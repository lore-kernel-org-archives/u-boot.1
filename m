Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AC4C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 01:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1D0087E25;
	Mon, 26 Feb 2024 02:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AeDBhKQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA54287E2A; Mon, 26 Feb 2024 02:47:14 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A158718A
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 02:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-608cba5507aso22961407b3.2
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 17:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708912031; x=1709516831; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y6BY0orspuxyK2aSHFeJezc5EynRatTZ/9vQ+SO5twc=;
 b=AeDBhKQGv45kf7fTs5N2X1kZ4wWY8HODwWiLTizc/boypfHV9FCdVqipAtgI33Wrmy
 7hUVHTrZ9w18si2I23EeA5gOntt6FxUIXxzjk3Sjn91ZJN2vruoA+zJe5iu/44FuvPed
 jywNQhMbmovZ5gl8u3bjf7h2jSVbpVU8nrChw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708912031; x=1709516831;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6BY0orspuxyK2aSHFeJezc5EynRatTZ/9vQ+SO5twc=;
 b=j5R3MoNv0LpHfaVAowZy47qwITAA1vcxStg3GhhWfr4y88hTZk0NCdx5btLKFOlAAL
 XqdN+b+5KXYONqzVkSTpLo5VzCCgIg6LCwRcq3V3L32czFk+SVQBlMTbiDb5Op9gjV9m
 ARiE/NMTm8PFdBwYGhiW0iwPU7MaYlf66aVchuPM2cBugVKxUC7E9JFR96bJ/qLV63HZ
 tjxgErjzc+ftBWpO/Lv5CjvD4ocAVq4vaXeIpyBsCvM/yJ5gJUF/PeHlMHJWcq5Lvat+
 TJYjQVaf2O0aAaZBgmlBXF9uhkoca5Mn1PGQ8n9Ei95FaBclQc8BxQELHjUQA08Czxmf
 VrBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE+MzUbvoW9DGS13ntOx2WwxcOEW1CHJVeg3mW0GzO8mr1ov+4jBfZX94SWNr+/ktuvWcqy+IJbgMF5/91+vtJx7V+Dw==
X-Gm-Message-State: AOJu0YyvmPqG5J5lIq/Q7kjaNIaILNi88wnLmZ+NPHpsBe9HrReUONgx
 hZjNv6sMj4vD6C8C6EJ9BmYOz7kp/u0k02KjE4bPhGBxmD8xGkhPUirBRDtGi6k=
X-Google-Smtp-Source: AGHT+IEJgejNiyjipJBRfy5I/vDqR566LefgHERFbgVYNm9r1wqfSL7Ag1MqaQ26CPsD0kjrjmu/IA==
X-Received: by 2002:a81:4009:0:b0:608:b5f7:a6cd with SMTP id
 l9-20020a814009000000b00608b5f7a6cdmr4829663ywn.6.1708912031129; 
 Sun, 25 Feb 2024 17:47:11 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 r135-20020a0de88d000000b006086a467647sm966579ywe.56.2024.02.25.17.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 17:47:10 -0800 (PST)
Date: Sun, 25 Feb 2024 20:47:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
Message-ID: <20240226014708.GH3040305@bill-the-cat>
References: <20240225152715.1821613-1-jonas@kwiboo.se>
 <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
 <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1aYqLJnCdYmYYeRe"
Content-Disposition: inline
In-Reply-To: <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
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


--1aYqLJnCdYmYYeRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 01:02:04AM +0100, Jonas Karlman wrote:
> On 2024-02-25 23:01, Marek Vasut wrote:
> > On 2/25/24 4:27 PM, Jonas Karlman wrote:
> >> Build fail with the following error when DM_USB_GADGET is enabled and
> >> USB_DWC3_GADGET is disabled:
> >>
> >>    dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
> >>    dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10=
):
> >>      undefined reference to `dwc3_gadget_uboot_handle_interrupt'
> >>
> >> Build also fail with the following error when USB_GADGET_DWC2_OTG +
> >> DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled:
> >>
> >>    gadget/dwc2_udc_otg.o: in function `dm_usb_gadget_handle_interrupts=
':
> >>    gadget/dwc2_udc_otg.c:947: multiple definition of `dm_usb_gadget_ha=
ndle_interrupts';
> >>      dwc3/dwc3-generic.o:dwc3/dwc3-generic.c:197: first defined here
> >>
> >> Fix this by checking for USB_DWC3_GADGET in addition to DM_USB_GADGET.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >>   drivers/usb/dwc3/dwc3-generic.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-g=
eneric.c
> >> index 6fb2de8a5ace..891d01957619 100644
> >> --- a/drivers/usb/dwc3/dwc3-generic.c
> >> +++ b/drivers/usb/dwc3/dwc3-generic.c
> >> @@ -192,7 +192,7 @@ static int dwc3_generic_of_to_plat(struct udevice =
*dev)
> >>   	return 0;
> >>   }
> >>  =20
> >> -#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> >> +#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GA=
DGET)
> >=20
> > Maybe just make USB_DWC3_GADGET depend on (or select?) DM_USB_GADGET ,=
=20
> > since I think the DWC3 code doesn't work without DM anyway .
>=20
> Do you mean in addition to this? I do not think that alone is something
> that will address my intention to be able to disable the gadget part of
> the dwc3-generic driver.
>=20
> Before this patch it was possible to enable disable host or gadget by
> using USB_HOST/SPL_USB_HOST and DM_USB_GADGET/SPL_DM_USB_GADGET options.
>=20
> However, Rockchip RK3328 boards have dwc2 otg and dwc3 host, trying to
> use DM_USB_GADGET for dwc2 and USB_HOST for dwc3 is currently not
> possible and result in the build errors reported, i.e. multiple
> definition of dm_usb_gadget_handle_interrupts() and undefined reference
> to dwc3_gadget_uboot_handle_interrupt().
>=20
> After this patch I can use dm dwc2 gadget and dwc3 host without issue.

Note that *DM_* symbols can be confusing. At this point, in SPL
SPL_DM_USB and SPL_DM_USB_GADGET are encouraged but not required for
host/gadget drivers. In full U-Boot, DM_USB is required for all host
drivers and really should be enabled in all cases for DM_USB_GADGET. We
can't enforce that at the Kconfig level because of, iirc, some of the
armv7 part gadget drivers (more than one). But for newer and still very
active chips, we should be using DM_USB_GADGET unconditionally in full
U-Boot.

So perhaps part of the issue is that dwc2/dwc3 need some hopefully now
legacy code removed.

--=20
Tom

--1aYqLJnCdYmYYeRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXb7ZkACgkQFHw5/5Y0
tywrGgv/WZn78MwgCPHlLH1yH4De0KOgMHltQcchmMXpU5FoBGjfJVJ9+3uySWYz
nZ9kF43XmWkcvT49IdoJoHUrvy9xK858dhQAOwPSPaQ+k+HWq2/HFzj/j/Zysk8x
fl6ghBDH+DYMGworuomcMYDHpxxbKEw6YgB4FQ6LcfN3wdekW6Iyk7Mk+1bW2IW4
NA7VAYRI1S9l58mqzaLz7AMLX8zPu08MyhsQCAM6y/qj9sK0dFDFEDojWFgyXEMy
wNYzCBvCtdZ+ZtZ1hCfNhdzOHwaxOZ1peye98tJgHubTVoRVLqnr/dR68jPFZshq
yUw7sA+z77mhLcKBSEJpSqupt+0LcTxuwy2AriXXua4vR6gpWETBHfOmvyNHnue+
tPtyQepi6szPW1HHtbZAYfpQmQM24gyg2hEyodb7sndGx2hhlWC1CxgzOW/fOaYM
eb2vt+hqIOU01e0q+wZBet8t5brFdOjwIGv54i4eZhYDhbA0BYTdUt9iD9ljJMFe
wfY2IgSE
=rzIt
-----END PGP SIGNATURE-----

--1aYqLJnCdYmYYeRe--
