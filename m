Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A7BEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD878641E;
	Tue, 22 Aug 2023 18:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="tvYF60f1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D2D8642C; Tue, 22 Aug 2023 18:34:01 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB52863EE
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3179ed1dfbbso4333055f8f.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692722038; x=1693326838; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yNguA9GAvfhdy+kbdIq+Bcs8zlvgKi7vdwgOW+0Juo0=;
 b=tvYF60f1UcOlgEw2Bhh/D5JgRQkrzNrpxMy1IgFUxqn2elNg+daw/EEwPeYy6hIOcs
 0hB4TCrQ6J+OU/JLv73dM4Tno5p6PtLQ30pLQ+4vMlbfBjuyfXa5WZ5QLtizNXj/ZuqW
 2IBgW8hMasyak+2LLWzzkxkieFPOlOvDY+9XZomyrkG42uNP+PSD0c64OeTKT/4Eqm3q
 UrUSD0MJ1nrwSRfUZetHWAd59XeITFgUtHxXz07HPkopmQB+JFeHOpm+AkvyrbSIFDrV
 U0jqgP2Vb0aXuVYuGl0UBglKkwB2jAs5cKHi2r6GWoNpl/B0nNxZbebDlveXtqcW1Gz6
 as4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692722038; x=1693326838;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNguA9GAvfhdy+kbdIq+Bcs8zlvgKi7vdwgOW+0Juo0=;
 b=V1L3ZpYq4ZTiiWbQvw1YNe0xpPNxxO4AKtR1LWaz2vC9u7W+iV+mcVkdCxTNdJINOV
 yxaZHNiMJ8FSB65fS8PkIFdwlBBXza/rFhKUIgUZkdNmV2abe62Tya1afKCrhyt6JYEU
 XNDQ9jErRACAI5+V+YTstOBJykMCts4tRTWZ4ipPkm42p57f1J2USVNbtCCXG1h+KZj2
 0l4gzXl5nJa/mwCg3Fnjf+t4yrdtHf9BY/hREcDIK68GXfptR6xQL4heSvQm+oGtAt+b
 piQNTMW8yA115baCmGxh1whCzZTGQ/5OXfKyTeY8uvNEp6ScWCoQlX6yTZ+jShLUvo8Y
 arGQ==
X-Gm-Message-State: AOJu0YzDh3kmkGBnh9Z+wlk3ZF7/1Br90LuPzj8CC8R3dGeUhp69YYr9
 QewaOQY2LDoB6R7HOS2pUqi/NQ==
X-Google-Smtp-Source: AGHT+IEC59+Jkb34RIWZkQDZqVIvUdHyjU9nPqtdpQo/mPFHQVvzrTsNK0giCyLtpGpcZ8wTlR5bPw==
X-Received: by 2002:adf:d0c1:0:b0:319:8333:a2d4 with SMTP id
 z1-20020adfd0c1000000b003198333a2d4mr7803729wrh.29.1692722037814; 
 Tue, 22 Aug 2023 09:33:57 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 e1-20020adff341000000b003177f57e79esm16259456wrp.88.2023.08.22.09.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:33:57 -0700 (PDT)
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
Subject: Re: [PATCH 10/17] dfu: Use plain udevice for UDC controller
 interaction
In-Reply-To: <20230819142407.49632-10-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-10-marex@denx.de>
Date: Tue, 22 Aug 2023 18:33:56 +0200
Message-ID: <87350brq8b.fsf@baylibre.com>
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
>  common/dfu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/common/dfu.c b/common/dfu.c
> index 32fba84da16..45206b9e225 100644
> --- a/common/dfu.c
> +++ b/common/dfu.c
> @@ -23,11 +23,12 @@
>  int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl_gadget)
>  {
>  	bool dfu_reset =3D false;
> +	struct udevice *udc;
>  	int ret, i =3D 0;
>=20=20
> -	ret =3D usb_gadget_initialize(usbctrl_index);
> +	ret =3D udc_device_get_by_index(usbctrl_index, &udc);
>  	if (ret) {
> -		pr_err("usb_gadget_initialize failed\n");
> +		pr_err("udc_device_get_by_index failed\n");
>  		return CMD_RET_FAILURE;
>  	}
>  	g_dnl_clear_detach();
> @@ -55,7 +56,7 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl=
_gadget)
>  			}
>=20=20
>  			/*
> -			 * This extra number of usb_gadget_handle_interrupts()
> +			 * This extra number of dm_usb_gadget_handle_interrupts()
>  			 * calls is necessary to assure correct transmission
>  			 * completion with dfu-util
>  			 */
> @@ -68,7 +69,7 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl=
_gadget)
>=20=20
>  		if (dfu_get_defer_flush()) {
>  			/*
> -			 * Call to usb_gadget_handle_interrupts() is necessary
> +			 * Call to dm_usb_gadget_handle_interrupts() is necessary
>  			 * to act on ZLP OUT transaction from HOST PC after
>  			 * transmitting the whole file.
>  			 *
> @@ -77,7 +78,7 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl=
_gadget)
>  			 * 5 seconds). In such situation the dfu-util program
>  			 * exits with error message.
>  			 */
> -			usb_gadget_handle_interrupts(usbctrl_index);
> +			dm_usb_gadget_handle_interrupts(udc);
>  			ret =3D dfu_flush(dfu_get_defer_flush(), NULL, 0, 0);
>  			dfu_set_defer_flush(NULL);
>  			if (ret) {
> @@ -103,12 +104,12 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb=
_dnl_gadget)
>  			goto exit;
>=20=20
>  		schedule();
> -		usb_gadget_handle_interrupts(usbctrl_index);
> +		dm_usb_gadget_handle_interrupts(udc);
>  	}
>  exit:
>  	g_dnl_unregister();
>  err_detach:
> -	usb_gadget_release(usbctrl_index);
> +	udc_device_put(udc);
>=20=20
>  	if (dfu_reset)
>  		do_reset(NULL, 0, 0, NULL);
> --=20
> 2.40.1
