Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A39CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 20:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7BA848DF;
	Tue,  9 Jun 2026 22:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MLbWtuXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F428496E; Tue,  9 Jun 2026 22:23:04 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C23E88486D
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 22:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-68b5bae70easo865570a12.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781036581; x=1781641381; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D5ku2SObEeruWkrsI0xLKMNmtZUVTZObXnFj75Enwxk=;
 b=MLbWtuXulqLSpFTWBbJZ6VETeNwp8TGvu9nbQY2kPTvfzWMo5k8jYEq4iaMD4RPr+A
 lUGIXn0/L592nP5ytleCEVMYlsPGpGwgO3CS3Le7O3uJbOlnyS1mcXbDDzuEDgO5gML4
 xpEAoSHSAtR4ou+yMPsvuWe5LGfJYh4Lk30a+vhBeCfz0TlnW5H4S/0xLu/5lMwPijM6
 f3wXbA10e0LHQ8jUcwjCMwbrElw+Z3jcwldvLsNpY9/zfTB/iEOhh1t7uCFYY6ViN7As
 7Y22XVREVQ2agqnTALinFsZCfAepk63M2UCYrPOg+eZLnrDUM3cX08hPUYiSekc0Lt+R
 BW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781036581; x=1781641381;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D5ku2SObEeruWkrsI0xLKMNmtZUVTZObXnFj75Enwxk=;
 b=gTow1LQc1y7jKGZZP8KiptCVtxhTMYPwqwQTEqKnnkMJ+dgBnRiMiwdSQPA+oy7QnR
 P0EYMML3oEldiwHXri/gU/JqQbB7WdFXAmJAAcs1jJxKAKjXChgh3GImVNdjE6oHLu0Y
 Xj1UkoyXEdQ/5R2SjfCEuM46w8D7aDJ+ryjDKDCZFMH2kUikrTMLr5/x8OOMejWBTK9h
 i66pKfhl2j0T//ntdvdN/esFkhPvGuoOnsKwJ1BMpIaqoKYK3v9oktBoX6qwNbeIlybp
 iItqBhKKPtrow5c4lUVVhV/igRRlOncONO7sNsrSKuCenok0pzwd7iSf/aAKP+QtDY8G
 yOjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ciVB8Epjmx+XDSz0ta82MEr1W8lisFKHxWQ2qUFprb8N+UlLX+ZTWFwzoTuH5uVC990bXyxg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+xTdgyCKoWjBrXTlSxYZB668bvp66tRCym7Ik38cS2iuLtNLm
 Fnw1KczoCE8mPMlK/THezYcL8htUcAUSUt29fpN92+NC1oEdDJAY1Oqh
X-Gm-Gg: Acq92OEprghJvnP3CoDoGtupvua/r9aFrURFbP/07DIwxfxyF6IRiLOdQ/4ZBznW1/8
 mt33rrSGH/mc2sr62+xYwfwyOKY0ioC9+3xM/NrRn5uoOvdOJ2oZL7kW+ABhHO3I+C0+bvoWaVO
 237D0gwVmTCTiU2vpujAoRJPrOC7hw2o90dU2qnNLD5dsk2p8nSqjBaNHt7X2WWM6WJF6stKbOL
 dvYKYaGBhMB4iYMp7GTascWZ8NLGrvIX3WEry+ORyc6o6x5Ne7/Z+OW9soF9X1/GyecAp23mDzT
 iBEG9LuDY9+suMb4fYeRcKCp1tWr2YIQ3JMKzzdrfbH5KaCv5Tu49UNwMDSpMQ4wmZWmQmiyVrQ
 k2w2SkIeMNDCePjQq982hoxeu78Nf3qqpYkdM0K3k5gk2y/wvCdVcW5uIndGsTJa4VXWmpeO57+
 9VwsEtDJZ3cMGu6oGLvs7R+ijb9QraHjYR8WPB7bjslaoPpK1rGCX6CMw/lAhgZtkQvPJFb+Hs
X-Received: by 2002:a05:6402:4595:b0:68c:4190:fe2 with SMTP id
 4fb4d7f45d1cf-68fa51471d2mr4829777a12.7.1781036580572; 
 Tue, 09 Jun 2026 13:23:00 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05530935csm1077291566b.51.2026.06.09.13.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 13:23:00 -0700 (PDT)
Message-ID: <51cb65e5-1702-467f-b961-c9cdd029056f@gmail.com>
Date: Tue, 9 Jun 2026 22:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/3] rockchip: pinctrl: replace RK_FUNC_n defines
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 u-boot@lists.denx.de
References: <d5752c9d-eca6-4ee4-a0bd-52ffc8103976@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d5752c9d-eca6-4ee4-a0bd-52ffc8103976@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The use of RK_FUNC_n defines is deprecated in the upstream
rockchip.h file. Replace all them by the function number.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/dts/rk3368-sheep.dts             |   2 +-
 doc/develop/driver-model/serial-howto.rst |   4 +-
 drivers/pinctrl/rockchip/pinctrl-rk3568.c | 186 +++++++++++-----------
 include/dt-bindings/pinctrl/rockchip.h    |   6 -
 4 files changed, 96 insertions(+), 102 deletions(-)

diff --git a/arch/arm/dts/rk3368-sheep.dts b/arch/arm/dts/rk3368-sheep.dts
index 120dec1a3de9..723f78b46d53 100644
--- a/arch/arm/dts/rk3368-sheep.dts
+++ b/arch/arm/dts/rk3368-sheep.dts
@@ -250,7 +250,7 @@

 	pmic {
 		pmic_sleep: pmic-sleep {
-			rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
+			rockchip,pins = <0 0 2 &pcfg_pull_none>;
 		};

 		pmic_int: pmic-int {
diff --git a/doc/develop/driver-model/serial-howto.rst b/doc/develop/driver-model/serial-howto.rst
index 17b53e3cabfb..8ca9a016f9a9 100644
--- a/doc/develop/driver-model/serial-howto.rst
+++ b/doc/develop/driver-model/serial-howto.rst
@@ -97,8 +97,8 @@ Here are some things you might need to consider:

            uart2: uart2 {
                uart2_xfer: uart2-xfer {
-                   rockchip,pins = <1 RK_PC2 RK_FUNC_2 &pcfg_pull_up>,
-                         <1 RK_PC3 RK_FUNC_2 &pcfg_pull_none>;
+                   rockchip,pins = <1 RK_PC2 2 &pcfg_pull_up>,
+                         <1 RK_PC3 2 &pcfg_pull_none>;
            };
            ...
        };
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3568.c b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
index c8a91b8bb6e9..f8899443d529 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3568.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
@@ -12,99 +12,99 @@
 #include "pinctrl-rockchip.h"

 static struct rockchip_mux_route_data rk3568_mux_route_data[] = {
-	MR_PMUGRF(RK_GPIO0, RK_PB7, RK_FUNC_1, 0x0110, RK_GENMASK_VAL(1, 0, 0)), /* PWM0 IO mux selection M0 */
-	MR_PMUGRF(RK_GPIO0, RK_PC7, RK_FUNC_2, 0x0110, RK_GENMASK_VAL(1, 0, 1)), /* PWM0 IO mux selection M1 */
-	MR_PMUGRF(RK_GPIO0, RK_PC0, RK_FUNC_1, 0x0110, RK_GENMASK_VAL(3, 2, 0)), /* PWM1 IO mux selection M0 */
-	MR_PMUGRF(RK_GPIO0, RK_PB5, RK_FUNC_4, 0x0110, RK_GENMASK_VAL(3, 2, 1)), /* PWM1 IO mux selection M1 */
-	MR_PMUGRF(RK_GPIO0, RK_PC1, RK_FUNC_1, 0x0110, RK_GENMASK_VAL(5, 4, 0)), /* PWM2 IO mux selection M0 */
-	MR_PMUGRF(RK_GPIO0, RK_PB6, RK_FUNC_4, 0x0110, RK_GENMASK_VAL(5, 4, 1)), /* PWM2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO0, RK_PB3, RK_FUNC_2, 0x0300, RK_GENMASK_VAL(0, 0, 0)), /* CAN0 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PA1, RK_FUNC_4, 0x0300, RK_GENMASK_VAL(0, 0, 1)), /* CAN0 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA1, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(2, 2, 0)), /* CAN1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC3, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(2, 2, 1)), /* CAN1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PB5, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(4, 4, 0)), /* CAN2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PB2, RK_FUNC_4, 0x0300, RK_GENMASK_VAL(4, 4, 1)), /* CAN2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PC4, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(6, 6, 0)), /* EDPDP_HPDIN IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO0, RK_PC2, RK_FUNC_2, 0x0300, RK_GENMASK_VAL(6, 6, 1)), /* EDPDP_HPDIN IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB1, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(8, 8, 0)), /* GMAC1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PA7, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(8, 8, 1)), /* GMAC1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PD1, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(10, 10, 0)), /* HDMITX IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO0, RK_PC7, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(10, 10, 1)), /* HDMITX IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO0, RK_PB6, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(14, 14, 0)), /* I2C2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PB4, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(14, 14, 1)), /* I2C2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA0, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(0, 0, 0)), /* I2C3 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PB6, RK_FUNC_4, 0x0304, RK_GENMASK_VAL(0, 0, 1)), /* I2C3 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PB2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(2, 2, 0)), /* I2C4 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PB1, RK_FUNC_2, 0x0304, RK_GENMASK_VAL(2, 2, 1)), /* I2C4 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB4, RK_FUNC_4, 0x0304, RK_GENMASK_VAL(4, 4, 0)), /* I2C5 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PD0, RK_FUNC_2, 0x0304, RK_GENMASK_VAL(4, 4, 1)), /* I2C5 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB1, RK_FUNC_5, 0x0304, RK_GENMASK_VAL(14, 14, 0)), /* PWM8 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PD5, RK_FUNC_4, 0x0304, RK_GENMASK_VAL(14, 14, 1)), /* PWM8 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB2, RK_FUNC_5, 0x0308, RK_GENMASK_VAL(0, 0, 0)), /* PWM9 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PD6, RK_FUNC_4, 0x0308, RK_GENMASK_VAL(0, 0, 1)), /* PWM9 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB5, RK_FUNC_5, 0x0308, RK_GENMASK_VAL(2, 2, 0)), /* PWM10 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PA1, RK_FUNC_2, 0x0308, RK_GENMASK_VAL(2, 2, 1)), /* PWM10 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB6, RK_FUNC_5, 0x0308, RK_GENMASK_VAL(4, 4, 0)), /* PWM11 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC0, RK_FUNC_3, 0x0308, RK_GENMASK_VAL(4, 4, 1)), /* PWM11 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB7, RK_FUNC_2, 0x0308, RK_GENMASK_VAL(6, 6, 0)), /* PWM12 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC5, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(6, 6, 1)), /* PWM12 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PC0, RK_FUNC_2, 0x0308, RK_GENMASK_VAL(8, 8, 0)), /* PWM13 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC6, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(8, 8, 1)), /* PWM13 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PC4, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(10, 10, 0)), /* PWM14 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(10, 10, 1)), /* PWM14 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PC5, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(12, 12, 0)), /* PWM15 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC3, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(12, 12, 1)), /* PWM15 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_3, 0x0308, RK_GENMASK_VAL(14, 14, 0)), /* SDMMC2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PA5, RK_FUNC_5, 0x0308, RK_GENMASK_VAL(14, 14, 1)), /* SDMMC2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO0, RK_PB5, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(0, 0, 0)), /* SPI0 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD3, RK_FUNC_3, 0x030c, RK_GENMASK_VAL(0, 0, 1)), /* SPI0 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PB5, RK_FUNC_3, 0x030c, RK_GENMASK_VAL(2, 2, 0)), /* SPI1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PC3, RK_FUNC_3, 0x030c, RK_GENMASK_VAL(2, 2, 1)), /* SPI1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PC1, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(4, 4, 0)), /* SPI2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PA0, RK_FUNC_3, 0x030c, RK_GENMASK_VAL(4, 4, 1)), /* SPI2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PB3, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(6, 6, 0)), /* SPI3 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(6, 6, 1)), /* SPI3 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PB4, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(8, 8, 0)), /* UART1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PD6, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(8, 8, 1)), /* UART1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO0, RK_PD1, RK_FUNC_1, 0x030c, RK_GENMASK_VAL(10, 10, 0)), /* UART2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PD5, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(10, 10, 1)), /* UART2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA1, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(12, 12, 0)), /* UART3 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PB7, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(12, 12, 1)), /* UART3 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA6, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(14, 14, 0)), /* UART4 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PB2, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(14, 14, 1)), /* UART4 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PA2, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(0, 0, 0)), /* UART5 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PC2, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(0, 0, 1)), /* UART5 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PA4, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(2, 2, 0)), /* UART6 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PD5, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(2, 2, 1)), /* UART6 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PA6, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(5, 4, 0)), /* UART7 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PC4, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(5, 4, 1)), /* UART7 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PA2, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(5, 4, 2)), /* UART7 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO2, RK_PC5, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(6, 6, 0)), /* UART8 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD7, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(6, 6, 1)), /* UART8 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PB0, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(9, 8, 0)), /* UART9 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC5, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(9, 8, 1)), /* UART9 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PA4, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(9, 8, 2)), /* UART9 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO1, RK_PA2, RK_FUNC_1, 0x0310, RK_GENMASK_VAL(11, 10, 0)), /* I2S1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PC6, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(11, 10, 1)), /* I2S1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PD0, RK_FUNC_5, 0x0310, RK_GENMASK_VAL(11, 10, 2)), /* I2S1 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO2, RK_PC1, RK_FUNC_1, 0x0310, RK_GENMASK_VAL(12, 12, 0)), /* I2S2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PB6, RK_FUNC_5, 0x0310, RK_GENMASK_VAL(12, 12, 1)), /* I2S2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PA2, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(14, 14, 0)), /* I2S3 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_5, 0x0310, RK_GENMASK_VAL(14, 14, 1)), /* I2S3 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA4, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PA6, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PD6, RK_FUNC_5, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PA0, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PC4, RK_FUNC_5, 0x0314, RK_GENMASK_VAL(1, 0, 2)), /* PDM IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO0, RK_PA5, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(3, 2, 0)), /* PCIE20 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD0, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(3, 2, 1)), /* PCIE20 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PB0, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(3, 2, 2)), /* PCIE20 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO0, RK_PA4, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(5, 4, 0)), /* PCIE30X1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD2, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(5, 4, 1)), /* PCIE30X1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA5, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(5, 4, 2)), /* PCIE30X1 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO0, RK_PA6, RK_FUNC_2, 0x0314, RK_GENMASK_VAL(7, 6, 0)), /* PCIE30X2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD4, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(7, 6, 1)), /* PCIE30X2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(7, 6, 2)), /* PCIE30X2 IO mux selection M2 */
+	MR_PMUGRF(RK_GPIO0, RK_PB7, 1, 0x0110, RK_GENMASK_VAL(1, 0, 0)), /* PWM0 IO mux selection M0 */
+	MR_PMUGRF(RK_GPIO0, RK_PC7, 2, 0x0110, RK_GENMASK_VAL(1, 0, 1)), /* PWM0 IO mux selection M1 */
+	MR_PMUGRF(RK_GPIO0, RK_PC0, 1, 0x0110, RK_GENMASK_VAL(3, 2, 0)), /* PWM1 IO mux selection M0 */
+	MR_PMUGRF(RK_GPIO0, RK_PB5, 4, 0x0110, RK_GENMASK_VAL(3, 2, 1)), /* PWM1 IO mux selection M1 */
+	MR_PMUGRF(RK_GPIO0, RK_PC1, 1, 0x0110, RK_GENMASK_VAL(5, 4, 0)), /* PWM2 IO mux selection M0 */
+	MR_PMUGRF(RK_GPIO0, RK_PB6, 4, 0x0110, RK_GENMASK_VAL(5, 4, 1)), /* PWM2 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO0, RK_PB3, 2, 0x0300, RK_GENMASK_VAL(0, 0, 0)), /* CAN0 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO2, RK_PA1, 4, 0x0300, RK_GENMASK_VAL(0, 0, 1)), /* CAN0 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO1, RK_PA1, 3, 0x0300, RK_GENMASK_VAL(2, 2, 0)), /* CAN1 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PC3, 3, 0x0300, RK_GENMASK_VAL(2, 2, 1)), /* CAN1 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO4, RK_PB5, 3, 0x0300, RK_GENMASK_VAL(4, 4, 0)), /* CAN2 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO2, RK_PB2, 4, 0x0300, RK_GENMASK_VAL(4, 4, 1)), /* CAN2 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO4, RK_PC4, 1, 0x0300, RK_GENMASK_VAL(6, 6, 0)), /* EDPDP_HPDIN IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO0, RK_PC2, 2, 0x0300, RK_GENMASK_VAL(6, 6, 1)), /* EDPDP_HPDIN IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PB1, 3, 0x0300, RK_GENMASK_VAL(8, 8, 0)), /* GMAC1 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PA7, 3, 0x0300, RK_GENMASK_VAL(8, 8, 1)), /* GMAC1 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO4, RK_PD1, 1, 0x0300, RK_GENMASK_VAL(10, 10, 0)), /* HDMITX IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO0, RK_PC7, 1, 0x0300, RK_GENMASK_VAL(10, 10, 1)), /* HDMITX IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO0, RK_PB6, 1, 0x0300, RK_GENMASK_VAL(14, 14, 0)), /* I2C2 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PB4, 1, 0x0300, RK_GENMASK_VAL(14, 14, 1)), /* I2C2 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO1, RK_PA0, 1, 0x0304, RK_GENMASK_VAL(0, 0, 0)), /* I2C3 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PB6, 4, 0x0304, RK_GENMASK_VAL(0, 0, 1)), /* I2C3 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO4, RK_PB2, 1, 0x0304, RK_GENMASK_VAL(2, 2, 0)), /* I2C4 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO2, RK_PB1, 2, 0x0304, RK_GENMASK_VAL(2, 2, 1)), /* I2C4 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PB4, 4, 0x0304, RK_GENMASK_VAL(4, 4, 0)), /* I2C5 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PD0, 2, 0x0304, RK_GENMASK_VAL(4, 4, 1)), /* I2C5 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PB1, 5, 0x0304, RK_GENMASK_VAL(14, 14, 0)), /* PWM8 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO1, RK_PD5, 4, 0x0304, RK_GENMASK_VAL(14, 14, 1)), /* PWM8 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PB2, 5, 0x0308, RK_GENMASK_VAL(0, 0, 0)), /* PWM9 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO1, RK_PD6, 4, 0x0308, RK_GENMASK_VAL(0, 0, 1)), /* PWM9 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PB5, 5, 0x0308, RK_GENMASK_VAL(2, 2, 0)), /* PWM10 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO2, RK_PA1, 2, 0x0308, RK_GENMASK_VAL(2, 2, 1)), /* PWM10 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PB6, 5, 0x0308, RK_GENMASK_VAL(4, 4, 0)), /* PWM11 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PC0, 3, 0x0308, RK_GENMASK_VAL(4, 4, 1)), /* PWM11 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PB7, 2, 0x0308, RK_GENMASK_VAL(6, 6, 0)), /* PWM12 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PC5, 1, 0x0308, RK_GENMASK_VAL(6, 6, 1)), /* PWM12 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PC0, 2, 0x0308, RK_GENMASK_VAL(8, 8, 0)), /* PWM13 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PC6, 1, 0x0308, RK_GENMASK_VAL(8, 8, 1)), /* PWM13 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PC4, 1, 0x0308, RK_GENMASK_VAL(10, 10, 0)), /* PWM14 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PC2, 1, 0x0308, RK_GENMASK_VAL(10, 10, 1)), /* PWM14 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PC5, 1, 0x0308, RK_GENMASK_VAL(12, 12, 0)), /* PWM15 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PC3, 1, 0x0308, RK_GENMASK_VAL(12, 12, 1)), /* PWM15 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PD2, 3, 0x0308, RK_GENMASK_VAL(14, 14, 0)), /* SDMMC2 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PA5, 5, 0x0308, RK_GENMASK_VAL(14, 14, 1)), /* SDMMC2 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO0, RK_PB5, 2, 0x030c, RK_GENMASK_VAL(0, 0, 0)), /* SPI0 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO2, RK_PD3, 3, 0x030c, RK_GENMASK_VAL(0, 0, 1)), /* SPI0 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO2, RK_PB5, 3, 0x030c, RK_GENMASK_VAL(2, 2, 0)), /* SPI1 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PC3, 3, 0x030c, RK_GENMASK_VAL(2, 2, 1)), /* SPI1 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO2, RK_PC1, 4, 0x030c, RK_GENMASK_VAL(4, 4, 0)), /* SPI2 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PA0, 3, 0x030c, RK_GENMASK_VAL(4, 4, 1)), /* SPI2 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO4, RK_PB3, 4, 0x030c, RK_GENMASK_VAL(6, 6, 0)), /* SPI3 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PC2, 2, 0x030c, RK_GENMASK_VAL(6, 6, 1)), /* SPI3 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO2, RK_PB4, 2, 0x030c, RK_GENMASK_VAL(8, 8, 0)), /* UART1 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PD6, 4, 0x030c, RK_GENMASK_VAL(8, 8, 1)), /* UART1 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO0, RK_PD1, 1, 0x030c, RK_GENMASK_VAL(10, 10, 0)), /* UART2 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO1, RK_PD5, 2, 0x030c, RK_GENMASK_VAL(10, 10, 1)), /* UART2 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO1, RK_PA1, 2, 0x030c, RK_GENMASK_VAL(12, 12, 0)), /* UART3 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PB7, 4, 0x030c, RK_GENMASK_VAL(12, 12, 1)), /* UART3 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO1, RK_PA6, 2, 0x030c, RK_GENMASK_VAL(14, 14, 0)), /* UART4 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PB2, 4, 0x030c, RK_GENMASK_VAL(14, 14, 1)), /* UART4 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO2, RK_PA2, 3, 0x0310, RK_GENMASK_VAL(0, 0, 0)), /* UART5 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PC2, 4, 0x0310, RK_GENMASK_VAL(0, 0, 1)), /* UART5 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO2, RK_PA4, 3, 0x0310, RK_GENMASK_VAL(2, 2, 0)), /* UART6 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO1, RK_PD5, 3, 0x0310, RK_GENMASK_VAL(2, 2, 1)), /* UART6 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO2, RK_PA6, 3, 0x0310, RK_GENMASK_VAL(5, 4, 0)), /* UART7 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PC4, 4, 0x0310, RK_GENMASK_VAL(5, 4, 1)), /* UART7 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO4, RK_PA2, 4, 0x0310, RK_GENMASK_VAL(5, 4, 2)), /* UART7 IO mux selection M2 */
+	MR_TOPGRF(RK_GPIO2, RK_PC5, 3, 0x0310, RK_GENMASK_VAL(6, 6, 0)), /* UART8 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO2, RK_PD7, 4, 0x0310, RK_GENMASK_VAL(6, 6, 1)), /* UART8 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO2, RK_PB0, 3, 0x0310, RK_GENMASK_VAL(9, 8, 0)), /* UART9 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PC5, 4, 0x0310, RK_GENMASK_VAL(9, 8, 1)), /* UART9 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO4, RK_PA4, 4, 0x0310, RK_GENMASK_VAL(9, 8, 2)), /* UART9 IO mux selection M2 */
+	MR_TOPGRF(RK_GPIO1, RK_PA2, 1, 0x0310, RK_GENMASK_VAL(11, 10, 0)), /* I2S1 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PC6, 4, 0x0310, RK_GENMASK_VAL(11, 10, 1)), /* I2S1 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO2, RK_PD0, 5, 0x0310, RK_GENMASK_VAL(11, 10, 2)), /* I2S1 IO mux selection M2 */
+	MR_TOPGRF(RK_GPIO2, RK_PC1, 1, 0x0310, RK_GENMASK_VAL(12, 12, 0)), /* I2S2 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PB6, 5, 0x0310, RK_GENMASK_VAL(12, 12, 1)), /* I2S2 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PA2, 4, 0x0310, RK_GENMASK_VAL(14, 14, 0)), /* I2S3 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO4, RK_PC2, 5, 0x0310, RK_GENMASK_VAL(14, 14, 1)), /* I2S3 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO1, RK_PA4, 3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO1, RK_PA6, 3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO3, RK_PD6, 5, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO4, RK_PA0, 4, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO3, RK_PC4, 5, 0x0314, RK_GENMASK_VAL(1, 0, 2)), /* PDM IO mux selection M2 */
+	MR_TOPGRF(RK_GPIO0, RK_PA5, 3, 0x0314, RK_GENMASK_VAL(3, 2, 0)), /* PCIE20 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO2, RK_PD0, 4, 0x0314, RK_GENMASK_VAL(3, 2, 1)), /* PCIE20 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO1, RK_PB0, 4, 0x0314, RK_GENMASK_VAL(3, 2, 2)), /* PCIE20 IO mux selection M2 */
+	MR_TOPGRF(RK_GPIO0, RK_PA4, 3, 0x0314, RK_GENMASK_VAL(5, 4, 0)), /* PCIE30X1 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO2, RK_PD2, 4, 0x0314, RK_GENMASK_VAL(5, 4, 1)), /* PCIE30X1 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO1, RK_PA5, 4, 0x0314, RK_GENMASK_VAL(5, 4, 2)), /* PCIE30X1 IO mux selection M2 */
+	MR_TOPGRF(RK_GPIO0, RK_PA6, 2, 0x0314, RK_GENMASK_VAL(7, 6, 0)), /* PCIE30X2 IO mux selection M0 */
+	MR_TOPGRF(RK_GPIO2, RK_PD4, 4, 0x0314, RK_GENMASK_VAL(7, 6, 1)), /* PCIE30X2 IO mux selection M1 */
+	MR_TOPGRF(RK_GPIO4, RK_PC2, 4, 0x0314, RK_GENMASK_VAL(7, 6, 2)), /* PCIE30X2 IO mux selection M2 */
 };

 static int rk3568_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
index 1c28d6cb1fad..1636ec99eb68 100644
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ b/include/dt-bindings/pinctrl/rockchip.h
@@ -50,11 +50,5 @@
 #define RK_PD7		31

 #define RK_FUNC_GPIO	0
-#define RK_FUNC_1	1
-#define RK_FUNC_2	2
-#define RK_FUNC_3	3
-#define RK_FUNC_4	4
-#define RK_FUNC_5	5
-#define RK_FUNC_6	6

 #endif
--
2.39.5

