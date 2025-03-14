Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47686C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A4081E66;
	Fri, 14 Mar 2025 17:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ePtW6CsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A6581E81; Fri, 14 Mar 2025 17:34:30 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6341081E14
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7c559b3eb0bso143157085a.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741970067; x=1742574867; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OOnW+cZFu9dATkF4Cvq9Q+Mk9gK9bHwiRL1/Q+40/Ww=;
 b=ePtW6CsPLtncKFRDuLr6k4y0RxNeR4OXRdNsymT6RpwEKoiPtFYuuhuqSzXXqSoDTL
 kLGwtRPzpx7z0Yie8s2XVhubF1qSxQQYaGJqI8l2lXw4OZ+RsMsiWpI6y/od6p4OYZfj
 sQKFH+4nLhA+11PiILpPiaerhZUHztOPW1G3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741970067; x=1742574867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOnW+cZFu9dATkF4Cvq9Q+Mk9gK9bHwiRL1/Q+40/Ww=;
 b=H5je0ybZzfRCXF3c7qHI04MgtHxF4mcS969RJFtHjs2t1xIVYP2GXWDCEIw9JPtly5
 ryAblhixXYkxBsdP/3lSM646QCcZbRnN9siiGXmbj1SV0/+Q2h4S/fG8EMzh2wCgn8Hm
 fBqQ9TXw3vkg1st9ITjMLM4DZx1Ac5b3GtUM0BCQhvdFXIbPFaNi4HuCsKVqFVIuMCyQ
 IwrtyYZWlSh+WClxVGWy3nfrcPEVuExjmelNDkKrPIY/4vAFnenspSKkkZfrIlGuqJYQ
 EM3gY4KzrDAgVnUjmqmhxL9Hrl/5gFNE/4aypxYdLRiiB4IY+Wm7Ki1X3yjnSgHotjFB
 zWcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf1QiGDuf5fGHwIKKQ5V5AbCHH0UF/lOdoNM4/ur5j0zc9j1fMBdyINBuFvY6XIfFlmkySZBI=@lists.denx.de
X-Gm-Message-State: AOJu0YyNNxbag8GA3ez/o63YvcHCYkbD9r7qDQ+gpqWIRn4XieKP9dXs
 +l+OaBTxwQNfhOxnbH5wgZkdIf3xp6UR4HUz93osSGnGHaYDCXlG2PDsrDecxvQ=
X-Gm-Gg: ASbGnctSnuGk+riD5d2pKcPe8cl3FTbCWFuS7hsyKkQ+ia301Lj/bRumSgBdsA/lb/G
 3q54d8Ar+69otnET25tu+sb2ZgNRHldQwmNLfuE2aRSkFL+gliQk5HTyRDatdTw8imgrxMjysTr
 r2X7h8ByrTpc+UQmbFGOlf/i4mt3NCQof8DGahiOMD169a4yxBcee2p3GTDs2J8ogvfUYueBSIl
 fe7dtJ9JG4bZRhESpCz82eXzVd6eKvZOw/8dg415ypuPRGJAlwxedw71R/zHV1Bdfc9zkJb4BKv
 sbf+si2AsutowJH4HWHjN4LXEt1cpsb79Px30pplzOCTXJYJwkENzyW4
X-Google-Smtp-Source: AGHT+IF1V8gFhuPAOszmhtt5pr3vqcjHJovXh8KBqk5J95GnROCF3mcC06G5PUDDbSPPduYqrS+6Jw==
X-Received: by 2002:a05:620a:28c2:b0:7c5:602f:51fc with SMTP id
 af79cd13be357-7c57c8abbc5mr406304285a.44.1741970067210; 
 Fri, 14 Mar 2025 09:34:27 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c9d641sm275226585a.65.2025.03.14.09.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:34:25 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:34:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <20250314163422.GV2640854@bill-the-cat>
References: <20250314100734.23777-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dBHT2OMncpuQau0T"
Content-Disposition: inline
In-Reply-To: <20250314100734.23777-1-eichest@gmail.com>
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


--dBHT2OMncpuQau0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:

> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>=20
> The get_ram_size() function fails to restore the original RAM data when
> the data cache is enabled. This issue was observed on an AM625 R5 SPL
> with 512MB of RAM and is a regression that became visible with
> commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
> location and Fixup DDR size when ECC is enabled").
>=20
> Observed boot failure messages:
>   Warning: Did not detect image signing certificate. Skipping authenticat=
ion to prevent boot failure. This will fail on Security Enforcing(HS-SE) de=
vices
>   Authentication passed
>   Starting ATF on ARM64 core...
>=20
> The system then hangs. This indicates that without a data cache flush,
> data in the cache is not coherent with RAM, preventing the system from
> booting. This was verified by printing the content of this address when
> the issue occurs.
>=20
> Add a data cache flush after each restore operation to resolve this
> issue.
>=20
> Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common=
 location and Fixup DDR size when ECC is enabled")
> Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is =
enabled")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  common/memsize.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Ugh. Is there not a chance the problem being that we need a
dcache_flush_all() in the K3 ddr code somewhere? I'm just trying to see
how we got here and I notice now that yes, this does look like it
finishes what 1c64b98c1ec4 started but in hindsight was that showing
something else needing to be fixed?

--=20
Tom

--dBHT2OMncpuQau0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUWocACgkQFHw5/5Y0
tyypyAwAhMKPPirLMGQ3Z8zdqf17P7OULPphtLKlM+mytW58JanisE2obEJAhp1q
7nwFAMfxnc/zN3d7iA7Ad2JNriY60UyUd6my7Ns7+xOCrSh5kV8LUpUn7CYEuv3l
p980htry7tVZXE48l8U0TQps+1/ye3v7kZEV3yR5ETssrRQ/g0PnvBcbm8klN2L0
dAFOCsoLME7vD/q39fsKL03lyfLZfwhzK6MJYHAFR/Gg8wKkQYxU7bp11/3fvDrr
0jjjxlN12Wn+L5qHfJlsLC/9/RgmrxB+0xBUIxULOmPHyMkpJ7z0YaeYcsVlnwiw
rmNf5sCgWoajc7soDPcLP4MvdG+jCoZdWM/QQBGl2wS161XQUpmf11Bh1/GS03mf
H7XzlyMRAFB/Ewk+vqSYXSFZwFbXg6G7ZFpeCqOYuQP1ZDiKw+9ZBm6MZmxeJt+N
GBnWS1S/AOtpYUm/cjUrRZ9rPYJsCqzqKyb6cWToM2Xd54U1LBAVqCv7JiJxVG5H
bxsbA9+n
=fSso
-----END PGP SIGNATURE-----

--dBHT2OMncpuQau0T--
