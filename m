Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5FDC19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 21:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D7180FD4;
	Wed, 26 Feb 2025 22:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QAT2yBv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29799810F2; Wed, 26 Feb 2025 22:05:16 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E59158081A
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 22:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZckpFiItXEvS2YJd9Yp7Ia/+IuLlrxxOQ/TbF2m54eCUSnLg2PUhH5oVfRoL+12PiGged6x2DDt0TYXgGQJtz7tbxUs0GKDB1+hukLRR45VPTrYo+RYhtt8TldPTABDyWDnnezbm9kx4MB0Va57eT9e3+b2pEp1SHCwu7zEhk4RKsA75g6ARIV0xR1cBQsvMYhgEA+csouXxYl6uqAAGOr9QoYeHW3mQ/za0I6ghfEfid1AE+rJAhmVUYdZ8aEgSevtGX1WS6MtKdylZCHqJQo/Uz//DjH7NT4x938ZBqE+pCxiKWREQtHqNgLsGAuei4dz7/mAzGTA23EItWVx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbSe++x2ZWGbxcCe5MKmVnvFoGAQUthgEGcxEIJg7mo=;
 b=QtrLhI1CDff8cJVjAW5k7A0WiNlvgvp6mSHcQo45ivV1OKCmP/nSn8PFUujqaXyY4OfhamuDqVwjRjfgqAgk7mkH9iv8ECCguo3l8DsEKoA9lEt2nPLvv/k+uHc4V7rcPaAl2DPWVKNLH/rKXEm+PI5qssMPDPXXc3H+bhJDznSmWRzTLFxgJ/jK3e0umxpfMebaUmGYwEF/TAsP1gEImcOAG4YteEqIew1XLqwIVreVlpZTVwQWw3S1AICOgoZYxbGyhEWPXLW3BpETVq8wU20arjBfNrSUd7kHZ/v3PLHVF+xVd51S2C6x82dtdODiG4ax3K3ZrMr3IJOVPrNZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbSe++x2ZWGbxcCe5MKmVnvFoGAQUthgEGcxEIJg7mo=;
 b=QAT2yBv41vFI550sWUc3ZBW0BKrLr5DIjgnq9tMEMOMKXthqbcSJ+HrTsOWpE21u63wySWZHOdNCE0viKssjGNnAqrh/Lu8Q4RqATq7OveR9sJlw5dsQPifHKq3eMyuTIA5V2wEZFNf8FCUyOVsrfhEVBJA1mhwdTGXu8Vhfwv1D82HiFt0yEJHYPtVLrPgYA9uriHnOL7lSUguFIcJa+CA0KJl+frJRZJfL+pKxX1WrHcfQf2b2CceIU/Os7WS4qQ4RrHWTtmk3uekk0gKhhaFvUGbT5UiCASdy4bsKtQDOffvl5nNfMKirzXXSU4M7wFOE+T2Hkx6XBoJuLQw0og==
Received: from DU2P251CA0021.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::24)
 by AS2P195MB2152.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:558::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 21:05:11 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::4b) by DU2P251CA0021.outlook.office365.com
 (2603:10a6:10:230::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 21:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 21:05:11 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 22:05:10 +0100
Received: from llp-anderweit.fritz.box (172.25.39.133) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 22:05:10 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Leonard Anderweit
 <l.anderweit@phytec.de>, Marek Vasut <marex@denx.de>, Tim Harvey
 <tharvey@gateworks.com>, <upstream@lists.phytec.de>
Subject: [PATCH v2 1/3] binman: build_from_git: Add argument specifying branch
Date: Wed, 26 Feb 2025 22:04:59 +0100
Message-ID: <20250226210501.72794-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.133]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|AS2P195MB2152:EE_
X-MS-Office365-Filtering-Correlation-Id: f7247a90-88c9-4759-710b-08dd56a94202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tDSdoqDUHsK3+JgW7Ya/Bqu6ImQbGjNI0/M2/bmGFb3aCZsHAyYVEdrFNBL2?=
 =?us-ascii?Q?8KkPeNp+CDZpFuhAtYTmQRccTCNiZjZ7hwFV15Pzf+gsUJC+h5B+FgW2arpr?=
 =?us-ascii?Q?WqJU3Tv3BOt3bo0fZx/f/4kewfYXI1SxnbO9geHtUzTWVvVRI5c7oqdzH6Bb?=
 =?us-ascii?Q?ls6bDrEzZKKkmOMpmn5kGYifPSWcb9YtpGlHu2fDkiCE8HAhnBxNP6CcMsNB?=
 =?us-ascii?Q?yUsX8/9AfRv01dSi64uC1yY5uyOarnPyIb6vdspCDreA4Vfv7DHdHcom2+ga?=
 =?us-ascii?Q?ueXyMRZyHOitvu7GKKbsxOyNuTYorLJpkBFkABlGYIPxv5aNOHAiQb5c1zfI?=
 =?us-ascii?Q?cODcvj1LZVgLk/HX36Bba99UKBUJUXc2J+2NYTlT2NG9hExuItH/+WWKiKzH?=
 =?us-ascii?Q?4DWsd0O7FJMi7SpumA5lHeZRNQp/dmnWlqyQGLvA79VMf+hv+wO1xWwjwFNz?=
 =?us-ascii?Q?RzUIfl62o2/lFWsQNrGD1RfA6UTseO4HOA4FLJWbhMmbZli19qbJU54U/TyH?=
 =?us-ascii?Q?0eHg3rMepyH/z1jtDVl6M7Nckp7YOF4C05VvCao2tv1ejzHuxjPefWfYyonF?=
 =?us-ascii?Q?WUm9q62CcqcV064H+pKi4LnjO7lFHFRx9mcFbKzUZcSrbfdXJxUds73V0qQB?=
 =?us-ascii?Q?Q+IqBmFYdW7fE9c6+aSpa9ZszXPDGvhr3OWre7IpbGQD/OCZSjEe5rmFUEtG?=
 =?us-ascii?Q?2otqDv6BRhF3BnCfWm4mIFBasNamqC3UddMtVvmmX7nzBC32rnFeknKgug8X?=
 =?us-ascii?Q?PuW2L3CrP0aKv6fFa28OL9xAEZfWGtpuO0BZNRhLM5bMHKi3OljYaWxYK4Mt?=
 =?us-ascii?Q?wMZtebQjh5oJeQ3FNpAY3xyamX//Ci7DPpX3pj04eS2PLeCX52u49vS4wx9K?=
 =?us-ascii?Q?HvrcX5klEqXE9Wo+/LvM+uGYy0be8O9L8t/3935MBA4EFHHis3Z+RWduOsC0?=
 =?us-ascii?Q?1eTbEqie60U83usQtM8vNt+cohRH15QO0NIcEQ+3Bp8bbWIQk008k2CKA5pg?=
 =?us-ascii?Q?tQUtrHfHAmZdap14Sn2JM5ki5E9DQFw01bPV4up4e+W3i4GP1UYmOK155qXB?=
 =?us-ascii?Q?UEuNUBOrBabmYOq4XEcHb4FvIog5EZCtzle6OMBG2WiFBVg+nZQdrdSkW8wH?=
 =?us-ascii?Q?hjUowuKFwgSS+HDQUQY3+sJDHlCoE8pJ6A06tfysX6l4Hh2DXNlPJcrWnZOB?=
 =?us-ascii?Q?W4mL8teXLoI8pe+Layg+YN9xEc+StiQw99jHOc1dhXpNO5IqhJ1NpVzP7K9b?=
 =?us-ascii?Q?z7e+XqLhnd37jsoPKrd4wp3BgvWJzWAkPQQ4l8RZwP6w/E0+3IOonTsD9GxT?=
 =?us-ascii?Q?aMNYyEr3U9XH+BmXIOxhCwUwxS4wZYNHtR5elk3Ze0PhYMYfdLJJ/wQjA3cO?=
 =?us-ascii?Q?QJ0mYZdfH4DCLRXYTz7FESIHUxCF+ouuGMZIFrceOEACmG6rczJoiXyes0H2?=
 =?us-ascii?Q?72pnWkzb2Rn7v6ZgKTd/1wRBdi92dnCXCn/fJKAj0mIu03/JerC4K1AWTNkT?=
 =?us-ascii?Q?lRdy3uubIXyq6Gw=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:05:11.2771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7247a90-88c9-4759-710b-08dd56a94202
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2152
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

