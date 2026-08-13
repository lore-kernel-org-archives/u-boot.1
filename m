Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5A4C5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 07:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3CC340939;
	Thu, 13 Aug 2026 07:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GMz2F_Nk7XqB; Thu, 13 Aug 2026 07:11:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98F3B40778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786605114;
	bh=NWlP11DtsQjuO529ZYEBZKndxoD9gVM78YN3FGOqMl8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eB8n7UxZWS5ch5faTVC5qrG0Tc6gpWMAiqmcKmZJ0CdFSDayz0yB+t/XrqsGYz5V0
	 De+dXsD2Kjx5GL/aomAgoqhei0INrdT7DfS37C7KcQ7JQhEdcaV76kphvbfl377OgP
	 gnTRE8ZpViRGARafhXT4XBlL05VKSbhnQsSWvJc7ZjZ8i/rYTzRX6uO1WGetXhodT+
	 TSh+5EdLHFk61knthLpC9vYIqgkuaiUIV0SfDZ4arVNZj/XE565DAMeTQH0V/3GX8w
	 AKXovvjI18x9gSStJ9Mn8zumQzE7IZaanhqe/9UgpbT3d5zNnDR/jX5Ydoj0ckEpj0
	 9v/chkDh4gQOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98F3B40778;
	Thu, 13 Aug 2026 07:11:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 11282109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBCF880F22
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:11:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGSxCKK2Hiwn for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 07:11:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4756780F3E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4756780F3E
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4756780F3E
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUd7rxm0wDhxHIFM+1IKVHTPryEAxo423LEL3WbjOdFHHqy2c1nmNFDKSr99MYxqY9fSVpT+aDleJQ9a1HEOy8mFV8re8+msZZD0ERiweVlhGzxhUoQmeeWkT+XUCbCL9BrhUfd3BJk4VXfnJxEWqSdhDZHiIz791R99S9bGMgWhpnEMOVE7XPqLPPzld5ER+2YSsgDt9lpopk/2cqC9Pu8hIpiKIBtMG+gKhJVWGQRAY12Be5LFzl0DLQHO8wQxbMA0JcUeoNx1RNZO8Z+AaqZcAasFILTGk53QXwWcETBaIqGrdtkg+3BC3fh9vtwG/jISDZbDxWp2IQxflhjRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWlP11DtsQjuO529ZYEBZKndxoD9gVM78YN3FGOqMl8=;
 b=NH1pcl8dXKHPfhc6Vz1VcS/BwYuKQabkoNCRQ3MxPNC4NpBrB3bd5KAcdRWubA57tzNyfQrcxzSQCJsAdsQ3lrIqDl5jkYigwujTelcmpLIHYZr6LkAcQ5aNhF5hLv7SYIcTN5Taom/HSVUiTK9lM5wBCHa6EfpgTWZHREcvGlJjrrzNQh5lIHabuTXRHTyqzUtoD/A06oGFjOMC92SQJn4Al3IdfYSE3P3Utp0D6LxOUGqlxgtI1uOypEfamPd/lY9ImBbQ7cjbd4fMdKFlS7SbAvbtq/CnstubMS3Wd/f9ogVTIPm0tFOmtjd+iWr77ioRXaR8/ZR/LUiaiiPKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 CH1PPFE5ACC0FD2.namprd12.prod.outlook.com (2603:10b6:61f:fc00::629)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 07:11:47 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::1b) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 07:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 07:11:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 02:11:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 02:11:45 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 02:11:44 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] scripts: Add MAINTAINERS F: file existence checker
Date: Thu, 13 Aug 2026 09:11:16 +0200
Message-ID: <36b0cd5101d70d61a655c7c16825b9bfd7a9f73d.1786605072.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786605072.git.michal.simek@amd.com>
References: <cover.1786605072.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Qo3N2CKymKRZWuaIq9HuJjlZSHTJfNfhtU9f0qCys2w=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTV5mmtKnt97v1ca0cHL9NLLr7h9ekr12+rPqS8+nZBF
 ft13uPVHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCR/66MDBM4/xou6VjZ23lx
 /55rVx3O55tWXWvzD2l3/XxVaEv4yi0M/zRPzjQqXdVkt/z1TPejXWb+MnecF5kuSGfbJJl9clP
 aQm4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 444db1a1-e581-4cbe-d175-08def90a2323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lQctesWDqz/r7KT95UT4iMdOwvXdGrXKaw/JpjiQzsdDEgiQdkDD2wpJHdrNgHE/LHKLeSrg841x5eDZKxlq04Sx7eM2buGcKAcy/3R2wioKd76Hz4gw8+y65dn9RkUnIVRbGwulX0nF62UclwAHFodSHNMLAjX77Wm3d/u6TJdGGNOXPgh4Byed7hb9HcHarOr4Boh2i2tPCrDgqoty6mkf2kzX5wQoviEMRb7/KEjIqIXr0gnxrQBvnzml2XpOsBvn+mz4XldvUvCV5xKYq8gcNmTqWEYApU0BFUyFut1KlMR7o3uqwpLZju7nS31fgkw/pvU3S3C1mPpT1MraI9ypzinnk5set1QH5lltiu+5ng+bC9R1xs9cmvC+9bgSlZ2M71RomoZmMTxODqAYK/0wkW6yHjNGaSOwzs0Os8lze1wuYknkD8X16iRS4gdPyjC+/nn8oyatCj5HZkKzcAK5sipMljOK72pBlT6rCNcp4vBjIpnVASAwpsPY80tKQQ9dr9AOg+ATPmZ0CtRpi0VmO8rUnnJPw2L/u+URFCgSwexaxR2FuzVbuZz7uGJ0MP3WxnIl8qAgWQPLQZJ4eRhfutYqCSflBOdUER5PxhQyta8Qocdy9y0owEn/VOnXa5rYb4iHW1dKG/OOjehX00EhQPnXo18v1pi7Mtxb3Yj2i0gufMjzE3KtPTKQhf0K9GGno1liHPixt68q2qt42g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +5wl6Mw5dGOO+s7bRk3phkZZ0n4kSJO3WqIQaXwz8Na71PB9uKJWbc23V0i6nIBbwHGEmbcmPCkVm0QDDocRxynQHkb9Ka7mcFHpc3Zh/PfIpFhSMxbNZKCTXBRzSm/iYhQdptAtEhgK6xsORjpO7JOunrY6zdp42elvfbwdp48Zt8mN6z5tK0fRAeDIEPjbCwPd7wj097DRDhgZpzjhr4U40hLldcQzASc7I3467pe0MtopLENDXb4kScCMV70X12guO811lei+ATDJAldcnpowWQKIGsOqja2a0+0OGLKq9+GWtzKf4PaU5JMr1Z/nR3bc1f6Kl+6ucv9EAGx6fv213RdONwOMFdE0DJtqD82IMR7SyJN6sFGATVtroNK/wt6HIHhU8o9whmdNxnsuRJcU3+FIACJJKITj3Qk4el/SHUpHKhCP0bI+v12LLDX9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:11:46.7011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 444db1a1-e581-4cbe-d175-08def90a2323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWlP11DtsQjuO529ZYEBZKndxoD9gVM78YN3FGOqMl8=;
 b=jQaRvuh3fRuEcw+/dKPt/n9uJfHLX+1ckCv6ZiAl83V0tIBOQEN6NzMRY1IrDr4TR2B7FsH6yWW4X3mLdkhlLfIdsgFitZ6z/rg2UHoILrICDI75gRxuAWpouK2uFFLolYM9c/RHl0kr5hQBuQhEePrn3KeXpIy32oOCEVqmF2w=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jQaRvuh3
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a small script that extracts all F: entries from the MAINTAINERS file
and verifies that each one matches an existing file or directory. Entries
are expanded as globs to match MAINTAINERS wildcard usage. The script
errors out and exits non-zero when a reference points to a non-existing
path, making it easy to catch stale entries.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 scripts/check_maintainers_files.sh | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 scripts/check_maintainers_files.sh

diff --git a/scripts/check_maintainers_files.sh b/scripts/check_maintainers_files.sh
new file mode 100755
index 000000000000..4c1279958e98
--- /dev/null
+++ b/scripts/check_maintainers_files.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check that every "F:" file reference in MAINTAINERS exists.
+#
+# Each F: entry is treated as a shell glob (relative to the repo root),
+# matching the way MAINTAINERS wildcards work. If a pattern matches no
+# existing file or directory, it is reported and the script exits non-zero.
+
+set -u
+
+MAINTAINERS="${1:-MAINTAINERS}"
+
+if [ ! -f "$MAINTAINERS" ]; then
+	echo "error: cannot find $MAINTAINERS" >&2
+	exit 2
+fi
+
+rc=0
+
+while IFS= read -r pattern; do
+	# Strip the "F:" prefix and surrounding whitespace.
+	pattern=$(printf '%s\n' "$pattern" | sed -e 's/^F:[[:space:]]*//' -e 's/[[:space:]]*$//')
+	[ -n "$pattern" ] || continue
+
+	# Expand the pattern as a glob; if nothing matches the glob stays literal.
+	matched=0
+	for path in $pattern; do
+		if [ -e "$path" ]; then
+			matched=1
+			break
+		fi
+	done
+
+	if [ "$matched" -eq 0 ]; then
+		echo "error: MAINTAINERS references non-existing file: $pattern" >&2
+		rc=1
+	fi
+done <<EOF
+$(grep '^F:' "$MAINTAINERS")
+EOF
+
+if [ "$rc" -eq 0 ]; then
+	echo "All MAINTAINERS F: entries exist."
+fi
+
+exit $rc
-- 
2.43.0

