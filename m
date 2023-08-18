Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D810FEE498D
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 18:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E2786EEA;
	Fri, 18 Aug 2023 20:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OdlpGhiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7227086EEA; Fri, 18 Aug 2023 20:48:47 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1AE86F67
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 20:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-58fae4a5285so325167b3.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692384523; x=1692989323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CcPKZECuNQG6fIGXQawe7BsS6DjZNuBAJ+L2ts77NaA=;
 b=OdlpGhivp+OtVL7bQbNAZZDPvBIQTJ6PGW5S+U+KQzLK0SK6dHvI6UsEi8n6V+j1Wc
 VdvIBHlkB+jjQrztRGsMgFbDWTc4aXO6bjsAe03t42rog1rtfXIfTyUMWXKNZoodpQ9B
 Jsc10UUtZZbeelrZTm8uMiZ14xS67mJ+Mx26Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692384523; x=1692989323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcPKZECuNQG6fIGXQawe7BsS6DjZNuBAJ+L2ts77NaA=;
 b=TaQFnf+xmTmLMHh6R/Tmi4cEbmHF7SD+EimllJlmTVYKSgecXWdGGCk+M8TJbaoGmU
 aDrNkfKJOnlVNNS9hiqVRNdEpDnSJ73A4GskV/nxIKpfnxv2q+6UONolM3WFjkLY+Tj2
 0fcp547XPisBY5E1CDrHpcMYWXqjyHIkP3TFCAhV4Lfi/XlghTi3nPTR9PGSJqgowKtI
 df3THFYn4j+azlnKTA/UeKlkoILBuZlyem+rDyh7OXCdMIZTsFSpCqPCq5+HnN6IW5VF
 bKCm5wivZgO4Ntm3pPcDmYYvl00JTCdUNCxMxZwXQmRmcWQF5HA8aeW5WAFH5HX/bX8g
 XWvw==
X-Gm-Message-State: AOJu0YwQXejbx+95qBhDaxmH0ZqN8YeBrKO50/X8gde3awWNAOMxKFHL
 mXvIXUSnW7P/sbGT0kNeO8J6HGFostNvUDRpREW1Xg==
X-Google-Smtp-Source: AGHT+IEZODKRB3Vt6eXGx232VMWo41pUOYUSKLNESQ5MI7wOpXJugRWnK1VyINgwMjE5r4wphqv3/w==
X-Received: by 2002:a81:c208:0:b0:55a:574f:327c with SMTP id
 z8-20020a81c208000000b0055a574f327cmr40904ywc.13.1692384523460; 
 Fri, 18 Aug 2023 11:48:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 g129-20020a0df687000000b00577374e8abasm659180ywf.87.2023.08.18.11.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 11:48:43 -0700 (PDT)
Date: Fri, 18 Aug 2023 14:48:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Julien Panis <jpanis@baylibre.com>, u-boot@lists.denx.de, marex@denx.de,
 tony@atomide.com, r-gunasekaran@ti.com, vigneshr@ti.com, nm@ti.com
Subject: Re: [PATCH v3 09/12] usb: cdns3: Handle otg mode as peripheral
Message-ID: <20230818184841.GO1515023@bill-the-cat>
References: <20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com>
 <20230706-handle-otg-as-periph-v3-9-27e24fa17345@baylibre.com>
 <20230814171755.GB3630934@bill-the-cat>
 <d1c121d2-35b7-5097-4a02-308541c50d29@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k4ol9gQX6NbVz7Rn"
Content-Disposition: inline
In-Reply-To: <d1c121d2-35b7-5097-4a02-308541c50d29@kernel.org>
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


--k4ol9gQX6NbVz7Rn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 11:15:17AM +0300, Roger Quadros wrote:
> Hi Tom,
>=20
> On 14/08/2023 20:17, Tom Rini wrote:
> > On Thu, Jul 13, 2023 at 03:45:42PM +0200, Julien Panis wrote:
> >=20
> >> Override 'otg' to 'peripheral' mode, since 'otg' mode
> >> is not yet supported by u-boot.
> >>
> >> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> >> Suggested-by: Roger Quadros <rogerq@kernel.org>
> >> ---
> >>  drivers/usb/cdns3/core.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> >> index 644a9791b9c9..bd763fc593e1 100644
> >> --- a/drivers/usb/cdns3/core.c
> >> +++ b/drivers/usb/cdns3/core.c
> >> @@ -149,6 +149,10 @@ static int cdns3_core_init_role(struct cdns3 *cdn=
s)
> >> =20
> >>  	dr_mode =3D best_dr_mode;
> >> =20
> >> +	/* u-boot doesn't yet support OTG so limit to PERIPHERAL */
> >> +	if (dr_mode =3D=3D USB_DR_MODE_OTG)
> >> +		dr_mode =3D USB_DR_MODE_PERIPHERAL;
> >> +
> >>  #if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
> >>  	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOS=
T) {
> >>  		ret =3D cdns3_host_init(cdns);
> >=20
> > Julien, why don't we support otg mode here?
> >=20
>=20
> dr_mode will never be OTG at this point as the previous if condition
> would have forced it to PERIPHERAL.
>=20
> My understanding was that u-boot USB framework doesn't support OTG mode
> so we force it to PERIPHERAL.

Well, the first part of this series is "make unknown state be OTG" for
DWC3, so we do in general (and Marek told me off-list he's used it on
DWC2 as well), so it sounds like these (CDNS3, MUSB) drivers need fixing
/ updating.

--=20
Tom

--k4ol9gQX6NbVz7Rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfvQkACgkQFHw5/5Y0
tyzWqQv/dJbbNDTd9sWmnKEuCdq5zrRL2obTynET4ybUWC6F0h1BNAfXe5iqg+Ik
MQ8U8bS9dj7IDqDKgivb/1j8UCKmhpKm2kNvP8492ayRJaHk4tfjePjW5VcgJrv9
1iHSbtz2duGv2KK9x33AeCcPsmM5hlH7FtWsbkcp0F1OxGERZI7fsPDo5M0qf6DR
VlqQx+LeYFSfIHcQNUN+uwIs2/1nwKbPUkj9840lBStmeNKLNOqAuS9E+kKg+9qN
/UVmEFWFTA5f8xDxzUqnmOrXlAYlMlyAEoqY5F/w/YZF+XbbDLuhBUoi+COKaU5O
zEPRrfW9JL8oNZ3cnjWFcl56w7LTSk4INgnNl8U/MXr1qrrqr/kAsvRW7CLiljyP
00LOCvhfMtOg1RvfE8Ot5hsy87OuKHkceZec3ejhbpX6T1h0k6VMIJq9VkpJZnFM
FFwdNFAiXONrxpNzW95zPw8+RStt4GExUGiBYnXStL0mcQdv0J4lC8+L5zbZT8Et
+mANDAe3
=qOpN
-----END PGP SIGNATURE-----

--k4ol9gQX6NbVz7Rn--
