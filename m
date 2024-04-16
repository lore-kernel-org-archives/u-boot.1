Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EECAC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211B68840D;
	Wed, 17 Apr 2024 01:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RYpYqred";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF21B8840D; Wed, 17 Apr 2024 01:12:24 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4028836A
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-69b3d05e945so30828796d6.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 16:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713309140; x=1713913940; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zO+9mBZCPo8+bpOxlAxd56hz+5KRNtV+uLeYty1mofQ=;
 b=RYpYqredPqxqDUIaU0YjEnbfyC3IABd8aztMlkDDL892jMPCfOMg9SzSXW62/vG7Uy
 NIB+FdleWABPWlTiPa1BpXbat+MXuMXMUI1/hUsAx12dUPORaWj17/pB0omZB0iI4C24
 mxJMGf/MmQsaEjN4HFRoSbGWjYtyccCCaAFlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713309140; x=1713913940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zO+9mBZCPo8+bpOxlAxd56hz+5KRNtV+uLeYty1mofQ=;
 b=G4w59Mn5L2JLNlovkJfKc3EZFxm+q5atds3IAYZKEHgMh7TGW4EObduCUeQs7vKQnk
 nivZWGo9olSMQxxmMQvYQfg+kO3J+UTiW5GL7WriZ6jju+S7g24uHCUgZwn6J8CX4MZQ
 a6PGlHyJ2uWP9LPdor4Qk3H3O2ZlnAs5X1gs91uCWmdcjU4VR8X9lAfADJ4yegdLy/dL
 Jaag59XqGrqbhacuEaTBp9K8ldfUw/5cWc13en51itHLJapcftoG/Qgq9ff8q9FPsnLT
 32YCxwSUUM14I5A3CBBpNtfaJe+Zeh7ZMNnHKpQVGtcm4aJh4RS3Xqsjwwdj7i1rT13w
 fvRA==
X-Gm-Message-State: AOJu0YxeTqoUa+YeNGkNrQpW3LWd6WK7OMzKMsEljGWWZkLUI9I3b5x1
 45oj/dodGutf7pJo2/8FMJShhmMLlezmM2nQT+Suf0+EWbJU+aH3MwNbwV8VxYg=
X-Google-Smtp-Source: AGHT+IEAj7/T6AtZk7dHJGz3s1NRbeT3qzVMpUMccgfLodICo1/S04ADgVF35MJKDED/CyMEqHIoZg==
X-Received: by 2002:a05:6214:18cd:b0:6a0:40f7:1da6 with SMTP id
 cy13-20020a05621418cd00b006a040f71da6mr1925610qvb.26.1713309139958; 
 Tue, 16 Apr 2024 16:12:19 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 oj6-20020a056214440600b006986db59235sm7735053qvb.68.2024.04.16.16.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 16:12:19 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:12:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240416230133.GZ1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/gDFONGQtUagJu0T"
Content-Disposition: inline
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
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


--/gDFONGQtUagJu0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:

[snip]
> [1]: bloat-o-meter output between disabling/enabling MbedTLS
> ```
> add/remove: 231/69 grow/shrink: 12/5 up/down: 60196/-11166 (49030)

I don't know if this is qemu_arm64 or sandbox.  With buildman's size
comparison functions we see:
            qemu_arm64     : all +75537 bss -88 data +24 rodata +6349 text =
+69252
               u-boot: add: 274/-12, grow: 12/-4 bytes: 72002/-3800 (68202)
=2E..
            sandbox        : all +57008 bss +32 data +1632 rodata +352 text=
 +54992
               u-boot: add: 143/-75, grow: 21/-18 bytes: 64058/-16523 (4753=
5)

So please look in to using buildman to get more details about what's
changing, size-wise. Also, my goodness, that's far too much growth, and
we aren't removing anything? This needs to be a whole switch, not just
an addition. And then look in to what we can tweak / remove. Are we
perhaps not getting our usual link time garbage collection done?

--=20
Tom

--/gDFONGQtUagJu0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYfBckACgkQFHw5/5Y0
tywO8AwApdSRxYuXSy/DtK1CYJyFApkHo2mFtKYSKSOb/4JaPIDX5lHoERxQurEI
W6fw1eOBMB6QJKG/aqw4fwcUbRxUS77o1NFIUT4qLo/7Zjx3exvFTQ/d+VPDBONe
LnIvyRBJnwrgmbtR9MBHr14kr31U6tgWuHpTpTWNOvJLEzDtLCqbbITGuHrkjZ09
C8gxX6wdm+N/D4LxJFLPyrzbZH/YthD81pQc7dNlc5QFriEGOz+b1qSt0SslLPIH
tzWWZt8CMB7NSNrk6so2VrDhM8YuQnSsn6ylYOd2qshfGP8x6Tas1GMDC8VzDiX6
ac65bJKYPNaBchVR7y7hgIMvSJIYBxMXb3gI/I+vPPkgD/Aax/Ck1k+2HoSwji/+
25sgXx/h5P3RxkoZ8y9l/wS8vZOBOesG7nx0k65yaCpv1UjD/RdTUZX9u7YiD9WV
PMDqI/nBhvjpEfIDp+5TrgoEjnFfV9knTw+Ase0Celxlor7Q47/4V1p5vvesN9wg
wJX6gMUt
=VFm9
-----END PGP SIGNATURE-----

--/gDFONGQtUagJu0T--
