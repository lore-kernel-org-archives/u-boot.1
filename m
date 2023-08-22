Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F66EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C36864B0;
	Tue, 22 Aug 2023 18:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="L3aU1Ako";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CB3864B2; Tue, 22 Aug 2023 18:29:21 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6AA08648E
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3197808bb08so4319366f8f.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692721757; x=1693326557; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SNA8dgc62OGZlR1bI11GQMoQJ9OrUBGvmDIQTDjPsx8=;
 b=L3aU1AkoIalPJR7nxASKERMH5FMcsOLVOLucfNs6Z6GoJly0N5RpknGQB6LZt+OiJ9
 Rzv5dPp3PhXPzTcchV/GSllV9EdcoIL1s40GmrnwlG6McMxiH4+NFaJ5vG6nFaFUymAh
 F3j2BxMSKXLIwXZhlAAawKcaIefdlLrlRUSnXJxc5SUXvV5U1AwTLH/ClB915pOZey+J
 /a2GFKyHPbMpXO7ZVCJD33Broi9IsJhxTl3NfiIzi+ampLriLdelaif0uZ5q9T37TjSu
 NoCbOQRrwtGvrUx4+G7laQiU9jBdXeT78RbOTObMBjXnXznNBG0hxbl/ckm1ESwtrmfA
 V+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692721757; x=1693326557;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNA8dgc62OGZlR1bI11GQMoQJ9OrUBGvmDIQTDjPsx8=;
 b=NKv/yJfiDDBcC8iFj7/Wb26iBWrc6hkc/UKE2Xk88pIXnHvQ8D/tDr3a40qyk4xKRW
 ff2J9PLHvHpXaU8p+d0za+BxR3/0z6JGbseQUFHj0PLbDCiHTZPIYqap6QnyznGo5F/O
 WEj/j6/Zh8Jgdqpk8nKXCGU7PdET2azCSkk4B3mAz3PaZnG2OZ02r9VyqpyvvuLCYpHS
 bnaGWbmJuLz/ujdpZ6agR9nUAYcBVHD2oOmNmjDAuBEVVceXyuHge5EdukCIvHkK7yOw
 EQAYEgKjpjXL4lvDF0ASDr5Ts9ajeHXumJYsVgNSfJUWulY1BGL2LVh/Y0J5i+0xvWLu
 ZHwg==
X-Gm-Message-State: AOJu0Yxb5LIV+J36imRZkcmjFZ85veHVV05NfWwR3WsGEHD7EhtF+bx/
 pTntgbc4p5QK1nqf0YpgpTWlUA==
X-Google-Smtp-Source: AGHT+IEVJghmKDgYo2DHs+yuHvanrP4i0I81yIsh3CHima0GvtbjUng5kM4UTdm1v0Y9ukIsdd9epw==
X-Received: by 2002:adf:dcce:0:b0:319:6b6c:dd01 with SMTP id
 x14-20020adfdcce000000b003196b6cdd01mr8113327wrm.17.1692721757184; 
 Tue, 22 Aug 2023 09:29:17 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 n16-20020adfe790000000b0030ae53550f5sm16169439wrm.51.2023.08.22.09.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:29:16 -0700 (PDT)
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
Subject: Re: [PATCH 08/17] cmd: ums: Use plain udevice for UDC controller
 interaction
In-Reply-To: <20230819142407.49632-8-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-8-marex@denx.de>
Date: Tue, 22 Aug 2023 18:29:15 +0200
Message-ID: <878ra3rqg4.fsf@baylibre.com>
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
>  cmd/usb_mass_storage.c              | 10 ++++++----
>  drivers/usb/gadget/f_mass_storage.c |  8 ++++----
>  include/usb_mass_storage.h          |  2 +-
>  3 files changed, 11 insertions(+), 9 deletions(-)

Tested on vim3 with:
=3D> ums 0 mmc 2

Tested that I could read some files from the android data partition.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on khadas vim3

>
> diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
> index c3cc1975f9d..9c51ae0967f 100644
> --- a/cmd/usb_mass_storage.c
> +++ b/cmd/usb_mass_storage.c
> @@ -143,6 +143,7 @@ static int do_usb_mass_storage(struct cmd_tbl *cmdtp,=
 int flag,
>  	const char *devtype;
>  	const char *devnum;
>  	unsigned int controller_index;
> +	struct udevice *udc;
>  	int rc;
>  	int cable_ready_timeout __maybe_unused;
>=20=20
> @@ -164,13 +165,14 @@ static int do_usb_mass_storage(struct cmd_tbl *cmdt=
p, int flag,
>=20=20
>  	controller_index =3D (unsigned int)(simple_strtoul(
>  				usb_controller,	NULL, 0));
> -	if (usb_gadget_initialize(controller_index)) {
> +	rc =3D udc_device_get_by_index(controller_index, &udc);
> +	if (rc) {
>  		pr_err("Couldn't init USB controller.\n");
>  		rc =3D CMD_RET_FAILURE;
>  		goto cleanup_ums_init;
>  	}
>=20=20
> -	rc =3D fsg_init(ums, ums_count, controller_index);
> +	rc =3D fsg_init(ums, ums_count, udc);
>  	if (rc) {
>  		pr_err("fsg_init failed\n");
>  		rc =3D CMD_RET_FAILURE;
> @@ -215,7 +217,7 @@ static int do_usb_mass_storage(struct cmd_tbl *cmdtp,=
 int flag,
>  	}
>=20=20
>  	while (1) {
> -		usb_gadget_handle_interrupts(controller_index);
> +		dm_usb_gadget_handle_interrupts(udc);
>=20=20
>  		rc =3D fsg_main_thread(NULL);
>  		if (rc) {
> @@ -247,7 +249,7 @@ static int do_usb_mass_storage(struct cmd_tbl *cmdtp,=
 int flag,
>  cleanup_register:
>  	g_dnl_unregister();
>  cleanup_board:
> -	usb_gadget_release(controller_index);
> +	udc_device_put(udc);
>  cleanup_ums_init:
>  	ums_fini();
>=20=20
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_m=
ass_storage.c
> index f46829eb7ad..1d17331cb03 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -435,7 +435,7 @@ static void set_bulk_out_req_length(struct fsg_common=
 *common,
>  static struct ums *ums;
>  static int ums_count;
>  static struct fsg_common *the_fsg_common;
> -static unsigned int controller_index;
> +static struct udevice *udcdev;
>=20=20
>  static int fsg_set_halt(struct fsg_dev *fsg, struct usb_ep *ep)
>  {
> @@ -680,7 +680,7 @@ static int sleep_thread(struct fsg_common *common)
>  			k =3D 0;
>  		}
>=20=20
> -		usb_gadget_handle_interrupts(controller_index);
> +		dm_usb_gadget_handle_interrupts(udcdev);
>  	}
>  	common->thread_wakeup_needed =3D 0;
>  	return rc;
> @@ -2764,11 +2764,11 @@ int fsg_add(struct usb_configuration *c)
>  	return fsg_bind_config(c->cdev, c, fsg_common);
>  }
>=20=20
> -int fsg_init(struct ums *ums_devs, int count, unsigned int controller_id=
x)
> +int fsg_init(struct ums *ums_devs, int count, struct udevice *udc)
>  {
>  	ums =3D ums_devs;
>  	ums_count =3D count;
> -	controller_index =3D controller_idx;
> +	udcdev =3D udc;
>=20=20
>  	return 0;
>  }
> diff --git a/include/usb_mass_storage.h b/include/usb_mass_storage.h
> index 08ccc97cf22..83ab93b530d 100644
> --- a/include/usb_mass_storage.h
> +++ b/include/usb_mass_storage.h
> @@ -25,7 +25,7 @@ struct ums {
>  	struct blk_desc block_dev;
>  };
>=20=20
> -int fsg_init(struct ums *ums_devs, int count, unsigned int controller_id=
x);
> +int fsg_init(struct ums *ums_devs, int count, struct udevice *udc);
>  void fsg_cleanup(void);
>  int fsg_main_thread(void *);
>  int fsg_add(struct usb_configuration *c);
> --=20
> 2.40.1
