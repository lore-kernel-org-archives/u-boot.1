Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85946D4979A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3038964A;
	Tue,  3 Dec 2024 10:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="PUyK2Mj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10312895D0; Tue,  3 Dec 2024 10:42:43 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0187F8962A
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0TXkuN1NpFfnr9Yr+mv3GfyWEXpgXltrRYHTbJj75WSlkSGI5xslkaP8m4qDhrYcZ7o/phhbidvGdVYhWLsi/+oCQOQmZHtQ2MbasGsevlZ+4UyGpQDSQrGEILE9K2n0sUepHLtBSapAQylCYP15H4sivLAHN9KqxHGnJXvkcyuzSH14wsQbgwRCpnbn/sbxRemvp9d8TdUO3tuCESxrDQddmYr1+kb7IUC8sg8FL44ugoG5OqTZfJDP0v8qe/ecONysdfird13UmHPDg6BSRdjoKKGKwtG/mx1aFRViPt9X5uxUhsjJYY3jMBrs5JPAe2BGkUOz4HXpLQ3NuAHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgprThQqkN8F8UMQ5MW3Avii1vhQ6D4M4TWyCNQB/tI=;
 b=do2QvqJQVInYkAOQ6V7oYDXrLTu9cLrIBS1XW7qlMZv2eiyywASFIEfif6C9hNE8+FjiyneWBKLgCz3GaqBmdQyeADuQdamgxCF4qfVnO/tRvh1giwkHzz0TKLrn4jYovS5/SCDwqwcqTMkbKnYPctWCvTlqGK6SByKKAr6KDXZES3wEAJoVn72M4sU6An9+ckYKOaNi+PL3P0Y9q9z+ZgF8FwNQ6TjIpOz4XKyS8KOHX8pO0ivMAeO4XoIMwnxc/3W3i9JLbJA2EibJ9Epj0dxCpPKG8pMFtZnd+R4GiUT3cha+caQUWBcRUlXa8ftR9Urf6EB9arx3wKiHNUhkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgprThQqkN8F8UMQ5MW3Avii1vhQ6D4M4TWyCNQB/tI=;
 b=PUyK2Mj/ZFmp08LJS9nJ69rfLC/ELGLRr3w/6y1GImhBwMAbGYl2SGjthY43AWL4CKaGS4x3Df8XHYuVBsTxOxl6txtczpeZ6VOU7/9MVj0yT6vLc/GatgZK3I+B8AnynGeHVMnsvcsXkMQZ87O1zwm47/VB2N2oR2KlJBCG60o=
Received: from DUZPR01CA0198.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::29) by GVXP195MB2644.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:1fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 09:42:37 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::33) by DUZPR01CA0198.outlook.office365.com
 (2603:10a6:10:4b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 09:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 09:42:37 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:42:36 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:42:35 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Tue, 3 Dec 2024 10:42:35 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024120310423494-267 ; Tue, 3 Dec 2024 10:42:34 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>, <t.remmet@phytec.de>
CC: <Y.Moog@phytec.de>, <B.Hahn@phytec.de>
Subject: [PATCH v3 2/3] phycore_imx8mm: Move default bootcmd to board env
Date: Tue, 3 Dec 2024 10:42:34 +0100
Message-ID: <20241203094235.693693-2-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203094235.693693-1-y.bas@phytec.de>
References: <20241203094235.693693-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 03.12.2024 10:42:35,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 03.12.2024 10:42:35
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|GVXP195MB2644:EE_
X-MS-Office365-Filtering-Correlation-Id: a25c4ac4-f98f-4729-d2ed-08dd137ed260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ZuXRGo1aUtKPBCGFarSpzkbBfHcPimf2hK9V+RmQtz7qUx/aLetT7IM69Mq?=
 =?us-ascii?Q?4IM2qcF1jF8OnWHXJab9hiBCYHWjzjQxAN+NmpajVxk9Zf8FMjA1NgNqwZ3w?=
 =?us-ascii?Q?Ovcrm7bC7EMmncivN2kJ38rFlaU6dmJxV6qJ4vvqtCUU6hRmLtz1G3k8982T?=
 =?us-ascii?Q?vdVrxoBYEW8hukv0JCM9oD/fUBp62jf60uNololJtmTNvUJMYVqccOgHdOh3?=
 =?us-ascii?Q?pfeF+0a3GrB7D3T9PdzhyAb3aHkmQ6GnQYebzdp40a8pDTaf309Nyoi9pTWX?=
 =?us-ascii?Q?HbQE4z22j0jkXa9GRYO2P24sCOAw3ZfcGsCjkLsLvfECL0MH5FvU9BdrGJoH?=
 =?us-ascii?Q?ctnnx6/IUH/Bhr/S0y6EN/D/C+AvE0gqEWq5psLyweQIMNB+6pC+DfSQBgNX?=
 =?us-ascii?Q?U9Ax3kvAFoSD1vr9Ir58NBrhiCg1fVYJ3iFrHUwk3qJSvtzCa5x06IfwtuH9?=
 =?us-ascii?Q?rSiOwboRLfVf1soE5mEbg92Oxi2YCvEAX0di8bNA6+v80f1wN5OVkq2c1MUr?=
 =?us-ascii?Q?/DKnTBn2Cg6Jv2+P7TUHowswFyTb1yipXruxIt0ZtH32qsAACYa8bdckmiVi?=
 =?us-ascii?Q?xmTwSi2UIG3tDb2C9Yldq1jL7EsqDWlyYjtvCiOAejeEKcm1Ue49CB97LxQ5?=
 =?us-ascii?Q?ik85hUegomVAiglXhM0RVzy6RYhZHGdInVMOcmNm4qW0ma5WE/s7F7mk/OpK?=
 =?us-ascii?Q?qB967OgrX1ZR0DcuGacTmbszhTcbwtalFh+Wa5bB6+qGx0fGbwT3VPn1ol/L?=
 =?us-ascii?Q?vvBSsZMf9DQdPUDJBcDZOZ/gsBEQhUtjMq2pQ8IQ5qYnKCIGFySn6VDSo0Tz?=
 =?us-ascii?Q?em2wlncohELmMESZ2zKzizBl83H3mWvhf2rYMzW8/UAWEJ1Eib9w4Csd4H8v?=
 =?us-ascii?Q?Msjh85MEYhmoWc3iuo6t9u7pRWzMmES8UCz7EWU6HrZkb1cPnD2lmRublIw8?=
 =?us-ascii?Q?7/YzQ17y0f7t2e5D6uECzMb7mpKMbw0+Hv6J8od9v0tcx1v71+ZPJiHmF9Rd?=
 =?us-ascii?Q?8WmiNjw2AFi+GVyf2M775DU8SJAaT+hY5VT+/6bhr4kHSCvymdM14IHmt2Ey?=
 =?us-ascii?Q?BbvI7GdiZUKrfn3VN+2+KeQYCwqR0b6Bij0vF2RZUv0a8P96euQFGYSaq+xN?=
 =?us-ascii?Q?e4+LlGdFjCo0Y7hvvV2c8v9a2SZXbJsHKmtlQnDepM8R+wOG0K0nnAm8Hkiy?=
 =?us-ascii?Q?Ccszv1CsCAPaBm+Tqdt37GNriDrmwe8l96XgG77Q54BZTaQaUs9FTMMhlMIB?=
 =?us-ascii?Q?vw7I3lFys1+E+/gccYAaM+Z8u8DAAyJYkdNhFoJWPIW89LEl7m8MJH7IZmoM?=
 =?us-ascii?Q?+vPTYs5cClf+UI02W6gcRl0EkRadIOWzJVVcFLmhW3DJUt9uaalZX6KKs00A?=
 =?us-ascii?Q?jAjmwNbwfS9rCD3EKJV8xeCV23K/gQ9hkx/yd/1xI+EKTz/67BM3fEEMVyE3?=
 =?us-ascii?Q?g+RQCp6+jxEQbS2fYPbLAwlGuZmG1VsS?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:42:37.2065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a25c4ac4-f98f-4729-d2ed-08dd137ed260
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2644
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
Changes in v3:
- Added Maintainers and reviewers
- Added Changes description
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

