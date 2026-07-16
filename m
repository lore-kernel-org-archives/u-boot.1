Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AA6C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 20:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578D584D8A;
	Thu, 16 Jul 2026 22:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b7XJiRid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF45B84D8E; Thu, 16 Jul 2026 22:26:45 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B5284D32
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-45133d2974fso4112426fac.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784233602; x=1784838402; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mYofJPUXUDTPwAyiBu02qhIumicNvKS7dLlWMJLJ8Xo=;
 b=b7XJiRidX16w25RQOL3qt0jvYKVojulIhdBkwAz6+qAeU2YNPo0XPJh/ULf3VgCus6
 GPAyB/bZHDkYwGx/kVL1OOuV+dpRiKkC5fNiZEuFusVBWULzJxeyO+Q4+CQLVvYDI2ph
 JxbwLyQvUW+dl06h7HxAFm7FvuWS2EB2mG8eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784233602; x=1784838402;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mYofJPUXUDTPwAyiBu02qhIumicNvKS7dLlWMJLJ8Xo=;
 b=SpCJBYMvc6h64qaz5cEx6qp7ph1FPWRfZsxopAEEYj8moIkb06IaSNmhbBZr5Kqklu
 cHUa8hlH0G3n7wCpChJv70F0qt7gYKd/UA1GgJNTlkNQn1AUr1/FKfg7oTF5ktcviyxl
 8LO/euJK+hjvei/A84N6e7+0cEbglYlVKy8Mc5xEY61R5uSPeLE8lFWoZT90mxhE76Dx
 7XAubPIRIuSKzRPHJmw5Nr3NObyeReh6PTcCn6S5cC4EUYtJz/kOhsxSQosX31+P5N7d
 pzyhLQLwA8zQiVf6FI+RgNZ2Ptv2eAdWLzFuwWWV42I7z2TkJ9rfBN7xByQvXJE7HNwK
 NxYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVjffxpsB05178MsYVxVImhmgfs5TZLTU8w6BUGsj8w6kxsmXAxBpjv4iaD32IgvnLOeHAGTI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywr0VvuxUm3+bNC54jI1epqnodFhp2qVtWyEoUazjTHKoeAflXi
 fXt059SUYXt3tfqI9skTi/cOhQB84a4PFs5uPZhgp1tH7MqJsciyxKBxPf4ew5zBqC8=
X-Gm-Gg: AfdE7cnqzjLGCrMN71omQeIj/w7iV2B3rRmL+ZELP40sYgb62+DAEd+/ubOrlBO/JOO
 MqKaHxH4TWK4xY7hT7RFI+IKRdd4Imn/Q3JaBvuEHvorK9ELsK4xH/+reEjrugaoRTRZflxHpUg
 E20SPTfSGzzHZM06IhHlA8wnS+g128wp5UI+MYRqrfKZ2cl/AfCq1ene1No6C3AiUB6Lme/Yr3v
 pr2WQW3agtaA+/SArxFc+F+53KClPfcJrVWQ746xAclxjQfNebMk9R0uVZEmnPdml/2x/IByxxd
 k0f0k5MJuxHuMNkz35/jYtzqh3OMF2CSmXoSOLQyhLpw/yyzcvIo4bwftau/3YeW5wv5LjKeLjF
 OukYTm+m3BoumLLZJoSwzBTg7PzgzBMDBwNHUmI6TWApetm5puFD6+De9M6d7Mfi6cGxXhTfajB
 0ffQsRlNeLsfsnxrt+1H35qew76Qx+YlrlvdH7fjypvURSoF95Js9f+2cbip54D4MVF85t3/PP9
 pDk2jIJh0YbGM5cyOBEyEm1Sa8=
X-Received: by 2002:a05:6870:7189:b0:434:56c8:5c76 with SMTP id
 586e51a60fabf-4560b3f8959mr7113305fac.9.1784233601825; 
 Thu, 16 Jul 2026 13:26:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451a0ceccf1sm22183172fac.6.2026.07.16.13.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:26:40 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:26:38 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bohdan Chubuk <chbgdn@gmail.com>
Subject: Re: [PATCH] mmc: sunxi: support DM MMC in SPL
Message-ID: <20260716202638.GQ749385@bill-the-cat>
References: <20260626205153.2744981-1-james.hilliard1@gmail.com>
 <20260628171716.4a9d7793@ryzen.lan>
 <CADvTj4opB+XMbupiBZtmZnuvDUtyDFkjWR5E1u2QMTXzjMqzrA@mail.gmail.com>
 <20260716200318.GA3179201@bill-the-cat>
 <CADvTj4q5=qRuCz4=rii-a_2sSRMO6inCoUVO_3UmmZkGdjSg5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j1qBihkLziGFJEu8"
Content-Disposition: inline
In-Reply-To: <CADvTj4q5=qRuCz4=rii-a_2sSRMO6inCoUVO_3UmmZkGdjSg5g@mail.gmail.com>
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


--j1qBihkLziGFJEu8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 02:16:36PM -0600, James Hilliard wrote:
> On Thu, Jul 16, 2026 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sun, Jun 28, 2026 at 03:27:48PM -0600, James Hilliard wrote:
> > > On Sun, Jun 28, 2026 at 10:16=E2=80=AFAM Andre Przywara <andre.przywa=
ra@arm.com> wrote:
> > > >
> > > > On Fri, 26 Jun 2026 14:51:50 -0600
> > > > James Hilliard <james.hilliard1@gmail.com> wrote:
> > > >
> > > > Hi James,
> > > >
> > > > > sunxi SPL normally uses the legacy MMC interface while U-Boot
> > > > > proper uses the DM driver. Boards which enable SPL_DM_MMC need
> > > >
> > > > I think I mentioned this before: enabling the device model in the S=
PL
> > > > (or not) is not a *device* decision, but a platform one.
> > >
> > > I'm a bit confused here, uboot's configuration system from what I can=
 tell
> > > is designed to allow enabling device model for specific devices and e=
ven
> > > for specific drivers.
> >
> > Right. And to be clear, in your tree you're working to upstream out of,
> > only the h616 platforms end up enabling SPL_DM and not all of the
> > existing ARCH_SUNXI, yes?
>=20
> Well my uboot config is managed out of tree by buildroot technically. I'v=
e only
> tested on h616 myself. AFAIU SPL_DM for sunxi is not disabled by kconfig
> on sunxi platform as-is, it's just a bit broken at runtime I think.
>=20
> >
> > > Why would this need to be a platform level decision? Given that boards
> > > that don't have enough SRAM for SPL DM support tend to be older, we
> > > will presumably want to migrate newer boards to SPL DM at some point
> > > in the future anyways.
> > >
> > > > And for
> > > > technical reasons, mostly to support older devices, which have no o=
ther
> > > > choice, but also to keep it simple and the SPL small, we do not use=
 DM
> > > > in the SPL on Allwinner boards.
> > >
> > > I mean, this seems to me to be justification for continuing to support
> > > legacy drivers, not justification for not supporting DM as well since=
 there
> > > are also many sunxi boards that don't have that limitation.
> >
> > This would be a separate set of potential cleanups to evaluate later on.
> >
> > > > I see the SPL as the continuation of the
> > > > BootROM, which is completely board agnostic.
> > >
> > > At a minimum SPL is still fairly SoC specific. Although in practice i=
t seems
> > > to not be all that board agnostic, I think if anything DM support mak=
es it
> > > more agnostic by allowing better factoring of the device specific stu=
ff.
> > >
> > > > The SPL can mimic this
> > > > behaviour, to follow the decisions that the BootROM made, for insta=
nce
> > > > about the boot device. The only difference here is the DRAM
> > > > initialisation, which requires some board specific data, but so far=
 we
> > > > got away with just hardcoding it.
> > >
> > > This is one of a few reasons I wanted to get SPL DM functional on sun=
xi.
> > >
> > > > If that is not good anymore, I think
> > > > we can find other solutions than pulling in the whole world of SPL_=
DM
> > > > support.
> > > >
> > > > So what is the purpose of this exercise, why do you want DM_SPL
> > > > supported?
> > >
> > > Some cryptoengine uboot drivers I was working on adding seemed to
> > > need DM_SPL, also I think handling DRAM profiles becomes easier with
> > > it somewhat.
> > >
> > > > Keep in mind that there are 178 Allwinner boards supported in
> > > > U-Boot, so there better would be good reasons to change something
> > > > fundamental like this for all of them. It changing it for a number =
of
> > > > them is not better, because this doubles the test matrix, so we hav=
e to
> > > > test now that it works on both legacy and DM_SPL boards - which fra=
nkly
> > > > nobody will do.
> > >
> > > Well it doesn't actually double the test matrix since presumably boar=
ds
> > > that are not SPL DM compatible will continue to use non-DM drivers on=
ly.
> >
> > And today nothing ARCH_SUNXI enables SPL, but they all could enable it
> > today and get an assortment of failures. With what James is doing, some
> > could now enable it and have it work, or more easily work.
>=20
> There are plenty of sunxi board configs in uboot with SPL enabled, I think
> it's just SPL DM that's always disabled:
> https://github.com/u-boot/u-boot/blob/v2026.07/configs/yuzukihd-chameleon=
_defconfig

Yes, oops, I mis-typed there. I meant to say SPL_DM.

--=20
Tom

--j1qBihkLziGFJEu8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalk+egAKCRAr4qD1Cr/k
CmfUAQDBJs1cv0RzS9wRB3aIMT8xjoNr83rZFZfb30C5PCkdSQEA4csoajT9QmDi
ERzP6+4HzTzH8cfOfknWLVMVFR/etQY=
=Kf1O
-----END PGP SIGNATURE-----

--j1qBihkLziGFJEu8--
