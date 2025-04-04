Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9BBC3601A
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 17:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BA9829C3;
	Fri,  4 Apr 2025 19:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IKD2MKG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234C882A16; Fri,  4 Apr 2025 19:57:18 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6CC8215B
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 19:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72bb9725de1so614630a34.2
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743789434; x=1744394234; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9SheIcumq37lTtSTs+5XeTVRTWajYYN/2jGdPld76Z0=;
 b=IKD2MKG5jChadV9K/G/fOQlR5VXZsHp4RKndrmFv1qqvCGWDli6dJlxbMyMNkw3SuO
 tbJPjnvibZCEaQw2ilh4sHNDXDn6yekYgPtIc76FxIqACNSYn27GqwMfEInmAl85gUig
 3b8TFNJJ0dNSB/37ZcZAdOTcrQj5BHQQnCK7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743789434; x=1744394234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SheIcumq37lTtSTs+5XeTVRTWajYYN/2jGdPld76Z0=;
 b=LE3eADinwOW/ZiO6wWNMcb+hHu9FcLA5Dp1QOSneszurSftDBwk2CM8NyUM1Uz4ipR
 0Lukh12ZsgL9cH7h4BvP2/gJr5PIVWBS1JIJGS7zB1nJgxYoIMoOsYB2OZs74mCbEnP/
 uDPlWrmAi71j1be4w5yYPrWX5Z/Ma8hoETUbdmZnvyX3lqpzUyK9nE/aPtTXfSbBcuq0
 opvXcPxYQEOuCHWKKiLKzpZQidH0T5qD7JLmm3qCgnQKNf4MBetLr/xKivSW0/fQewVf
 vZJX7EVpfz2IkIa2RT73Bh2lNbcGlkuk1dWnxFVEAcP2H/2cFS7vHpM1Lk3lj9WjKJ52
 GyMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0deBoejIlBRzKrzefVIzFyN1Wzs5l+trmTOikYR7ubf4oSpS3K+8wYQEmdFytLBfQgMsdIY8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw67uBo2gqwxK1O8f+gtBrGRCP56/xrzW8BO/1E40z4pckwBVqO
 TOQCvYTTsvhj/EnSufQHIlQOzMnsJaAUXiNVge4gmQnW4O5OtcEYajyF2tQ/DBQ=
X-Gm-Gg: ASbGnctxelclYsT1zllpKI4HWJekFfWS++b6O/hXnu0nq9OkarQaUAg9azLfuE3sXYz
 h/+LMPhLhyi46+NoOnZ6TUWUP30oru8WJmb96xK/ZSMBfYA/DYnJHkDA6XjCPz8uahezIRtzVlF
 06J970QvDgEqhE1k4W61t8vYoaA6njjReOg/8OhwdIVJdR3x37XYwTWeFrff0UiC2SiWfk6ouy5
 +ivWaSW2PP/vFRy5fr9jUN5JB74w0ZZXX5+FwFBt1yatvWSWUa+joiawsWoRzu40mGcByU6eF1i
 qt6+xwc/+y1ztyv64w2mOJsDP9g0NAHz8Z0mXkyn6ren4rb1UWYwF5QJ6voJ3SJ5OsMH1pHFvV8
 KwaQHCw==
X-Google-Smtp-Source: AGHT+IEQDeWTC5Q5P+nbzLhFNluRJzman+c5rLGtlQSCeIPKustY46w891s8AD9Dz/+mPvRGAIsEwQ==
X-Received: by 2002:a05:6830:6418:b0:72b:89ca:5120 with SMTP id
 46e09a7af769-72e366cfb40mr3498808a34.8.1743789434082; 
 Fri, 04 Apr 2025 10:57:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e305b66fcsm769056a34.65.2025.04.04.10.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 10:57:13 -0700 (PDT)
Date: Fri, 4 Apr 2025 11:57:10 -0600
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
Message-ID: <20250404175710.GU5495@bill-the-cat>
References: <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
 <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
 <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
 <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
 <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
 <CAFLszTjGn1JGdpNAZVL6CC+pQLsOrG6gjmo8kRzjbnR_=6CMvw@mail.gmail.com>
 <20250403215239.GO5495@bill-the-cat>
 <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
 <20250403225058.GQ5495@bill-the-cat>
 <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1OZ+jTMAkxOU/6xF"
Content-Disposition: inline
In-Reply-To: <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
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


--1OZ+jTMAkxOU/6xF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Glass wrote:
> > > > > Hi Raymond,
> > > > >
> > > > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao@linaro.org>=
 wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.org> wro=
te:
> > > > > > >
> > > > > > > Hi Raymond,
> > > > > > >
> > > > > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@linaro.=
org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org>=
 wrote:
> > > > > > > > >
> > > > > > > > > Hi Raymond,
> > > > > > > > >
> > > > > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@lin=
aro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Simon,
> > > > > > > > > >
> > > > > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > > > > > > >
> > > > > > > > > > > The bloblist code took what I consider to be a wrong =
turn a year or so
> > > > > > > > > > > ago. As discussed with Tom, this series proposes a wa=
y to arrange things
> > > > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > > > >
> > > > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > > > - Avoid needing to init the bloblist just to get the =
FDT
> > > > > > > > > > > - Create a deterministic OF_BLOBLIST option rather th=
an using guesswork
> > > > > > > > > > >
> > > > > > > > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which =
means
> > > > > > > > > > mandatorily use bloblist to hand over everything betwee=
n boot stages
> > > > > > > > > > including fdt, creating OF_BLOBLIST is not necessary.
> > > > > > > > >
> > > > > > > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indic=
ates that
> > > > > > > > > there must be a bloblist, not that it must contain a devi=
cetree. So I
> > > > > > > > > wasn't sure about removing it.
> > > > > > > > >
> > > > > > > >
> > > > > > > > See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MA=
NDATORY is
> > > > > > > > selected, we can override any fdt from board or env with th=
e one from
> > > > > > > > the bloblist.
> > > > > > >
> > > > > > > Yes, but we should be explicit about what is going on here. W=
ith
> > > > > > > OF_BLOBLIST we indicate that the devicetree is coming from the
> > > > > > > bloblist. It becomes one of the sources for devicetree, like
> > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > >
> > > > > >
> > > > > > BLOBLIST_PASSAGE_MANDATORY indicates the fdt from bloblist will=
 be
> > > > > > mandatorily used and override other fdt sources like from the b=
oard or
> > > > > > env variables.
> > > > >
> > > > > So long as you are OK with OF_BLOBLIST as well, I have no objecti=
on to
> > > > > keeping BLOBLIST_PASSAGE_MANDATORY, although I don't like the name
> > > > > very much. But I can see why it is called that as my standard pas=
sage
> > > > > series was actually never applied. So I suppose I'll need to have
> > > > > another try at that.
> > > > >
> > > > > So to be clear, I want a separate option for devicetree, called
> > > > > OF_BLOBLIST, which I can enable/disable as needed, without affect=
ing
> > > > > your option.
> > > >
> > > > Sigh. Can I ask what the use case for this will be? And we are goin=
g to
> > > > get rid of BLOBLIST_FIXED at some point, yes?
> > >
> > > I thought we agreed that this was acceptable. We argued the toss for
> > > months on this point and I would rather not revisit it.
> > >
> > > Yes, I will look at removing BLOBLIST_FIXED once this is in. I'm
> > > pretty sure it can be done. The only tricky bit is coming up with a
> > > bloblist protocol for x86.
> >
> > Yes, I'm stuck between being "flexible and saying yes" and how long we
> > have to live with what I also think are bad designs.
> >
> > So maybe the pre-requisite here is that with "bloblist" and "standard
> > passage" being divorced, what is the requirement for bloblist again?
> > Because in practice, all of the problems we've had come down to looking
> > in fixed address locations before they're valid. You want to handle this
> > by saying "Ah, we won't look before it's valid with other CONFIG flags"
> > and I say we should handle this by not using a fixed address to start
> > with.
> >
> > If we have to add OF_BLOBLIST now and delete it in a few months, sigh,
> > OK. But it shouldn't need to exist long term.
>=20
> For me, OF_BLOBLIST is needed for x86 devices which don't pass the
> devicetree in the bloblist.

I don't understand why that would become the case when it's not true
today.

--=20
Tom

--1OZ+jTMAkxOU/6xF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfwHXYACgkQFHw5/5Y0
tyw4VAv+LNow0J59UVPNQRjl35SHQ47aoQVHA8x1wnINL3Zx/Bb7oRBfKKrjSaId
7sa84QpKiuJND+YNssNUhdaA1LFB1wp/NqSOyhXN0j/IgBgXFDFHGNRNaTZAHIk9
6vY+Gm18w+Ts2BVRFPZ1LRP0h4QkzrFfhHUZzd9SIWC3cn0yV8cFypblfrTjBOc8
m6w0tLYyvLi3w6jJtnvL+qv/mCMh6vDgJyfxT84eHB1+589Vd/LWDh7ooVBIqzYC
th1zP1xv2U+jBETnRpU/Uom5tsyWm5EtF2TF5IfUYtLTyRfE1ABfXezqkl5FD8vW
PJerq3fYMebV5c30M42PCPdJgak/jn/ytM9CGNiFZmf5oauvdC8vmbsd+El0H8BJ
+nx1wMH+QXeQ8tHqZmcWn0/mYAnzIc0DRtFXD0Hhb8hlSVZOEYmJMcvbvjolT4s0
wj9xsIpJaGVW/ZyhwidRNepFPjlcIJs1OKX+aEdT6YlCK0M2SULVhJm5TL76kzVk
6WQWj8aI
=efvy
-----END PGP SIGNATURE-----

--1OZ+jTMAkxOU/6xF--
