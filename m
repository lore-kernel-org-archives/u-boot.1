Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3618C5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3EAE40693;
	Mon, 24 Aug 2026 07:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IIghX1e5vJbj; Mon, 24 Aug 2026 07:19:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787555968;
	bh=kw/yXuZs8WEtRTJvl/+9UVV6M2LZN0BhZVm/fnz6gOg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8wTasDOzXqf8sA/haXhYobXcnzYMIM29Le6xyiza1+VGikfcbG2KifnAbrYeQOYf
	 nnPubvGe78xZDndLgr9QJprKpkG9LLnB1ldgTLe8cWbob7A6dgWrKKbghd3pKJvkW0
	 lly72ujNGwZWr07LdWZWWjYTpSFT4p4tbmCT1w0aP7+LlKlkXyMVHitLv0lx+SjcQ8
	 VdTpNfxBxTvGE9ts9fPUaBXvjpaa4ANc4tTgX6yw6D/sIVPNlqaOrW7TqlwKcy3xlz
	 MLybvJL/VeHhcYsh/liwGye1//+VRFexZWj8i4tbk3edkEVcB5hMmRkdR/ihOmsPXV
	 daUWSUKue32fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04FA9403EE;
	Mon, 24 Aug 2026 07:19:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D60733DA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC32480CB9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ul8YKjhobEt for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:19:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=XLNf/9M/
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04C8580BB5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzc/C9BobzYNOTc3gdPxzLzpxoVy287VgNlutg4LiA9dQ1TEG/X+tKrFrPyXFoo47e8pc2oQKr4ssjxKlHMafuaC/l4oYH+HAzG9sqp9i2Ip9nMHTMOnNW5fj00iB2QuE24O+vrOuBMMrYMJKz9HLg9mHaU3Le4DAeoeKClf8jEuJSqCxL/UlDGcJY/ngEPdASmx3PPgOsEMzwpHryi4AS15BI84Rqt/sd77DUbtYaVAnC688i/35nUNNWtVggnNTuBMBAbEjL8WkM7fAWC4HrLCueOFu7aX9DSGiIU3fVzO49SlVdI+fb49TseXq5xfOypTM4uFx1DIi0tcmy4isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw/yXuZs8WEtRTJvl/+9UVV6M2LZN0BhZVm/fnz6gOg=;
 b=s9Yiciezir3ZFvX5lTPrwxwR5toMQhsPePOyT6hBXbmMyITpZqZdS7oym8iGi+4XVn6Bv3fChFb/CosPLO5vGVKsL5d8nLZFcbcPmRc0VmCPpbE+lPD/+plHVgysIYskfa3nW/uPqUEEG/xOq0ONjvoXvE4V0k5JnP1RB4UI5EICThroAy/sLqEkfUJLHQK5j0Xu6HSIjgXsRcSB5o6n4y9dLty2/wCFpBhatV0+vhJ0HZV5tFg7hJXio5lQERMiVW3AEk9hDvDbWfmdEvBeZrchTazsY21jQMbSITt0xUtZq78TcK0Vz3jeZpiD6E260be11tezvcRrsUxQ36pjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw/yXuZs8WEtRTJvl/+9UVV6M2LZN0BhZVm/fnz6gOg=;
 b=XLNf/9M/ojUZXV8Z/dKS+rMXGd9jXWC2ySXPUOM1ccpMJKgmY1maHMVvOBpYO3GtCNbdN7JOfSqYNHIJZdzbmJYi0N6Ctj3Izjqof/QhWz626L8oL3OyaVqDaCFf3UKEWrXvsH4bYpf2uZ+csxJI1rvRzrI1X56efEHfw++M8+A=
Received: from SJ0PR03CA0121.namprd03.prod.outlook.com (2603:10b6:a03:33c::6)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 24 Aug
 2026 07:19:22 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::98) by SJ0PR03CA0121.outlook.office365.com
 (2603:10b6:a03:33c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:19:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:19:16 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:19:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/3] scripts: Check F: entries in all MAINTAINERS files
Date: Mon, 24 Aug 2026 09:18:47 +0200
Message-ID: <6a07d4bb5c0da18c885a05b24f29d2df69489853.1787555916.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787555916.git.michal.simek@amd.com>
References: <cover.1787555916.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4186; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dwJnJaPV2ClbFZ3HtSrWzq0tCRM2JzJsSM8ztTeDfGk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR1f0jVfq6bZ/2oUFdj9ypH/STrFV1HhYMfS0yaUcTad
 eav7/u7HaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRtZcYGWYkXbns5jVl61Rh
 DUfriGgJ5Z0+C5Y3PXzFklgU+eKCxRNGhhtmtRsZ7Ru++W7cZqJ236Clgqv/x1HlGY21y+9/Kb1
 2lAsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0883ca-2dcd-4be6-d55e-08df01b004d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: KZ+ohldgvfMW5x9CCejAAN/bvRstzJm5iMFg7nCrYiAage4e4OZ/ESrPbnA3gpE96wPsZIb+zTdbFZeFa/3RDOk0SDed54gFLatjqt7QzWgdHdRPCpttUWCCuZIbcmu7eyGg0lLV+NYRPemJNDJFUjS26dfba881oMRRECsnUC/l/2ySdiFQDs3s/2RHrhpxHqysbA7ML3rI8eVSP016DXPxHx60otGNjocjtMvRKHfHT7ugMZngwWb61fteTuDtKa/fVX3rk4zGDC0nFHIj1KEj1d3/nij9zFWoZntR8iegA7Eqi6E54VPR9uHaYolJcOc3WOCeD+A9B4L2s4pPGLXNRuiMvUfZYfkSuMin26IzjcPSBsNXiDpchWk24a+nRHMx2381cwLOkaGO8GZBclHBlyCaLF3V4EgNeFsaeTeBYArGb/e1ZR6Iif6gEIUcpQ+2JTZkJU7vNnWRq6tA12dbEaW3KmD5H6RjmEL8satfWb4gpHMqRSuNn/NiLBThdpCSdkJZa5NSOmRKJ7V6S6j5CGuY5w1IISBPseYFUB/uKQgNOoD6uP5o+p9BC+wflxzHkNm5vNVfT1uBg2YKy4b13w7zlDsZXmU5OS22HY/gBx8VneYZfQc0vrK/yeYubdMiCKduvfuCVWmFy0fEGO2s2gQ9oXnq2sY1MF5GDtSG+DvH5iUTZ+G5bfeXcVGClQIkDdTF+jvK2Fw5y9zo7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O8B8LfQQgpEvkkySl2Ugdl+rUYP4oczPVeAxX+L0XJGeHwhEatrLQoQ8hYOJCa9CxgrfxS40r7rLw1PtFCW3t+naAChYLwrdaEggWB2oAc8BLgzQhxWdiPA9p8oW/YzY3iL6U1obXLoEQSoIhMf67FyVRBCfsp7TqgKYr+U4pMt7zFnr1gU5rCWwxL+yeWQAOxwiNCFObeBtUWniUbulGW4S/Q1GjXrExPvtvXHLGYfft6hai2UqPLQ94V5R3H86aIINaGKJWYnQeSn1VLvi6RgsIW3aK3Axmt5XwLgiz+0JUpLIhNv0DxDKhkDgzIZ250YvgyGO6mb61dSyRcm4ecvHwqbY8ciWsGdmZ4JS+pYk5tHVeM2fzyNhOC1Wv4nn/wM9phNRdcarVZxqF/feHwdFua3YKAxdjOy+PEmsGkg+Ignutcw8YS/mqfUGz6Xg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:19:21.5490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0883ca-2dcd-4be6-d55e-08df01b004d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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

