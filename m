Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64A1C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 14:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C998839F;
	Thu,  2 May 2024 16:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MCl1gDHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7928838E; Thu,  2 May 2024 16:51:33 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EE96883BA
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 16:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-437a660c94fso49964301cf.1
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714661488; x=1715266288; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wGQMi7jE0YvzucN/vY7Edusv5y4r3SPIyceXRPlHzy8=;
 b=MCl1gDHs4FsPl1IBzyHf+fUotJrvtmHc+Aa9o7o801DDfO0LNPSbyLVqUsJ2a0ZS01
 YBbAQvcKxGfuIFYL9LfXEDMf5En0BKp3HRJIrexkw3F+JWo7XQ1bs0h/2+4W7nzUFwQx
 NzmISFbZPe378LasYBewb3n+xYYHbwRX1JHI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714661488; x=1715266288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGQMi7jE0YvzucN/vY7Edusv5y4r3SPIyceXRPlHzy8=;
 b=fR9qW1Vq8gSlhyE9GOC0TbPXySJlyfYKb3BmgrfWxuAPe2cRuIpG0/+nMSW9sijDL0
 boqmF9ntuGXKpMNgv21kNIO7+HrJLpvwTO4gAFYOwVdOxUDJrnrwY+kH8fQ/fKyoD9Hs
 nU8KriVJh069jbRUojINwEVlRfk6p5LQU4yD0G15Lgmp07Vd27GHK40zMr6+fhGVT0M4
 M+3j4pejM+4iGxUW8V2RuwHBsRMDtZPaH/vpqtrDOOlTtYsdBLa8Fttl7HJxSbLylO7e
 IqniDhiWuGKJgtN7ESTKxx18Vs3lKfuJ1VVI8P9GRLhwAGlnwBLr5wk9uMneiE2MesWN
 FyKA==
X-Gm-Message-State: AOJu0YwgoRPDtz8jrcyeSVJxAoRY3y08b3lX6kZAoaODHyDyJ6M4A9Sa
 V/rsY5eTsLx50Z31kROyl+/jPBw/YHo642+PWkfUMALkjI/ov8H5tAtlMirFz0g40vjiiMbCC4Y
 tK1UswJjg
X-Google-Smtp-Source: AGHT+IFKE5Utm49AGZ0WahxcvfTQuJcLuU8K24AamH478PNSJ4zeYcGhzkKCTYf9Zdqu3HfsYKydJA==
X-Received: by 2002:a05:622a:11c9:b0:43a:d84e:442b with SMTP id
 n9-20020a05622a11c900b0043ad84e442bmr2737703qtk.5.1714661488110; 
 Thu, 02 May 2024 07:51:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 ec21-20020a05622a5b9500b00436e5e47969sm540707qtb.54.2024.05.02.07.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 07:51:27 -0700 (PDT)
Date: Thu, 2 May 2024 08:51:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 Linus Walleij <linus.walleij@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Nishanth Menon <nm@ti.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Roger Quadros <rogerq@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sean Anderson <seanga2@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Tim Harvey <tharvey@gateworks.com>, Mathieu Othacehe <othacehe@gnu.org>,
 Fabio Estevam <festevam@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 73/81] usb: Remove <common.h> and add needed includes
Message-ID: <20240502145121.GW1054907@bill-the-cat>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-73-trini@konsulko.com>
 <87o79o4q63.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="On/n5sT3j9kS5TIn"
Content-Disposition: inline
In-Reply-To: <87o79o4q63.fsf@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 02 May 2024 16:52:03 +0200
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


--On/n5sT3j9kS5TIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 09:40:52AM +0200, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> Thank you for the patch
>=20
> On mer., mai 01, 2024 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>=20
> > Remove <common.h> from this driver directory and when needed
> > add missing include files directly.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> [...]
>=20
> > diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> > index fedcf7869295..38c5928faed5 100644
> > --- a/drivers/usb/host/xhci-rcar.c
> > +++ b/drivers/usb/host/xhci-rcar.c
> > @@ -5,7 +5,6 @@
> >   * Renesas RCar USB HOST xHCI Controller
> >   */
> > =20
> > -#include <common.h>
> >  #include <clk.h>
> >  #include <dm.h>
> >  #include <fdtdec.h>
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> > index 910c5f3352b8..1360a5940fa0 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -13,7 +13,6 @@
> >   *	    Vikas Sajjan <vikas.sajjan@samsung.com>
> >   */
> > =20
> > -#include <common.h>
>=20
> This generates the following build warning with
> khadas-vim3_android_defconfig:
>=20
> drivers/usb/host/xhci-ring.c: In function 'xhci_wait_for_event':
> drivers/usb/host/xhci-ring.c:464:28: warning: implicit declaration of fun=
ction 'get_timer'; did you mean 'get_mem'? [-Wimplicit-function-declaration]
>   464 |         unsigned long ts =3D get_timer(0);
>       |                            ^~~~~~~~~
>       |                            get_mem
>=20
> Adding: "#include <time.h>" fixes the warning.
>=20
> With the above fix included:
>=20
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Did you have the full series applied? I don't see the warning here (nor
in CI) and I suspect that:
https://patchwork.ozlabs.org/project/uboot/patch/20240502013138.2383421-9-t=
rini@konsulko.com/
is what resolves this warning.

--=20
Tom

--On/n5sT3j9kS5TIn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYzqGkACgkQFHw5/5Y0
tywsYwv/dLD+OFFzUcv7xPQktGEKgWkTK1bD1NiTL3d5pHX5JmPyj3rUg0xHMvNH
8U/8dGn5daxhKCc6c7HAvZj+mrTxazgbYsZqxjbaCeVFy6wF2mS7533+zkntXjyg
9npkKGZBcgeXhj019PUEhlZMfNFWOjQi3Cr4uyL6+B0IG1WORln8B5F2gVk0pfjB
SB4j9VgE2gDZ2wghc0MGDhOhoWGUxgNw+i6LWsfH1HdhULqmARKFxiV7Kb6kDML5
ljuh89p/D1d56xSTneEZHPvET+7US/X2cjknFyUygmvQHFWeEj39BrYSnod5IJUM
W66wrXUHIFTJ2AzcffAzejj3zVh5we8Ut/u13wKv1zGN6Ga/X8MiSeCBabTEMxBa
6RL7DbBwD2Z8FXHlNEEzNcq/uUds6Z8RriBzjB2Du93tRVWyjULyKVVLoiAKkZvC
WmEAvXlSRvH+tIhf29gSY4Xt7TaGAwj/MKtore10YLh+LS233FFDxow6OQPYXz/I
EcNsfGGE
=6LE8
-----END PGP SIGNATURE-----

--On/n5sT3j9kS5TIn--
