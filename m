Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5092EC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 07:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14B466090A;
	Thu, 13 Aug 2026 07:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29kMjT9HofDc; Thu, 13 Aug 2026 07:12:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9FB860A6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786605125;
	bh=S7bjfJOORlEbGetQZvvmpaAKKn+fR0KfPTDuA1WeHQc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ex8k7p0x28huZMmJ/9xOcqlGjqWmVDidaNoiwc+0m2V6DFNuRVKIrP0t9oCtagu/G
	 6VmVZykQ5Fjxsd4bgqbou7Mad649Ma1TOLKVrrstyv2oFJeILbVpbln9DYbJINW2H+
	 GZKqi9h9Jtwj8JOhH9lj3nRlIj+lQ+YmLSNxmddxcwaQvKMQnjNcwe+pPHb/xs7nar
	 5Kk7lSNYr3pGVWHxTDnFdnmXSRFDq7O/Nszw5SQ1EDq9EaSjI0j4K4fUB/D/FrbRgZ
	 w6lytXdk6d2NNmFq8CvUnj6/Mbq7jZ4oV1HXNYiOsvA8KFfyLkkQYrqISmNwoaX4Vt
	 Eqsf2GLbINdGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9FB860A6B;
	Thu, 13 Aug 2026 07:12:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CCFC259
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12B5160AB4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-DQ8JpVQFaz for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 07:12:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C70C4608F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C70C4608F1
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C70C4608F1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1dR4YC+wZujeDARdJDi5Wfi1QZkqvETVaiWYzYSI5tm11n8Bu/MCa+h8hWBrhI/3RU5p/+WI7n1+87xEqV/QYOcA0hWC28jBPJUtSXmvcXjk9GPIvXWU5JT7D5CzT0bys2uFgdcBteZJQ4dB8OHk5Ogf5yhhkgiHwvQzI6hwrYGok5xWWZ3/9N5UyVR12+rvP4BSoYF+L4n7WE0MTIlkk/eNTrZXRyXrFPLJaxnscVbv9FPF3Y/87VhxRTpAfW6c2xGSCwCEd3sQ/FogMAwCjDmhek3hNXCfwh9Xt32THYX3uT2g9BSAClNRBz6m8CGs7+7vYLn/dECi8H6pWzHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7bjfJOORlEbGetQZvvmpaAKKn+fR0KfPTDuA1WeHQc=;
 b=mY8AerJI7e7OZinvGXZCDg5/r5taZXc3+t/0sD+1vAjCiafeWrL2PsMwTjjULwwQ2fnXeSz4p8tMlHNNfz3V79lj7a7bUDgKIhFlm6Z2puMUcLOHzAgcuGWwpexZaVKlvJGhgI9UTAyLzp6ehIyOHioscGOK1T8K7ZQDS6EpO/TarVomv1dbVoVVobmCXbKyDZ92ZIQukD9JEFub1ul4yL4lxyWQom4FlcgKQwZjFQcp+c3pnafM0mK5XjMT3BsuHsCFlXkJo4KUU0a/pA11f185JDJnawcfityR4sftK/uD+as5Qm8LO4wmw0U4/tdjI3vKn4L1SltMWt4SIVn2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from SJ0PR05CA0142.namprd05.prod.outlook.com (2603:10b6:a03:33d::27)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 07:11:56 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::6c) by SJ0PR05CA0142.outlook.office365.com
 (2603:10b6:a03:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 07:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 13 Aug 2026 07:11:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 02:11:53 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 02:11:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] MAINTAINERS: Remove references to not existing files
Date: Thu, 13 Aug 2026 09:11:17 +0200
Message-ID: <ac8e1f589ad13aa2b9cc21bbb12b7d9acf3fcaea.1786605072.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786605072.git.michal.simek@amd.com>
References: <cover.1786605072.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8574; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=m3dn/myYggEChaKUW5Kz+E7dFBpk0FEXh9E6KmSqtG8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTV5mn3nfeNL325Zne41IM3R3ZPvvLcJPnnjcbMjzOZw
 zXPz/2X1VHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATOdzH8D9qeeLdVSsYztSt
 +7lO84uj1In9Z8WyPRf+ErnbJbjxeaA2wz8z138bC3lEze7HBt6/duh2StwbgXUbF99gj5dsNgk
 282QEAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f336c09-a0b6-420c-67e3-08def90a2842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dHepVXDHx8JFnhda64dmviP9x/XUutO+b3PtZU2sGXMXCXG4IZlRMw4ZOvszulrmjjaKrhegN2WRHjHqUVMEvVukIYOb5D+C0FxNiKe0erW4f/MdU2ngQHLRBVPltZdgmTnQIy5hlGRFwnoMzOo6iH4LEUuHfUdBaaDfev1r3hRL2sMfpczxTDDjT4gLbuzDEdCUFhJvW5nEPf+9skqPjE1k3ATZ2xsiXu7RYw8ZN5g8TX/Q+7dtAdieEx4PMf8p1fZ6MZMN9a/RN25mdv8Jkdj4TN/AFB4MXYjbmGgQdneqAJhRLim1BoZ6whcEZvlSIweYnqOXljVgFJ6/f9oeo5SHuEzzn0pLGZqrmmVH7JEp7nUss5xXQW+7QYO/L1MFy4IID4Erql65PcdWWPly1AxTZXUSccxIlmWP4g79n04HZOS+s/zcj0lzw2pcyoDGZNBzIZnjLGPvrlfmkccedtVOUirakyF2Zh+PAW3m/SvkzzZX8H0tH4b4qlcwH06W5n4zo8vRh3gTuITHJwPqJQ5rRpqQsAvJOdaujhHH2uw3wXdoqA7FP+Yo7CbyIVD2oCprR3UihOKboSuT3f9QvrgiEpZoYhLpRr0ecBe8mhgC4DxxFvsRsWHfu/vQYZhWnnSNY6jrvSWzjQawKB3Q7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UsXZEtxQyZUgNTiKbjpcsc61v4Ij2qYoThgzyu4gugvzqWscmaUESAYQjL4kI+P+XK92A0xaR/e84LDCetLKCv/IQzm9aRHcQLYziYQ0JUFix+WDkCzhIc8tf6IIaoBc8YKYPfOfILfTmYgXchIb61LOBvyVgknJz5izDizbI4JoePCLHC7xprrR+mpWu9jqKHDUeSih0KxQpr54193vH9oKHsCLWLtkY8ZukzKAj59/vFafMO4Wo0cUQYJFUBgKDjvwdFbOFtXQGqGNSCVKdrT+T7TleClOZX6Qb9szypDKSiXHZYibNvV606mN/aW+LldHca4eR43wZKqMaK60XT8gjP40IN58FzhqtBkNCb5bPmeKOp8zAZYDTqztRxFbM3uJIuZBg8KXSAHLFpjW0rcHEeuDLbefmB3sPGVys5CUR59LwDEzsrxrX6T2JX9l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:11:55.2348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f336c09-a0b6-420c-67e3-08def90a2842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7bjfJOORlEbGetQZvvmpaAKKn+fR0KfPTDuA1WeHQc=;
 b=X/lT8gWSYoQVePjVkyPfV2Fx7ugzkWFfSx3NVokegkta+itoce+l90MrTQKkv+NL5PhvXZNqoZEGjBZ/wR4L5ekqIbePCoshbolq8Zy1MgBncT9dPtCyD7v4YZcr8hxjnmEKGR1Klife4uNYsPzAZ5HFycBTsmV6jp06bpnyHaE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=X/lT8gWS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A number of file (F:) entries in MAINTAINERS pointed to files or
directories which had been removed or renamed over time.
Remove all of these stale references so every F: entry resolves to an
existing path.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS | 45 ---------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb48eea55c5a..80e83af678b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -127,7 +127,6 @@ ARC HSDK RESET
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
 L:	uboot-snps-arc@synopsys.com
-F:	include/dt-bindings/reset/snps,hsdk-reset.h
 F:	drivers/reset/reset-hsdk.c
 
 ARC SYNOPSYS DW MMC EXTENSIONS
@@ -156,7 +155,6 @@ F:	drivers/pinctrl/pinctrl-apple.c
 F:	drivers/power/domain/apple-pmgr.c
 F:	drivers/spi/apple_spi.c
 F:	drivers/watchdog/apple_wdt.c
-F:	include/configs/apple.h
 
 ARM
 M:	Tom Rini <trini@konsulko.com>
@@ -248,7 +246,6 @@ F:	drivers/serial/serial_bcm283x_mu.c
 F:	drivers/serial/serial_bcm283x_pl011.c
 F:	drivers/video/bcm2835.c
 F:	include/dm/platform_data/serial_bcm283x_mu.h
-F:	include/dt-bindings/pinctrl/bcm2835.h
 F:	drivers/pinctrl/broadcom/
 F:	configs/rpi_*
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-arm.git
@@ -284,7 +281,6 @@ S:	Maintained
 F:	arch/arm/mach-bcmstb/
 F:	board/broadcom/bcmstb/
 F:	configs/bcm7*_defconfig
-F:	doc/README.bcm7xxx
 F:	drivers/mmc/bcmstb_sdhci.c
 F:	drivers/spi/bcmstb_spi.c
 
@@ -349,9 +345,7 @@ ARM IPQ40XX
 M:	Robert Marko <robert.marko@sartura.hr>
 S:	Maintained
 F:	arch/arm/mach-ipq40xx/
-F:	include/dt-bindings/clock/qcom,gcc-ipq4019.h
 F:	drivers/clk/qcom/clock-ipq4019.c
-F:	drivers/phy/phy-qcom-ipq4019-usb.c
 F:	drivers/spi/spi-qup.c
 F:	drivers/net/mdio-ipq4019.c
 F:	drivers/rng/msm_rng.c
@@ -439,7 +433,6 @@ S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-at91.git
 F:	arch/arm/dts/sam*
 F:	drivers/misc/microchip_flexcom.c
-F:	include/dt-bindings/sound/microchip,pdmc.h
 F:	drivers/timer/mchp-pit64b-timer.c
 N:	at91
 N:	atmel
@@ -464,7 +457,6 @@ F:	configs/s5p4418_nanopi2_defconfig
 F:	doc/README.s5p4418
 F:	drivers/gpio/nx_gpio.c
 F:	drivers/i2c/nx_i2c.c
-F:	drivers/mmc/nexell_dw_mmc_dm.c
 F:	drivers/pinctrl/nexell/
 F:	drivers/serial/serial_s5p4418_pl011.c
 F:	drivers/video/nexell/
@@ -620,11 +612,8 @@ L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon.git
 F:	configs/qcm6490_defconfig
-F:	configs/qcs9100_defconfig
-F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
-F:	drivers/phy/msm8916-usbh-phy.c
 F:	drivers/phy/qcom/
 F:	drivers/serial/serial_msm.c
 F:	drivers/serial/serial_msm_geni.c
@@ -648,10 +637,6 @@ F:	drivers/reset/sti-reset.c
 F:	drivers/serial/serial_sti_asc.c
 F:	drivers/sysreset/sysreset_sti.c
 F:	drivers/timer/arm_global_timer.c
-F:	drivers/usb/host/dwc3-sti.c
-F:	include/dt-bindings/clock/stih407-clks.h
-F:	include/dt-bindings/clock/stih410-clks.h
-F:	include/dt-bindings/reset/stih407-resets.h
 
 ARM STM STM32MP
 M:	Patrick Delaunay <patrick.delaunay@foss.st.com>
@@ -667,7 +652,6 @@ F:	drivers/gpio/stm32_gpio.c
 F:	drivers/hwspinlock/stm32_hwspinlock.c
 F:	drivers/i2c/stm32f7_i2c.c
 F:	drivers/mailbox/stm32-ipcc.c
-F:	drivers/memory/stm32-omm.c
 F:	drivers/misc/stm32mp_fuse.c
 F:	drivers/misc/stm32_rcc.c
 F:	drivers/mmc/stm32_sdmmc2.c
@@ -690,10 +674,7 @@ F:	drivers/spi/stm32_spi.c
 F:	drivers/video/stm32/stm32_ltdc.c
 F:	drivers/video/stm32/stm32_lvds.c
 F:	drivers/watchdog/stm32mp_wdt.c
-F:	include/dt-bindings/clock/stm32fx-clock.h
 F:	include/dt-bindings/clock/stm32mp*
-F:	include/dt-bindings/pinctrl/stm32-pinfunc.h
-F:	include/dt-bindings/reset/stm32mp*
 F:	include/stm32_rcc.h
 F:	tools/logos/st.bmp
 F:	tools/stm32image.c
@@ -745,7 +726,6 @@ F:	drivers/firmware/ti_sci.*
 F:	drivers/gpio/omap_gpio.c
 F:	drivers/memory/ti-aemif.c
 F:	drivers/misc/k3_avs.c
-F:	drivers/mailbox/k3-sec-procy.c
 F:	drivers/pci/pcie_cdns_ti.c
 F:	drivers/pci/pcie_dw_ti.c
 F:	drivers/phy/keystone-usb-phy.c
@@ -756,7 +736,6 @@ F:	drivers/ram/k3*
 F:	drivers/ram/k3*/
 F:	drivers/remoteproc/ipu_rproc.c
 F:	drivers/remoteproc/k3_system_controller.c
-F:	drivers/remoteproc/pruc_rpoc.c
 F:	drivers/remoteproc/ti*
 F:	drivers/reset/reset-dra7.c
 F:	drivers/reset/reset-ti-sci.c
@@ -901,19 +880,14 @@ S:	Maintained
 F:	boot/bootdev*.c
 F:	boot/bootflow.c
 F:	boot/bootmeth*.c
-F:	boot/bootstd.c
 F:	cmd/bootdev.c
 F:	cmd/bootflow.c
 F:	doc/develop/bootstd/
-F:	doc/usage/bootdev.rst
-F:	doc/usage/bootflow.rst
-F:	doc/usage/bootmeth.rst
 F:	drivers/mmc/mmc_bootdev.c
 F:	include/bootdev.h
 F:	include/bootflow.h
 F:	include/bootmeth.h
 F:	include/bootstd.h
-F:	net/eth_bootdevice.c
 F:	test/boot/
 
 BOOTMETH_ANDROID
@@ -969,7 +943,6 @@ M:	Simon Glass <sjg@chromium.org>
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 S:	Maintained
 F:	cmd/cpu.c
-F:	doc/usage/cpu.rst
 
 CYCLIC
 M:	Stefan Roese <stefan.roese@mailbox.org>
@@ -1007,7 +980,6 @@ DRIVER MODEL
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
-F:	doc/driver-model/
 F:	drivers/core/
 F:	include/dm/
 F:	test/dm/
@@ -1039,7 +1011,6 @@ F:	cmd/nvedit_efi.c
 F:	doc/api/efi.rst
 F:	doc/develop/uefi/*
 F:	doc/mkeficapsule.1
-F:	doc/usage/bootefi.rst
 F:	drivers/rtc/emul_rtc.c
 F:	include/capitalization.h
 F:	include/charset.h
@@ -1054,7 +1025,6 @@ F:	lib/efi*/
 F:	test/lib/efi_*
 F:	test/py/tests/test_efi*
 F:	test/py/tests/test_efi*/
-F:	test/unicode_ut.c
 F:	cmd/bootefi.c
 F:	cmd/efidebug.c
 F:	cmd/nvedit_efi.c
@@ -1140,7 +1110,6 @@ F:	lib/libfdt/
 F:	include/fdt*
 F:	include/linux/libfdt*
 F:	cmd/fdt.c
-F:	common/fdt_support.c
 F:	scripts/dtc-version.sh
 
 FREEBSD
@@ -1256,7 +1225,6 @@ MALI DISPLAY PROCESSORS
 M:	Liviu Dudau <liviu.dudau@foss.arm.com>
 S:	Supported
 T:	git git://github.com/ARM-software/u-boot.git
-F:	drivers/video/mali_dp.c
 F:	drivers/i2c/i2c-versatile.c
 
 MBEDTLS
@@ -1276,7 +1244,6 @@ M:	Michal Simek <monstr@monstr.eu>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	arch/microblaze/
-F:	cmd/mfsl.c
 F:	drivers/gpio/xilinx_gpio.c
 F:	drivers/net/xilinx_axi_emac.c
 F:	drivers/net/xilinx_emaclite.c
@@ -1372,7 +1339,6 @@ MIPS Octeon
 M:	Aaron Williams <awilliams@marvell.com>
 S:	Maintained
 F:	arch/mips/mach-octeon/
-F:	arch/mips/include/asm/arch-octeon/
 F:	arch/mips/dts/mrvl,cn73xx.dtsi
 
 MMC
@@ -1396,9 +1362,7 @@ M:	Jerome Forissier <jerome.forissier@arm.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git
 F:	cmd/lwip/
-F:	cmd/net-lwip.c
 F:	configs/qemu_arm64_lwip_defconfig
-F:	drivers/net/sandbox-lwip.c
 F:	include/net-lwip.h
 F:	lib/lwip/Makefile
 F:	lib/lwip/u-boot/
@@ -1579,7 +1543,6 @@ T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git
 F:	arch/riscv/
 F:	cmd/riscv/
 F:	doc/arch/riscv.rst
-F:	doc/usage/sbi.rst
 F:	drivers/sysreset/sysreset_sbi.c
 F:	drivers/timer/andes_plmt_timer.c
 F:	drivers/timer/riscv_aclint_timer.c
@@ -1625,7 +1588,6 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	arch/sandbox/
 F:	configs/sandbox*
-F:	doc/arch/sandbox.rst
 F:	drivers/*/*sandbox*.c
 F:	include/dt-bindings/*/sandbox*.h
 F:	include/os.h
@@ -1658,7 +1620,6 @@ SETEXPR
 M:	Roland Gaudig <roland.gaudig@weidmueller.com>
 S:	Maintained
 F:	cmd/printf.c
-F:	doc/usage/setexpr.rst
 
 SH
 M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
@@ -1740,7 +1701,6 @@ S:	Maintained
 F:	cmd/sqfs.c
 F:	common/spl/spl_squashfs.c
 F:	fs/squashfs/
-F:	include/sqfs.h
 F:	test/py/tests/test_fs/test_squashfs/
 
 STACKPROTECTOR
@@ -1914,7 +1874,6 @@ VBE
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	boot/vbe*
-F:	common/spl_reloc.c
 F:	include/vbe.h
 
 VIDEO
@@ -1929,9 +1888,6 @@ M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	drivers/virtio/
 F:	cmd/virtio.c
-F:	include/config/virtio/
-F:	include/config/virtio.h
-F:	include/config/cmd/virtio.h
 F:	include/virtio*.h
 F:	test/dm/virtio.c
 F:	doc/develop/driver-model/virtio.rst
@@ -1978,7 +1934,6 @@ M:	Roger Knecht <rknecht@pm.me>
 S:	Maintained
 F:	cmd/xxd.c
 F:	doc/usage/cmd/xxd.rst
-F:	test/py/tests/test_xxd/
 
 THE REST
 M:	Tom Rini <trini@konsulko.com>
-- 
2.43.0

