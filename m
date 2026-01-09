Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DBAD26D8F
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 19:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E95F843B6;
	Fri,  9 Jan 2026 20:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VmrLIK3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D699E843C3; Fri,  9 Jan 2026 20:07:52 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A45843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 20:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso3169607fac.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767985668; x=1768590468; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XsSUCdCt8ITIANL3JUooQQ4DehAzgMaTWInd8QaDl3k=;
 b=VmrLIK3xx4uksAdCZqMFO3IlHlk7V+ghlnRz0UUqHRlJqc/JHbKrE5y1KScByS9rXz
 2E8IljqWNvuQQ2tdVXX+sDBi5E88aQkpnl9omjb5roRC/uw5NDIy8mt5/zTyZUuIyVzf
 +aAH+D8qJ8u4LtLY50WTszYP2CSQXoXmL0pg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767985668; x=1768590468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsSUCdCt8ITIANL3JUooQQ4DehAzgMaTWInd8QaDl3k=;
 b=ApEZooFFVywiW6TcFv7zm2gpjshDcTAutlRZYzk4NdDFPOt80shXEBDoaD2qrabSac
 Mt/GYiat6UumtKU3YBd5+MOVShHWR5nXqTaxPW6oU0qPuWv8hLobPmRonPbIvS4KDC4c
 G4H5U/1rxmRpNxyoY25VX7+HPBTqCHwg3nluCQxp9y9E6vPVMKBndA8HnvfoauKMXoIY
 L73cX26R+qDUpFF4P39IWBecKWAGUEOjDSrD8uuEglTKryc9R5anwfKcH0tOLdghZEL4
 DzPUqOiTddBpuNEgkZWszux/TWdBu5D9ooJ+M/+ia+QeJDQS4OgUwNM/yG2tde1jW50e
 /3WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHBV2tE2XczbNOAxz1L4rR4SloEbD1m5jGtAIBrNUij5aPkyQjyoLcMZAo8Ivfj2+baHYKgdA=@lists.denx.de
X-Gm-Message-State: AOJu0YwO1Gd4Bx7Y8exyScwug1C/RDNhUWmszZmeDstGKYN8eIZKhreF
 jBBjMj+CVpfxC7DFWscXqBJxA/gspt3lUGJxT9TvveGi5fLaY3/stEXp4y/kg8gmtbk=
X-Gm-Gg: AY/fxX6hUoo5t+NH7l8m7Y39SFXsImG1/pMtVuAls8s4ojm8W6nQNtUsQ38X6MNqlnH
 EcgG1fN5CfEZd7/oGxf4XhmR0j0c0ajEaUupkMg6LUQ+nBWTnpCQZDBbuBoUnGYiw1Ag/GXggjm
 hPw/6nTk+KvnGUnsWyGxmJk2jvAdz8H2HHd6dY4+aYD0UN1S060CO+UyFc8dlUZ9/ROsTcJbB+e
 8QEL45vr/zJtFAcXNWVS3UkU0iwtxqNGW6PBcPTsSHNlGXoxXnBioEqfikEy8zaOi6Yp79kiem7
 U50WVcFX+Sa1kscPmyHhBiGcv9ck+wHYRUysp0yW3HUShDNjHCA1XpyWcPYX8El0QJzymLBwAln
 R2DeOhdqn9HvzNHpFNSCmh18ipZ+AdOPW+PtiKWVrsd/ujt93ItBqEEFf3p95Xa5rrL1wpPpf36
 eFSaKOmfqjn0bWBlbXLTQq1DsJMjcc+bZWI9DoP7tnJsG0vhvvlHtiyfigQnNurG2TRKHiZopQM
 2NwEp4+bmaNDXD2tkhSu5OUFylBBWW0b4uaNVU=
X-Google-Smtp-Source: AGHT+IHxH5yWy8851ix/lFW2oCIG+ChXxljkJbMMG7IkncX9mpa/OKl5MQ7A8nzEzVxQ8MPVYoyu+A==
X-Received: by 2002:a05:6871:69b8:b0:33f:b3dc:23cf with SMTP id
 586e51a60fabf-3ffc0c0d892mr5991979fac.50.1767985668520; 
 Fri, 09 Jan 2026 11:07:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa5072427sm7262693fac.12.2026.01.09.11.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 11:07:47 -0800 (PST)
Date: Fri, 9 Jan 2026 13:07:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com,
 anshuld@ti.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
Message-ID: <20260109190744.GI3416603@bill-the-cat>
References: <20260109190026.58464-1-b-padhi@ti.com>
 <20260109190026.58464-2-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IRSP2vGNn6rlTNKM"
Content-Disposition: inline
In-Reply-To: <20260109190026.58464-2-b-padhi@ti.com>
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


--IRSP2vGNn6rlTNKM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 12:30:25AM +0530, Beleswar Padhi wrote:

> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
> packed inside the multidtb.fit FIT image. While the individual DTBs
> and the FIT image start address are 8-byte aligned, the DTBs embedded
> within the FIT image are not guaranteed to maintain 8-byte alignment.
>=20
> This misalignment causes -FDT_ERR_ALIGNMENT failure in
> setup_multi_dtb_fit() when locating the next available DTB within the
> FIT blob and setting gd->fdt_blob, because of the recent libfdt
> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
> version v1.7.2-35-g52f07dcca47c")
>=20
> Add the -B 0x8 flag to mkimage to enforce 8-byte alignment for all DTB
> entries within the multidtb FIT image.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--IRSP2vGNn6rlTNKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWFR/AAKCRAr4qD1Cr/k
Cvc6AP9O9e87Pt5SseKuz2BvJ2Dgo61w5XWmBZdhXdl/D2S7EgEA/S7njL0fUDBc
irb55098J1MQ7DaLLbgmhIHRQqFHEAQ=
=ceRd
-----END PGP SIGNATURE-----

--IRSP2vGNn6rlTNKM--
