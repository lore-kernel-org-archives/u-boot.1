Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71635E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 08:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9BA801E8;
	Wed,  8 Jan 2025 09:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IgdnufvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C5C805E1; Wed,  8 Jan 2025 09:20:49 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3383E8005B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 09:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361f796586so168493855e9.3
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 00:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736324446; x=1736929246;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JzC9NA7IcGquPjVgb7KhmJTfS8U4+XmQUe3Aktz2laM=;
 b=IgdnufvVqkla3WT1+87NGDJMt7zNvgeN92yI/KrsBEo1Mfuzjurq6p6hM+iOVsIXmZ
 MUUTA/6Ta7DEE8wrfjrhd5UG9K+HWBsL3K1fnXsdtyh8RbJsr5/8gnhLsAfdMYlgCPA3
 1FVXnCbAkfFwNnQIyWQNZ2rE4T7W1SJf/j1HdigxUpX/F8O3UgsQZjXe8zSp+mJgy8Nz
 TAn9HT/4lpFrpT/3cWskE0icVCtR5ZMyvpH+8oRsCaPUgGxCplPdRtsoVy9y6h6pMn1a
 j6wmrjMgjQ8w6kMfJpMVnLoZqn2kJfJowpXTksP7OQb1vqwiQ04bw3ouxNHJDxGn+FJT
 iurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736324446; x=1736929246;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JzC9NA7IcGquPjVgb7KhmJTfS8U4+XmQUe3Aktz2laM=;
 b=NTUZAYN1I9Riunfxq7JxsvHrVNbhpaaS+iq5Y0odJQr5Fl8qtkYyr6nsfBEjVvBtCs
 c68zayIBfcqhZk+gQPRxtHXKP7ODTuJXOylAC8wbRFQCteNUhTn7KAjTKtJjuS41qntw
 mnW/XVdrScfufgOmQ3cd8nE4UAXLPPGkCt7oXtV9yaMX2Q6HFvgIQa16xtTkvBdOaMuC
 rWGaGnjrzaRXn6jujhV01r4C3Fh4kCZtU6wbtKY+Qr6n63hEMeB/a+JgE+QLfJeqQwpS
 60cbnufEC62n3N0wps47MSK9Y/3ZI1Mb/YWYJp39o2CVt0OjXlvDgQQNadVsQTl72BHI
 0Fqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJCYjtL0uKCXlHDavHK9JS04gyn2gD+Wle9tF9UfVj2bVqLIzquvIWuwDOOdKq0incZh9AkX0=@lists.denx.de
X-Gm-Message-State: AOJu0YyTp1WE0LO1sTbgiE8b8GBYOzR5vcAYkov85FmHH5QjiqWvKfDu
 pZABbyhf7LPVxggUVmXy0iFiM4LwmaDebwv1SvZL2cm4sbzyARxUFqEFc/HbLSU=
X-Gm-Gg: ASbGnctR64XP4md8n93y2AeldVe3OD/ql08yjrtELCeHd5eC8yAXWTqeY6zU4BD7E2g
 lxdPzswClZokx/XG4AuFCEYvAmmFalkUq+V8i5E/6xhrd+NkgPcHTqhuUFYHzrThv40eGpts+7Z
 LSd6ClkEA+neVwbRZM/G2PhlKVe0wr+m/gd0yZ4p/IYeixQw1nUf1zEZ4ehNHjTZMUyrIzYONZy
 OGdIgHzvWB6CCPmTbx++z4+RtbkHI6QfQhWGMuAC/sRE9VNgOGxje4YCKzm6zikeA==
X-Google-Smtp-Source: AGHT+IFi3FiHWUaIEslcIPw8iR+R9p031U8oGG3hQSx+2BMm9sGbL/y5ecSQMGn0cpqg7M/hSvgU+g==
X-Received: by 2002:a05:600c:5129:b0:434:ff45:cbbe with SMTP id
 5b1f17b1804b1-436e26aaaa5mr11364525e9.18.1736324446590; 
 Wed, 08 Jan 2025 00:20:46 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e8a326sm12259465e9.35.2025.01.08.00.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 00:20:46 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>, Fabio
 Estevam <festevam@gmail.com>, Mathieu Othacehe <othacehe@gnu.org>, Peng
 Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] usb: ehci-mx6: Use regulator_set_enable_if_allowed
In-Reply-To: <20250107225616.195878-2-marex@denx.de>
References: <20250107225616.195878-1-marex@denx.de>
 <20250107225616.195878-2-marex@denx.de>
Date: Wed, 08 Jan 2025 09:20:45 +0100
Message-ID: <8734htd8de.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On mar., janv. 07, 2025 at 23:56, Marek Vasut <marex@denx.de> wrote:

> With the commit 4fcba5d556b4 ("regulator: implement basic reference
> counter") the return value of regulator_set_enable may be EALREADY or
> EBUSY for fixed/gpio regulators.
>
> Change to use the more relaxed regulator_set_enable_if_allowed to
> continue if regulator already was enabled or disabled.
>
> Based on 335799b7252a ("usb: dwc2: Use regulator_set_enable_if_allowed")
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Mathieu Othacehe <othacehe@gnu.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/usb/host/ehci-mx6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index a93fa5d5455..a8748cef7ad 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -479,9 +479,9 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
>  #if CONFIG_IS_ENABLED(DM_REGULATOR)
>  	if (priv->vbus_supply) {
>  		int ret;
> -		ret = regulator_set_enable(priv->vbus_supply,
> -					   (type == USB_INIT_DEVICE) ?
> -					   false : true);
> +		ret = regulator_set_enable_if_allowed(priv->vbus_supply,
> +						      (type == USB_INIT_DEVICE) ?
> +						      false : true);
>  		if (ret && ret != -ENOSYS) {
>  			printf("Error enabling VBUS supply (ret=%i)\n", ret);
>  			return ret;
> -- 
> 2.45.2
