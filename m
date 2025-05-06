Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21553C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B838210D;
	Tue,  6 May 2025 18:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="po8HhTw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC868214B; Tue,  6 May 2025 18:32:36 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BDB381FAB
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3f6a92f234dso4226998b6e.3
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746549153; x=1747153953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u5ywPw2Eufz1v/eYd7jDfD4tVbq8vmtHuXscACdErr0=;
 b=po8HhTw5/IzNrQxXHQOPu082EVCUTM/UOnt8CFIsY2una1rtTiaFxq9WCMUmhsoPbp
 wpt9qvVTxcaXmk+TnfvzVipmuQjm+cUOjcR/cTdODy4/C+NzuZzjWIMBHiAZgrhz8Tt8
 V1VuEcOU2MkS53ccYIDI1m0tXUdKgd8adR9js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746549153; x=1747153953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5ywPw2Eufz1v/eYd7jDfD4tVbq8vmtHuXscACdErr0=;
 b=vG5520fs9wUtN3SB+DLruX3ZyKrIhC5pf8HNsb4No1Iuk/XDjaRKgefcMTl6CsKMhs
 qZqWXusVns+0j7YG0No7jbxXJP5Xo6TVVL2nm76lUhfor60zao4Aj+lBarqN+iiiaCpv
 NSvETguZSAiAH5USM+s4wWJxdg9QsRrvmxFMpmAl4EVLyb4UsEOm/4BVb/xI6J0OcyZz
 o4v1nD41CezN95rB1HCiU6ex6YFO0d+LCmSY0euDUhIfdifx3tySvwGX4dt7E4+jRTSO
 G6KjAREhc0O3y9178GKPsCYwcjibvemajfkaeGnCzMwygxmIxQsmsWonf+MitYQ6kAYg
 Tk9w==
X-Gm-Message-State: AOJu0YxSLgH7Ed3a9PinFupAsBmtVH1OvhTelY2UDXQ6HfZJsxKkSr5T
 OFh0jh91K0HRCnNPh0fIqXgxxGc//qI6AWvirc5I1/j5jqKh8OCBMS9TUSvZwzQ=
X-Gm-Gg: ASbGncvJhDI2wxxHiRY+8e5oO5nVRItAJZorf9VTrp0eIihNgkCJ0wKBqMZnMxyaiuB
 d/QXfzpwRcqSqTlp9hVl1ZffrJFxDSFL5SkdcIUYeUCIbRUE7CCKncHNlSd/+2ZfbrPKmIVzr3X
 CH6lDKRJQfawycsY7YGU3c/WpZhtTHlc91Usmoxwu999JwVEcGP3UVTmIiB5o9Gff2z2YA48ya/
 q4XTe+qNHTF5uNcqub97zW+J9quLtjL3pGcfbNed71SZ+8hNUCFO4S/YO4CabUMZFCoCmBBf3cR
 x71MVH/hDHcQbWD9FTeH6sBBKEPq6bmzMljedDfjJZEpAForv24MebiuuVtHE4nkKjQBu81igFt
 0A30UiA1e7M+M
X-Google-Smtp-Source: AGHT+IF7JC0TG+wwSRbQD0srtW+uxC83yUD8fEYypwh4dybiKuxslFb7xsrnjSOw5QvsJCLtTkyNaA==
X-Received: by 2002:a05:6871:78e:b0:2c2:d749:82d3 with SMTP id
 586e51a60fabf-2db595ef63emr227049fac.27.1746549152683; 
 Tue, 06 May 2025 09:32:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033d9c2299sm2554360b6e.18.2025.05.06.09.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:32:31 -0700 (PDT)
Date: Tue, 6 May 2025 10:32:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
Message-ID: <20250506163229.GY5430@bill-the-cat>
References: <20250501131858.2160756-1-sjg@chromium.org>
 <20250505181421.GI5430@bill-the-cat>
 <CAFLszTgp0Y-yJVwE_ZBKKOXrqra6nRZqE-phPgQhA9Et99qcDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gVbNR1G18POO//Nt"
Content-Disposition: inline
In-Reply-To: <CAFLszTgp0Y-yJVwE_ZBKKOXrqra6nRZqE-phPgQhA9Et99qcDg@mail.gmail.com>
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


--gVbNR1G18POO//Nt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 03:24:21PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 5 May 2025 at 20:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 01, 2025 at 07:18:32AM -0600, Simon Glass wrote:
> >
> > > This series restores the original behaviour of extlinux booting linux
> > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead us=
es
> > > a limit of 10x the compressed size.
> > >
> > > It also adds RISC-V support, since it uses a similar format to ARM64.
> > >
> > > Future work should integrate the code in 'booti' into main 'bootm'
> > > logic.
> >
> > I don't like "in the future we'll remove duplicated code".
>=20
> Small series, fixes a problem, can be made larger but then it isn't a bug=
-fix.

Which is why yes, this should have been instead of the however-many-part
"PXE" series, and then fixups on top, a series to address this problem.
Then other series to address other problems.

> > I also don't
> > like not seeing that what we really need to do, in all cases (not just
> > booti) handle decompression like we do for FIT images, and ask LMB to
> > give us a space to use.
>=20
> See bootm_load_os() which does already do this.

Yes, that's what I was asking you to look at. I assume you're even
specifically pointing to commit 69544c4fd8b1 ("bootm: Support
kernel_noload with compression") which you and I did together.

> > A problem is that CONFIG_SYS_BOOTM_LEN was never
> > intended to be the limit on *decompression* as it's the limit on what
> > we're loading to memory from disk. That's what getting me unhappy with
> > this part of the series.
>=20
> From what I can tell, that was introduced 11 years ago by this commit:
>=20
> 081cc197472 (HEAD) bootm: Export bootm_decomp_image()
>=20
> I suppose the idea is that BOOTM is supposed to be a limit on the
> image being loaded, so it is compressed, then the limit needs to apply
> to the size of the uncompressed image, to maintain parity. Otherwise
> there would be no limit at all, since it is pretty easy to devise an
> 100-byte image which expands to fill all available memory.
>=20
> Using 10x the uncompressed size doesn't fill me with the joys of spring, =
TBH.

Yes, it's a matter of heuristics, and also why we have things like lmb
to check and make sure we don't overwrite ourselves. I do not recall if
the 10x used there, or the 4x we used for kernel_noload FIT
decompression, was based on checking what the compression factor the
available algorithms get on typical kernel images or not. That would be
another improvement area, sure.

--=20
Tom

--gVbNR1G18POO//Nt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaOZ0ACgkQFHw5/5Y0
tyzBwAwAlqzD5t64wTqLhxhaTjuzkQ/kqEaBKgveZz8AJILi+0K8HPyjSHkWwg/0
lTpLYlatClpNYcYCZm41yEaPx+R+6xUDibkjmaLkNCeG3Utg15Aji9kKp4oLjPjE
S81xwj1AolttbGHD9rpIbUt3PYwhKZFIgjHD0VmlP0aQRjtQEweMnMy7iAYk8ydv
n/K7aDlpZUdVKud7a5cHniigkqvbAo5j8vYp37l0FIqPl9T1J3t4L+0eNkwnE8q1
Pag7cDxOoMBf9uf8J02kj2Qgy8dkAeS0brwFY4sfbbSODzvlZhjKk5rSoFNq/d5h
QymmcvvJba/jyokLJ2WQPq9SSCYq765NdkeA7ATSgIorHjGgpR03fV4CYYVKHfVV
x/RTV/XOE7si0DHmYwtOQvvU3xT6gXaaI58Fpf3Q/CL1uK1HQVAiLBDzc1V4OIE2
IVsTB3mKhTnnVlqBZJbwIRDdes5no71kWIhqmB/0CVnPGylqxwxIlwJyOS/MKemf
DWkuUW2J
=JUt0
-----END PGP SIGNATURE-----

--gVbNR1G18POO//Nt--
