Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0B5C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C67E807C4;
	Fri, 21 Feb 2025 18:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740157750;
	bh=6fZ7OahInrxXuEQvgDUBjlaOxhvyXELO1igRb3OAtPs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sCGpYxE9VcmKmfo8LqAXL1rJpg0x6lXA97B+wISXjiR3Xmmfi1irj21MHqhb69ZCb
	 Zs/hI7lu9BAc9oGQV2HQrg2hCRVULN0b3EG0oGhbtIPUy3gmkbAD89OGROloyGJN/C
	 B4eaW5wvvspImmmle8JuaPwE+WwT7QoNV+f2w2Sh1YpYeyqEwLCN+DF3TfLkcd6fI5
	 qtiXcusiY0FgtVjIKbXvB6fYiRXGPysGh79+3UkkgXR1Hl6AFnzqAo8TEn+w02U2E0
	 rKLLIcUHuj22hNVzWZNZ9aOdK6x6MDlDxurZ1YyD4WsTLMg5fbzL4oMJAF+kbbqpPL
	 bHmhy0PNtCcuA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9090280EC0; Fri, 21 Feb 2025 18:09:08 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92023806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="G+JLVDpR"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9633410382D37; Fri, 21 Feb 2025 18:09:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740157745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6fZ7OahInrxXuEQvgDUBjlaOxhvyXELO1igRb3OAtPs=;
 b=G+JLVDpRv68ZgYODc4luutZ3bOHnWyeHoeEM3UGOlFY7YG+mT3PP4plD2+sO827NilR1lo
 VCAxKJqt8juO/QF8BE96X+blTlhWBjInb1oW3fLHBvTjVc/xMWALljAHZe3QDOj/sw3VtU
 96cdpwIsdbBwh4kLRHPhZPj+Jvkplrevq6XcqpuuqtlyZNCt0Gcqp5vMLy17QE3DbNTIz/
 aCT8B0Ur75AexRYJ7DArBftx6UVQ1LVveRQ8rx/ATIgCx/ah9zSSXmDqGvA1hYcOkoLECX
 PJOgVZkQjo+8ZGxEK6ADr1OTnz7tQQLQNiMnkyJP/A6xuDXGhT19ZRZFolegJQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD update on DH
 STM32MP1 DHSOM
Date: Fri, 21 Feb 2025 18:08:38 +0100
Message-ID: <20250221170851.184893-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The environment is missing closing quotes for string variable, but the
variable is empty on this system, remove the CONFIG_BOOTCOUNT_ALTBOOTCMD
assignment entirely.

Fixes: 940135eea5df ("Kconfig: Move CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 configs/stm32mp13_dhcor_defconfig       | 1 -
 configs/stm32mp15_dhcom_basic_defconfig | 1 -
 configs/stm32mp15_dhcor_basic_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/stm32mp13_dhcor_defconfig b/configs/stm32mp13_dhcor_defconfig
index 4dc3954128d..ff948b904be 100644
--- a/configs/stm32mp13_dhcor_defconfig
+++ b/configs/stm32mp13_dhcor_defconfig
@@ -44,4 +44,3 @@ CONFIG_OPTEE=y
 CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=2000
 CONFIG_ERRNO_STR=y
-CONFIG_BOOTCOUNT_ALTBOOTCMD="
diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index f89c921925d..a28f2862048 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -8,4 +8,3 @@ CONFIG_SYS_MEMTEST_END=0xc4000000
 CONFIG_SYS_I2C_EEPROM_BUS=3
 CONFIG_OF_LIST="st/stm32mp157c-dhcom-pdk2 st/stm32mp153c-dhcom-drc02 st/stm32mp157c-dhcom-picoitx"
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_BOOTCOUNT_ALTBOOTCMD="
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index bde668761b3..f6f2af6e7a2 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -8,4 +8,3 @@ CONFIG_OF_LIST="st/stm32mp157a-dhcor-avenger96 st/stm32mp151a-dhcor-testbench st
 CONFIG_SYS_I2C_EEPROM_ADDR=0x53
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_BOOTCOUNT_ALTBOOTCMD="
-- 
2.47.2

