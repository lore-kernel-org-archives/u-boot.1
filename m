Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E15D0EE1C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 00:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B0D8941E;
	Sat, 12 Oct 2024 02:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KtZSBPdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBEF289429; Sat, 12 Oct 2024 02:36:18 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE651892F8
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 02:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4603d3e456bso20758231cf.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728693375; x=1729298175; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=moHmRJpbKtf67yg+82797yLOIgxsVQyoftVXoEUca4Q=;
 b=KtZSBPdd2X4MmcE8a/Sz77aZXHbv7L1YqBXmk90+VWHR1P4KtqxX54Fu/zRJ/6EJ9Q
 K6YZwzwBDaWuICQ061ghfxuzEIrPKrzAF4R7bpq2+xdwhf/5XWLeR7lmGbaT9T7IL1S4
 yzaOvCwK4x//HLTjK3FNrQ2sfW4ZVUQIgPW+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728693375; x=1729298175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moHmRJpbKtf67yg+82797yLOIgxsVQyoftVXoEUca4Q=;
 b=qgZLqRXETBRjeN7jLvuiTSj1lI1EyQkNZhuRXnmWhjrSGxJUsreuteAF/Vf46rgVwM
 /81q609+AMm3iLDMJzz0guMInR6IEDTgp9B8lULsN8tCxSyyWd+ggRub98v7FDvpIZtA
 2MoZxKQOn11wrzROBCrpnmFdBIUYq5N3LrsBtanUNxd8qfLLTmqjV9O9SD8aB6vIeMAd
 LK6765eb9TflA9bKYu/w+YEPkuwoW4bSpXbGfQJpArA1MhoB3tBGnzmrwO7/0iUsihAQ
 4OddQSe6M2PbYMKCZtT/jo5tXfXUyVBnD4g0m2B8F9IUT+xuDRPMYaWZSdPxoYX+GfVy
 0YgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUugJNsnZLW9VDLUqS+h0cvO6byLnEacZbeMDIyvtNzu3V1eHtA3rt+VTJRx/DgtGNWwKtz/Z0=@lists.denx.de
X-Gm-Message-State: AOJu0YyYOBD7Apj82zIcwYXhqgRI/bT4D9vh4b2IUwqqCW2cwzupZY/E
 y5s0fPvFp5IkTdmUwC6PUJvr05tZ0hGIGvvU6JLZ0SLH23ME4zfdwWbyRSOS3SU=
X-Google-Smtp-Source: AGHT+IHovrIp4nxX6LzUwrh/0bRHf07A/rvlwFSETowgHMuJB2mn9HuBZA7xUAAhuO1FZZqVLJmJHA==
X-Received: by 2002:a05:622a:2c5:b0:458:2b0f:6b59 with SMTP id
 d75a77b69052e-4604bc4cc92mr63368861cf.48.1728693375498; 
 Fri, 11 Oct 2024 17:36:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46042801ee8sm20746221cf.40.2024.10.11.17.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 17:36:14 -0700 (PDT)
Date: Fri, 11 Oct 2024 18:36:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
Message-ID: <20241012003611.GB14210@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <CAFLszTiGHhU3LgUu7bv-oYd3b-4Y5-OY=LZhTGcQ4vvpu80r2w@mail.gmail.com>
 <20241011225438.GA14210@bill-the-cat>
 <64416580-3AEA-448F-B625-51195B08D1EC@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R/XFAuAoJTf0G4Pj"
Content-Disposition: inline
In-Reply-To: <64416580-3AEA-448F-B625-51195B08D1EC@gmx.de>
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


--R/XFAuAoJTf0G4Pj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 01:45:10AM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 12. Oktober 2024 00:54:38 MESZ schrieb Tom Rini <trini@konsulko.com>:
> >On Fri, Oct 11, 2024 at 04:18:07PM -0600, Simon Glass wrote:
> >
> >[snip]
> >> No other subsystem generates ANSI characters when U-Boot starts. Why
> >> are we creating this problem in the EFI implementation?
> >>=20
> >> So please, I very-much want to have a way to stop this output from
> >> being generated, not to filter it afterwards. As above, we should
> >> design U-Boot for easy testing, not treat it as a black box. Please do
> >> seriously consider this as I believe this is an important testing
> >> principle being violated here.
> >
> >This is, I think, a good point. Outside of user-facing interactive
> >code, we don't use ANSI sequences for printing information in
> >U-Boot anywhere else. Why are we doing it in the EFI_LOADER code outside
> >of personal preference? And, can we just not instead? It does confuse
> >matters (as my example showed) when problems do arise.
>=20
> Tests should be executable on any U-Boot instance. I see no virtue in a s=
andbox only hack.

Right, and I want to know what the particular problematic escape
sequences are because right now it does, on hardware, when things fail,
put a bunch of un-rendered escape sequences on the console. That's why I
was "What's going on?" and not seeing that it was the banner count
issue.

--=20
Tom

--R/XFAuAoJTf0G4Pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJxHgACgkQFHw5/5Y0
tywZpQv7Bi2wO3owJX8hgTFcaQec8EmA2v+22dpA61AfS6cEPDtLqE6+wIyk0FNv
21Ed/QbTVr5OYKvXLM7qPLm42L1NSMcguApCIwkblG0DSHuCh5s2XDtVRIxEUR4G
8Bxj2LFX8Ewu2ozeoHXfVYsVPibM/e1ejRKRj2C4WZgkJNOLFmg1dqnxjDVizZsN
jqAy/pNfRHh6UO39XfnEGDJYba68Zgedh8txYVEDk2GEVR/B1Q4QT4H1AaaKQTmK
0W38dB806ertBnzYiX1CmYpau1n9MDzi49xPuE20P0vsPynChQSTAyWBdKcxsuOu
fpC3rRCtxx6DOXyD3cxFOvthSaaRL/NEc2qfP2A3S4aK+Mcr29IOtqqjaoPKzQdI
kqi5PqZvX2HPwzDhlZoHLm9tnSJx+pkGXjrsEK345WZCpBUoD1AHFylVYU/pPHkw
tvr9Bf4Ohc/ALsna5TYLL2MA/CcFEgJtTx3yx/RE6joiMMjtenARjufqvTR8nkpL
LVJjLj2+
=YuMP
-----END PGP SIGNATURE-----

--R/XFAuAoJTf0G4Pj--
