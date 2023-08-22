Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AFCEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995BF8648E;
	Tue, 22 Aug 2023 18:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="hf7qOTHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12D48648E; Tue, 22 Aug 2023 18:58:39 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A21864D5
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so44997405e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692723515; x=1693328315; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HY4sZ/+wowfdppfOFMn0Hty3CiYyThf1tOwYa1oKHqY=;
 b=hf7qOTHzVCrJVtKS/LFVB7SEUuKj/EkB7+lGFdQ6r1jHQuaYTCTsUx4AhclE7MBv95
 P82L6I7+R3J8prNqdWkNVvoeZato/Qo79r13Yhx3jb8h9Bj+N28VAFG3BhdqCMrxMVgc
 fOXK8mk3rRLk2pvtAydl94F6Gz9M20F9hckXXGvh7EHCo0h0+k2FZBbRGpxviSskVOhC
 1e0lJwvQuFyX9F9R+3SnoQr3ttgJTG9pDr7xgCwEnoIGfhPADuVY50fqKKFD7p4RJd/t
 MJ5qP4bxxSEIHr5mFuiwZhSdlWDqM39E5YZ+vRjzZAuV/8UG77nCT1ynggMyhzQjT/6y
 NZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723515; x=1693328315;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HY4sZ/+wowfdppfOFMn0Hty3CiYyThf1tOwYa1oKHqY=;
 b=ctb/uTCbVEo0vDSDBfO7vNjM+9SeKXTTFfan0MJzEomCinsb1nnWf9LPy9xAMzRbRp
 xUrwdZcY4yV1gRHInLzduCp3/E1d1gS3UEIb0tR803lCTOJ7s6Q4KZhhzTmQ1+uZTHLe
 E6UMS4xwiicUxEGMKfpJsqwSIc+x6ncHZF3Yks5CIuFX/ldFnlhcq/uJVeRqPbfzDyar
 gFpvdtFv7h80k/7Zy+XyyrfcmLbVa7Wbh/oRnaSo5MYqHNIMm1RHA7QQM6UTF8ffuqrS
 UdFktkLDvidACe1/4ufU5dinXvYSq27i2ttv2OWRWjK/mwA10lEcmMNKATtVaLWBwpZW
 ejSQ==
X-Gm-Message-State: AOJu0YxDBPD/pRK9Y67JoK0ZL6427VkIwGpR/RUVwQtBkFBYNagoKYR6
 Asq3C/tLFQ/EfoqvxhCybOd/ig==
X-Google-Smtp-Source: AGHT+IFOd+rFE2JphwYV1e8brmTMTborwAmQXvlhPtPdwf08FmPhvdBSYf6IWmI9WpvpwgvQ79W3bA==
X-Received: by 2002:a5d:43d0:0:b0:319:735c:73e1 with SMTP id
 v16-20020a5d43d0000000b00319735c73e1mr7842633wrr.4.1692723515146; 
 Tue, 22 Aug 2023 09:58:35 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 v17-20020a1cf711000000b003fe23b10fdfsm20157399wmh.36.2023.08.22.09.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:58:34 -0700 (PDT)
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
Subject: Re: [PATCH 17/17] board: usb: Replace legacy
 usb_gadget_handle_interrupts()
In-Reply-To: <20230819142407.49632-17-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-17-marex@denx.de>
Date: Tue, 22 Aug 2023 18:58:33 +0200
Message-ID: <87r0nvqaiu.fsf@baylibre.com>
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

> The usb_gadget_handle_interrupts() is no longer used anywhere,
> replace the remaining uses with dm_usb_gadget_handle_interrupts()
> which takes udevice as a parameter.
>
> Some of the UDC drivers currently ignore the index parameter altogether,
> those also ignore the udevice and have to be reworked. Other like the
> dwc3_uboot_handle_interrupt() had to be switched from index to udevice
> look up to avoid breakage.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> NOTE: Next step, get rid of dwc3_uboot_init()/dwc3_uboot_exit()
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
>  arch/arm/mach-rockchip/board.c      |  4 ++--
>  board/purism/librem5/spl.c          |  4 ++--
>  board/samsung/common/exynos5-dt.c   |  4 ++--
>  board/st/stih410-b2260/board.c      |  4 ++--
>  board/ti/am43xx/board.c             |  6 +++---
>  drivers/usb/dwc3/core.c             |  6 +++---
>  drivers/usb/dwc3/dwc3-omap.c        |  8 ++++----
>  drivers/usb/gadget/at91_udc.c       |  2 +-
>  drivers/usb/gadget/atmel_usba_udc.c |  3 +--
>  drivers/usb/gadget/ci_udc.c         |  4 ++--
>  drivers/usb/gadget/dwc2_udc_otg.c   | 12 ++----------
>  drivers/usb/gadget/udc/udc-uclass.c | 12 ------------
>  drivers/usb/host/usb-sandbox.c      |  5 -----
>  drivers/usb/musb-new/musb_uboot.c   |  2 +-
>  include/dwc3-omap-uboot.h           |  2 +-
>  include/dwc3-uboot.h                |  2 +-
>  include/linux/usb/gadget.h          |  2 +-
>  17 files changed, 28 insertions(+), 54 deletions(-)

Tested that I could reflash the vim3 bootloader (on mmc2boot0)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on khadas vim3

>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/boar=
d.c
> index 8d7b39ba157..57f08e0be0e 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -299,9 +299,9 @@ static struct dwc3_device dwc3_device_data =3D {
>  	.hsphy_mode =3D USBPHY_INTERFACE_MODE_UTMIW,
>  };
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
> -	dwc3_uboot_handle_interrupt(0);
> +	dwc3_uboot_handle_interrupt(dev);
>  	return 0;
>  }
>=20=20
> diff --git a/board/purism/librem5/spl.c b/board/purism/librem5/spl.c
> index 90f1fcf415f..581f0929662 100644
> --- a/board/purism/librem5/spl.c
> +++ b/board/purism/librem5/spl.c
> @@ -418,9 +418,9 @@ out:
>  	return rv;
>  }
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
> -	dwc3_uboot_handle_interrupt(0);
> +	dwc3_uboot_handle_interrupt(dev);
>  	return 0;
>  }
>=20=20
> diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exy=
nos5-dt.c
> index cde77d79a0f..726b7f0667a 100644
> --- a/board/samsung/common/exynos5-dt.c
> +++ b/board/samsung/common/exynos5-dt.c
> @@ -126,9 +126,9 @@ static struct dwc3_device dwc3_device_data =3D {
>  	.index =3D 0,
>  };
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
> -	dwc3_uboot_handle_interrupt(0);
> +	dwc3_uboot_handle_interrupt(dev);
>  	return 0;
>  }
>=20=20
> diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/boar=
d.c
> index cd3a7dc51a2..e21cbc270e9 100644
> --- a/board/st/stih410-b2260/board.c
> +++ b/board/st/stih410-b2260/board.c
> @@ -50,9 +50,9 @@ static struct dwc3_device dwc3_device_data =3D {
>  	.index =3D 0,
>  };
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
> -	dwc3_uboot_handle_interrupt(index);
> +	dwc3_uboot_handle_interrupt(dev);
>  	return 0;
>  }
>=20=20
> diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
> index 87e552a4701..58bfe7cd455 100644
> --- a/board/ti/am43xx/board.c
> +++ b/board/ti/am43xx/board.c
> @@ -760,13 +760,13 @@ static struct ti_usb_phy_device usb_phy2_device =3D=
 {
>  	.index =3D 1,
>  };
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
>  	u32 status;
>=20=20
> -	status =3D dwc3_omap_uboot_interrupt_status(index);
> +	status =3D dwc3_omap_uboot_interrupt_status(dev);
>  	if (status)
> -		dwc3_uboot_handle_interrupt(index);
> +		dwc3_uboot_handle_interrupt(dev);
>=20=20
>  	return 0;
>  }
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 49f6a1900b0..7ca9d09824e 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -986,18 +986,18 @@ void dwc3_uboot_exit(int index)
>=20=20
>  /**
>   * dwc3_uboot_handle_interrupt - handle dwc3 core interrupt
> - * @index: index of this controller
> + * @dev: device of this controller
>   *
>   * Invokes dwc3 gadget interrupts.
>   *
>   * Generally called from board file.
>   */
> -void dwc3_uboot_handle_interrupt(int index)
> +void dwc3_uboot_handle_interrupt(struct udevice *dev)
>  {
>  	struct dwc3 *dwc =3D NULL;
>=20=20
>  	list_for_each_entry(dwc, &dwc3_list, list) {
> -		if (dwc->index !=3D index)
> +		if (dwc->dev !=3D dev)
>  			continue;
>=20=20
>  		dwc3_gadget_uboot_handle_interrupt(dwc);
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 9596bf144c3..ff4ebfb4447 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -119,7 +119,7 @@
>  #define USBOTGSS_UTMI_OTG_STATUS_VBUSVALID	(1 << 1)
>=20=20
>  struct dwc3_omap {
> -	struct device		*dev;
> +	struct udevice		*dev;
>=20=20
>  	void __iomem		*base;
>=20=20
> @@ -429,19 +429,19 @@ void dwc3_omap_uboot_exit(int index)
>=20=20
>  /**
>   * dwc3_omap_uboot_interrupt_status - check the status of interrupt
> - * @index: index of this controller
> + * @dev: device of this controller
>   *
>   * Checks the status of interrupts and returns true if an interrupt
>   * is detected or false otherwise.
>   *
>   * Generally called from board file.
>   */
> -int dwc3_omap_uboot_interrupt_status(int index)
> +int dwc3_omap_uboot_interrupt_status(struct udevice *dev)
>  {
>  	struct dwc3_omap *omap =3D NULL;
>=20=20
>  	list_for_each_entry(omap, &dwc3_omap_list, list)
> -		if (omap->index =3D=3D index)
> +		if (omap->dev =3D=3D dev)
>  			return dwc3_omap_interrupt(-1, omap);
>=20=20
>  	return 0;
> diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
> index baa4c431fed..61d2aa5b929 100644
> --- a/drivers/usb/gadget/at91_udc.c
> +++ b/drivers/usb/gadget/at91_udc.c
> @@ -1429,7 +1429,7 @@ static const struct at91_udc_caps at91sam9261_udc_c=
aps =3D {
>  };
>  #endif
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
>  	struct at91_udc *udc =3D controller;
>=20=20
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atm=
el_usba_udc.c
> index f4dcd205a4f..90b248a0777 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1198,14 +1198,13 @@ static struct usba_udc controller =3D {
>  	},
>  };
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
>  	struct usba_udc *udc =3D &controller;
>=20=20
>  	return usba_udc_irq(udc);
>  }
>=20=20
> -
>  int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  {
>  	struct usba_udc *udc =3D &controller;
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index 5bb26d7ab4a..44d2da0b4fb 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -869,10 +869,10 @@ void udc_irq(void)
>  	}
>  }
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
> -	u32 value;
>  	struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
> +	u32 value;
>=20=20
>  	value =3D readl(&udc->usbsts);
>  	if (value)
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_=
udc_otg.c
> index 0a3bc0886e6..ff5173eda68 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -941,15 +941,12 @@ int dwc2_udc_handle_interrupt(void)
>  	return 0;
>  }
>=20=20
> -#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
> -
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
>  	return dwc2_udc_handle_interrupt();
>  }
>=20=20
> -#else /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
> -
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
>  struct dwc2_priv_data {
>  	struct clk_bulk		clks;
>  	struct reset_ctl_bulk	resets;
> @@ -957,11 +954,6 @@ struct dwc2_priv_data {
>  	struct udevice *usb33d_supply;
>  };
>=20=20
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	return dwc2_udc_handle_interrupt();
> -}
> -
>  static int dwc2_phy_setup(struct udevice *dev, struct phy_bulk *phys)
>  {
>  	int ret;
> diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc=
/udc-uclass.c
> index 7f54a3b00cb..9dfae08313b 100644
> --- a/drivers/usb/gadget/udc/udc-uclass.c
> +++ b/drivers/usb/gadget/udc/udc-uclass.c
> @@ -41,18 +41,6 @@ int udc_device_put(struct udevice *udev)
>  	return -ENOSYS;
>  #endif
>  }
> -
> -int usb_gadget_handle_interrupts(int index)
> -{
> -	struct udevice *udc;
> -	int ret;
> -
> -	ret =3D udc_device_get_by_index(index, &udc);
> -	if (ret)
> -		return ret;
> -
> -	return dm_usb_gadget_handle_interrupts(udc);
> -}
>  #else
>  /* Backwards hardware compatibility -- switch to DM_USB_GADGET */
>  static int legacy_index;
> diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbo=
x.c
> index 582f72d00c1..3d4f8d653b5 100644
> --- a/drivers/usb/host/usb-sandbox.c
> +++ b/drivers/usb/host/usb-sandbox.c
> @@ -130,11 +130,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *=
dev)
>  	return 0;
>  }
>  #else
> -int usb_gadget_handle_interrupts(int index)
> -{
> -	return 0;
> -}
> -
>  int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  {
>  	struct sandbox_udc *dev =3D this_controller;
> diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/mus=
b_uboot.c
> index 67dc11669d2..0dcc428efeb 100644
> --- a/drivers/usb/musb-new/musb_uboot.c
> +++ b/drivers/usb/musb-new/musb_uboot.c
> @@ -376,7 +376,7 @@ struct dm_usb_ops musb_usb_ops =3D {
>  #if defined(CONFIG_USB_MUSB_GADGET) && !CONFIG_IS_ENABLED(DM_USB_GADGET)
>  static struct musb *gadget;
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
>  	schedule();
>  	if (!gadget || !gadget->isr)
> diff --git a/include/dwc3-omap-uboot.h b/include/dwc3-omap-uboot.h
> index 7c982e3798b..9e0e717dc98 100644
> --- a/include/dwc3-omap-uboot.h
> +++ b/include/dwc3-omap-uboot.h
> @@ -27,5 +27,5 @@ struct dwc3_omap_device {
>=20=20
>  int dwc3_omap_uboot_init(struct dwc3_omap_device *dev);
>  void dwc3_omap_uboot_exit(int index);
> -int dwc3_omap_uboot_interrupt_status(int index);
> +int dwc3_omap_uboot_interrupt_status(struct udevice *dev);
>  #endif /* __DWC3_OMAP_UBOOT_H_ */
> diff --git a/include/dwc3-uboot.h b/include/dwc3-uboot.h
> index e08530ec4e5..bb0436c0973 100644
> --- a/include/dwc3-uboot.h
> +++ b/include/dwc3-uboot.h
> @@ -44,7 +44,7 @@ struct dwc3_device {
>=20=20
>  int dwc3_uboot_init(struct dwc3_device *dev);
>  void dwc3_uboot_exit(int index);
> -void dwc3_uboot_handle_interrupt(int index);
> +void dwc3_uboot_handle_interrupt(struct udevice *dev);
>=20=20
>  struct phy;
>  #if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 54875d2716e..40228e320b3 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -1004,7 +1004,7 @@ extern struct usb_ep *usb_ep_autoconfig(struct usb_=
gadget *,
>=20=20
>  extern void usb_ep_autoconfig_reset(struct usb_gadget *);
>=20=20
> -extern int usb_gadget_handle_interrupts(int index);
> +extern int dm_usb_gadget_handle_interrupts(struct udevice *);
>=20=20
>  /**
>   * udc_device_get_by_index() - Get UDC udevice by index
> --=20
> 2.40.1
