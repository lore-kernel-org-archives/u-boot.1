Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D9BC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C35B482C55;
	Mon,  7 Apr 2025 16:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rxf0istT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D9182F3B; Mon,  7 Apr 2025 16:31:06 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 390FB82B63
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3fefbbc7dd4so2603346b6e.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744036261; x=1744641061; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJMrlfpQwnX3OgbGA1SpE+8ZeXU2u+//1vLLOyvg880=;
 b=Rxf0istTDmWS/Mk/CyCTRnvkHztvBe/26IkQgUf9OCzVpQBtV9pnre0nkfjmNfTUg4
 8fcmS/zqQR7Fsfkbm8X3xjWrLf1P4zF23AC21x2fp2ezGNp9Nn6TrUhM55K8wWsR6uyK
 hEbtRCZePm2Zk18W29B19mi76G4MA19aZUY80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744036261; x=1744641061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJMrlfpQwnX3OgbGA1SpE+8ZeXU2u+//1vLLOyvg880=;
 b=EAFZuBJmsD47vGCXBgmT5R/RDK3K2vn8V1Ff1En4LxnjKYIJTKdy106p8QFH0rC60i
 MxNA09j0749M3ghAyblX3M1u3XL/ykWb5TKBXCPa8G6qGoeywujVZoh+uSE1HyAZohjO
 rjhvMtDzKf0EsncVTiXhJZN7ngwl8Poob79hUroW6t55C/B+LjJZzYfz4CjX+J0b4oN8
 1jf8yMLb5OmmR8D17vP86LGO7y0buLBO7S5UsISQVNhkdEkaU7nazERCOp9drzMkxNGh
 6aiXLWrWrTgXxW1X0JIBFLyPJshzlXMgdvwPguCiyx6ggmX/0mWQo9lZX1JuekpK7KPU
 CAzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoPv5FJ6sx+mMHox1E3+dZhuZJ1jg1qMz+WFd5Lf618U8PyXoKl9ag/fhoU8B2tqwsWDdfwqQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzxlTLg4WyBMuzcyYBcVKdb5cpnVNhuGr1d6xJXS4gjB2MOa+7R
 MuTlVWNxhouLi7flhxcTk0R8yVx113ijf2kB1CkkI9/lATAdeKEhYhBiDm47+7o=
X-Gm-Gg: ASbGncugA0iVLaPiQRqQsnIQ1GcZ2NBtNTEfThR5np90jUoNVyy+Qj4pt7cnCeYT7hB
 SFIXX7p0jiwAZ8DzLYMWDzYK1YLaaEOPK3LaU8gbzmIyf9CdmWrsL5XseJJMjuZ56Xne8tcvZ4Z
 Y4cfp6T+74jLIp+rVU9uDuUeNFvzEzqIMxAjocwcc1cUM76S6/yTn03TOohJgMFzstLcMLwxDgt
 PtQZlrD2lJ7rCkGioKVnlS8N16JKMKSL6AnC48MtuhMOwpYm8TKl1ThPSF/M51+PRa9LTQD7RzH
 pFewRFKsl7FrAxfB5HiYJ8V+6KnXQrhY4SnVCKHQNrhdn7y/ht5ESmCvhfgdQZpROw4hmvtNCdA
 UwjtId0hhNbho65f3
X-Google-Smtp-Source: AGHT+IG55QIy/JU7LnIhfMaOuyaaP2/ntBwajk0dBcmgVqARx7b7jBi9rI2xKPzXyQB7zOwStPluKg==
X-Received: by 2002:a05:6808:6c88:b0:3f7:ccac:287f with SMTP id
 5614622812f47-40045639cfamr7913420b6e.27.1744036260883; 
 Mon, 07 Apr 2025 07:31:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4003ff4e085sm1729948b6e.3.2025.04.07.07.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:31:00 -0700 (PDT)
Date: Mon, 7 Apr 2025 08:30:56 -0600
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
Message-ID: <20250407143056.GL5495@bill-the-cat>
References: <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
 <CAFLszTjGn1JGdpNAZVL6CC+pQLsOrG6gjmo8kRzjbnR_=6CMvw@mail.gmail.com>
 <20250403215239.GO5495@bill-the-cat>
 <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
 <20250403225058.GQ5495@bill-the-cat>
 <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
 <20250404175710.GU5495@bill-the-cat>
 <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
 <20250406223854.GE5495@bill-the-cat>
 <CAFLszTjLugnmipzzCcAttyvZqQdohNV==jDj_mGzs2_1eFJw1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M5TqWhmbkuPv03Lr"
Content-Disposition: inline
In-Reply-To: <CAFLszTjLugnmipzzCcAttyvZqQdohNV==jDj_mGzs2_1eFJw1w@mail.gmail.com>
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


--M5TqWhmbkuPv03Lr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 12:35:15PM +1200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 7 Apr 2025 at 10:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 07, 2025 at 10:06:07AM +1200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 5 Apr 2025 at 06:57, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Glass wrote:
> > > > > > > > > Hi Raymond,
> > > > > > > > >
> > > > > > > > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao@lin=
aro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Simon,
> > > > > > > > > >
> > > > > > > > > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.=
org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Raymond,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao=
@linaro.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond=
=2Emao@linaro.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@=
chromium.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The bloblist code took what I consider to be =
a wrong turn a year or so
> > > > > > > > > > > > > > > ago. As discussed with Tom, this series propo=
ses a way to arrange things
> > > > > > > > > > > > > > > so that it is simpler to understand and manag=
e.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > - Unwind some of the nesting in bloblist_init=
()
> > > > > > > > > > > > > > > - Avoid needing to init the bloblist just to =
get the FDT
> > > > > > > > > > > > > > > - Create a deterministic OF_BLOBLIST option r=
ather than using guesswork
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATOR=
Y which means
> > > > > > > > > > > > > > mandatorily use bloblist to hand over everythin=
g between boot stages
> > > > > > > > > > > > > > including fdt, creating OF_BLOBLIST is not nece=
ssary.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATO=
RY indicates that
> > > > > > > > > > > > > there must be a bloblist, not that it must contai=
n a devicetree. So I
> > > > > > > > > > > > > wasn't sure about removing it.
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > See my comments to your [2/4] patch, if BLOBLIST_PA=
SSAGE_MANDATORY is
> > > > > > > > > > > > selected, we can override any fdt from board or env=
 with the one from
> > > > > > > > > > > > the bloblist.
> > > > > > > > > > >
> > > > > > > > > > > Yes, but we should be explicit about what is going on=
 here. With
> > > > > > > > > > > OF_BLOBLIST we indicate that the devicetree is coming=
 from the
> > > > > > > > > > > bloblist. It becomes one of the sources for devicetre=
e, like
> > > > > > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > BLOBLIST_PASSAGE_MANDATORY indicates the fdt from blobl=
ist will be
> > > > > > > > > > mandatorily used and override other fdt sources like fr=
om the board or
> > > > > > > > > > env variables.
> > > > > > > > >
> > > > > > > > > So long as you are OK with OF_BLOBLIST as well, I have no=
 objection to
> > > > > > > > > keeping BLOBLIST_PASSAGE_MANDATORY, although I don't like=
 the name
> > > > > > > > > very much. But I can see why it is called that as my stan=
dard passage
> > > > > > > > > series was actually never applied. So I suppose I'll need=
 to have
> > > > > > > > > another try at that.
> > > > > > > > >
> > > > > > > > > So to be clear, I want a separate option for devicetree, =
called
> > > > > > > > > OF_BLOBLIST, which I can enable/disable as needed, withou=
t affecting
> > > > > > > > > your option.
> > > > > > > >
> > > > > > > > Sigh. Can I ask what the use case for this will be? And we =
are going to
> > > > > > > > get rid of BLOBLIST_FIXED at some point, yes?
> > > > > > >
> > > > > > > I thought we agreed that this was acceptable. We argued the t=
oss for
> > > > > > > months on this point and I would rather not revisit it.
> > > > > > >
> > > > > > > Yes, I will look at removing BLOBLIST_FIXED once this is in. =
I'm
> > > > > > > pretty sure it can be done. The only tricky bit is coming up =
with a
> > > > > > > bloblist protocol for x86.
> > > > > >
> > > > > > Yes, I'm stuck between being "flexible and saying yes" and how =
long we
> > > > > > have to live with what I also think are bad designs.
> > > > > >
> > > > > > So maybe the pre-requisite here is that with "bloblist" and "st=
andard
> > > > > > passage" being divorced, what is the requirement for bloblist a=
gain?
> > > > > > Because in practice, all of the problems we've had come down to=
 looking
> > > > > > in fixed address locations before they're valid. You want to ha=
ndle this
> > > > > > by saying "Ah, we won't look before it's valid with other CONFI=
G flags"
> > > > > > and I say we should handle this by not using a fixed address to=
 start
> > > > > > with.
> > > > > >
> > > > > > If we have to add OF_BLOBLIST now and delete it in a few months=
, sigh,
> > > > > > OK. But it shouldn't need to exist long term.
> > > > >
> > > > > For me, OF_BLOBLIST is needed for x86 devices which don't pass the
> > > > > devicetree in the bloblist.
> > > >
> > > > I don't understand why that would become the case when it's not true
> > > > today.
> > >
> > > If you look at the top obbfdtdec_setup() in your tree you can see the
> > > special-case code related to TPL, that I'm wanting to get rid of.
> >
> > OK, but all of that too is for the case of a fixed bloblist being in
> > uninitialized memory. Which is why I don't like BLOBLIST_FIXED and want
> > to see passing of the bloblist from xPL -> PPL be implemented and so xPL
> > can allocate a bloblist (or grow a passed one if needed).
>=20
> We are going around in circles though. Having it is registers doesn't
> help with the problem that there isn't an FDT in the bloblist.

Sure it does. If we're passed a bloblist in a register we can then see
if it has a DT (and use it) or not (and move to the next DT location).

> Also, I thought you decided that I could maintain bloblist. Have you
> changed your mind?

You just mis-understood me. Yes, you can maintain bloblist. But also,
Yes, I need to understand what you're doing. The root of the OF_BLOBLIST
problems is that no one understood you.

--=20
Tom

--M5TqWhmbkuPv03Lr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfz4ZkACgkQFHw5/5Y0
tyw7Pgv+KAp/EYP9uG3e/kEiwmhyOhT3UIeFIRV5a78j2jL9SD+LBBVxpBez3Ppe
etcV1IOUoNg5pYqiprC1f3i07l0b0tTDnAgjXFGE1LHopkWCPZxZH6VYl1L2DZzP
3VE/uaVs8CngUXIuNhsnwTrhGBY8d+a00EF+kAjGjRhtyF1USu+SjyNvGDYM2AI8
ubPUjqHXuGX5KFrpHAcGCY2xxX2TYZ4qg/Hv+8L3i3TE24v5u6sugk+162sEGH08
18K6B5m4ST+g+Bmem80knBt4M7vazzzgxK3ZW5yCOQRPp+oRGhjZm3glk+OPMiGf
KxrIPP/vLxsay1zbuLu27CV5TWO0p8bAKszjCSIw83zFO40/IidifcxU54VT2GTV
ZifNabclRDawnYcGHUeIu47p5YZ9jw1v8i1LVFQe4USXCOmZ+S9Cy7ROaBGdI6sB
BN1Vr2CZ/LbQhIENqKgdGc5zxEUOLTcsrn8v4BhPuk/Hr+8preu2JHEiDzjUtbHg
SKyr2bQn
=gBnO
-----END PGP SIGNATURE-----

--M5TqWhmbkuPv03Lr--
