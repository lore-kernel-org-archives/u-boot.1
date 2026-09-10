Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D6DC79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF41D40B54;
	Thu, 10 Sep 2026 20:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A4Kc-19nLKi5; Thu, 10 Sep 2026 20:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1951040B10
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789070598;
	b=Yyq9xt+aUvVV2u8QHgA7bbqcpAdW2CNhU5Gua4tK0lqGhQ6sJs9/5ZqhgzmpUGUlA2Bn
	 MuJUofLulZpizZBkkYjeYYBJQBc6d/CiBM05Q825+gwxNHleYIVD7pUvYevhjsgCKMN3K
	 iyQ85kUHDtSgXsiXbZpA4gXeP8HVTOxAXO3fJRq7PuUpG5BHI5SJQtkuGZbUmMHiVIBlA
	 vy/4lBPLHupe5jy2lFHrS40Hdm5fH5MGi/zSbFqjJsBi0E9hGPHHrz7kCQJt7erd1dRMu
	 VcJdWdDdnf9HqQ5McKPfE2KXn4eyiwRf/f4OAySXbN0AG+PlIG2hex3giFJqjnTCw6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789070598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FfgsVZbw2SI/TOE9AITxaHP5M9L9HjEku2oT8peWZnw=;
	b=A48zpvsZrLCbQRzk4iKSozyJp2ZIKy8TsZ9YiMxVHvnmexV+bPp9D2EVtKU+DIPD7dD7
	 qPsiWjpcgQARwHOSPn0SPbOsSCsGyw1Fdb5XY8YPi2iEvkoHyt5SrdI+LgkbeECZg68qA
	 e/myUzS8ILkYKFg5VQM3pmhE07wlx/DRQFgpf9fdHcV0b5W1WaWVqReonLK53VIPeub8U
	 P10k6FwMm0hiUayk5srHzLLkHdI+y25NkdlNnLqg7ytQaTGkKBd3hQF49CYYycl4dIKAz
	 kpkmMnPsRcuDkVlGk9z2FEFVL3iJ3+ce2kygEWD0hybSv9rEc5gWEpiqhKBY2eR2Svg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WLE3OHV3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789070598;
	bh=FfgsVZbw2SI/TOE9AITxaHP5M9L9HjEku2oT8peWZnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MfP56tF90ZzsGyC40amdmNqgA0Irj7HQPW+RiAfbKTsqVqTou9bJaJ0nKpR4qYwqn
	 tG+yVO46x6+zXyWq2Xx3PU8xlRTIWgD7bjZx7gNjl3OQK1mnYx4djYzvF2Y25RRqZD
	 awB3ZZFDL+x6bxnNUp6m3AeWl+7aL1GH/gxvFfihcW4ENBCW8nAeoH/lHhZraHNtwF
	 kCdmKeTsY2ZQ3QD3PwfztABjmlua7tBEHyijVgAJXhmNBCQ3Xx46XnOdP78Y8ONZuK
	 MlAnzR2Pp4U6fqThjcazd9SfYmfMJkpo45io4InMym9OeD7WD7ptDTKPxaa/N1fUo+
	 zrj7sMd/11k8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1951040B10;
	Thu, 10 Sep 2026 20:03:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E79C1786
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5B1840B10
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KdmYQCN-S9hK for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 20:03:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2B24840AEE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789070595;
 b=mj8eufQDNqiG/TnHQcHgUXbek1oUJerysU59DJm94CIfF+Gp9eNE3YDNdGa9NO+tXWDI
 YxRFGWAY9znLlEI78C2nVDheanK2P1ruJqNrDIR4K9HGExVq3Qv4SirPTqqp1xiha1oRH
 0Dd55cUdmlyxVJoZ4pFxH7NuDSG8DYW0SPVhVBa4heTXtmaGTePpUhvnKlwMK7jPOQX4I
 dOCIVEIX5fZXi9tKdCOpwRZXsgqrsBMM4Crx2NYe/Og0j/w9FSixSEVhSyj4rZ6+Dpo/O
 3JwqNU2NecX+TCWH+1F3igFQyWP6MWI9CL1v67KJs9VwwuDirS4R6nONgxt87oOBi/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789070595;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=FfgsVZbw2SI/TOE9AITxaHP5M9L9HjEku2oT8peWZnw=;
 b=ibhZgnzoR+h09Quqv1RvfO82zerQ2fL3pjdQa9gAU1NmAiBdJ5vhWzVld+bmaVTm3SIk
 tXEJS2QmVbAuB0+I0O3Q60ODurt61XQSz1kijIk8dJnJuyC+plWbng0uvbPU7mj0Y9qHn
 Y1N/97CJQtPHfW6lbSyDDkQIBgFLx4ay5h+snLTZtPGfqTuR0kUMa/gObEKl1eqLSWFJ7
 FpA9pWfI/T+TPQysBic3slyJW2s5rWXLACj7kgUDYXREJ4QNGSP4xR6Rv9xhVm0Y7Ga+j
 GXvvR96RXMWD/+1R8DhjvvIAb10v3daw1sCuXqOwMTpMW0IcOh7hikp+jOA1Ao+JDtQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WLE3OHV3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=WLE3OHV3
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B24840AEE
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:14 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a39a42dso102214b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789070594; x=1789675394;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FfgsVZbw2SI/TOE9AITxaHP5M9L9HjEku2oT8peWZnw=;
 b=WLE3OHV3zrHi0W8NgOlipffUWioDgdMWn58U3s33j4ZSmmCEvYCJNVkD5l321vE+0B
 WCEDZiXjTbQl2GyhanKrAfSKN4oqGGoyja04GWqXRFzjQC25I+CcxTwppxaDMvMzJx0U
 01vY46mb5Ylew5b3q2DAi6mhGQtxVj+76xHAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070594; x=1789675394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FfgsVZbw2SI/TOE9AITxaHP5M9L9HjEku2oT8peWZnw=;
 b=rJUnNdGgD1AHbL4Q5zQta55bkF3XRTpFUEcJjKZtIIXzoTYjEGTXpaKGCpNexfGGzl
 yoXiNxmDPthYfgbMOTDNWeAAK74wlPGazkbXZJz4Igz7r6K+G3fFdaGHLp4IVpNSdo9U
 6hTqL2DUk5e9hLp3yvSzCsnQcc5CmXxkcRLEFjUdDVQ77g3letG1R7vmnK7iJ1XP05V6
 oLbK6/Y75kCOw6qnAIxH3/pM8UuDsgVpLfq513ohaBVPGIrtntzBbs7txsi8lj+TirIg
 1dgXRtmI+BDEU0eF167vHAEwI2zlQymsixL8JFbjs0GQSS1VJdo53/O0WVV1jeAXWYx+
 PMrw==
X-Gm-Message-State: AFuF++lYCBkY3Rrl+ErQTOUxRtaQqHblVIUVKoAvoTS052mwXrq2oOpx
 41zEoBgmwdlGwroCdQQDtfYGQkPpMRr4vxK1RYp+HnUgc+E/TY6WelqmpPcDkSx3Me37EhnGRkB
 ZHmbW3Hm3QqoK
X-Gm-Gg: AYBFou3Qf3WS3XKjLXkU56V+l+ZHwQh5lse3aAuEZXk/e+cterQcg+Co/oboDdcT3HJ
 JnpypbSnqLons1L1q4emn+0in9JhTwfhveDVo/m8/qUAzWqKn61W4UA44EBqHZX3uFUudrinW1Q
 NNnseMYP5gFp0KZK4yzoJw/mXzidDzkg8ZSZ0vtKFgaTP12fB9+NskOjGPDuTTaifFLarxPo9IJ
 1D8B3Tq2OX4sdtjo0vvEbzZFM/eXna5bk4rOjnoJoS5CZV3jSHCt3MBxmWp7wpwOMK19E/Cwv/v
 AfoVNVvNwRGWDv5oA4cL1JqABOqQlrc5LKSfnqfq8bSSLMQpLZ4EaQ0RfoUe+Acu1wLuTS7BIi3
 F8KXRR4VTToK5zJAuAGDq+24kpMulk3AnbxLDS/EHhgR7n3yBreIS5d9mU2pR4aKEYenXHK7y6d
 Ew8OjM8lR8zs6bWcC88BA+Fizw0suBMP369GWCi7KhpsV3Sy/UdYhgTbzceCjrxoff6/PLvJmdO
 +ey7sODTPKlRKdSC6hOl0CONsI0rWvNkwMnd14wLLkg3XEpJbT1EUIfAVSTGOqbSIfhV+LTPvSF
 94SeYKu3+HFD/296B73YMwhdz8mQOqJ13G2BD8rBX5dm
X-Received: by 2002:a05:6808:e82:b0:4b8:46e3:e222 with SMTP id
 5614622812f47-4c308598b1fmr563819b6e.14.1789070593891; 
 Thu, 10 Sep 2026 13:03:13 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc937bsm208357b6e.11.2026.09.10.13.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 1/7] scripts: Check F: entries in all MAINTAINERS files
Date: Thu, 10 Sep 2026 14:03:03 -0600
Message-ID: <20260910200310.3503830-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910200310.3503830-1-trini@konsulko.com>
References: <20260910200310.3503830-1-trini@konsulko.com>
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

