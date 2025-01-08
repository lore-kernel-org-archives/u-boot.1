Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17CEE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 08:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 677D58006D;
	Wed,  8 Jan 2025 09:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CjnNOQyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D015801E8; Wed,  8 Jan 2025 09:20:12 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 293268005B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 09:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso109588715e9.3
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 00:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736324409; x=1736929209;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YCUS7ZrSZkcVb1/+bj4iL7RACc0D1V368bDzv6iw4KM=;
 b=CjnNOQyNrND6sFcN2c/5i1hRyyQwuTykEj4w+Qrm3SfbHFUQv9FzAWSS7iSZmHEtBE
 sYLWGzICn3GPdaU0oWf3RZKUkRUd+WWXPpOgak76/34Mwj2CaFo5M3PsnLEhfTaHc1JP
 1swyqNXISA5Xc/+SrBPgG2Yf08gVs4VFvBXjDLO3QYgG7qFDpNh42+mx4LPhunS5azmK
 X151xrUUTlDGbmeTmHPz9XpbvG+yb1pS9vLgjfYzN3fPunYJl69rdzk2gJ+v6KJHlRef
 InAlPLnlw3Y0IyF8RzJuUSNwp8rh5NITV02T0mZvTcj6QU33C+a5Q2wvffUzak/ctvMp
 sOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736324409; x=1736929209;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YCUS7ZrSZkcVb1/+bj4iL7RACc0D1V368bDzv6iw4KM=;
 b=Hgdp1f8FO7aNb4SU1M2OSaCev/J1tOjxQ/P/YTkouy35fokMX88OVxDLIfRoLue3W+
 gvAmKAq7hWHwkzEKcTRKZ4OAXPJMNfHiqihT8nRSzuLD82KicdBzH9B5gmmtGyvYyLAc
 MnSbuTOJqoX+f2ORG0R1qhDKs1D7446PLD/AwFdFNxtcbIG83ZMOQGVbTGJm+OwSE2We
 plccrYmYQAIBLUwu5SaO0OKsVpE/X3gjNTtdIrCM3XiUWzMurycez7MlCNbum8rU6PcS
 dyP/AMtKf7wrn3DuK0yNnZUHgi5/HM0SuAQhcprzGjm+yEto4guJcvuLV7iZ/LbRt7Rh
 fGPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmtpXdUzF+3o0qI2QgPz8YnARjPGp2K98Y1xAqIMbO5FTx74kPu8ghzUVDedegjuCa5vYUKIk=@lists.denx.de
X-Gm-Message-State: AOJu0YxnpOlyrM86f7Nqo4cfh++Rh27IejZloai+DEAwMRke2ARFeY+U
 usS7lUmMdcWkLKjzRKzWvhHQ8DtbgDgQpsfmobIiaJTUh7kigjM76KiP4vODcPI=
X-Gm-Gg: ASbGnctHfYMoLPANVn+oFW/K4xUDwnpFMklrLl/93slSKktUPGq6YwfijeEU72NMq/Q
 GN7R2wGc046WXoe/gdZ2aiSCPZJezVC/RY1L/Rf7I/+y0heClAWXSFZ42BXBVEz7i07h7BjU4Q/
 KvJ+dR4RV5Dw3Tjs4c5o4vY78j2xwCK1fMNaXniOCtsKPswdFEB6VFKXhv3/Mh7YZvAmT7yKL1e
 BQdSuQl/3TOQKfQXNM6Gn5JyF/JcFXxCXzI8XQBdJTbJxOGzUMjlrvNxiM24PZ+DQ==
X-Google-Smtp-Source: AGHT+IFFkzAB2jlJPZDehb+B4krJzWIHSScesUzLq7AfyKQzQIeykp+lne3iYnkhRmP313HyJ7Ld3g==
X-Received: by 2002:a05:600c:500f:b0:436:51bb:7a52 with SMTP id
 5b1f17b1804b1-436e2697170mr11886355e9.7.1736324409547; 
 Wed, 08 Jan 2025 00:20:09 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0bb7sm12371645e9.16.2025.01.08.00.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 00:20:09 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>, Fabio
 Estevam <festevam@gmail.com>, Mathieu Othacehe <othacehe@gnu.org>, Peng
 Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] usb: ehci-mx5: Use regulator_set_enable_if_allowed
In-Reply-To: <20250107225616.195878-1-marex@denx.de>
References: <20250107225616.195878-1-marex@denx.de>
Date: Wed, 08 Jan 2025 09:20:07 +0100
Message-ID: <875xmpd8eg.fsf@baylibre.com>
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
>  drivers/usb/host/ehci-mx5.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-mx5.c b/drivers/usb/host/ehci-mx5.c
> index d8f521befe1..1392d29bc13 100644
> --- a/drivers/usb/host/ehci-mx5.c
> +++ b/drivers/usb/host/ehci-mx5.c
> @@ -287,9 +287,9 @@ static int ehci_usb_probe(struct udevice *dev)
>  		debug("%s: No vbus supply\n", dev->name);
>  
>  	if (!ret && priv->vbus_supply) {
> -		ret = regulator_set_enable(priv->vbus_supply,
> -					   (type == USB_INIT_DEVICE) ?
> -					   false : true);
> +		ret = regulator_set_enable_if_allowed(priv->vbus_supply,
> +						      (type == USB_INIT_DEVICE) ?
> +						      false : true);
>  		if (ret) {
>  			puts("Error enabling VBUS supply\n");
>  			return ret;
> -- 
> 2.45.2
