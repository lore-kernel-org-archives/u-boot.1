Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD129C5AD4C
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1534286F9F;
	Sat, 18 Nov 2023 18:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c53tt297";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D12A86FF7; Sat, 18 Nov 2023 18:46:05 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2853804CE
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41e1974783cso17450991cf.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700329553; x=1700934353; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9AOVCxEcWfmZ3x/4Zonxq8L4a4eBRjniZW0va0Ymb2c=;
 b=c53tt297Uxx+NZ/YazebgAmxiE7O/4f94lm8Z+XQPsh6SxWgfNrw25t1rsOAvd252N
 yxTvicpKciReRoz8XnI/MWGfVce2kQ8gUrUK7E4V30GACx1CQpEp78r32JXKDYzuaaHY
 GtxtiimcIg33n5m77n7vzD5lm3BZ7WMj7jpIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700329553; x=1700934353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AOVCxEcWfmZ3x/4Zonxq8L4a4eBRjniZW0va0Ymb2c=;
 b=Fhw0ePGFvZHX1ftks7dVH7CYhhGWdRs+hFhJW9ezw1ZlBP4qZUnyi0iQ0W+TwO685N
 ufwuZGm7fDCdGowDGHIcEXCgrX5t4Ha1Sgv8Ayj8akuG6zO+7ROZxCi5vb1nh3dPRPyM
 tfQ1EDJqMwYqVsndQnh3cpvbyc1dvoNjkgM+ZJZ2SMxJI+e1CUWF4tb5rUq8BqYdgkC5
 0u1OtcPgU8Rv3iD5XN9SI6+xupz8O5Vtbh5RP2A5S2daDFOqRJ+PyBKflNZDqaZNqGhq
 O/egNQVNyPOujnlz+ju1FKjMzb5ZmYGACxH1xJWfucS3X/DdqhR2Ak3Ot4ucFXeHbJIL
 eJgg==
X-Gm-Message-State: AOJu0Yyn40K1zPce45o789mvYqYDOCP/BtFMNzDRLQd7W+SkYAVdIqma
 qY4Lt4VnxBn+aRx2Fv50/7agd74jnKTct63A0UbOxw==
X-Google-Smtp-Source: AGHT+IFaSkRWARXRZyA0/v+Oy4IrHMh1peySLjkpS7sKWYurLdnnsV8kD3lFk7KWkWErutlxw300UA==
X-Received: by 2002:a05:622a:1707:b0:410:9111:4a0b with SMTP id
 h7-20020a05622a170700b0041091114a0bmr4150405qtk.13.1700329553705; 
 Sat, 18 Nov 2023 09:45:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 h5-20020ac846c5000000b0041abcc69050sm1392954qto.95.2023.11.18.09.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 09:45:52 -0800 (PST)
Date: Sat, 18 Nov 2023 12:45:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] sandbox: Audit config.h and common.h usage
Message-ID: <20231118174550.GI170968@bill-the-cat>
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-4-trini@konsulko.com>
 <CAPnjgZ2N__uy8qdhJfwzrk088dyG8fFGXbsh4-Z4yWa6rkDFNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lmHXUNnBpGEZAnKi"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2N__uy8qdhJfwzrk088dyG8fFGXbsh4-Z4yWa6rkDFNA@mail.gmail.com>
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


--lmHXUNnBpGEZAnKi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 10:09:55AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 17 Nov 2023 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > Remove and replace common.h and config.h in sandbox when it's not needed
> > and add some explicit includes where needed.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  arch/sandbox/cpu/cache.c         | 1 -
> >  arch/sandbox/cpu/cpu.c           | 1 -
> >  arch/sandbox/cpu/sdl.c           | 2 +-
> >  arch/sandbox/cpu/spl.c           | 1 -
> >  arch/sandbox/cpu/start.c         | 2 +-
> >  arch/sandbox/cpu/state.c         | 2 +-
> >  arch/sandbox/include/asm/io.h    | 2 ++
> >  arch/sandbox/include/asm/state.h | 1 -
> >  arch/sandbox/lib/bootm.c         | 1 -
> >  arch/sandbox/lib/fdt_fixup.c     | 1 -
> >  arch/sandbox/lib/interrupts.c    | 1 -
> >  arch/sandbox/lib/pci_io.c        | 1 -
> >  board/sandbox/sandbox.c          | 2 +-
> >  13 files changed, 6 insertions(+), 12 deletions(-)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> Is it possible to move CFG_SYS_SDRAM_BASE/SIZE to Kconfig?

Possible? Sure. But I think it would end up being fairly horrible. What
would be nice I think is some Zephyr-style "convert
CONFIG_DEFAULT_DEVICE_TREE to some defines" because we could parse out
/memory to CFG_SYS_SDRAM_BASE/SIZE and that's something we _need_ at
build time.

> For CFG_SYS_BAUDRATE_TABLE perhaps we could have a standard set that
> most boards use, or turn it into a set of word flags with a bit for
> each rate?

We do, largely, use a default table. I forget which further rework I
posted as an RFC a few years ago, but I believe it was largely seen as
being uglier than what we have today.

--=20
Tom

--lmHXUNnBpGEZAnKi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVY+EoACgkQFHw5/5Y0
tyygBAv+M06erTeYnwJjsOVztQC+hh6N1VQ6JBD4AvZKd/gVc4YW2+4MXC4YmZzk
Ukuy1W8JgiCEolKixevmCAZXAWAhPs3GgoLKvkz5FnjnHzeAw5HG7RI6AeXU9ZGF
NfQhgX06Gc6ZaIxvddXJLvwCt6Wo0JloSi3UiwMC0jd1JVHHBgOH/bkwdLewkBTB
QlSspcvE6AOCGBEDn969L1iTJ3z5e6mJqiO/qhIXWxlcDt0R60ZzEC44XxcRNs9E
wn87JhG51uvCEk4iLDLY6g1stlXrmWh/vsG0WmQsr2/W49ybyYaCbEFh/+loPfiN
hyr+oasjwFzww3cqQiixhy4srUDk2UIcwEpSPSNGa5pVoJ3imHq319jFFQQF3aIZ
Qh7FHB+ElRyeGIs9xzUNpov4z5fBIdV48gj4wLHlX6T5S1kBNWwRcNcmgB1ElLM2
0aNNW2bddL5cBe0CXUeZr9tescerGclX9MlUONalHYfe+dXX3fUfV6VVOlemxPUF
XPbORY9F
=VXQw
-----END PGP SIGNATURE-----

--lmHXUNnBpGEZAnKi--
