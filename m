Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716A7CD6E56
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A81840ED;
	Sun, 31 May 2026 23:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="os8C41yy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B5C846F9; Sun, 31 May 2026 23:03:30 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529088039B
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-beae88ab40dso19185966b.0
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261408; x=1780866208; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6AnUv/nIKsB5I1Mh5xaEqO+JZ2REyeTJfP44UZv481w=;
 b=os8C41yy+gjBQZM0K6Ifyktwlhkn+l0pVYA/fbgDaYYOdjL9lg3H2ah8pOQqH9Xf7L
 x3btnWNph9TBJGk67U2KtQJsNiWtK6wi0rSfGAqkJNpBfKhk6O1Nc8A5uTVhZhX7cq8P
 OTahmO/1TKjWBjdnBttOYK7okxEE8f7CyAvEL27qihKSDLRdFgsqw/faG47QTpvfjd5y
 lGiHe7VXQOei09bJee2h+Um/uw3uit1wMPCYkUgAlNW699vJeE8kWWhbP4Jtw+YzgzPF
 hmq49jhmp9g/NkPpDGbMZg702JLltyolCPTupJFY2SJ67J/U0WIT5OucuZ2/Rv/OnfAW
 yFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261408; x=1780866208;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AnUv/nIKsB5I1Mh5xaEqO+JZ2REyeTJfP44UZv481w=;
 b=R9xwBr+CWnIyarSvKLrL1b8A53i4JhP0EJRC/Y2CtJx8+PWunwjH7tQWrPNyE6iQq9
 /wGtVVlqJocvU4NybaeV3WuD24zgjXpthpom/YhyAdTsbjQTty6qz8OiFBKaOUexl+uG
 ZX4cTJoPci8MxgGpIQyf1I6EzJSRusm8+lR8SUJYFfnBAg2uP37QwpWjh1HtKIqaXfie
 WNcDSfQ/DY/kEsSaQ5FN3p9OQr2buiOulA2vV3Pu5YXwrCqIYd/DwAdlIusXwlZC4Jey
 RAgDbPrn32Go3MESkxu43Mp/gAEQrbDyIrkCS+y5tVPpaKGXf/ozJgocv79N2qi8Tx/1
 e1/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Uqld24/5P4iBkWe2mf8y1s3ADCtiOvBOhhpx4HJiiS2jeT2Nlb5d2o1ZgX/XxW9SAJJk0O1A=@lists.denx.de
X-Gm-Message-State: AOJu0Ywv7vQk2H+qUfW053tdNjQSo77Z3cTidJmKH1hgxmSfTVcpjBoS
 nXB4UqJITJs8NXP8qbXNtT6H6PQgpQ4t2kk7mBhe+u58Yt2oHWHulWqj
X-Gm-Gg: Acq92OHArM+C7lY9oN+RcecrYu3lks38hx5FhgJRHmxTjuOnBg8w2awgr6LoSMqYmHw
 0Ws9/5gqXB6NYZyfMVmlueGA4vr/vYnsUroDun3xJt+QFBDHfvFvkWEkG/B5e7kc5g4z1u6irul
 lOPPRD2f/HUr3hEK91MAh0nEPeyM5OCvZrJAtKhdP25G8WxhQPVwDwgUwtQUsMnp4IGWLOKrKeR
 bn/Wv5buP/NC4a2KVQO45BUlHbZ8kmnluhTdslTCK/NZoCEtnO2SWOl/7KAfKdulTj97ym31PAx
 v/Cf1UibY9f/dxpTxnnDHFKCGkaELCVuCWPcngDRco9WaNR4NTmZGM5Yk6BXIStYobbV6ywYZ6L
 27dmKYpKhg9S7LwRTXEJUnJbbo/DJiHk6oB8SEhaNbF9eOAi/hdFqnOpzEuO2bUEoXsRwnP4yRn
 3H2S4Yw4i6Kw1oAc7/9N7cH2PJhbnFxl6n6VBR1MnF1DZR5pYWqjCsBziwDmPLqVM/0xu8XLa1
X-Received: by 2002:a17:906:5a41:b0:bce:9169:361d with SMTP id
 a640c23a62f3a-beab15b3b64mr132175266b.3.1780261407584; 
 Sun, 31 May 2026 14:03:27 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-be9d63c1792sm254186766b.49.2026.05.31.14.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:03:26 -0700 (PDT)
Message-ID: <4a201f58-11ba-4e3b-980c-00eae365e956@gmail.com>
Date: Sun, 31 May 2026 23:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 07/12] rockchip: reset: make reset-rockchip available in SPL
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
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

Make reset-rockchip available for use with dwc2 phy
in SPL to load U-boot (full) from a USB disk.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/reset/Kconfig  | 9 +++++++++
 drivers/reset/Makefile | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 66911199c8ba..10aa1ee9598b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -100,6 +100,15 @@ config RESET_ROCKCHIP
 	  though is that some reset signals, like I2C or MISC reset multiple
 	  devices.

+config SPL_RESET_ROCKCHIP
+	bool "Reset controller driver for Rockchip SoCs in SPL"
+	depends on SPL_DM_RESET && ARCH_ROCKCHIP && SPL_CLK
+	default n
+	help
+	  Support for reset controller on rockchip SoC. The main limitation
+	  though is that some reset signals, like I2C or MISC reset multiple
+	  devices.
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on DM_RESET && TARGET_HSDK
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 088545c64733..afb54b24ac95 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2016, NVIDIA CORPORATION.
 #

-obj-$(CONFIG_DM_RESET) += reset-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_RESET) += reset-uclass.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-reset.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-reset-test.o
 obj-$(CONFIG_STI_RESET) += sti-reset.o
@@ -16,7 +16,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
 obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
-obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3506.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
+obj-$(CONFIG_$(PHASE_)RESET_ROCKCHIP) += reset-rockchip.o rst-rk3506.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_MEDIATEK) += reset-mediatek.o
--
2.39.5

