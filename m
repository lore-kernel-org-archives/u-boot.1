Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B232BD3177F
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC9588D29;
	Tue,  5 Nov 2024 19:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NEwzg980";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6EF8900E; Tue,  5 Nov 2024 19:26:28 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C505785B66
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 19:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b161fa1c7bso400309785a.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730831184; x=1731435984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7DLjzoj4GDhr+2iGy4Je7mZUrLIGGbyB3rXG9NKVvYw=;
 b=NEwzg980MqWD7YE3d3R35i4nOYZzWtmrRcYd5sNmL7LUAMheb0zG3z+aGgLU9lYIyZ
 b23QRthzhUf6tMlSQdKlUXNRd4K4VeV3E8YjdIQdB/VGEo8TQOJsxtZfNp1bn/TDZhrg
 RlBBmqbg/11dGeJtJufDw1DTaW02iERvY8B6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730831184; x=1731435984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DLjzoj4GDhr+2iGy4Je7mZUrLIGGbyB3rXG9NKVvYw=;
 b=mKJX8CoWRuhQjtPErn7WeTxiWl4vXGqQLub0dKggR9C6nop6/4ae9RiNaipANAdELG
 a0GXjckjwJBP6BKh9/wFWVowlaVGCE7/MPsXMajgW/lVbDK4JbwY6gdVT7zVJgR1bU7a
 AIu4q2BAwwn8FQrsMv4c3xKCDm9LHzvdI4fKB3cNW/mv3n/o1z0TiojIRUDPxG8H73mu
 nWyCSmedc9LH/FZbQRWDTJFM0/vVcdKdmtLuaRabLqj/ZW06dC5TUVA8crB3CsclP+Hb
 UTrXRFEAzPJb0b3wpZs8X03PZktueev/7AhcMNZxrhI4G8xgDh/lJTBamx/oP0kk+c7T
 b5sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8bm1lXC9sGRz7DD9SqDGKrBcqG/UCpEZoP8LNHMv8XvLkzDM/M5Jqw0WEBQN0M+uc0RyhzvI=@lists.denx.de
X-Gm-Message-State: AOJu0YwH+vNfTZmn01wOfVW8WuBqR+eXZXq1tAebFIVn43VAGx7nKd2Y
 X2lsGQMtr9EDjKLdD+hnsYlrx745wI/oVY/TmRRcK6iOfomThgvUsGsRZL3mLcA=
X-Google-Smtp-Source: AGHT+IEGcUNhKIKQUhxVwRW8dK4O8/Kf97y+hDKOF4QKXFJpwDswWNIf4WrQeFusCa/LZPHdAnK7Zw==
X-Received: by 2002:a05:620a:2410:b0:7ac:b220:309a with SMTP id
 af79cd13be357-7b193eea86cmr5244608085a.15.1730831184608; 
 Tue, 05 Nov 2024 10:26:24 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a0c1c6sm549051085a.61.2024.11.05.10.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 10:26:23 -0800 (PST)
Date: Tue, 5 Nov 2024 12:26:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
Message-ID: <20241105182619.GL3600562@bill-the-cat>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
 <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
 <20241105154741.GI3600562@bill-the-cat>
 <CAFLszTjntxJShjnWK++NkonNrPdL0S-=zWf-N_AWUaZmfmArtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r4pLTuywMsaawwKr"
Content-Disposition: inline
In-Reply-To: <CAFLszTjntxJShjnWK++NkonNrPdL0S-=zWf-N_AWUaZmfmArtg@mail.gmail.com>
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


--r4pLTuywMsaawwKr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 09:07:17AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 5 Nov 2024 at 08:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 05, 2024 at 08:15:25AM -0700, Simon Glass wrote:
> > > Hi Peter,
> > >
> > > On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com> wr=
ote:
> > > >
> > > > On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy w=
rote:
> > > > > >
> > > > > > > Legacy TCP stack is bad. Here are some of the known issues:
> > > > > > >  * tcp packet from other connection can break a current one
> > > > > > >  * tcp send sequence always starts from zero
> > > > > > >  * bad tcp options processing
> > > > > > >  * strange assumptions on packet size for selective acknowled=
ge
> > > > > > >  * tcp interface assumes one of the two scenarios:
> > > > > > >      - data downloading from remote host to a board
> > > > > > >      - request-response exchange with a small packets
> > > > > > >    so it's not possible to upload large amount of data from t=
he
> > > > > > >    board to remote host.
> > > > > > >  * wget test generate bad tcp stream, test should fail but it=
 passes instead
> > > > > > >
> > > > > > > This series of patches fixes all of the above issues.
> > > > > >
> > > > > > I know Peter asked on the last one, but I want to ask as well. =
With lwIP
> > > > > > merged, why do we want to add features to the old stack? I can =
see
> > > > > > fixing issues, but not adding new functionality as well. Thanks.
> > > > > >
> > > > >
> > > > > Let's apply this. It has tests and the old stack is still used by=
 a
> > > > > lot of boards. At present lwip is only used on one. There is more=
 work
> > > > > to do on the new stack, including finishing off the sandbox
> > > > > implementation.
> > > >
> > > > I agree with applying the fixes pieces, I do not agree with apply t=
he
> > > > HTTP server pieces. This series should actually be split into 3
> > >
> > > But what is your objection?
> > >
> > > I would much rather just apply it ASAP. It has already gone through 12
> > > versions, during which lwip has been prepared and applied.
> >
> > Yes, and to be blunt, the first bit of feedback I provided was "can you
> > please look at the lwIP series instead?".
> >
> > > The HTTP server is a useful feature and we should be able to use it to
> > > test networking in U-Boot in a more self-contained and performant
> > > manner.
> >
> > I very much do not want to add more features to the legacy TCP stack.
> > We're likely, long term, to still need some cut-back version of the old
> > stack for the limited SPL cases.
>=20
> This series has been in progress for a long time and it seems unfair
> to just drop it, with one one board on the new stack.

Well, I continue to not say that we should drop the series, but that we
should take the fixes and not the new features. Because as far as I can
tell, the current TCP stack is in such a shape that it's not
production-usable anywhere and so the number of users argument is
irrelevant.

--=20
Tom

--r4pLTuywMsaawwKr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqY0gACgkQFHw5/5Y0
tyy1bwv7BuiXSm7C/nbSdl+8xESTq4qUMh1goLVrGKhz+2TqUdT+lyjG/JTU9+Cu
/30RV70o2QM1NkAhGDiFr1ycpZtPVdC5beQEcRVQccYfUI7Jb1lW798LpcoL3qlv
rDuKGO+27C+f1lj3sP0xM2Akwsv95b3/3/M54DhV48TkppTDDa8YoWsfAyOTbfFC
LQOD4J4X+m0uqnCC/rWygQAnH8oiYFtr1sR0UJmeJjZwaJy/Ym2LodTdXnc2eC1N
2QrXsyYXUr+qHzqYsYcEu3OJW4Xx/VGXZoIpCormenar8hvEv5PTPnhCbTTZ/maK
2WBXwWjlsRUHcnByRKhX0VW9UvQhvwdArcJUxMaRnvA4sXnSOsbrqsuRNO49fhTD
wDOqIz2zSd1SEYl4JMhoFnGtPnJ+vkqZvuYj219UVgTv04eSRRUW8i8opFK383f5
wlTiWpnDy5FZgiAQz4BbWFz6ua+IYnrgz78dDf0g/rceryMaEzliAlKSO1qZXyN3
hlyG8xF7
=ZqUk
-----END PGP SIGNATURE-----

--r4pLTuywMsaawwKr--
