Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC26AEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E36864B0;
	Tue, 22 Aug 2023 18:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="Awght/B5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48870864B3; Tue, 22 Aug 2023 18:22:30 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6731A864AB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so1456825f8f.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692721347; x=1693326147; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/2dahQOOn/LCyifJFxvoL5C1iG5+8WyV6r/Hzk3qPDQ=;
 b=Awght/B5G01cl3droNSnm8qgBOPSgzgZCqlaReHNOON1GHFpM2Sxv6XytYSzDaEXLy
 C+RH/mGmydJ+spp9jeOP19uaIKJ/CkIVdnBg20KxFDQUuPnVfR/pirDmePNYfXBTABvq
 eUtMDwrOWjycVOIW0JHHXWTvyrQ9DlYKGiY8EIbIlYtyabe9dm09PoETtIa8Kl8NjURe
 uevcbnCoEl+dllEjFhLiT9f4Z7F4SbUyfNpijM15vClKa1aGqaUxUetSsAwwi9R8Lx+G
 VHi51ikBRCDWQO/x3VC+CHtH8tVqbe+IUyb/8iKuM8tcxv7SwQg3Yokjeg8bAvg1nU0g
 X4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692721347; x=1693326147;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2dahQOOn/LCyifJFxvoL5C1iG5+8WyV6r/Hzk3qPDQ=;
 b=Mrzpz/4Js4Xjrv5AXjUdhPmVxSBoc+4B4sBKpJxZd+rS/XalBgfUQXEsI56b19aQ0i
 5L/GpYfTblC+5FPnJ4g7X51uJaSbSllcs/M4GEsJBgUvGw0qY+4JDw/afHxTJp8hAwy0
 VVFF3GUMMNX1aadpWRDqUtLap4keqqdkGv5sL2YR4HqNxxk/gKv+JOyouTjffcS8szCJ
 5D1XASAaxvhYWufSDYc9A5rTfy8R++V86T76Lh40O6N9WE1nu2Xshxdb52KaEHSCxun0
 YxST2cK4yOjktfj0pQhQ88XB2nwqvMUG+gpbohTu58yOnggtM7clUOltudWcKv/HzB6o
 U+Iw==
X-Gm-Message-State: AOJu0YxRP1i/rdOR3nylDKZUUGaPuE9sq+fmqzZ3uSY8k3Euyx5excYE
 r88tKEUjNqnF9j+IqtuHBkr1Xw==
X-Google-Smtp-Source: AGHT+IFHEH5fKq6xep/ILBho1QvaiS3FFDCOBX1x+kU0Qs2RiUiZGHHTWeL/1ntIG99+AHVnpp1Smw==
X-Received: by 2002:a5d:68cc:0:b0:319:8c35:37b with SMTP id
 p12-20020a5d68cc000000b003198c35037bmr7577485wrw.7.1692721346883; 
 Tue, 22 Aug 2023 09:22:26 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fefd46df47sm1245480wma.29.2023.08.22.09.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:22:26 -0700 (PDT)
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
Subject: Re: [PATCH 04/17] cmd: fastboot: Use plain udevice for UDC
 controller interaction
In-Reply-To: <20230819142407.49632-4-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-4-marex@denx.de>
Date: Tue, 22 Aug 2023 18:22:25 +0200
Message-ID: <87edjvrqri.fsf@baylibre.com>
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

> Convert to plain udevice interaction with UDC controller
> device, avoid the use of UDC uclass dev_array .
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
>  cmd/fastboot.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Tested that I could reflash the bootloader (raw) partition with:

$ fastboot flash bootloader u-boot_kvim3_noab.bin

Works fine!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on khadas vim3

Based on: 2023.10-rc3

>
> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> index 3d5ff951eb6..17fb0a0aa7b 100644
> --- a/cmd/fastboot.c
> +++ b/cmd/fastboot.c
> @@ -61,6 +61,7 @@ static int do_fastboot_usb(int argc, char *const argv[],
>  {
>  	int controller_index;
>  	char *usb_controller;
> +	struct udevice *udc;
>  	char *endp;
>  	int ret;
>=20=20
> @@ -79,7 +80,7 @@ static int do_fastboot_usb(int argc, char *const argv[],
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> -	ret =3D usb_gadget_initialize(controller_index);
> +	ret =3D udc_device_get_by_index(controller_index, &udc);
>  	if (ret) {
>  		pr_err("USB init failed: %d\n", ret);
>  		return CMD_RET_FAILURE;
> @@ -103,13 +104,13 @@ static int do_fastboot_usb(int argc, char *const ar=
gv[],
>  		if (ctrlc())
>  			break;
>  		schedule();
> -		usb_gadget_handle_interrupts(controller_index);
> +		dm_usb_gadget_handle_interrupts(udc);
>  	}
>=20=20
>  	ret =3D CMD_RET_SUCCESS;
>=20=20
>  exit:
> -	usb_gadget_release(controller_index);
> +	udc_device_put(udc);
>  	g_dnl_unregister();
>  	g_dnl_clear_detach();
>=20=20
> --=20
> 2.40.1
