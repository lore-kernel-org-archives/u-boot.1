Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1129BC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 14:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538BC82B20;
	Wed, 11 Jun 2025 16:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YfnGrK4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683A482B63; Wed, 11 Jun 2025 16:20:42 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EFAB82B0F
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 16:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-235ef62066eso84452965ad.3
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749651639; x=1750256439; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QfQbY8E83bcoOyI9xUWQ+xh3ifou3sGPQF65k3aJA14=;
 b=YfnGrK4p7bLEdbX5FDpRfGt2gTGRx44M+r/EW0q2LISxlCs6BhAXXBv2YOp8ey1XHo
 njxCMtld8WfTXzdiIKXglO2rB/9cc3ZQOQcBqSm2i0j9+JiFUU1S40dOO5GAJUe1nUc0
 RY5DjC+hb0BBK+W9Zvmff3fnO7HdrhWsnYOCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749651639; x=1750256439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfQbY8E83bcoOyI9xUWQ+xh3ifou3sGPQF65k3aJA14=;
 b=tl1x/BwnhmODDanFZt710yW9fvCvy86eQn3Xd2WTRieKJ/3CQNkQZo0eA1AnUj8CFV
 WQC+8aaEzahE/fTL/7kqVoB9pN41l7heXYLAQP1/8XWQLwAUP7ggdVcRVhJQllnw/NmQ
 TLR0ja3T9cyoBsqE6lmli3+yL4PgFxUWA7y350EN+t4AwM4NWA0eI8UIYVOU5Fny1ogb
 1aT2dhVvhNsRRWv5+tXBRpy/0iI5+4RUBER+PsyBCwdrQRo91aPkvQh8Z+5ctG2wGDkW
 vfWGUgTOo4rMAr59ANTVMw4o3GmEnPGK6CMzxaMLg9+gMir7XWGxReaUnHEV0JYg8GeH
 90jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwwxnFA5Su/oyXcJmgItvnysfsuSvFeEpW4UW2njHkd3JXbUsrb5+z2gjnnt2W8Da03wgbSZc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyg1EUeLFCLMlXcAsgKR9C7rTCaGJ/IibhFpVOBaZ8KlwlWwoEk
 YB4jKXPqh/rHmGmjfuLh5lKRGn/w4xOfdnpyW24RHvaZaPKaOi/cS2BEgdIV0YtAO+6KCEPoEDU
 R7/EXGTg=
X-Gm-Gg: ASbGncuOtb87Vf4/zy2Fq3h8sPVmJljyY01uUEaHlgbedR8XoIoD3F7xVZ3GxbbuOQZ
 DtWLq2myC5ThPCam5188aZGkef3TwBM5R//3/IynbUvyzv4NYnlg9Lrq5uypFXg6Wm71zCmxYOd
 dq7tAMPwr/RXZyJCr+m1V2u5k3+1HFNBzGDz+Wts8dejHzGznGH6eiwhUypN7CB1huWWeQD6P08
 aJXAdgZVYWY7oJyQJM0SuCiqDjYWUeCU/VmYT4MGN+QoE56BuJrVxGpx714YsV33To6c5nV4nSd
 SUAAumbNjZx3qpLrofF9YrsXLr9j1PxlM4s40t9N+JpzxuQfs2WBJttootRPh32J3V9zUkMzffb
 30gLNE7Wm48K06dOQLIIMKno=
X-Google-Smtp-Source: AGHT+IG6RDpL0VU1CXA3bCamdTQrTUYBl8jEnbgLm56xaFKSev1BSmzssB0fVOXCn6igHK+YfUgHbQ==
X-Received: by 2002:a05:6808:3c43:b0:3f7:e860:b5f3 with SMTP id
 5614622812f47-40a5d11fd43mr2269104b6e.22.1749651627938; 
 Wed, 11 Jun 2025 07:20:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a06fe0b60sm321717a34.28.2025.06.11.07.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 07:20:27 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:20:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Thiery <heiko.thiery@gmail.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 mwalle@kernel.org
Subject: Re: [PATCH] mmc: Kconfig: Correct dependencies SDHCI ADMA options
Message-ID: <20250611142025.GH1382132@bill-the-cat>
References: <20250115020737.230558-1-trini@konsulko.com>
 <174434362339.24440.10543026192875667256.b4-ty@nxp.com>
 <CAEyMn7Yg5xkanAV+wEiGPwb4X7XqCKpJiMaPB+sdwdmhxbdKXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rCVFbpJDXH1SVFn8"
Content-Disposition: inline
In-Reply-To: <CAEyMn7Yg5xkanAV+wEiGPwb4X7XqCKpJiMaPB+sdwdmhxbdKXg@mail.gmail.com>
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


--rCVFbpJDXH1SVFn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:58:42AM +0200, Heiko Thiery wrote:

> Hi Peng, Hi Tom,
>=20
> I figured out that this commit introduces problems on the kontron sl28
> board (kontron_sl28_defconfig). Since this commit accessing SD card does
> not work anymore. I see that the freescale
> has CONFIG_FSL_ESDHC_SUPPORT_ADMA2 support but now we need in
> addition MMC_SDHCI_ADMA or  SPL_MMC_SDHCI_ADMA to get MMC_SDHCI_ADMA_64BI=
T.
> Is this intentional?

Hi Heiko,

This is in fact a bug and I'll post a fix shortly, thanks for the
report!

--=20
Tom

--rCVFbpJDXH1SVFn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhJkKIACgkQFHw5/5Y0
tyzT5QwAs5g71IDmG2KZ1tDzn7EtqFS9zZgTVPosvM9LZD5KySGvDzM7pTSl1XlF
IUuOqklLmAh2DmI2vCGaJAewkcTNNABSbSmoqI5XUPFsjn0weGKzTZiWgRiXo0qq
7kuV0hbRMaI/estZ36jNiq3TwavkjlDN631lUilMjhl/ls6uMoxV9RsyFQQovM6J
yCLqA+j5KtEfiAhK6YVX2edTJMskGnvRbPmHG+kDF96haWUaEP7w3wmIwqLtjutS
kep+tQoNjE7mr6av/RjpdX1vD02omKA3F3n0SNSuBpVfcLQxtPg6Ss2yODOQ3exh
4IHgUhVphScd3FGpudqQDNDjh+Vp6+b92ESRPJzvQ9S5HlHAx5XwqJ8sIoTpUrsU
gP+pFSYagdbLlr+pI1axJNYNWQmfPvTVn/IrTFaEyOtiVpsyu9qs7KkeJxAJXzrB
JqiqwnEQSA5VpliPhpF0kLXKMoxwq3lqQ0BRtC1ERI7Ddigjhe5Fl1onni/2vPua
HbPjPvW8
=g65I
-----END PGP SIGNATURE-----

--rCVFbpJDXH1SVFn8--
