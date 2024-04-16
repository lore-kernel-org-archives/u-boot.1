Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE6CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85C388422;
	Wed, 17 Apr 2024 01:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PK9JFOBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AC18836E; Wed, 17 Apr 2024 01:50:29 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E864588224
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-69b9365e584so2370046d6.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713311425; x=1713916225; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TH56L8mhgS90bIbwb3cXI5qWLT0/jqE4jH8qahnn190=;
 b=PK9JFOBDzuopOl6KqpTWUA5dS1z7NsFbRYnaeng+2x8ldEmV2wBHylU1XQ9Ew47Kvt
 9vb89bLDYlINxcf1dpnxdP42DkXtl1hYOU5B2KxcVNgWc6rIzVy0k0yw0HDqHPKUzsRA
 NVrEeiWqZ4BPJhhXtyXal2WyHDQHE5Fw7BB0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713311425; x=1713916225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TH56L8mhgS90bIbwb3cXI5qWLT0/jqE4jH8qahnn190=;
 b=cQSBoDJ101+WpH562oLh/K+mR/RUSzQGRW2LBmgjcyB5bWvb9phPD+UFN5vHckFmK5
 XZH8kWCfixTNyQ04QKCw74qwCIDmw2eabT86seEDeyov5efHNCqQjagReqlZFJgCXLG1
 B6ms0G1IX94x6fE210xRLkjZBS4skvqvKilXkZ/CFLmVKFJrmBNpJdCCO0JdxNZ7pyOy
 Gx3T+PUdSoDxWmaegVMCGPIZ1TF9ZEh9pVIwVezKQ42XPB7B9QWBSYVKHoQgeMKL2o2G
 VQMkbSgKxn14s8G274ucAfHqmteE748obJmxNwnuhecOHN1jfBK+5Or1b1BGImDQE1Mx
 JBmA==
X-Gm-Message-State: AOJu0YztvMCFCANnNk8QXwwiOe/S6Fo/LhXG5sLeN/Hiik5JGg/epZAB
 ED2MEsEp8C2NF7VpBU+fH5XjqM0rhHYVvutml/a1lMVDjoyv7DJx6TNuLVYDmtw=
X-Google-Smtp-Source: AGHT+IFoQW6W0+q2GThZLGkV+b5KksD3RT11TJqFjeZuu4NNMSDcE3/cBb/wwLlU/GPQ//ZFKRp1Xg==
X-Received: by 2002:a0c:f74d:0:b0:6a0:4420:7ec0 with SMTP id
 e13-20020a0cf74d000000b006a044207ec0mr1583135qvo.15.1713311424814; 
 Tue, 16 Apr 2024 16:50:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 em17-20020ad44f91000000b0069b21f13c52sm7793103qvb.113.2024.04.16.16.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 16:50:24 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:50:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240416235020.GB1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416230133.GZ1054907@bill-the-cat>
 <CAEfUkUKFG4pVR3nHw-GM1Ub2SShnSDgA+zhwTNHY+pSkuaHvXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kt3TT/yrGfWSojus"
Content-Disposition: inline
In-Reply-To: <CAEfUkUKFG4pVR3nHw-GM1Ub2SShnSDgA+zhwTNHY+pSkuaHvXg@mail.gmail.com>
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


--kt3TT/yrGfWSojus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 07:47:44PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 16 Apr 2024 at 19:12, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:
> >
> > [snip]
> > > [1]: bloat-o-meter output between disabling/enabling MbedTLS
> > > ```
> > > add/remove: 231/69 grow/shrink: 12/5 up/down: 60196/-11166 (49030)
> >
> > I don't know if this is qemu_arm64 or sandbox.  With buildman's size
> > comparison functions we see:
> >             qemu_arm64     : all +75537 bss -88 data +24 rodata +6349 t=
ext
> > +69252
> >                u-boot: add: 274/-12, grow: 12/-4 bytes: 72002/-3800 (68=
202)
> > ...
> >             sandbox        : all +57008 bss +32 data +1632 rodata +352
> > text +54992
> >                u-boot: add: 143/-75, grow: 21/-18 bytes: 64058/-16523
> > (47535)
> >
> > So please look in to using buildman to get more details about what's
> > changing, size-wise. Also, my goodness, that's far too much growth, and
> > we aren't removing anything? This needs to be a whole switch, not just
> > an addition. And then look in to what we can tweak / remove. Are we
> > perhaps not getting our usual link time garbage collection done?
> >
> As stated in the cover letter, with this patch set, we still build the
> original libs
> (lib/rsa, lib/asn1_decoder.c, lib/crypto/rsa_helper.c, lib/md5.c,
> lib/sha1.c,
> lib/sha256.c, lib/sha512.c) for the components outside of EFI loader.
> Eventually all these will be completely switched and removed.
> But I think we should do this in a sparated patch set - It is too big for
> one
> patch set.
> So, as the first patch set, this one will introduce MbedTLS and enable it
> with
> EFI loader, after they are merged, the next patch set will switch other
> components
> to use MbedTLS and remove the original libs.
> What are your thoughts?

My thoughts are that we need to implement this as the optional
replacement for the existing libraries. We already have abstractions for
most if not all of the algorithms I believe. And we need to be able to
see how much size growth we get from this change because long term we
don't really want to have two sets of libraries for this functionality
(as a SW rather than HW implementation).

--=20
Tom

--kt3TT/yrGfWSojus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYfDrkACgkQFHw5/5Y0
tyy8Wwv/a0q/hiyh38wS1ArS1Rm93QNgDTB8yGWmdMZgF5BLyyQFq7/LKmgwjDqd
CooQ/ydjqEmtlnf1wK1R4ifNk7UVFK94RgCosyB0h7yzdMCUNSNEz4xsR9FKn3Ak
yMqhDs8UJ8hUvZ8XvAvE8xlSkosT/G2DtNLJL8zXWgwQ7R6IgOxP6j6SFrQTiXEx
3rd3+Q7ZqshhnxMWLjoLYbX2QVurJ3rnnxLLBIb4Icg083WnDScBjpwY9M1BhCHq
owk7djj2y4MBpPdQSOKo0kC64bvmXbMTqUxJOGpZbyM5gImVkHXdvMjVNYqpp/UK
IzSanIH6rRAPQT2lVLvTv4vCgank2wW3R9Nwe6ZrkRe0q0zunP9p+MUEHNkYDFJy
OidXa139VjvmcGwrPpqO3u2uxyNnaJogIHR7cXZpg3VkpzJU1DubVNJa2hMZI2Y3
Mkd/3/UAWhA8k9Jy0y7BN/1eEeORX56kEcuDnWSIlMCjzvsezlRi7CVhFGmw24vJ
gm/7GyE8
=Zu2m
-----END PGP SIGNATURE-----

--kt3TT/yrGfWSojus--
