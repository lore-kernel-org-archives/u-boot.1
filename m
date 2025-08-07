Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF98C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E7584609;
	Thu,  7 Aug 2025 17:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YJrHFniJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE578460B; Thu,  7 Aug 2025 17:54:05 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF2E845F6
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-301a83477e5so990958fac.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754582040; x=1755186840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3OKL9SuBOtcBOqakJzNMnO2lAQgLMlJHqXwxXyvilOM=;
 b=YJrHFniJwccY0NSV/wzZqRVfB9nvjrRLcJeEFjNUNJYQEv2mj+tGZZcJn3/cr+XC+P
 Q7FZYpe0MuK+Vlr4ph2+cdrxtAMltrt3kLzJ09Hpj5M64+EwoThRlP42a627RVc+Wbk3
 0DdPUD/Iy7y2uzEN8PCicvAtMmFwrHgTgSN5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754582040; x=1755186840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OKL9SuBOtcBOqakJzNMnO2lAQgLMlJHqXwxXyvilOM=;
 b=VnzvZzLE3XGDmUVT6lyM8glvdUif4zxV1ZIhCEZttVoFftgaAiHg8SMHCm3/hCvyOP
 Kyx4/Cpk/ixrq4GryRCPkACe5mjLB3+qqciVJPbBM9I+Q9lxHROHw/EvBuyTo1fHp3Yl
 tZi2wGyUqzIt2b0R8AHTwjteUqvNynyLiuNq5BaAcNahmzfLdb59hWBzhqubqumvAkDM
 fNXp5rSbiWyx0qpn47G3ydgXaeLc9gffQr0Kb+ICH3OJDkDfT+9nPc9J4lYAiuVc0Bm4
 G3F2voY3sdZtpkwjQmHVlvO3ZDsUfiBsBZFEKVmGpBChvLk/4WiDKQpWRXiNj9eieu7Y
 Ou5Q==
X-Gm-Message-State: AOJu0Yz/lEPvaGYqExOhrYgJF7zdn1pVhZ8zl+6D0cafqDJ4k0B7SffJ
 FKfuQSsX/aEx+0G+f/6rivcixojqe/kIWxG7NHI14e4sxjjRWg2CIJ++t417RwNpE/8=
X-Gm-Gg: ASbGncusnTgAm28Z6B9qtcVzVOGmLjzKh7+rZrKHGXpjew64J8bexl5gqJ+w8FXd7Ne
 qj+On9cw3kVGeBdVOXAPyedT22wczJdXxKjLSIgJkP2h55vf+XOYh00XOIfGkZJ6RQyvLuRGkW9
 X7Zaz9/2oMr5+I6b2eq64cjB9Xo5N7BSPE0h9OZULFfM9rRQ9a7kSdJHBdNgS68K8WwqR0HFIUW
 MG4YP5sUpViQrbRPBSRI2miyirpeV7RM2V89UapA9OZKcCum6hySJ+2lcnYzacopsrZsXgYmFQr
 piibGXjKCgjNNGZX2xSfBfcQ+ZuONCCsQSJd/vRVuYqmJsPCOCS3DgroX9iEsQc8HzdNIZOIr+0
 JPX1wzy+nQTu0PKcLocxaOULLCbhRSC7PtqVTK6avA3UQBGEvw65uh8AR
X-Google-Smtp-Source: AGHT+IEWB/lqGIFmOi5sW5FpxNclTyYQr7YaoO7eg/FpHXXI+9QPrAAs+H9lAkKpcstpLhjc3kY6jA==
X-Received: by 2002:a05:6871:5827:b0:2c3:f8e3:bdb9 with SMTP id
 586e51a60fabf-30c1d24a025mr365384fac.28.1754582040418; 
 Thu, 07 Aug 2025 08:54:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30bbe5846f9sm2257942fac.36.2025.08.07.08.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 08:53:59 -0700 (PDT)
Date: Thu, 7 Aug 2025 09:53:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Swamil Jain <s-jain1@ti.com>
Cc: u-boot@lists.denx.de, "Thakkar, Devarsh" <devarsht@ti.com>,
 "Raghavendra, Vignesh" <vigneshr@ti.com>
Subject: Re: [PATCH 1/8] video: tidss: Remove unused drivers
Message-ID: <20250807155357.GW124814@bill-the-cat>
References: <20250806145649.1664724-1-trini@konsulko.com>
 <21bad7ca-16e4-43dc-ac99-87bc31b3bc51@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oTnH2TgjRVWSs0C/"
Content-Disposition: inline
In-Reply-To: <21bad7ca-16e4-43dc-ac99-87bc31b3bc51@ti.com>
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


--oTnH2TgjRVWSs0C/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 09:16:55PM +0530, Swamil Jain wrote:
>=20
> On 8/6/25 20:26, Tom Rini wrote:
> > These drivers are no longer used. Remove them.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> Hi Tom,
> We are using this driver, we are refactoring it.
> Already posted a v2 for the same, please check:
> https://lore.kernel.org/all/20250725043012.1186886-1-s-jain1@ti.com/

OK, I can defer this one. Please make sure that with the refactor (and
likely a need for a v3) that it either builds on sandbox or has
sufficient Kconfig dependencies that it doesn't show up. I hit this as
part of "allyesconfig" (which today has too many failures to count).

--=20
Tom

--oTnH2TgjRVWSs0C/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJTMDQAKCRAr4qD1Cr/k
Cp9WAQCH4mxXc3eDcIBwzNMXZH0dcCBHPaiAgYR8xtdwYsXRHQEAjs7Or+pn77ht
QF8KVHBHSAS9WJuabBcOzHDBRenKpAY=
=mhV3
-----END PGP SIGNATURE-----

--oTnH2TgjRVWSs0C/--
