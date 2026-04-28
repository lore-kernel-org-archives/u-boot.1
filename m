Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070AAFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4869D846A5;
	Tue, 28 Apr 2026 22:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LYdQmnLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BEB6846A7; Tue, 28 Apr 2026 22:49:03 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D92846A0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so10597127a34.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777409339; x=1778014139;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1AL+UF9P+2CdZ3Azs7JIV2zOyRFInCGU9l9STJTKJIg=;
 b=LYdQmnLpPupnsxRVw9GhslGu+8XF2q9fCuq5Daksx5KG0ZFh4q/5o0q376U7znROfw
 lhKgEEqP6I3iCthDxkqjyXT1BypkPqYHBQc39I7U3V2B33YkILuPFNYuPx/XdNEKiq13
 LTXXY/wG3LvTSJD6sdC+8SkujqSV5ufPEHcX+MfZKZ5EA+5jf9HNQ2vumaZULfaGgVFf
 Q/sS6djGzB5ZWLShcrQdJxFYqVtTM4ZLrLHlvqlRUmwCVvTvB6OvyVoh0YQMI43KDvyq
 AWYNO1ZhmYq6Y99Z3NVqnWdmnRRyyH4qiZ0SVoUBk4hy6WpnRmuSiND8l1/ha43yEDxL
 aYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777409339; x=1778014139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1AL+UF9P+2CdZ3Azs7JIV2zOyRFInCGU9l9STJTKJIg=;
 b=bVxsEUwvC01lTSo1zNjwW7sJyfylb0yRyKLPuAu7NcXetzMSXYqWuf2hLOotTwxcld
 +kQ1a12TO4lIK8x5qP6D5eXKg9wbNHy/FLwNeFUzybaiNqei+h5tZwuQ/CEObZ8pZSjy
 6p1zYLppq4GpIuSPqWIECxaWBzQ/KjkkYuGfu811GCav2nglOsjsuxcTofKUpWjZ3cg7
 7O2U+PV1KYQO//wxEUTHmREhXJ/ZGZQ1qJHQ3tJlvMOb6rEHA3+5Y7tj8VcI6BxjY5z0
 jhLRwl116bG6yHDiAtl2bB4FEsjqCDrM3yPYZVNhYTM76Pd4FmvFELDhui4c60g79LAv
 GjtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BF1kQO/Dtc9wbDPYngUcq70M3Qlb6CDwwespPOrEeClSEkbc9v6Y10Ydcczsr1X9Ic18WVPc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywqq8zMShGTw1DkRgChXHjoEjLmLKsBpqJibhgBxi7DDFNojSpS
 nO4dYCPx58BvwBk3Cj9WDMlZRN+AdB5A6T5tGTer9dZ9oEOcVebfW0+3eVaOaYFsh30=
X-Gm-Gg: AeBDieu+yEMXHqF2Rd8GWHE+TYRT37Mrfg8VSjNuemxApRkDAi8rdzg4opZRDWCHhEV
 0g/9Cahurr1NEzkkE/mlynKnHnUd7NYTvluUrB/iuTCdIwDaRxgQt3fAxWLBig1WaK2bZRpIxHU
 dzwwPB7qtpcI8Xvg1RVFH2Ob867eumfPEET1YE67dglK1vvd+kgx8keGplENTvq27SL1X+JhDdP
 yTehmjMN0MPWoBaL9mcXpoWYXjwuk1ehDpVH6dPWRHz/tNqzEfMq01qTTV61qL6WufszbMDJilS
 ygsxv3M8uoW6AYDVV8jjb0F+Jx4UTbRAJbtDrgNs8MyAuU73TM7oKNZNr7oekgD3YL+/iKHkeDT
 OW4co4adNIP9TYrJNm3WQi+us0MUXUQBEqFJ9pySscmOqN6jHvLE8fqPkQZXZsyJzqUVtw8Kf9s
 ovfNnYAPTgS7b6pvE/gCF6qbw6+euJ74eANWALnbdSEN+yswx47K4RFWtbYlYEECIUDdJ1W8tuj
 5XPNaJQJOiZWoCH+dTmtBI=
X-Received: by 2002:a05:6820:f003:b0:694:a17f:759d with SMTP id
 006d021491bc7-6965cb401a8mr2435645eaf.28.1777409339086; 
 Tue, 28 Apr 2026 13:48:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966aa7caa9sm47024eaf.2.2026.04.28.13.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 13:48:58 -0700 (PDT)
Message-ID: <72f227d7-20ba-451e-a847-a58e309d61f2@baylibre.com>
Date: Tue, 28 Apr 2026 15:48:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] pinctrl: airoha: add pin controller and gpio
 driver for AN7583 SoC
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
 <20260428153448.980150-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428153448.980150-4-mikhail.kshevetskiy@iopsys.eu>
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

On 4/28/26 10:34 AM, Mikhail Kshevetskiy wrote:
> The driver based on official linux airoha pinctrl and gpio driver with
> Matheus Sampaio Queiroga <srherobrine20@gmail.com> changes.
> The changes:
>  * Separate code for each SoC and keep some of the functions in
>    common between them,
>  * Add pinctrl driver for EN7523 SoC.
> 
> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>   https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl
> 
> This patch adds U-Boot pin controller and gpio driver for Airoha AN7583 SoC.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---

Same comments about subject, commit message, general code style from other
patches applies here as well.

> +static const struct airoha_pinctrl_func_group an7583_phy4_led0_func_group[] = {
> +	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio1", GPIO_LAN0_LED0_MODE_MASK,
> +				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(3)),
> +	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio2", GPIO_LAN1_LED0_MODE_MASK,
> +				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(3)),
> +	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio3", GPIO_LAN2_LED0_MODE_MASK,
> +				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(3)),
> +	AIROHA_PINCTRL_PHY_LED0(AN7581, "gpio4", GPIO_LAN3_LED0_MODE_MASK,
> +				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(3)),
> +};
> +
> +static const struct airoha_pinctrl_func_group an7583_phy1_led1_func_group[] = {
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio8", GPIO_LAN0_LED1_MODE_MASK,
> +				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(0)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio9", GPIO_LAN1_LED1_MODE_MASK,
> +				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(0)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio10", GPIO_LAN2_LED1_MODE_MASK,
> +				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(0)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio1", GPIO_LAN3_LED1_MODE_MASK,

Is this supposed to be gpio11? It doesn't match the pattern of the others.

> +				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(0)),
> +};
> +
> +static const struct airoha_pinctrl_func_group an7583_phy2_led1_func_group[] = {
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio8", GPIO_LAN0_LED1_MODE_MASK,
> +				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(1)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio9", GPIO_LAN1_LED1_MODE_MASK,
> +				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(1)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio10", GPIO_LAN2_LED1_MODE_MASK,
> +				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(1)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio11", GPIO_LAN3_LED1_MODE_MASK,
> +				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(1)),
> +};
> +
> +static const struct airoha_pinctrl_func_group an7583_phy3_led1_func_group[] = {
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio8", GPIO_LAN0_LED1_MODE_MASK,
> +				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio9", GPIO_LAN1_LED1_MODE_MASK,
> +				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio10", GPIO_LAN2_LED1_MODE_MASK,
> +				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio11", GPIO_LAN3_LED1_MODE_MASK,
> +				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
> +};
> +
> +static const struct airoha_pinctrl_func_group an7583_phy4_led1_func_group[] = {
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio8", GPIO_LAN0_LED1_MODE_MASK,
> +				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio9", GPIO_LAN1_LED1_MODE_MASK,
> +				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio10", GPIO_LAN2_LED1_MODE_MASK,
> +				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio11", GPIO_LAN3_LED1_MODE_MASK,
> +				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),

Are these supposed to be LANX_PHY_LED_MAP(3) instead of 2?

> +};
> +

...

> +static const struct airoha_pinctrl_conf an7583_pinctrl_pullup_conf[] = {
> +	PINCTRL_CONF_DESC(2, REG_GPIO_L_PU, BIT(0)),
> +	PINCTRL_CONF_DESC(3, REG_GPIO_L_PU, BIT(1)),
> +	PINCTRL_CONF_DESC(4, REG_GPIO_L_PU, BIT(2)),
> +	PINCTRL_CONF_DESC(5, REG_GPIO_L_PU, BIT(3)),
> +	PINCTRL_CONF_DESC(6, REG_GPIO_L_PU, BIT(4)),
> +	PINCTRL_CONF_DESC(7, REG_GPIO_L_PU, BIT(5)),
> +	PINCTRL_CONF_DESC(8, REG_GPIO_L_PU, BIT(6)),
> +	PINCTRL_CONF_DESC(9, REG_GPIO_L_PU, BIT(7)),
> +	PINCTRL_CONF_DESC(10, REG_GPIO_L_PU, BIT(8)),
> +	PINCTRL_CONF_DESC(11, REG_GPIO_L_PU, BIT(9)),
> +	PINCTRL_CONF_DESC(12, REG_GPIO_L_PU, BIT(10)),
> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_PU, BIT(11)),
> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_PU, BIT(12)),
> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_PU, BIT(13)),
> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_PU, BIT(14)),
> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_PU, BIT(15)),
> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_PU, BIT(16)),
> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_PU, BIT(17)),
> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_PU, BIT(18)),
> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_PU, BIT(18)),

Is this supposed to be BIT(19)?

> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_PU, BIT(20)),
> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_PU, BIT(21)),
> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_PU, BIT(22)),
> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_PU, BIT(23)),
> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_PU, BIT(24)),
> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_PU, BIT(25)),
> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_PU, BIT(26)),
> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_PU, BIT(27)),
> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_PU, BIT(28)),
> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_PU, BIT(29)),
> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_PU, BIT(30)),
> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_PU, BIT(31)),
> +	PINCTRL_CONF_DESC(34, REG_GPIO_H_PU, BIT(0)),
> +	PINCTRL_CONF_DESC(35, REG_GPIO_H_PU, BIT(1)),
> +	PINCTRL_CONF_DESC(36, REG_GPIO_H_PU, BIT(2)),
> +	PINCTRL_CONF_DESC(37, REG_GPIO_H_PU, BIT(3)),
> +	PINCTRL_CONF_DESC(38, REG_GPIO_H_PU, BIT(4)),
> +	PINCTRL_CONF_DESC(39, REG_GPIO_H_PU, BIT(5)),
> +	PINCTRL_CONF_DESC(40, REG_GPIO_H_PU, BIT(6)),
> +	PINCTRL_CONF_DESC(41, REG_I2C_SDA_PU, I2C_SCL_PU_MASK),
> +	PINCTRL_CONF_DESC(42, REG_I2C_SDA_PU, I2C_SDA_PU_MASK),
> +	PINCTRL_CONF_DESC(43, REG_I2C_SDA_PU, AN7583_I2C1_SCL_PU_MASK),
> +	PINCTRL_CONF_DESC(44, REG_I2C_SDA_PU, AN7583_I2C1_SDA_PU_MASK),
> +	PINCTRL_CONF_DESC(45, REG_I2C_SDA_PU, SPI_CLK_PU_MASK),
> +	PINCTRL_CONF_DESC(46, REG_I2C_SDA_PU, SPI_CS0_PU_MASK),
> +	PINCTRL_CONF_DESC(47, REG_I2C_SDA_PU, SPI_MOSI_PU_MASK),
> +	PINCTRL_CONF_DESC(48, REG_I2C_SDA_PU, SPI_MISO_PU_MASK),
> +	PINCTRL_CONF_DESC(49, REG_I2C_SDA_PU, UART1_TXD_PU_MASK),
> +	PINCTRL_CONF_DESC(50, REG_I2C_SDA_PU, UART1_RXD_PU_MASK),
> +	PINCTRL_CONF_DESC(51, REG_I2C_SDA_PU, PCIE0_RESET_PU_MASK),
> +	PINCTRL_CONF_DESC(52, REG_I2C_SDA_PU, PCIE1_RESET_PU_MASK),
> +	PINCTRL_CONF_DESC(53, REG_I2C_SDA_PU, AN7583_MDC_0_PU_MASK),
> +	PINCTRL_CONF_DESC(54, REG_I2C_SDA_PU, AN7583_MDIO_0_PU_MASK),
> +};
> +
> +static const struct airoha_pinctrl_conf an7583_pinctrl_pulldown_conf[] = {
> +	PINCTRL_CONF_DESC(2, REG_GPIO_L_PD, BIT(0)),
> +	PINCTRL_CONF_DESC(3, REG_GPIO_L_PD, BIT(1)),
> +	PINCTRL_CONF_DESC(4, REG_GPIO_L_PD, BIT(2)),
> +	PINCTRL_CONF_DESC(5, REG_GPIO_L_PD, BIT(3)),
> +	PINCTRL_CONF_DESC(6, REG_GPIO_L_PD, BIT(4)),
> +	PINCTRL_CONF_DESC(7, REG_GPIO_L_PD, BIT(5)),
> +	PINCTRL_CONF_DESC(8, REG_GPIO_L_PD, BIT(6)),
> +	PINCTRL_CONF_DESC(9, REG_GPIO_L_PD, BIT(7)),
> +	PINCTRL_CONF_DESC(10, REG_GPIO_L_PD, BIT(8)),
> +	PINCTRL_CONF_DESC(11, REG_GPIO_L_PD, BIT(9)),
> +	PINCTRL_CONF_DESC(12, REG_GPIO_L_PD, BIT(10)),
> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_PD, BIT(11)),
> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_PD, BIT(12)),
> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_PD, BIT(13)),
> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_PD, BIT(14)),
> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_PD, BIT(15)),
> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_PD, BIT(16)),
> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_PD, BIT(17)),
> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_PD, BIT(18)),
> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_PD, BIT(18)),

Is this supposed to be BIT(19)?

> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_PD, BIT(20)),
> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_PD, BIT(21)),
> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_PD, BIT(22)),
> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_PD, BIT(23)),
> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_PD, BIT(24)),
> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_PD, BIT(25)),
> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_PD, BIT(26)),
> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_PD, BIT(27)),
> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_PD, BIT(28)),
> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_PD, BIT(29)),
> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_PD, BIT(30)),
> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_PD, BIT(31)),
> +	PINCTRL_CONF_DESC(34, REG_GPIO_H_PD, BIT(0)),
> +	PINCTRL_CONF_DESC(35, REG_GPIO_H_PD, BIT(1)),
> +	PINCTRL_CONF_DESC(36, REG_GPIO_H_PD, BIT(2)),
> +	PINCTRL_CONF_DESC(37, REG_GPIO_H_PD, BIT(3)),
> +	PINCTRL_CONF_DESC(38, REG_GPIO_H_PD, BIT(4)),
> +	PINCTRL_CONF_DESC(39, REG_GPIO_H_PD, BIT(5)),
> +	PINCTRL_CONF_DESC(40, REG_GPIO_H_PD, BIT(6)),
> +	PINCTRL_CONF_DESC(41, REG_I2C_SDA_PD, I2C_SCL_PD_MASK),
> +	PINCTRL_CONF_DESC(42, REG_I2C_SDA_PD, I2C_SDA_PD_MASK),
> +	PINCTRL_CONF_DESC(43, REG_I2C_SDA_PD, AN7583_I2C1_SCL_PD_MASK),
> +	PINCTRL_CONF_DESC(44, REG_I2C_SDA_PD, AN7583_I2C1_SDA_PD_MASK),
> +	PINCTRL_CONF_DESC(45, REG_I2C_SDA_PD, SPI_CLK_PD_MASK),
> +	PINCTRL_CONF_DESC(46, REG_I2C_SDA_PD, SPI_CS0_PD_MASK),
> +	PINCTRL_CONF_DESC(47, REG_I2C_SDA_PD, SPI_MOSI_PD_MASK),
> +	PINCTRL_CONF_DESC(48, REG_I2C_SDA_PD, SPI_MISO_PD_MASK),
> +	PINCTRL_CONF_DESC(49, REG_I2C_SDA_PD, UART1_TXD_PD_MASK),
> +	PINCTRL_CONF_DESC(50, REG_I2C_SDA_PD, UART1_RXD_PD_MASK),
> +	PINCTRL_CONF_DESC(51, REG_I2C_SDA_PD, PCIE0_RESET_PD_MASK),
> +	PINCTRL_CONF_DESC(52, REG_I2C_SDA_PD, PCIE1_RESET_PD_MASK),
> +	PINCTRL_CONF_DESC(53, REG_I2C_SDA_PD, AN7583_MDC_0_PD_MASK),
> +	PINCTRL_CONF_DESC(54, REG_I2C_SDA_PD, AN7583_MDIO_0_PD_MASK),
> +};
> +
> +static const struct airoha_pinctrl_conf an7583_pinctrl_drive_e2_conf[] = {
> +	PINCTRL_CONF_DESC(2, REG_GPIO_L_E2, BIT(0)),
> +	PINCTRL_CONF_DESC(3, REG_GPIO_L_E2, BIT(1)),
> +	PINCTRL_CONF_DESC(4, REG_GPIO_L_E2, BIT(2)),
> +	PINCTRL_CONF_DESC(5, REG_GPIO_L_E2, BIT(3)),
> +	PINCTRL_CONF_DESC(6, REG_GPIO_L_E2, BIT(4)),
> +	PINCTRL_CONF_DESC(7, REG_GPIO_L_E2, BIT(5)),
> +	PINCTRL_CONF_DESC(8, REG_GPIO_L_E2, BIT(6)),
> +	PINCTRL_CONF_DESC(9, REG_GPIO_L_E2, BIT(7)),
> +	PINCTRL_CONF_DESC(10, REG_GPIO_L_E2, BIT(8)),
> +	PINCTRL_CONF_DESC(11, REG_GPIO_L_E2, BIT(9)),
> +	PINCTRL_CONF_DESC(12, REG_GPIO_L_E2, BIT(10)),
> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_E2, BIT(11)),
> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_E2, BIT(12)),
> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_E2, BIT(13)),
> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_E2, BIT(14)),
> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_E2, BIT(15)),
> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_E2, BIT(16)),
> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_E2, BIT(17)),
> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_E2, BIT(18)),
> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_E2, BIT(18)),

Is this supposed to be BIT(19)?

> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_E2, BIT(20)),
> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_E2, BIT(21)),
> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_E2, BIT(22)),
> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_E2, BIT(23)),
> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_E2, BIT(24)),
> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_E2, BIT(25)),
> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_E2, BIT(26)),
> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_E2, BIT(27)),
> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_E2, BIT(28)),
> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_E2, BIT(29)),
> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_E2, BIT(30)),
> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_E2, BIT(31)),
> +	PINCTRL_CONF_DESC(34, REG_GPIO_H_E2, BIT(0)),
> +	PINCTRL_CONF_DESC(35, REG_GPIO_H_E2, BIT(1)),
> +	PINCTRL_CONF_DESC(36, REG_GPIO_H_E2, BIT(2)),
> +	PINCTRL_CONF_DESC(37, REG_GPIO_H_E2, BIT(3)),
> +	PINCTRL_CONF_DESC(38, REG_GPIO_H_E2, BIT(4)),
> +	PINCTRL_CONF_DESC(39, REG_GPIO_H_E2, BIT(5)),
> +	PINCTRL_CONF_DESC(40, REG_GPIO_H_E2, BIT(6)),
> +	PINCTRL_CONF_DESC(41, REG_I2C_SDA_E2, I2C_SCL_E2_MASK),
> +	PINCTRL_CONF_DESC(42, REG_I2C_SDA_E2, I2C_SDA_E2_MASK),
> +	PINCTRL_CONF_DESC(43, REG_I2C_SDA_E2, AN7583_I2C1_SCL_E2_MASK),
> +	PINCTRL_CONF_DESC(44, REG_I2C_SDA_E2, AN7583_I2C1_SDA_E2_MASK),
> +	PINCTRL_CONF_DESC(45, REG_I2C_SDA_E2, SPI_CLK_E2_MASK),
> +	PINCTRL_CONF_DESC(46, REG_I2C_SDA_E2, SPI_CS0_E2_MASK),
> +	PINCTRL_CONF_DESC(47, REG_I2C_SDA_E2, SPI_MOSI_E2_MASK),
> +	PINCTRL_CONF_DESC(48, REG_I2C_SDA_E2, SPI_MISO_E2_MASK),
> +	PINCTRL_CONF_DESC(49, REG_I2C_SDA_E2, UART1_TXD_E2_MASK),
> +	PINCTRL_CONF_DESC(50, REG_I2C_SDA_E2, UART1_RXD_E2_MASK),
> +	PINCTRL_CONF_DESC(51, REG_I2C_SDA_E2, PCIE0_RESET_E2_MASK),
> +	PINCTRL_CONF_DESC(52, REG_I2C_SDA_E2, PCIE1_RESET_E2_MASK),
> +	PINCTRL_CONF_DESC(53, REG_I2C_SDA_E2, AN7583_MDC_0_E2_MASK),
> +	PINCTRL_CONF_DESC(54, REG_I2C_SDA_E2, AN7583_MDIO_0_E2_MASK),
> +};
> +
> +static const struct airoha_pinctrl_conf an7583_pinctrl_drive_e4_conf[] = {
> +	PINCTRL_CONF_DESC(2, REG_GPIO_L_E4, BIT(0)),
> +	PINCTRL_CONF_DESC(3, REG_GPIO_L_E4, BIT(1)),
> +	PINCTRL_CONF_DESC(4, REG_GPIO_L_E4, BIT(2)),
> +	PINCTRL_CONF_DESC(5, REG_GPIO_L_E4, BIT(3)),
> +	PINCTRL_CONF_DESC(6, REG_GPIO_L_E4, BIT(4)),
> +	PINCTRL_CONF_DESC(7, REG_GPIO_L_E4, BIT(5)),
> +	PINCTRL_CONF_DESC(8, REG_GPIO_L_E4, BIT(6)),
> +	PINCTRL_CONF_DESC(9, REG_GPIO_L_E4, BIT(7)),
> +	PINCTRL_CONF_DESC(10, REG_GPIO_L_E4, BIT(8)),
> +	PINCTRL_CONF_DESC(11, REG_GPIO_L_E4, BIT(9)),
> +	PINCTRL_CONF_DESC(12, REG_GPIO_L_E4, BIT(10)),
> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_E4, BIT(11)),
> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_E4, BIT(12)),
> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_E4, BIT(13)),
> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_E4, BIT(14)),
> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_E4, BIT(15)),
> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_E4, BIT(16)),
> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_E4, BIT(17)),
> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_E4, BIT(18)),
> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_E4, BIT(18)),

Is this supposed to be BIT(19)?

> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_E4, BIT(20)),
> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_E4, BIT(21)),
> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_E4, BIT(22)),
> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_E4, BIT(23)),

..

> +U_BOOT_DRIVER(airoha_pinctrl) = {

airoha_an7583_pinctrl

> +	.name = "airoha-an7583-pinctrl",
> +	.id = UCLASS_PINCTRL,
> +	.of_match = of_match_ptr(airoha_pinctrl_of_match),
> +	.probe = airoha_pinctrl_probe,
> +	.bind = airoha_pinctrl_bind,
> +	.priv_auto = sizeof(struct airoha_pinctrl),
> +	.ops = &airoha_pinctrl_ops,
> +};

