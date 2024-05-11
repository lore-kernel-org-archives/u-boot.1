Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F217BC04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 11:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0C48858A;
	Sat, 11 May 2024 13:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="c+U9334G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40087884F1; Sat, 11 May 2024 13:28:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C9BF8817B
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 13:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6c02=MO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715426919; bh=XDEdJUZBvhVF3Xn2AS0H+clqiqTGW/CBhs4BT5QtU/k=;
 b=c+U9334GyD130cSBEAiDAvrQ5+u4oc7lQV8u1+8VouHhU5MaN0ZiwPwqyoFN/wSftp3TxWeUF
 uBvOIu7Qy7AZoUC4/kKIJC3i4bs9NLoAGU9mnp6xrJibI973X/E/IIbKxeg+K+G9hr4xtS/Jr52
 cNnEHo/lr7wH0ZbSYpqX7Fr3e0dB1s34bvhEHUYKvA74YSm3c1rI9hNSxp2gzDbZYQkHQG9xWr2
 kh58nxzuHwUmZe/oVoyULfY8e6B8KTEYBpYX2ya7HcJoW7hgqJkDKpdHPxOyo9UjgPhVnbWKwvO
 p3BoGIvkMhi7Mf1ppRCyqoca4WUQCGtJ6NnlkQdZfj0A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 2/4] gpio: rockchip: Add request() ops
Date: Sat, 11 May 2024 11:28:13 +0000
Message-ID: <20240511112821.1156519-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240511112821.1156519-1-jonas@kwiboo.se>
References: <20240511112821.1156519-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663f5662acd5e90e057dfc52
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

Some boards use pinctrl to set a non-gpio pinmux on a pin that is later
requested to be used for gpio output.

Add a request() ops that call pinctrl_gpio_request() when the required
gpio-ranges prop has been defined to signal pinctrl driver to use gpio
pinmux.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs affected,
gpio-ranges props for remaining RK SoCs will be added in a follow up
series adding support for the pinmux status cmd.
---
 drivers/gpio/rk_gpio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index 2e901ac5c734..956894501633 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -126,6 +126,15 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
 	return (data & mask) ? GPIOF_OUTPUT : GPIOF_INPUT;
 }
 
+static int rockchip_gpio_request(struct udevice *dev, unsigned offset,
+				 const char *label)
+{
+	if (CONFIG_IS_ENABLED(PINCTRL) && dev_read_bool(dev, "gpio-ranges"))
+		return pinctrl_gpio_request(dev, offset, label);
+
+	return 0;
+}
+
 /* Simple SPL interface to GPIOs */
 #ifdef CONFIG_SPL_BUILD
 
@@ -216,6 +225,7 @@ static int rockchip_gpio_probe(struct udevice *dev)
 }
 
 static const struct dm_gpio_ops gpio_rockchip_ops = {
+	.request		= rockchip_gpio_request,
 	.direction_input	= rockchip_gpio_direction_input,
 	.direction_output	= rockchip_gpio_direction_output,
 	.get_value		= rockchip_gpio_get_value,
-- 
2.43.2

