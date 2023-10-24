Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B729C25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 19:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B4D87992;
	Tue, 24 Oct 2023 21:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QlVJdr7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCC887989; Tue, 24 Oct 2023 21:58:33 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B76F86FF3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 21:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59b5484fbe6so50693577b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698177510; x=1698782310; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1ulfORwocUthOJOKBPP7REIiHkyYWyn2n2R6SgaJEQ4=;
 b=QlVJdr7E1W2hx0ehULz9IQbGOYVWW4O0XvfDnddw3FAk4pA0//4XmJxUPwPEp/0Rdb
 TFlSWe0MQJ47pg/WBrnebYMfy7Hd10+c6Q1KZTjXdHQTTwcrRCAGZHnxF0VYgSQiJC3z
 aS4353ymZJpdZd1SyRjK0i9a6ouDo9wPDaK5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698177510; x=1698782310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ulfORwocUthOJOKBPP7REIiHkyYWyn2n2R6SgaJEQ4=;
 b=ZAMgLenAiJC44R51aU6WD8EZO8awxXPdZCImawqT0F0mxeCrlvdtMwTPHAdS01Kce6
 BQ+WGpCZOtgeqSyQKE/mMbRQ2K+3vfCTGlBy4YMXpEXy1GPv0JEqnpTy0l3FnmQqeBrO
 eNtqIhJxPuRAiGueQQ+ns5+GCYAZ0Xx/ltDbXo50NU3OZyTwyBHykK5UFiTqQ3T3dwkD
 evV9vI5d32Y1Nz7PFW9YtrId2FiNXo7xg80/FZkKL2xmIZXKkHHEq2QfOYCOjepRdzyi
 gXXD/H579qI5Rd/7dXulRj5UBaOvvTXoLh2l4uvH6bCY9Zu+2vxdNRHcrXDGHNr2g5UH
 cYVA==
X-Gm-Message-State: AOJu0YxMER3LatdA3A0CYKdpVAIOq0VW5MJYcsPerGzl2cx1Q+ITKhzZ
 cytvhdAtzkEVG0OIOKUNkw8CWQ==
X-Google-Smtp-Source: AGHT+IEPvQCfCdVAPh3b7EIaBkYIWL+a2gpIkNru0l7dxg8NJPx16eMNqJtgllTnNcDBbUJ/cQLwhA==
X-Received: by 2002:a0d:d7c9:0:b0:59b:bd55:8452 with SMTP id
 z192-20020a0dd7c9000000b0059bbd558452mr13349094ywd.36.1698177509750; 
 Tue, 24 Oct 2023 12:58:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 x126-20020a818784000000b005707fb5110bsm4385860ywf.58.2023.10.24.12.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 12:58:29 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:58:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm: init: add an option to use FDT from previous
 bootloader
Message-ID: <20231024195827.GJ496310@bill-the-cat>
References: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
 <20231024192530.GH496310@bill-the-cat>
 <a4979be1-2267-4cfa-b412-f66e7455258b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8iIixqgJ9i78LZKv"
Content-Disposition: inline
In-Reply-To: <a4979be1-2267-4cfa-b412-f66e7455258b@linaro.org>
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


--8iIixqgJ9i78LZKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 08:52:22PM +0100, Caleb Connolly wrote:
>=20
>=20
> On 24/10/2023 20:25, Tom Rini wrote:
> > On Tue, Oct 24, 2023 at 12:32:35PM +0100, Caleb Connolly wrote:
> >=20
> >> Add a new config option to allow u-boot to reuse the FDT provided by t=
he
> >> previous stage bootloader when available.
> >>
> >> On some boards the previous stage bootloader can populate
> >> platform-specific parts of the devicetree such as the memory node, this
> >> allows us to avoid hardcoding it in u-boot and instead determine it
> >> dynamically at runtime.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >> This patch will improve generic support for Qualcomm boards by enabling
> >> us to configure the memory map at runtime rather than having hardcoded
> >> maps on a per-device basis. I've gone for this approach initially to t=
ry
> >> and avoid introducing board specific code where possible, but I'm happy
> >> to rework this into mach-snapdragon if that's preferred.
> >> ---
> >> base-commit: e65b5d35c9116485366bb08138043d51220551da
> >>
> >> // Caleb (they/them)
> >> ---
> >>  arch/arm/lib/save_prev_bl_data.c |  7 +++++++
> >>  boot/Kconfig                     | 10 ++++++++++
> >>  include/init.h                   |  9 +++++++++
> >>  lib/fdtdec.c                     |  7 ++++++-
> >=20
> > So what is different with this instead of using save_boot_params ? I'm
> > not saying this isn't needed, but I don't immediately see why
> > save_boot_params + (OF_HAS_PRIOR_STAGE=3Dy&&OF_BOARD=3Dy) isn't the sol=
ution
> > to the problem.
>=20
> OF_BOARD would work here by implementing board_fdt_blob_setup() for
> mach-snapdragon, my hope was to avoid doing this in a board-specific
> way, but if that's preferred then I can totally do that instead.
>=20
> I left a comment below the patch about this, although it probably wasn't
> super clear.

Ah, yes.  I guess I don't see what I suggested as "board specific" in
that outside of efforts like bloblist that Simon mentioned, every
semiconductor is slightly different.  So yes please, OF_BOARD and
board_fdt_blob_setup and so forth instead, thanks.

--=20
Tom

--8iIixqgJ9i78LZKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4IdwACgkQFHw5/5Y0
tyymcwv+IA9IFgNfFS4oC6XTKXJUUJWav3RHk70rbVKSfI/Mxokrw8DdWMAgCtA/
dZjvLfRZ2TkCdW3rLuHHzjQHSdrRJIdFm2O8/pW6vH26JOANr9EDNqa8G6MuriFS
kqsSVT4i5KDFMVTlWgF+kp1lESZT9wOleQUrJTGfcF7aDGffsiVSVCd/Bc3sSIS3
esueIR6rmskhkuDjNXVecViqdATDLw42JG/zfr6yN7bfH84zOoFFFOWTUjUN5fdP
1KoTu57veJ9aHsr+Se1J7rI8a7VZvjguvnBH9ueROYpqumOSqX+omN5kP4gMdxcw
MKDfy0ivePehnpzU7daFasxmmtAg4Zt6Qp6G0Scl+VhWE56hsWw2fVFaqTgFjYvt
ZUxtsfxuUP98M+s6og1KI8qVL/qNOBOgVq+H39SuMQjsjs0VYkCLZfaYjnfgO7Im
yyKFAwQuoAL3QNJbCuZb+DgiZPJbBTZ3ORpoDMKWljQG/7zros4K3HxlIKcAPtV8
2YODfVAN
=tueT
-----END PGP SIGNATURE-----

--8iIixqgJ9i78LZKv--
