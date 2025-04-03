Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271BDC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D0182385;
	Thu,  3 Apr 2025 23:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JMQIhxKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445B08249D; Thu,  3 Apr 2025 23:52:46 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F32B08215D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3f556b90790so443580b6e.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743717163; x=1744321963; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6pCb3QksLiclxBRu9Vu7HGCrGu7goaCDJBLAxSYnsXE=;
 b=JMQIhxKT1tn3/npDofnCi/0XhUV9q/Vac+zLV63UrsHHiAtds4WtSkq+yJoBEjMIFC
 yk0mjOGXguRoWVwKjplotdrLBi+h1lMmjNA0NqoH0sChlRwpGjZDgXi8zc/ocIfTT0bd
 EpiTr+pD532vfV3O01PT4Je0U/M+sr8hNyL3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717163; x=1744321963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pCb3QksLiclxBRu9Vu7HGCrGu7goaCDJBLAxSYnsXE=;
 b=PxULvDZrYtGH8/t0dSdfTXvqUWTZzaHokAwUzDYiypqw3HIm1Q65QphEJmOrgSkBXp
 b18TAmm4LRguJJtLHwCRhOceidQkESv7d7xUOixnTPfBv3NZgWXxC5mDJ3JRiqEQ7xL4
 CLthGbAhz1tSbNzE0lofkgOWY2xBQ2k5XpbD86IMQmkpWo+LagTwRfz9lQHLXTPqBK3p
 tA/hVCyrRg+ia31rSY16x4V+6n/r78wOCRUaDQQdaHC1lvOb+OR2i/+V53XPWW2Mm2mD
 Jlar39GfEnXiONIKPhq19XZMH8BWt+pjsherU812PKOvKeFeqSiyvU6mhd6B26kPDtAb
 s9Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKe5TS5RCDUsirk8mXvPfTkvdgDnY8cOJ6tPl1qEDADs1Db5sCSODJkFcTiGTzqCDwPxQd/VY=@lists.denx.de
X-Gm-Message-State: AOJu0YwrqWeJ2CihZKg6tjpgqt37WyP1liQE5EIchdte/gFdwN3qbkkB
 E20bD+vRtq67N4/bxA4n+bLPKk6p6gCLITwrrRLwHUB2h6oIitIlWyhNMhtuAF4=
X-Gm-Gg: ASbGncs10OhPO1eijsYgew6KYjhnSEQd93lOcFdYFjmQ5e1cz9K1w+ZhRjiTXmEWk6j
 Hz8Ct8tqNpg00A/i19m9yKmapHJL4NIprfgc10Jns3qxCvCl8xqjPiDkKRfdn8Kqs9FOlP2rBKt
 W6A02UswsRfTaaL6YNRKzHEU7xJFKyH/HiEieRVe3S45IBFXgkz2Zav6zaXetIVH1X0x1Xy0aHO
 s+Nqafy14CyVCVH8KJneAtITJQzIuMuc1yU7IOwBAoks6ScRCkMUobqOwY8JAp5SXo8xK07cfap
 o6AN1ccjqo7HxTu8rTvcT2AEkqh7eSdCJXjPGuNhjtAH7rTA+Z5Du1UZh/cr5PWvcLNNoHYFrmr
 1TW5JZQ==
X-Google-Smtp-Source: AGHT+IFKcwf4EXNBlNK/QHJQ7B4q6Z4YFkJe3rJ2KebIASL9Jpuppf0hRjuF8iLcexCxuqKvv4eZ7Q==
X-Received: by 2002:a05:6808:1686:b0:3f9:73c5:68d3 with SMTP id
 5614622812f47-4004557f222mr606598b6e.5.1743717162702; 
 Thu, 03 Apr 2025 14:52:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40040099665sm361883b6e.43.2025.04.03.14.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:52:41 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:52:39 -0600
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
Message-ID: <20250403215239.GO5495@bill-the-cat>
References: <20250328154401.3563921-1-sjg@chromium.org>
 <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
 <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
 <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
 <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
 <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
 <CAFLszTjGn1JGdpNAZVL6CC+pQLsOrG6gjmo8kRzjbnR_=6CMvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z1nKvFHpGIvGQzKP"
Content-Disposition: inline
In-Reply-To: <CAFLszTjGn1JGdpNAZVL6CC+pQLsOrG6gjmo8kRzjbnR_=6CMvw@mail.gmail.com>
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


--z1nKvFHpGIvGQzKP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Glass wrote:
> Hi Raymond,
>=20
> On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@linaro.org> wro=
te:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Raymond,
> > > > >
> > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.org>=
 wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wr=
ote:
> > > > > > >
> > > > > > > The bloblist code took what I consider to be a wrong turn a y=
ear or so
> > > > > > > ago. As discussed with Tom, this series proposes a way to arr=
ange things
> > > > > > > so that it is simpler to understand and manage.
> > > > > > >
> > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > - Create a deterministic OF_BLOBLIST option rather than using=
 guesswork
> > > > > > >
> > > > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> > > > > > mandatorily use bloblist to hand over everything between boot s=
tages
> > > > > > including fdt, creating OF_BLOBLIST is not necessary.
> > > > >
> > > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates that
> > > > > there must be a bloblist, not that it must contain a devicetree. =
So I
> > > > > wasn't sure about removing it.
> > > > >
> > > >
> > > > See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MANDATORY =
is
> > > > selected, we can override any fdt from board or env with the one fr=
om
> > > > the bloblist.
> > >
> > > Yes, but we should be explicit about what is going on here. With
> > > OF_BLOBLIST we indicate that the devicetree is coming from the
> > > bloblist. It becomes one of the sources for devicetree, like
> > > OF_SEPARATE and OF_EMBED
> > >
> >
> > BLOBLIST_PASSAGE_MANDATORY indicates the fdt from bloblist will be
> > mandatorily used and override other fdt sources like from the board or
> > env variables.
>=20
> So long as you are OK with OF_BLOBLIST as well, I have no objection to
> keeping BLOBLIST_PASSAGE_MANDATORY, although I don't like the name
> very much. But I can see why it is called that as my standard passage
> series was actually never applied. So I suppose I'll need to have
> another try at that.
>=20
> So to be clear, I want a separate option for devicetree, called
> OF_BLOBLIST, which I can enable/disable as needed, without affecting
> your option.

Sigh. Can I ask what the use case for this will be? And we are going to
get rid of BLOBLIST_FIXED at some point, yes?

--=20
Tom

--z1nKvFHpGIvGQzKP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfvAycACgkQFHw5/5Y0
tyx1Pwv9HsY6odZrguY/5zkYOK5+PsGym+Darb+oDEQzS0FP6YwWdrjQqYDVBCdM
+KXHGS8bZAYKc4APUPTlv/05u/qNVcHp70HJnb/GUqI8R2+afx4oOujmyQyvQF5j
XJ2hUv+Kh1vR6oZNTS/jraSikCUUlclgrsiixu2FsaLvi/KH8yM28VTqtEm1gDAG
DYaiAAVMSVW/5bx2g2iyQmyb30cL7hADmNCec+fTylzhcyXszKLeu0+/1Nc5djji
8h4I7/GRWc6JRuvLhORk08HAv4l4JaLUtI85zhbB7CKHeGRjIv1Pl9osNIMKB5F1
pWwQ95kRc2vtgBqBa3oz/M1Pcb6O9wWh4XatSq/2dBZ5GWaVHaWjoe39Arbo8c5K
EePk7mA6lt23fZeZwpN6lyA+Mqhinx+nu2xbOYW3PvZmC2/+oz4Q8dUhyNeJphxR
qawsm5VI2Y5gHtKLhJZHTDAXeUcSwySsn+ha7NfAbT5W9CCK1Q0qPuTj+kX0ifl3
PYhC6lie
=Ntlh
-----END PGP SIGNATURE-----

--z1nKvFHpGIvGQzKP--
