Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B442EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C55948647B;
	Tue, 22 Aug 2023 18:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="s/wAzaLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30789864B9; Tue, 22 Aug 2023 18:10:09 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D978645B
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c615eb6feso709191f8f.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692720606; x=1693325406; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=72aWv4uE5klKgRHZTRzU8bRF9LpZKt0GnVGRVkW2Hb0=;
 b=s/wAzaLtfQj2O8lUUIx6n9Dhni9MiWNo/sx3oZvxm2C6EvqW9GaW5YfZTCBQQ/mzfB
 ESaDgXes5JWnW9z5c5nRL01aF6VbaKTwN7o+RnhZzuCZoMSa9IcaWvDH6V2IcS8qPS8s
 ohQJJJ6iXgs2O0GG+NLcWQxAbQM3No8uVtIGBM6wz09cZVOv9gc/c7lmqraCQjeZ2OSe
 /vFJERsuxNWgyzTRlpu8ie7e2xgMnvBgDTpWoV1ZauamNv8p6s+An3aPlviKTHasCDG5
 VzhBbTOLLll/sEdIS5VrHj3RXRCJf418FnhLtXqimYBGjT/ZzddK6FTaaFpGTQs74ODx
 XMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720606; x=1693325406;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72aWv4uE5klKgRHZTRzU8bRF9LpZKt0GnVGRVkW2Hb0=;
 b=E42+lZh04MjKndD+2MC7Sk2KlVnVAP0VZT8daZWWoXacHv5ln0Axw43o9jltDtsvHq
 x74Wo7rGgNHurCb3S7GdkCAi07f5AJisfgmnIZiXhEPW+eXS3wn7wly6P26ZFkrXE0Rk
 cp2Govadav6K2P9Ya9g3QFIfrpmSPXB6OMRNoS0cChWlDikdyawRNALHdKXXcP6iAIjZ
 GNjPsFnBLzYujTh7b4FxNyhHGD6WnFW2hHl+2YjNXv/Bk4j+E4WpsbK9+dK4ZhOeGCKW
 aPkD9hN/lQ9i31Y9TpiEo2X46FgEwO/uJtxNZtuBtsH7bbCgR7ZUQ/zVfqa9fcZdAufO
 QbTw==
X-Gm-Message-State: AOJu0Yw7jnI3S0m75/6QlJhfcHkCS1xty6DyQoonPTjqJA8USQVG7CM1
 htZ2eBBDeFV5UdHSxP85l6uIDQ==
X-Google-Smtp-Source: AGHT+IFsRNjtqBJmH07Fl6RyOa2oe1kGfiszRvmezf7yQ1s6pYM7MfXB2Dmd8hlhZBHx397sFx1CiQ==
X-Received: by 2002:a5d:4683:0:b0:318:f7a:e3cb with SMTP id
 u3-20020a5d4683000000b003180f7ae3cbmr8118086wrq.31.1692720605968; 
 Tue, 22 Aug 2023 09:10:05 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 r5-20020adfe685000000b0030647449730sm16353179wrm.74.2023.08.22.09.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:10:05 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>, Dmitrii
 Merkurev <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH 02/17] usb: sandbox: Add DM_USB_GADGET support
In-Reply-To: <20230819142407.49632-2-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-2-marex@denx.de>
Date: Tue, 22 Aug 2023 18:10:04 +0200
Message-ID: <87jztnrrc3.fsf@baylibre.com>
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

On sam., ao=C3=BBt 19, 2023 at 16:23, Marek Vasut <marex@denx.de> wrote:

> Remove local usb_gadget_register_driver()/usb_gadget_unregister_driver()
> implementation which is implemented in udc-core.c instead if DM_USB_GADGET
> is enabled. Add no-op dm_usb_gadget_handle_interrupts() implementation.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---
>  drivers/usb/host/usb-sandbox.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbo=
x.c
> index d1103dcb2e9..582f72d00c1 100644
> --- a/drivers/usb/host/usb-sandbox.c
> +++ b/drivers/usb/host/usb-sandbox.c
> @@ -124,6 +124,12 @@ static int sandbox_submit_int(struct udevice *bus, s=
truct usb_device *udev,
>  	return ret;
>  }
>=20=20
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	return 0;
> +}
> +#else
>  int usb_gadget_handle_interrupts(int index)
>  {
>  	return 0;
> @@ -144,6 +150,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_dr=
iver *driver)
>=20=20
>  	return 0;
>  }
> +#endif
>=20=20
>  static int sandbox_alloc_device(struct udevice *dev, struct usb_device *=
udev)
>  {
> --=20
> 2.40.1
