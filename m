Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F4BD0BB46
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 23:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B283892E1;
	Thu, 24 Oct 2024 01:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P1SxCHH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8D08930D; Thu, 24 Oct 2024 01:00:42 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79747892DB
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 01:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbcc2bd7fcso2268446d6.1
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729724437; x=1730329237; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=19crp+nnH/LyOJAlm9kqn8vA5MLISK1h83Y2XL1m/34=;
 b=P1SxCHH/B6mBnYSjR441vuZz18xL+GZAN8vNkfXNoHU4wVumit+if+eferOOc3uhsb
 59j8o9ply0tSBR/uL0AB7bIzezzcnHhORmN0+xnt/ASm7Bp9/Xgj5BrRtmjo5NbEOhdS
 RzP6+pUOkKH6y4lEq5MT5WDWywAX9Yy0V9tYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729724437; x=1730329237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19crp+nnH/LyOJAlm9kqn8vA5MLISK1h83Y2XL1m/34=;
 b=LFWCn5fsHErI2+qsEu5+2xFhVaJFIvCSf9ldvr5NkNzgxEYgUtC2HOvS27O0ya2ATh
 uNGPttQi8g2moVjgLa4KSJSKh2kctUyOxSrDFVuByf0d6ILcnEoWo08yrtVIO7NWPiSI
 UpU8K5uUVOgBH1f6e1poSbASjXiFlC4ZvICVywDC2go87GaCkSjE/rvLDieH+9WnmD5c
 aF5eJIGLEOdSRt7mXzcnlfZ9KsZdTwNoSHxCyIp0UI7dGs1BFIdJFrhPsPfNCA06Ynt4
 l1sgd7Qr37GjC9BhC7hm//HlutP4tb4JPE1rOJLhSgaMbA8YTDTvyOvu8euJzZfGhlnh
 YMlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkhrIH7A62qDpYpfuEaer1gtkrQCV5+DBAWMGfiPnhGk/yIkCK6X4nkJApFR1JdZYGgssIVuc=@lists.denx.de
X-Gm-Message-State: AOJu0YzH1ll32q1TDjs3GIcAjrV+NwqXdp16dWroJSUUYjttnLudnNhN
 HKEf3p9/6LaGhiwyZFXHIYsREIgBvMmU/tFsRUVN0lIbk0LEbUV1892Nmdi+T5Q=
X-Google-Smtp-Source: AGHT+IGbX0oPGCRAQmGLVSABX1uvqrSPQ5PSuDjRtjXMB0DAL1+hwANCkeva+SUrOXAeYEa8YXARdg==
X-Received: by 2002:a05:6214:3d9f:b0:6ce:2f4e:40f1 with SMTP id
 6a1803df08f44-6ce34256662mr64127036d6.26.1729724437218; 
 Wed, 23 Oct 2024 16:00:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0090c360sm43823456d6.57.2024.10.23.16.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 16:00:35 -0700 (PDT)
Date: Wed, 23 Oct 2024 17:00:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: enabling W=1 by default
Message-ID: <20241023230032.GO4959@bill-the-cat>
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
 <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
 <ZxenO05qCbt5IIZS@smile.fi.intel.com>
 <CAFLszTj4pot8tCjesT9-cHewTUMogKMdGj+pSQDHXsnFV3rwUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SwGSwPfnewALSRc0"
Content-Disposition: inline
In-Reply-To: <CAFLszTj4pot8tCjesT9-cHewTUMogKMdGj+pSQDHXsnFV3rwUQ@mail.gmail.com>
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


--SwGSwPfnewALSRc0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 08:13:40PM +0200, Simon Glass wrote:
> Hi Andy,
>=20
> On Tue, 22 Oct 2024 at 15:23, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 06:32:21PM +0200, Simon Glass wrote:
> > > On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > looking at the redness of the output of `make W=3D1` here is the qu=
estion:
> > > > isn't it a good time to enable `make W=3D1` by default. Yes, I unde=
rstand
> > > > the impact, but at least we can do it mandatory for a _new_ code su=
bmitted to
> > > > U-Boot, right?
> > > >
> > > > Ideally I would have what Linux kernel has for a few releases alrea=
dy, i.e.
> > > > Werror by default and getting close to make a clean builds with tha=
t and
> > > > make W=3D1` at least against default configurations (yeah, with U-B=
oot there is
> > > > probably no default, but sandbox one).
> > >
> > > Warnings should be warnings...
> >
> > Yes, and ideally the code should not have warnings, right?
> >
> > Otherwise how can we do better? It's quite similar to what you wrote WRT
> > documenting the function prototypes, the same applies to the new contri=
bution
> > WRT `make W=3D1`.
> >
> > > if you would like to enable it for CI that is fine by me,
> >
> > Yes, that's the idea, but I'm not the owner of any U-Boot CIs,
> > hence it's a proposal.
>=20
> You can still do a patch...but I see we already use 'buildman -E' in
> CI, so perhaps it is already working?

In general, yes, it is.

> > > but the U-Boot makefile shouldn't do it. It defeats the purpose of
> > > having a distinction between errors and warnings.
> >
> > While it's not what I wanted, I disagree on your comment. The idea is t=
o make
> > rules stricter (for new code) to make it better and that's why Linus en=
abled
> > Werror by default in the Linux kernel. And personally I consider that a=
s a good
> > thing to follow.
>=20
> I'll note that coreboot enabled this and it is a right pain. Since
> coreboot always produces copious amounts of pointless output, there is
> then a warning hidden somewhere in the middle and the build then fails
> inexplicably. At least with U-Boot we can use -s and only get messages
> which require user action.

Personally, I find -Werror very helpful when developing code because it
means I either (a) made a mistake or (b) forgot to if-out some code I
didn't intend. This is also personal preference. But I think "make
KCFLAGS=3D-Werror -sj" is great, personally. And I'll re-run without the
-j if I can't see what failed right there.

> But anyway, so long as we have this enabled in CI, we are not
> introducing new warnings. But another point is that we tend to get
> more warnings when moving to a newer toolchain...and devicetree has
> tons of warnings now.

It doesn't matter at this point, but perhaps if device tree warnings
were errors there'd have been motivation these past many years to (a)
resync and (b) fix any number of them. Unfortunately it's like migration
notices and just noise to ignore.

--=20
Tom

--SwGSwPfnewALSRc0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcZgBAACgkQFHw5/5Y0
tyy8cwv+IWfYtahvCKlSLHcNm3AoJwnEZJt6Sc9U4GmMKjTG0/shA1Cep4gDuMGy
qV36vib/VAJRSWQyTu2PUc7bwSwZSn7EdzMEzSszmnEg9qRkADu9mTc3+4yS5w7L
fA8Yns4xfJA3kGaP1+ArQxCJS/JqNAE8UGMdlfrfwngyQILGBufIN20PvY5pbcfh
AAmaNTtu2kz4MT9UQ8cX0GrxxFSw4FsqBP3ALNqIGzwiHgjZlogldJsvho6eaI5J
AWt4sng1r7e85JNToQZELM/ypqPE6QwPJBmzIaBNv68goGGgTLM4fLGKV5erkb8B
h2tXj8ME93uzfrBVoX/1w6JUnEcqJx4VQJSdqYz/POEHlIySPo4zcRDasP6/7AiA
HrRTNMRfckhgltEsQ/xacoavNg6jfxZ45Wnwa7TTN8nyxynHMXFOV4l9em6Eqb5K
SynjaFdis/1s17+07aC1eFPlnU/0KzHQGTpIhOX3Kyl1KkQLbjqX8DQeggopeC/S
rjeTkE7r
=FQFT
-----END PGP SIGNATURE-----

--SwGSwPfnewALSRc0--
