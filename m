Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D941104891D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 23:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8540C83CDF;
	Sat, 28 Feb 2026 00:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jVZ1IFKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3399F83E81; Sat, 28 Feb 2026 00:42:22 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A0083A1B
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 00:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d19bfe1190so2015381a34.1
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 15:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772235738; x=1772840538; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V0xgGrSQtmr2pIwSXaA/TT+Kc7vnFKND49nhWRtLVUY=;
 b=jVZ1IFKtvgoUpwn0aTuQ3pxLJNOrGwg35ucbbpMlQ7Syrrk0MAI39/v2qURfYBMAHb
 Bp+ucM5dXnfumq9JToYhfIRUFD/9ovKmxPghKAGbEcyPg6mYaLddCniqDWjiknEhpZ8X
 osjM9bTEF4F5sFm36nEgHyLbkXwWHaMCWK3Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772235738; x=1772840538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0xgGrSQtmr2pIwSXaA/TT+Kc7vnFKND49nhWRtLVUY=;
 b=I1eARGSNKgpvIRqOag7Up/dl7smx76j/h7lE9HvrNCPPE8N67SD+4o8y4UwTFXT1TC
 ovJfN3I/baTKDw0HRylePoRlIlXeX2/X7jYY6qe+TKMzf7RQkky14OR1jOV5nwxZsYe8
 p5/jmZRjMcaMyzruu+1Onk3XX6QNrM1dZXjs/8WAh9fR5QHXmDVuCgmsHBLK8ikZjtH3
 3IG+JRoLCo2hGydq1e8JgRPd5jcEcT+f8QQHmiCSUS2leuitxpbQVQrxBmEe5LEMuEAa
 D246bMhOyLGyysVLlHgwTDAJnn+GnpWP4Z/Ggyq+3GnXuY6Taruz8pk0UkQVxtrW4mZ+
 oc6w==
X-Gm-Message-State: AOJu0YzfXZ5AwPpmLPbrUYTeE9mSGFKijq2rx9DutqkYfbNb3owt2g8E
 pxX2+17hlxKacmm7myF/DYuR99T1wmwuO599zVM2z6OuQcRc0x76pz5p/6da/HX+FYc=
X-Gm-Gg: ATEYQzxZJZER4vQ/lNH8u1wHgHFHVBpB7yn+J59Qp52sd33Nwq3/7HgzW3WEw49Z5z1
 pfBghf2HJwqrFJBwT6LE/NgkJ4yPTIxTnkZlUEPnzRAPtoD5rWxAcQWbs4wxUO+CF9Xs7tFFvf7
 a9m8sKF5jNybPOKZIPf4fKBWrej9bdqDNRrRDzYbCKn9AP9CgcBATjrCtJZAaxo5hgN2L+4RzTG
 NGsYm78CnYJ8u0EQFmuy1rgbMxek0N4VnTSc4UXS05oFrctJsCoqNZP91Ey5mu++A8RiXI9g2Fr
 wve+Wv9Fp/AE2HYY3QHHwqs9zPAQXakFT8G2zl94S51S34E9aQjWcLr8x4JnVsiolkr6IXokzci
 CownG/NPRmM/Qb+WBPuY3q7JxNnUwGclTJMWbYVSu7Jwwk5yPdgcxx5jBaWVtsFNWmY18CNEWn5
 +bKxDH+VC8xJm3D2ernXmB0Mt77Zja6MiVGEzIm55sHMHGDWxWtP3GoNhTEniXPXtEpyad/syh3
 dpLmXCQFjQ4zAQReffJDxMnj06HiTxCReOYxls+59aG6AWdUac=
X-Received: by 2002:a05:6830:6581:b0:7d1:49a9:6b53 with SMTP id
 46e09a7af769-7d591bf8f07mr3372648a34.33.1772235738213; 
 Fri, 27 Feb 2026 15:42:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644dd17sm5257754a34.5.2026.02.27.15.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 15:42:17 -0800 (PST)
Date: Fri, 27 Feb 2026 17:42:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 5/6] test: Add a helper class to create disk images
Message-ID: <20260227234215.GB1593142@bill-the-cat>
References: <20260225162357.3449937-1-sjg@chromium.org>
 <20260225162357.3449937-6-sjg@chromium.org>
 <20260225171256.GR1593142@bill-the-cat>
 <CAFLszTjvQFS1BGU8QFA-Q8jiqac8jQj28_u6P=dKTo6xTrKFiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wTJ+aNofBJNh24ef"
Content-Disposition: inline
In-Reply-To: <CAFLszTjvQFS1BGU8QFA-Q8jiqac8jQj28_u6P=dKTo6xTrKFiQ@mail.gmail.com>
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


--wTJ+aNofBJNh24ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 03:14:38PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 25 Feb 2026 at 10:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 25, 2026 at 09:23:49AM -0700, Simon Glass wrote:
> >
> > > From: Simon Glass <simon.glass@canonical.com>
> > >
> > > Provide a way to create disk images which consist of multiple filesys=
tem
> > > images.
> > >
> > > Provide an option to use the current directory for images, instead of
> > > persistent-data directory. This makes it easy for C tests to locate t=
he
> > > image.
> > >
> > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > ---
> > >
> > >  test/py/tests/fs_helper.py | 97 ++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 97 insertions(+)
> >
> > It seems wrong to ignore the existing function to create disk images.
>=20
> Can we do this in steps? I have a pending series to rework the test
> images (and move them to the persistent dir) but it is at least 10
> patches, so I figured I should start with this.

Yes, as doing this in steps you should convert the existing disk image
part to be available too via the class and not construct a new one. And
I want to say that given what you said on the call about more generic
imagre creation I'm wary about this "cleanup" leading to something odd
being built on top of it.

--=20
Tom

--wTJ+aNofBJNh24ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaIr1AAKCRAr4qD1Cr/k
Cnj3AP4r2I6jzFPDBtGqpPnS1fl4XxBATwtVGnVPf3w+xvUQfwD/fBw6M1jVh7uP
6YGQl9qcJdEDG2yhITYvF8+d6iqIvAY=
=n2N9
-----END PGP SIGNATURE-----

--wTJ+aNofBJNh24ef--
