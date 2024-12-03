Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A3EE6689A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F0089649;
	Tue,  3 Dec 2024 10:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="O2qKCf9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26BA89635; Tue,  3 Dec 2024 10:37:48 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::703])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C73F8962A
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9nXr1Zr8+gcnBWdrtHeG8w86YYjvvCXXUPEmTLo8RFhOVwkURL9qgxAtwlDG4QkitDoaWQIwHy+x050eE0tkfPX7FulDxpmpd4H/VhPq75f62cAos9IXvJKq4slAM+sXvSy1Fq/AB6q5e0f4t6nfiQGIBNobHI+CMZ2We/ujRPlBZULkaVnBwJtcmkp0Str6KqhoXk1U1q09bcAMXyKymv/I/AdivmjFO10TGmtTXjYQAA9vcTQYkowMMLV/quYTFUi4MpyngkpiE95pZLfQmRbzPwHc/q7KgFiYaC1jHCqbakwEKbR76wMVnpjR7AL/upyp1nbkPNTJmQBF6Xgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFilcLBzGj3pQFtzZA5vRJwywKX3AKdBk5mYG56GWpw=;
 b=LG2QNNlHlnV5jaJXy0zqiBxEznVvBfD1j1gLCCnB1ur7+CqtUnSQF7pu2lB//LQFPKanINUT2fyCw46mzaaJnmgAl7roFgoW++nuKQTRKxKazOdDxaEjzhowO38HWJNRlAIB8CQR8vydm7RCQitmnNerExZWBYUJx/FRiymk8iBIPJgjLVT1f+AMDWIy3i1VJU4iLv7om1Ah5aGmCxvm+URlEut3gqvaMKHJwss/nO6ZPe+QtdCmUUVBgZzcgrQet82UeSLAlU3nvKWNCt4bBXkoVjec69NPFQpv9sNzZ/ioTFsYw5W+SSYvFq67/PdDhiWOPWn4KigzRDuzzIxekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFilcLBzGj3pQFtzZA5vRJwywKX3AKdBk5mYG56GWpw=;
 b=O2qKCf9zsYgTcsdcXV6MWZ0815Etxu4iOnhM9X+orh6qpizw5BtAA2e3YauAfMG37pl92IpKkpyTPY/eOMxfiKb3bhphnI8prQxmxfCMmJ5E+EVYRjYph1uRrD2vpT3afH2pbJi2ON9ByOKGmUWQtg7Lz4oxrxKCQOuWXOdgpTo=
Received: from DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) by AS1P195MB1517.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 09:37:41 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::3b) by DUZPR01CA0217.outlook.office365.com
 (2603:10a6:10:4b4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 09:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 09:37:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:37:41 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:37:40 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Tue, 3 Dec 2024 10:37:40 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024120310373996-263 ; Tue, 3 Dec 2024 10:37:39 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>, <t.remmet@phytec.de>
CC: <Y.Moog@phytec.de>, <B.Hahn@phytec.de>
Subject: [PATCH v2 1/3] phycore_imx8mm: Switch to using env text files
Date: Tue, 3 Dec 2024 10:37:38 +0100
Message-ID: <20241203093740.693628-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|AS1P195MB1517:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac36b57-f58a-4c84-4d24-08dd137e222d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5HEdmpdG4QRtXN6d4/tKuY1cE//gNSnqpT1KmIn12y5ppa/bk9XgeoKQeyqX?=
 =?us-ascii?Q?TudwoRkH030pWYYfxS1qhwWAKfbyjKcnJx2wXtg95z4ruU1jjYWznmURKYMC?=
 =?us-ascii?Q?C0t41tvDjn9ATfmkDfx8iyV1+YNgRmH0fi3YXfYqGjAyK1oWCwSBvl7LQ2mp?=
 =?us-ascii?Q?AVOZdh1Hh85Dh9IE+utT+pFAqzp/yP2af/H3W2XiPyNiRyEGVWb3u5eyexvM?=
 =?us-ascii?Q?iqCwD8jiKmZGFBmJSKP2XSHi3Yrl+wt6F7oe3ZdJBkDhA8wcYA2IUkCs9uJu?=
 =?us-ascii?Q?MH+EUaQcxbIZwsQTWk3/ILrmFWgkrR26zWNSq5S20FoWNpmvt46dInj6snix?=
 =?us-ascii?Q?Xdl5YA3n9hn0foQt/Ldkw5ZmUXCo1+xnYiO8ovsPgJSNzuJ7AtFbAzQsdR7a?=
 =?us-ascii?Q?Qxl5vJyqcEKYF1yfz8b7akVLsvGmU2QDOMoBSROZPE3rFWVCPiPGbAHVkics?=
 =?us-ascii?Q?SY6OmU2afd33iQEVzcVkuIxXUJQhwObP3wuyUbXhn18OpnjXToHlwF8Ol3Ni?=
 =?us-ascii?Q?u96eu21IyNuMa3THPi/t0f/scX91bR7D2A0nA6OiBpE6pm2gpuvZjDRl4Wwd?=
 =?us-ascii?Q?BwJ8W8B8horLhBhzovpug6NI9pYkT554VL/zsAx43PGOVKRIiUkd7FIjksx7?=
 =?us-ascii?Q?jjk4sx9wxp+qfIlokwxZHQbLVfWjQzLETKqf/Gg1ZrAye5urc3276m5Z1Lv+?=
 =?us-ascii?Q?x69bIQdHQ/CQROvIn6DR309QS7+geDBE5XbGgGzIb0gbssfb5kFgwtH5Cm09?=
 =?us-ascii?Q?imPcvVj8FkdDG3oAq5zObzfXQi5QZ1beB+5MVB/3eykwE5UwxbsuRsDyCX27?=
 =?us-ascii?Q?KMN3Ri2SLnazKnKNElrnEC1YsleRTvrEkz4nDudvTRf7WCIsDGFGnT546J/e?=
 =?us-ascii?Q?VKpDMvbKYR/aG7bjntjPE9xL5neEEk/Y2DFodPV+VDoChzSDTdvRAwEVdB+E?=
 =?us-ascii?Q?vLYDxXK7vZfZYbKitPaIHD+TN3ONZp8+pbWxbT4gBRHVrdYWind/QMByrA7m?=
 =?us-ascii?Q?jEKVdjeZtDwkTH7aw1mi0TYTuenSN9/eXRo7Bqq1t9XkhfBrz7R/dwR+Kgua?=
 =?us-ascii?Q?jhp4JlU3xpP2udGQEh9iRJ+cdg4oVmexGDDexPG2qxZ11VRgGwFc6Of/g4Oh?=
 =?us-ascii?Q?ZAjbCzLilrKXfBJ7QlCLw2k7ywsoDFUAE3MO6K57VXfOlxB+BZymi3+wnBpN?=
 =?us-ascii?Q?vNuvGiYsjkHBp66LZarxSTPN+qnOjGaWcnmUiSHzdwYZR+brAm1FesavBZKX?=
 =?us-ascii?Q?SmURr44fpc+I1DrLoX5yoe03mGnTh3b1JdfHeAY9LrG2oz9i8W9l+1KBwvzI?=
 =?us-ascii?Q?x59C624RlzLfF2HHB/jZU19fV1u/SqUtQppXCA2qqtoriTBaEMuQDoowXTAk?=
 =?us-ascii?Q?wGJ6sL5s6Gg/oAeZI9W7qZCrAN7bYifzRWP9him8leSoGc8acLZvJQRltreC?=
 =?us-ascii?Q?uI6V0r84t5gI2P4uSLrBDez52scNkrEy?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:37:41.6054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac36b57-f58a-4c84-4d24-08dd137e222d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1517
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
 .../phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env  | 51 +++++++++++++++++++
 include/configs/phycore=5Fimx8mm.h              | 46 -----------------
 2 files changed, 51 insertions(+), 46 deletions(-)
 create mode 100644 board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env

diff --git a/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env b/board/phy=
tec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
new file mode 100644
index 00000000000..33a2595fa16
--- /dev/null
+++ b/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
@@ -0,0 +1,51 @@
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

