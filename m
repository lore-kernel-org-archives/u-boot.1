Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3C6CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 21:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A8483906;
	Mon, 27 Oct 2025 22:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FGF0oCS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE668391B; Mon, 27 Oct 2025 22:20:25 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DCC7838F8
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 22:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-74526ca79beso3643664a34.0
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761600022; x=1762204822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+pwp55T4C0h8zRnHw9neM4nB5MUaRs6nznG49uPSgMk=;
 b=FGF0oCS6x3BOaJjQKiX6C40A6q2kTi+OM0I9K+eIFr5t8mW89oKGdxZ2iKa/Yc/h6J
 XWj0LDzwSGuBH84Mt2LJEuSfdMVK4hmw72ALWA8RTZltx5mbuqdow8kiI7AAqjUtlnRr
 QmbfzLsyej8+L5Bh/q/opuDqo0LR2PdyFBf8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761600022; x=1762204822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pwp55T4C0h8zRnHw9neM4nB5MUaRs6nznG49uPSgMk=;
 b=OmnYDmWjzQKM8jhAr3GI6yAFe7ajAC8CQSIM2/yGKvwZawLh6QgQL4VieO5WE9PEvg
 uoPEKAFm6OU7odQh+QUOagRh7LI3Fgt1u0N1PFKetcnn6WDmOmIRLo4tXJ3WMOCtI3iH
 +9RlBIOz4dgLAqLkaWDlUZ/Tv0LQZ0Z/fbRq2KTAudB2G4uneaQEKHG8DqP5kBUnYErD
 2qftE6ny3ozByuzvz/R1xShTH61z2eV3wGOi4ZP3iqZ7AIJUxcBEWJTHGw4atW8v/nCY
 ZPlctwxTe7PxnH6T6ewWsR2CB5JXW9thXaH2JDgrlDcfxjOOoJsimz1bkzIOF3WG+dLF
 /aYw==
X-Gm-Message-State: AOJu0YzJhw0J4TJibfS2ptdYicztEseLDV1RYh3Te5vrZqj4HfhdCSAL
 1IPg02J2kw5E5x1lTfr5DcS0v981MpnWv38+0dvlZpg974b4ng+3Gatl2qEHFKsyA28=
X-Gm-Gg: ASbGnctN3bX38m/ruDqMQ5l+uqIDMl5n3yjY1Lgk//2Ti8vabri6zyJs737MymESvXp
 DpfOdz0DThVN04WMIOT/TqwXdPZ2wgXYUiegwMTDrYng71plD9AE/tlFdBPTgeje2Hhtzqpoydk
 G9Zqnwd4/i/CQd9C0FPrih/iqc889GPusWXdIgwpyIE6dOE4O1HRRDYO9i5cSe2kzvY5Wj6HrFI
 BQT7n0roNBYT5rpWwdbjjzO/M6d33vvKKW34/lxIeTOHZhNO60qS1TYs15ix7u95PG2xmhpVoBa
 RbTEXws5OQxRdtG6dhwHbTY4Oq4E+MZp2/3A1OhVihh4g6lwwa/1QPlYqqF8oICdsOBnBgwLvKh
 rFCY9XDAh3hxvqGajX/8kefZMFMxVSiTVxIM6APlLhZNNuny5I2bp12/BR+8ggk8+r6p9H317g9
 wsu5hALAkOWWQpxR0Ea7YDNwsb6FcNxtC2OJAHgLo=
X-Google-Smtp-Source: AGHT+IGhTFMCx2PzDFc6DYiFSPrYJ81+ATkhRY2OKWIB+zdMOiqpphusp3zR00aB2K1U5JKZSZmpAg==
X-Received: by 2002:a05:6830:34a0:b0:746:d4cf:b480 with SMTP id
 46e09a7af769-7c677eb14eemr670295a34.6.1761600021993; 
 Mon, 27 Oct 2025 14:20:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c53022052fsm2589032a34.30.2025.10.27.14.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 14:20:21 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:20:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v10 1/2] spl: remove usage of CMD_BOOTx from image parsing
Message-ID: <20251027210852.GZ6688@bill-the-cat>
References: <20251027-fix_cmd_bootx-v10-0-10487e907710@ti.com>
 <20251027-fix_cmd_bootx-v10-1-10487e907710@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h0EvRRwbq5SofZmk"
Content-Disposition: inline
In-Reply-To: <20251027-fix_cmd_bootx-v10-1-10487e907710@ti.com>
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


--h0EvRRwbq5SofZmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 07:47:02PM +0530, Anshul Dalal wrote:

> Using CMD_* configs from spl doesn't make logical sense. Therefore
> this patch replaces the checks for CMD_BOOTx with newly added library
> symbols LIB_BOOT[IMZ] and SPL_LIB_BOOT[IMZ] which are enabled by their
> respective CMD_* or SPL_* counterparts.
>=20
> On platforms with non-secure falcon mode, SPL_BOOTZ is enabled by
> default for 32-bit ARM systems and SPL_BOOTI is enabled by default for
> 64-bit ARM and RISCV.
>=20
> The respective C files (image.c/zimage.c) are compiled based on library
> symbols $(PHASE_)LIB_BOOTx instead which are in turn selected by both
> CMD_BOOTx and SPL_BOOTx as required.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--h0EvRRwbq5SofZmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaP/iEgAKCRAr4qD1Cr/k
Cla5AP9Ge7GsjsGvM7ePJLKbRFzrHZjIgeuw0qEimXiWBP9L9AD9EA5+DMGcIGdP
FTgUW9DFWa6AGLll+QifAUyxQe4uagk=
=1MOr
-----END PGP SIGNATURE-----

--h0EvRRwbq5SofZmk--
