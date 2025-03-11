Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E72C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 18:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38D8817D3;
	Tue, 11 Mar 2025 19:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QIm7G8Hl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3D08169D; Tue, 11 Mar 2025 15:35:09 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A9E8168B
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5165985d62=cheick.traore@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCMmw7016939;
 Tue, 11 Mar 2025 15:35:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 h19Ur/l+r35cqH+bG9jDzvrIlNis8/R8aZCPMMZkdYY=; b=QIm7G8HljPfMLSlx
 vZVeYh7SesgyedYuq4NACecp9vzF3TtL1JcGAyiDei8ykXoYB1R2mM6XQ4sRfE6l
 kgmdsYu2rYPQvw7ViqjlEiZLnBPKos7nfO9ZjK2Hq8iQc4BiXAqJxF9MRhes1sv+
 hCkIHXYpj1K7Y4gIQv2lGRssCjOJoHYSvcMvTOMgTnHsF1zinoJsKNThrNU86lGV
 talVMb6Tn3HBOEvQQqWoyxzDWRymwenZu1wO2KyW6yQMXal832HX3X7a7SqepkyJ
 jQdhPQyAhRKpWoFscAHVtmlKEULFChItfuvuPtlTMGm0mQ5NENimQHZ+y11sHrNa
 I04fwA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4590b97b0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 15:35:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6CDD240054;
 Tue, 11 Mar 2025 15:33:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B93DE599752;
 Tue, 11 Mar 2025 15:31:29 +0100 (CET)
Received: from localhost (10.48.86.119) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:31:29 +0100
From: Cheick Traore <cheick.traore@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] configs: stm32mp13: Enable MFD timer and PWM for
 stm32mp13_defconfig
Date: Tue, 11 Mar 2025 15:30:36 +0100
Message-ID: <20250311143037.818675-4-cheick.traore@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311143037.818675-1-cheick.traore@foss.st.com>
References: <20250311143037.818675-1-cheick.traore@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.119]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Mailman-Approved-At: Tue, 11 Mar 2025 19:37:25 +0100
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

* CONFIG_MFD_STM32_TIMERS: enables support for the STM32 multifunction
                           timer
* CONFIG_DM_PWM: enables support for pulse-width modulation devices
* CONFIG_CMD_PWM: enables 'pwm' command to control PWM channels
* CONFIG_PWM_STM32: enables support for the STM32 PWM devices

Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

(no changes since v1)

 configs/stm32mp13_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
index 0acd1487c9a..4c6a7f82fe5 100644
--- a/configs/stm32mp13_defconfig
+++ b/configs/stm32mp13_defconfig
@@ -10,6 +10,7 @@ CONFIG_SYS_LOAD_ADDR=0xc2000000
 CONFIG_STM32MP13X=y
 CONFIG_DDR_CACHEABLE_SIZE=0x8000000
 CONFIG_CMD_STM32KEY=y
+CONFIG_MFD_STM32_TIMERS=y
 CONFIG_TARGET_ST_STM32MP13X=y
 CONFIG_ENV_OFFSET_REDUND=0x940000
 CONFIG_CMD_STM32PROG=y
@@ -31,6 +32,7 @@ CONFIG_CMD_UNZIP=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MMC=y
@@ -80,6 +82,8 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_SCMI=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_STM32=y
 CONFIG_RESET_SCMI=y
 CONFIG_DM_RNG=y
 CONFIG_RNG_STM32=y
-- 
2.34.1

