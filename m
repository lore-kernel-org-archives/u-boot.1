Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55891CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51AE830B4;
	Tue,  9 Sep 2025 16:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g3wfnjeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20AB8313B; Tue,  9 Sep 2025 16:09:34 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE948309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-4079c655e50so16310195ab.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757426971; x=1758031771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PkEhHfDwkLd1/9U8PBLTfoMHtKVLBL17FR0V5QMOV44=;
 b=g3wfnjeb52uqBkGtISlryQgBO52JcdFJAHkbap9dyvNTERwOrAT4wx6XYWXnD8WhBO
 mRAgq7/c4ao2TEh/ktjgGSs6MbjhRSjKiTm6mgkU4vFm9yX2mBMsw+wvNY651sbyaJ6Q
 E/szr5IfFhKJr4BPGleLYRo1tnM0iBCIDMPSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757426971; x=1758031771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkEhHfDwkLd1/9U8PBLTfoMHtKVLBL17FR0V5QMOV44=;
 b=UbOTcfMXtiiRGBIcbhqN9YvGcAhBerKgZSM1AjrmXgCjp+JIolQhD4iKn8VISv6otq
 7GjokAzkev2Z/Su/62jVkJ68cMIBpAp47ONYyFIW6bBwpmFFCYd2EKVL2e87UKUgTjqR
 MbRuCoc/kLjSVQ8JcQjc0H1GPqWxuI07gs31hwlppKdHmt3AQ2AawvwfmPX88LtiVwg+
 JHJ2UyFh1C7nzLsiEmt7fZdOvOBeB6OLz91SboofD1ZPSMDvK2i+JQUgZDDgANaDtAsy
 I9wrg6N5zhCUpzvX8yk14a+hCKgT/U+261s5Sy5Da3q5ooTaHHObCuI2ypGVdxbhnGD8
 XDpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWhuhKhveIK+yDQkA16Jhq+c+XfcXSUNiQko8YGd6/eyYHutS6J3PW+BMEi14dGnHpxRVwihY=@lists.denx.de
X-Gm-Message-State: AOJu0YyfyPsES0Z/1gDAT5EfOGUhhPRJFk3bvEXcMr8YlZPNTgGunuvH
 8C3mmJYFNfB6/XPDJiL+YF86IGcPVlbIfXin7XIZ5bITKAMMYl4Z9QGq73UDzFycfqc=
X-Gm-Gg: ASbGncuimOWTeuaPDTb8LT4f5+M/kG01vvNNhGQYALRJRaYf3c/5YZ6vv45rBY8fkfa
 sQ3LtzhbzHt/nfeMWwdLj8F9mVuJT1K8Orz0NwFhFEoomluV7+mriNfNiTjkyYqp5ZZ+LHfM8rD
 ej5CS0QHluL/GrhKRA0W7DzanwtiL/ye3JHEN0EqWPf//aq5ZPMPATs5L3L5mgbaMB+eq9HZNxs
 krULrh4ng1AYjnwgx96J9s99WETTVp1I131UoAMpoqxjRBRIkg9fDRR3AFilr+UtRMGtdmA+XK6
 LjUaGRlP40rhLIl+I32ZLzAfNhycBv0GdSlKGH1/v6zJIQx4D39kt0hEIXyOWIrbMwkRM1yMcQM
 U30mcNu8KLYOWWlpzTHUzWPgSapm0Gci5+45gSFkuZiwug0Zm8hdOGKERxaHPwaj08BvgzA+Uum
 iqyA==
X-Google-Smtp-Source: AGHT+IGog7TL+AW9Titebj+7ugEfbhua6CfsEonm/p9fS1rFIEJVYObh8dmS7lYKAI4QsLLSdUOALg==
X-Received: by 2002:a05:6e02:1d82:b0:3f6:55e5:18fd with SMTP id
 e9e14a558f8ab-3fdfaf2e3e1mr178927385ab.3.1757426967870; 
 Tue, 09 Sep 2025 07:09:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-414edd65957sm809015ab.29.2025.09.09.07.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:09:27 -0700 (PDT)
Date: Tue, 9 Sep 2025 08:09:24 -0600
From: Tom Rini <trini@konsulko.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?Q?H_v4_1=2F2=5D_binman=3A_add_a_new_entr?= =?utf-8?Q?y?= type to
 support .bin file generation for the i.MX95 platform
Message-ID: <20250909140924.GU124814@bill-the-cat>
References: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
 <20250818-imx95-v1-1-f68a19fe30b6@oss.nxp.com>
 <CAOMZO5C=ROcrsS256shQNP4Dfz9ca_55tT1hQNHUM=kOrxnVUg@mail.gmail.com>
 <PAXPR04MB964427E6CFEFCC51D44D046AE20CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <20250908143503.GQ124814@bill-the-cat>
 <PAXPR04MB96448DB6FB2EF55C97A528E8E20FA@PAXPR04MB9644.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AqsGRY2JnErGYMZm"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB96448DB6FB2EF55C97A528E8E20FA@PAXPR04MB9644.eurprd04.prod.outlook.com>
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


--AqsGRY2JnErGYMZm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 03:26:18AM +0000, Alice Guo (OSS) wrote:
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tom Rini <trini@konsulko.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B49=E6=9C=888=E6=97=A5=
 22:35
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > =E6=8A=84=E9=80=81: Fabio Estevam <festevam@gmail.com>; Simon Glass
> > <sjg@chromium.org>; Alper Nebi Yasak <alpernebiyasak@gmail.com>; Stefano
> > Babic <sbabic@nabladev.com>; dl-uboot-imx <uboot-imx@nxp.com>; Alice
> > Guo <alice.guo@nxp.com>; Marek Vasut <marek.vasut@mailbox.org>;
> > tharvey@gateworks.com; u-boot@lists.denx.de
> > =E4=B8=BB=E9=A2=98: Re: =E5=9B=9E=E5=A4=8D: [PATCH v4 1/2] binman: add =
a new entry type to support .bin
> > file generation for the i.MX95 platform
> >=20
> > On Mon, Sep 08, 2025 at 03:40:32AM +0000, Alice Guo (OSS) wrote:
> > > > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Fabio Estevam <festevam@gmail.com>
> > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B49=E6=9C=886=E6=
=97=A5 5:53
> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > > =E6=8A=84=E9=80=81: Tom Rini <trini@konsulko.com>; Simon Glass <sjg=
@chromium.org>;
> > > > Alper Nebi Yasak <alpernebiyasak@gmail.com>; Stefano Babic
> > > > <sbabic@nabladev.com>; dl-uboot-imx <uboot-imx@nxp.com>; Alice Guo
> > > > <alice.guo@nxp.com>; Marek Vasut <marek.vasut@mailbox.org>;
> > > > tharvey@gateworks.com; u-boot@lists.denx.de
> > > > =E4=B8=BB=E9=A2=98: Re: [PATCH v4 1/2] binman: add a new entry type=
 to support .bin
> > > > file generation for the i.MX95 platform
> > > >
> > > > On Wed, Aug 27, 2025 at 4:06=E2=80=AFAM Alice Guo (OSS)
> > > > <alice.guo@oss.nxp.com>
> > > > wrote:
> > > > >
> > > > > From: Alice Guo <alice.guo@nxp.com>
> > > > >
> > > > > To support passing specific commands defined in enum imx8image_cmd
> > > > > to the imx8image_copy_image() function, this patch introduces a
> > > > > new entry type nxp-imx9image. This entry generates a plain text
> > > > > data file containing the relevant commands, enabling flexible
> > > > > configuration during image creation.
> > > > >
> > > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > >
> > > > I'm getting CI failures:
> > > >
> > > > +/binman/m33-oei-ddrfw/oei-m33-ddr (oei-m33-ddr.bin):
> > > > +/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-imem
> > > > (lpddr5_imem_v202409.bin):
> > > > +/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-dmem
> > > > (lpddr5_dmem_v202409.bin):
> > > > +/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-imem-qb
> > > > (lpddr5_imem_qb_v202409.bin):
> > > > +/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-dmem-qb
> > > > (lpddr5_dmem_qb_v202409.bin):
> > > > +Image 'm33-oei-ddrfw' has faked external blobs and is non-function=
al:
> > > > oei-m33-ddr.bin lpddr5_imem_v202409.bin lpddr5_dmem_v202409.bin
> > > > lpddr5_imem_qb_v202409.bin lpddr5_dmem_qb_v202409.bin
> > > > +binman: Error 1 running 'mkimage -d ./imx9image.imx-boot.spl -n
> > > > ./spl/u-boot-spl.cfgout -T imx8image ./imx9image-out.imx-boot.spl':
> > > > Fail open first container file mx95b0-ahab-container.img
> > > > +make[1]: *** [Makefile:1339: .binman_stamp] Error 1
> > > > +make: *** [Makefile:198: sub-make] Error 2
> > > > +binman: Error 1 running 'mkimage -d ./imx9image.imx-boot.spl -n
> > > > ./spl/u-boot-spl.cfgout -T imx8image ./imx9image-out.imx-boot.spl':
> > > > Fail open first container file mx95a0-ahab-container.img
> > > >
> > > > https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1238965
> > > >
> > > > To reinforce what I asked you before: for v5, please make sure that
> > > > you send me a link showing that CI has passed.
> > >
> > > Hi Fabio,
> > >
> > > Thank you for your message. I am currently using Azure Pipelines (free
> > version), but recently the world_build stage has failed to run properly=
=2E I will try
> > alternative way to run the CI pipeline to ensure everything is properly=
 checked
> > before posting.
> >=20
> > What problems do you see with the world build pipeline? I don't wait fo=
r it to
> > complete every time I push (due to how long it takes) but it should nev=
er be
> > broken.
>=20
> Hi Tom,
>=20
> The message appears in the logs: =E2=80=9CThis can happen when the job is=
 cancelled or times out.=E2=80=9D I am using a free Azure DevOps account wi=
th a private project and private repository. The maximum allowed runtime on=
 Microsoft-hosted agents is 60 minutes. This limitation seems to be the cau=
se of the issue.

Ah. This is also configurable, and you need to bump it to whatever the
maximum is, which might be 4 hours. Updating the documentation to
explain this after you do it would be good.

> I would like to inquire if there are any alternative solutions available=
=E2=80=94preferably free=E2=80=94that could run a U-Boot CI pipeline.

We can add contributor repositories on source.denx.de, but we're also a
bit short on fast runners sometimes, can NXP help out with that perhaps?
Thanks!

--=20
Tom

--AqsGRY2JnErGYMZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMA1EQAKCRAr4qD1Cr/k
CrR3AQCG3dEPL0pp8BK84sENbnrlwfbbMTIZcV4mrk5ShUhQcAEAt3joOZUxzFJg
nqzRXpEz164U0dgFGjBGW3fqm3FmUQk=
=itPJ
-----END PGP SIGNATURE-----

--AqsGRY2JnErGYMZm--
