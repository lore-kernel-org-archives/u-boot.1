Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE528D75E4F
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 14:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A87589853;
	Fri, 22 Nov 2024 15:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="gK94nrtr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C1F8897D6; Fri, 22 Nov 2024 11:28:42 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59FDF88DE6
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 11:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBS8pggRYRakkcjpKY5ZW41Y8y8835QzY/XtHTyOBuwPvYZulg5JHwBHgsUoJJH4S5Bui6isPq3R+3uuttzvJ8e4pR3zmrN9jmKcuECMDgaLzGimwOip50itYR+p65ok3ynAdclbYDyuoBmPH0gm4csyQDI8rgZliMJVPKVukSN3+A+m6epdW91IyUI6wkDtfolWXrjsq3g+S/zAaIO8P4fH5g5vVTHKKdoD49tCjx4FF14im6E61tp3+pPz5S/0qoqD+3CNEeem54zuu+9Re1ZPsA5Sa7ShVgXoz1Yj7P7nCDgW9DM7/otZuIY+crBPB/0d3DtUNXagLp51RwBZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAt2f52dNS8JQrG5UTPSqtn9JiDvJiTN2lbe93XmNP4=;
 b=UXdrw2DGfTbZD/Wiye2hAj+hbo1d0kvuzuSx1hQUCrY9uBxIo7bMS17ZUy277h45XYnrAC6xlSMkMH7GzYI4RkwAcJsfJPzyJYuKOGY7HOCanDGvsHy9aqpj5ejxI+WILtrHT5oNXmYbir0ZP1G6Eza/b48wruaLPWSH98Ck0mrntkbBW16Pvo1DCd2LWtLegE+pqVdNidMksApFnQ8CR7DyUx2ATy47MHLJThhPI/JAxLRgZgLdXOiPUYDUoSEoIOOIckPAK58GnQIgcuj7Aet+n2q3RFbJ4fOVpFRBCwMdyi8oitU4QxODlg1RyYxl8+aU7TUvEL+j5ap2IGFViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAt2f52dNS8JQrG5UTPSqtn9JiDvJiTN2lbe93XmNP4=;
 b=gK94nrtr6WkjaazAwnepduZ1x5IwcucRXC4/mRHwKbCucWjg2Yk8WEQ3S29GuJj9tJeH24qkCjTyUfj9Gfs65ZNHml+sb4OngcYrFs5ZpqlRuSWAN5MtExt95woPvOCphqGmhJ85/S5GzRHRlGITz6Uer3OICN/Nj7E7fQ8m2Dk=
Received: from DU2P251CA0013.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::17)
 by PR3P195MB0990.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 10:28:35 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::17) by DU2P251CA0013.outlook.office365.com
 (2603:10a6:10:230::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Fri, 22 Nov 2024 10:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 10:28:34 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 22 Nov
 2024 11:28:34 +0100
Received: from Diagnostix.phytec.de (172.25.0.14) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 22 Nov
 2024 11:28:33 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Fri, 22 Nov 2024 11:28:33 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024112211283347-240 ; Fri, 22 Nov 2024 11:28:33 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>
Subject: [PATCH 2/3] phycore_imx8mm: Move default bootcmd to board env
Date: Fri, 22 Nov 2024 11:28:32 +0100
Message-ID: <20241122102833.4061689-2-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241122102833.4061689-1-y.bas@phytec.de>
References: <20241122102833.4061689-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 22.11.2024 11:28:33,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 22.11.2024 11:28:33
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|PR3P195MB0990:EE_
X-MS-Office365-Filtering-Correlation-Id: 911c0cae-c0e3-437c-edc2-08dd0ae06b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cHfWYujXv34pOsjoELW4lJzW+r0jJ8EjqKkTzbzk86Tld6RUGaFfrxlD4X+Y?=
 =?us-ascii?Q?KQfd44HbERGu6CU7RUpUK7uGwtTBd1h3pHtWQCIETEpwGQIi2JhuDb+mVHDw?=
 =?us-ascii?Q?i6tHprDbm1DzE9QEZLnNdoRxcPsSMaZw2yT00v4NaW3/tUWyIA+U1ZZ74sCy?=
 =?us-ascii?Q?zKg1Iy56nk7qrXQNScNpedvfLgt373SQVjUlmjX/oADJ8gGTNniwi6bNF/Y8?=
 =?us-ascii?Q?t2cIZd81XFblEQPNr3Vbstpcd9iqGs/pRiLKgxRBN0ESS1zlNEWLGD+K9CTU?=
 =?us-ascii?Q?ywcDoBU6+cM9BAOKF5eRcHdXLVdzqB3EeSK1G75ir1lNKw+/wdRZIBow5qz4?=
 =?us-ascii?Q?63n8rnqjeZw1SvK2+2aR332XuZe9g3cM2gEYLR3nVuBLDbtAUzg62geuu7jP?=
 =?us-ascii?Q?tVMistZJ4u7Aftlfzqg453aK+yuFB2uASAD4dexAzimEFZP451luDB0vbMeR?=
 =?us-ascii?Q?sCrCVlZpZTMLJfsWMI3JThFHBrGrc6kE7W4iE4vwaPNjAFiAYyLpDJ2ttbCQ?=
 =?us-ascii?Q?+keUagPq/thoRjMzz45HdfWJ7ZorZQRaoybHKosoIjLw+WXeIAZKZlE5IGKX?=
 =?us-ascii?Q?P5+W94F39Nlhs92SYUbn8NU3+qLtTdpXDBOdegM6iIXjaDu2CyAoh8b+3s0N?=
 =?us-ascii?Q?1acDWDMzqbpWg5dlS7czkZV8UYwSSuRg0iH34v3ILas/1xy7Ke2DSUrqcMlU?=
 =?us-ascii?Q?bOg6fyEajVLVPisaU4n2T1UPE7uYHpR3SpPVxevF35YrQDmGSBtEWgzMWuQ0?=
 =?us-ascii?Q?cLVCwQ11uh+ZiffIJ5TZA6Y2WA8EhJ1fEDJ5vmC9KfJXzUM18xSfZwF51/Mb?=
 =?us-ascii?Q?QGR3NzSBuFDd964mFGPSukGOo5gHbXTA8TxiSqfLm6CVOLQuxsXI2DARYKIz?=
 =?us-ascii?Q?ENSdZJ8esax4pY2rJPhlPA5Zrd+woz4aZDceU3rIavgz6NgUP9JN94WCqXWB?=
 =?us-ascii?Q?50CYYjqy7qgqqJddttvmGpp0dsGU4QJE5twBItqa2jo2HXO8LIoqp/xWOgJ6?=
 =?us-ascii?Q?xIPhAfeVN+WkzRr1UFNC5k6zksTRo/3fGxberUyEm/en5IL32RNZ83lUcAvE?=
 =?us-ascii?Q?V3yEqKcOTknr+m5MSKUBmSElvdWplHtsUTUbBwuLZ/UY5E6fAsgULx6OrPLX?=
 =?us-ascii?Q?1hP1EZoCiWJ7RzoOP+kk7If8IzUp9klH12SY/lMnu+E4XBh05Y9aOxq/ZJg0?=
 =?us-ascii?Q?0EnHGwoR8zpv5vYzoEk0DVlb3f49z1QT+wbpaDPO9CkcJr0OPZo6VNF9/GMe?=
 =?us-ascii?Q?v8yeIxDjHlKaxmvgTKTw0/pPWZFd2ZTGkp7crCOAvbfa8zUSnxXo4slN+yZQ?=
 =?us-ascii?Q?j0rK1q5Xy3ss8ZGMRLX2MfbSNwt1yIJGb0To3/vMhj4n6twG4M5RxWLSumZL?=
 =?us-ascii?Q?a52kNdjCqt49MKiES4GiMeP73m3JNQpfnLlIN+gIhZWw5seN5tpmvcZFkXyV?=
 =?us-ascii?Q?1qpZ5r8AUFkTc7ECU9KETA9VKaLWsTag?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:28:34.9047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 911c0cae-c0e3-437c-edc2-08dd0ae06b8c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0990
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

Move the default bootcmd from the defconfig to the board environment.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env | 9 +++++++++
 configs/phycore-imx8mm=5Fdefconfig               | 2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env b/board/phy=
tec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
index b2f61843995..2058bf59235 100644
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
index 5e59efe5649..c8fbcc910d8 100644
--- a/configs/phycore-imx8mm=5Fdefconfig
+++ b/configs/phycore-imx8mm=5Fdefconfig
@@ -30,8 +30,6 @@ CONFIG=5FFIT=3Dy
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

