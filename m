Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FF8E7B61B
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 14:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5B98752D;
	Wed,  4 Oct 2023 16:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ujCk+Qmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E1C87524; Wed,  4 Oct 2023 16:06:00 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D0D874E8
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 16:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59f7cc71e2eso26654937b3.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696428357; x=1697033157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6ExBqbHsOuBuqZ77HPm4C3JzpUmBxEtYuxKbTVN4Fsw=;
 b=ujCk+QmfFrRR21tpR2OcvNMTqlKIPGQB54rTmNP+N+dXZ+16iLVTNOEcWu+H0zd4em
 bxVy5tq8UDFCTJq7dqa1GZFx1LeJJcx4BHkISRSzjZJWVDpJDL+GVisqTux5MeZfiF3Q
 QYDmJ2Co+y5kixA3PVHb+Pja5nDkAajIfA7DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696428357; x=1697033157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ExBqbHsOuBuqZ77HPm4C3JzpUmBxEtYuxKbTVN4Fsw=;
 b=G9yDFYVvxznNZROd+W0K6E7W6cD8YeRylPXJ4dhmR5S9tizOKu22smMdwLDzZj+T9a
 bIxU2sFk7kUbuIOzzZTJbGvzfi47XyawA/LyszIS7FM7bdGghlPkcggbCT7P8LiiQHrK
 gjdNu5j+htJFmFv0Yzur570qn+3RZRkMCC5wJewtaYeKjIDiESatwYqbt6DZhA3T3/ek
 /taUv0LLtQ5wMKxSR7bkBS/0pi8qGGtAlnNS63KT+maRUWi9aPxeKT6a1rvsFZ/i8Eln
 BumoTGpeTbx6wB5j6SzKerV6eKVWLfN+B3mm0OqCbi40h8YNDqlMCUIb+iBKPCD1u2kJ
 Xduw==
X-Gm-Message-State: AOJu0Yw/I0KtrDB7MltoCxw8GM94Zaq7YVP1nszvl4XzV+TI9Fqk5Lh5
 o3/7dVWpDShR+DMMcH6dq/YLQw==
X-Google-Smtp-Source: AGHT+IEi02IVtVeJBdZzw/YK6MtGDHNkTRM8zvDmvGd0ztTPU0pCf7f+u9KfgN+0POcuBVfyR0IdOw==
X-Received: by 2002:a0d:eb90:0:b0:59f:81e3:3be4 with SMTP id
 u138-20020a0deb90000000b0059f81e33be4mr2856350ywe.14.1696428357290; 
 Wed, 04 Oct 2023 07:05:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1e7b-517b-66e6-a4a8.res6.spectrum.com.
 [2603:6081:7b00:6400:1e7b:517b:66e6:a4a8])
 by smtp.gmail.com with ESMTPSA id
 g187-20020a8152c4000000b0059f67a72276sm1172614ywb.17.2023.10.04.07.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:05:56 -0700 (PDT)
Date: Wed, 4 Oct 2023 10:05:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/1] input: avoid NULL dereference
Message-ID: <20231004140554.GF8465@bill-the-cat>
References: <20231003010901.98121-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2nIOD9H2OK4xomss"
Content-Disposition: inline
In-Reply-To: <20231003010901.98121-1-heinrich.schuchardt@canonical.com>
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


--2nIOD9H2OK4xomss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 03:09:01AM +0200, Heinrich Schuchardt wrote:

> Before using the result of env_get("stdin") we must check if it is NULL.
>=20
> Avoid #if. This resolves the -Wunused-but-set-variable issue and we don't
> need a dummy assignment in the else branch. Anyway this warning is
> disabled in the Makefile.
>=20
> For sake of readability use an early return after the configuration check.
>=20
> Checking CONFIG_SPL_BUILD is incorrect as env_get() is only defined if
> CONFIG_$(SPL_TPL)ENV_SUPPORT=3Dy.
>=20
> Fixes: 985ca3945fa3 ("spl: input: Allow input in SPL and TPL")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--2nIOD9H2OK4xomss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUdcT8ACgkQFHw5/5Y0
tywoYQv/XurxJdSX1s1rW1cUdp/xWhDt879jVaFuND4Bqvxag4WzHqZmag/IxlXT
aK4/mZlyK0D80U+EgpRHTOQv/9xIrEgpaAhwV9l6lNFm6MsjZ36Uiny3mDVu48ok
1+fmRX5S1CW23JFIn76rbYgXacmgV5KAObvcQa2SgwUcxs44W0X89+IKHt9lMlXA
7FIfrfrIpfHXBK730F/67wCPjNq2/cA9748FPBoC2aeusin0NvTN6B8QhSHw87RX
x1jTWZbPD0g/lp3N5fqKPToMmVsuTM+PmYkcyn+DjxRjriyV9dXl+tVJ6jCU7Slj
AWZtXrpOFnlzoBV2OKfxCvz5EGS0FRY1av8B79BnusV7egiXABoRDXD+LmTPhmLs
btI7FBdohItJcMyFdhrknghgI8g9pXQrzvX1yLbJn71rmmZUxcIkC09tNH8L3cxp
AVRApZtY1BBc/hz5DK+yT6+obVOKleW+e3E43db9LXz5q5SwCZHKxDXfdeH9dN7g
gTRPZgi+
=k+vH
-----END PGP SIGNATURE-----

--2nIOD9H2OK4xomss--
