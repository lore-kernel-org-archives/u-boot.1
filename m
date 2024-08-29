Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5384C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C2388360;
	Thu, 29 Aug 2024 09:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QG2cmqOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A2C88297; Thu, 29 Aug 2024 09:43:13 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0637D8870D
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42bb72a5e0bso2199725e9.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724917391; x=1725522191;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B9ERjpS6Q7vQoc0wnc6N31qOKk6+tzrK4o1wIu6oN+I=;
 b=QG2cmqOhWTsT4rxxpxilmB3X5bBJz0b2tgiCUnK3WyHk/Ia5OfNyf/NPFa5IUfCTFO
 KPz1Op/b8Px+KWECyOaW4ik6AZi0XaN0uijo8Jz8KctOIaEWgxdSSK6ktH8oJ5Qvlz/q
 0/LiSM1QC5ULwGmUhpPze2yi7lK5GeEn6rHlPyk/hx40IYePSrcDd/jyXlNEWR6Oe733
 e0SfGU+hQVv4a6kVutgcJIUKoejRT2YCYpaHhOyUlMPm7dmqDDSPo1jIPn/y8Bx6eX+q
 hu75c5DmpewWA3iDBLhYr1af0FDES95hINhE06qOUIbt1g3RLON5/7aKW0FaxNgzxNrT
 PtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724917391; x=1725522191;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9ERjpS6Q7vQoc0wnc6N31qOKk6+tzrK4o1wIu6oN+I=;
 b=e9lv918dF51tdJGDM3oTo5dzTlwtezDE1fpJu3YOMK/ul7Do84P0WyNQCnneOBMm7d
 waMmTUAbE5Q3o0ZzD8/oFZW37reDQLEiUzbxUwSAymw2ZGGjh/pR1DbALhJq3eRdIiW9
 bV+BF/+gC3amClZX1MozO52RbosIlsQbhjHRnEbLWlR6PN5g+d3P2OzypJ/b8H4u7SRu
 KuF5GCnBOiOkE53ZHcP2pxi4SojT3rOy2apL2jm1ekCmsY4kAAGCkDuL8lKidHwyEcWj
 S5XAxcYBx3KraxN3waaFI0kXLQ5kvYg7Qv+T65LaYtfNzbN95PY5cLdz92eemA3PA6Qr
 K00w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVupi3Eroo787apgsuNhjSB+E3LnvUwdhr4GpAU3i+5QdK5uQnlCwdsafKraLyGfQ9hJxcxD04=@lists.denx.de
X-Gm-Message-State: AOJu0YyYTP1Xa1GjYOqMyatfuqzbI/1A2d4lB+e5eobUH6WGTUqA/y8K
 iDevyMgNUP25MSbScjjP2Q5ho7djxA/hdPoEV0itbteKBSdH4tey8j+0ALfadWA=
X-Google-Smtp-Source: AGHT+IFhpM+2RYZsGsaPme76fKHFvZ5MIt1vlFuuL3zlEZnyRijwtTGHZiAhrdoqTBcvNuufzkdzRg==
X-Received: by 2002:a05:600c:1389:b0:426:6326:4cec with SMTP id
 5b1f17b1804b1-42bb01e6befmr15112195e9.29.1724917390822; 
 Thu, 29 Aug 2024 00:43:10 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba641da5asm42377545e9.36.2024.08.29.00.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 00:43:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Linus Walleij
 <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nishanth Menon <nm@ti.com>, Zixun LI <admin@hifiphile.com>
Subject: Re: [PATCH 4/6] usb: gadget: Drop dev_to_usb_gadget()
In-Reply-To: <20240826143851.8020-4-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
 <20240826143851.8020-4-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Aug 2024 09:43:07 +0200
Message-ID: <87zfovrcz8.fsf@baylibre.com>
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

> This function is unused, remove it.
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
>  include/linux/usb/gadget.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index a2b8520bc99..194025ebd12 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -558,11 +558,6 @@ static inline void *get_gadget_data(struct usb_gadge=
t *gadget)
>  	return gadget->driver_data;
>  }
>=20=20
> -static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
> -{
> -	return container_of(dev, struct usb_gadget, dev);
> -}
> -
>  /* iterates the non-control endpoints; 'tmp' is a struct usb_ep pointer =
*/
>  #define gadget_for_each_ep(tmp, gadget) \
>  	list_for_each_entry(tmp, &(gadget)->ep_list, ep_list)
> --=20
> 2.45.2
