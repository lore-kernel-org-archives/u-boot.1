Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2129C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C5887677;
	Wed, 22 Nov 2023 21:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JZPCkylD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 468A68768C; Wed, 22 Nov 2023 21:50:07 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B5F8765E
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5cca712b715so1872107b3.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686202; x=1701291002; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9BJWvmRLcKA5/WY+VdcRfZPKEAeiTqoU+wkQFdu229g=;
 b=JZPCkylDF1VGgGWYrHvT+OAlcNQMTFiCJTTHiD+x3XzuOQsjAfSmotQ184S0+QPQVH
 yFxbpbbXfPth7NTuifeqKDKqXz+t/rrqHeTFUAhpRRw5crkZLh6phXkVLCOYSGLiaJ1j
 0+XutkvPwtyuXFE47pqIeWqguM9311LweNxrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686202; x=1701291002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BJWvmRLcKA5/WY+VdcRfZPKEAeiTqoU+wkQFdu229g=;
 b=V8iHPns1cMeWQnv44XhFg5OF1cw+QdTQ5bsqxDGAL96xnX2rVbvFgLrUZ0e2fdy88/
 H5U9dwCp0fBP0ErJGApwPLEMt4Ad6O+fDI77NWEeqjZ9vD4imDFWJpNwrD+oAaq69Np4
 p4c4L2MJ/dJh1B8mza8v3f3S8yGUioaPK9UcNueBvKhuUh0ba/cVbAKSAh+ahZ/ibx40
 +hkFXW2wCZFffN1lf9wldKqLlbGS5EUQ/23o86PIrcCARcAZkNF4rXsBzAjwXyoNa2mm
 mEIoDKLakBIdxtd1HiH/wkMqb7tRgycpD75b9GNa8Tq/Jcsc48p8H3MMirNcODDxTUEs
 p6ZA==
X-Gm-Message-State: AOJu0YzCL4US2S1wl6gKsnOHs4yalhS/ULMuPNj22dKTfeZ/b7ub26jH
 1KVZgqZNmi4zBMUq98BwiWvj+A==
X-Google-Smtp-Source: AGHT+IGj8Xvb0BIeI2B2XDafUbcw8FSGboVhPsTndC5y5r5PisuI9EAFJcXOk6mPJwSApm8reaqegQ==
X-Received: by 2002:a05:690c:2b84:b0:5cc:d89c:cefa with SMTP id
 en4-20020a05690c2b8400b005ccd89ccefamr1681761ywb.21.1700686202358; 
 Wed, 22 Nov 2023 12:50:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 n62-20020a817241000000b0059b50f126fbsm86286ywc.114.2023.11.22.12.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:50:01 -0800 (PST)
Date: Wed, 22 Nov 2023 15:50:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Reid Tonking <reidt@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de, n-francis@ti.com, u-kumar1@ti.com,
 vigneshr@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH] arm: dts: k3-j7200: Sync with Linux 6.7-rc1
Message-ID: <20231122205000.GJ2513409@bill-the-cat>
References: <20231113204309.3246434-1-reidt@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fq7QQ5GQxAOHY+4Q"
Content-Disposition: inline
In-Reply-To: <20231113204309.3246434-1-reidt@ti.com>
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


--Fq7QQ5GQxAOHY+4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 02:43:09PM -0600, Reid Tonking wrote:

> Sync u-boot device tree with Linux kernel 6.7-rc1
>=20
> Signed-off-by: Reid Tonking <reidt@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Fq7QQ5GQxAOHY+4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaXgACgkQFHw5/5Y0
tyzAtgwAnmbAm6ubJwsVbleiZK78SrkXsDrepSd5CfRkoZGVD9oct0PKdZf7Qn29
PqSPnKh2K/mv7kxZtBFO+M9jjB0foeK+Km+fkL13M7bh3JI0yDi5WdSXhGENjF+i
tfi972IMCwS+qKy1MjEmH9Uhw6j0HyM/xvqDNsRPWgR1Tx6igU9HMRp8/A+2E1Fi
SXE1XnZvHG899xVT/mBnAzQvNqrq0EGmHXpcW9phGye7cODyEiq8xsQrGOA8xzYl
/2XErhz5TqQxWjfh6v2i1CE1SQ/n31xNgMc4ETOXkQOKuNupgnyOBYVskzUXKeta
NQ8kD4PPM41m+lTBjA5Pgf4rfqHw2f5O7nUJksnXho2OaQI00uyY+iZMtzjh9fTQ
Shn1Uo2W+EuFMEeDqcrD3Oc6ZfwPEk2jEvMY+psDH7MTcfh0rzDp8l6mOLcWdibn
QRj43cTozcXpDr1BPv/TEcGDHxY/lDN7MFZFA/S6FodfDL7b1I2s27fkifMKO0ow
zIXhjkkg
=le+h
-----END PGP SIGNATURE-----

--Fq7QQ5GQxAOHY+4Q--
