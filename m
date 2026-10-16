Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D194FCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9717B612CD;
	Fri, 16 Oct 2026 13:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XY-B-ALteeAJ; Fri, 16 Oct 2026 13:24:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D425612A4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157070;
	b=IYthqGciUh8Mq3S/SCRdDJO4c9xqEkjn2+g6PWbrUlQsymlHPrKR2Iz94uWauJqcfMx1
	 R8spF967q/JuCAGs/u2C8BhThWEMXPm49+ePaStXEYhwtciAsSYOx0D4+Vcxy6+WD3Qbp
	 /O5ywPTP+Im4a3YiDZafxo1GdX6qSKq+TcdvxFjpQKlkmg5wI2U36QP2rE/xex71m9Hrn
	 /yLY8QsJnmnBhLLSEStMmhLsU+19oI3UaitEgXkOS6w+tq8DKfBbdDLk/Sby0dXNpuFTn
	 lRguwNBgxJLMj3+/tO8NZvcBrok5G4Vj4cYHnZm25lpjpUMESTHGTEiZeJxFKY7uN1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ljIDRjf0Yief38ZtqYKzP1Y5f3xxiLVfBeA9j6h2kXQ=;
	b=TjXoZbFhcPOKlIC4k1bMpdYSAGHbmhVu6Hv2VKK2SfQPiZ4N5q70uN7ZuO+SegvgHTYV
	 rjtL6F+qkAe5DGm6ALjJXVGbtVf77Zoj9lmNL8W1WOduQ2fNMNRfkP4KNplqkhA2hYPsa
	 K7hCYvymnASbXhzgKsrFVZn/3POeR/CsCNC2dzGdanpqRq4JsPf2OJswVu92jgKoQrKZG
	 OMKEjOtyclOwod4M8gagA+027lqkHq6nsH4w6GVlk6jRQoJYhIzstwBcizgLv4jVXe1I3
	 y6+fEBHJJcei15jImChL9cENGClxanlfPWL1M87Z6OAxxQR1wNmJ+JNr+dB6VHpd89g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157070;
	bh=ljIDRjf0Yief38ZtqYKzP1Y5f3xxiLVfBeA9j6h2kXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jjJb/9V0VALRxPltH/UfxZi4kLIcKseh72TUU1VyS+0sMYb3IGE2J3d9lec+3x2nT
	 ULenUxqItMybqKGJEaiAFKh0AfdyTTDJvZN9Gf5ZU8OTArZPRz1AMOLd2TdNbYB/Xj
	 1TqmG1oq5gJ/xHGwn4pVqO/ZNxotB5I+cYCxu5pfZWL+HeE9QnIFuv0mjnJ7kKL20a
	 2e8IMBgsaFgT1rBEkTknDHFxiIz9iMKmPzJ29jhfs/Q6d7oGyISvbp1VIpgizf5gfC
	 Vi/RnBf8g3gfOqv6S7R3JUGQMVEAGp7gIEVF1jpijgB3rX9VP597FsMrloG8RHMopq
	 uwSyzVXOpN/Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D425612A4;
	Fri, 16 Oct 2026 13:24:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E706105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0072240474
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kMQLaVqhoH9e for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2029D40100
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142233;
 b=aoosRzOpfLMhsszglbxvSLp1Rh8iv4HCn+iTKoenFgrPuvHxp8gv2jEpxc7I+ZNKZS3o
 6mBd7h79tb7n3UHDvF6ZbEA1wP3QQG+BcDRTpTphNK4TJax/9MpBMzDhnr8xQK/vejzHK
 CXADnS7WSMnjj91hicdQzViHGVfbWvzg+7uTkMPl9fOBg/3hauN1PZVkz5pgYyzrSvZvu
 NUbccqYZQaFTRu0E2z7NInvPIEw6yTB3xZUj0/a8TOOvzhfo5m938VVvsHYWp9HkNu9kf
 JYiMP6dq0qRH1vbSWBViXJ5NsUujnKXLbd1WdPF10cLAGaQUdFl4TCOwo5HzTKf6raA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142233;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=ljIDRjf0Yief38ZtqYKzP1Y5f3xxiLVfBeA9j6h2kXQ=;
 b=r5KZFAkEsHrlnXQ/eDFBqFk9bKc4M7DeRrlWl4ylsr4J2su6sw81ct0gTn+RlsvkBblY
 WvdzekYtvTy2VJeediN1Qe7LS14+K2KU1ATKuup9aLurEhJpUwSznr9WhNqTyqQW6jasM
 MQWqFbkhnH9oIPf0WtHwr/f2h4+aL7hv8YAYteew1WLXiXflDzComo1VjUjdga7Fp0Mf0
 qoRiyVMxgmeXpu2k/AGVAzZNuKOPo+u/wXltNWaX7xIiLkX7ryD5KNyfclD9zRSm1UXb4
 b7KieY8rsGvd+FTLlp9lhbgmikFX08tFhXwOhGPjEZ623u6rREf8VWggZDyFKVhshJg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=emw984hS; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=pmazzini@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=emw984hS
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2029D40100
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:12 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso24158935e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142230; x=1792747030;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ljIDRjf0Yief38ZtqYKzP1Y5f3xxiLVfBeA9j6h2kXQ=;
 b=emw984hSu3UDe9G2WsGi9cSww4WRhxHTVgepUGMmO3R5Rxbzj010WMlNLRT5Z7pv7e
 UbRg33rVs9M0L6HLmj4PGuv9gUYeNgvMeAqqnI6jrLQvJ7xyUveKJrDensrJEz5831Md
 +Jy1il/GA6vWG+7qm7TokGK+Y4VRjbys6N45IzNtDMQzmAmbD4aSMaIiW0c2k+e17Juo
 6B24IxQyQKl/ypWQl9WdI/QAGMP7XNZDHjIfWCEX7ft8bDiIVQ097cDwQ9/2fB7QBsgI
 vFcPY96+t8TpZySoDwrr4TQNbigMEfO9Qnum4CJuE3VaQKPKdfDuXRLjB8X+SsM8DJDY
 te6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142230; x=1792747030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ljIDRjf0Yief38ZtqYKzP1Y5f3xxiLVfBeA9j6h2kXQ=;
 b=EzNJae0eRnZPYhH7KQvrPfKmvcHbp9Op3bvPWTNuoYoYdOBEU+DmIW5Plmy0F9FJpt
 VdR4UyEUlF18hwyp0YoxsvrHotvbhlk6B5n2sUgwXy4ymate6BRiJaxmGY0dOn/AtwMC
 0sEohhDELGMN+GKVs2BLnuT8vtmoMIa4mulZ43Z53irhtjhI4PFluvbSdERo/X/XEk4u
 Q7QsnXLuu1uppOXYrj8Okzbh+fo+NvlGYMXiwIjrOjfWLRzzLEFABVVe1sjkuLeLi8MS
 mqHZq56i9wYEnE9Fv+1I8bfYh7BouOHkz2NZrrKFUoFEAZ4jC9NbycPUzgIEYEUIxeEi
 LRNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEnxlLdENN/oNAwZCHir3N7dC8XyjGLl9luawHcAp69lV71pwdyCK+fx1Fsic1tyl9+ZWf/KY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIY36E3P/VeabegyKkHRh7VKSt9I+dGO/1VduNr3LaGQih+1gl3
 yEXmAhlFF4cwIkO1WZ4QzxTJboKfL5AIwTgslqyj2E7LDQlCx7e6QJqq
X-Gm-Gg: AYBFou2WTcZyRZ7xQJC+Gak9vnO4DLibOf4Rjc9obzZvq/v4zaBxhE2ZOea0UTA2SbA
 yrwn4OuVxrw4UWoElR+F+MjiLuHwZAOhW4cFZBCiqz2Y8pZZWc4fShubXL2QlHxR6uzbGd2wJsZ
 J6sXGENPRK2xxmtHjucityCgHd1qNIEfkSh1XTptxVgsaGnLTIO/pcDTvmXtqO7OcLZ2LT4Z6I6
 yTlnGtlorGMEoAeAArfe2DG8rKXJ3jterWwSY1AYNQKZXYpUSfNwazOevdPuBDMuY6SFD3CAptY
 mWQRh6RTk75gQiS29ZIz3VGuKVUWpAyB7dhUXIeNi9eC8uAk1H5BZqOlJQGVl9hIPXuBebinMLr
 Y9CH2AIZygLd4M/wE0i2tZqox0rDF8+O7wE9jk3lt8BX7d7GRoFJYN/jgjYCOxx4cClp6RAJeRN
 OBmCDTxX02RIz9wDanZ8OtuZRQ4xv+c+8o7egR3If1YwSUs7WEtdhwrMm1T60=
X-Received: by 2002:a05:600c:3ba3:b0:4a1:d15e:792f with SMTP id
 5b1f17b1804b1-4a1d15e7d43mr15824855e9.12.1792142230452; 
 Fri, 16 Oct 2026 02:17:10 -0700 (PDT)
Received: from debian.tfbnw.net ([2620:10d:c092:400::4:7d8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm3692331f8f.29.2026.10.16.02.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:17:08 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 5/7] pinctrl: sunxi: add the Allwinner B288 PIO
Date: Fri, 16 Oct 2026 10:16:06 +0100
Message-ID: <20261016091608.121842-6-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091608.121842-1-pmazzini@gmail.com>
References: <20261016091608.121842-1-pmazzini@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The pin functions used by the PocketBook Verse.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 drivers/pinctrl/sunxi/Kconfig         |  5 +++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 54314992299..748a4140fbd 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -54,6 +54,11 @@ config PINCTRL_SUN8I_A33
 	default MACH_SUN8I_A33
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN8I_B288
+	bool "Support for the Allwinner B288 PIO"
+	default MACH_SUN8I_B288
+	select PINCTRL_SUNXI
+
 config PINCTRL_SUN8I_A83T
 	bool "Support for the Allwinner A83T PIO"
 	default MACH_SUN8I_A83T
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index ab4e88c9918..29219c11b93 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -448,6 +448,22 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun8i_a33_pinctrl_desc = {
 	.num_banks	= 8,
 };
 
+static const struct sunxi_pinctrl_function sun8i_b288_pinctrl_functions[] = {
+	{ "gpio_in",	0 },
+	{ "gpio_out",	1 },
+	{ "i2c0",	2 },	/* PB6-PB7 */
+	{ "mmc0",	2 },	/* PF0-PF5 */
+	{ "mmc3",	5 },	/* PC1, PC4-PC14 */
+	{ "uart0",	2 },	/* PB4-PB5 */
+};
+
+static const struct sunxi_pinctrl_desc __maybe_unused sun8i_b288_pinctrl_desc = {
+	.functions	= sun8i_b288_pinctrl_functions,
+	.num_functions	= ARRAY_SIZE(sun8i_b288_pinctrl_functions),
+	.first_bank	= SUNXI_GPIO_A,
+	.num_banks	= 7,
+};
+
 static const struct sunxi_pinctrl_function sun8i_a83t_pinctrl_functions[] = {
 	{ "gmac",	4 },	/* PD2-PD23 */
 	{ "gpio_in",	0 },
@@ -912,6 +928,12 @@ static const struct udevice_id sunxi_pinctrl_ids[] = {
 		.data = (ulong)&sun8i_a33_pinctrl_desc,
 	},
 #endif
+#ifdef CONFIG_PINCTRL_SUN8I_B288
+	{
+		.compatible = "allwinner,sun8i-b288-pinctrl",
+		.data = (ulong)&sun8i_b288_pinctrl_desc,
+	},
+#endif
 #ifdef CONFIG_PINCTRL_SUN8I_A83T
 	{
 		.compatible = "allwinner,sun8i-a83t-pinctrl",
-- 
2.52.0

