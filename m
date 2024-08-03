Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CE1C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C0A88CE7;
	Sat,  3 Aug 2024 18:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701720;
	bh=9dkP/xwsyM7sLm9YxPJu+de83u4Igqv3BuJ1ynawShA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e4++8uQ4iMJlsRVU7kgMNTsLi6a7J1XX5Z3sVLFIFQLYRtsyQU+GHAURWYNEdrVWx
	 zwho6ctMRJfwDVougTnj5CsGq92HmY4bYnB+cwUGpJF+5k1F9CYRjKOLMmidG5USYj
	 dK7ussX0a2NZSuBXuoNYMqKv0JnRKnFEO97FpsxlztDfh82mQ7ptSpx7V0dJMVWQ5b
	 n4BTiN8qpU8IRKxLW5Nfz0cnvri8Nb2WiJFIzKHU9G62yY/TangcoI09zWOoScbaIj
	 Bq0+0RMlx+iO08drUlVDyHnlDcMhaI9GxPyi+VHGKPPO490FDrSnzdxfxVMf4S4Eyn
	 t7uVbaqxpLnYA==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4031088CA8;
 Sat,  3 Aug 2024 18:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701716;
 bh=9dkP/xwsyM7sLm9YxPJu+de83u4Igqv3BuJ1ynawShA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZTDbNRD89qDYKqqKTdd+7BJbgfoc6o+XhkHQDZ3KBud3ZtR5Apw3j8UiVg01UzS2O
 +ImGf1dOR2oxENAtsLp5My4I6W7yqvwdZmbumhndHZgsR5it1/T3Ibpo1zZeqdTGVw
 grIP9KeKZP079PzUUP1PFRZVn6HmIFRXb6yDYRdz/pV+nkomBhh3pdXW6YrjQGGs5M
 vuRVZ8hI48id6jHNAWGHqq2+WE/xGxPUhUpdwcbmbrbGJDfX9eG5JC3SIXXvgW3eqH
 2150an3VU0BaIIRuZamYaGwqY5vI1x0H+YdukTQli9wxy9F39uQJ8vj34ZHkODDZor
 pBoLOXVteU6OA==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Paul Kocialkowski <contact@paulk.fr>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/11] board: sniper: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:11 +0200
Message-Id: <20240803161513.486062-9-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240803161513.486062-1-agust@denx.de>
References: <20240803161513.486062-1-agust@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Conversion to DM_I2C is mandatory, enable DM_I2C
to disable board removal warning. Also enable
OF_UPSTREAM since we do not have a default device
tree.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Cc: Paul Kocialkowski <contact@paulk.fr>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-omap2/omap3/Kconfig | 1 +
 configs/sniper_defconfig          | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
index f15f44fe7d..b56e379ca1 100644
--- a/arch/arm/mach-omap2/omap3/Kconfig
+++ b/arch/arm/mach-omap2/omap3/Kconfig
@@ -115,6 +115,7 @@ config TARGET_SNIPER
 	select OMAP3_GPIO_5
 	select OMAP3_GPIO_6
 	imply CMD_DM
+	imply OF_UPSTREAM
 
 endchoice
 
diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
index 0243b15f31..29e783da8a 100644
--- a/configs/sniper_defconfig
+++ b/configs/sniper_defconfig
@@ -7,6 +7,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4020ff00
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-sniper"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_SNIPER=y
 CONFIG_SPL_STACK=0x4020fffc
@@ -32,12 +33,13 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_I2C_LEGACY=y
+# CONFIG_TI_SYSC is not set
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_SPEED=400000
 CONFIG_TWL4030_INPUT=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_CONS_INDEX=3
-CONFIG_OF_LIBFDT=y
-- 
2.25.1

