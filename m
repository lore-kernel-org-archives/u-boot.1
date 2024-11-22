Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F113D75E4F
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 14:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D5E89842;
	Fri, 22 Nov 2024 15:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="XDTcu7f8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31532897E3; Fri, 22 Nov 2024 11:28:40 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E525B88DE6
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 11:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR3gvP5AJF26ZSM5iArfa/effwzfo7JUFfnFyo3esyerMnGE4nomf2TXRMBwXaCgeO29jZPqc8S680BgopHexLXFOnjs4hvybqwvFoE4JnwUdBDXh697nTa3cVMg5830k+ztFwDtr/ICAIYjNTkdTlngLIDvVIi78+k35uu8HS5atKPEyw70QQb8BaSbMu3HKO68HSBU2BfnosQuZClYSkPjTn3cHcyzY6MhNlYqiJ01SUit9nDiOcGMDXxSu9UQJ39Yf0v99fCymJ3blDnBsPYHJzYFfcd5u+MorHj2AJZ3GSrnPrfSVUX1XlwtpjVFu1QtsGiKRl8JSaO5CQ3oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jCzuhtBwBd8AzOtq+8UO2/nrnZ/mWnXyY7Pj2itUes=;
 b=SiKo2Ex2P54mcWoXOVaC6wJ9EYLCBBSQdMvE9zV9v7V7YGLjMXB3Tx8Tn+cio+Rkys7Yd5fCusHVRPCOj+EPShaPE3+dRkg/lvakvl7lKMTKTBEuhb2xnXJCjqVsEuoerRcrkY4rnOR4zW4SGISHRqe11XRNGzMWjzVd3BJruofIhk3PMxpvvmTplBbCWWnkcUINM+UFQUnn+uYiSCn5wJ6lWl/HQNTZCEvZMEVvUNQ1cQdpuPz7T4v6qdk+n4G5Lj/LEWxDmEQTG8x+w/5fHXh5RNolGAS6sh/iuN6umnUtbIriaExZqRbQD5USDhr7AwgE1+F+WavCu7EMqtiYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jCzuhtBwBd8AzOtq+8UO2/nrnZ/mWnXyY7Pj2itUes=;
 b=XDTcu7f8sJEjjFjpQQa8v/uggQ7IukJvtGwSqGOsw5Z6aGlKozdBGn53WRmxAQcJaFInLxWBek8Hy3i8ysdhxY7MXQ9v1KOpDikXnDpmBVQPParMPqNMu1FLyyd6D+mGh+dixWmYFgC+s1hW3RS10YIskRcv4pF0i918fgH2gz4=
Received: from DU2P251CA0023.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::35)
 by AM0P195MB0675.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:168::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 10:28:34 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::9f) by DU2P251CA0023.outlook.office365.com
 (2603:10a6:10:230::35) with Microsoft SMTP Server (version=TLS1_2,
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
 2024 11:28:33 +0100
Received: from Diagnostix.phytec.de (172.25.0.14) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 22 Nov
 2024 11:28:33 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Fri, 22 Nov 2024 11:28:33 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024112211283324-239 ; Fri, 22 Nov 2024 11:28:33 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>
Subject: [PATCH 1/3] phycore_imx8mm: Switch to using env text files
Date: Fri, 22 Nov 2024 11:28:31 +0100
Message-ID: <20241122102833.4061689-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|AM0P195MB0675:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7a7faa-08fe-44aa-a400-08dd0ae06b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jUjaWhfka3Q4tI32R5z0i4BDHYAS7GkpzVd8QAT/ZLOXUdUqh2hkQmoq6HI1?=
 =?us-ascii?Q?iCiu890eCkMWNHDwLEsuv0bVpr834mTOVkCnbrK75XtNNDsHfM7Ga/F2vHp/?=
 =?us-ascii?Q?LPkU0SWkTib0fqSmcp9zNf8nkLBV9IryhsmtYKZOqRAQ/oIe59+wschzxh7S?=
 =?us-ascii?Q?T+2CTHf2u7oCM3s0+afSuBa9qV1uKnlvL/HO3ExLppnTJ4uYSfsxzy5kezW8?=
 =?us-ascii?Q?LY16VuO7VaDhivU/l5t5Ly/uIcqBXgjQk83kwZ8Lwse2LUKHuqhUG8+cT24N?=
 =?us-ascii?Q?mbIBXcsQq0I8PPqwyQu0vsgerZ9m3eLSfKlAYbwH9UYnHpyvYs8Ak35TmXvx?=
 =?us-ascii?Q?fqzVv/BD+ublWyC3JQEWnbpDybDEyll/UvSrAt6Lkt/CivCqUy/RAawVQ+oC?=
 =?us-ascii?Q?Ebx9R0pfbmdM76n+Q2C1022/YnCscdc8thlJuLbHVk77RBY15o0xTEfi6WmB?=
 =?us-ascii?Q?dVciEQHhFOnLvBgqcrjcJ/xkBkPwO3hCo2MnQvdQxoZR99m2Kw4iyUpNWlKz?=
 =?us-ascii?Q?blQ4YH0uuQ0YfD8w6/q4z7V0RmaqVG35mI5inGmFWCzA9FVBRut6M1Tg4+n5?=
 =?us-ascii?Q?nqWI5VT4BmuNjCTB81dsT9zHacRW7eBZoloOTnlT5O0uoy2v7RqJPTRKkEBi?=
 =?us-ascii?Q?g/PXU0/e3EVGKwnBX5w9jFpkoC5wguiHdLyJrDuZ/LRoo5gKRr2VFirFNGMm?=
 =?us-ascii?Q?HLb2NPwcgkTWXc1jcftAv5L4dPnd6SvzFdufu9Jem0kqTC6Rb3CRgdQFTvhE?=
 =?us-ascii?Q?vfYa81hU/pqCJ/1BMe/lRIuF/1WcO7TS5yznpq91R4EM6XcCTiyqA3MipKS8?=
 =?us-ascii?Q?16QEpgPRDSoCv9gECnSGvbJppfXIquVPaylu0pVCcAL4f6z6f+8O1dKU1BGS?=
 =?us-ascii?Q?I1IeIWZUeuG2xHxfOYT9Pvx9WTkBzTkV7W1x4OQcouUWQ+Cd+N6vAfwTQSEV?=
 =?us-ascii?Q?kAZ8V53uZ16CQGzvKu6NaKFLwlShl4Ds6LOXfu8NEklQ8ElVeJMxq3J5DjHQ?=
 =?us-ascii?Q?lfNxV82Os9KUDLeM1dv5fefGwLHJlp0ODrhggf5EBzA6kFa7Bm1ail9krf4s?=
 =?us-ascii?Q?z1TGoEfL5X+QTaI8GcxvFvjd0t6jBnNesqf56mG/6iMhYD3BxOhjdH1zolbL?=
 =?us-ascii?Q?qZrw6xvdT28D3gOFFa9T8XIre7R0QuIx/00TlJL6af57vJWyxvShN4EVVgcO?=
 =?us-ascii?Q?qUNeZ6ruPo3F5yDP+y+EB+cw6ODFobgsH8DSqW/f/ablchzf/g9QguGgw10I?=
 =?us-ascii?Q?UYcfjMaJAjMO81M12UXhgoFkkKjNpQ5wVWfbN7FkJ4fq6AcrQ2TetSknD66v?=
 =?us-ascii?Q?EkOn++nNTL21Kxel3qcVReieHIhIrfiKgNMetvsOJEYltcmeW6fdIoZNkGHd?=
 =?us-ascii?Q?C9rQ6b7eFM6AKftvHfdMwI+IBxr8lfJxpwwZ64oE7Q+UfKc6xe0a7XX5awWU?=
 =?us-ascii?Q?B2SkdV1a0ruQVY3zBlZoXdmvW9+QVZpp?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:28:34.2016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7a7faa-08fe-44aa-a400-08dd0ae06b21
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0675
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

Move the environment into the board directory and convert header to a
txt file. In addition, this patch also applies following changes:

- Change default nfsroot path to /srv/nfs due to compliance with Linux
FHS 3.0.

- Rename specific variables as stated in the bootstd documentation.
Renamed variables:
	fdt=5Faddr =3D> fdt=5Faddr=5Fr
	fdt=5Ffile =3D> fdtfile

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 .../phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env  | 52 +++++++++++++++++++
 include/configs/phycore=5Fimx8mm.h              | 46 ----------------
 2 files changed, 52 insertions(+), 46 deletions(-)
 create mode 100644 board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env

diff --git a/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env b/board/phy=
tec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
new file mode 100644
index 00000000000..b2f61843995
--- /dev/null
+++ b/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
@@ -0,0 +1,52 @@
+console=3Dttymxc2,115200
+emmc=5Fdev=3D2
+fdt=5Faddr=5Fr=3D0x48000000
+fdtfile=3DCONFIG=5FDEFAULT=5FFDT=5FFILE
+image=3DImage
+ip=5Fdyn=3Dyes
+loadimage=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdt=5Faddr=5Fr} ${fdtfile}
+mmcargs=3D
+	setenv bootargs console=3D${console}
+	root=3D/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
+mmcautodetect=3Dyes
+mmcboot=3D
+	echo Booting from mmc ...;
+	run mmcargs;
+	if run loadfdt; then
+		if test ${dofitboot} =3D 1; then
+			booti ${loadaddr} - ${fdt=5Faddr=5Fr}
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+mmcdev=3DCONFIG=5FSYS=5FMMC=5FENV=5FDEV
+mmcpart=3D1
+mmcroot=3D2
+netargs=3D
+	setenv bootargs console=3D${console} root=3D/dev/nfs ip=3Ddhcp
+	nfsroot=3D${serverip}:${nfsroot},v3,tcp
+netboot=3D
+	echo Booting from net ...;
+	if test ${ip=5Fdyn} =3D yes; then
+		setenv get=5Fcmd dhcp;
+	else
+		setenv get=5Fcmd tftp;
+	fi;
+	${get=5Fcmd} ${loadaddr} ${image};
+	run netargs;
+	if ${get=5Fcmd} ${fdt=5Faddr=5Fr} ${fdtfile}; then
+		booti ${loadaddr} - ${fdt=5Faddr=5Fr};
+	else
+		echo WARN: Cannot load the DT;
+	fi;
+nfsroot=3D/srv/nfs
+sd=5Fdev=3D1
+update=5Fbootimg=3D
+	mmc dev ${mmcdev};
+	if dhcp ${loadaddr} ${update=5Ffilepath}/${update=5Ffilename}; then
+		setexpr fw=5Fsz ${filesize} / 0x200;
+		mmc write ${loadaddr} ${update=5Foffset} ${fw=5Fsz};
+	fi;
+update=5Ffilename=3Dflash.bin
+update=5Foffset=3D0x42
diff --git a/include/configs/phycore=5Fimx8mm.h b/include/configs/phycore=
=5Fimx8mm.h
index e74a3f184c6..20e2ab832ee 100644
--- a/include/configs/phycore=5Fimx8mm.h
+++ b/include/configs/phycore=5Fimx8mm.h
@@ -20,52 +20,6 @@
 /* For RAW image gives a error info not panic */
 #endif
=20
-#define CFG=5FEXTRA=5FENV=5FSETTINGS \
-	"image=3DImage\0" \
-	"console=3Dttymxc2,115200\0" \
-	"fdt=5Faddr=3D0x48000000\0" \
-	"fdt=5Ffile=3D" CONFIG=5FDEFAULT=5FFDT=5FFILE "\0" \
-	"ip=5Fdyn=3Dyes\0" \
-	"mmcdev=3D" =5F=5Fstringify(CONFIG=5FSYS=5FMMC=5FENV=5FDEV) "\0" \
-	"mmcpart=3D1\0" \
-	"mmcroot=3D2\0" \
-	"update=5Foffset=3D0x42\0" \
-	"update=5Ffilename=3Dflash.bin\0" \
-	"update=5Fbootimg=3D"						\
-		"mmc dev ${mmcdev} ; "		\
-		"if dhcp ${loadaddr} ${update=5Ffilepath}/${update=5Ffilename} ; then "	\
-		"setexpr fw=5Fsz ${filesize} / 0x200 ; "	/* SD block size */ \
-		"mmc write ${loadaddr} ${update=5Foffset} ${fw=5Fsz} ; "	\
-		"fi\0" \
-	"mmcautodetect=3Dyes\0" \
-	"mmcargs=3Dsetenv bootargs console=3D${console} " \
-		"root=3D/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw\0" \
-	"loadimage=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
-	"loadfdt=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdt=5Faddr} ${fdt=5Ffile}\0=
" \
-	"mmcboot=3Decho Booting from mmc ...; " \
-		"run mmcargs; " \
-		"if run loadfdt; then " \
-			"booti ${loadaddr} - ${fdt=5Faddr}; " \
-		"else " \
-			"echo WARN: Cannot load the DT; " \
-		"fi;\0 " \
-	"nfsroot=3D/nfs\0" \
-	"netargs=3Dsetenv bootargs console=3D${console} root=3D/dev/nfs ip=3Ddhcp=
 " \
-		"nfsroot=3D${serverip}:${nfsroot},v3,tcp\0" \
-	"netboot=3Decho Booting from net ...; " \
-		"run netargs; " \
-		"if test ${ip=5Fdyn} =3D yes; then " \
-			"setenv get=5Fcmd dhcp; " \
-		"else " \
-			"setenv get=5Fcmd tftp; " \
-		"fi; " \
-		"${get=5Fcmd} ${loadaddr} ${image}; " \
-		"if ${get=5Fcmd} ${fdt=5Faddr} ${fdt=5Ffile}; then " \
-			"booti ${loadaddr} - ${fdt=5Faddr}; " \
-		"else " \
-			"echo WARN: Cannot load the DT; " \
-		"fi;\0" \
-
 /* Link Definitions */
=20
 #define CFG=5FSYS=5FINIT=5FRAM=5FADDR	0x40000000
--=20
2.25.1

