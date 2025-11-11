Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D9FCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 14:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3BD83B97;
	Tue, 11 Nov 2025 15:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D1diu+m0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F5883B97; Tue, 11 Nov 2025 15:43:15 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BAD83B95
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 15:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c71cca8fc2so818259a34.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762872191; x=1763476991; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s2AnFKJpOsmeH4C0HLp9g7jzvDkOZQneTd2y4X/g7qQ=;
 b=D1diu+m0weCIeJzZ2C35NSvpsFg4AZzC73gzsvCGZE03KGuvbtYOZpGceIHjZSkRPm
 Opo6sUJIff9lDtrukX1+j3cN0Cy1TYpQpdpOVdNwNYeWbapOXddfrN1AvKOKCoMO17YQ
 dKo2NUtbI6Z3yxI+aC66AHhTO0W4+0cW9oGCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762872191; x=1763476991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2AnFKJpOsmeH4C0HLp9g7jzvDkOZQneTd2y4X/g7qQ=;
 b=LO3CMXuSnPANl9uEQOjYOzOC2zNv+tBnMacBYJbNWTWkpPUuC2Jms2kL0F2uRgpmes
 NjAc+a1Wzaalsgkxl/usaYfR/4MOZZSHK9Lp5MUd3ZzGv+gIZ54uCq0Q0/VOTBa5Yt6z
 LxK2+LXijdGh0UC9xDy/ncQPyidnXtGfwpd4McUkHu15zVBBNClcnoYdpmYsHcyT/gqN
 aLWTsWbyAg2wKFU9hrn+cotSJ3aGBrt6WY6Eut0kOkzfM7SGi1jggdVCNasU8CNQEOO/
 SYNl4r371cVULD+vwwDJgfQoz7TnClkwnVnykv9qGZRu6te0aTnWHYiuH8cFUf70fRKl
 Ex8A==
X-Gm-Message-State: AOJu0Yz0cpu23PQ4SNXuVw5oc7BduEikuscSvXl8BdWkWm64CBhO3KtP
 JQEYHsJFTGxRJq9Q13rHBn1o1/WLZvFQer88cXYzCz/nR7jz2IiIaBQsqvXkMkCRfdo=
X-Gm-Gg: ASbGncuwoWJlz4AJi1Ni0v1NZlCeifpII+cidS25cU+aOCFH1REyVdLYSWfNXkn5TZx
 o6xeMEJaa0Ll0519pgl9vpfTIbJabbk/NitPzJQFH1q9nLxuwsfhBGZnZjV4kwP5vC2KGfUHl0w
 iiEvi6cTPg0D8gyZ/nnHwFHHdmRTlD43CTXMlivim0LH1iQXnTnH86jMDzmTanOSxQaMbPjsLeF
 WlXIlxR/TiOWLOLmfw/rNry/Zc5w/kg9jo+4d28/OfaizmB4ioERAekIt/HnnhsLqF5550n/vdR
 KokQJvx8X7EjjM/dlOwA42n2QuUlreGO9/NOkRy3FcW6d9+J7d3FGunevlD+FkaRhsAIbmw3EvR
 ESl3I1vSeubuq5u3uws6LhXk5tfPQCOjK0q+Vt857OgbSe000aMyiRHT0Kd+pc9BuQlFyWGQ+Xt
 7zuuIC/88L5DUXya4hAtxw4P384AFXqqUYidVzsx3FT8TvRkhPYg==
X-Google-Smtp-Source: AGHT+IGRtBKtexYMVQiaAMf4GOcY0YsVz1tkNxXkjYxesRP9sFcstLkAMdwGr5ODa5mK6wOCIEbf9g==
X-Received: by 2002:a05:6808:180e:b0:450:13d3:fccc with SMTP id
 5614622812f47-4502a321df8mr7003798b6e.12.1762872191476; 
 Tue, 11 Nov 2025 06:43:11 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4500275053bsm6913064b6e.12.2025.11.11.06.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 06:43:10 -0800 (PST)
Date: Tue, 11 Nov 2025 08:43:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 0/2] Fix AArch32 compilation with Clang
Message-ID: <20251111144308.GW6688@bill-the-cat>
References: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
 <176246626861.3129497.14948596131312532180.b4-ty@konsulko.com>
 <20251106221355.GZ6688@bill-the-cat>
 <CAChbrCYcFua=B9ZaS8_tbzugUh6MyLMJo3T9tEDZhA-Y6zdsOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rekqnKCHm4yov3I9"
Content-Disposition: inline
In-Reply-To: <CAChbrCYcFua=B9ZaS8_tbzugUh6MyLMJo3T9tEDZhA-Y6zdsOA@mail.gmail.com>
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


--rekqnKCHm4yov3I9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 09:55:00PM +0100, Dmitrii Sharshakov wrote:
> Thank you for your reply.
>=20
> Please review a fix for the aforementioned issue[1] and let me know
> whether this enables your
> local and CI builds with Clang!

That fixed what I ran in to, thanks!

>=20
> Thank you!
>=20
> Best regards,
> Dmitrii
>=20
> [1] https://lore.kernel.org/u-boot/20251108-clang-cross-fixes-v1-1-ea6c42=
82844a@gmail.com/
>=20
>=20
> On Thu, Nov 6, 2025 at 11:13=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Nov 06, 2025 at 03:57:48PM -0600, Tom Rini wrote:
> >
> > > On Sat, 01 Nov 2025 10:39:57 +0100, Dmitrii Sharshakov wrote:
> > >
> > > > I faced some minor compatibility issues when choosing Clang as the =
cross-compiler for my target.
> > > >
> > > > Please review these two fixes, aiming at enabling Clang-based build=
s (still using GNU binutils)
> > > > for 32-bit ARM targets.
> > > >
> > > > Tested to fix build with (also run-tested on qemu arm and arm64 wit=
h clang):
> > > >
> > > > [...]
> > >
> > > Applied to u-boot/master, thanks!
> > >
> > > [1/2] arch: arm: build: only set -mgeneral-regs-only for AArch64
> > >       commit: e8e3b38def93b5e5d53569961237ce215454e141
> > > [2/2] build: fix building u-boot.lds with Clang as a cross-compiler
> > >       commit: f7d177395d73f7747373dfd0ef7329834788106e
> >
> > So, I can replicate your success if I do:
> > $ export PATH=3D${PATH}:/opt/gcc-14.2.0-nolibc/aarch64-linux/bin
> > $ make O=3D/tmp/rpi4 CROSS_COMPILE=3Daarch64-linux- CC=3Dclang-18 HOSTC=
C=3Dclang-18 rpi_4_config all
> >
> > But if I instead use CROSS_COMPILE=3D/opt/gcc-.../bin/aarch64-linux-
> > instead we get /usr/bin/as being used and fail. Any ideas where perhaps
> > CROSS_COMPILE isn't being trimmed correctly and passed to clang maybe?
> > Thanks!
> >
> > --
> > Tom

--=20
Tom

--rekqnKCHm4yov3I9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRNLfAAKCRAr4qD1Cr/k
Cs4pAP9jIMqC9GrMRX4IDNyFZGe+PGxlgWn88Uaik9JyMDzAIQD/f8uHxn9FF6LX
B0ZpF5I7afXrjU6isqqyspLvsi9VuwE=
=g+7K
-----END PGP SIGNATURE-----

--rekqnKCHm4yov3I9--
