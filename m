Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC54E7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 23:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC87800D2;
	Mon, 16 Dec 2024 00:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734305448;
	bh=ItvedxVomU3cBEwoxbDlTXeBipLix66jfwi9jyRb32E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Srs4lWC/yM3m4A5sy+flck2AcDM7YBTr94UiE1723WvglTMhtpxtV6TNiCdwjYJ0q
	 Njm5vU22MKTfv4QCNVJJIx8hYhTiWZ18uc88LXHfoICcTotERmYz+9+ay9lcqTJ5+j
	 E3IjONkahSKXAX9Csf/+UleNaf8iCDbDC7GdlUtvYplyrs5AyhdImsHyPHIfptSiNk
	 lq5Ydv/R0NjePQO47JtJWNHceSjusnHwTg0wzl0e56an6KaVWZV2hlSzxdQEjvXozQ
	 IbnyjZ3WWoixFc2ptsaW0CrHpSF45ztIy5fCuitFDtUVWMZD9HepoXOaID/Lpfbglr
	 TnpUOdOc08Mgg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE3C801EE; Mon, 16 Dec 2024 00:30:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4488180137
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="d6qPHr/Q"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EE03B1049AF75; Mon, 16 Dec 2024 00:30:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734305443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItvedxVomU3cBEwoxbDlTXeBipLix66jfwi9jyRb32E=;
 b=d6qPHr/QQIwibEe+STAgjfSZYx0CdVxOwWyhFh7/PT1YM5ZVvkvSgsN5CMNRI75gOv/2x2
 9b/uQehtXnLRDOyq8BG8LgL6PmTmkPMNYv0uIt2xpzgK7bHANaxsP72PxHTqWM7jlruGjm
 UbmqZfhDkStFdtowZuEKkLUhRkX9WBaDwjLOe7q5u8OKHncfAz1GkOhjN0iR3ti6oT4RK2
 xVCkv8lJOodiSTswP1P17GFvCEwe+KYIqQYh+QSJCcXWymsri6RLE1nOwvbQnrHDmuIPAm
 OFiPIrZOof5v19oyp7C6bNLFIHWXgQ23Bzc/9mz7nfjSjGu8JWc9BJEQZWBjjA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/4] ARM: dts: stm32: Drop access-controllers from SPL DT on
 DH STM32MP15xx DHSOM
Date: Mon, 16 Dec 2024 00:29:14 +0100
Message-ID: <20241215233011.569287-3-marex@denx.de>
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

The access-controllers DT property is not useful in STM32MP15xx SPL,
remove it to reduce SPL control DT size. No functional change.

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
 configs/stm32mp15_dhcom_basic_defconfig | 2 +-
 configs/stm32mp15_dhcor_basic_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index b730bf76dca..5add66fb2f4 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -7,5 +7,5 @@ CONFIG_SYS_MEMTEST_START=0xc0000000
 CONFIG_SYS_MEMTEST_END=0xc4000000
 CONFIG_SYS_I2C_EEPROM_BUS=3
 CONFIG_OF_LIST="st/stm32mp157c-dhcom-pdk2 st/stm32mp153c-dhcom-drc02 st/stm32mp157c-dhcom-picoitx"
-CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
+CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index 42a596505ca..dd14db3b4c5 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_STM32MP=y
 CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp157a-dhcor-avenger96"
 CONFIG_SYS_I2C_EEPROM_BUS=2
 CONFIG_OF_LIST="st/stm32mp157a-dhcor-avenger96 st/stm32mp151a-dhcor-testbench st/stm32mp153c-dhcor-drc-compact"
-CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
+CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
 CONFIG_SYS_I2C_EEPROM_ADDR=0x53
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
-- 
2.45.2

