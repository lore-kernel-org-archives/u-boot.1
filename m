Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C716C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB6281879;
	Thu, 27 Mar 2025 15:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W9BeTdDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB34781B42; Thu, 27 Mar 2025 15:14:50 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3DF081273
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3f9832f798aso595300b6e.2
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743084886; x=1743689686; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cpMQMCDTXB3IrXYmWm2v5ubLPsZ1HB4rg6XSAy66u6A=;
 b=W9BeTdDnc74HvRlzw4hxs/GUScDxzXBjfik7kUJzOuqnbaFUkr+Rvne8sXCkIuSLqG
 g4L1uxGI9QPCu7iewoleBWzUf3BxpWws27z7zgo6bESqiV/+p6Tjp2OIYclXhXQuyIVz
 m1HGAJKUUu0xV7FngZFINWebZMQ2F+VVGF1kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743084886; x=1743689686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpMQMCDTXB3IrXYmWm2v5ubLPsZ1HB4rg6XSAy66u6A=;
 b=A+4wzDzoWuYqABD+eGeH2LdH/vXt99coM2t1X/XcpRpADzX/SlhSiUinxSCWhs0J1p
 9Cw9hVBuNiIK5Teumpr400BW0e4mX0vbrOXswIhNlROSD4hI4bA+N74xT6S75Fw/4Z3f
 XhyOgPCtdJ05n+GSEbi9OkecpPovOZda7IpzH3ZZ9THY+GDQYp/UIxE+IMbm4msRGHVg
 iWb7LwSqMzbz4Irlfd/nqpwdYGr7pXjYAcMsdm6oKnRXHlo4ngMMEHSomcB318Q8u73p
 e74K8v0SwNqsbzKYgk9b43qSp7GDbdjlPtNwGDyVNK9omqMXYhs7I6GCoxg7gUEdaoqD
 lSIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWohuwomCQd7oo2i5Cnp577qUXqrASVS28SvF5B6NbRD/7/ko/E2V9RxRUi0qNbjnOqDOYQK5I=@lists.denx.de
X-Gm-Message-State: AOJu0Yyjc1UMRl+PiqP1ZLt1yZ1zIl46OsFi6Ns28J+Bbm6K6Jt6GxWw
 6mP+UUqJr5PB7GeRlBsJMJ0KpbEqUxptjQQ3b+W6Q3vtRxRoBvjiuhlES7EyfGo=
X-Gm-Gg: ASbGnctwppjKnX2ILKev6E/j2CtdxAQtVAYNw4cy08T1gCCzZI/PYzWmCiqaEbnjFnh
 itQtZqb8V4nGcJhO3/ijzBtWfcbKjEJ25qLLbtJB86WKHSyZlqFgpRxbBmwBVqCVA4SXvNPMbVc
 8baInWPj05vMYUJ/5nuK3cGMKpyvKUtNJcKkK3uhTTP5bbTVWVXeUX5L1uE9vhMoKQl05YQzZ8K
 YMVafU3EX+BrtoG2D81SeWQ1kyR5B0ikL3vDlxA++UCtJthmZoPnML1oH2IYvyoIYMK5Rqc7zU/
 C1DdGwD/fwFxTCqvIo1eW3Y+EeP9vaTEUNQnyBl9J20QU8i8mIPiYDhujSQSN/6hxGAiirjF/O6
 ppKoq2Q==
X-Google-Smtp-Source: AGHT+IFKhYBExtZ1lkiEXxoyS3NpzIg4RqJFXIFPDXMLMrwQ0XsVVhY9dGfAcF9wzaX7AAJ7k9HAFA==
X-Received: by 2002:a05:6808:1b89:b0:3f6:76f6:b5ca with SMTP id
 5614622812f47-3fefa53f512mr2601747b6e.18.1743084886478; 
 Thu, 27 Mar 2025 07:14:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3febf6bd788sm2798540b6e.4.2025.03.27.07.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:14:45 -0700 (PDT)
Date: Thu, 27 Mar 2025 08:14:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
Message-ID: <20250327141442.GO93000@bill-the-cat>
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAPVz0n01g9JghOb1JCPg1sCwOf-w0AcjMZRngGZbAK_C_VhGcA@mail.gmail.com>
 <CAOMZO5BMZi3adJCcxVq3-04YY8yAAVqkdcy8Q1tMzMsK+W0rEA@mail.gmail.com>
 <87pli3q1j9.fsf@bootlin.com>
 <CAOMZO5DnfOSGg0wCZpoqw9EsyLWL-ezDshGZT1s8WuBu-K_CrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I6g65dlD8/1lPAdz"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DnfOSGg0wCZpoqw9EsyLWL-ezDshGZT1s8WuBu-K_CrQ@mail.gmail.com>
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


--I6g65dlD8/1lPAdz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 10:31:18AM -0300, Fabio Estevam wrote:
> Hi Miquel,
>=20
> On Wed, Mar 26, 2025 at 12:01=E2=80=AFPM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>=20
> > I rebased this work on the latest next, fixed the conflicts, adapted my
> > changes to use Svyatoslav's work, fixed the CI.
>=20
> v5 still fails in CI:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25364

And the exact failure is:
https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1078073#L259

Which looks like a series conflict or test needing to be updated, rather
than a "what the heck???" kind of failure like before.

> > Then I pushed a PR to trigger azure tests and figured out you applied m=
ore
> > patches (imx8 clock related) which conflicted. So I rebased again and
> > fixed the conflicts.
> >
> > Azure testing is failing though. I just pushed an empty branch with just
> > today's 'next' and it is already failing, my series does not produce
> > additional warnings as far as I can see.
> >
> > So I am sending a series that has been tested locally. dm unit tests
> > pass, v5 is on its way.
>=20
> If I remove your series, I don't see any test failure:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25365
>=20
> I don't know about the Azure failure. Please work with the team and
> make sure v6 passes in CI.

I see that the Azure failure is:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10824&view=3Dr=
esults
which was the unfortunate "next is broken because master has a fix and
next has a test that needed updating now" that happened this week with
-rc5 being merged. Sorry about that, it's fixed now.

--=20
Tom

--I6g65dlD8/1lPAdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmflXUsACgkQFHw5/5Y0
tywjLgv9Ff9oeSrUUpf1oeWoDZr2qc5y1TaUD5AcoxAlSFLUXf1pHxK7YVOg5knD
7fsyybvuGAao+7tc8UhVGGRk/1cQSCCkl2PqISXEcnn+X7YRFZWfm89SA69TYssL
i8s6jCC8QKLrSO6f32PL3TbTF7E1fq0eWC+9741V8Yxhwb6wvm+i53DgC9RvnA3y
+/2LUu+SP3ZqUssRu9tl54CZPU/5k6Jp1PTzxR2xA0zyqUf0TWJu1ElN9E6czZFw
4rLhkTFJV3OpUzYbgcYIdTizEnBe1VG1Hz68ZWb6+/ms3Hcm+iks+q43zT1fAtfQ
0mVB9Dl4b0JU7DgVzcl/6VwQbBAA49m28DItEbMZJ2pcTXwm2PJj1K/xD0Nyb11U
PIvtVW584rnsYtmIq9LwRw70F1ixfR8GvHGIc+0xNgDo+QWbvwpTYfuGTX7jZuh9
CdfhVo6WANdWrnZnxhhGu9KuZFscaHjQwzic3Ado22Uk+ynrnPQrnpBPTuxwjUWn
pUr/4daS
=2XGX
-----END PGP SIGNATURE-----

--I6g65dlD8/1lPAdz--
