Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02269D75E4F
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 14:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B864C89859;
	Fri, 22 Nov 2024 15:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="K5WqH3+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6D02897D6; Fri, 22 Nov 2024 11:29:43 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71D788FAF
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 11:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQOsuYFkwp11GQvrASqhTwHXNEIOVrVlnydvDa51jqq0NWgF0mFb8L/Z5QXz/MjNfQuvCF7MQFWWmT3zym69MBwWYd8eAU4cH+5u5FbWHGvm3f3TlVYty+H6iFkAaQfvqKJJdnUjop0xmERMDedyX7ts4ywRILKbvznVfmbAfCt50ANxiWH9TSWYCkJ0gGI1GouCI4tobxuc0QETjSbSOTTnit8PbCMPUFaG3Z5rzZZi8sPoFfSMOfxBX8auWtSbz+MAhPkVV4cN9jqNns4oQkHPy54+D4TiisFX9SyDCAD4BYCnuFdRagZNRMhvpGrmG1Pmoje255uILt5a0L+C4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7Xvlrlqj8lm4jeei4xTVaJygLRBjrpOYsNmAkdvWlk=;
 b=S2Ft93/l7AnfdL2/cp8WsyLX7oPEmyEgRgn7E8d1iHdeR48hzlSGJ7qBfBmPvgR/BY2I0YmsSKAf6NnZ/ajWPua5CeFtDZRGEcGqcpbYKzfPW797Zw3IfRQwT6YNIPE/UsfzAaPo1lTyQjkg7j7kosACMYLASvwMgYG+rEib/4iTi1LMsrKtYYmQHGp+aBphRqdQ8RK4mrUqnIKJdUM1WfdiHKXc54EdubqW/pjBMFPz8gVMnbRGmOkT/zeF+9zb+F4zAaF3j13sAJ8bcwh5+wioEjrsc9cg2Sc7zDBBJxlp2myewZKvZKx2lE2DziAI+0xlkdscN+pUCeGpd2Zwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7Xvlrlqj8lm4jeei4xTVaJygLRBjrpOYsNmAkdvWlk=;
 b=K5WqH3+6RQEyi0mnXIi1eA+LZOPfOYXN/yvtwf2TuyE47y5q1lvyKGfCu3jD0nDsy2Y34/DjJbaADa77vbv3I9XJpo+GWoELWsPoPuvJYFxHtfpSt0+VME6YFmU5iSWCAbwmquCewDY0FgDoq6xLtywuXlHMuYlE8Q8Y5N/BR7Q=
Received: from DU2P251CA0027.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::33)
 by DB8P195MB0742.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 10:29:40 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::b1) by DU2P251CA0027.outlook.office365.com
 (2603:10a6:10:230::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Fri, 22 Nov 2024 10:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 10:29:39 +0000
Received: from Diagnostix.phytec.de (172.25.0.14) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 22 Nov
 2024 11:29:39 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Fri, 22 Nov 2024 11:29:39 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024112211293896-242 ; Fri, 22 Nov 2024 11:29:38 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>
Subject: [PATCH] board: phytec: phycore-imx8mm: Add EEPROM detection
 initialisation
Date: Fri, 22 Nov 2024 11:29:38 +0100
Message-ID: <20241122102938.4080117-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 22.11.2024 11:29:39,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 22.11.2024 11:29:39
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DB8P195MB0742:EE_
X-MS-Office365-Filtering-Correlation-Id: c12ff73b-e13b-4ebe-4f58-08dd0ae09249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0KuUxY2vE1tsBsvY52S8dNmO7sdVqAle8xJ6DClo+SYy+n2c/FT1J/nZU2ai?=
 =?us-ascii?Q?8D9xzuEXQzrjtb9eWH5x2WbG9QvXiKoajq7gv/A0xCA2mtM5lGNbjN444fSn?=
 =?us-ascii?Q?VKtqRlNz1XOIiv0JrnrsyYWNgcYndJiU4UXtSzcYlCsPMNIsZj8NDqxwd/Wp?=
 =?us-ascii?Q?gd7dFDtXyCuLJccaMfWzzyJiEDrm0BSLZrBTbc5ADtH7fRhrs+HjS8oPkSI7?=
 =?us-ascii?Q?rDuDYTUm7v3oZCZ+GyA9rILygWVDOJMVi6Bj5/g4RG7A6rlND1UsUkPWUGDF?=
 =?us-ascii?Q?TXKbRKhQFTpFUMKxSyeq8RYjlWSIIuJ8vFIXR2cdxI68dZeSyt1qK2daoFQO?=
 =?us-ascii?Q?2fPI17R+vpKmt9LSFVGPDVRMCQYgcqQGUdoL4QBIet2OSbut9BOEe8XQ+YGg?=
 =?us-ascii?Q?p9XyxQIM/2FjGltEdzT6sVKRayd2/53FMMU0V332kGMR7EWuJGGXISxfSmEx?=
 =?us-ascii?Q?icOLU1b9a6vyMYoSJHzBsAqpdbUwj05V8j7kUdsMI2d7BN6rcBzzCFYFnHD7?=
 =?us-ascii?Q?yIBLs3tGFNMGjs/ZOW0SWGPxPXUwIZXVzbY1yF/vuFM3EdJfS7eYSioUTvqK?=
 =?us-ascii?Q?KZZWM9mBEh7FZFmbjzeWu0N0V8NC9jaqi3YamfcM302NZyAhKhgG59H1SvlH?=
 =?us-ascii?Q?UPID3kRwxs3yer7qf53V2lxoAXODZFwY29o/b2D9npCcC8UImlVenyzBMQrx?=
 =?us-ascii?Q?xpwkheGm0J3QN1RZnSy6lblKFlJiwcB5eTItLHy8OJNJg0eBhbmKraFaUXYt?=
 =?us-ascii?Q?Rm7NHX5Vo6+58jbSCQdnQF0EMr8vG1O4q3kQgt2MmfRbsOocTb4B69fFUW+e?=
 =?us-ascii?Q?FMXMmdlOMPDYGXSfe8R/jP+NdbzN+MeFnM1g3AAutfDdxGCR3wG6AW6jCCwt?=
 =?us-ascii?Q?R20jJlKc/lvGiltnpjRYusUZu8VjJVdXLB8D+UmSNJr74b6/kq24ptks9rBM?=
 =?us-ascii?Q?njj/AazXQuq8+7yWNBrV2r/PPAU4KAfrcrXyiR1uLg4ER3dSuckUHz5FKrTi?=
 =?us-ascii?Q?e8S4+Nl/yOO3ZQ/ezJWDJ9r5Wm30kE/dFxFZ2gRi45JQNCZscOMFambyxBHI?=
 =?us-ascii?Q?uarxqIot2C1803kjACyDjD1pC2u07QNGVRZnL0FUDDN0G4Wr9EEu/c3ZXSoB?=
 =?us-ascii?Q?7w3OnQVqNWn1AFkP82Or52wtn+2b+ouzxscyu8Jtw7BvWGtx2RDzeJfJE7xp?=
 =?us-ascii?Q?Hcbi4suM7Mt9wXjAp3Yc3nP1gXkkl3M7oDLzpXAbizMd3kqO0obsVH9nuCgv?=
 =?us-ascii?Q?v21LU5gC2tPLR7hruFrLHl4iJKEVf9aYC6Ee9EiECiNxOksIQvhttWLG8IO1?=
 =?us-ascii?Q?bJ8aoe6MnoY3XmgwyeBU+darwGOGgx5m2pIwYq+vPSZHAIP8VGd1cc+Uq/y8?=
 =?us-ascii?Q?yOx6riwvBlzKZVc6Z7uz1PA7e5xEschQ7C3vpqSFtbZnAiStPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:29:39.7989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12ff73b-e13b-4ebe-4f58-08dd0ae09249
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0742
X-Mailman-Approved-At: Fri, 22 Nov 2024 15:05:24 +0100
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

Add EEPROM detection initialisation for phyCORE-i.MX8MM.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 .../dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi   |  8 ++++++++
 board/phytec/phycore=5Fimx8mm/Kconfig             |  1 +
 board/phytec/phycore=5Fimx8mm/spl.c               | 17 +++++++++++++++++
 configs/phycore-imx8mm=5Fdefconfig                |  1 +
 4 files changed, 27 insertions(+)

diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi b/arch/arm/=
dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
index 516e52e1f5d..512dbc9ee86 100644
--- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
@@ -14,6 +14,10 @@
 	};
 };
=20
+&pinctrl=5Fi2c1 {
+	bootph-pre-ram;
+};
+
 &pinctrl=5Fuart3 {
 	bootph-pre-ram;
 };
@@ -54,6 +58,10 @@
 	bootph-pre-ram;
 };
=20
+&i2c1 {
+	bootph-pre-ram;
+};
+
 &uart3 {
 	bootph-pre-ram;
 };
diff --git a/board/phytec/phycore=5Fimx8mm/Kconfig b/board/phytec/phycore=
=5Fimx8mm/Kconfig
index 25e4bf2f836..06449128ba8 100644
--- a/board/phytec/phycore=5Fimx8mm/Kconfig
+++ b/board/phytec/phycore=5Fimx8mm/Kconfig
@@ -12,4 +12,5 @@ config SYS=5FCONFIG=5FNAME
 config IMX=5FCONFIG
 	default "board/phytec/phycore=5Fimx8mm/imximage-8mm-sd.cfg"
=20
+source "board/phytec/common/Kconfig"
 endif
diff --git a/board/phytec/phycore=5Fimx8mm/spl.c b/board/phytec/phycore=5Fi=
mx8mm/spl.c
index 8d858590a39..faff064779c 100644
--- a/board/phytec/phycore=5Fimx8mm/spl.c
+++ b/board/phytec/phycore=5Fimx8mm/spl.c
@@ -17,8 +17,13 @@
 #include <log.h>
 #include <spl.h>
=20
+#include "../common/imx8m=5Fsom=5Fdetection.h"
+
 DECLARE=5FGLOBAL=5FDATA=5FPTR;
=20
+#define EEPROM=5FADDR		0x51
+#define EEPROM=5FADDR=5FFALLBACK	0x59
+
 int spl=5Fboard=5Fboot=5Fdevice(enum boot=5Fdevice boot=5Fdev=5Fspl)
 {
 	switch (boot=5Fdev=5Fspl) {
@@ -39,6 +44,18 @@ int spl=5Fboard=5Fboot=5Fdevice(enum boot=5Fdevice boot=
=5Fdev=5Fspl)
=20
 static void spl=5Fdram=5Finit(void)
 {
+	int ret;
+
+	ret =3D phytec=5Feeprom=5Fdata=5Fsetup=5Ffallback(NULL, 0, EEPROM=5FADDR,
+			EEPROM=5FADDR=5FFALLBACK);
+	if (ret)
+		goto out;
+
+	ret =3D phytec=5Fimx8m=5Fdetect(NULL);
+	if (!ret)
+		phytec=5Fprint=5Fsom=5Finfo(NULL);
+
+out:
 	ddr=5Finit(&dram=5Ftiming);
 }
=20
diff --git a/configs/phycore-imx8mm=5Fdefconfig b/configs/phycore-imx8mm=5F=
defconfig
index c8fbcc910d8..3f4336837e9 100644
--- a/configs/phycore-imx8mm=5Fdefconfig
+++ b/configs/phycore-imx8mm=5Fdefconfig
@@ -11,6 +11,7 @@ CONFIG=5FENV=5FOFFSET=3D0x3C0000
 CONFIG=5FDM=5FGPIO=3Dy
 CONFIG=5FDEFAULT=5FDEVICE=5FTREE=3D"freescale/imx8mm-phyboard-polis-rdk"
 CONFIG=5FTARGET=5FPHYCORE=5FIMX8MM=3Dy
+CONFIG=5FPHYTEC=5FSOM=5FDETECTION=3Dy
 CONFIG=5FDM=5FRESET=3Dy
 CONFIG=5FSYS=5FMONITOR=5FLEN=3D524288
 CONFIG=5FSPL=5FMMC=3Dy
--=20
2.25.1

