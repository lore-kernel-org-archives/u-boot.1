Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB69C7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 17:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4DC82E52;
	Fri, 20 Jun 2025 19:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="vLT4by26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF74982D2B; Fri, 20 Jun 2025 17:55:14 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 133BB82CF8
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 17:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82669a5191=cheick.traore@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KCOCwC017602;
 Fri, 20 Jun 2025 17:55:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 quAC6hdNTCxZvHJDzXdREn00vuWZWPeOeL3lQ3kOfQY=; b=vLT4by26+jjO88v8
 sdHemqKfscwO9/L5gHl+HG6uIogJ7QCP9aW1bmzcbQQXcElLHdtRCh+1y8XyyAkb
 a05IOeZqPWHmxgaB2I/oaqzkYGeXYfR6TORdSZW8+kEosMJLXIlx01xelBV3nqw2
 cwLB9uRCi0jDGMQazjGDwtvCMpIDPvDx+mbUcwb3HHWgcBPv2TqMtg5aL2G3tDEm
 wQbcdLr9PD7Gp3w98TRn00wGAvZSj/yAUkX/4VEihL4e+deEjZqPfubmRR1y96/j
 3mCpSBgZsSlmE9r5WXROsZm8SBKV1OcyVf/rH9qQy9+wS1CIn28BsLVHtlP2kVP4
 jw/yWQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 479m1pkp5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 17:55:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D016C4007D;
 Fri, 20 Jun 2025 17:54:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2DE45B296F8;
 Fri, 20 Jun 2025 17:51:17 +0200 (CEST)
Received: from localhost (10.48.86.135) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 17:51:16 +0200
From: Cheick Traore <cheick.traore@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] configs: stm32mp25: Enable MFD timer and PWM for
 stm32mp25_defconfig
Date: Fri, 20 Jun 2025 17:50:00 +0200
Message-ID: <20250620155000.1258718-4-cheick.traore@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620155000.1258718-1-cheick.traore@foss.st.com>
References: <20250620155000.1258718-1-cheick.traore@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.135]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Mailman-Approved-At: Fri, 20 Jun 2025 19:54:50 +0200
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

Enable the following configs:

- CONFIG_MFD_STM32_TIMERS: enables support for the STM32 multifunction
                           timer
- CONFIG_DM_PWM: enables support for pulse-width modulation devices
- CONFIG_CMD_PWM: enables 'pwm' command to control PWM channels
- CONFIG_PWM_STM32: enables support for the STM32 PWM devices

Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
---

 configs/stm32mp25_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index acb48f4ec72..3be00c6201e 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -24,11 +24,15 @@ CONFIG_SYS_PROMPT="STM32MP> "
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_ADTIMG=y
 # CONFIG_CMD_ELF is not set
+CONFIG_MFD_STM32_TIMERS=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_STM32=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
 # CONFIG_CMD_LOADB is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_CACHE=y
-- 
2.34.1

