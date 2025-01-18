Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0619C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B4BE8075F;
	Sat, 18 Jan 2025 05:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PcM9lVfq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MexbfwRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F2F80790; Sat, 18 Jan 2025 05:02:20 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D7480657
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YZjbt0kLjz9slV;
 Sat, 18 Jan 2025 05:02:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qq8BNQf6nACtX72pcKMEGbASiO6/i3TiCaXAd8qcmuE=;
 b=PcM9lVfqDt07m7c0jjot272k3ssG8c3azzyZHqza1SG8QM01AbeaSdEd8YXkZwKpsJo1iG
 fsZvmwFizVVK8ApEfif5q2zWZnDRYgeKB9h/lOtVc5ez3nczIvZ6LLPy3tKv5bRjVm/xCo
 W8shBmwHa1Qkr56N/0Tv0n/wTtCR+ZA5a8On/OKtYTrSXr/XtaJ1NXzQrXzHGG5C59OxGq
 YStCplrwZYjkjIB1vamEtjbOQLlmhQPnfssreqg68UTbyPRQchOHSA0R1tdT6YfV1YZ+Z+
 UFAbe270C+dLFNq/zzB43sLhbV9lYnfuHpc6ihb+B/XWmV69DqRTSU+NssMo9g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qq8BNQf6nACtX72pcKMEGbASiO6/i3TiCaXAd8qcmuE=;
 b=MexbfwRMds1delpUUEolNiclwjF4W1oJz3SMwQYPhYlTW3g7rhFn38aJB3rtzWGv48CMg4
 3+iANdEUmIGiaAQFU06lUThRgNRewje4F/nYd4uX6lSZ3ufwnXQtGu6sLK63wazUcIHMMd
 3vpXFucSDvMNUznzHuXVEMFDHyxK5nH2NIGUYZLM8pm9v/Di/h3sq/En1jw+/8ztQ7AxEu
 6poYmTaJfhKuokK9dhARMbxkosEJtS4VFVOXEcQ5+BvGtTGJf65I+j8v68M/NlqWnE34fR
 bQqvg/Pe5joYaRkJupKakhelHgrwtQl1qucm2vQNXAGqVjrQCLWWihNLQUVFqw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Williams <awilliams@marvell.com>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/8] led: Handle return value from cyclic_register()
Date: Sat, 18 Jan 2025 05:00:59 +0100
Message-ID: <20250118040130.74921-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5cad8cd18051d0d55cc
X-MBO-RS-META: oby44k48e97sya79ai7bunk3y4afxbg5
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

Handle the error code returned by cyclic_register() and propagate it.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Williams <awilliams@marvell.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/led/led_sw_blink.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
index ee1546d02d4..859dac47c30 100644
--- a/drivers/led/led_sw_blink.c
+++ b/drivers/led/led_sw_blink.c
@@ -50,6 +50,7 @@ int led_sw_set_period(struct udevice *dev, int period_ms)
 	struct led_sw_blink *sw_blink = uc_plat->sw_blink;
 	struct led_ops *ops = led_get_ops(dev);
 	int half_period_us;
+	int ret = 0;
 
 	half_period_us = period_ms * 1000 / 2;
 
@@ -71,8 +72,8 @@ int led_sw_set_period(struct udevice *dev, int period_ms)
 	}
 
 	if (sw_blink->state == LED_SW_BLINK_ST_DISABLED) {
-		cyclic_register(&sw_blink->cyclic, led_sw_blink,
-				half_period_us, sw_blink->cyclic_name);
+		ret = cyclic_register(&sw_blink->cyclic, led_sw_blink,
+				      half_period_us, sw_blink->cyclic_name);
 	} else {
 		sw_blink->cyclic.delay_us = half_period_us;
 		sw_blink->cyclic.start_time_us = timer_get_us();
@@ -81,7 +82,7 @@ int led_sw_set_period(struct udevice *dev, int period_ms)
 	sw_blink->state = LED_SW_BLINK_ST_NOT_READY;
 	ops->set_state(dev, LEDST_OFF);
 
-	return 0;
+	return ret;
 }
 
 bool led_sw_is_blinking(struct udevice *dev)
-- 
2.45.2

