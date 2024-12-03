Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34BDD73619
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41FDB8962A;
	Tue,  3 Dec 2024 10:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="GePO6lL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74A38962B; Tue,  3 Dec 2024 10:42:42 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75409895D0
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irtlQu8Lgns65X33Qys0QEIpeMpse2FSPMbIKJbAW5ZJze0MMqy5UJOVapdGcZmD05fo1IQ2aov67jRilQWr5Ymj0UD/l+nBV4PfjAZlMsZEuZsVDlVAf7hljOrFAtqJ9uk5VEt31tx5MfSZqeszDniruC2sSNff59kjiYjo3Z2KSkyUcZXpSsw3U5/kjTDlGRkZ+1WcRINXdUIdu2YrU2BoWfq9+g3kXllcpug6itLGj5JLsRyb+TGJPtZYft7EXCsopXjp61FKUFYWxAe9qp+UXmszuwQFHxXFUi23nBHgNzaXAVATKnEh0ri2cx7J8vdiu/fh/Wq4/UWUZr5W0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2jDg+NE6tJlB4u1BHL9Yyw8xY/NrVYnnegKdUONTOU=;
 b=hEHM9XEmyg+oiHELbbTrm7bn7U2LPDm8PoOo/tc+lf4fhbuHc2QniR5lMmf6q7Jl3hOrVgFzCzG+l1gDv9q4/N9H7D0BHSiUcP1KV6cIvMvfpb0iK2tr3xiIl52XUsA5DLuhQeDoW6JpQEVfaFM5F+Qjta6Z1JBZw/LWVI91ROCrtF3W2ai5Td03ar5SOYNOwCZMrVP2mn1XhsNM4tyTfIcAVDfGCG6w3/EjruYD1lPRVJdOuO4nMFN6hy9nK+pSMKhufVJ9J90QYLNRHh8gz0ind6TzrygwwC7Vo3Wy0MvVEfC5oZnI9pguy/DC32NAoVdrvuj/XQsmt9+OYe9hpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2jDg+NE6tJlB4u1BHL9Yyw8xY/NrVYnnegKdUONTOU=;
 b=GePO6lL7NEuZJW41di/RlDNg7m3ukTjDbq6Zwwx39ezfMgHyWBuW3uhf9BWtE15fOaXpOz+UbEw9aO1M3Lmwv6YgC/55dXL9pPd1V/reTbeDfVts2ctwbyYLeQ8YrnBy7duCElHRL91QoIB4zz53oxYQT2ragZ1PkY6DUMDh+8s=
Received: from DUZPR01CA0191.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::20) by GV1P195MB1738.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:59::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 09:42:36 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::5b) by DUZPR01CA0191.outlook.office365.com
 (2603:10a6:10:4b6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 09:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 09:42:36 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:42:35 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:42:35 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Tue, 3 Dec 2024 10:42:35 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024120310423491-266 ; Tue, 3 Dec 2024 10:42:34 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>, <t.remmet@phytec.de>
CC: <Y.Moog@phytec.de>, <B.Hahn@phytec.de>
Subject: [PATCH v3 1/3] phycore_imx8mm: Switch to using env text files
Date: Tue, 3 Dec 2024 10:42:33 +0100
Message-ID: <20241203094235.693693-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 03.12.2024 10:42:34,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 03.12.2024 10:42:35
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|GV1P195MB1738:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ccc928-a729-4813-2858-08dd137ed1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NOIlDfo8Lsd75ElQima7IJ0KtdiDwEy1ycyvrn8SPQsoYVNhq22hr1ryHVnt?=
 =?us-ascii?Q?XlccJ6S0GQXVPV7X8PJOiExwslZ2D3yvJstpCg4zywyoXZzlTfDp1rcj9yhE?=
 =?us-ascii?Q?OQD2wGMOhTR5GOu6Ft3TSNRytYK47QJ0wYrCvVtElteOTo1/P2bF9wpYk/AJ?=
 =?us-ascii?Q?fgz76o+ildPf8kBH51JIoi17MV1EAGSpUrgZmEOneTTuYfTBkBG1teGiwiqm?=
 =?us-ascii?Q?YTh9eDNvuI4hzZ3UY2gGye6Pl1vnLtu6X4UIph/u/8WAMp5oUD8+zHjUQvqM?=
 =?us-ascii?Q?i3U1NwseOgnwomwUpegvjYVpOhPke5xScnuV017aGZ8me78e241xheYgrh0m?=
 =?us-ascii?Q?S+lEV2RfMcP3glTrRr9WCBbqvBoFjeS8CnlBLw+YK3+5IaMtg4Wu/VvFKl5R?=
 =?us-ascii?Q?zMK3eNQStAcYFavRJBjbxzyIHkkHU6XaWQWUVXGyPVU8cHX8XOnQxIsPYKdw?=
 =?us-ascii?Q?ME5kpsQL1K1aQMVsVbR3Z9r+vaKAS64Y5phzRNbgoYSBuoN1Y4lRKp89Pt4s?=
 =?us-ascii?Q?XEenbQ2uye8OkMG6wY6QppAVSNh+BuP9WaggLmuXbbwkvUI3RZobe07kHb3B?=
 =?us-ascii?Q?mnbBuvLmuvT1aFUImekATD8le6ukQoBHA+mPN/kbty8750uVVDR1laCXzxw0?=
 =?us-ascii?Q?mAwH5RfsnYjJKYaw3a3615oannDwrEMRSXj91iDms7TkrqRNcJWvYg3w/2dC?=
 =?us-ascii?Q?Tj1i3qpnHLkFO8uLhUnxsP2xT+2/H7ZMHud/ja4xLy79McW72g1Em76UJj0K?=
 =?us-ascii?Q?7d3q+GZXTELfpArUILHizjWUASbdzo5OaK3HVEurJB3i9fz0Q4OXWponX3Kk?=
 =?us-ascii?Q?QRHJ3uq9TD2iaYBTZcAz2oReJskf/Y+RU9RtyPhJ3N+ERBx0FolZkd6jZKas?=
 =?us-ascii?Q?S6GxWL8W0/lGSW5LXtAuYv2Ux3eqbZtd2D0ajDiImszQaLqnoqG3R3GuV6kc?=
 =?us-ascii?Q?g5DePYxlO54OP02EUAaCYJCzELheVJJ0+lH/LKUpjJm0sWpnHKmykwpNZSVC?=
 =?us-ascii?Q?KfXZjOXu4MbyV/OaRhvysX4um+nRmmuyBMpMBuyLOsG9wHJ1xC/jKTlmacyp?=
 =?us-ascii?Q?Rcw+PdWeUbLUEKKS++OJN2qVsPYAtzFQe6DBqdR5uoP20xf6tl6T6Xsefz5s?=
 =?us-ascii?Q?EhI1xJSYjiUt6UAhmpFXC5fOrk9NcjeX4s3PuiCZIcmkIk8mpcNR4hwjWPKt?=
 =?us-ascii?Q?e6LQfCnK6Qfoq6rXKnFgMrbDb/FJxxtnRxsYVg6GBWWefbCCuzjWmdtGQDZb?=
 =?us-ascii?Q?BmbDARAvxT9LyeO/IzAn40lE1nlvlHlUGMh0m6MXeA298Yp0M76ItFQRAXqV?=
 =?us-ascii?Q?B1FxH0fwpI3XMOpti1Ursl4+EUg5WzQIiopcvTc88R/Xx1dm+5rLIisY86lY?=
 =?us-ascii?Q?voil7meiVHP6FmNKki9YicxjSszsTVltvYx1ntBDosTMKC43/c5dTht7SFsR?=
 =?us-ascii?Q?jBSrTqdQcWkRdrAetEFCqLYcueJYOsvF?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:42:36.3002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ccc928-a729-4813-2858-08dd137ed1d4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1738
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
Changes in v3:
- Removed sd=5Fdev entry
- Added Maintainers and reviewers
- Added changes description
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

