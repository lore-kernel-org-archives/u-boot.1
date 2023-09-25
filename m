Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736F7CE7AB9
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 18:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE1FA86A94;
	Mon, 25 Sep 2023 20:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mlhrJ2nG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C71486AF7; Mon, 25 Sep 2023 20:19:46 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC7886A50
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 20:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d89491dab33so1310151276.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695665982; x=1696270782; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d5VR0fohfPx5tCpVs46mi/R0e+XpRwWRYJdF3tTTpCA=;
 b=mlhrJ2nGh+Ix7iR4bGvmiYIbsGzdGRa/Q+ErgOkeaV1cOCbXW0ps9r0PvaVP4e3Kj4
 H7O7DRc4aO8n4XrKn/YYTz+/uWFhQGRT7523ayT2/7axaJcVL5Ooqbx+DTQv+L79IkUs
 VrVcH/+11unJVdkW89hUt/sfhCiihVx8Ksavk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695665982; x=1696270782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5VR0fohfPx5tCpVs46mi/R0e+XpRwWRYJdF3tTTpCA=;
 b=GPWPWBBmaFOdZ8Q/l6X4KXzWaHXkX9S0IEOtDJD7Aec/Xt2gjbkRAvZ05QmjClsYD8
 looBnyCLkB6ebjWz9vQUC+mBewYdIFqCIS1bnHvwVzBJNXbc+Xnd5mIaeh/AN/J/1mhr
 XBgASXGD+o0hqeBaCghHNHguqzCXBhNRKC4QPwhtKV98Q0OL3U8woGnay5goEAmsR9Kv
 Pxw+piS7E4fXGOc15/uTeFZ0Q+2gu+wwnh4P5tSt7aBXs2Se7CkfPhZ9n96/hVF+q1XT
 szUbPJwEvXVp8c8T+4PvuB0mqxjjKCJj0aB/bSrC1dzNQ6cY/S1r1oMXD2Cfn5HbkBIY
 bOWg==
X-Gm-Message-State: AOJu0YwG+mBshvc9ViYXOljK2UJrFn8eDmoDioXmAkB6PS7r/frlTl99
 mW6kHGZ3o4NV1ulvDQI98gnZ4w==
X-Google-Smtp-Source: AGHT+IG9Gzouy+XboxiREa440RQKCIja66d1wmvMmsmvRqmfyO2Ys3WojQfmjfeXzDXgCXzmfqsCMA==
X-Received: by 2002:a25:cacd:0:b0:d12:ab1:d88a with SMTP id
 a196-20020a25cacd000000b00d120ab1d88amr7767265ybg.40.1695665982636; 
 Mon, 25 Sep 2023 11:19:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 j134-20020a25238c000000b00c64533e4e20sm2333775ybj.33.2023.09.25.11.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:19:42 -0700 (PDT)
Date: Mon, 25 Sep 2023 14:19:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
Message-ID: <20230925181940.GH305624@bill-the-cat>
References: <9658c219-1de8-3bdf-3beb-0c1e2a128569@prevas.dk>
 <20230425200932.GM1134230@bill-the-cat>
 <c3c94614-9916-7316-e009-04ddbdc205bc@prevas.dk>
 <20230427162100.GE1134230@bill-the-cat>
 <20230427173113.GG1134230@bill-the-cat>
 <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XOn40xIhvbYYoQNS"
Content-Disposition: inline
In-Reply-To: <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
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


--XOn40xIhvbYYoQNS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wrote:
> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> > On 03/05/2023 16.54, Tom Rini wrote:
>=20
> >> The one last problem now is on stm32mp15_dhcor_basic which is a
> >> defconfig missing one from OF_LIST but including it in the its file, so
> >> the above is the patch we need.
> >>
> >=20
> > Hm, well, for now I think at least all .dtbo targets need to be left in
> > the Makefiles, since nothing in the defconfig tells us to build those.
>=20
> Hi Tom
>=20
> Can I persuade you to try something like
> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a1076f9cab=
0005f400fa072
> again, but leaving the .dtbo targets in there?
>=20
> I could send a patch, but it's entirely mechanical, and not really meant
> for being applied until we know if there's more to be cleaned up.

So what ended up being the problem I think is the case Simon pointed out
where we do take the output from "make all" and concatenate one of the
dtbs that was generated with u-boot.img or so, and it works.  But maybe
that should just list all of the valid DTBs that it needs in the
defconfig to start with? I don't quite know, it was a case I hadn't
considered at the time.

--=20
Tom

--XOn40xIhvbYYoQNS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURzzkACgkQFHw5/5Y0
tyy7Swv/YxgkqZHkBBuUj22YRyJFZKPRUOhT2Ata6VGk5mwYN8gMyiiKumTDxzPP
jPlsAhtCAE72zwMl6KQgsn9Pz2xmUeiQ1QWwiI5b9hTci31r+gBd38783yzD17TK
PAzEFHKsMFqqWfjaFza1JjgrepmcXTbbN3v3o0LZ0BwRQDgEiQ5BA01XnmGw5xCu
WsnjQLLK/E/x07lv5Fu/11+EHvBD+RCw8tsuKnvKmF9iGIbzB+TYieFowgRt3UpW
8BOIplK9wPd+SwboxqDGghYT7e/BuFUb9aYP1qugOM402ODxZ/8RN47Xm+KpCZCh
qqp34zE2xPOscwq1IXvKxXieqGy465yhV2K9EYZc1R8BqV40Oo4yPUr2ieN/yDqz
0IJDEoXobQjc7KixvpHMrlLLauv46Wq73JwijY95y6KuD8E31RRY3F4sQcaND5dx
8VZle3+pPluwlSprrkRiDsuDw28j11Em40tCNmO5ChjHjLHSSP8enDO0PrrZwWkn
9E9P8R2m
=Qldv
-----END PGP SIGNATURE-----

--XOn40xIhvbYYoQNS--
