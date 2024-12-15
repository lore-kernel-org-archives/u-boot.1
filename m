Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1C0E7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 23:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD20780212;
	Mon, 16 Dec 2024 00:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734305448;
	bh=59Nlo6jQPJJHAkcJZBb4YNJHHzkhQhfL0pU9Z2Vb3WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pcOHcBB+IzTvUyKuaSg+VdfSzkkuJRdHUvi00xNisJBucqgJUxY7Xo5y2yYAOBWKv
	 v6d86l5UVzbPd8QZz+PyIucraYDmdQf7V9Z0TM1omraz6dRQf1dEP8pEUWOwf+hH/E
	 ns0MfYQeC0WfPNY46K3SQBUZS9QT7NXxPimiKza0sMqSb41jmt9t/Y8vGU6kGYJ6pY
	 JKyv8LtnSjeudvDiHMxGDZReAJ8/wlcwz9U2j5HyoWyFSB8cKMTNhMzdbftSznTOSO
	 xang/GHMPQBMcsOWI2z71hzBcNrDs0P3gOfZzlGgKUOI6l6MBI7keonuvhxJ13GcRy
	 6ZzGmNL9z+P8w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47FB280141; Mon, 16 Dec 2024 00:30:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC7F8005B
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EuNjtDNZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D2BF61049AF76; Mon, 16 Dec 2024 00:30:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734305444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59Nlo6jQPJJHAkcJZBb4YNJHHzkhQhfL0pU9Z2Vb3WA=;
 b=EuNjtDNZ4o8KpWSGeO07p3fRCPdW8Xjv6ass2/RQiVi8UkCSUSoxo6mqRgtdQq7BrqIPKv
 4vdlpK/P0kfs7iotbFZLFf9oJj6vXId+R1bSs9zLoDOc2EwkEy14Cs6VjmmO3LlARa5ZnY
 86SpfxVFXUYcqJVxjhdXvf9C023kFQVyqs1srJwGOXd55BA770VDc/lNjGX7sFztStDXxk
 Zbt+15F+XFgzSa2IxHbDYJ0AUhGCTJfqJa7oTtnFTo9yIUtxrdsOAEYBc0vZPvdPsgoXA6
 Y+sNCE07yybTT+w0iGhl9gfqL1U5Fg0oL8P9BNpuxq8H+sVCaQnqOIk9lKSgPg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 4/4] ARM: dts: stm32: Deduplicate CONFIG_OF_SPL_REMOVE_PROPS
 on DH STM32MP15xx DHSOM
Date: Mon, 16 Dec 2024 00:29:15 +0100
Message-ID: <20241215233011.569287-4-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241215233011.569287-1-marex@denx.de>
References: <20241215233011.569287-1-marex@denx.de>
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

The content of CONFIG_OF_SPL_REMOVE_PROPS is the same in both
STM32MP15xx DHCOM and DHCOR defconfigs, deduplicate the content
into stm32mp15_dhsom.config .

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: For 2025.01
---
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 configs/stm32mp15_dhcom_basic_defconfig | 1 -
 configs/stm32mp15_dhcor_basic_defconfig | 1 -
 configs/stm32mp15_dhsom.config          | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index 5add66fb2f4..a28f2862048 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -7,5 +7,4 @@ CONFIG_SYS_MEMTEST_START=0xc0000000
 CONFIG_SYS_MEMTEST_END=0xc4000000
 CONFIG_SYS_I2C_EEPROM_BUS=3
 CONFIG_OF_LIST="st/stm32mp157c-dhcom-pdk2 st/stm32mp153c-dhcom-drc02 st/stm32mp157c-dhcom-picoitx"
-CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index dd14db3b4c5..f6f2af6e7a2 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_STM32MP=y
 CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp157a-dhcor-avenger96"
 CONFIG_SYS_I2C_EEPROM_BUS=2
 CONFIG_OF_LIST="st/stm32mp157a-dhcor-avenger96 st/stm32mp151a-dhcor-testbench st/stm32mp153c-dhcor-drc-compact"
-CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
 CONFIG_SYS_I2C_EEPROM_ADDR=0x53
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
index 04ee9bfc444..ac3ae82cda9 100644
--- a/configs/stm32mp15_dhsom.config
+++ b/configs/stm32mp15_dhsom.config
@@ -22,6 +22,7 @@ CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_HWSPINLOCK_STM32=y
 CONFIG_KS8851_MLL=y
+CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
 CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PINCTRL_STMFX=y
 CONFIG_REMOTEPROC_STM32_COPRO=y
-- 
2.45.2

