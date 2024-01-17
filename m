Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4B0C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D2187B9C;
	Wed, 17 Jan 2024 15:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mNBkI90C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0B887B9C; Wed, 17 Jan 2024 15:27:09 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F2B87BAC
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5ff45c65e60so21553557b3.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501626; x=1706106426; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Dgo+c3/dvXiiBdVBe9USuq1XFwKY/wSkrTZxqVvoqU=;
 b=mNBkI90C+J4YkpXn1ey1qPX4nueCNzdOPXyH/S/VSqySeR6s8uFBUGz6gZVLqeHpR8
 nZC1PFfodW+dUG45M0UlNmR0GvYiRCdXAot2z69v38QhwUt2K3SESqjb8D3aS/4hklX7
 KqLvZzAqN2A+86Eofo1PpqGaWA3Gube56Q32Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501626; x=1706106426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Dgo+c3/dvXiiBdVBe9USuq1XFwKY/wSkrTZxqVvoqU=;
 b=SrORtWOCyWYFMl2r08FViVc6uZ53qeRYWzudY5CJG3nrFfPB1K0YhV2yyJ2vRVt6jC
 8xsbVMrEy9ZEekBkBgSNabC9GqwLqNEMU6mDaOchkMhgAY0g+fzVnVS9yzIbpZlf8wlh
 hIDczQ55gx8gdooJhIsL9o2B6CbIVQLL/pyX2vZdEPEnqZSSipuWUBUqUVGA3bQZIm/+
 Mu5H7969S9DvimY3fMy6LbXScpvuslaye0+aNi9Iww9kRSpZ+c360xcyjxg8mIVe1GW8
 bxurUuMrCbrz9spIOUnEmXoilVLILETNmQNhmP+7qkMGC5A/V1LvIe9COghrvtHeeEmj
 Kiag==
X-Gm-Message-State: AOJu0YxnsWoZm6AafBxxcmOLrlSYnRQrXlFY119BMr1gB5vdCfoYM9sx
 FWyjyG0PFzot5zlE+zzgpyngKWjVwsUiZQ==
X-Google-Smtp-Source: AGHT+IFSAkSa/+LnxOo3yAzLPvADJ08b/h/1KPEMYgohOVQwVgrTXiB9P2RDZk/uNQ7dFqaZ04Dyfw==
X-Received: by 2002:a81:830c:0:b0:5ff:6b4a:8ec0 with SMTP id
 t12-20020a81830c000000b005ff6b4a8ec0mr532261ywf.5.1705501626127; 
 Wed, 17 Jan 2024 06:27:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 cd10-20020a05690c088a00b005fb56881fa9sm5659464ywb.15.2024.01.17.06.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:27:05 -0800 (PST)
Date: Wed, 17 Jan 2024 09:27:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 1/1] lib: smbios: remove redundant next_header()
Message-ID: <20240117142703.GU12635@bill-the-cat>
References: <20231223011734.248809-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SPiKcNwu751PFP8U"
Content-Disposition: inline
In-Reply-To: <20231223011734.248809-1-xypron.glpk@gmx.de>
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


--SPiKcNwu751PFP8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 02:17:33AM +0100, Heinrich Schuchardt wrote:

> next_header() and get_next_header() only differ in how the const attribute
> is used. One function taking a const parameter and returning a non-const =
is
> good enough.
>=20
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--SPiKcNwu751PFP8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn47cACgkQFHw5/5Y0
tywF9Qv/XrF/tgvWDgJaAN6btja5u1IzNTonjtG0ZPFm9HC7Yqel0o8XEezA/eEG
95OWz9z14KHTtweRDQcHjdQR/QCpj0dVRRyu4oTFl5dvTGAtA5VAENuIQTMB+hv2
0GYVZkyvOHGXnaKkBl6K6UEWjVrXqytIXre/TXW7H/jjfYQ4/6HRQWBr1c8K/eDH
LH54PctC2ke/1s6sGkpNsEqGbumzqreIMeS2XAxlnKNGlOvXYes1nWomdCvUz1yI
I3dlpTcA+8K2yXIvFgLfAmY19VZXiHrWiu3RRPgRTCetSWEiMx2BdAGKcOlwXVLF
BEI6NobVVzuwFQOIjahNjZ83h5R2n9slhQotKKVpA5tstA0yjKB983qY8QxCUbFW
kg6iZUYfVmbu1jkIRMqKoALdxqr5zQOXFiosW721JuIrGNkWxuTZur9GfBUE4EWu
6GjsO27f39qukqSsDAH8qPy411h9aTpOasHR76C8pHR+rydPFWYPmdVjmVfvTWEB
6IWMm6iA
=KjGW
-----END PGP SIGNATURE-----

--SPiKcNwu751PFP8U--
