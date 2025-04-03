Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47757C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 22:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C90826AD;
	Fri,  4 Apr 2025 00:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MdkdQvZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1FB8826B2; Fri,  4 Apr 2025 00:51:05 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72FF682385
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 00:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2c77a5747e0so739697fac.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 15:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743720662; x=1744325462; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JfYrA1FbITlOz+buB7ZIWbajGJz0cwOQAjy1JpuHSxI=;
 b=MdkdQvZV5G9wSFbJprYzgiB8gzAay3cC+AEW02LOP+ekfS97sNqWRykX8tb9G3vWeG
 i6i43uaKKiNPoyZl58WK9EBpYWISaku4F7oq/n25lwz1/tliVSpFPmhiPIuer8Q8dmq4
 ze+5W95QQ3g9imw79vaM85citjH+vjiabt/fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743720662; x=1744325462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfYrA1FbITlOz+buB7ZIWbajGJz0cwOQAjy1JpuHSxI=;
 b=YCoTSVInrElNUmeMdMjNNrMKuXlVZkXFyiyOso788Jw41c0a4/lXNnZvf7QbbTRgeB
 wswIGnRX6+49jEq746ywJHycwlS8Fae207OLDE8bmmYlaW1UdeOFb8QK83/afZa9Yu/H
 T1yjCwdlroEk9X7CfZhgsP2TsbTfA61RUbOydDm3PNuBhYlT1NuxfOB0ZtO6yCJpcO7s
 SsKssfe9+PCois5nkUnm9BMOQWwjyp+ScSmp2r0XsD4YKEArW6q8ka6K1L7tSnN7Et31
 yjNRCLfKafw01dhghcoMc2b0fHMhSWH/NQUfcBrniyz3wq48VuQ+qltuhh0McDmwT3Df
 MHAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKVpVfTYeQJXAzGvg0PmeQ9mc745iOpQ5M1F5vOaDw/H1F1UoOGWsjTG/4l0KTyxqr42BPSVE=@lists.denx.de
X-Gm-Message-State: AOJu0YwB0fT1DAcKmDPFCwCgZbtJ9ylF1B0SVhLPwJuKjuw5P5Dfy//2
 E9vASuTM8ixoL/bsx4usr7HYPjTRzcEA3mXf2VpO0G1uAjZLiEm/o2XdHyMGzlc=
X-Gm-Gg: ASbGncvq0c/WA9PEq2yJ6JbZ91QHiOZesq/uGcI5ot5hg5gT17iVsMPLDIq3HKbHEfY
 nB0iWJN3GJFXsmFStzoZO/VV2kIhDkjbAABdOoLuAxFLAu3YiCLclQjWyfLqwU+WxWs+YPOFo1x
 G/L3CdmRh0pBpgI5SKFj8qBa3eHGGFOyi0Zr1Z6Zg+3BflnnmynOj5IP3h1e2Om//HRnsjvlkql
 Dsceg10aKyUIypr1KqQTxAUdC1dxM5EjXOfn7SbdjaTUSCKFC8ECe3Rzb8pGuO9M/stW5rLwhe5
 PjDS47S+PR840vVKPofgof/dbMh/iLgAZgrdOi36H/4a7o5R8vP/CxajQrSvX21uj2REHUjmsnI
 Av9Jnqw==
X-Google-Smtp-Source: AGHT+IH/4RYuiZMKGEQYhAmSCl44/n5kPGouFeZTr33uXqNZjusLcGzwZVM6Av8xC3NAEq0oE6UVmQ==
X-Received: by 2002:a05:6871:582b:b0:2b7:bd7f:f4d6 with SMTP id
 586e51a60fabf-2cc9e8bbc2cmr651188fac.37.1743720662082; 
 Thu, 03 Apr 2025 15:51:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845c69d6sm463762fac.13.2025.04.03.15.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 15:51:01 -0700 (PDT)
Date: Thu, 3 Apr 2025 16:50:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
Message-ID: <20250403225058.GQ5495@bill-the-cat>
References: <20250328154401.3563921-1-sjg@chromium.org>
 <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
 <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
 <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
 <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
 <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
 <CAFLszTjGn1JGdpNAZVL6CC+pQLsOrG6gjmo8kRzjbnR_=6CMvw@mail.gmail.com>
 <20250403215239.GO5495@bill-the-cat>
 <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mbUwYqy2dT4JhGI2"
Content-Disposition: inline
In-Reply-To: <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
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


--mbUwYqy2dT4JhGI2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Glass wrote:
> > > Hi Raymond,
> > >
> > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao@linaro.org> wro=
te:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Raymond,
> > > > >
> > > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@linaro.org>=
 wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org> wro=
te:
> > > > > > >
> > > > > > > Hi Raymond,
> > > > > > >
> > > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.=
org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org=
> wrote:
> > > > > > > > >
> > > > > > > > > The bloblist code took what I consider to be a wrong turn=
 a year or so
> > > > > > > > > ago. As discussed with Tom, this series proposes a way to=
 arrange things
> > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > >
> > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > > > - Create a deterministic OF_BLOBLIST option rather than u=
sing guesswork
> > > > > > > > >
> > > > > > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> > > > > > > > mandatorily use bloblist to hand over everything between bo=
ot stages
> > > > > > > > including fdt, creating OF_BLOBLIST is not necessary.
> > > > > > >
> > > > > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates=
 that
> > > > > > > there must be a bloblist, not that it must contain a devicetr=
ee. So I
> > > > > > > wasn't sure about removing it.
> > > > > > >
> > > > > >
> > > > > > See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MANDAT=
ORY is
> > > > > > selected, we can override any fdt from board or env with the on=
e from
> > > > > > the bloblist.
> > > > >
> > > > > Yes, but we should be explicit about what is going on here. With
> > > > > OF_BLOBLIST we indicate that the devicetree is coming from the
> > > > > bloblist. It becomes one of the sources for devicetree, like
> > > > > OF_SEPARATE and OF_EMBED
> > > > >
> > > >
> > > > BLOBLIST_PASSAGE_MANDATORY indicates the fdt from bloblist will be
> > > > mandatorily used and override other fdt sources like from the board=
 or
> > > > env variables.
> > >
> > > So long as you are OK with OF_BLOBLIST as well, I have no objection to
> > > keeping BLOBLIST_PASSAGE_MANDATORY, although I don't like the name
> > > very much. But I can see why it is called that as my standard passage
> > > series was actually never applied. So I suppose I'll need to have
> > > another try at that.
> > >
> > > So to be clear, I want a separate option for devicetree, called
> > > OF_BLOBLIST, which I can enable/disable as needed, without affecting
> > > your option.
> >
> > Sigh. Can I ask what the use case for this will be? And we are going to
> > get rid of BLOBLIST_FIXED at some point, yes?
>=20
> I thought we agreed that this was acceptable. We argued the toss for
> months on this point and I would rather not revisit it.
>=20
> Yes, I will look at removing BLOBLIST_FIXED once this is in. I'm
> pretty sure it can be done. The only tricky bit is coming up with a
> bloblist protocol for x86.

Yes, I'm stuck between being "flexible and saying yes" and how long we
have to live with what I also think are bad designs.

So maybe the pre-requisite here is that with "bloblist" and "standard
passage" being divorced, what is the requirement for bloblist again?
Because in practice, all of the problems we've had come down to looking
in fixed address locations before they're valid. You want to handle this
by saying "Ah, we won't look before it's valid with other CONFIG flags"
and I say we should handle this by not using a fixed address to start
with.

If we have to add OF_BLOBLIST now and delete it in a few months, sigh,
OK. But it shouldn't need to exist long term.

--=20
Tom

--mbUwYqy2dT4JhGI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfvEMUACgkQFHw5/5Y0
tyxufAv8D/HSoE15I8OxVUwgWcwOIKBxBny4nDdjV59AsyNLxNptdj7RCvqarozq
yBh/qcUiUmL+S4XRp/X7lRvaNi6EXHyqjaVMOhP46tjNderHykWxTzwuRg+hxWKV
cgeQkYZEor5wcU5snVv7C0b6BYIIUgZEBo6fdiyWQP+odarbib5xQofkvVIHzI2l
fPiO4rx7iJe8B9hgLqSTq4P+DbDF3UcmMHfG8ppJK/aKpwn6cLxekQ9NEJiBUSb5
WU4Xjrup53J9yICkg75kpohan9ZgR0PrLtzZZ8PE0T5+WG8V9fWKq3Z1Gli65x04
+fHcvsnTFQHnCA1kbqmzuGQ+YrszrgZVYP/S5JKBhjXW/bbwzBtCzhbLH6PzOCnz
7FY1AFVMDMMYzmmd0BUakuHsQHmBCNSVyPw51Vaw8Zc+W+g8tCb/5n+uL3glGtLu
310h27TFqNtXmpny1KBXPFFVtwLqD9jOuWX3s0YYrMS4SNCWZropZNBAD9D2gtBz
Hm0ST/7i
=kop0
-----END PGP SIGNATURE-----

--mbUwYqy2dT4JhGI2--
