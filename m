Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A36C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3FD888B3C;
	Thu, 29 Aug 2024 09:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G3DFdxEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608C088B59; Thu, 29 Aug 2024 09:44:39 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CC6788297
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37189d8e637so213809f8f.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724917477; x=1725522277;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VvXR84GuCiJq1Fjb4OafSOfEkcnp1Pozl2saDnA9lX8=;
 b=G3DFdxEo37r79SKaWribUc++SjMG5OT3v4CS8+1tk0hdabbK4pnGP165nqxjrktdb+
 cS7fpPEuPvm4R3WB6iq+lsiqpY8TXM83IUo5Ku6FwKMhpZCz31e1AUEkahuTTTTLyuNC
 BUSC3l5Gy6brdOrQK9nxax+vFU73h1ZjEbcdTQnKphQWkpYTj+s7hFEMHXbsC46odtkM
 EBtPy1vBZvWX00MfMRNCPtq7aALns/IsqkRjfWw6YiIGvf7MMddUPK02bZWLk4UqlAt3
 FWflw0Jfor6nmPpWxRoktjcuzS4SjWykL7oJ7hHKSbqrwfbaiv1775ocGA2lPWzm+4J4
 dZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724917477; x=1725522277;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvXR84GuCiJq1Fjb4OafSOfEkcnp1Pozl2saDnA9lX8=;
 b=AqNWWFsYKSnC6Q72Hx1cL0q6kSKg7Ydc6bt7loM/JDcW4XpTPdJmbfEsFRO+WQXhp0
 fG36n/Kvk7Ql/+jzmVblkNVvbBj0xiKJaYlOMjITw5XW/rww2RLh40Y94eD29zZP4fZf
 1nrktwLh8BBia4dptwHA0aVRTgp6w3i5xRtXMFCvYRHtutY7sHZQHfoZJ45m0YvZrhUW
 +3rLluG9VBjV2c0u50KZDgoxSKaIBpF2y+mkQ0kHqg6Juu0P+21vvrKxUrtNxsFronc5
 gWswff+YpdYuhyrij0raaf00Gx79dsGeHDP5ATxBDmnfLzEjIMba9HYFbLTz4LXc09nO
 n4+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv9Ga8D2wIktSz8h66OhnMU7zcFkCQQAQZJUeBLM52wUSe0svFMfyDsXeFPG/Ws2Dn5dPN8Ho=@lists.denx.de
X-Gm-Message-State: AOJu0YxTGjSuiQhZqtaCGRH01ekzHztE1lqXgyg3dYeSFqMiURB/HJiK
 DZ2XtQI4XW28fUbOiSSVxP5weBcqKYDbBu/sLSeSaDbAH/2fQAZZOgKFhR0g/DU=
X-Google-Smtp-Source: AGHT+IGSDwjW9UniFk4k+DSh+YhSvb55XH3CGNzYHTof9+Wq+VKWuIu28ybRqWrFzEuG1AzIQ5FbOQ==
X-Received: by 2002:a05:6000:50:b0:368:667a:3dec with SMTP id
 ffacd0b85a97d-3749b557de2mr1253382f8f.18.1724917476411; 
 Thu, 29 Aug 2024 00:44:36 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df0adbsm8836045e9.15.2024.08.29.00.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 00:44:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Linus Walleij
 <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nishanth Menon <nm@ti.com>, Zixun LI <admin@hifiphile.com>
Subject: Re: [PATCH 5/6] usb: gadget: dwc2: Drop
 get/set_udc_gadget_private_data()
In-Reply-To: <20240826143851.8020-5-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
 <20240826143851.8020-5-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Aug 2024 09:44:33 +0200
Message-ID: <87wmjzrcwu.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On lun., ao=C3=BBt 26, 2024 at 16:38, Marek Vasut <marek.vasut+renesas@mail=
box.org> wrote:

> Neither get_udc_gadget_private_data() nor set_udc_gadget_private_data()
> is ever called anywhere, remove both.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/usb/gadget/dwc2_udc_otg.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_=
udc_otg.c
> index 7e9dd6f4268..fbd6c9600fc 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -121,19 +121,6 @@ static void nuke(struct dwc2_ep *ep, int status);
>  static int dwc2_udc_set_halt(struct usb_ep *_ep, int value);
>  static void dwc2_udc_set_nak(struct dwc2_ep *ep);
>=20=20
> -void set_udc_gadget_private_data(void *p)
> -{
> -	debug_cond(DEBUG_SETUP !=3D 0,
> -		   "%s: the_controller: 0x%p, p: 0x%p\n", __func__,
> -		   the_controller, p);
> -	the_controller->gadget.dev.device_data =3D p;
> -}
> -
> -void *get_udc_gadget_private_data(struct usb_gadget *gadget)
> -{
> -	return gadget->dev.device_data;
> -}
> -
>  static struct usb_ep_ops dwc2_ep_ops =3D {
>  	.enable =3D dwc2_ep_enable,
>  	.disable =3D dwc2_ep_disable,
> --=20
> 2.45.2
