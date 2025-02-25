Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0147C021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 12:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E752180FB1;
	Tue, 25 Feb 2025 13:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Sz5X2Twh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A11480F53; Tue, 25 Feb 2025 13:12:00 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::708])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83B080F7B
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy6si+SL/s7gfR9oonTTsMfGCAudAgDtUgtRhFzAusAggkdZnzSJVqc/+iyanNdosIHwIppS031W8dCvhJiw68tms7utQK4Q55qRqqupTD+JhEy7xGXlHYCGob0HsuZyRfvSeckboMnWSgFtH/7Ur+2RagVCpy8iyFETk0LV/+ls8LJuCr2Xe8FOHr3bISUdpAIml+0H5+HdPqEwcZqrPFnAm8jnvzcCJ4EfhYAui93xM6DffwIzKS8FwEaMvaClTN8dI1gFvzWVMvnE4n/KhRNpA0FatAx0dJ1QLvngGWx+rjMcvyfxqnnuGhXE2KqG5qbKzLGJq8xROUTH9WJDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9R5T2ML1hYZdc6YK3xlmqNIjzbXxEbg4GLT7O0HYgU=;
 b=Q7z29k35Bbi5XOREsV19oVOK27sPp0rzjrW8onsVLZqE+kbb8mEDyrSIiy37WeXFI7VUsEiSbc4fVNjg2CRiWQV17Z4JeFK8fSxyy/G/EFzxAOsFFpBahyfIT1U/9ttVVcDC3ZYQ0h0keP0cH7dtyxdUhlRaTYsJyWrT+8zOoqwcCMwdWwvUmGcvcU89VNBY/uWjmtM1DCZZRSfcAYg4LaVjrKF5hk5EFczh3j9H9B6u+eGM18nKRwODS5xMPwaAhcQIbEYhkabdPF8elHbAUu5OYEE5tf852bmOyCbvZoOasm7DvmaNhrVrqGg5H8o1st48KelrO/m5pRO5lmIaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9R5T2ML1hYZdc6YK3xlmqNIjzbXxEbg4GLT7O0HYgU=;
 b=Sz5X2TwhcIhMAoLAJnEfUQ3Ap9h/u21bQZrlvpvNcZ8PJtVQIqra39fG2q8PKTg5jhgKI2AE9tsRADwwcMSZI2App2JGZmiJsePN0PUEOQrirgJfa6XM7pTQRMG5LItZ/IDwEWMuxhsWdKOnC7WwcWmjChx+1aPMNnKfUfo2DIN3XxUBG/pV/fuQySave5vKog8nD5/HJ5dXNv7HCwetv6KP1o7zDDAFhQ4j4GV+2mHv58Vefy1wwIb7uTWlJzBI9sfQ5PYGTgl6W4ynjucfXpv1sEUvXOk7nV/YoKiSvmn8ZsUFtH241OH6d94EpoH2PT47D8hZYJJD0ZiGbs6Teg==
Received: from PR1PR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::46) by AS2P195MB2458.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:64a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 25 Feb
 2025 12:11:54 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:102:0:cafe::4c) by PR1PR01CA0033.outlook.office365.com
 (2603:10a6:102::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
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
 15.20.8466.11 via Frontend Transport; Tue, 25 Feb 2025 12:11:54 +0000
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
Subject: [PATCH 2/3] binman: build_from_git: Add optional make path inside git
 repo
Date: Tue, 25 Feb 2025 13:11:42 +0100
Message-ID: <20250225121143.14862-2-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225121143.14862-1-l.anderweit@phytec.de>
References: <20250225121143.14862-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.242]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|AS2P195MB2458:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c98d05f-fad7-49a7-6385-08dd5595980e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TSIsO2RoVBpqiMuh/hyN25j3Cnx6OkSXLGjIDf9cZJdDRqXvi+/EZiMO2gou?=
 =?us-ascii?Q?DpeuEmYWTgN+w4oQpVRLdPSiwn+U2nnDuaFwEssyr/lp20aaWnTtlcart84M?=
 =?us-ascii?Q?39IEXIV/BSbxA6ptzYmsL2KegpPZA0QFEuzp/9W8Id0N7XxSd6QjVwhURIxj?=
 =?us-ascii?Q?Jf8YWXzSnhRrhPXpuqRSZJ3Gvh4e8Ha7l0RP6qvsGdcxFYOd5o3HlC1SZ0Jt?=
 =?us-ascii?Q?plc3sUSDE/DhVQRUDKYKugz9+TAQdLXoqI7BeOpSriWIqRN2REWOd/zXE2/t?=
 =?us-ascii?Q?2KSttOgGIfHSiyXew919PjwYRNRdvLUhqkR9KaWdBQJeYidGEsUyn3E1KoOO?=
 =?us-ascii?Q?jek3r7HBSlDpqZDjULlmhycHfDIQYI6D9VneiuHc852y6BXdXMEZfrfp92OA?=
 =?us-ascii?Q?G+mDfiremuc2YIGVHBDUtaed+NzeQNywNCPzT+kw8P/RdNYX+F7swF2pixzk?=
 =?us-ascii?Q?WOaFqhOFP3n+u88J7xtST8VoVtrinBLGqwHNtH32dsU/YNqJvNGmv1q17CdC?=
 =?us-ascii?Q?6+DgdT3Au4QiIq72p1YUkx70C3MTCeQDaDudLrtgTNMxgakX+V0WdzzzGNH/?=
 =?us-ascii?Q?xkkratmlSA4xgf5A7WLK9OGVCWzVTjO15n+qdkPP27fcBXs8uyf7SLnDmBwg?=
 =?us-ascii?Q?pYvx8Ob9QFU3uJjHnhAubcKC5RAwJSKg5XMAO8p7MTbn20xLq4+6siU/I9PS?=
 =?us-ascii?Q?9D3w068HphpAHAx9W9OnBHYArlkp9I9u4D5kTo+6T+bfCE2kQttup7Q8VCDD?=
 =?us-ascii?Q?pX9iTlUqtPLgdswCEAhK3iJSZAICnXegZjFchKb34o4pi+39JdELtD1UnlwJ?=
 =?us-ascii?Q?bZFwtqrjQirOVUgjuITnBiwN21jIKf2RxoHMpoUc+nqTgiuULqEDkO8yswAo?=
 =?us-ascii?Q?pobzTuCimtGfUXoSKRTeORKJEjj+2tdkI7gl5X2mlztdE4vTcx7VskcGq4DJ?=
 =?us-ascii?Q?FCenySWecDqvdU0OtFWlft71H5Z8RJza9t/sb2/K1EY/YgT3uwa/roZoU7kz?=
 =?us-ascii?Q?H2ZpMqRkwszwpNpHH5A1rLcuVqMbo4NZJ/PoQFWwKn6HFs5Tg2j9fbcUVmG7?=
 =?us-ascii?Q?vpcjQE/flM965Or9uME3vK3RVWgzrpq6Q2GKxVIwbe1PsRF2VMupAaeNfUE2?=
 =?us-ascii?Q?nX52U2ChqN8Ic68lqjrbevfyS99nsZBcEzfXgTSNcGnsQ8BkLayI4vwPbOPd?=
 =?us-ascii?Q?aZ+7uY/SkrN1MMdrmqI/cVNmTdbbuhp5E4WHUVZSq6ZAEeW8pgeslqNSgNsK?=
 =?us-ascii?Q?7btBw/P/ODE+98htz68+OYsgfXZvxizdsXZDHIU/O3CaMYyrppfxgSSei+Qy?=
 =?us-ascii?Q?+4Sd7SyTNKhULaZUTRgBPr33yDTgwtzA5pvJ9PLI/B+Imcbxbz0Z/kEHbUuX?=
 =?us-ascii?Q?gBT9vmv1uaeJFsl+Twm+vPC5kgZlOKgwByxVdC+jzYiUgE7aNELlocDukjqq?=
 =?us-ascii?Q?V3CZFJAZG9BFZwJYc5AVZGsBiPZKHZH10+Y+w719zQIZLVUwOOeBrkBui05T?=
 =?us-ascii?Q?nUhl5kvQ1civKqY=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 12:11:54.5733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c98d05f-fad7-49a7-6385-08dd5595980e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2458
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

Add optional argument make_path to build_from git. The new argument
allows specifying the path to a Makefile in case it is not in the root
of the git repo.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 tools/binman/bintool.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 7280ee4f8cd9..81872db377f9 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -329,7 +329,7 @@ class Bintool:
 
     @classmethod
     def build_from_git(cls, git_repo, make_targets, bintool_path,
-            flags=None, git_branch=None):
+            flags=None, git_branch=None, make_path=None):
         """Build a bintool from a git repo
 
         This clones the repo in a temporary directory, builds it with 'make',
@@ -343,6 +343,8 @@ class Bintool:
                 build is complete
             flags (list of str): Flags or variables to pass to make, or None
             git_branch (str): Branch of git repo, or None to use the default
+            make_path (str): Relative path inside git repo containing the
+                Makefile, or None
 
         Returns:
             tuple:
@@ -359,7 +361,10 @@ class Bintool:
             tools.run('git', 'clone', '--depth', '1', git_repo, tmpdir)
         for target in make_targets:
             print(f"- build target '{target}'")
-            cmd = ['make', '-C', tmpdir, '-j', f'{multiprocessing.cpu_count()}',
+            makedir = tmpdir
+            if make_path:
+                makedir = os.path.join(tmpdir, make_path)
+            cmd = ['make', '-C', makedir, '-j', f'{multiprocessing.cpu_count()}',
                    target]
             if flags:
                 cmd += flags
-- 
2.34.1

