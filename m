Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F58EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9830864CF;
	Tue, 22 Aug 2023 18:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="JkKpn2Cy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E31864DB; Tue, 22 Aug 2023 18:46:11 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 272388642C
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so44671375e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692722768; x=1693327568; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n68L3YRyKtGc16IhZsKR7FhhgND0n2zhewi+Mfd4zt4=;
 b=JkKpn2CyZGm66io4CmMJPoNP/zcLDJloEcwvNXjn/Od/ym5XaR9qS6q1eTZSPUojpi
 EexAuJMjPbN3xhgqRcW70mF8Gv/nqUEGpptLzlgq/Abf3yeSwPfJzt8ji+V4mU3v07lo
 4miJ8yEUxtV+O0jbodFsFGhQhpUFNalsZBdqrTRDTjUiO8yr4pJTYsZpKgpwEWGF4LrR
 w+iVJc0aysRN7PjPBNwlDxC4toatNXghEQhV9NsYekWvfFY6gJuRuQg9FzNuTLebNXsw
 7ZezQIM+0VUvljQYHsc7z2bOvqhoXjpxCnr8MXx2+uNB7/YjHMvmEaEBQip8IfrdwAX5
 SgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692722768; x=1693327568;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n68L3YRyKtGc16IhZsKR7FhhgND0n2zhewi+Mfd4zt4=;
 b=OI8EDbWxfa4NKXndNNuzjymLh4I2pg+AQXqZAQ6o0L7xglA3kQhoJXvwc7uue591Ac
 rkIN1Wu7+CFEhWyLr7eUr2hrcFblruBpF4T1kh6Ce44kqer1VXJ3HrdiRbz47x/U1paB
 atF7SSmdjbXM6Dn3tZXKJ1nCUY6aeX/6Iy8NPYsNdaLfdjMpQYxUI4voSLnR3X2qUlEQ
 IF2BfG341t8acsRPVY/ront841NrbEH8zo2hccYiuAO5DxLK4rWuw8RDWPPjRzG91t7C
 GA92jlirBHKI5ytbmrlzhw6v53UPx+7zgoLDBKBmv/vykmjpYFq4tSwsoFjtei1ui7H7
 a7Jg==
X-Gm-Message-State: AOJu0Yw+iUoNQyeTgSqalUcxMk6IAMgasyUuX5DOc1OVfL+G2jVZ00Hc
 lNRaadLyriKV+0vQWhHMYS4D/Q==
X-Google-Smtp-Source: AGHT+IF8aojPKyJ4B3OP1fRzMSNMS3hqJP1RWjyiS+e/ihGkc+tbm/SiEGe7nTjm6Xx0fv0Wu5vMJw==
X-Received: by 2002:a05:600c:214a:b0:3fc:25:ced6 with SMTP id
 v10-20020a05600c214a00b003fc0025ced6mr8267330wml.13.1692722768598; 
 Tue, 22 Aug 2023 09:46:08 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 x1-20020a05600c2a4100b003fe1630a8f0sm19753021wme.24.2023.08.22.09.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:46:08 -0700 (PDT)
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
Subject: Re: [PATCH 12/17] sdp: Use plain udevice for UDC controller
 interaction
In-Reply-To: <20230819142407.49632-12-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-12-marex@denx.de>
Date: Tue, 22 Aug 2023 18:46:07 +0200
Message-ID: <87wmxnqb3k.fsf@baylibre.com>
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

On sam., ao=C3=BBt 19, 2023 at 16:24, Marek Vasut <marex@denx.de> wrote:

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
>  cmd/usb_gadget_sdp.c       | 11 +++++++----
>  common/spl/spl_sdp.c       | 13 ++++++++-----
>  drivers/usb/gadget/f_sdp.c | 10 +++++-----
>  include/sdp.h              |  6 +++---
>  4 files changed, 23 insertions(+), 17 deletions(-)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/cmd/usb_gadget_sdp.c b/cmd/usb_gadget_sdp.c
> index 784d1b49768..748aa0a7488 100644
> --- a/cmd/usb_gadget_sdp.c
> +++ b/cmd/usb_gadget_sdp.c
> @@ -15,13 +15,16 @@
>  static int do_sdp(struct cmd_tbl *cmdtp, int flag, int argc, char *const=
 argv[])
>  {
>  	int controller_index;
> +	struct udevice *udc;
>  	int ret;
>=20=20
>  	if (argc < 2)
>  		return CMD_RET_USAGE;
>=20=20
>  	controller_index =3D simple_strtoul(argv[1], NULL, 0);
> -	usb_gadget_initialize(controller_index);
> +	ret =3D udc_device_get_by_index(controller_index, &udc);
> +	if (ret)
> +		return ret;
>=20=20
>  	g_dnl_clear_detach();
>  	ret =3D g_dnl_register("usb_dnl_sdp");
> @@ -30,20 +33,20 @@ static int do_sdp(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
>  		goto exit_register;
>  	}
>=20=20
> -	ret =3D sdp_init(controller_index);
> +	ret =3D sdp_init(udc);
>  	if (ret) {
>  		pr_err("SDP init failed: %d\n", ret);
>  		goto exit;
>  	}
>=20=20
>  	/* This command typically does not return but jumps to an image */
> -	sdp_handle(controller_index);
> +	sdp_handle(udc);
>  	pr_err("SDP ended\n");
>=20=20
>  exit:
>  	g_dnl_unregister();
>  exit_register:
> -	usb_gadget_release(controller_index);
> +	udc_device_put(udc);
>=20=20
>  	return CMD_RET_FAILURE;
>  }
> diff --git a/common/spl/spl_sdp.c b/common/spl/spl_sdp.c
> index f6b99c1af5a..83585cf82d3 100644
> --- a/common/spl/spl_sdp.c
> +++ b/common/spl/spl_sdp.c
> @@ -14,10 +14,13 @@
>  static int spl_sdp_load_image(struct spl_image_info *spl_image,
>  			      struct spl_boot_device *bootdev)
>  {
> -	int ret;
>  	const int controller_index =3D CONFIG_SPL_SDP_USB_DEV;
> +	struct udevice *udc;
> +	int ret;
>=20=20
> -	usb_gadget_initialize(controller_index);
> +	ret =3D udc_device_get_by_index(controller_index, &udc);
> +	if (ret)
> +		return ret;
>=20=20
>  	board_usb_init(controller_index, USB_INIT_DEVICE);
>=20=20
> @@ -28,7 +31,7 @@ static int spl_sdp_load_image(struct spl_image_info *sp=
l_image,
>  		goto err_detach;
>  	}
>=20=20
> -	ret =3D sdp_init(controller_index);
> +	ret =3D sdp_init(udc);
>  	if (ret) {
>  		pr_err("SDP init failed: %d\n", ret);
>  		goto err_detach;
> @@ -39,11 +42,11 @@ static int spl_sdp_load_image(struct spl_image_info *=
spl_image,
>  	 * or it loads a FIT image and returns it to be handled by the SPL
>  	 * code.
>  	 */
> -	ret =3D spl_sdp_handle(controller_index, spl_image, bootdev);
> +	ret =3D spl_sdp_handle(udc, spl_image, bootdev);
>  	debug("SDP ended\n");
>=20=20
>  err_detach:
> -	usb_gadget_release(controller_index);
> +	udc_device_put(udc);
>  	return ret;
>  }
>  SPL_LOAD_IMAGE_METHOD("USB SDP", 0, BOOT_DEVICE_BOARD, spl_sdp_load_imag=
e);
> diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
> index 4da5a160a09..37f6281abfb 100644
> --- a/drivers/usb/gadget/f_sdp.c
> +++ b/drivers/usb/gadget/f_sdp.c
> @@ -702,7 +702,7 @@ static int sdp_bind_config(struct usb_configuration *=
c)
>  	return status;
>  }
>=20=20
> -int sdp_init(int controller_index)
> +int sdp_init(struct udevice *udc)
>  {
>  	printf("SDP: initialize...\n");
>  	while (!sdp_func->configuration_done) {
> @@ -712,7 +712,7 @@ int sdp_init(int controller_index)
>  		}
>=20=20
>  		schedule();
> -		usb_gadget_handle_interrupts(controller_index);
> +		dm_usb_gadget_handle_interrupts(udc);
>  	}
>=20=20
>  	return 0;
> @@ -911,9 +911,9 @@ static void sdp_handle_out_ep(void)
>  }
>=20=20
>  #ifndef CONFIG_SPL_BUILD
> -int sdp_handle(int controller_index)
> +int sdp_handle(struct udevice *udc)
>  #else
> -int spl_sdp_handle(int controller_index, struct spl_image_info *spl_imag=
e,
> +int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
>  		   struct spl_boot_device *bootdev)
>  #endif
>  {
> @@ -929,7 +929,7 @@ int spl_sdp_handle(int controller_index, struct spl_i=
mage_info *spl_image,
>  			return 0;
>=20=20
>  		schedule();
> -		usb_gadget_handle_interrupts(controller_index);
> +		dm_usb_gadget_handle_interrupts(udc);
>=20=20
>  #ifdef CONFIG_SPL_BUILD
>  		flag =3D sdp_handle_in_ep(spl_image, bootdev);
> diff --git a/include/sdp.h b/include/sdp.h
> index 6d89baa04ec..5492f9c47d2 100644
> --- a/include/sdp.h
> +++ b/include/sdp.h
> @@ -9,15 +9,15 @@
>  #ifndef __SDP_H_
>  #define __SDP_H_
>=20=20
> -int sdp_init(int controller_index);
> +int sdp_init(struct udevice *udc);
>=20=20
>  #ifdef CONFIG_SPL_BUILD
>  #include <spl.h>
>=20=20
> -int spl_sdp_handle(int controller_index, struct spl_image_info *spl_imag=
e,
> +int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
>  		   struct spl_boot_device *bootdev);
>  #else
> -int sdp_handle(int controller_index);
> +int sdp_handle(struct udevice *udc);
>  #endif
>=20=20
>  #endif /* __SDP_H_ */
> --=20
> 2.40.1
