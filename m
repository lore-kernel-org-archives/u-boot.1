Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACDBE674BF
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC63892C6;
	Fri,  1 Nov 2024 10:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t4N9ZuRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA1688F4A; Fri,  1 Nov 2024 10:18:44 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A7989045
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWe0eWopAGIAAOqnI23+p7sVUuMCa2UKMDSGD0v3wEdqVPgNZDlr6ZWfaU7Zf+Z/11TRLCw9mNCp6NbrEEfMgdPXPq7OhxiII+wNz0sXAyx1tfUG44yD3rS59y7cJtNBne+rK86/jh5Jh3TZupLpzcgNJ3Q4/7ycoaHvNapBGOcmr1+WSfHDoWIO/RnujgtFgwNlzsiTKTzw9IP1MPDhWdi3wGrguh4xml4VN7R9iwduNgwj/OrhZRUHFwsCjXDDW0lG+Gqea/RPIOzNv7SP6al6BCj2nn3W1K/FlYBOmGejLMNabiOI4K6WzGWDgSa0eV1rGd9/P4tgROKV896LJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZrmWFozhD34c3nfcrYmGS5bDxBDAcJm17H4tcT9FIc=;
 b=Ueas9Y5BjAJsL9CNcvGguFsdFj1x3zVf/5X9kegPL9DOpuN9Sf1PNt/1pH5KUlAehCjZYSQUBBUz+VBNWAvXeKjG5vBcT21GTBkoLpk6V//F8vRlWoW97E09+nod2JjnX56O4DMyvC/w6//u+PpiP8+P6eMh4WDZN+PZkvcLPuqTB153HPvnC5Qwb2oaiTg+to1UxWFQtOUbLjoARl/OygswcudzIou0xgd95DjlrqR4RTAID9SXGmi3i1cKRHsiHkyjeKrPMM+6mijbqTa39jhRluKeiv2KZ1/bKM4RKOSKhfHQcxNQSjgypZKNaMXDh3PZ6JH413CAK7VKbhZrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZrmWFozhD34c3nfcrYmGS5bDxBDAcJm17H4tcT9FIc=;
 b=t4N9ZuRiqLtaUkwgCKi0EQTv0cLML4tpFh3BOprb8RCl+z2PleVO/PnNi0ObTBsTlGT4VjbO16/gSExTQSPAsUchm1IZv6eauBmo/tMEYuusJXRDM1dvFYgDbsqxLf5sCRtxN51/aOGvy4zBcq+p/FoD5mHKkP/Al13nThFu5Rs=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 09:18:35 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::cd) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Fri, 1 Nov 2024 09:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:18:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:18:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 <neal.frager@amd.com>
CC: Adam Ford <aford173@gmail.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Charlie Johnston
 <charlie.johnston@loftorbital.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
 <csokas.bence@prolan.hu>, Fabio Estevam <festevam@denx.de>, Jonas Karlman
 <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Peter Robinson
 <pbrobinson@gmail.com>, Prasad Kummari <prasad.kummari@amd.com>, "Rayagonda
 Kokatanur" <rayagonda.kokatanur@broadcom.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, "Tom
 Rini" <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 4/7] arm64: zynqmp: Add binman description for SOM
Date: Fri, 1 Nov 2024 10:17:57 +0100
Message-ID: <35bc47a4a4799c5f5dbea56a45340a2810538330.1730452668.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730452668.git.michal.simek@amd.com>
References: <cover.1730452668.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10528; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=oS5L/bGYgjyLIoMmQbtcRILqa42PN9O5k7rYpKn8v/Q=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVOUdUYvd5RrvGfGB95bZyefbRb9eTY6NsznTv3uPGk
 bF3aYJ9RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIvtsM8/22fD5UVshuzj95
 6bvpay+wTClOa2BY0H6H70t/2+xPqR+O1TgeYCuc++jKTQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 483b3610-3c55-4fd3-b0b3-08dcfa562990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yxd83e58nGDvgscR7W50JUy4WceV6Mx389Iq6Zwm3LYyeYbUhJ2NNbeMoW3q?=
 =?us-ascii?Q?uyV90Pi5hJeDi9r/uGPCg7h33hhenycEqCgNR9IUVb5ebTQWNAzhZ2uCPGus?=
 =?us-ascii?Q?YfqNpKkavrBubj0osagWx31KLY//Od+t0rT//rM2VPS4Wi5okMnhPHuwddOV?=
 =?us-ascii?Q?exZmvLCk/rbKe5zZg3Mp+UAzsf2fHRTBY6iWrwKaVCzAMD0cDmvz7h7ciXpM?=
 =?us-ascii?Q?Wz0aENjukroppARbe/n7azoiObj+dA2s2YAfSybM65HeX0cZUioLTzsh/a8V?=
 =?us-ascii?Q?CBZZYAFJFkpQUOciJynypTvqyIUy2HyG20G1DjETrvUlWEJey/yYrJ4a0Iqe?=
 =?us-ascii?Q?Y2goWnFWZcISe4KlKa4/HGbpca/nXyJ/BCCWdfxYnBRYSX6z9Du8urMPTDai?=
 =?us-ascii?Q?LDDjelNdKiFRn38lW4Kt39nw0O4llvE/ORRd99hiIjOjLsxb/S22JlovBhcn?=
 =?us-ascii?Q?pMjy+X2l8HtcctQkFb1fA26Q5EjuaZ1hiav11mdapHhzWwvBeYSg3UoEaQSR?=
 =?us-ascii?Q?bwPYoBdiXf4C/y0+IioDMA4qo2eR8azfqvQNAp3waQpVCUBXf5g6b8S6vBfg?=
 =?us-ascii?Q?AXtXXr6TFjNPdxPysRxKonifCKTZaaMoPxePi4Yj+saK9UR97IA9f8KwMpI7?=
 =?us-ascii?Q?m7ItUHJHL7WG66yK75e6y4uMY+Yo4e1v1bkS/N0dC9MF9XSDAbe2Ejc0PtJC?=
 =?us-ascii?Q?9KV12uojepWQEU4PWqx9zLvM49OefpMprH+T/7MA8fatTMqa78SOV7KBUaoX?=
 =?us-ascii?Q?GzViToGiU4krrmrd3ldY2iBB1THjj6KyfhO2e6y7g56hlVGkl0zbUuyiPonW?=
 =?us-ascii?Q?i+fxWX5s7SEX70mFG3d/puhzCfQjRd2E8OWfVIwVxXiiGUvDZlTV7xTrgGl0?=
 =?us-ascii?Q?Hd/Mdb1OUN0KWcxfMRZ/RU6KO8u2qZnS5kSUzEPSSgnX+arhtFisjD9yfW6n?=
 =?us-ascii?Q?X1UrwXNk28s7cXYxY4h2yLC9j+rc5NDOPP1XispDB17+0q/3zd6kbIUA6fcg?=
 =?us-ascii?Q?z3rA3h8wcdT/CZdaefcShheqbU9I7qxYtLa4/s2zkxXnRXZ2zDFo5v92sY3D?=
 =?us-ascii?Q?QAhd/LqCVe/dnmB9dltiaRkO8kp6KsBRrHJ8JdaxFgHH8qxxdtvy6R+nnv5k?=
 =?us-ascii?Q?xZEuEN+86phDjO9O26dlhIMQn2Zi9lyI3t0f35Lc1J6LCkrfG55qIyCVyCgr?=
 =?us-ascii?Q?DoLnUaDgf6SDpueNpMRDLsFlHsR4fkKFrotPdacFzUmb74zHKn7gFYE4g0q4?=
 =?us-ascii?Q?sD3kaEsEfFUDScw1n+JxsqUVOcaje2ekdU7xkUoWK3N3pWqtFn9BuOmKkEn+?=
 =?us-ascii?Q?ji3BkIQpR34C3wbwrt/f5nlfaU1nOJR7nIu4IbrJKRtW355W96BiENdPyury?=
 =?us-ascii?Q?XMYBpCiOTGRqKm8bQ8zDEYayg/y1jESO7NL9C4fbZU/2J+3Sxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:18:35.0622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483b3610-3c55-4fd3-b0b3-08dcfa562990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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

There is necessary to do some steps to compose boot images. These steps
were in scripts in layers for a while. That's why introduce description via
binman to simplify wiring and remove all scripting around.
This should make sure that everybody is up2date with the latest versions.

The first step is to create fit image with DTBs with descriptions in
configuration node which is written as regular expression to match all SOM
versions.
Description is there for k24 and k26 in spite of low level psu_init
configuration is different. The reason is that it goes to u-boot.itb image
which is the same for k24 and k26.
u-boot.itb is another image which is generated. It is normally generated
via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
be deprecated.
FIT image by purpose is using 64bit addresses to have default option to
move images to high DDR (above 4GB). TF-A and TEE are optional components
but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
by some configurations too.

3rd generated image is boot.bin with updated user field which contains
version number. This image can be used with updated Image Selector
which supports A/B update mechanisms with rollback protection.

4th image is image.bin which binary file which contains boot.bin and
u-boot.itb together and can be programmed via origin Image Selector.
This image can be also used for creating one capsule which contains both
boot images (in SPL boot flow).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Align fit,fdt-list-val to have shorter lines
- Add reference to defconfig
- Rename zynqmp-som-binman.dts to zynqmp-binman-som.dts
- Use conf instead of config
- Change image name from image.bin to qspi.bin
- Remove RFC
- Change default addresses for BL31/BL32

 arch/arm/Kconfig                     |   1 +
 arch/arm/dts/Makefile                |   1 +
 arch/arm/dts/zynqmp-binman-som.dts   | 225 +++++++++++++++++++++++++++
 arch/arm/mach-zynqmp/Kconfig         |  14 ++
 configs/xilinx_zynqmp_kria_defconfig |   3 +
 5 files changed, 244 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-binman-som.dts

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 787f983ffd46..bbf04f301188 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1324,6 +1324,7 @@ config ARCH_ZYNQMP_R5
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP based platform"
 	select ARM64
+	select BINMAN
 	select CLK
 	select DM
 	select DEBUG_UART_BOARD_INIT if SPL && DEBUG_UART
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 253d883d6156..5d28a17b8b8c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -370,6 +370,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kv-g-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kr-g-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kr-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-binman-som.dtb
 
 dtb-$(CONFIG_ARCH_VERSAL) += \
 	versal-mini.dtb \
diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
new file mode 100644
index 000000000000..3d9d8476c98e
--- /dev/null
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP SOMs (k24/k26)
+ *
+ * (C) Copyright 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <config.h>
+
+/dts-v1/;
+/ {
+	binman: binman {
+		multiple-images;
+		fit-dtb.blob {
+			filename = "fit-dtb.blob";
+			pad-byte = <0>;
+			fit {
+				fit,align = <0x8>;
+				fit,external-offset = <0x0>;
+				description = "DTBs for SOMs+CCs";
+				fit,fdt-list-val = "zynqmp-smk-k26-revA", "zynqmp-smk-k26-revA-sck-kr-g-revA",
+						"zynqmp-smk-k26-revA-sck-kr-g-revB", "zynqmp-smk-k26-revA-sck-kv-g-revA",
+						"zynqmp-smk-k26-revA-sck-kv-g-revB", "zynqmp-sm-k26-revA-sck-kv-g-revA",
+						"zynqmp-sm-k26-revA-sck-kv-g-revB", "zynqmp-sm-k26-revA-sck-kr-g-revB",
+						"zynqmp-smk-k24-revA-sck-kd-g-revA", "zynqmp-smk-k24-revA-sck-kv-g-revB",
+						"zynqmp-smk-k24-revA-sck-kr-g-revB", "zynqmp-sm-k24-revA-sck-kd-g-revA",
+						"zynqmp-sm-k24-revA-sck-kv-g-revB", "zynqmp-sm-k24-revA-sck-kr-g-revB";
+
+				images {
+					@fdt-SEQ {
+						description = "NAME";
+						type = "flat_dt";
+						arch = "arm64";
+						compression = "none";
+						hash-1 {
+							algo = "md5";
+						};
+					};
+				};
+				configurations {
+					default = "conf-1";
+					conf-1 {
+						description = "SOM itself";
+						fdt = "fdt-1";
+					};
+					conf-2 {
+						description = "zynqmp-smk-k26-.*-sck-kr-g-revA";
+						fdt = "fdt-2";
+					};
+					conf-3 {
+						description = "zynqmp-smk-k26-.*-sck-kr-g-.*";
+						fdt = "fdt-3";
+					};
+					conf-4 {
+						description = "zynqmp-smk-k26-.*-sck-kv-g-rev[AZ]";
+						fdt = "fdt-4";
+					};
+					conf-5 {
+						description = "zynqmp-smk-k26-.*-sck-kv-g-.*";
+						fdt = "fdt-5";
+					};
+					conf-6 {
+						description = "zynqmp-sm-k26-.*-sck-kv-g-rev[AZ]";
+						fdt = "fdt-6";
+					};
+					conf-7 {
+						description = "zynqmp-sm-k26-.*-sck-kv-g-.*";
+						fdt = "fdt-7";
+					};
+					conf-8 {
+						description = "zynqmp-sm-k26-.*-sck-kr-g-.*";
+						fdt = "fdt-8";
+					};
+					conf-9 {
+						description = "zynqmp-smk-k24-.*-sck-kd-g-.*";
+						fdt = "fdt-9";
+					};
+					conf-10 {
+						description = "zynqmp-smk-k24-.*-sck-kv-g-.*";
+						fdt = "fdt-10";
+					};
+					conf-11 {
+						description = "zynqmp-smk-k24-.*-sck-kr-g-.*";
+						fdt = "fdt-11";
+					};
+					conf-12 {
+						description = "zynqmp-sm-k24-.*-sck-kd-g-.*";
+						fdt = "fdt-12";
+					};
+					conf-13 {
+						description = "zynqmp-sm-k24-.*-sck-kv-g-.*";
+						fdt = "fdt-13";
+					};
+					conf-14 {
+						description = "zynqmp-sm-k24-.*-sck-kr-g-.*";
+						fdt = "fdt-14";
+					};
+				};
+			};
+		};
+
+		/* u-boot.itb generation in a static way */
+		itb {
+			filename = "u-boot.itb";
+			pad-byte = <0>;
+
+			fit {
+				description = "Configuration for Xilinx ZynqMP SoC";
+				fit,align = <0x8>;
+				fit,external-offset = <0x0>;
+				images {
+					uboot {
+						description = "U-Boot (64-bit)";
+						type = "firmware";
+						os = "u-boot";
+						arch = "arm64";
+						compression = "none";
+						load = /bits/ 64 <CONFIG_TEXT_BASE>;
+						entry = /bits/ 64 <CONFIG_TEXT_BASE>;
+						hash {
+							algo = "md5";
+						};
+						u-boot-nodtb {
+						};
+					};
+					atf {
+						description = "Trusted Firmware-A";
+						type = "firmware";
+						os = "arm-trusted-firmware";
+						arch = "arm64";
+						compression = "none";
+						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						hash {
+							algo = "md5";
+						};
+						atf-bl31 {
+							optional;
+						};
+					};
+					tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						tee-os {
+							optional;
+						};
+					};
+					fdt {
+						description = "Multi DTB fit image";
+						type = "flat_dt";
+						arch = "arm64";
+						compression = "none";
+						load = <0x0 0x100000>;
+						hash {
+							algo = "md5";
+						};
+						fdt-blob {
+							filename = "fit-dtb.blob";
+							type = "blob-ext";
+						};
+					};
+				};
+				configurations {
+					default = "conf-1";
+					conf-1 {
+						description = "Multi DTB with TF-A/TEE";
+						firmware = "atf";
+						loadables = "tee", "uboot", "fdt";
+					};
+				};
+			};
+		};
+
+		/* boot.bin generated with version string inside */
+		bootimage {
+			filename = "boot.bin";
+			pad-byte = <0>;
+
+			blob-ext@1 {
+				offset = <0x0>;
+				filename = "spl/boot.bin";
+			};
+			/* Optional version string at offset 0x70 */
+			blob-ext@2 {
+				offset = <0x70>;
+				filename = "version.bin";
+				overlap;
+				optional;
+			};
+			/* Optional version string at offset 0x94 */
+			blob-ext@3 {
+				offset = <0x94>;
+				filename = "version.bin";
+				overlap;
+				optional;
+			};
+		};
+
+#ifdef CONFIG_SYS_SPI_U_BOOT_OFFS
+		/* Full QSPI image for recovery app */
+		image {
+			filename = "qspi.bin";
+			pad-byte = <0>;
+
+			blob-ext@1 {
+				offset = <0x0>;
+				filename = "boot.bin";
+			};
+			blob-ext@2 {
+				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
+				filename = "u-boot.itb";
+			};
+			fdtmap {
+			};
+		};
+#endif
+	};
+};
diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index aea13622b68a..92d61e84319d 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -132,6 +132,20 @@ config SPL_ZYNQMP_RESTORE_JTAG
 	  even if no eFuses were burnt. This option restores the interface if
 	  possible.
 
+config BL31_LOAD_ADDR
+	hex "Load address of BL31 image (mostly TF-A)"
+	default 0xfffea000
+	help
+	  The load address for the BL31 image. This value is used to build the
+	  FIT image header that places BL31 in memory where it will run.
+
+config BL32_LOAD_ADDR
+	hex "Load address of BL32 image (mostly secure OS)"
+	default 0
+	help
+	  The load address for the BL32 image. This value is used to build the
+	  FIT image header that places BL32 in memory where it will run.
+
 config ZYNQ_SDHCI_MAX_FREQ
 	default 200000000
 
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 5757a0c9be9b..6d66a9423797 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -47,6 +47,7 @@ CONFIG_SYS_PBSIZE=2073
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_FS_LOAD_KERNEL_NAME=""
 CONFIG_SPL_FS_LOAD_ARGS_NAME=""
@@ -224,6 +225,8 @@ CONFIG_VIDEO_ZYNQMP_DPSUB=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
-- 
2.43.0

