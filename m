Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15001C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 22:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB0C80050;
	Thu,  5 Jun 2025 00:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HhaxyH7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E050805D7; Thu,  5 Jun 2025 00:47:55 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFDA8004F
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 00:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-735a9e65471so173058a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749077265; x=1749682065; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jnL1bviXsOPAti36qI/83Sv9JdmRE7rHX6pmBHFuaHM=;
 b=HhaxyH7lINHlsatiL+lmW5Sd7DPBYTtrm9Ct4W2bsC3N0mPuoMW2QOE6YI9R/qXS7W
 AuJzMg0QZi35GIsceQCXhuOm50UfoXMlZ7fSRVPXH0DYG5AF4yobpaN0zrjxTSGlLJYg
 e1P3hH7Y2gLuHxCM6CeH4gEu624F9hmczoEss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749077265; x=1749682065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnL1bviXsOPAti36qI/83Sv9JdmRE7rHX6pmBHFuaHM=;
 b=ECO8J+/fZZYsaBsvdB7/tdiWB650HcCzvpYxnET+MO1noAEtGXhZFJ9IeHp4YXQhbq
 l7ixxle3d/tMM8Zjn3prWwEkrlBmNr1UQdRE7HKw6Ivp+c0LXvFwKtY2nOf9T98Hcc6B
 m0tLomCG+Pit3zvuxFQbr+XWHfUOztQjihjowJlthK6JEGzlQgQfbjcMagIh6QmIDIkn
 BXXuzt/sLe3LXqZ1E1OufZxiwrb6Uki2fD3zHyGa3o7jv5q3kEnM8oOlX2LABTe+YCDA
 FI0Ts4kagbc82z5YOrI6G8s7+2+0KL1mtmKBa19i9tLHxGKTipGCT2AUEPGf0yzCzvb8
 HmIg==
X-Gm-Message-State: AOJu0Yxd7JKbU5h1sl4j+rjD9WmgHKPQFajqYlpFPJ7JaAj0TZWJMO3Y
 ts/jWkX9rgovfmdpCWyCTcz20R7qJJHw2OyGAdDM8ZThQMrZ/vJPcG1OQW1yzmg/3bE=
X-Gm-Gg: ASbGncsNmg2eDk+oixtVo2JZ8D5rWFpF6CAjqYQ/vmOYYHwA/+0JZS2avbUk5dT8Fk+
 OLefm+AIE3zS3GDOE6VGvm8Oiji9auLoqXa3Uu1QKgmKMWZyjQRY8Bg1ujSkErHgzILZpxqRxC7
 do5bSb/NRkqcvRDpLeTkfY4JvSIa1pTCxTgxojxhheFO+n6mo88T7+nV7KZk18sseSNzYfIRiIf
 RthBqD201ObL34A2RHFuR9ZfOFDs5VH2mDXD8srnUkf9vbIlAYQsKoKgc1kYXR4wbhK5/cBM7v9
 SBpczEbRYV85AQbDgRvghOhhntM0VXIiY4FlyNCMcla737mSRpvECnJLrQYW7qEFpX1hyXmeZur
 1qGdhPdxRBi613q4/OyTvNkKEKJainIeXTA==
X-Google-Smtp-Source: AGHT+IFJjArzSwPcj/7IsWlBnvgn9fUKogskVF4pqPEy7FJsCkuwjfnKTs46vO4RrFPtJaVucdP2ig==
X-Received: by 2002:a05:6830:370f:b0:731:e7e8:b6ce with SMTP id
 46e09a7af769-73869de6e86mr3645779a34.19.1749077264936; 
 Wed, 04 Jun 2025 15:47:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9f4050sm2402478a34.69.2025.06.04.15.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 15:47:44 -0700 (PDT)
Date: Wed, 4 Jun 2025 16:47:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com
Subject: Re: [PATCH 00/12] drop volatile from global data
Message-ID: <20250604224741.GT1382132@bill-the-cat>
References: <20250604195612.2312979-1-ravi@prevas.dk>
 <20250604200702.GS1382132@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZzYSC1d7TUMqiD6Y"
Content-Disposition: inline
In-Reply-To: <20250604200702.GS1382132@bill-the-cat>
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


--ZzYSC1d7TUMqiD6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 02:07:02PM -0600, Tom Rini wrote:
> On Wed, Jun 04, 2025 at 09:56:00PM +0200, Rasmus Villemoes wrote:
> > There's really no reason for the gd pointer to have the volatile
> > qualifier.
> >=20
> > In fact, I claim that it's completely unnecessary and just pessimizes
> > code generation and forces ugly casts in lots of places. For example,
> > see the casts in drivers/core/tag.c where elements are added to
> > gd->dm_taglist, or a helper such as cyclic_get_list() that should not
> > be needed.
> >=20
> > Also, it is what ends up standing in the way of an otherwise
> > innocent code cleanup of list.h:
> > https://lore.kernel.org/u-boot/20250522165656.GB2179216@bill-the-cat/
> >=20
> > Note that riscv, x86 as well as arm64 with LTO enabled has not had
> > this volatile qualifier, so it's unlikely there's any generic code
> > that depends on it.
> >=20
> > CI seems mostly happy:
> >=20
> >   https://github.com/u-boot/u-boot/pull/775/checks?check_run_id=3D43463=
083829
> >=20
> > The one failing test seems to be an infrastructure thing unrelated to
> > these patches ("docker: filesystem layer verification failed for
> > digest
> > sha256:379cc6cd06dc3fc80e31d5170204c0cfcc25cb3b3ad457ced23bed2b38ec9f36=
")
>=20
> Azure seems to be having some hiccups, sadly. I know from my end I can't
> hit "rerun failed jobs", is there an option visible to you like that?

Ah, this was a different Azure problem (I was looking like I was logged
in and authorized, but was in fact not authorized) so I hit the retry
failed jobs button now.

--=20
Tom

--ZzYSC1d7TUMqiD6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAzQoACgkQFHw5/5Y0
tyzAtgv41PhMTIPxAShEQ56BokcstWMvP8I9e9JXzldrfw0wqNn3WC5zPKFn3nat
sOaiqfWKKO3kyPtmJk/P3VEBE11l28iBZahJzYU+CZmpSmeKMazXuOacM/O76oWo
XfFsaxuPThIyvm+i1VoR1F7Z85lZJ9o25dU9+V3Ak+hXU850xtWZ3NKLAy8sIla7
0FfSkagAKBv01SZ1jOJsQTpP9G3aSXWWHigydbWQEfGUeNAQDPGz3BmcjQubalHA
ysm/r4Bd5HTlr7+iSA8BXN2bsyjZpcSXKtcJHWjYTQKqDj6HBi7WcCxOtRw7/JT2
dtYqgarhTH4/cNXC1T4kqOhB4lucs8/mMOhdNpBSOmWIJcRMH4NrAvOL7ceEtWpl
FTT7cvle7Adaz+rNf4g3r99rangG5ZHR0x6V1aGDGXUvHAJVtGXD7qI9MySxOhQp
WtVmnt2b0q5LzwAeT22iQ2ZxB6rpToPZ4TV1nR9jImSOcYP+qQFHnunfV6yPoCxk
tJmK0SM=
=dky4
-----END PGP SIGNATURE-----

--ZzYSC1d7TUMqiD6Y--
