Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E38E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 09:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B82448027E;
	Wed, 18 Dec 2024 10:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gAfa0dT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D2780288; Wed, 18 Dec 2024 10:58:22 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6D480269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f796586so68612895e9.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 01:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734515900; x=1735120700;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MQPnnmX6n53+TIieRkY8BYpgQWkr0UB1x11YTLLQlcU=;
 b=gAfa0dT+skk9XVLoXYN+luI4NmMTbIBo9RG42whV60mOCr6g5WuAkyLYuAZ6WR2v6O
 NjpAy1TYXaXnIZI0NMrmXGIv1IUfNBLeelo+5TmHi1uclFnpxsm9TmM8AJRpY60PYcfP
 pKVpG7NtLJ0+22u7j4xzfy5VFAKcyTrJUkakSVvdqmuRq04qycpJVdC1/OwYjcBlYNZ4
 x++tmdUuwVwlbUE8Y6UFcHZuUJmt2Cqh2WFVCbICh42r3H0AjREEUZIzoXdGBG1BTV5n
 D2CPbgzgubSok07IMxT9kxFjPco4vqQMv2LkskHo38ItlHsjOeYobajQkRfA3yMTqFyD
 5M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734515900; x=1735120700;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQPnnmX6n53+TIieRkY8BYpgQWkr0UB1x11YTLLQlcU=;
 b=wtl51F8xv31jO6dsSiuafsvYxu7K07tjjNMYy4Fiicr6BHY1+F7ogdcRrhVK0mqp5f
 I++MvMfEdhaMM6zZJX9cYSd/N8ECLfRKz3Ye4nSrZt3kTDfIr1k04ue2LUGiTod2D34x
 I6tKbNj5n/EtCg5Bbt38jDC6QF/dwYLRorK8dLZZlukCCXRBXptb03z1y/S7gkhzLCCy
 jMN4v/9UUrN2UlsYShXInNl3+JNxFT7uOJ2aMlmLmOsjmr9SxQhURFOSxXNOluPxnted
 fpj4p3ydjb66SJTqo2b7L5Ahs+q22REVTHVWg8WE9+cPdcyASw5ug0NYPIq5tu1ZZMLM
 BCEQ==
X-Gm-Message-State: AOJu0YzeqTI/Em5Z7jrzT0BXbPKooUfrzwSBRL2cGPejgMFF92uCrdDc
 BOzn7XJiFeT+mpvarfUgEjzGtv5B2rLw/nE10RfRM2eiaTMQHb2l/brCFY/+H4k=
X-Gm-Gg: ASbGnct7iNSxr7Rday+Z2JroDrTvn9EvdEvbhx2MXBAE01u2QTmfdno29ydAG1fEllE
 qekHdK1aEj5CkNbIQDUAgiLaEK8/baroWQ8to/Wmqy7CnN1aacnkJgmO21WBcSy2jQ8WE7Jw8U1
 eXnhYnNl5s+ILjT+MrTcnzJh8WTJEGl2teNgkqPOE3ZbCNi/aUqOT6vAt6k8a/TgkrNsH37ArlR
 iHmEWdy2oAkMNbYMnRSSKGKXjywiyoPq8FCw49GYbIOe9iEC5aSO1GIsqiNILngFg==
X-Google-Smtp-Source: AGHT+IGvp3H1v37DOEv/10p5gWK/9qex+oA60Lfe6TiPe31ei9EaUS1kaoAEoCOoI1y0JKYZIV1KAg==
X-Received: by 2002:a05:6000:1fa9:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-388e4db2f48mr2179264f8f.44.1734515899882; 
 Wed, 18 Dec 2024 01:58:19 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801233asm13963078f8f.9.2024.12.18.01.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 01:58:19 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH 3/4] configs: am62x_r5_usbdfu: extend for AM62Px
In-Reply-To: <20241217131658.2920799-4-s-vadapalli@ti.com>
References: <20241217131658.2920799-1-s-vadapalli@ti.com>
 <20241217131658.2920799-4-s-vadapalli@ti.com>
Date: Wed, 18 Dec 2024 10:58:18 +0100
Message-ID: <87v7vhwbwl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Siddharth,

Thank you for the patch.

On mar., d=C3=A9c. 17, 2024 at 18:46, Siddharth Vadapalli <s-vadapalli@ti.c=
om> wrote:

> Disable configs which are not required for USB DFU functionality, in
> order to allow reusing this fragment for AM62Px SoC.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

I confirm this is needed, without this, the tispl size is too big and we
can't build.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  configs/am62x_r5_usbdfu.config | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.con=
fig
> index 772bb2ab935..f094ed127e6 100644
> --- a/configs/am62x_r5_usbdfu.config
> +++ b/configs/am62x_r5_usbdfu.config
> @@ -26,3 +26,6 @@ CONFIG_SPL_DFU=3Dy
>  # CONFIG_CMD_MMC is not set
>  # CONFIG_CMD_FAT is not set
>  # CONFIG_MMC_SDHCI is not set
> +# CONFIG_SPL_MTD is not set
> +# CONFIG_DMA_CHANNELS is not set
> +# CONFIG_TI_K3_NAVSS_UDMA is not set
> --=20
> 2.43.0
