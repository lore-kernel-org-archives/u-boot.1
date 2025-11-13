Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8832CCD98D0
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 20:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78F18403D;
	Thu, 13 Nov 2025 21:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eUXGghLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E068403E; Thu, 13 Nov 2025 21:05:34 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B69C88401F
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 21:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3e84d56c4b8so694891fac.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763064330; x=1763669130; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d063462o8pUb2tL0dWExn9MsEfjKqXYH7nrdhe1i7vw=;
 b=eUXGghLgc0GY0SXZH2skQizartiMesoENMtpChvHktrJXomMO5p4pLuwZ1sreV5JXQ
 oIeZyJE19BNQFk/2iHdzzg7EGGt2/E/7XPtk5zAn7Vp/lBWVs1275N32zPxCfiTrPaup
 CiiYa5EoDBI0flckC16Fo0rLSN5w0uOV+qx5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763064330; x=1763669130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d063462o8pUb2tL0dWExn9MsEfjKqXYH7nrdhe1i7vw=;
 b=FCPqzPj7ijFJd/a8v70Jttl1Wjz05vdBxfzLtXbUqgya2+fEd8DObbaCIKTdfOVx1a
 XGjptse82qBxRgZ3Q/DRYx8SvwpYW2H8y5rYrCdARlfWvVr7BMMEOxZWjkn/wsp19rdk
 BjWT1AX6/lPjpv1YkO22hdYO0UEClNrTomTUYp/k/qznKYfhCWVocwgl6Lxp1CoqHuvV
 4dYrQUzl6ygBs+4FxiTBKpS3T97qQtOnUUavCC7WV2dhkjZOYmJ4NjybEZa+TYJ+1rWX
 GfeyVM3zXJSzaZvHOwVR0O1X2ez3Kn57E5rHudTgKJcT2PeISvXtDmtxMkJaDx0ynDro
 kEsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTzQsNwAd0vHHQKT6XBNgVlHVxT2Wr2HO4zNSFeq7mnf7jCNldPOqksVpilfqd0rCQH/Jqq9E=@lists.denx.de
X-Gm-Message-State: AOJu0YyRzClaUHgFLcDAA3fIHEGfN11q34cSoA+RQSjsuzQCGPq5wELK
 vlCXylbxRQYiy3Js4Xv2Gowkf5m86N4jA/JXeFg440xWEvojm5XluxIDn9Rk4J/rptI=
X-Gm-Gg: ASbGncuHlkJG5tdd2+I2qfKXCLsBheBx4AvDPmBeeXrH8bFWUTQQzrw+cdydXtEyI9i
 EVjyZ6gXzR/vL3XcGsdSz1BhgWZSoPlQEorv6rYgB+4Gr1pBUrSHlaeelYUxYUvtXT1wwxVzIMr
 57cMaw7LcbkjCjYRY9+B9+lmaqUQ/TV69qW30mOpQNQ6qdbN5pLYkgh2POQC2yz9UVqji8uNzyQ
 nStGIdOTv9IfbcUXir52pneaBUwacuiy8lYDfHZFoOo6Y1MKCLwnSVJnRvtPA5nSqeF1OtXe0CH
 qGBpuZV+CIGRhkuOOV8+QZb6tyf7Menqvg6Mo/Kfpg3rsUL6RG5+ZlVI5ie0Lc4JYiUKkmbr3Pn
 He6tsfQmQfPTS7M+CeW5+gfBjdJVLk8let277OPwTup7x7PimhOHbhQUMzYBsANriccQC872tfj
 XdopwVFbWGsiUHEVMuc8uf6xkOn8at8CX36qyE+RY=
X-Google-Smtp-Source: AGHT+IH6HzyU3pwbnHE1EjT1sv+sMtckjbe1g4NRWA4tTjO2538MEcp7Ow3Go8ZPCoDcBuODypMQwg==
X-Received: by 2002:a05:6870:206:b0:3d4:5e0e:c8c6 with SMTP id
 586e51a60fabf-3e868ea22b4mr481524fac.10.1763064330316; 
 Thu, 13 Nov 2025 12:05:30 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ffc60dsm2012669fac.4.2025.11.13.12.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 12:05:29 -0800 (PST)
Date: Thu, 13 Nov 2025 14:05:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
Message-ID: <20251113200527.GQ6688@bill-the-cat>
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ttV1wYrS1UZnwY5S"
Content-Disposition: inline
In-Reply-To: <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
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


--ttV1wYrS1UZnwY5S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:57:30PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 13 Nov 2025 at 12:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Nov 13, 2025 at 12:33:24PM -0700, Simon Glass wrote:
> > > Hi Marek,
> > >
> > > On Tue, 11 Nov 2025 at 18:17, Marek Vasut
> > > <marek.vasut+renesas@mailbox.org> wrote:
> > > >
> > > > Newer versions of libfdt strictly check whether the FDT blob
> > > > passed to them is at 8-byte aligned offset, if it is not, then
> > > > the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
> > > > android_image_print_dtb_contents() passed FDT directly mapped
> > > > from abootimg to libfdt, and this FDT is not always aligned to
> > > > 8-byte offset. Specifically, the FDTs are somewhat packed in
> > > > the abootimg, therefore if the first FDT blob is e.g. 0xfd bytes
> > > > long, then the next FDT blob ends up at 0xfd offset, which is
> > > > not 8-byte aligned.
> > > >
> > > > Fix this by first extracting the header into 8-byte aligned buffer,
> > > > checking only the header for validity, and then by copying the
> > > > entire FDT into newly allocated 8-byte aligned buffer. While this
> > > > is not efficient, it is the correct way to handle DTs, which must
> > > > be at 8-byte aligned offsets. Mitigate the inefficiency for the
> > > > common case by checking whether the DT might be 8-byte aligned and
> > > > if it is, map it directly.
> > > >
> > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > ---
> > > > Cc: Aaron Kling <webgeek1234@gmail.com>
> > > > Cc: Eddie Kovsky <ekovsky@redhat.com>
> > > > Cc: George Chan <gchan9527@gmail.com>
> > > > Cc: Julien Masson <jmasson@baylibre.com>
> > > > Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> > > > Cc: Nicolas Belin <nbelin@baylibre.com>
> > > > Cc: Sam Day <me@samcday.com>
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > Cc: u-boot@lists.denx.de
> > > > ---
> > > >  boot/image-android.c | 46 +++++++++++++++++++++++++++++++++-------=
----
> > > >  1 file changed, 35 insertions(+), 11 deletions(-)
> > > >
> > >
> > > OK, we need to adjust mkimage etc. to handle this. Until then I think
> > > we should have a way to disable the 8-byte-alignment check as it seems
> > > to have an enormous blast radius :-)
> >
> > We can't. We really can't. Passing misaligned device trees results in,
> > and has already resulted in for years:
> > - Silent Linux crashes
> > - When Linux doesn't crash so many of the read functions go wrong the
> >   result is incomprehensible.
> >
> > It's something that has and continues to waste untold engineering time.
> > The only reason it's not worse is that we've killed off *most* of the
> > platforms that disabled device tree relocation and that's how
> > misalignment happens downstream most often.
>=20
> That's fine, but making the devicetree aligned for Linux is pretty
> simple. We generally relocate it before booting anyway.
>=20
> But that's not what I'm seeing here. It seems to be updating U-Boot to
> deal with a libfdt change. That is also a worthy goal, but we need to
> consider code size and where best in the stack the changes should be
> made. Doing a memalign() at the last minute is just not a good idea.

Yes, the device tree specification, not the OS, says that it must be 8
byte aligned. We've needed to do that for ages. Not doing that is not a
good thing, for U-Boot, internally. The same APIs that blow up in Linux
(or anything else) with misaligned device trees will blow up in us too.
We need to make sure we pass ourselves something aligned correctly.

Which is different from disagreeing with your specific feedback about
how we get there, to be clear.

--=20
Tom

--ttV1wYrS1UZnwY5S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRY6BAAKCRAr4qD1Cr/k
CmAQAPsH4JcgbUk9hk9LITP6cbStxaTlolmJqDLgzTNLf1+QkwD+L2rvuFfVAHAO
C+XYTbf7oSodyvGbbUdqQTzQxTl/Ogc=
=p8iM
-----END PGP SIGNATURE-----

--ttV1wYrS1UZnwY5S--
