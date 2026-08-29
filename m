Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BDAC61DD3
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 01:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A9D380F55;
	Sat, 29 Aug 2026 01:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZymgW6csigR4; Sat, 29 Aug 2026 01:50:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787968233;
	bh=FfgsVZbw2SI/TOE9AITxaHP5M9L9HjEku2oT8peWZnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1E5Tf1YcT0JKL3tYBUsIbp7qoRPwm59a9mWoStL0Huu5zbsYM0G5sN4mXVVKcpHpA
	 bdknbQLIgaTIl/BHzr5f0mH6z1ATttWHv7029NvviCiMABFXpaVLCsfhRgQzSXZbCV
	 8ynhgeEdCBJspX99YND+M6wkIOBd1kK5zVHNbGXElLv8KE5VdSxFA00m+DtJbk8Wep
	 BAqrWVvL+NrlN2IBn2PQY8vJYpirtl7bjqERKPXgHBcQF7n4zRWDu5Qk9yoAUeFAjE
	 RetGkuf2ilwGkwMkc9ujlUtKjFmVOxyxj3MnztsS4G3KyPDdD0DpiUeoKOROxb0bia
	 Lalrq6iJumPcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 720F480F56;
	Sat, 29 Aug 2026 01:50:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 963631DE
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C67140841
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GImeLgweCXIm for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 01:50:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lLuy3Ptm
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BB6040830
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:30 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6b12942ed04so34472eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787968229; x=1788573029;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FfgsVZbw2SI/TOE9AITxaHP5M9L9HjEku2oT8peWZnw=;
 b=lLuy3PtmlQsYOyYtptA7HQbVxI5IRE3Sq4G0SD0SSex75PF93dxbsTFUM4Q3y5xA7G
 C+aXh62EPqDorZs9j6Z2oaV6GHv1PvJB2J5Arj+dVsM8v6g6LwP68iqIkgU/DKTOA3zU
 cEEX9jau72S1z6metbCIzpkKR45ckDVUJH7DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787968229; x=1788573029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FfgsVZbw2SI/TOE9AITxaHP5M9L9HjEku2oT8peWZnw=;
 b=Ac54P7DpZAvyIbJxIKf15KS63KSMOPd8isWVJ0qQJqiIpr5D9Dgp5NgqCZ2Xviviur
 IdtVGhcoyGXpS80O2xeaWzDjEGPT6o6e9jytGuloA5hNZu2k/ihp6Bh0gSH57ZCL3T4M
 FEk3ZqMTga4iKbHNg9skurx7ds0349dZEJaoJ4TbuZ03MLG7q1w34/8MfnLbfkz8Z0Ly
 a3XE+oHtjfQfSnBmEOjoX0HucmCP64nwbym0DRs40CXk49mEK7j1Ya8i6e9or4u7Bsjr
 V/tpYOLfdAX0L4M97u0mQoEXRbBkVJWR2BRWKZwFu57FMpfxOCU/JwBpUIy+gQUu9pJh
 gKVQ==
X-Gm-Message-State: AFuF++kb4iRoNhhJSdzp5GCqHD3E1k596ZvN7DWLgZjj3idgmzLooaie
 7zXAKjjlblvTZmtl15EtooPDqY7GUNJ+DWcBXMdbraJtQtgZHhSdOa0yMuKOfiLYq7LCPEC5wu8
 qKOhDUhPx/bwF
X-Gm-Gg: AR+sD12i9zPE8nsIgPWWkMdJWKG7m1o9DPF4wQ2zE4YvgJCpsBzHOlg8jRut4T/FHS6
 6+R3hJKVHijQcUJ+z53lPGfSP6wk7KE9WUVxvp5cuOaRM/7RKe8WeSluJmigazU/4wnP1dJ/7pE
 o0aLLY5wDZlk501teQu07x5q4rYE/PCPex12y7N4lwIFiC2hfgFa4MRgJ4BmbH3jp9qzDEyxxz3
 72xF/MtHHAUdgcXsfXKSX54ctocs2VNQggLG5EI+Sd0HtAXl3VyD2lNQvgeHfjIrVIfo+W7pMCw
 YCwlGI0o7kR7t/HYFGxaxsOVbPrzGrFvm9JhMdfVJwz6aPBcy1e6OVZTcOpiZhaaeEXWD0xkAy6
 ZA5+5+3LMNe/S7w8C0+tVMaPuNyrTBTWKVRrSNwxDMy7WDBsgvGaiw57XXZ5TUK8XmV7Y/HKXWL
 /ujsEQeGzmFyNTKyGFhCzvxkLBl+7ausU1fto01LTWy9Hqneo2aIbEeXF/CEgkaLDSj9Gc+EMDR
 ZPwJpXS/q6QGRujlSlmWjed2oos+8ngYAA0+P1HkyKpwRXfBscPYYj7NaDKWcnp1pB8RfaAVATD
 NS6NbQGrbqmXXwkdfA26atYXeht7wj/+Aw8=
X-Received: by 2002:a05:6820:258e:b0:6b1:9f9d:7a04 with SMTP id
 006d021491bc7-6b1c6464f27mr10424014eaf.7.1787968229285; 
 Fri, 28 Aug 2026 18:50:29 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a353d45asm3070190fac.7.2026.08.28.18.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 18:50:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 1/7] scripts: Check F: entries in all MAINTAINERS files
Date: Fri, 28 Aug 2026 19:50:19 -0600
Message-ID: <20260829015026.473134-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829015026.473134-1-trini@konsulko.com>
References: <20260829015026.473134-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Michal Simek <michal.simek@amd.com>

Extend the checker to walk every MAINTAINERS file in the tree instead of
only the top-level one, so stale F: references in the per-board and
per-driver MAINTAINERS files are caught too.

Use git ls-files to enumerate the MAINTAINERS files so that only tracked
files are checked, ignored build artifacts are skipped and paths are
reported relative to the repository root. Fall back to find when running
outside a git checkout.

MAINTAINERS files under tools/buildman/ are skipped as they are test
fixtures whose F: paths are relative to the test setup rather than the
repository root.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---
 scripts/check_maintainers_files.sh | 80 ++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/scripts/check_maintainers_files.sh b/scripts/check_maintainers_files.sh
index 4c1279958e98..ccac97a2d93e 100755
--- a/scripts/check_maintainers_files.sh
+++ b/scripts/check_maintainers_files.sh
@@ -1,44 +1,70 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 #
-# Check that every "F:" file reference in MAINTAINERS exists.
+# Check that every "F:" file reference in the MAINTAINERS files exists.
 #
-# Each F: entry is treated as a shell glob (relative to the repo root),
-# matching the way MAINTAINERS wildcards work. If a pattern matches no
-# existing file or directory, it is reported and the script exits non-zero.
+# Every MAINTAINERS file in the tree is checked (the top-level one plus the
+# per-board/per-driver MAINTAINERS files). All F: paths are interpreted
+# relative to the repository root and are treated as shell globs, matching the
+# way MAINTAINERS wildcards work. If a pattern matches no existing file or
+# directory it is reported and the script exits non-zero.
 
 set -u
 
-MAINTAINERS="${1:-MAINTAINERS}"
+# Move to the repository root so that F: globs (which are root relative)
+# resolve correctly regardless of where the script is invoked from.
+if root=$(git rev-parse --show-toplevel 2>/dev/null); then
+	cd "$root" || exit 2
+fi
 
-if [ ! -f "$MAINTAINERS" ]; then
-	echo "error: cannot find $MAINTAINERS" >&2
-	exit 2
+# Collect the list of MAINTAINERS files to check. Newlines separate entries;
+# MAINTAINERS paths never contain spaces.
+set -f
+IFS='
+'
+if list=$(git ls-files '*MAINTAINERS' 'MAINTAINERS' 2>/dev/null) && [ -n "$list" ]; then
+	set -- $list
+else
+	# Fall back to a filesystem search if git is unavailable.
+	set -- $(find . -name MAINTAINERS -type f | sed 's,^\./,,')
 fi
+unset IFS
+set +f
 
 rc=0
 
-while IFS= read -r pattern; do
-	# Strip the "F:" prefix and surrounding whitespace.
-	pattern=$(printf '%s\n' "$pattern" | sed -e 's/^F:[[:space:]]*//' -e 's/[[:space:]]*$//')
-	[ -n "$pattern" ] || continue
-
-	# Expand the pattern as a glob; if nothing matches the glob stays literal.
-	matched=0
-	for path in $pattern; do
-		if [ -e "$path" ]; then
-			matched=1
-			break
+for maint in "$@"; do
+	[ -f "$maint" ] || continue
+
+	# Skip Buildman's test fixtures, whose F: paths are relative to the
+	# test setup rather than the repository root.
+	case "$maint" in
+	tools/buildman/*) continue ;;
+	esac
+
+	while IFS= read -r pattern; do
+		# Strip the "F:" prefix and surrounding whitespace, then drop the
+		# backslashes MAINTAINERS uses to escape regex-special characters
+		# (e.g. "board/k\+p/") so the pattern can be used as a plain glob.
+		pattern=$(printf '%s\n' "$pattern" | sed -e 's/^F:[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/\\\(.\)/\1/g')
+		[ -n "$pattern" ] || continue
+
+		matched=0
+		for path in $pattern; do
+			if [ -e "$path" ]; then
+				matched=1
+				break
+			fi
+		done
+
+		if [ "$matched" -eq 0 ]; then
+			echo "error: $maint references non-existing file: $pattern" >&2
+			rc=1
 		fi
-	done
-
-	if [ "$matched" -eq 0 ]; then
-		echo "error: MAINTAINERS references non-existing file: $pattern" >&2
-		rc=1
-	fi
-done <<EOF
-$(grep '^F:' "$MAINTAINERS")
+	done <<EOF
+$(grep '^F:' "$maint")
 EOF
+done
 
 if [ "$rc" -eq 0 ]; then
 	echo "All MAINTAINERS F: entries exist."
-- 
2.43.0

