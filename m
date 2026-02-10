Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F149BEA8109
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B42183D6C;
	Tue, 10 Feb 2026 13:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="EraAFxDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C248388D; Tue, 10 Feb 2026 10:00:55 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934DD8341A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3E4zYbHSeYtPfE/d4aEdjkIQzDobUo8p2Q4A5z4sAbKzkHnXKVywTsF7JLsKwewH06QYoj8dvP+D4ZEDjaiew3NNmgvmxCTCnmTxi4UgaN+R0+fuuyIbKlZCjnzdOFIN+003xFwQP2/+WcapGcHEN3G9bAGfSKmW77Nl4YQblCMj+05dH+s58Y+DXsXYS5Fd9Qe0hZYcfXz0lU2SY1vWWVcMSPyRmcB8Rc8f9+jfLPSCcrEPnPqI0klJK31JNJV4cYpBqth7mUWgK+7PTdO7MLY9LFvBjHNCO8rydYz0yTwHDgdnDPZshfw+c2JaudcKz3alq18LS71pKejcD07sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7EcrPCsGbx848ajHB/ugp8Z6DRoiVg9c5q6R+bazwA=;
 b=X+GzgoO19kMO59taHfwjWnwhpbFQ8JWSv9QixuwI/uSPzRfGw+p+K6V+G7sGv8nFQBf867239EqStAuw4A6SGt1rsalCmg4XOPqtnrvDOLGAh4Lqk/NUa5Ue+unB5AhNF5ExefIJM+V/I4CJk25XOcN28wE6LxDR55BxlLHayzdnDdGPRZwjd7zeEYvrsXp0WdSEyfJSgxv9+0BRZtc8ZzvJFgbNPYz4MogFrTFaqSwo7O6goQ8D04mJFBUIJ0/29ri2FX9WCyq3HblYgOwbaj4J8TsDrkfmkySmAnM2HfHKiJcYSqqNISqOoVnLbrG8JorazRRd0xSY+c+2nDSlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7EcrPCsGbx848ajHB/ugp8Z6DRoiVg9c5q6R+bazwA=;
 b=EraAFxDMThmwryEYKnv4qt75qdheuLfjp3BE2hvVLLBPgfEL6BnO5y5gDkwqmU7w45GZL00Qfufe6FWTyd3HkGL9BHRvZvTQ3dwk7RyTKd63bHtY+orGZ8blJ3TP+/6Q7Xg/+fKJHwwjH/iurVZHVraU9hw9kPOKvWbSjWp4nCJra+roy4mR8ZNYtsx5zuOPqj2DXKt4uB4/8rmkqVBuifWUM+fydrIE8FAqCRf+tsc07Z9oc722jC2C7jA7MOtDG91ERTiUb6lTlGG4oQ/VYosxmbsliISYcx/39IkLPa3wa53kr3DC/aMDoGQe2pWIWMTi3ZR6vIyr3iSwxgjghg==
Received: from BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27)
 by MW6PR22MB4206.namprd22.prod.outlook.com (2603:10b6:303:245::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 09:00:49 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::b) by BYAPR06CA0050.outlook.office365.com
 (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 09:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:00:48 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 3A9C9F882E;
 Tue, 10 Feb 2026 11:00:44 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 David Zang <davidzangcs@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <monstr@monstr.eu>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Scott McNutt <smcnutt@psyent.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH v2 1/6] arch: imx: fix incorrect shutdown call for inactive
 video devices
Date: Tue, 10 Feb 2026 11:00:23 +0200
Message-Id: <20260210090029.728636-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
References: <"20260205141332.2515996-6-brian.ruley@gehealthcare.com">
 <20260210090029.728636-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|MW6PR22MB4206:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 58496797-3203-4e35-d0e9-08de6882e28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hZliiBP57sJr/4fOjlNvUtebUpoEj47nGyn5BJ6ZWH3H5NvO4SS9QSUTQKM8?=
 =?us-ascii?Q?u1hGODY2duKhYj48ZY+3Fl65lMBwIw6TmBSFSIWED83mnMoIy80RWNiagt6X?=
 =?us-ascii?Q?VL6VWOysn/CqJRquSRFngg7MELEAlgyQlf5492Ewg5Z586Qb6zvWX3KvtDy+?=
 =?us-ascii?Q?66if1SlOYmC4UOOsAJbhWJio1M/oqzf4fMnuoUNG/yL+B3SYYL5rUE00TRx4?=
 =?us-ascii?Q?h2Wrvc1LbnJd13ha9dEKRYAtQh1Nt2/kVxHGU2tI+HCFCWdjuRbM9uBtBIxh?=
 =?us-ascii?Q?xYBnDMYMRQY9bspVMnsBhklR1PkXD+bng6FAzWohNjpnx3rdLsmn96ljC84u?=
 =?us-ascii?Q?zqYntRq+Pp5BLdi1vNELMtkCDj3UMpyfvfv1oZVQxHMo4jE/RkLs+gUVA/ds?=
 =?us-ascii?Q?eB+hf1N7x+6FtJ4dcdGIl66jb3H1VG4jzQuxzwpH5wockfTyQOz1OpAZDPHw?=
 =?us-ascii?Q?7KxhHN2JAdUafbOacXHlpo1ZOyKcRJLQmeH7aiLMoi4ZW1n/7doduEO6BqCK?=
 =?us-ascii?Q?BmrxNjFE2ZOC0JPDgIVoxq9uJ0XXkxjZ5ztQhJD7wm4ArwdKE1R4+yXaSy8K?=
 =?us-ascii?Q?FowA+1zG9m87DGoJIf41LztspkYnsECi9mL/C+o/b7Ddnby80iPdwlxwF8A3?=
 =?us-ascii?Q?K3BOxxk8+F5sIdzp8MURFYPBY0Md4hlvkDjFkSdq6E86b4O8U4s/S9fcKXuT?=
 =?us-ascii?Q?lXMPlXGNlDyUsGBb8iLTHFSUBDFzL9Omsopfl696px1zVIrWuvcAURQPDk+g?=
 =?us-ascii?Q?WLJWtAVKJxidGQqUmAT4IwpMJ+DxSkeFr1PvwFpvc35+kC0P0hE5pSAI/YGS?=
 =?us-ascii?Q?l5trLWs6kIHM9tNM3ys0sUv7W15rRAcs7v6BsNL00HcNuybQ9px4tZI9SzJ/?=
 =?us-ascii?Q?HojXlOAyap+Uf+ZvtQFhy/g6B7Ia4kcvBL4mX+70FSvg3G1Chu3SqDxX+iNU?=
 =?us-ascii?Q?udxCDahINt2lQvXYy9fcrLSj57rtXuS/EuQK+hz6h5exeN1DftlRBjIgRgyG?=
 =?us-ascii?Q?EuZ3shww23Iy4vr4z2raIqVJr1CpZQXKSBVZmMYGPfZuj2g2LYtrfURMeGyI?=
 =?us-ascii?Q?6jmzA4BXyHNW9lhMQLykTxXP2rUvbmbXobKPJvi+3Bjv1v691/PlVZofBCw2?=
 =?us-ascii?Q?kZSBLZJ0TvmKBjfef9biOiblqueojjnKb2hbS5WYBH0MmHCPh2XquIW73s6o?=
 =?us-ascii?Q?ZKoUDbKZi4G5Q/pCDiyvu8vhSvJnIXsasPW5uizAH4KrE5AdwthQeZcEvoCd?=
 =?us-ascii?Q?HaH58G7LI0f01tSTcGerhyM3NSXkReTS/eU2nNdRU6SYD36+lke5EZjZj1EJ?=
 =?us-ascii?Q?1hTtEZH0V580hCPKat2jM/Kv3TqI4nE+vGLzN4VxfHVQs//1y+YFNEtBUlW9?=
 =?us-ascii?Q?5SNv9zrnpPkIQensqNDneDo40qEATHbk8sVkLjsJG0/08DIbNTiv1ZgFVWKT?=
 =?us-ascii?Q?EF9X1pmVW2B9grTNaGnWSRWWxANFEkw16U9MWyxZSw8seXi/572NzAACphy5?=
 =?us-ascii?Q?GbihnrpVYGb5ArNx8ES73S/FV7aIudFUIgmxr3ysbFiYttP+DAg7nSyLZ6KY?=
 =?us-ascii?Q?w2pF5+7saX1EtGzDblX56IBYGiEKGBLARo2RprIUdtbUBxG6j7Cd0htP8FsX?=
 =?us-ascii?Q?lOeyWtQaMcGAeMgSbonQbYw90ql4td43xy+anluoEFOWpLCzd3xWEtSAAs1N?=
 =?us-ascii?Q?DNui5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Te2yiPRVRXHfTVhBTUSewXLgd00QZZeFd2mu/vNXQRk0ilIuJZ0gNANa6CvBujCqyUQ1Oni4UWbMcwnNuWQpflMFKPcRLsl10XNRDDAKuAQs99vmKi4s681xGo0zq5RCqIP0LmeGC5jAl2zbr2DqQSeHxf8dJIG1eMA+g88qxKMOiU9oua2e8BJfjHUPYcB2WGyhKxBQDhs4FH22jjc30Vne+V0vZ1ZZVYnOMFuW+ohYBwsu00QaZSFs6qlyX0o22Dhs3kTN/gO5QUT4NwvWl9jEyxC75gNonCEvBrMZsnmZjoYuG8ULHNtyLWPZ/kQbpBwo0jzRh2ldambaF5UnK5foykk5wtcSbHmVXd7hQtV5nNvtp6rflcaNMN9UvgzQIgRcqwrNck2Ar6byV6TALVvjmSyH1hgucJKwwTOrOvP2dbYjHdb6YMvU/ZGAZZQF
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:00:48.7046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58496797-3203-4e35-d0e9-08de6882e28d
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR22MB4206
X-Mailman-Approved-At: Tue, 10 Feb 2026 13:41:53 +0100
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

Somehow I missed that ipuv3_fb_shutdown() can be called for inactive
devices, resulting in invalid memory access and preventing the kernel
from booting.

Fixes: 32da6773f62 ("video: imx: ipuv3: refactor to use dm-managed state")
Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

Changes in v2:
- New

 arch/arm/mach-imx/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 20c741283cd..8af45e14707 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -310,7 +310,8 @@ void arch_preboot_os(void)
 	/* disable video before launching O/S */
 	rc = uclass_find_first_device(UCLASS_VIDEO, &dev);
 	while (!rc && dev) {
-		ipuv3_fb_shutdown(dev);
+		if (device_active(dev))
+			ipuv3_fb_shutdown(dev);
 		uclass_find_next_device(&dev);
 	}
 #endif
-- 
2.39.5

