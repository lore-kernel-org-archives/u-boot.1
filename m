Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13581CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 08:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE358313B;
	Wed, 15 Oct 2025 10:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56B28323A; Wed, 15 Oct 2025 10:39:31 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BF080107
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 10:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E9A5AB220372;
 Wed, 15 Oct 2025 10:39:27 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [RFC PATCH v1] tools: update-subtree.sh improve user experience
Date: Wed, 15 Oct 2025 01:38:34 -0700
Message-ID: <20251015083842.46057-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Makeover of the script:
- Usage now explains at each step what is expected from the user.
- Default branch name is no longer hard-coded and is queried when omitted.
- Additional operations 'update' and 'log' close the logic gap between
  expecting the user to provide a commit id and where from this commit id
  should be obtained.
- Use 'set -x' context to show git invocation where appropriate
- Sort options for usage output
- 'pick' operation detects merge commit id and displays suggested commits

Additionally the LwIP remote is now using the Savannah mirror system:

https://lists.gnu.org/archive/html/savannah-users/2025-05/msg00002.html

Signed-off-by: E Shattow <e@freeshell.de>
---

TODO v1:

- 'update dts <tag>' should attempt to substitute tag with the branch containing the suspected tag.  How to do this?

- 'log dts <tag>' should attempt to substitute tag with the branch containing the suspected tag.  How to do this?

- list branch names where branch name given is invalid or possibly as an info operation i.e. "see info operation for list of tags and/or/branches".  How to do this?

- 'pull dts invalid' takes awhile to fail, maybe pre-check if the tag exists before doing the pull action but only if that would be faster to fail. How to do this?

- behavior of operations when disconnected from network is not well-characterized, yet.

I think this script can add value by making it give helpful output and guide the user to a successful outcome. In most situations it should not be necessary to read documentation to use the script properly.

-E

---
 tools/update-subtree.sh | 187 +++++++++++++++++++++++++++++-----------
 1 file changed, 138 insertions(+), 49 deletions(-)

diff --git a/tools/update-subtree.sh b/tools/update-subtree.sh
index 536b3318573..e0c59330f16 100755
--- a/tools/update-subtree.sh
+++ b/tools/update-subtree.sh
@@ -1,42 +1,39 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (c) 2024 Linaro Limited
+# update-subtree.sh: Pull changes from subtree repo into U-Boot
 #
-# Usage: from the top level U-Boot source tree, run:
-# $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
-# Or:
-# $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
+# Copyright (c) 2024 Linaro Limited
 #
-# The script will pull changes from subtree repo into U-Boot.
-# It will automatically create a squash/merge commit listing the commits
-# imported.
-
-set -e
-
-print_usage() {
-    echo "usage: $0 <op> <subtree-name> <ref>"
-    echo "  <op>           pull or pick"
-    echo "  <subtree-name> mbedtls or dts or lwip"
-    echo "  <ref>          release tag [pull] or commit id [pick]"
-}
-
-if [ $# -ne 3 ]; then
-    print_usage
-    exit 1
-fi
 
 op=$1
 subtree_name=$2
 ref=$3
 
+print_usage() {
+    echo "usage: $0 <op> <subtree> [ref]"
+    echo "    op        update    fetch <subtree> for [ref] branch"
+    echo "                        add remote <subtree> as needed"
+    echo "                        query default branch from remote if omitted"
+    echo "              log       view log for <subtree>/[ref] branch"
+    echo "                        add remote <subtree> as needed"
+    echo "                        query default branch from remote if omitted"
+    echo "              pick      create cherry-pick commit into U-Boot with"
+    echo "                        <subtree> for <ref> commit-id"
+    echo "              pull      create squash/merge commit into U-Boot with"
+    echo "                        <subtree> for <ref> release-tag"
+    echo "                        add remote <subtree> as needed"
+    echo ""
+    echo "    subtree   dts       device tree definitions extracted from the"
+    echo "                        Linux kernel source tree"
+    echo "              lwip      A Lightweight TCPIP stack"
+    echo "              mbedtls   C library that implements cryptographic"
+    echo "                        primatives, X.509 certificate manipulation"
+    echo "                        and the SSL/TLS and DTLS protocols"
+}
+
 set_params() {
     case "$subtree_name" in
-        mbedtls)
-            path=lib/mbedtls/external/mbedtls
-            repo_url=https://github.com/Mbed-TLS/mbedtls.git
-            remote_name="mbedtls_upstream"
-            ;;
         dts)
             path=dts/upstream
             repo_url=https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
@@ -44,9 +41,14 @@ set_params() {
             ;;
         lwip)
             path=lib/lwip/lwip
-            repo_url=https://git.savannah.gnu.org/git/lwip.git
+            repo_url=https://https.git.savannah.gnu.org/git/lwip.git
             remote_name="lwip_upstream"
             ;;
+        mbedtls)
+            path=lib/mbedtls/external/mbedtls
+            repo_url=https://github.com/Mbed-TLS/mbedtls.git
+            remote_name="mbedtls_upstream"
+            ;;
         *)
             echo "Invalid subtree name: $subtree_name"
             print_usage
@@ -54,32 +56,119 @@ set_params() {
     esac
 }
 
-set_params
-
-merge_commit_msg=$(cat << EOF
-Subtree merge tag '$ref' of $subtree_name repo [1] into $path
+set_remote() {
+    if [ -z "$(git remote get-url $remote_name 2>/dev/null)" ]; then
+        (set -x
+            git remote add $remote_name $repo_url
+        )
+    fi
+}
 
-[1] $repo_url
-EOF
-)
+set_branch() {
+    if [ -z "$ref" ]; then
+        echo -n "Branch name omitted, query remote for default branch name... "
+        ref=$(git remote show $remote_name | grep -Po '(?<=HEAD branch:\s).*')
+        if [ $? -eq 0 ]; then
+            echo "$ref"
+        else
+            echo "Failed to query."
+            exit 1
+        fi
+    fi
+}
 
-remote_add_and_fetch() {
-    if [ -z "$(git remote get-url $remote_name 2>/dev/null)" ]; then
-        echo "Warning: Script automatically adds new git remote via:"
-        echo "    git remote add $remote_name \\"
-        echo "        $repo_url"
-        git remote add $remote_name $repo_url
+check_branch() {
+    (set -x
+        git show-ref --quiet "$remote_name"/"$ref"
+    )
+    if [ $? -ne 0 ] ; then
+        echo "TODO: lookup remote to determine if branch exists there"
+        echo "No such branch $remote_name/$ref"
+        echo "TODO: resolve if $ref is a tag and what branch it is from"
+        echo "Did you run \"$0 update $subtree_name $ref\" ?"
+        exit 1
     fi
-    git fetch $remote_name master
 }
 
-if [ "$op" = "pull" ]; then
-    remote_add_and_fetch
-    git subtree pull --prefix $path $remote_name "$ref" --squash -m "$merge_commit_msg"
-elif [ "$op" = "pick" ]; then
-    remote_add_and_fetch
-    git cherry-pick -x --strategy=subtree -Xsubtree=$path/ "$ref"
-else
+if [ $# -lt 1 ]; then
     print_usage
     exit 1
 fi
+
+case "$op" in
+    update)
+        if [ $# -lt 2 ]; then
+            print_usage
+            exit 1
+        fi
+        set_params
+        set_remote
+        set_branch
+        (set -x
+            git fetch $remote_name $ref
+        )
+        ;;
+    log)
+        if [ $# -lt 2 ]; then
+            print_usage
+            exit 1
+        fi
+        set_params
+        set_remote
+        set_branch
+        check_branch
+        (set -x
+            git log $remote_name/$ref
+        )
+        ;;
+    pick)
+        if [ $# -lt 3 ]; then
+            print_usage
+            exit 1
+        fi
+        set_params
+        is_merge=$(set -x
+            git rev-list --no-walk --count --merges "$ref" 2>/dev/null
+        )
+        if [ $? -ne 0 ]; then
+            echo "Merge commit detection in pick failed for $ref."
+            echo "TODO: resolve if $ref exists in remote to guide suggestion."
+            echo "Did you run \"$0 update $subtree_name\" ?"
+            exit 1
+        fi
+        if [ $(($is_merge)) -gt 0 ]; then
+            echo "Merge commits are not allowed for pick operation."
+            echo "Did you want to pick one of the following commit-id instead?"
+            (set -x
+                git log --oneline "$ref"^1.."$ref"^2
+            )
+            exit 1
+        fi
+        (set -x
+            git cherry-pick -x --strategy=subtree -Xsubtree=$path/ "$ref"
+        )
+        ;;
+    pull)
+        if [ $# -lt 3 ]; then
+            print_usage
+            exit 1
+        fi
+        set_params
+        set_remote
+        # HEREDOC with tabs indent and syntax to ignore tabs:
+        merge_msg=$(cat <<-EOF
+		Subtree merge tag '$ref' of $subtree_name repo [1] into $path
+		
+		[1] $repo_url
+		EOF
+        )
+        (set -x
+            git subtree pull --prefix $path $remote_name "$ref" --squash -m "$merge_msg"
+        )
+        ;;
+    *)
+        echo "Invalid op: $op"
+        print_usage
+        exit 1
+        ;;
+esac

base-commit: b1cc9a53d7ba8b85e77980417242420889273e86
-- 
2.50.0

