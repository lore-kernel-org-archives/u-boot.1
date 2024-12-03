Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB513D49797
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B2589635;
	Tue,  3 Dec 2024 10:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="E9c6Z3OL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65B7E8962E; Tue,  3 Dec 2024 10:37:48 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6254489625
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCAEsrzz658sV8dGDsQ5SrxN3q1gL5XOtwWGLWeWDHW/Etfv2DZ1n8LqrfgSbarXeNdhRjaxRtrbRfyuViJ8PXtL4Njx6kucnzFyFVKfRuIzzXHKFLVm7RNF/JkaqAAruS9DNCu0UJuFdm914TNwwPP/Gj9oc/aPFIz7/DD8N4dt5W7qdldrCzwemsuHVlxmce8UElnvSm66Im2uzCPNTz5PGXrpIJJ0ns2GfbrN1oK7j7eo+Jusku0dL1qqHf2+RUaSk+xiWi12bAyNdza5g65RhJC8OhS/vEA5H844MJSrvjFnQNIkjpvdYliec6hZdnapxBWn6mspXaYRLyqTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UinRdZ1Ffv3mgZyyOFcRm0TcAM4YS2rs/EnWkmaTQ08=;
 b=o6U1O8v+UpGq1DWnGys/jwvuSCsUyjtS2sb4CWr8iczfnQlTrHE63B398biVRm97zYvDQsVv6IfZTJDIN6GRzgH9Mca7zTJWixcMc/LwesxoLFh4bESRO6M3mKzrphi4MOi/i5UT+Krsw4JAAqXNrqI9uAajjI5r74khWA9HuJ5v0mhQPDRhDqjJ4jYHljl8KK9dT5mmEjM21jIuM0Z7ILHjI5IPXaKDAzoR8hFXpR/r+GJ6Tq/vNV57b7lXl7aLgAj+fpe/SaoI/etS0LmJWA5rsY+tZGDC9nfUf77ohfaJ/SscEnzMEsZIfWR3nQ4bn/e43dtxBHVzqFb4rLnRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UinRdZ1Ffv3mgZyyOFcRm0TcAM4YS2rs/EnWkmaTQ08=;
 b=E9c6Z3OLINtnG1B4YeEEwP2QwhP2ZXp15+aAfu3kDKPjCKlAuSzlzp8lSjbmKj9yVnHWwczgPxK4RC7FV4PoF/a+glLc+nuXNkc5ZUDkPu0cxDqlW4B/FHO+L3Az4v5rwfBcJ+Imr442unK4Mb2BkFWhXOjMaWDOIj4guRo7gQI=
Received: from DUZPR01CA0214.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::19) by VI1P195MB0688.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 09:37:42 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::7b) by DUZPR01CA0214.outlook.office365.com
 (2603:10a6:10:4b4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 09:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 09:37:42 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:37:41 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:37:41 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Tue, 3 Dec 2024 10:37:41 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024120310374019-264 ; Tue, 3 Dec 2024 10:37:40 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>, <t.remmet@phytec.de>
CC: <Y.Moog@phytec.de>, <B.Hahn@phytec.de>
Subject: [PATCH v2 2/3] phycore_imx8mm: Move default bootcmd to board env
Date: Tue, 3 Dec 2024 10:37:39 +0100
Message-ID: <20241203093740.693628-2-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203093740.693628-1-y.bas@phytec.de>
References: <20241203093740.693628-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 03.12.2024 10:37:40,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 03.12.2024 10:37:40
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|VI1P195MB0688:EE_
X-MS-Office365-Filtering-Correlation-Id: b667c159-1cf8-45e4-d2d1-08dd137e2293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NeQjsYQMHVekug2HdS0VcI4/e/WYcDREmrj3glW1LK5N/pBhsFECcIhhDOr8?=
 =?us-ascii?Q?rGEJWKWSKpuVl/tt4zdStRcz6mS49uCwgt4geJYrKVSQShiHNzwSjUiVfbnk?=
 =?us-ascii?Q?mHmR7UYPSdFvXLYgHqOW6HqnXZ/0aVWeQI3WPLm/vr974bfXK+O9wf581TKi?=
 =?us-ascii?Q?2P9EGiX9gQA6PM7JpZHYVsWY6j1OeuNzxDxHLueS4hSbV4Nlz+J8nPV5fOnz?=
 =?us-ascii?Q?Dhz8JrwF4POPSBGVrhV7h7rBUIfX8SOYtwFCI70RTmaasaS1m9sSP8iRdgja?=
 =?us-ascii?Q?VP10UNC6rEsaJC++sdHpZrX6tZiFaVfXVDiSWTrpGEmUu2EJ+N0KHuZz3ZaM?=
 =?us-ascii?Q?sqgKzww89XQqFagh1lmSLwrXzSnzMa7tjxeJ4yZjxKrz6M1dXLVePNhqEkj0?=
 =?us-ascii?Q?Q7Yu8cEJoX/QLdJDtXM6Qiq0EfomfPliO/TlOA9ftKcjHmA0tsnk65NWTvnx?=
 =?us-ascii?Q?8Ov2xfhCbsh5mnml1xV77bcZy2smXzGV1V7x0IBpOGRgdo73kI239+a8h/MR?=
 =?us-ascii?Q?PCMqezH2y3QLciLl9AbIjEFemiq+CSNeck8pXnFYXNb/rPgKqVdF33xPjGm8?=
 =?us-ascii?Q?wADRj1xGs1Oqj94h9uzPTRK3VLT9t6RSgMwLR1j7v9oYEIAfF80uhdQ2vY0f?=
 =?us-ascii?Q?YXDkZ9rk63kF9l+cA0iVAEc0NuwUfPJfOJ+8bdKZpAsoc08FUi/e/ECKMhLP?=
 =?us-ascii?Q?2o4C/KAoNZ2tnOPXBI51BLYqpTWIW7m/N6sFfYy+lgq8b7k7TV7cDKe3fZ2v?=
 =?us-ascii?Q?RkuZPPUAPeU3AagjjhNrsTWBTJXQdE3gEiYPvvuROqj3z3SERvjXTeT4z3S1?=
 =?us-ascii?Q?z+GgZfFkun6029wewQ804r/hE2towLi1LGUvPBMQJb71+s2OplMu4N/9ZufX?=
 =?us-ascii?Q?Ewcj6UnNGJGew7KgPJlS5fFFoNCTfTlmWGa0AC4eL2TNOz7ICgKNLMX3uRkk?=
 =?us-ascii?Q?sjYAsJNoow+L+TGby57dq/xHEZIXGR+n40KbDAFnGxAD+Oont5oZzQKEU1xb?=
 =?us-ascii?Q?65R1IeXsa/6xurX+vqjeeJbzraxqRl7BikD1GTzHAFiJcE4KQJEy2lbJK8rU?=
 =?us-ascii?Q?PufS4k4bAT9wr2ghu+TrLe5qHIMZTmEsKE8aJ79E78erRWDI7RL2tSWgJa4f?=
 =?us-ascii?Q?Kyp4bH7/LVRETyxDENquKee8LkVu9TQt3YNDHP7b37eq9qzE+SNB4MESWGPo?=
 =?us-ascii?Q?/gyRAZpDyVPDuxcg6LVP+1+SlRTCAmsCTZK61b5qKTt3r+ERoqtzIU7fEGjc?=
 =?us-ascii?Q?WOR+jclT62l7oiHYVcqc+EJbyUpDv1BlD51L0OBqqRWxs8C34MnSovj1YDKS?=
 =?us-ascii?Q?VS6zWPtKenExD0X76M0Pn4vpFtet1J84yfvR73yHaqkxMKql54LCxNrdIoK5?=
 =?us-ascii?Q?yvicfOA+xmrS+qLNkKAmYgjaAEVN7uP8dcmmJN4owCSh5Bg6K80SaAdCo/7f?=
 =?us-ascii?Q?VnH07mm/IHQuNjK4fz5Hu4yVhnVbyMAd?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:37:42.2773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b667c159-1cf8-45e4-d2d1-08dd137e2293
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0688
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

Move the default bootcmd from the defconfig to the board environment.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env | 9 +++++++++
 configs/phycore-imx8mm=5Fdefconfig               | 2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env b/board/phy=
tec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
index 33a2595fa16..44fa3731b8a 100644
--- a/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
+++ b/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
@@ -1,3 +1,12 @@
+bootcmd=3D
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
 console=3Dttymxc2,115200
 emmc=5Fdev=3D2
 fdt=5Faddr=5Fr=3D0x48000000
diff --git a/configs/phycore-imx8mm=5Fdefconfig b/configs/phycore-imx8mm=5F=
defconfig
index c24580430f2..3f4336837e9 100644
--- a/configs/phycore-imx8mm=5Fdefconfig
+++ b/configs/phycore-imx8mm=5Fdefconfig
@@ -31,8 +31,6 @@ CONFIG=5FFIT=3Dy
 CONFIG=5FFIT=5FEXTERNAL=5FOFFSET=3D0x3000
 CONFIG=5FSPL=5FLOAD=5FFIT=3Dy
 CONFIG=5FOF=5FSYSTEM=5FSETUP=3Dy
-CONFIG=5FUSE=5FBOOTCOMMAND=3Dy
-CONFIG=5FBOOTCOMMAND=3D"mmc dev ${mmcdev}; if mmc rescan; then if run load=
image; then run mmcboot; else run netboot; fi; fi;"
 CONFIG=5FDEFAULT=5FFDT=5FFILE=3D"oftree"
 CONFIG=5FSYS=5FCBSIZE=3D2048
 CONFIG=5FSYS=5FPBSIZE=3D2074
--=20
2.25.1

