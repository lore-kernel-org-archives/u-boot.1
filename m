Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3FFC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 08:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D6888405;
	Tue,  9 Jul 2024 10:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TezCc634";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84108884CC; Tue,  9 Jul 2024 10:40:00 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 826AD871C7
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 10:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-426602e8050so19073195e9.2
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720514398; x=1721119198;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PzBX3MflJrCg3y2NEO0hx49UwCd7yJXHC+XXtd/R7Bk=;
 b=TezCc634M5TKckiCyOLEO41Vi8zkmbUHn0UhMwQ7MEyiY5YBLd3rTFtiDwWYHGxCX1
 4xbdCPGNgit4oYVNvJt4J00sRWsRZeVSR/0mB/4IdN2lL1N+j3C9dI8beNmO8XACihEZ
 rDlGBumHrIA0zwrU6dKWqy5umHMozTqr9qnQyb3cXXhRSXEzy6ASwWes1SOJTmh63tCe
 1/lg4dLf4oV/TueZ74VNmRDg6P23lwSsnNkqWs1EOYbzdMNIZyg5+Ml6k+WJoeZ0whvj
 W5KOzswBTTp7J/uXbkfXkrZHnTpS+ZSIeHQg8XnaCdOSVfoMoVJL5Hf/uI1KW+j6MoXy
 njNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720514398; x=1721119198;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PzBX3MflJrCg3y2NEO0hx49UwCd7yJXHC+XXtd/R7Bk=;
 b=VOvftnJz7HLIvpI9rrS5n1uPdB3OjqDPGUfAPcGD3cW9ut0BJFGCIHH76m5jiu0miT
 H/eWYxPowApQNqknzoP4/1ojZgUn6G1p+Jz5PruNj8Iz39Gt+2SKqPmZy/COHDjlFK2y
 JEIDF+QNYb0tkLV5HqlJVLx8BRWDgL0s1SaA645vIbpz0eno30+BNGjW3Q6ti1FS0Ctt
 m7PHe88Ou0szQMA0P8qLcrwIUsfGG+773/+LOPHNIl2MNoqZAfKCfj7b2/RqBZcC4x2+
 Vv5CgAyDnhy35vOcFChg4oCy00R3I0nIRyFzz1ubuWr/rVrCXMy2xnsBQD5nC/P0pAEt
 bRqw==
X-Gm-Message-State: AOJu0YwouZJVApoYpD9N1SPwqjIkO+960AzSrayuJpywMma6FNTocNXt
 m1z0IBKz9+eqLkaFI5tua5jPP2HZC7K9PV09JJCvTjxqXriErm3GBnj5axPPlnM=
X-Google-Smtp-Source: AGHT+IGH4K8wXjBS/a1XkngvmoO0mDqKwuNj85lBvQkViWrFG1xHNawWFFaDH7odQMHFwe2VUS7ssA==
X-Received: by 2002:a05:600c:6a8a:b0:426:4b90:1e91 with SMTP id
 5b1f17b1804b1-426707d7fcbmr13511025e9.24.1720514397684; 
 Tue, 09 Jul 2024 01:39:57 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fc937sm199335175e9.40.2024.07.09.01.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 01:39:57 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] eth: asix88179: reset during probe
In-Reply-To: <20240618145759.3296876-2-caleb.connolly@linaro.org>
References: <20240618145759.3296876-2-caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 10:39:54 +0200
Message-ID: <87v81fhsbp.fsf@baylibre.com>
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

Hi Caleb,

Thank you for the patch.

On mar., juin 18, 2024 at 16:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> In some cases (consistently in my case with an embedded board) the
> ethernet controller will time out on the first init but always succeed
> after reset.
>
> Let's reset the controller during probe so we always start with it in a
> known state, and don't have wait for the first asix_wait_link() to
> time out.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> I see this behaviour consistently across three Qualcomm platforms that use this
> controller.
> ---
>  drivers/usb/eth/asix88179.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
> index 7bfd285b3aa4..a0aa5c25e428 100644
> --- a/drivers/usb/eth/asix88179.c
> +++ b/drivers/usb/eth/asix88179.c
> @@ -628,8 +628,14 @@ static int ax88179_eth_probe(struct udevice *dev)
>  
>  	usb_dev = priv->ueth.pusb_dev;
>  	priv->maxpacketsize = usb_dev->epmaxpacketout[AX_ENDPOINT_OUT];
>  
> +	ret = asix_basic_reset(&priv->ueth, priv);
> +	if (ret) {
> +		printf("Failed to reset ethernet device\n");
> +		return ret;
> +	}
> +
>  	/* Get the MAC address */
>  	ret = asix_read_mac(&priv->ueth, pdata->enetaddr);
>  	if (ret)
>  		return ret;
> -- 
> 2.45.0
