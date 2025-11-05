Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E15CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 15:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E8CF83A32;
	Wed,  5 Nov 2025 16:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Loeap3JZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E070F83A79; Wed,  5 Nov 2025 16:21:49 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFEE83A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 16:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-44fe80bde84so317081b6e.2
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 07:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762356106; x=1762960906; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FTD4v+0m7nsBhAgrM8z2pTVGwDrHCQHJ60tNeqS0Zo4=;
 b=Loeap3JZzHoNvV43aFLWHMPZqiRLVD+V3Rr01glM+riWBCLZSqLCKmjT1fGvs/wZ1r
 T2YFq+/1dO0dw9IdMhPcPyNv2lEk48l2ezISWjndNTX5nvQQT4IpwPfeOq/5IsBbdZmz
 kdz+Hw5iauU+NFb1M0wRrp7Gmr1pg+sUNiI74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762356106; x=1762960906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTD4v+0m7nsBhAgrM8z2pTVGwDrHCQHJ60tNeqS0Zo4=;
 b=KVS/2gQcBE34uXVIeKs80+8h0J2Kd+gy1kwQQne2SeszbAxIBUbteehgp5DdSJ5J2A
 8MrWtQAjaEfPvTcBY7xL0CubC22y1zocN+9LNb1SkGlnDk9FaJFvrzj6m54NFzBqd+33
 Rn0O8raWN4/GTMOdkEuNQPIt+v0lNqi6u8L0ff2gwlOQO+qOfU6iwu4GOHzOjp0qO4p0
 VkafS8wnxiBHn3/TCexNWizrwdTmsR7eMt7RtBdYaS9qIcdNveYRdcQOJQAqY7ePde9P
 IoSieial4eodJLeyohRia3MKtp/+ADAhag1V29V2PBG8VRzdWCa5VpOZZJ+GQstMc6Wa
 8StA==
X-Gm-Message-State: AOJu0Yxzaan8d2TqUUhwUNuhWuBSSrm3W+aJo67QA6QD4MrAGqUuvAkH
 a9s6n/BWVcQfi5C0w2zoKXr/bWxp4IPqlbKARfhoxJLCU1wNuaSd3DIM5c1zSphhuaU=
X-Gm-Gg: ASbGncvKb4Fh3getr9gN8zBTcxKC4AluFLwvMDGr/jlUnIJSTqxuvwe/zNQNEzhDUM9
 rBv2EhgyOpbbPGOHsdgkycsDXXe9GGLa9Vx2ryTXtHEtHMxrtLw4yacKSU3CyGDQjh/LcsJ5SbQ
 4Psq2kcjWhPthCko79a24IN6letd1q7sfewUTMheAXwyPUBIXijExv05XFMt9jYCggg2pTcuVQ4
 XxqbonWEfyRVt08sUuKdzJlDo58UK44YPNwV2KRHjhXgiXdqPS3XlBwT2rXdGFKA8/h61neTjeU
 vjTROsEcpQ5YcsOiWC/zJrVbmrBgdE53Ucyuz/5li50adPMsfHZqL8CuxdGJtljkKVacFO/dQsM
 rZYKS1u3o666pyEbpipPNu8JNaobF4CWADq3cIcYrkS6v1d6ADFiuDSDOTu78PUDV215vRnG2fl
 8zOlkcBgEQbRFSD49EAX5qmTu6DTCRPSV3fYWFhm62ZTEOrcxKyA==
X-Google-Smtp-Source: AGHT+IGqMLuMPmx6r9fTImH4PbbXz2cfNYQoLcfF71BtuaAYf4mWnpdfyfCJSeql7VflbpRxpCvXYg==
X-Received: by 2002:a05:6808:344c:b0:43f:1de2:fe8f with SMTP id
 5614622812f47-44fed1cd4c3mr1544608b6e.15.1762356106555; 
 Wed, 05 Nov 2025 07:21:46 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ad0617c8sm1852301eaf.4.2025.11.05.07.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 07:21:45 -0800 (PST)
Date: Wed, 5 Nov 2025 09:21:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] sync doc/README.socfpga with new info
Message-ID: <20251105152144.GP6688@bill-the-cat>
References: <20251105120613.530-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gw493htm8y4uJnFL"
Content-Disposition: inline
In-Reply-To: <20251105120613.530-1-briansune@gmail.com>
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


--gw493htm8y4uJnFL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 08:06:13PM +0800, Brian Sune wrote:

> Pulled from official Altera trunk
> and modified the handoff section.
> New handoff tool location and operations
> are explained accordingly.
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  doc/README.socfpga | 412 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 295 insertions(+), 117 deletions(-)

Right, so the first thing to do is migrate doc/README.socfpga to rST
probably as doc/board/socfpga/index.rst (and include that in
doc/board/index.rst). Then work in some improvements, thanks.

--=20
Tom

--gw493htm8y4uJnFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQtrhwAKCRAr4qD1Cr/k
CoCpAP9cp+juhskFnw3syzQFYHtVjX/yAlt7gcrMkPpX+FxnnwD/fEjltePwgRxS
A+GBYVKeRCOVABWs/K12IuQAENslOAM=
=om6V
-----END PGP SIGNATURE-----

--gw493htm8y4uJnFL--
