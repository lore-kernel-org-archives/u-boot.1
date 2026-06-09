Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3606ECD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 20:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC3C284994;
	Tue,  9 Jun 2026 22:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IYUxa9nP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BA88499D; Tue,  9 Jun 2026 22:23:21 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC548498E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 22:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68f0fc103easo684768a12.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781036598; x=1781641398; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QeV4itFy15kA07HKE7wSEjLzXmlOjSYE70GZFqU1Jrs=;
 b=IYUxa9nPrPWqDu0e4mu9GZ4fyoYUm/L/oT36pHQ85WmJW6z+zh+a4tPYbw3qPfTL01
 NHHlQro2pCnNijqCwBaeMIXoLZ9ouwq3VpY9v9nfJZdTOoumMnKk+CfhPODKiN2ghkBU
 oZsSsgeiDsmPULlslZ/JONkcdFPwLMnB1h7QGVqecV90qUVqCEU5BCeZA2eF4E37G5ff
 OVV9s44c3Z2QpARYKWSP1a9KiPBVfQS76T/QSg/0uDpN1dHlVJduRd/vGrisqtufXPLJ
 LgGTiy6fJA3PMbM6xVkKrKzt9MCag/S2oHY43K55KX2TYU3G6lRLZZoHQ8V+YH7QaCIx
 7sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781036598; x=1781641398;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QeV4itFy15kA07HKE7wSEjLzXmlOjSYE70GZFqU1Jrs=;
 b=Ay0MzQmLo7n2/QX8JCeozEKvWCHhgHu1sWnqXoxKenhYZVQSYWetF6mJ9nKVwpyXpb
 qPySBGkJN0TkL8zLUWVMdoHUVnL7gXXWOlZ41DOrcY4zcGoM6hEznx96TAmOq932sJpP
 PegM6P+CGZ7kf4B4hqPC2Ej2AgQj3QP9lKOvew9GOSYOTutCUmUyAZkBfaIvS8zAU+Hh
 86k8b4kqN38db69xo9qpzeDdTag9bUaqK4eDXRHnsBRDctpR/okQhyqx9vPA+dbmWgN4
 zpPcup8WFq5ynoZQzOa4sU4esW3i5ornNt2KSTcQfgEfmpoakVMfnugW5A6G1qBkw67z
 dDoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/70uPLcLOuYjH+I5A3kfQEzTyAMnfdk9An709Zo4aBinNZ+tncUy8hqE2fJraklyS8Qv0pt3E=@lists.denx.de
X-Gm-Message-State: AOJu0YyBw20SWXO3/5Jem6rZyWDqxd9YbjBspJSG3fkgzKgcgOtN7vPF
 0JMB5jivyKnOwAzi8Qtf34hyTaz4ZVSOBjjifpDZJdbr4+l8vPRzjAtc
X-Gm-Gg: Acq92OE/0spnJFxwoMb8YifHinnV2It6g/hhUwrtAMZgJohthoMU1dblwbICMqBAlXE
 yH7i7RIoUM4COEF2IBI0aEkWstCd1PetJZh/AEvj4ljsc5m9N/Zpekpibfty5Tpefx72A3BEJkS
 KfJLHQAvoG+hNfY5+3WBMupaXLNmpHuB/xZJ1Z7uJV6YWMYbVGdb7tT1giLyuUW0J+X6iMITNdc
 OHTi6vib/OE4nWT1SWem/f70HHAxXwTLuEkzgsZ6MBhLSKNSW+wD6OanTzx0isb2D25Ae5S0/vF
 B8fLMpg3s9TX9XPa65lPsG6gzrlLv/tjRZDrxMoDXQa0G30UQkWZ4KlQqiZ3pbKzjD9GADx+pOP
 s8KzcfemDTvZBO02M7pCUP68v7Cor5iDzlntyYAhJ6tlvyRCAlBRZGk3aiwdOtgk3llM2V53IwX
 mW9Mpncp7ODu4EMKk/J9iMD4gOJKXnXEaO2vLq3ETghH77iNrtNiOB8NNb2nhgat1NHv0BRKg3
X-Received: by 2002:a05:6402:449b:b0:68c:342f:23b6 with SMTP id
 4fb4d7f45d1cf-69237dc9521mr1176503a12.7.1781036597700; 
 Tue, 09 Jun 2026 13:23:17 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65851fa2sm8897216a12.18.2026.06.09.13.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 13:23:16 -0700 (PDT)
Message-ID: <6bcf3192-82dc-464e-92f6-b9758f6c8422@gmail.com>
Date: Tue, 9 Jun 2026 22:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/3] rockchip: pinctrl: replace RK_GPIOn defines
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

The use of RK_GPIOn defines is deprecated in the upstream
rockchip.h file. Replace all them by the gpio number.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/pinctrl/rockchip/pinctrl-rk3568.c | 186 +++++++++++-----------
 drivers/pinctrl/rockchip/pinctrl-rv1126.c | 134 ++++++++--------
 include/dt-bindings/pinctrl/rockchip.h    |   7 -
 3 files changed, 160 insertions(+), 167 deletions(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3568.c b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
index f8899443d529..514481530faa 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3568.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
@@ -12,99 +12,99 @@
 #include "pinctrl-rockchip.h"

 static struct rockchip_mux_route_data rk3568_mux_route_data[] = {
-	MR_PMUGRF(RK_GPIO0, RK_PB7, 1, 0x0110, RK_GENMASK_VAL(1, 0, 0)), /* PWM0 IO mux selection M0 */
-	MR_PMUGRF(RK_GPIO0, RK_PC7, 2, 0x0110, RK_GENMASK_VAL(1, 0, 1)), /* PWM0 IO mux selection M1 */
-	MR_PMUGRF(RK_GPIO0, RK_PC0, 1, 0x0110, RK_GENMASK_VAL(3, 2, 0)), /* PWM1 IO mux selection M0 */
-	MR_PMUGRF(RK_GPIO0, RK_PB5, 4, 0x0110, RK_GENMASK_VAL(3, 2, 1)), /* PWM1 IO mux selection M1 */
-	MR_PMUGRF(RK_GPIO0, RK_PC1, 1, 0x0110, RK_GENMASK_VAL(5, 4, 0)), /* PWM2 IO mux selection M0 */
-	MR_PMUGRF(RK_GPIO0, RK_PB6, 4, 0x0110, RK_GENMASK_VAL(5, 4, 1)), /* PWM2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO0, RK_PB3, 2, 0x0300, RK_GENMASK_VAL(0, 0, 0)), /* CAN0 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PA1, 4, 0x0300, RK_GENMASK_VAL(0, 0, 1)), /* CAN0 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA1, 3, 0x0300, RK_GENMASK_VAL(2, 2, 0)), /* CAN1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC3, 3, 0x0300, RK_GENMASK_VAL(2, 2, 1)), /* CAN1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PB5, 3, 0x0300, RK_GENMASK_VAL(4, 4, 0)), /* CAN2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PB2, 4, 0x0300, RK_GENMASK_VAL(4, 4, 1)), /* CAN2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PC4, 1, 0x0300, RK_GENMASK_VAL(6, 6, 0)), /* EDPDP_HPDIN IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO0, RK_PC2, 2, 0x0300, RK_GENMASK_VAL(6, 6, 1)), /* EDPDP_HPDIN IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB1, 3, 0x0300, RK_GENMASK_VAL(8, 8, 0)), /* GMAC1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PA7, 3, 0x0300, RK_GENMASK_VAL(8, 8, 1)), /* GMAC1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PD1, 1, 0x0300, RK_GENMASK_VAL(10, 10, 0)), /* HDMITX IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO0, RK_PC7, 1, 0x0300, RK_GENMASK_VAL(10, 10, 1)), /* HDMITX IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO0, RK_PB6, 1, 0x0300, RK_GENMASK_VAL(14, 14, 0)), /* I2C2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PB4, 1, 0x0300, RK_GENMASK_VAL(14, 14, 1)), /* I2C2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA0, 1, 0x0304, RK_GENMASK_VAL(0, 0, 0)), /* I2C3 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PB6, 4, 0x0304, RK_GENMASK_VAL(0, 0, 1)), /* I2C3 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PB2, 1, 0x0304, RK_GENMASK_VAL(2, 2, 0)), /* I2C4 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PB1, 2, 0x0304, RK_GENMASK_VAL(2, 2, 1)), /* I2C4 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB4, 4, 0x0304, RK_GENMASK_VAL(4, 4, 0)), /* I2C5 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PD0, 2, 0x0304, RK_GENMASK_VAL(4, 4, 1)), /* I2C5 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB1, 5, 0x0304, RK_GENMASK_VAL(14, 14, 0)), /* PWM8 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PD5, 4, 0x0304, RK_GENMASK_VAL(14, 14, 1)), /* PWM8 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB2, 5, 0x0308, RK_GENMASK_VAL(0, 0, 0)), /* PWM9 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PD6, 4, 0x0308, RK_GENMASK_VAL(0, 0, 1)), /* PWM9 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB5, 5, 0x0308, RK_GENMASK_VAL(2, 2, 0)), /* PWM10 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PA1, 2, 0x0308, RK_GENMASK_VAL(2, 2, 1)), /* PWM10 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB6, 5, 0x0308, RK_GENMASK_VAL(4, 4, 0)), /* PWM11 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC0, 3, 0x0308, RK_GENMASK_VAL(4, 4, 1)), /* PWM11 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PB7, 2, 0x0308, RK_GENMASK_VAL(6, 6, 0)), /* PWM12 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC5, 1, 0x0308, RK_GENMASK_VAL(6, 6, 1)), /* PWM12 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PC0, 2, 0x0308, RK_GENMASK_VAL(8, 8, 0)), /* PWM13 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC6, 1, 0x0308, RK_GENMASK_VAL(8, 8, 1)), /* PWM13 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PC4, 1, 0x0308, RK_GENMASK_VAL(10, 10, 0)), /* PWM14 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC2, 1, 0x0308, RK_GENMASK_VAL(10, 10, 1)), /* PWM14 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PC5, 1, 0x0308, RK_GENMASK_VAL(12, 12, 0)), /* PWM15 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC3, 1, 0x0308, RK_GENMASK_VAL(12, 12, 1)), /* PWM15 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PD2, 3, 0x0308, RK_GENMASK_VAL(14, 14, 0)), /* SDMMC2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PA5, 5, 0x0308, RK_GENMASK_VAL(14, 14, 1)), /* SDMMC2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO0, RK_PB5, 2, 0x030c, RK_GENMASK_VAL(0, 0, 0)), /* SPI0 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD3, 3, 0x030c, RK_GENMASK_VAL(0, 0, 1)), /* SPI0 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PB5, 3, 0x030c, RK_GENMASK_VAL(2, 2, 0)), /* SPI1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PC3, 3, 0x030c, RK_GENMASK_VAL(2, 2, 1)), /* SPI1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PC1, 4, 0x030c, RK_GENMASK_VAL(4, 4, 0)), /* SPI2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PA0, 3, 0x030c, RK_GENMASK_VAL(4, 4, 1)), /* SPI2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PB3, 4, 0x030c, RK_GENMASK_VAL(6, 6, 0)), /* SPI3 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC2, 2, 0x030c, RK_GENMASK_VAL(6, 6, 1)), /* SPI3 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PB4, 2, 0x030c, RK_GENMASK_VAL(8, 8, 0)), /* UART1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PD6, 4, 0x030c, RK_GENMASK_VAL(8, 8, 1)), /* UART1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO0, RK_PD1, 1, 0x030c, RK_GENMASK_VAL(10, 10, 0)), /* UART2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PD5, 2, 0x030c, RK_GENMASK_VAL(10, 10, 1)), /* UART2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA1, 2, 0x030c, RK_GENMASK_VAL(12, 12, 0)), /* UART3 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PB7, 4, 0x030c, RK_GENMASK_VAL(12, 12, 1)), /* UART3 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA6, 2, 0x030c, RK_GENMASK_VAL(14, 14, 0)), /* UART4 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PB2, 4, 0x030c, RK_GENMASK_VAL(14, 14, 1)), /* UART4 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PA2, 3, 0x0310, RK_GENMASK_VAL(0, 0, 0)), /* UART5 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PC2, 4, 0x0310, RK_GENMASK_VAL(0, 0, 1)), /* UART5 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PA4, 3, 0x0310, RK_GENMASK_VAL(2, 2, 0)), /* UART6 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PD5, 3, 0x0310, RK_GENMASK_VAL(2, 2, 1)), /* UART6 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PA6, 3, 0x0310, RK_GENMASK_VAL(5, 4, 0)), /* UART7 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PC4, 4, 0x0310, RK_GENMASK_VAL(5, 4, 1)), /* UART7 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PA2, 4, 0x0310, RK_GENMASK_VAL(5, 4, 2)), /* UART7 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO2, RK_PC5, 3, 0x0310, RK_GENMASK_VAL(6, 6, 0)), /* UART8 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD7, 4, 0x0310, RK_GENMASK_VAL(6, 6, 1)), /* UART8 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PB0, 3, 0x0310, RK_GENMASK_VAL(9, 8, 0)), /* UART9 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC5, 4, 0x0310, RK_GENMASK_VAL(9, 8, 1)), /* UART9 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PA4, 4, 0x0310, RK_GENMASK_VAL(9, 8, 2)), /* UART9 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO1, RK_PA2, 1, 0x0310, RK_GENMASK_VAL(11, 10, 0)), /* I2S1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PC6, 4, 0x0310, RK_GENMASK_VAL(11, 10, 1)), /* I2S1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PD0, 5, 0x0310, RK_GENMASK_VAL(11, 10, 2)), /* I2S1 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO2, RK_PC1, 1, 0x0310, RK_GENMASK_VAL(12, 12, 0)), /* I2S2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PB6, 5, 0x0310, RK_GENMASK_VAL(12, 12, 1)), /* I2S2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PA2, 4, 0x0310, RK_GENMASK_VAL(14, 14, 0)), /* I2S3 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PC2, 5, 0x0310, RK_GENMASK_VAL(14, 14, 1)), /* I2S3 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA4, 3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PA6, 3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PD6, 5, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PA0, 4, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PC4, 5, 0x0314, RK_GENMASK_VAL(1, 0, 2)), /* PDM IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO0, RK_PA5, 3, 0x0314, RK_GENMASK_VAL(3, 2, 0)), /* PCIE20 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD0, 4, 0x0314, RK_GENMASK_VAL(3, 2, 1)), /* PCIE20 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PB0, 4, 0x0314, RK_GENMASK_VAL(3, 2, 2)), /* PCIE20 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO0, RK_PA4, 3, 0x0314, RK_GENMASK_VAL(5, 4, 0)), /* PCIE30X1 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD2, 4, 0x0314, RK_GENMASK_VAL(5, 4, 1)), /* PCIE30X1 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PA5, 4, 0x0314, RK_GENMASK_VAL(5, 4, 2)), /* PCIE30X1 IO mux selection M2 */
-	MR_TOPGRF(RK_GPIO0, RK_PA6, 2, 0x0314, RK_GENMASK_VAL(7, 6, 0)), /* PCIE30X2 IO mux selection M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD4, 4, 0x0314, RK_GENMASK_VAL(7, 6, 1)), /* PCIE30X2 IO mux selection M1 */
-	MR_TOPGRF(RK_GPIO4, RK_PC2, 4, 0x0314, RK_GENMASK_VAL(7, 6, 2)), /* PCIE30X2 IO mux selection M2 */
+	MR_PMUGRF(0, RK_PB7, 1, 0x0110, RK_GENMASK_VAL(1, 0, 0)), /* PWM0 IO mux selection M0 */
+	MR_PMUGRF(0, RK_PC7, 2, 0x0110, RK_GENMASK_VAL(1, 0, 1)), /* PWM0 IO mux selection M1 */
+	MR_PMUGRF(0, RK_PC0, 1, 0x0110, RK_GENMASK_VAL(3, 2, 0)), /* PWM1 IO mux selection M0 */
+	MR_PMUGRF(0, RK_PB5, 4, 0x0110, RK_GENMASK_VAL(3, 2, 1)), /* PWM1 IO mux selection M1 */
+	MR_PMUGRF(0, RK_PC1, 1, 0x0110, RK_GENMASK_VAL(5, 4, 0)), /* PWM2 IO mux selection M0 */
+	MR_PMUGRF(0, RK_PB6, 4, 0x0110, RK_GENMASK_VAL(5, 4, 1)), /* PWM2 IO mux selection M1 */
+	MR_TOPGRF(0, RK_PB3, 2, 0x0300, RK_GENMASK_VAL(0, 0, 0)), /* CAN0 IO mux selection M0 */
+	MR_TOPGRF(2, RK_PA1, 4, 0x0300, RK_GENMASK_VAL(0, 0, 1)), /* CAN0 IO mux selection M1 */
+	MR_TOPGRF(1, RK_PA1, 3, 0x0300, RK_GENMASK_VAL(2, 2, 0)), /* CAN1 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PC3, 3, 0x0300, RK_GENMASK_VAL(2, 2, 1)), /* CAN1 IO mux selection M1 */
+	MR_TOPGRF(4, RK_PB5, 3, 0x0300, RK_GENMASK_VAL(4, 4, 0)), /* CAN2 IO mux selection M0 */
+	MR_TOPGRF(2, RK_PB2, 4, 0x0300, RK_GENMASK_VAL(4, 4, 1)), /* CAN2 IO mux selection M1 */
+	MR_TOPGRF(4, RK_PC4, 1, 0x0300, RK_GENMASK_VAL(6, 6, 0)), /* EDPDP_HPDIN IO mux selection M0 */
+	MR_TOPGRF(0, RK_PC2, 2, 0x0300, RK_GENMASK_VAL(6, 6, 1)), /* EDPDP_HPDIN IO mux selection M1 */
+	MR_TOPGRF(3, RK_PB1, 3, 0x0300, RK_GENMASK_VAL(8, 8, 0)), /* GMAC1 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PA7, 3, 0x0300, RK_GENMASK_VAL(8, 8, 1)), /* GMAC1 IO mux selection M1 */
+	MR_TOPGRF(4, RK_PD1, 1, 0x0300, RK_GENMASK_VAL(10, 10, 0)), /* HDMITX IO mux selection M0 */
+	MR_TOPGRF(0, RK_PC7, 1, 0x0300, RK_GENMASK_VAL(10, 10, 1)), /* HDMITX IO mux selection M1 */
+	MR_TOPGRF(0, RK_PB6, 1, 0x0300, RK_GENMASK_VAL(14, 14, 0)), /* I2C2 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PB4, 1, 0x0300, RK_GENMASK_VAL(14, 14, 1)), /* I2C2 IO mux selection M1 */
+	MR_TOPGRF(1, RK_PA0, 1, 0x0304, RK_GENMASK_VAL(0, 0, 0)), /* I2C3 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PB6, 4, 0x0304, RK_GENMASK_VAL(0, 0, 1)), /* I2C3 IO mux selection M1 */
+	MR_TOPGRF(4, RK_PB2, 1, 0x0304, RK_GENMASK_VAL(2, 2, 0)), /* I2C4 IO mux selection M0 */
+	MR_TOPGRF(2, RK_PB1, 2, 0x0304, RK_GENMASK_VAL(2, 2, 1)), /* I2C4 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PB4, 4, 0x0304, RK_GENMASK_VAL(4, 4, 0)), /* I2C5 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PD0, 2, 0x0304, RK_GENMASK_VAL(4, 4, 1)), /* I2C5 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PB1, 5, 0x0304, RK_GENMASK_VAL(14, 14, 0)), /* PWM8 IO mux selection M0 */
+	MR_TOPGRF(1, RK_PD5, 4, 0x0304, RK_GENMASK_VAL(14, 14, 1)), /* PWM8 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PB2, 5, 0x0308, RK_GENMASK_VAL(0, 0, 0)), /* PWM9 IO mux selection M0 */
+	MR_TOPGRF(1, RK_PD6, 4, 0x0308, RK_GENMASK_VAL(0, 0, 1)), /* PWM9 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PB5, 5, 0x0308, RK_GENMASK_VAL(2, 2, 0)), /* PWM10 IO mux selection M0 */
+	MR_TOPGRF(2, RK_PA1, 2, 0x0308, RK_GENMASK_VAL(2, 2, 1)), /* PWM10 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PB6, 5, 0x0308, RK_GENMASK_VAL(4, 4, 0)), /* PWM11 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PC0, 3, 0x0308, RK_GENMASK_VAL(4, 4, 1)), /* PWM11 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PB7, 2, 0x0308, RK_GENMASK_VAL(6, 6, 0)), /* PWM12 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PC5, 1, 0x0308, RK_GENMASK_VAL(6, 6, 1)), /* PWM12 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PC0, 2, 0x0308, RK_GENMASK_VAL(8, 8, 0)), /* PWM13 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PC6, 1, 0x0308, RK_GENMASK_VAL(8, 8, 1)), /* PWM13 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PC4, 1, 0x0308, RK_GENMASK_VAL(10, 10, 0)), /* PWM14 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PC2, 1, 0x0308, RK_GENMASK_VAL(10, 10, 1)), /* PWM14 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PC5, 1, 0x0308, RK_GENMASK_VAL(12, 12, 0)), /* PWM15 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PC3, 1, 0x0308, RK_GENMASK_VAL(12, 12, 1)), /* PWM15 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PD2, 3, 0x0308, RK_GENMASK_VAL(14, 14, 0)), /* SDMMC2 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PA5, 5, 0x0308, RK_GENMASK_VAL(14, 14, 1)), /* SDMMC2 IO mux selection M1 */
+	MR_TOPGRF(0, RK_PB5, 2, 0x030c, RK_GENMASK_VAL(0, 0, 0)), /* SPI0 IO mux selection M0 */
+	MR_TOPGRF(2, RK_PD3, 3, 0x030c, RK_GENMASK_VAL(0, 0, 1)), /* SPI0 IO mux selection M1 */
+	MR_TOPGRF(2, RK_PB5, 3, 0x030c, RK_GENMASK_VAL(2, 2, 0)), /* SPI1 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PC3, 3, 0x030c, RK_GENMASK_VAL(2, 2, 1)), /* SPI1 IO mux selection M1 */
+	MR_TOPGRF(2, RK_PC1, 4, 0x030c, RK_GENMASK_VAL(4, 4, 0)), /* SPI2 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PA0, 3, 0x030c, RK_GENMASK_VAL(4, 4, 1)), /* SPI2 IO mux selection M1 */
+	MR_TOPGRF(4, RK_PB3, 4, 0x030c, RK_GENMASK_VAL(6, 6, 0)), /* SPI3 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PC2, 2, 0x030c, RK_GENMASK_VAL(6, 6, 1)), /* SPI3 IO mux selection M1 */
+	MR_TOPGRF(2, RK_PB4, 2, 0x030c, RK_GENMASK_VAL(8, 8, 0)), /* UART1 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PD6, 4, 0x030c, RK_GENMASK_VAL(8, 8, 1)), /* UART1 IO mux selection M1 */
+	MR_TOPGRF(0, RK_PD1, 1, 0x030c, RK_GENMASK_VAL(10, 10, 0)), /* UART2 IO mux selection M0 */
+	MR_TOPGRF(1, RK_PD5, 2, 0x030c, RK_GENMASK_VAL(10, 10, 1)), /* UART2 IO mux selection M1 */
+	MR_TOPGRF(1, RK_PA1, 2, 0x030c, RK_GENMASK_VAL(12, 12, 0)), /* UART3 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PB7, 4, 0x030c, RK_GENMASK_VAL(12, 12, 1)), /* UART3 IO mux selection M1 */
+	MR_TOPGRF(1, RK_PA6, 2, 0x030c, RK_GENMASK_VAL(14, 14, 0)), /* UART4 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PB2, 4, 0x030c, RK_GENMASK_VAL(14, 14, 1)), /* UART4 IO mux selection M1 */
+	MR_TOPGRF(2, RK_PA2, 3, 0x0310, RK_GENMASK_VAL(0, 0, 0)), /* UART5 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PC2, 4, 0x0310, RK_GENMASK_VAL(0, 0, 1)), /* UART5 IO mux selection M1 */
+	MR_TOPGRF(2, RK_PA4, 3, 0x0310, RK_GENMASK_VAL(2, 2, 0)), /* UART6 IO mux selection M0 */
+	MR_TOPGRF(1, RK_PD5, 3, 0x0310, RK_GENMASK_VAL(2, 2, 1)), /* UART6 IO mux selection M1 */
+	MR_TOPGRF(2, RK_PA6, 3, 0x0310, RK_GENMASK_VAL(5, 4, 0)), /* UART7 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PC4, 4, 0x0310, RK_GENMASK_VAL(5, 4, 1)), /* UART7 IO mux selection M1 */
+	MR_TOPGRF(4, RK_PA2, 4, 0x0310, RK_GENMASK_VAL(5, 4, 2)), /* UART7 IO mux selection M2 */
+	MR_TOPGRF(2, RK_PC5, 3, 0x0310, RK_GENMASK_VAL(6, 6, 0)), /* UART8 IO mux selection M0 */
+	MR_TOPGRF(2, RK_PD7, 4, 0x0310, RK_GENMASK_VAL(6, 6, 1)), /* UART8 IO mux selection M1 */
+	MR_TOPGRF(2, RK_PB0, 3, 0x0310, RK_GENMASK_VAL(9, 8, 0)), /* UART9 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PC5, 4, 0x0310, RK_GENMASK_VAL(9, 8, 1)), /* UART9 IO mux selection M1 */
+	MR_TOPGRF(4, RK_PA4, 4, 0x0310, RK_GENMASK_VAL(9, 8, 2)), /* UART9 IO mux selection M2 */
+	MR_TOPGRF(1, RK_PA2, 1, 0x0310, RK_GENMASK_VAL(11, 10, 0)), /* I2S1 IO mux selection M0 */
+	MR_TOPGRF(3, RK_PC6, 4, 0x0310, RK_GENMASK_VAL(11, 10, 1)), /* I2S1 IO mux selection M1 */
+	MR_TOPGRF(2, RK_PD0, 5, 0x0310, RK_GENMASK_VAL(11, 10, 2)), /* I2S1 IO mux selection M2 */
+	MR_TOPGRF(2, RK_PC1, 1, 0x0310, RK_GENMASK_VAL(12, 12, 0)), /* I2S2 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PB6, 5, 0x0310, RK_GENMASK_VAL(12, 12, 1)), /* I2S2 IO mux selection M1 */
+	MR_TOPGRF(3, RK_PA2, 4, 0x0310, RK_GENMASK_VAL(14, 14, 0)), /* I2S3 IO mux selection M0 */
+	MR_TOPGRF(4, RK_PC2, 5, 0x0310, RK_GENMASK_VAL(14, 14, 1)), /* I2S3 IO mux selection M1 */
+	MR_TOPGRF(1, RK_PA4, 3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
+	MR_TOPGRF(1, RK_PA6, 3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
+	MR_TOPGRF(3, RK_PD6, 5, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
+	MR_TOPGRF(4, RK_PA0, 4, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
+	MR_TOPGRF(3, RK_PC4, 5, 0x0314, RK_GENMASK_VAL(1, 0, 2)), /* PDM IO mux selection M2 */
+	MR_TOPGRF(0, RK_PA5, 3, 0x0314, RK_GENMASK_VAL(3, 2, 0)), /* PCIE20 IO mux selection M0 */
+	MR_TOPGRF(2, RK_PD0, 4, 0x0314, RK_GENMASK_VAL(3, 2, 1)), /* PCIE20 IO mux selection M1 */
+	MR_TOPGRF(1, RK_PB0, 4, 0x0314, RK_GENMASK_VAL(3, 2, 2)), /* PCIE20 IO mux selection M2 */
+	MR_TOPGRF(0, RK_PA4, 3, 0x0314, RK_GENMASK_VAL(5, 4, 0)), /* PCIE30X1 IO mux selection M0 */
+	MR_TOPGRF(2, RK_PD2, 4, 0x0314, RK_GENMASK_VAL(5, 4, 1)), /* PCIE30X1 IO mux selection M1 */
+	MR_TOPGRF(1, RK_PA5, 4, 0x0314, RK_GENMASK_VAL(5, 4, 2)), /* PCIE30X1 IO mux selection M2 */
+	MR_TOPGRF(0, RK_PA6, 2, 0x0314, RK_GENMASK_VAL(7, 6, 0)), /* PCIE30X2 IO mux selection M0 */
+	MR_TOPGRF(2, RK_PD4, 4, 0x0314, RK_GENMASK_VAL(7, 6, 1)), /* PCIE30X2 IO mux selection M1 */
+	MR_TOPGRF(4, RK_PC2, 4, 0x0314, RK_GENMASK_VAL(7, 6, 2)), /* PCIE30X2 IO mux selection M2 */
 };

 static int rk3568_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1126.c b/drivers/pinctrl/rockchip/pinctrl-rv1126.c
index 3878a5420dcc..88966ef34a68 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rv1126.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rv1126.c
@@ -45,101 +45,101 @@ static struct rockchip_mux_recalced_data rv1126_mux_recalced_data[] = {
 };

 static struct rockchip_mux_route_data rv1126_mux_route_data[] = {
-	MR_TOPGRF(RK_GPIO3, RK_PD2, 1, 0x10260, RK_GENMASK_VAL(0, 0, 0)), /* I2S0_MCLK_M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PB0, 3, 0x10260, RK_GENMASK_VAL(0, 0, 1)), /* I2S0_MCLK_M1 */
+	MR_TOPGRF(3, RK_PD2, 1, 0x10260, RK_GENMASK_VAL(0, 0, 0)), /* I2S0_MCLK_M0 */
+	MR_TOPGRF(3, RK_PB0, 3, 0x10260, RK_GENMASK_VAL(0, 0, 1)), /* I2S0_MCLK_M1 */

-	MR_TOPGRF(RK_GPIO0, RK_PD4, 4, 0x10260, RK_GENMASK_VAL(3, 2, 0)), /* I2S1_MCLK_M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PD5, 2, 0x10260, RK_GENMASK_VAL(3, 2, 1)), /* I2S1_MCLK_M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PC7, 6, 0x10260, RK_GENMASK_VAL(3, 2, 2)), /* I2S1_MCLK_M2 */
+	MR_TOPGRF(0, RK_PD4, 4, 0x10260, RK_GENMASK_VAL(3, 2, 0)), /* I2S1_MCLK_M0 */
+	MR_TOPGRF(1, RK_PD5, 2, 0x10260, RK_GENMASK_VAL(3, 2, 1)), /* I2S1_MCLK_M1 */
+	MR_TOPGRF(2, RK_PC7, 6, 0x10260, RK_GENMASK_VAL(3, 2, 2)), /* I2S1_MCLK_M2 */

-	MR_TOPGRF(RK_GPIO1, RK_PD0, 1, 0x10260, RK_GENMASK_VAL(4, 4, 0)), /* I2S2_MCLK_M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PB3, 2, 0x10260, RK_GENMASK_VAL(4, 4, 1)), /* I2S2_MCLK_M1 */
+	MR_TOPGRF(1, RK_PD0, 1, 0x10260, RK_GENMASK_VAL(4, 4, 0)), /* I2S2_MCLK_M0 */
+	MR_TOPGRF(2, RK_PB3, 2, 0x10260, RK_GENMASK_VAL(4, 4, 1)), /* I2S2_MCLK_M1 */

-	MR_TOPGRF(RK_GPIO3, RK_PD4, 2, 0x10260, RK_GENMASK_VAL(12, 12, 0)), /* PDM_CLK0_M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PC0, 3, 0x10260, RK_GENMASK_VAL(12, 12, 1)), /* PDM_CLK0_M1 */
+	MR_TOPGRF(3, RK_PD4, 2, 0x10260, RK_GENMASK_VAL(12, 12, 0)), /* PDM_CLK0_M0 */
+	MR_TOPGRF(3, RK_PC0, 3, 0x10260, RK_GENMASK_VAL(12, 12, 1)), /* PDM_CLK0_M1 */

-	MR_TOPGRF(RK_GPIO3, RK_PC6, 1, 0x10264, RK_GENMASK_VAL(0, 0, 0)), /* CIF_CLKOUT_M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD1, 3, 0x10264, RK_GENMASK_VAL(0, 0, 1)), /* CIF_CLKOUT_M1 */
+	MR_TOPGRF(3, RK_PC6, 1, 0x10264, RK_GENMASK_VAL(0, 0, 0)), /* CIF_CLKOUT_M0 */
+	MR_TOPGRF(2, RK_PD1, 3, 0x10264, RK_GENMASK_VAL(0, 0, 1)), /* CIF_CLKOUT_M1 */

-	MR_TOPGRF(RK_GPIO3, RK_PA4, 5, 0x10264, RK_GENMASK_VAL(5, 4, 0)), /* I2C3_SCL_M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD4, 7, 0x10264, RK_GENMASK_VAL(5, 4, 1)), /* I2C3_SCL_M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PD6, 3, 0x10264, RK_GENMASK_VAL(5, 4, 2)), /* I2C3_SCL_M2 */
+	MR_TOPGRF(3, RK_PA4, 5, 0x10264, RK_GENMASK_VAL(5, 4, 0)), /* I2C3_SCL_M0 */
+	MR_TOPGRF(2, RK_PD4, 7, 0x10264, RK_GENMASK_VAL(5, 4, 1)), /* I2C3_SCL_M1 */
+	MR_TOPGRF(1, RK_PD6, 3, 0x10264, RK_GENMASK_VAL(5, 4, 2)), /* I2C3_SCL_M2 */

-	MR_TOPGRF(RK_GPIO3, RK_PA0, 7, 0x10264, RK_GENMASK_VAL(6, 6, 0)), /* I2C4_SCL_M0 */
-	MR_TOPGRF(RK_GPIO4, RK_PA0, 4, 0x10264, RK_GENMASK_VAL(6, 6, 1)), /* I2C4_SCL_M1 */
+	MR_TOPGRF(3, RK_PA0, 7, 0x10264, RK_GENMASK_VAL(6, 6, 0)), /* I2C4_SCL_M0 */
+	MR_TOPGRF(4, RK_PA0, 4, 0x10264, RK_GENMASK_VAL(6, 6, 1)), /* I2C4_SCL_M1 */

-	MR_TOPGRF(RK_GPIO2, RK_PA5, 7, 0x10264, RK_GENMASK_VAL(9, 8, 0)), /* I2C5_SCL_M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PB0, 5, 0x10264, RK_GENMASK_VAL(9, 8, 1)), /* I2C5_SCL_M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PD0, 4, 0x10264, RK_GENMASK_VAL(9, 8, 2)), /* I2C5_SCL_M2 */
+	MR_TOPGRF(2, RK_PA5, 7, 0x10264, RK_GENMASK_VAL(9, 8, 0)), /* I2C5_SCL_M0 */
+	MR_TOPGRF(3, RK_PB0, 5, 0x10264, RK_GENMASK_VAL(9, 8, 1)), /* I2C5_SCL_M1 */
+	MR_TOPGRF(1, RK_PD0, 4, 0x10264, RK_GENMASK_VAL(9, 8, 2)), /* I2C5_SCL_M2 */

-	MR_TOPGRF(RK_GPIO3, RK_PC0, 5, 0x10264, RK_GENMASK_VAL(11, 10, 0)), /* SPI1_CLK_M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PC6, 3, 0x10264, RK_GENMASK_VAL(11, 10, 1)), /* SPI1_CLK_M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PD5, 6, 0x10264, RK_GENMASK_VAL(11, 10, 2)), /* SPI1_CLK_M2 */
+	MR_TOPGRF(3, RK_PC0, 5, 0x10264, RK_GENMASK_VAL(11, 10, 0)), /* SPI1_CLK_M0 */
+	MR_TOPGRF(1, RK_PC6, 3, 0x10264, RK_GENMASK_VAL(11, 10, 1)), /* SPI1_CLK_M1 */
+	MR_TOPGRF(2, RK_PD5, 6, 0x10264, RK_GENMASK_VAL(11, 10, 2)), /* SPI1_CLK_M2 */

-	MR_TOPGRF(RK_GPIO3, RK_PC0, 2, 0x10264, RK_GENMASK_VAL(12, 12, 0)), /* RGMII_CLK_M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PB7, 2, 0x10264, RK_GENMASK_VAL(12, 12, 1)), /* RGMII_CLK_M1 */
+	MR_TOPGRF(3, RK_PC0, 2, 0x10264, RK_GENMASK_VAL(12, 12, 0)), /* RGMII_CLK_M0 */
+	MR_TOPGRF(2, RK_PB7, 2, 0x10264, RK_GENMASK_VAL(12, 12, 1)), /* RGMII_CLK_M1 */

-	MR_TOPGRF(RK_GPIO3, RK_PA1, 3, 0x10264, RK_GENMASK_VAL(13, 13, 0)), /* CAN_TXD_M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PA7, 5, 0x10264, RK_GENMASK_VAL(13, 13, 1)), /* CAN_TXD_M1 */
+	MR_TOPGRF(3, RK_PA1, 3, 0x10264, RK_GENMASK_VAL(13, 13, 0)), /* CAN_TXD_M0 */
+	MR_TOPGRF(3, RK_PA7, 5, 0x10264, RK_GENMASK_VAL(13, 13, 1)), /* CAN_TXD_M1 */

-	MR_TOPGRF(RK_GPIO3, RK_PA4, 6, 0x10268, RK_GENMASK_VAL(0, 0, 0)), /* PWM8_M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD7, 5, 0x10268, RK_GENMASK_VAL(0, 0, 1)), /* PWM8_M1 */
+	MR_TOPGRF(3, RK_PA4, 6, 0x10268, RK_GENMASK_VAL(0, 0, 0)), /* PWM8_M0 */
+	MR_TOPGRF(2, RK_PD7, 5, 0x10268, RK_GENMASK_VAL(0, 0, 1)), /* PWM8_M1 */

-	MR_TOPGRF(RK_GPIO3, RK_PA5, 6, 0x10268, RK_GENMASK_VAL(2, 2, 0)), /* PWM9_M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD6, 5, 0x10268, RK_GENMASK_VAL(2, 2, 1)), /* PWM9_M1 */
+	MR_TOPGRF(3, RK_PA5, 6, 0x10268, RK_GENMASK_VAL(2, 2, 0)), /* PWM9_M0 */
+	MR_TOPGRF(2, RK_PD6, 5, 0x10268, RK_GENMASK_VAL(2, 2, 1)), /* PWM9_M1 */

-	MR_TOPGRF(RK_GPIO3, RK_PA6, 6, 0x10268, RK_GENMASK_VAL(4, 4, 0)), /* PWM10_M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PD5, 5, 0x10268, RK_GENMASK_VAL(4, 4, 1)), /* PWM10_M1 */
+	MR_TOPGRF(3, RK_PA6, 6, 0x10268, RK_GENMASK_VAL(4, 4, 0)), /* PWM10_M0 */
+	MR_TOPGRF(2, RK_PD5, 5, 0x10268, RK_GENMASK_VAL(4, 4, 1)), /* PWM10_M1 */

-	MR_TOPGRF(RK_GPIO3, RK_PA7, 6, 0x10268, RK_GENMASK_VAL(6, 6, 0)), /* PWM11_IR_M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PA1, 5, 0x10268, RK_GENMASK_VAL(6, 6, 1)), /* PWM11_IR_M1 */
+	MR_TOPGRF(3, RK_PA7, 6, 0x10268, RK_GENMASK_VAL(6, 6, 0)), /* PWM11_IR_M0 */
+	MR_TOPGRF(3, RK_PA1, 5, 0x10268, RK_GENMASK_VAL(6, 6, 1)), /* PWM11_IR_M1 */

-	MR_TOPGRF(RK_GPIO1, RK_PA5, 3, 0x10268, RK_GENMASK_VAL(8, 8, 0)), /* UART2_TX_M0 */
-	MR_TOPGRF(RK_GPIO3, RK_PA2, 1, 0x10268, RK_GENMASK_VAL(8, 8, 1)), /* UART2_TX_M1 */
+	MR_TOPGRF(1, RK_PA5, 3, 0x10268, RK_GENMASK_VAL(8, 8, 0)), /* UART2_TX_M0 */
+	MR_TOPGRF(3, RK_PA2, 1, 0x10268, RK_GENMASK_VAL(8, 8, 1)), /* UART2_TX_M1 */

-	MR_TOPGRF(RK_GPIO3, RK_PC6, 3, 0x10268, RK_GENMASK_VAL(11, 10, 0)), /* UART3_TX_M0 */
-	MR_TOPGRF(RK_GPIO1, RK_PA7, 2, 0x10268, RK_GENMASK_VAL(11, 10, 1)), /* UART3_TX_M1 */
-	MR_TOPGRF(RK_GPIO3, RK_PA0, 4, 0x10268, RK_GENMASK_VAL(11, 10, 2)), /* UART3_TX_M2 */
+	MR_TOPGRF(3, RK_PC6, 3, 0x10268, RK_GENMASK_VAL(11, 10, 0)), /* UART3_TX_M0 */
+	MR_TOPGRF(1, RK_PA7, 2, 0x10268, RK_GENMASK_VAL(11, 10, 1)), /* UART3_TX_M1 */
+	MR_TOPGRF(3, RK_PA0, 4, 0x10268, RK_GENMASK_VAL(11, 10, 2)), /* UART3_TX_M2 */

-	MR_TOPGRF(RK_GPIO3, RK_PA4, 4, 0x10268, RK_GENMASK_VAL(13, 12, 0)), /* UART4_TX_M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PA6, 4, 0x10268, RK_GENMASK_VAL(13, 12, 1)), /* UART4_TX_M1 */
-	MR_TOPGRF(RK_GPIO1, RK_PD5, 3, 0x10268, RK_GENMASK_VAL(13, 12, 2)), /* UART4_TX_M2 */
+	MR_TOPGRF(3, RK_PA4, 4, 0x10268, RK_GENMASK_VAL(13, 12, 0)), /* UART4_TX_M0 */
+	MR_TOPGRF(2, RK_PA6, 4, 0x10268, RK_GENMASK_VAL(13, 12, 1)), /* UART4_TX_M1 */
+	MR_TOPGRF(1, RK_PD5, 3, 0x10268, RK_GENMASK_VAL(13, 12, 2)), /* UART4_TX_M2 */

-	MR_TOPGRF(RK_GPIO3, RK_PA6, 4, 0x10268, RK_GENMASK_VAL(15, 14, 0)), /* UART5_TX_M0 */
-	MR_TOPGRF(RK_GPIO2, RK_PB0, 4, 0x10268, RK_GENMASK_VAL(15, 14, 1)), /* UART5_TX_M1 */
-	MR_TOPGRF(RK_GPIO2, RK_PA0, 3, 0x10268, RK_GENMASK_VAL(15, 14, 2)), /* UART5_TX_M2 */
+	MR_TOPGRF(3, RK_PA6, 4, 0x10268, RK_GENMASK_VAL(15, 14, 0)), /* UART5_TX_M0 */
+	MR_TOPGRF(2, RK_PB0, 4, 0x10268, RK_GENMASK_VAL(15, 14, 1)), /* UART5_TX_M1 */
+	MR_TOPGRF(2, RK_PA0, 3, 0x10268, RK_GENMASK_VAL(15, 14, 2)), /* UART5_TX_M2 */

-	MR_PMUGRF(RK_GPIO0, RK_PB6, 3, 0x0114, RK_GENMASK_VAL(0, 0, 0)), /* PWM0_M0 */
-	MR_PMUGRF(RK_GPIO2, RK_PB3, 5, 0x0114, RK_GENMASK_VAL(0, 0, 1)), /* PWM0_M1 */
+	MR_PMUGRF(0, RK_PB6, 3, 0x0114, RK_GENMASK_VAL(0, 0, 0)), /* PWM0_M0 */
+	MR_PMUGRF(2, RK_PB3, 5, 0x0114, RK_GENMASK_VAL(0, 0, 1)), /* PWM0_M1 */

-	MR_PMUGRF(RK_GPIO0, RK_PB7, 3, 0x0114, RK_GENMASK_VAL(2, 2, 0)), /* PWM1_M0 */
-	MR_PMUGRF(RK_GPIO2, RK_PB2, 5, 0x0114, RK_GENMASK_VAL(2, 2, 1)), /* PWM1_M1 */
+	MR_PMUGRF(0, RK_PB7, 3, 0x0114, RK_GENMASK_VAL(2, 2, 0)), /* PWM1_M0 */
+	MR_PMUGRF(2, RK_PB2, 5, 0x0114, RK_GENMASK_VAL(2, 2, 1)), /* PWM1_M1 */

-	MR_PMUGRF(RK_GPIO0, RK_PC0, 3, 0x0114, RK_GENMASK_VAL(4, 4, 0)), /* PWM2_M0 */
-	MR_PMUGRF(RK_GPIO2, RK_PB1, 5, 0x0114, RK_GENMASK_VAL(4, 4, 1)), /* PWM2_M1 */
+	MR_PMUGRF(0, RK_PC0, 3, 0x0114, RK_GENMASK_VAL(4, 4, 0)), /* PWM2_M0 */
+	MR_PMUGRF(2, RK_PB1, 5, 0x0114, RK_GENMASK_VAL(4, 4, 1)), /* PWM2_M1 */

-	MR_PMUGRF(RK_GPIO0, RK_PC1, 3, 0x0114, RK_GENMASK_VAL(6, 6, 0)), /* PWM3_IR_M0 */
-	MR_PMUGRF(RK_GPIO2, RK_PB0, 5, 0x0114, RK_GENMASK_VAL(6, 6, 1)), /* PWM3_IR_M1 */
+	MR_PMUGRF(0, RK_PC1, 3, 0x0114, RK_GENMASK_VAL(6, 6, 0)), /* PWM3_IR_M0 */
+	MR_PMUGRF(2, RK_PB0, 5, 0x0114, RK_GENMASK_VAL(6, 6, 1)), /* PWM3_IR_M1 */

-	MR_PMUGRF(RK_GPIO0, RK_PC2, 3, 0x0114, RK_GENMASK_VAL(8, 8, 0)), /* PWM4_M0 */
-	MR_PMUGRF(RK_GPIO2, RK_PA7, 5, 0x0114, RK_GENMASK_VAL(8, 8, 1)), /* PWM4_M1 */
+	MR_PMUGRF(0, RK_PC2, 3, 0x0114, RK_GENMASK_VAL(8, 8, 0)), /* PWM4_M0 */
+	MR_PMUGRF(2, RK_PA7, 5, 0x0114, RK_GENMASK_VAL(8, 8, 1)), /* PWM4_M1 */

-	MR_PMUGRF(RK_GPIO0, RK_PC3, 3, 0x0114, RK_GENMASK_VAL(10, 10, 0)), /* PWM5_M0 */
-	MR_PMUGRF(RK_GPIO2, RK_PA6, 5, 0x0114, RK_GENMASK_VAL(10, 10, 1)), /* PWM5_M1 */
+	MR_PMUGRF(0, RK_PC3, 3, 0x0114, RK_GENMASK_VAL(10, 10, 0)), /* PWM5_M0 */
+	MR_PMUGRF(2, RK_PA6, 5, 0x0114, RK_GENMASK_VAL(10, 10, 1)), /* PWM5_M1 */

-	MR_PMUGRF(RK_GPIO0, RK_PB2, 3, 0x0114, RK_GENMASK_VAL(12, 12, 0)), /* PWM6_M0 */
-	MR_PMUGRF(RK_GPIO2, RK_PD4, 5, 0x0114, RK_GENMASK_VAL(12, 12, 1)), /* PWM6_M1 */
+	MR_PMUGRF(0, RK_PB2, 3, 0x0114, RK_GENMASK_VAL(12, 12, 0)), /* PWM6_M0 */
+	MR_PMUGRF(2, RK_PD4, 5, 0x0114, RK_GENMASK_VAL(12, 12, 1)), /* PWM6_M1 */

-	MR_PMUGRF(RK_GPIO0, RK_PB1, 3, 0x0114, RK_GENMASK_VAL(14, 14, 0)), /* PWM7_IR_M0 */
-	MR_PMUGRF(RK_GPIO3, RK_PA0, 5, 0x0114, RK_GENMASK_VAL(14, 14, 1)), /* PWM7_IR_M1 */
+	MR_PMUGRF(0, RK_PB1, 3, 0x0114, RK_GENMASK_VAL(14, 14, 0)), /* PWM7_IR_M0 */
+	MR_PMUGRF(3, RK_PA0, 5, 0x0114, RK_GENMASK_VAL(14, 14, 1)), /* PWM7_IR_M1 */

-	MR_PMUGRF(RK_GPIO0, RK_PB0, 1, 0x0118, RK_GENMASK_VAL(1, 0, 0)), /* SPI0_CLK_M0 */
-	MR_PMUGRF(RK_GPIO2, RK_PA1, 1, 0x0118, RK_GENMASK_VAL(1, 0, 1)), /* SPI0_CLK_M1 */
-	MR_PMUGRF(RK_GPIO2, RK_PB2, 6, 0x0118, RK_GENMASK_VAL(1, 0, 2)), /* SPI0_CLK_M2 */
+	MR_PMUGRF(0, RK_PB0, 1, 0x0118, RK_GENMASK_VAL(1, 0, 0)), /* SPI0_CLK_M0 */
+	MR_PMUGRF(2, RK_PA1, 1, 0x0118, RK_GENMASK_VAL(1, 0, 1)), /* SPI0_CLK_M1 */
+	MR_PMUGRF(2, RK_PB2, 6, 0x0118, RK_GENMASK_VAL(1, 0, 2)), /* SPI0_CLK_M2 */

-	MR_PMUGRF(RK_GPIO0, RK_PB6, 2, 0x0118, RK_GENMASK_VAL(2, 2, 0)), /* UART1_TX_M0 */
-	MR_PMUGRF(RK_GPIO1, RK_PD0, 5, 0x0118, RK_GENMASK_VAL(2, 2, 1)), /* UART1_TX_M1 */
-	MR_PMUGRF(RK_GPIO0, RK_PC3, 1, 0x0118, RK_GENMASK_VAL(4, 4, 1)), /* I2C2 */
+	MR_PMUGRF(0, RK_PB6, 2, 0x0118, RK_GENMASK_VAL(2, 2, 0)), /* UART1_TX_M0 */
+	MR_PMUGRF(1, RK_PD0, 5, 0x0118, RK_GENMASK_VAL(2, 2, 1)), /* UART1_TX_M1 */
+	MR_PMUGRF(0, RK_PC3, 1, 0x0118, RK_GENMASK_VAL(4, 4, 1)), /* I2C2 */
 };

 static int rv1126_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
index 1636ec99eb68..88544766f18e 100644
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ b/include/dt-bindings/pinctrl/rockchip.h
@@ -9,13 +9,6 @@
 #ifndef __DT_BINDINGS_ROCKCHIP_PINCTRL_H__
 #define __DT_BINDINGS_ROCKCHIP_PINCTRL_H__

-#define RK_GPIO0	0
-#define RK_GPIO1	1
-#define RK_GPIO2	2
-#define RK_GPIO3	3
-#define RK_GPIO4	4
-#define RK_GPIO6	6
-
 #define RK_PA0		0
 #define RK_PA1		1
 #define RK_PA2		2
--
2.39.5

