Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B15C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2BB8205A;
	Thu, 24 Apr 2025 08:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="eha9G06/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571128082A; Thu, 24 Apr 2025 08:08:46 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD5381F0B
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6209a59483=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O60IA6002626;
 Thu, 24 Apr 2025 08:08:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 esOblP3tIuu1hIYV1osuRVThdbjQr6dC9uNoaE3XdYk=; b=eha9G06/ObMkEbAS
 5jEudgCGyR+bSbAL0stipLCKulTDOU0MpZsdX7Oa1j9JOMOPTtn8FFnV9vX7dkkM
 Bea4KHgPMlidOFkkBMLBShKPOTVG6MIygNmvo2NgN1qCSXRXg2qSQs0JAb6eY6KK
 pmFm/Hq1s5agBDMbO1lE3e5Y7ly9A3nFiNzBrIz4S0+bYp/Hs1oqg9h0bK4FqoPU
 JcOa56U9776R5i9W5bNjvlrWODnf5gWrl2Ydme97AhbesoDX7Z0JqeL2ZB5B62s8
 q4RVWYC7R0x/xGruByPfp2+TKu8TzCDctTmGZcZRZbwwi2Fg/HHzoFoQCrmI5NBr
 DvBzww==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jk2e2vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 08:08:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 98E5B40052;
 Thu, 24 Apr 2025 08:08:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC710A4C097;
 Thu, 24 Apr 2025 08:07:52 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:07:52 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/21] arm: stm32mp: disable console for UART serial boot
Date: Thu, 24 Apr 2025 08:07:17 +0200
Message-ID: <20250424060723.2695014-16-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
References: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
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

For UART serial boot, the console need to be deactivated to avoid issue
with tools STM32CubeProgrammer.

This patch adds also the missing dependency for CMD_STM32PROG_SERIAL,
to allow the silent and disable console. This avoid to add is on
board level for STM32MP15 (with TARGET_ST_STM32MP15X or
TARGET_ST_STM32MP13X)

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig |  2 ++
 arch/arm/mach-stm32mp/stm32mp2/cpu.c        | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
index 589276282e4..490097e98be 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
@@ -27,6 +27,8 @@ config CMD_STM32PROG_USB
 config CMD_STM32PROG_SERIAL
 	bool "support stm32prog over UART"
 	depends on CMD_STM32PROG
+	imply DISABLE_CONSOLE
+	imply SILENT_CONSOLE
 	default y
 	help
 		activate the command "stm32prog serial" for STM32MP soc family
diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
index 9548b27cfa7..c3b87d7f981 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
@@ -55,6 +55,19 @@ int arch_cpu_init(void)
 	return 0;
 }
 
+int mach_cpu_init(void)
+{
+	u32 boot_mode;
+
+	boot_mode = get_bootmode();
+
+	if (IS_ENABLED(CONFIG_CMD_STM32PROG_SERIAL) &&
+	    (boot_mode & TAMP_BOOT_DEVICE_MASK) == BOOT_SERIAL_UART)
+		gd->flags |= GD_FLG_SILENT | GD_FLG_DISABLE_CONSOLE;
+
+	return 0;
+}
+
 void enable_caches(void)
 {
 	/* deactivate the data cache, early enabled in arch_cpu_init() */
-- 
2.25.1

