Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA90C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 21:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4BC810F1;
	Wed, 26 Feb 2025 22:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XxkLp52a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD588081A; Wed, 26 Feb 2025 22:05:16 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C622380FE2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 22:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0TfeHq5de+4PKJRYXF15Px7A/5UvTbYQ7I3XDdyksdwyDu7TxEp4Mih+NOebO3FEc+qimB2WKlR4ANdEZHyLu5tPQM4fDgopHEGYoegZMm4KPIk7L3LNouhtQJspTd6k61A8KauJqkUt7i0B6gAvOf80UF5GuKEhbh0FesVz7Dgv5Hl9uocpY8GXbXnArcGRDM4oWhvoaHvuI6V678IgWQL55/mFuxhJnxAk4MWv0LFKXUfxXzmKMnRhSVj/6em2GCKmbjyUu4X7iV4eaHuZxptS3QngBzKWV6PVRZJYGeo7+DN8PTB47FcW3LrVCqaERRxqs5KhDSJ/m6t7bCRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEg4d7+OeftDyDqlCbn3Hc+TBQFJsubgVhThrYXFPDg=;
 b=JaIBTh4G7DfAaupL7pa1vmAnzGzRzkRmj7VlSLWryL8vTr+6EZUNTrhb1Xp45D3pUXJOhdXid9B9jwalzd5j+Q9MJ81KBxpB3OJ2kTnTUp5MI35Wv6gj8uJ8VCN0kQVUMZJeAnbxNBw+OKH4tP3D+cO9jq2PwUV+f7Gkwn3ZtVhZu9OjMkXM0Wtg6mvJ10bcoig8dpulOpIg52voR3EB5jH2apT0rOsg1YSaxzPbqkOgI38a4IynbWQGIlAAk6S8NnHA1XErl3aDEuWgxBIYkLQrYdTNi+yNAQbatfLpz5Rii/t81XxU7nuFrt4a+gchtGuzLTRVZ7bOUzURlo+kbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEg4d7+OeftDyDqlCbn3Hc+TBQFJsubgVhThrYXFPDg=;
 b=XxkLp52abU1jZDVOSgKcRg9P7n8Wt3rRJlK7BDaeKpYaCkD9smce+1pjoGbjEcYIzuVC6GPlBPnI/9L9TPq62D/8ZnM63MWwb/ww9hgHDsEitqp5KyMExZR9J162oguQNXeK4HC/W8NCdHTqRokSnCmkddRTjRWNkIOopo7FaDia0KuYV1xXF1RqM0js9MgZCU6SuMvuoWHlvHK5zI6K3NLbaB2iR/po2nLQ4XC+AD2wYwgVb52L1hRRnu6llEADV1DMWaQDUsIIWqiQ74CuUUPCJtwFyvKyyvOUmgWrof+5hRdg9I4xs+1/qhuaE7phSAYtBmV8lk0c1lx2n9Ve1w==
Received: from DU2P251CA0007.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::9) by
 AS2P195MB2217.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5f3::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.19; Wed, 26 Feb 2025 21:05:12 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::83) by DU2P251CA0007.outlook.office365.com
 (2603:10a6:10:230::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Wed,
 26 Feb 2025 21:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 21:05:12 +0000
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
Subject: [PATCH v2 2/3] binman: build_from_git: Add optional make path inside
 git repo
Date: Wed, 26 Feb 2025 22:05:00 +0100
Message-ID: <20250226210501.72794-2-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226210501.72794-1-l.anderweit@phytec.de>
References: <20250226210501.72794-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.133]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|AS2P195MB2217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f49d5cb-687d-4516-2fec-08dd56a94283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LeZOPXtqnIVGbS2H6HODtr3EgI8tzlPF4ihvYXBdmjZ7USO/IDrkNgjPnlVx?=
 =?us-ascii?Q?D40h11a6XuqpUqbmB+Wx1aELddk6SZqwhBcaIKq4bN772yQP1XKCWrNWpQYw?=
 =?us-ascii?Q?2Y9/5qmqeSpP/XcttYO5QeXcqqhwunid3QwXWz+KfQ7EYSbtkxD91vMSUnmZ?=
 =?us-ascii?Q?F0xb3n2NF3T0Hdf9NHCrumNy+Sejfyld+aE65D2MafmnGF6w5dOiO6OQMscf?=
 =?us-ascii?Q?7+vBo4mUtJkwuJnX2sxmNkpFDSYm4g8bAGRefZ3IRVxJCFjsgO2iJWW+FDSg?=
 =?us-ascii?Q?RBBQTDe1UppzoZJXRq1oYrdUXJQ+DHiV4P7+VIvx05HJoTK8/bppwR9++SkC?=
 =?us-ascii?Q?pGOlzjcbKx2Edj+WjIWvnt+/HsFznD5h1MEhunODckvwdnxK2N6zEV4bbcyG?=
 =?us-ascii?Q?82a8L20qsMdmXVdHkOwjT1RVmVPBm+Vd51jyHYoXoi1ukGI543h3IvN9ulmn?=
 =?us-ascii?Q?Nf5WdhI7UtL/gpd81L5ubKT+RKXV0UVa4InDRb1PYKLOWk7FLIartlrxBOUq?=
 =?us-ascii?Q?1PX6FupPfIGxcEPi8DtfuPurpBk5pMP0+3nBiVjAgRzH4YZQvb/rEviA0Jke?=
 =?us-ascii?Q?rqlo3Ht46uHi62ArExrqXSrRLLfdtI5UwgMgSc8Mm4NR49hrPu7t9/4qGX1M?=
 =?us-ascii?Q?a24ojvQzRVct3E1KpVoqehDniKcIqFkBuS9skxzEw86xDgk92LMX7oyJtuYq?=
 =?us-ascii?Q?ns1X1W66gj7k+rvN5uhVL8K1fOxydnwmLEfiKH6kI730sVyRu6NaT/qjY5/x?=
 =?us-ascii?Q?Pe/BpDE1IZOmL0tEAs9BdAnjkf3YGzJGMtAo46nKBGHJrjHYiav4xJXcKbch?=
 =?us-ascii?Q?V/+NQk98+I480Rv/ZawAdQR5bX/PaVLi+eJD0oG9x+xMmxHeTaug8HLFIHVh?=
 =?us-ascii?Q?FZZ/2EHTO++NXlai0ATJG+XTXJPLUCVKkLNGuzekOL/dhd5Tv9wMocu1aBH1?=
 =?us-ascii?Q?iXBY/LFFJNPZQCTL0bA5HheskrDU8FJCRMfM6vy7VF1Np+TBFuD0jAkgakX2?=
 =?us-ascii?Q?iE727F+XaQA+bOJc79qRdgnUwYq3vl6IykLutAK9BvVWobWyw+z7GrHeuXqK?=
 =?us-ascii?Q?+yX04rnmoJjwvrBuRqtk3+ZgTwiRxkZi/HSzLd2bnc0JAS/+KpjY8i0MyXcv?=
 =?us-ascii?Q?etObd27N8CTLqxZvPossuOQftxRDv5S3g4PoNF8NZysmVPD37ohz+fpylLE9?=
 =?us-ascii?Q?LfXwYAHEr0AE3+Gu/vGFGy5W/MdXoaize4ctp7hUIIzSfQ1OtmUvwcODeVka?=
 =?us-ascii?Q?zEgdXcf01i/46Rs8DDqe1gMbru2X2A+1FHwmEqvM67gDvV629iiClsNxLF6D?=
 =?us-ascii?Q?ukapI8+WmQJby0LRvR0blCPcMgioGxwwGecw4jlCBzrlI4UlR+MQh6Gua4t3?=
 =?us-ascii?Q?DTooMO5wL/rPNn31eq5jWBqOR1zUGAcAXUw+VEOxopJFDmFJdDAlPzpPJrgQ?=
 =?us-ascii?Q?FSbTFzV6rkB26iTJn6PR4gJE0AhbjX+2ZIs9dsSdg6EwgqlNU+NAi1uoNVI3?=
 =?us-ascii?Q?UoldIFeORzsduXA=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:05:12.1208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f49d5cb-687d-4516-2fec-08dd56a94283
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2217
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
Also adjust the corresponding test.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
v2: fix tests
---
 tools/binman/bintool.py      | 9 +++++++--
 tools/binman/bintool_test.py | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

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
diff --git a/tools/binman/bintool_test.py b/tools/binman/bintool_test.py
index f9b16d4c73b5..949d6f4c8a90 100644
--- a/tools/binman/bintool_test.py
+++ b/tools/binman/bintool_test.py
@@ -303,6 +303,7 @@ class TestBintool(unittest.TestCase):
                 # See Bintool.build_from_git()
                 tmpdir = cmd[2]
                 self.fname = os.path.join(tmpdir, 'pathname')
+                os.makedirs(os.path.dirname(tmpdir), exist_ok=True)
                 tools.write_file(self.fname, b'hello')
 
         expected = b'this is a test'
-- 
2.34.1

