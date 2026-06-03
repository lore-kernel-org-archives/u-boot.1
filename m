Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFF3CD6E60
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05437848A1;
	Thu,  4 Jun 2026 01:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVTLvO2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 824EF84879; Thu,  4 Jun 2026 01:50:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A357283EF9
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68c201ec1cfso12679a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530598; x=1781135398; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rHmGiIDPPbFsV6tgWE3hLqdyrb3A36tjERrmauZUDL8=;
 b=jVTLvO2F7dEnXTBfooDCgaMC40e65JQ97pEuLiczacPKoN9Xx6K8trDKRkp/a5OZOJ
 uE80mmn6e/JTUcxxXA9iLQBMZPONf26LVimtoNQKQ8ZIFfqw+tDnCY3hUJ0T9RquWXOa
 Jqi3D92uWmrKyqlavW+Zi6TtTEoxJT82O2FM54SZtDObE/F5inou0ZGJ2aqaX2LUYgkz
 VEh/QANKE3WCCjxkKVI3q7kwpCaY018bDSebKiCWYjwdnLPXK2N/DCepI6IsPsCfPqi5
 ab0x72wMBEIguRAa+R0Y/mtwQMLJvgSI0ZAySSDhww+6BNymNDsxmI22bKN2fONoTzcV
 GONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530598; x=1781135398;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rHmGiIDPPbFsV6tgWE3hLqdyrb3A36tjERrmauZUDL8=;
 b=caL5NdVfA3Iv8cdJsZ5mqxWyjz7D1mGsLF/DH4KDG/CkkoMFbKHnN/DaQaVsniWVKh
 wGT1Q+Lo6NBe4cxd5WlHFcjjitx+M1tGnS941Lp69FlRHzetKuf/cbXOhd7RWb0oJVoS
 1OWrA7u5E94emC3MP6bxZtqRaxcZctW/qef4b/TnZT3YKRX2lyMI9lKoux9iGFIaxDhV
 00IMvGS3ReLt2rrSUEPdpHQrMg8fnZUl4Dep/CcLppuFDn/DgUnG9rulnVgh2S2LcNHe
 RRZjTcbcRnHcagBZ1t7175BHQ5xR6ksUJ9/yvT1jFmRF/As3moUfiXuqv2bF2jkqzqMk
 i4Tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/xJkmPmIGxhDd2jFBtgIXmv+dE04XwNQdgvumrqd8Agag8/aiWwVY9pQShZvHXEvm4jxw1YE=@lists.denx.de
X-Gm-Message-State: AOJu0YwqDhk/JMRR+WfkjzhuRccVNCHuAH39ddXeSlh0D0mdd6DuCmQm
 vj4ddNJJ+eJFEZ6mMmLjjwlmGCs6KEdVZQUbEALSg4rVlwSdh1PEa0TD
X-Gm-Gg: Acq92OFgMtSTJihs7dBIPE6NOG9gacbePBsxChBhgVTKw6pMrK8skLg2ipVPEpICZ54
 GpEssuJ6rxdD9UEEsRTitG1SpwGQqhDZ2J0/YkO1OYrAEZIVutpvnBmnc7yb6nYz0fYpn+Ro9lB
 8MfN24gLUsVqIIcyx2JnKY4WmKAipCwR9irW1Y96I4xxgnd/b7G71TXRb6sGRdNc/+IcIreOH+V
 z2OZzd4Z4ZdYOUKVYNScPO9eCSojkX2QbVEVvrXSpnAgnXAzPPH+3/Os/exyHESon+ceh8T8Q59
 JTjVswcxMeZzATq+qs3DuHhPKVRrsguzWAr2i2Uab1AkRa4pj/3lUitLauivoqbo4jKVhBTUDtn
 t8EUZKt3+WgrPsheGP118Z8+nB/jrIunr9mNYmMufsX5pzm/0RBRa2DEAyZOWnuHdg7VDedmCJ8
 ARS43kCONpOH72UxfPmhI1JRtnGGLbvqNszJRJJSH/u9db9PvdCF8MfvVF2wpGGuCyVDm86TTL
X-Received: by 2002:a05:6402:1906:b0:660:ce16:e5ce with SMTP id
 4fb4d7f45d1cf-68f3b08717amr47378a12.2.1780530597918; 
 Wed, 03 Jun 2026 16:49:57 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05208e897sm219215366b.25.2026.06.03.16.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:49:56 -0700 (PDT)
Message-ID: <29cc3359-462e-41b4-a288-d47edfeb8aa1@gmail.com>
Date: Thu, 4 Jun 2026 01:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 04/10] rockchip: bind grf syscon usbphy subnode
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
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

The RK3066/RK3188/RK3288 SoC's have a grf usbphy subnode that
doesn't show up in DM by it's self, so call dm_scan_fdt_dev to
bind grf child devices in the device tree.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c | 3 +++
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c | 3 +++
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
index ff269b53b542..41655d433d26 100644
--- a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
@@ -20,6 +20,9 @@ U_BOOT_DRIVER(syscon_rk3066) = {
 	.name = "rk3066_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3066_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 };

 #if CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
index 6df054e5b27d..543f078bc659 100644
--- a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
@@ -20,6 +20,9 @@ U_BOOT_DRIVER(syscon_rk3188) = {
 	.name = "rk3188_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3188_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 };

 #if CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
index 6413d0a88a16..fddb61f419b3 100644
--- a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
@@ -24,6 +24,9 @@ U_BOOT_DRIVER(syscon_rk3288) = {
 	.name = "rk3288_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3288_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 };

 #if CONFIG_IS_ENABLED(OF_PLATDATA)
--
2.39.5

