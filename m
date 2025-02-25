Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AC6C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 12:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5629380F9E;
	Tue, 25 Feb 2025 13:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SbR7h8oz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E7C980F9E; Tue, 25 Feb 2025 13:11:58 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1CD80977
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1dqY+Mc5kCCMHr/bQelq5xXXVlcWwPxCFQjkFWJwpkjnf2NFhcpgYbZjEqPrkTTN8+pzv9teSUHtqAzXVr8NPFYvkV59InE/oU104xMaO2yLmxnkCMyynsjYNBdTq8LtwD/kzmxLs3kPncwvMWYMlmHgn4Aka9oAOm1DuaSKWtWy58/ZhQ3JhQvh68cghIPuPAdbejbnJSXAVdp4ANprRmygDxaoWxPSO39I7QoxBTO0TuDua6lPZQh/xZl6Df6o5j1UrzOO2ouVLNKQ3Wi8GOfYWQ4sDBCrY/aLGoakAyiKY6R94YsUpThAhPrU0C9eODKr0hwTea5l4Xukpp+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbSe++x2ZWGbxcCe5MKmVnvFoGAQUthgEGcxEIJg7mo=;
 b=Vamu8xj7FcgrbkpRSdieXchke7L0DF1b60nIF0jpP7UQy8MrAA7gvJZHovqepBOdwd0ADY5UGdX+/LIfWms3B9KZqbfS7BrfZXhek8/FywseuWCus8eqwWSPO8nWsUmC1gZSi8Kls4NwMYBjBM33p4vid0e4HjBp17c8QRXLsZCOO8EGGFCGYQr/fTkDQssQ40499U3jLNsNJ17sMJVEme0sWXzmQ/IAfL/ACQV8u6aFUuFUvA0t+2QkEB7k3vc/0L7IsCDaC6kISODjcy/ZXmy2CEeQ8nB+lAKuHb4oQMsLDTLyIuf8/vXQcziMF6QtG/eJ9yIodgrylpHXu3O6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbSe++x2ZWGbxcCe5MKmVnvFoGAQUthgEGcxEIJg7mo=;
 b=SbR7h8oziILBZDsairPOnLB/d9Fa1PMbowP6QEBE92F8RnXb30yN+18urr9DNLR0gHR8x8FIOxYiO0XMfPKd1c0GGc9xAGMEyGiRTmpCEBebHQ3NAEuNy2mQL5aZXAaXEzBkVwNbPmfXRHauemp8yyjn+J7b68xe175URH22GLKeNTG3JdnDrAOFXyvT4+6oNOg0hJxdshDme3RhI5RoBylqEuZZNP/xJJEPylhBhC6L2sa1InPxcnTD87VonczDePcZgiOpBn03W6L4dN1XwgCFt88BP0N4liryiU9+t0dcaqvZizM4Yt4H3rBBxCWeVwDz6mRfGjeEuNSJ4gvr5A==
Received: from PR1PR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::32) by DB9P195MB1540.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:336::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 12:11:54 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:102:0:cafe::da) by PR1PR01CA0019.outlook.office365.com
 (2603:10a6:102::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 12:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 25 Feb 2025 12:11:53 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Feb
 2025 13:11:53 +0100
Received: from llp-anderweit.phytec.de (172.25.32.242) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Feb
 2025 13:11:53 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Leonard Anderweit
 <l.anderweit@phytec.de>, Marek Vasut <marex@denx.de>, Tim Harvey
 <tharvey@gateworks.com>, <upstream@lists.phytec.de>
Subject: [PATCH 1/3] binman: build_from_git: Add argument specifying branch
Date: Tue, 25 Feb 2025 13:11:41 +0100
Message-ID: <20250225121143.14862-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.242]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|DB9P195MB1540:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ce9f71-67a8-4e91-198e-08dd559597a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vBjccLPYK+TOAr2Cn5+XhzsWTj1/Vopyg+OoW1rciAUQFYqg5sjgE0S83GK5?=
 =?us-ascii?Q?3WhkdjhMf2Yg/UbAewgwdQrUbkmOEw4fKgCNJcKnZkbTyBeQih6kLyBTpZk1?=
 =?us-ascii?Q?AK6cwYg5mowddVjPwOO0hjClFW1m+irGCQr4X1nisu5ZI+czkmUlRrf+ptDg?=
 =?us-ascii?Q?R3pS7Hn5U3gMroZvPGv8tOEnBEmABptS/Hl8jdj9sZWu8M34v7zFs70qYbKZ?=
 =?us-ascii?Q?PD2H8qsYe8cEEfFGL18N/jH4josO9YCkeMcDVsL9xuHDLPyY2YeNuvRjfbdx?=
 =?us-ascii?Q?y8o/m60q/rY1IwMsH1m/10F+N9PGqXE0OYXJM5mAFSmiADrojYJd2sA2Ylx1?=
 =?us-ascii?Q?7fZcSfTA/SwlPxdzOOF/4+zXuVlb9A9y9gJNLJrr3HYjW/IQSPA6Q7zsr4bj?=
 =?us-ascii?Q?eYJ5Z3MmFVn2Ga5JERJLnFeUGSZMFdC9QiGrJnF7E/TsRn3huz9aXFYOqzP4?=
 =?us-ascii?Q?Sck0jK6ivdJExprxeIt5lxBIBcFWjhkJFIQNx90VvluKYtDgeuTR54InCHib?=
 =?us-ascii?Q?ZjTPfp1KQ1+ZisLYZLHkgD5SLawYOwHH8Oa8bdUb7rwiPZ4oMl8PnzXEfatN?=
 =?us-ascii?Q?6HgsrKAt8Lu2/shXvXwmtqmFTU8uPo/bP4ILwu4LKic7bRIwMDfHsRUVpOGt?=
 =?us-ascii?Q?mpstP01JX0ajTByXiRTZWIxT5D8WMOo+80nv52EwWrpH2ADeKAVYP1Ier2dO?=
 =?us-ascii?Q?I/y7XP+XgWmaW7WPshIF9/Mj3hCzqjWAXcqMkg9bRsqsGLtTZKNUy+E0QgOf?=
 =?us-ascii?Q?Xp+NW6qqHdhLEZJFuY8WHh0csa2PpgycwDyR7u+lon7mWNbYi52tKV7ZFnTq?=
 =?us-ascii?Q?DD/VZjhv2vS+PlSkxSNI8XwfHlPVs1P0B5L6TRkBpQgMRFp5cDce/1O3FpXA?=
 =?us-ascii?Q?cadHWUNu2jJFlazcOrhRp6n1hfrg/2jmp1cJWBZSxlp+zoAMspKE/dsLnwmh?=
 =?us-ascii?Q?tspLBrmu3Vo/maumbzIiH/7BXtdKtZnrU+59eOw2OHLvnDDbKvdq+IOP6Fll?=
 =?us-ascii?Q?sLrxz9NGT8e/YzMRJpbZCsV63zUeCpDZ9Za00BymfeO0UA2DZHXzVGUTYupb?=
 =?us-ascii?Q?Wgpa2DxIEAG2NbaSQgUSVrQk+x0FvJuxZSveAeICaKGvMv03tVpcXrifiKem?=
 =?us-ascii?Q?0gl7nDRvSY1gaf+VP4y9cotWnoEG1e4VGjoyqUDpMXMqN+vreIxDAoak3Qit?=
 =?us-ascii?Q?8bgYF9YygYP1dW1Kfy6WOHvtSSdSEZlSG0zZSZW8s6WTnsxPDKf22rijtJvH?=
 =?us-ascii?Q?66xqGPVbHkPcmjT0OVO9WzCxN75CVIOo9NeTtXS8JN7WLjgSqQFERGnk3v5U?=
 =?us-ascii?Q?QMtGaokX9XXTxpQACnbRNDdySkc5nCB5rL7L84agcHwb1uJfw1m1CuTvB/Mw?=
 =?us-ascii?Q?sYPxDtjRIsDePI7L/u8543KxvagbiMe7gG99fEOz46kQjeYAoHA+YqAdLFkJ?=
 =?us-ascii?Q?+jAP7/qE79R9E76Nz+ImuHC8ZDRSTUYFr7EKkPLi5J6czSmuHtqwICc6UbTU?=
 =?us-ascii?Q?jAjMhKP/DUHWWF0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 12:11:53.8702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ce9f71-67a8-4e91-198e-08dd559597a3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1540
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

Add optional argument git_branch to build_from_git. The new argument
allows specifying which branch of the repo to use.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 tools/binman/bintool.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 3c4ad1adbb9e..7280ee4f8cd9 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -328,7 +328,8 @@ class Bintool:
             return result.stdout
 
     @classmethod
-    def build_from_git(cls, git_repo, make_targets, bintool_path, flags=None):
+    def build_from_git(cls, git_repo, make_targets, bintool_path,
+            flags=None, git_branch=None):
         """Build a bintool from a git repo
 
         This clones the repo in a temporary directory, builds it with 'make',
@@ -341,6 +342,7 @@ class Bintool:
             bintool_path (str): Relative path of the tool in the repo, after
                 build is complete
             flags (list of str): Flags or variables to pass to make, or None
+            git_branch (str): Branch of git repo, or None to use the default
 
         Returns:
             tuple:
@@ -350,7 +352,11 @@ class Bintool:
         """
         tmpdir = tempfile.mkdtemp(prefix='binmanf.')
         print(f"- clone git repo '{git_repo}' to '{tmpdir}'")
-        tools.run('git', 'clone', '--depth', '1', git_repo, tmpdir)
+        if git_branch:
+            tools.run('git', 'clone', '--depth', '1', '--branch', git_branch,
+                      git_repo, tmpdir)
+        else:
+            tools.run('git', 'clone', '--depth', '1', git_repo, tmpdir)
         for target in make_targets:
             print(f"- build target '{target}'")
             cmd = ['make', '-C', tmpdir, '-j', f'{multiprocessing.cpu_count()}',
-- 
2.34.1

