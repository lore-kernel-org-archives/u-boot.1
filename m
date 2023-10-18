Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A03CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 06:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8A386A3C;
	Wed, 18 Oct 2023 08:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zjMYWotz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE4F886D2E; Wed, 18 Oct 2023 08:57:41 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E3E865D0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 08:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so5972336f8f.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697612259; x=1698217059;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hC7gfFasRFf7e4n8J/wHOZ5LuE7ogVSxA0H+54ce7wg=;
 b=zjMYWotzSiWxae++BB6APcd6hGqH08ApwC735g5DAVVQVVl8XeMpmLHkrsz0UwB3GD
 lsjLqUAb+2dbSME1C4kaZxkph58BC4ZcE5SmxQaBWGdCSMSASMY1sE9vNWMQhQ4/NE/W
 EfBS6RA3ZYumvRsC5mJTFqm3c8uH8gvK+lMH7v4/2VWlavXN6j5+A1b76bmEiwYgymvv
 GWSLqF7cq0Bn3Xe4qAT35bTiT+O73PSyGazpu5BmpXlQjdn5Lusz5tmu/IXpAYppNVK5
 ZPqASLT9QrV1G8bwS67A5d1O/sziAHbe8uhNp5zsWWKARBEg619i8dVTlMbfNzp9heeg
 GSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697612259; x=1698217059;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hC7gfFasRFf7e4n8J/wHOZ5LuE7ogVSxA0H+54ce7wg=;
 b=IA6VZiVcrN7y5Dt6Z6fqMSLFAVO9EtFHngMN2HG1TBIgt6vVUBS5nPgh2N/zPvDIV/
 NGQdoe+Z7+cKcdaMKX5Re1EOm8rwqqkBXKxQfgOmm+I3xQFSE6zdoTAFzwGpoGHcIDRq
 G/suDOX4BV97JSoh4sH3ci/rRiwoNIODzGqzAnwv+Y3Tvb5wuKN805PvjiBDIwLLQz+C
 pvUBycPHe1wbo/QO57RUgvIemjN3zoEBkK0A+ZFRXWLmUV6KGBfcQqiqj6bqI+5s49T9
 4NwSu/HrUYrnnoXIaSUjRj8m+RKTVOFIq1e4Sc+p8a89nmyCT9wkIW4MSy9Wy+bcRuVh
 tUYA==
X-Gm-Message-State: AOJu0YygZUFRfJyWQqnOe7y6LMhvPvpgff7Cj/H5CHtZejyeCppUwsBk
 JbWZCe8JTfdE9Tg6fO4+Abkuag==
X-Google-Smtp-Source: AGHT+IEH45ub7TWEO9XQqWSBohIfOOEuZztbZ7h1jbI9Boj35Nsf9ZYS/6dueL8SAuL3VsqJbHKxqQ==
X-Received: by 2002:a5d:6045:0:b0:320:8e6:b0cf with SMTP id
 j5-20020a5d6045000000b0032008e6b0cfmr3279199wrt.42.1697612259110; 
 Tue, 17 Oct 2023 23:57:39 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e2:8300:dbea:ecb8:b89e:dd0f])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a5d6741000000b003200c918c81sm1362127wrw.112.2023.10.17.23.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 23:57:38 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, glaroque@baylibre.com, neil.armstrong@linaro.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, avromanov@salutedevices.com
Subject: Re: [PATCH] phy: meson-g12a-usb2: fix ret check on power_domain_get
In-Reply-To: <20231017185725.809524-1-glaroque@baylibre.com>
References: <20231017185725.809524-1-glaroque@baylibre.com>
Date: Wed, 18 Oct 2023 08:57:37 +0200
Message-ID: <87v8b4xvry.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On mar., oct. 17, 2023 at 20:57, "Guillaume La Roque" <glaroque@baylibre.com> wrote:

> Patch which add A1 SoC support create a regression on khadas vim3/vim3l
> boards when we try to use fastboot command:
>
>   => fastboot usb 0
>   failed to get power domain
>   failed to get power domain
>   No USB device found
>   USB init failed: -19
>
> Add ENOENT check on ret in probe function.
>
> Fixes: 5533c883ce10 ("phy: support Amlogic A1 family")
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Tested on vim3 with:

=> fastboot usb 0

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

> ---
>  drivers/phy/meson-g12a-usb2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 4ba3992bda70..3958d2404b85 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -328,12 +328,12 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>  
>  #if CONFIG_IS_ENABLED(POWER_DOMAIN)
>  	ret = power_domain_get(dev, &priv->pwrdm);
> -	if (ret < 0 && ret != -ENODEV) {
> -		pr_err("failed to get power domain\n");
> +	if (ret < 0 && ret != -ENODEV && ret != -ENOENT) {
> +		pr_err("failed to get power domain : %d\n", ret);
>  		return ret;
>  	}
>  
> -	if (ret != -ENODEV) {
> +	if (ret != -ENODEV && ret != -ENOENT) {
>  		ret = power_domain_on(&priv->pwrdm);
>  		if (ret < 0) {
>  			pr_err("failed to enable power domain\n");
> -- 
> 2.34.1
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#1773): https://groups.io/g/u-boot-amlogic/message/1773
> Mute This Topic: https://groups.io/mt/102024645/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-
