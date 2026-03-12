Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D09F1067020
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 13:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD104841FF;
	Thu, 12 Mar 2026 14:50:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="onRw+si0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512058421E; Thu, 12 Mar 2026 14:50:26 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E5184150
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 14:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-463a0e14abfso675391b6e.2
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773323423; x=1773928223; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R01lS+ujoEfm8N1x/lejb4KpMo4XHtf+ezSrHH56EEc=;
 b=onRw+si0TX0a3WL4twOHQ7dhP5665FQDtd/5pBQ98WQyw/78bvVufFrE/59cznqUiA
 si1AH40C8BYl+SZwiN9bwzf585aK2N2wzyc+e0QHhEZFdpNLvR44azVkqRxe3f4Pl6NT
 xunXs5M9LVltB47tiOsN+k0RnzrFTSu47HxrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773323423; x=1773928223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R01lS+ujoEfm8N1x/lejb4KpMo4XHtf+ezSrHH56EEc=;
 b=ENLU8ecICBMDJOro4nqliGx9JwU1eXp4vQPdIgXGwMlBQ56szTFXpNZ+xgyAfHqM1n
 KrE+qY/hi/MWid4+/5P+nJf/ZXfnErvEPQqbgbnpWkEfY8NHIxuwGeILeGw/mtmWhLuf
 IhNkrXdB/r+ze7JVJXz6dXjClYIWcAyGVyncwuGbVWIzQL5M2kKVRva9oKXMzkDKSZQL
 I5nhQFuqrhuxwnU2HcbgeBUxiNUW4jDcyRs79s4Hno2UXJABxOtDp+GNfsmkIPCZ5+cW
 pduOvr/EzQ5Zd0lEOb8LVMLh6mRNN1mhUeXKsNn21k8lhKHe7oeGobikpRupW/9BscNw
 CSgA==
X-Gm-Message-State: AOJu0YyrMbIW8l9QM17HiDWbNGfuiuY55jKOrU2V16BFK4vtiy4hpqxp
 GaBFPu6UQRGThuvVP+1Jlv32P9656WfN5SHo29XpTKDqryZj/gH9W/7qxaXQMzYNuMY=
X-Gm-Gg: ATEYQzxXdGskxajCX5EhHsC/zl/3VqBCb8Nm9rOYKHqybicohT9SX0hJQkHgdQ16fR/
 Lwl4amSFrz8vhQx317F3PDdEb8VkAOsr6OQVFGsZOfuqqtq42V6qO3DSQxl3olLCAwmlmxyPqHn
 wyR66+24MhhuNj6wVoVDPI3LTyHXiwfEjYVrl3nGJJ1QP4ZFEnyLqL0+aCCR7nsAbUzXcp3onlg
 xmpMv9xS00lNiLekIMNynsiLmJXf9YCnhem3ieK5oXpXQBYHSTh7CLGdpUf0INwxiATwskeR1Sb
 Fvh2Lk8/VGH3djxQklVX6R4HrgwSriO/mmN/w/4SjTt+uzH+62U47Zez/67iohc+Lxzycivs/HH
 WwNHGZYIOrsLNfa3jtzhGVetNnjnM1U8PUvYHIPFUFTtS6Bh0oyQTez5DNKPCYB3PhZHcuym1r/
 EVTTi1aW3Xu1zG3JmI+VT+XFZu6BSux1dwc/ojCL4CpVy/Lybco1NAS6T53XMfazwjBcZH21hMq
 iVEB814vUVX4+G0Ivf2rni1qhhwyn09TTeLskgPWJsWVE16
X-Received: by 2002:a05:6808:2447:b0:467:2683:f648 with SMTP id
 5614622812f47-467333c5d58mr3369402b6e.9.1773323422588; 
 Thu, 12 Mar 2026 06:50:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46734123939sm2982483b6e.3.2026.03.12.06.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 06:50:21 -0700 (PDT)
Date: Thu, 12 Mar 2026 07:50:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Prasanth Babu Mantena <p-mantena@ti.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.denx.de, n-francis@ti.com, u-kumar1@ti.com,
 vigneshr@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH] Revert "usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG"
Message-ID: <20260312135019.GA502704@bill-the-cat>
References: <20260312133247.2192335-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PwVUf6VjLmxoJJRO"
Content-Disposition: inline
In-Reply-To: <20260312133247.2192335-1-p-mantena@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--PwVUf6VjLmxoJJRO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 07:02:47PM +0530, Prasanth Babu Mantena wrote:

> While USB DFU boot works with this patch, but the non USB boot modes like
> SD Boot and flash boot fails for J784S4 EVM device.
>=20
> So, Reverting this patch.
>=20
> This reverts commit bfb530e06ca6c19f66c079601e568c761a001993.
>=20
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>  drivers/usb/cdns3/core.c | 53 ----------------------------------------
>  drivers/usb/cdns3/drd.c  | 11 ---------
>  2 files changed, 64 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 10bc4cabed4..4434dc15bec 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -392,52 +392,6 @@ static const struct udevice_id cdns3_ids[] =3D {
>  	{ },
>  };
> =20
> -/*
> - * The VBUS Valid Bit in the OTG Status register can be used to determine
> - * the role. When VBUS Valid is set, it indicates that a USB Host is sup=
plying
> - * power, so the Controller should assume the PERIPHERAL role. If it isn=
't set,
> - * it indicates the absence of a USB Host, so the Controller should assu=
me the
> - * HOST role. If the OTG Status register is inaccessible, return an erro=
r.
> - */
> -static int cdns3_get_otg_mode(struct udevice *parent, enum usb_dr_mode *=
mode)
> -{
> -	/* Create a temporary child device for using devfdt_remap_addr_name() */
> -	struct udevice child =3D {
> -		.parent =3D parent,
> -	};
> -	struct cdns3 cdns, *cdnsp;
> -	void __iomem *otg_regs;
> -
> -	dev_set_ofnode(&child, ofnode_first_subnode(dev_ofnode(parent)));
> -	otg_regs =3D devfdt_remap_addr_name(&child, "otg");
> -	if (!otg_regs) {
> -		dev_err(parent, "failed to get otg registers for child node\n");
> -		return -ENXIO;
> -	}
> -
> -	/*
> -	 * As mentioned in drivers/usb/cdns3/drd.c, there are two versions
> -	 * of the Controller. The following logic detects the version of the
> -	 * Controller and interprets the register layout accordingly.
> -	 */
> -	cdnsp =3D &cdns;
> -	cdnsp->otg_v0_regs =3D otg_regs;
> -	if (!readl(&cdnsp->otg_v0_regs->cmd)) {
> -		cdnsp->otg_regs =3D otg_regs;
> -	} else {
> -		cdnsp->otg_v1_regs =3D otg_regs;
> -		cdnsp->otg_regs =3D (void *)&cdnsp->otg_v1_regs->cmd;
> -	}
> -
> -	/* Use VBUS Valid to determine role */
> -	if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID)
> -		*mode =3D USB_DR_MODE_PERIPHERAL;
> -	else
> -		*mode =3D USB_DR_MODE_HOST;
> -
> -	return 0;
> -}
> -
>  int cdns3_bind(struct udevice *parent)
>  {
>  	enum usb_dr_mode dr_mode;
> @@ -459,13 +413,6 @@ int cdns3_bind(struct udevice *parent)
>  	if (dr_mode =3D=3D USB_DR_MODE_UNKNOWN)
>  		dr_mode =3D usb_get_dr_mode(dev_ofnode(parent));
> =20
> -	/* Use VBUS Valid to determine role */
> -	if (dr_mode =3D=3D USB_DR_MODE_OTG) {
> -		ret =3D cdns3_get_otg_mode(parent, &dr_mode);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>  	switch (dr_mode) {
>  #if defined(CONFIG_SPL_USB_HOST) || \
>  	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 0ca40a5cc8d..cbb13342343 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -301,17 +301,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
>  		cdns->dr_mode =3D USB_DR_MODE_PERIPHERAL;
>  	}
> =20
> -	/*
> -	 * In the absence of STRAP configuration, use VBUS Valid to
> -	 * determine the appropriate role to be assigned to dr_mode.
> -	 */
> -	if (cdns->dr_mode =3D=3D USB_DR_MODE_OTG) {
> -		if (cdns3_get_vbus(cdns))
> -			cdns->dr_mode =3D USB_DR_MODE_PERIPHERAL;
> -		else
> -			cdns->dr_mode =3D USB_DR_MODE_HOST;
> -	}
> -
>  	state =3D readl(&cdns->otg_regs->sts);
>  	if (OTGSTS_OTG_NRDY(state) !=3D 0) {
>  		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");

Adding in the USB custodian as this revert is intended for master and
v2026.04 I assume as the commit being reverted is also in master.
Thanks.

--=20
Tom

--PwVUf6VjLmxoJJRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabLEmAAKCRAr4qD1Cr/k
CnRMAP9TZ/DWDM/o/SV5Er9x+WLh18YHJ47ADsfaau6vHIt6ewEAnsaDF8Tj5U1q
nRZmrmwOf+yVf3BuF7Dyvpbu+MHhYwk=
=cZyK
-----END PGP SIGNATURE-----

--PwVUf6VjLmxoJJRO--
