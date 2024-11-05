Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E631BD3E775
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 22:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4CF88D09;
	Tue,  5 Nov 2024 23:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hWZlhUnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C306F88009; Tue,  5 Nov 2024 23:24:04 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6820188D09
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 23:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5ebc04d4777so2952279eaf.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 14:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730845441; x=1731450241; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NPT4sbCkNvkysBp/Mk2tT3gvwhpWg7uPRCcQ6e0kjrU=;
 b=hWZlhUnNfh7K9vU60cmMdHoPSeT0FYdxvTZRsc9vs/vbX2j0O+VYnPhnfVWCa1xMkI
 zZqq66dW4KE6Y0VJp0GcL2xTyk/2//YqqC8Tjk8k8QLMnR5O6dYudLMxEXNvOMcKMZBa
 /wwBbnDh0YhVceCXgSz5gad6SMDVWggTyAlCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730845441; x=1731450241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPT4sbCkNvkysBp/Mk2tT3gvwhpWg7uPRCcQ6e0kjrU=;
 b=vVFSq7emT/HfCURyOFLzRRQUg9DWn64dEfFMxEUngSghamIFdeHeQEzxr2IGVNON5q
 DTDctx6D4y6veynWUp4lP2D6X1VFL0+KJPIRFES8mwGWdvNoC7c9j8xSz6koKDhiqOv1
 Oro0k1cHOKreOG9SQBtBN5bQi+a9jWnGzrI3tbgAyI5UwJSi8VwHyI0yco8/htv8HwO7
 6aOMrQeJ3Dt7ufCk49oYbeFdQdqG1QhpR6XzFNiPPvxHYU4q6K0Q096Ija1DGa1LzEMc
 ukCiExJFg6iJmxdo23wb02zb37ZgCrgt0/CCJnawrWbmPgUoj/CQa/wtwX+ocsNFeCRr
 N7mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTDKsCbEFgDTAdGbTl4G6IruoH2w1CRUaARFMpZCjbJKL+j/dNB28rfvz7LEqsn19V8KeZZ7M=@lists.denx.de
X-Gm-Message-State: AOJu0YxGI+BqGPM4xzPCVkTBIR0AoQmWEsidQLpkaklyI5F+JQvW/opd
 aNlLRoKeELJssaeKQSurD3o6Z/pAB3eXMFmNxDuv5VNFvW/7GzzLq/91V67gvX4=
X-Google-Smtp-Source: AGHT+IHICrjp4aDVTmHBl2HWN7JhSd7vszBuf0lKs2+xITt5Z/Hy2eT6qfhpebxGFiT+vSYDEIy8VQ==
X-Received: by 2002:a05:6358:d5a5:b0:1c6:99c:2a01 with SMTP id
 e5c5f4694b2df-1c6099c2a0bmr505047155d.3.1730845441069; 
 Tue, 05 Nov 2024 14:24:01 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35415a6d3sm64524336d6.101.2024.11.05.14.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 14:23:59 -0800 (PST)
Date: Tue, 5 Nov 2024 16:23:55 -0600
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
Message-ID: <20241105222355.GN3600562@bill-the-cat>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
 <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
 <20241105154741.GI3600562@bill-the-cat>
 <CAFLszTjntxJShjnWK++NkonNrPdL0S-=zWf-N_AWUaZmfmArtg@mail.gmail.com>
 <20241105182619.GL3600562@bill-the-cat>
 <CAFLszTjf69huO+NMJ2vSvEamgzcxnxA7DhiSk9qmfsRaP8QAvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9Djcwrtd9CpShTfj"
Content-Disposition: inline
In-Reply-To: <CAFLszTjf69huO+NMJ2vSvEamgzcxnxA7DhiSk9qmfsRaP8QAvQ@mail.gmail.com>
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


--9Djcwrtd9CpShTfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 12:03:49PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 5 Nov 2024 at 11:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 05, 2024 at 09:07:17AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 5 Nov 2024 at 08:47, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Nov 05, 2024 at 08:15:25AM -0700, Simon Glass wrote:
> > > > > Hi Peter,
> > > > >
> > > > > On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com=
> wrote:
> > > > > >
> > > > > > On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wro=
te:
> > > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetsk=
iy wrote:
> > > > > > > >
> > > > > > > > > Legacy TCP stack is bad. Here are some of the known issue=
s:
> > > > > > > > >  * tcp packet from other connection can break a current o=
ne
> > > > > > > > >  * tcp send sequence always starts from zero
> > > > > > > > >  * bad tcp options processing
> > > > > > > > >  * strange assumptions on packet size for selective ackno=
wledge
> > > > > > > > >  * tcp interface assumes one of the two scenarios:
> > > > > > > > >      - data downloading from remote host to a board
> > > > > > > > >      - request-response exchange with a small packets
> > > > > > > > >    so it's not possible to upload large amount of data fr=
om the
> > > > > > > > >    board to remote host.
> > > > > > > > >  * wget test generate bad tcp stream, test should fail bu=
t it passes instead
> > > > > > > > >
> > > > > > > > > This series of patches fixes all of the above issues.
> > > > > > > >
> > > > > > > > I know Peter asked on the last one, but I want to ask as we=
ll. With lwIP
> > > > > > > > merged, why do we want to add features to the old stack? I =
can see
> > > > > > > > fixing issues, but not adding new functionality as well. Th=
anks.
> > > > > > > >
> > > > > > >
> > > > > > > Let's apply this. It has tests and the old stack is still use=
d by a
> > > > > > > lot of boards. At present lwip is only used on one. There is =
more work
> > > > > > > to do on the new stack, including finishing off the sandbox
> > > > > > > implementation.
> > > > > >
> > > > > > I agree with applying the fixes pieces, I do not agree with app=
ly the
> > > > > > HTTP server pieces. This series should actually be split into 3
> > > > >
> > > > > But what is your objection?
> > > > >
> > > > > I would much rather just apply it ASAP. It has already gone throu=
gh 12
> > > > > versions, during which lwip has been prepared and applied.
> > > >
> > > > Yes, and to be blunt, the first bit of feedback I provided was "can=
 you
> > > > please look at the lwIP series instead?".
> > > >
> > > > > The HTTP server is a useful feature and we should be able to use =
it to
> > > > > test networking in U-Boot in a more self-contained and performant
> > > > > manner.
> > > >
> > > > I very much do not want to add more features to the legacy TCP stac=
k.
> > > > We're likely, long term, to still need some cut-back version of the=
 old
> > > > stack for the limited SPL cases.
> > >
> > > This series has been in progress for a long time and it seems unfair
> > > to just drop it, with one one board on the new stack.
> >
> > Well, I continue to not say that we should drop the series, but that we
> > should take the fixes and not the new features. Because as far as I can
> > tell, the current TCP stack is in such a shape that it's not
> > production-usable anywhere and so the number of users argument is
> > irrelevant.
>=20
> It's a strange thing as many people use the existing stack. I
> certainly didn't know it had problems and it has always worked fine
> for me. It just seems like an extreme position, to delay a series for
> such a long time, then drop it because a nascent competition thing has
> landed.

We've only had TCP for 2 years (almost, I didn't merge it until Nov 28,
2022). We've only had reliable wget (using TCP) since April of this
year. While much of the legacy network stack is reliable and robust, TCP
is not. And _that_ was the impetus behind suggesting to instead work on
lwIP rather than fixing up the current TCP stack.

> Let's take it as it is, then say that future bug-fixes and
> enhancements need to be based on lwip (perhaps add something to this
> effect to the headers and docs if not already there?). No one loses
> and everyone should be happy. Once people start using lwip they will
> build confidence in it. I will grow in confidence once it supports the
> sandbox tests.

I would be happy to take the *fixes* portion of this series.

And I do owe Mikhail a reply too, I'm just a tad swamped today.

--=20
Tom

--9Djcwrtd9CpShTfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqmvcACgkQFHw5/5Y0
tyw1igwAjQMxlqIyzK0wR+xiks5R5AfkHeTiDDEBnmIsYHTBMfGOPkIkWTDbzJYL
zGdXZbXlpzCffJ6c5U1QTOSg6obezoUNZdpCLfFkCqG8VHQZ6/0HYcAf4LNq2xUl
4v1EColuKScD+pkDHIOkjV0h/zeqz7BoZOBU1hCHxipLO2TSsPar+uzIhWQmbXbb
d8iZeMwQvxeAouFPImf1K9iPd2F0BCAattQwwGYEJBHQdv50zEooK5892jJVvg4l
eqUupnp3o5nWFd8318k2Z06+eIxAsQ9JjSI7uElInx4NhwHgBe5VX6i98u0sgx1e
ASidJ/SAbTAAgXu36/TGSp8zzUu+3wc8FIJiCTUrBwTmF9Asv0Epih0G2hBMivwx
1v1wJCAsxfqni7U3vttphxwrYl84bz9GUctQEXUWiBdOVV8m5E91zHvi8MaN96vm
jICQPO/tS6oS/+D8XSklaNyqppL4d5JgoyhtDnLITWSp3abI/ife/sBBKDiW6SXB
PdPhenBE
=s86B
-----END PGP SIGNATURE-----

--9Djcwrtd9CpShTfj--
