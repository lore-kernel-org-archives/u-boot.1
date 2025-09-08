Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44F1CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 14:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426A0809A5;
	Mon,  8 Sep 2025 16:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHDDWEpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7DB82AE9; Mon,  8 Sep 2025 16:35:13 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9926B80077
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 16:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30cceb749d7so2031933fac.2
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757342108; x=1757946908; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VlqNad0UperfnHepWzo+ZApDPgjO+hYCk7RGa0opfNQ=;
 b=XHDDWEpEwAjUuQOT/A4y8ITx0Gp7ekWR0tRqOLCGKRyJcwn4ieUSiJl8aF3vWI1w4I
 j1W+X8p4w8dYMuHkgsr+tCpHChhqp6Q0gowdirPD46G+9M8ULIto/paYbw8lJs1Df/5V
 2f5FqGFd6PE0USQ8eoSDwTIo34vT9XKMNHhKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757342108; x=1757946908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlqNad0UperfnHepWzo+ZApDPgjO+hYCk7RGa0opfNQ=;
 b=c2C0yyKaaLEQF6Sfo39xWas4t7PPAvw2rU9q9FgHdnHMPjfwQSpb0kVe3tf/uGX25A
 6/Ily0Es6jUpCV8cpR5YGv6xUOkBmgUFZR7jtonNMzCZ9msfHcfAqjJHm6grwohq93Dk
 Yh3IbvfiYjVSLUQJtQtkYUI6EOJM+NlZeTQYzf2Ye8jf6blffpPVbqaSwY/5tQ8RKIBx
 6RoILyiCbw4GsNDgUT2neJB8juwIAuY4v9Ak+dg8CQn4tLXNpTL4jdwa8P+Fbv6QLt4h
 l0dxT/5hmW9HqFfMa8aw5DFxye7o7ucJNsddmT27IHJ6HH17DSwf+BKqIEy8fJfJcVRu
 O4Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeDc2SxzqRPQlWzIyxObMMas4AWM27exl6QjFLkbxFmYPnaiOg+yMDd3imYiUJYL/vt1nRrRo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzws2u4lYk9gHgSNWKgQGxFU6Xp4laEuRfyjDSICN+pRtIQheub
 yEdXV2zyOlqr+e9LhYtGm4nobUCvKDpM7gxBKUDWh9ZGAuv7McCdfWM8NCPpr5CoWlE=
X-Gm-Gg: ASbGncuWSUgddziectTf/XItXsy+SUrmspAMzgZZpmNtnj07ANb1LTYrPF2mjud08az
 ZbDlBBfolGVVdouFr/9kekqUPyhRqCc5S/N2p0K5knSVcMQxa6lqbvY9Fst13apZmDae+cyFGmd
 Ti8NU9t4jxq49momvWrUMEnB6eVwfDvizkzKG+IesX1+xgYh5lEg5HtWgw8HbYzNPQestW4QV25
 3cYvjL4K4W4a8xvyzTKd2G6wWtaO0LONtdeOInWmB4eilPo7in7mC8cMTrhaho/oWFUgWP699P9
 I0czLYMH/OtdO1lYBpltqUVGB30bwf/WMsWSR8YXxYALQ8wvGIrzGSm8byuuJRtG+oSfi0gaaBm
 scKBs9KfGTg80cGhHE7izjX2mlZqhrVLBfaf+oJ5FyRbz0djfkdcNM9+T
X-Google-Smtp-Source: AGHT+IFtk4SyaufqeLPJ/hEgB7oHbqr7yrdRIOt1Lkg24pzeojsUeTeOEKXrm1Rec4t6craGvH1cEA==
X-Received: by 2002:a05:6870:d0c7:b0:31a:e9e8:3018 with SMTP id
 586e51a60fabf-3226274aa69mr3247186fac.5.1757342107846; 
 Mon, 08 Sep 2025 07:35:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-319c704f44csm6070306fac.2.2025.09.08.07.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 07:35:06 -0700 (PDT)
Date: Mon, 8 Sep 2025 08:35:03 -0600
From: Tom Rini <trini@konsulko.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjQgMS8y?=
 =?utf-8?Q?=5D_binman=3A_add_a_new_entr?= =?utf-8?Q?y?= type to support .bin
 file generation for the i.MX95 platform
Message-ID: <20250908143503.GQ124814@bill-the-cat>
References: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
 <20250818-imx95-v1-1-f68a19fe30b6@oss.nxp.com>
 <CAOMZO5C=ROcrsS256shQNP4Dfz9ca_55tT1hQNHUM=kOrxnVUg@mail.gmail.com>
 <PAXPR04MB964427E6CFEFCC51D44D046AE20CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GFPv0Hud9i7MKXol"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB964427E6CFEFCC51D44D046AE20CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
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


--GFPv0Hud9i7MKXol
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 03:40:32AM +0000, Alice Guo (OSS) wrote:
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Fabio Estevam <festevam@gmail.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B49=E6=9C=886=E6=97=A5=
 5:53
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > =E6=8A=84=E9=80=81: Tom Rini <trini@konsulko.com>; Simon Glass <sjg@chr=
omium.org>; Alper
> > Nebi Yasak <alpernebiyasak@gmail.com>; Stefano Babic
> > <sbabic@nabladev.com>; dl-uboot-imx <uboot-imx@nxp.com>; Alice Guo
> > <alice.guo@nxp.com>; Marek Vasut <marek.vasut@mailbox.org>;
> > tharvey@gateworks.com; u-boot@lists.denx.de
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v4 1/2] binman: add a new entry type to =
support .bin file
> > generation for the i.MX95 platform
> >=20
> > On Wed, Aug 27, 2025 at 4:06=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.=
nxp.com>
> > wrote:
> > >
> > > From: Alice Guo <alice.guo@nxp.com>
> > >
> > > To support passing specific commands defined in enum imx8image_cmd to
> > > the imx8image_copy_image() function, this patch introduces a new entry
> > > type nxp-imx9image. This entry generates a plain text data file
> > > containing the relevant commands, enabling flexible configuration
> > > during image creation.
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> >=20
> > I'm getting CI failures:
> >=20
> > +/binman/m33-oei-ddrfw/oei-m33-ddr (oei-m33-ddr.bin):
> > +/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-imem
> > (lpddr5_imem_v202409.bin):
> > +/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-dmem
> > (lpddr5_dmem_v202409.bin):
> > +/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-imem-qb
> > (lpddr5_imem_qb_v202409.bin):
> > +/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-dmem-qb
> > (lpddr5_dmem_qb_v202409.bin):
> > +Image 'm33-oei-ddrfw' has faked external blobs and is non-functional:
> > oei-m33-ddr.bin lpddr5_imem_v202409.bin lpddr5_dmem_v202409.bin
> > lpddr5_imem_qb_v202409.bin lpddr5_dmem_qb_v202409.bin
> > +binman: Error 1 running 'mkimage -d ./imx9image.imx-boot.spl -n
> > ./spl/u-boot-spl.cfgout -T imx8image ./imx9image-out.imx-boot.spl':
> > Fail open first container file mx95b0-ahab-container.img
> > +make[1]: *** [Makefile:1339: .binman_stamp] Error 1
> > +make: *** [Makefile:198: sub-make] Error 2
> > +binman: Error 1 running 'mkimage -d ./imx9image.imx-boot.spl -n
> > ./spl/u-boot-spl.cfgout -T imx8image ./imx9image-out.imx-boot.spl':
> > Fail open first container file mx95a0-ahab-container.img
> >=20
> > https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1238965
> >=20
> > To reinforce what I asked you before: for v5, please make sure that you=
 send me
> > a link showing that CI has passed.
>=20
> Hi Fabio,
>=20
> Thank you for your message. I am currently using Azure Pipelines (free ve=
rsion), but recently the world_build stage has failed to run properly. I wi=
ll try alternative way to run the CI pipeline to ensure everything is prope=
rly checked before posting.

What problems do you see with the world build pipeline? I don't wait for
it to complete every time I push (due to how long it takes) but it
should never be broken.

--=20
Tom

--GFPv0Hud9i7MKXol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaL7pgQAKCRAr4qD1Cr/k
Csi0AP9XVCie4DZF4i5Lsk/WnnsRi5qjnEuBARJuvlNCVsy/nAD6AvD8rquta0cC
WO5rfcKm2NO7NZictzECBeuuJggb5g8=
=UiXH
-----END PGP SIGNATURE-----

--GFPv0Hud9i7MKXol--
