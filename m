Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9ABC71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 19:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0CBF82B0F;
	Tue, 17 Jun 2025 21:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UhDADAc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB6082BA1; Tue, 17 Jun 2025 21:25:42 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB19A81FEE
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 21:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-407a3c10d03so3786396b6e.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750188338; x=1750793138; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TCSf1I5r2di1/SFeUREvNkyljNSSS3LlDd0DDQDc9nQ=;
 b=UhDADAc3yFwWYY5Yd00MXgdmWkDk4qsQ8uFAL2QvREplq40cZwgBhN9lzqN+tN8jfN
 pUfixGfFtoHtmZCzpkpkgwx0XoJuhyAAAG8Z0MzH3dVdTzZ/F1muzZTzRGkZPuVKKWap
 STCsAP+m600nowpjsTM9wGEL4dxpQad37oNWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750188338; x=1750793138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCSf1I5r2di1/SFeUREvNkyljNSSS3LlDd0DDQDc9nQ=;
 b=OQeFgC9b5u8d5J+9otS7Ju4gQ/rgnrrP88hWz/ARHcC/NxovMyDDbqg7qWcPDhfaUQ
 vPTYx3agYtm70SKBv+qnz6Ud+iW2qdvSPHS3gCChLK6WlpVe11hXQN0oxjVLgo+OZezS
 vpUlp7grsldlf80PFm1mRBqgmWJ04cfzZisISCphCPOb/aAlBE1LuqqV6QYCnBPADDg5
 9dCCm94zW1EX2mgEX/wq6EYSkyToXtq3fRtPhLLszWH/M4Cxuf2t4qUQSMyMFcwttsWx
 qrYnTBxhIbFF6YR2tKOK1O6Amf/QwAMZd7JPguQ10kH7/J+Q1ogoJ8wQgl/XllDnDxF4
 BX8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXq180cjRSVolfLNHTmJi5Ml4IwswoTrVQTWEia7yvWUxD8ZyF+HMZQiCNAeCs8xptEAxF+ec=@lists.denx.de
X-Gm-Message-State: AOJu0YwDkwyYooUMvjIm7i9QNTC0EMnf17w3/TPXl6Uko1VdtO/RpXPC
 1PBtzvE2HgJDjSPel6NdDPu6LgNn8IYiSJZXwBcLPgJEhOykIkYU1PkDishRUv5bFxo=
X-Gm-Gg: ASbGncsl1sYGetVJ8QAZ1dqdQxpdazpCHJjEz/SY8tR+ir2GpL06CsNvnz7mQ2YTToS
 3tp3nvo7uXsUOLz69ihAynOmjAZflFXGmQyITVOk7kcSH4YnwbzkJ+hWmuc8tMb+4IaJuit5x2H
 B0OM6s3H2CAdX+Lg6M7SMUB6vqYyAfIh+EQD1L9y8f6PctUwmaQMSmYsdjwCO81sxshYRNVay/B
 JV72zQ5VS+0HXrNy43GtdwiML4xqpDVhEcSfJYiMo04VNepva3YFChFYUdvxryF4YlLr7fwlef8
 vuICtCiTe47OJm8ig4gtboDResQGef+/w7dQJdkweDbzKeG6gWFPFJV7xqQ0G2pNBjMK282YZ/Q
 sPRfQ9EU1ZmUBHka/Mgx2eGc=
X-Google-Smtp-Source: AGHT+IEECe9dss7jbYX0OPe+DMiA4Ya5nU88zsXfobYIcT9Xakxc2acCUK2kR4Xx+U3sE0pYEa4p4g==
X-Received: by 2002:a05:6808:3a17:b0:406:6671:6d11 with SMTP id
 5614622812f47-40a7c1dc694mr7485911b6e.15.1750188338475; 
 Tue, 17 Jun 2025 12:25:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a7418a3b4sm2078365b6e.34.2025.06.17.12.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 12:25:37 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:25:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/8] Qualcomm: teach the build system to emit signed
 ELF images
Message-ID: <20250617192535.GN1382132@bill-the-cat>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
 <aa490fb0-e485-4227-8750-70c66c308bd5@linaro.org>
 <6da50198-445e-4e50-b2ec-97a385c5b2eb@linaro.org>
 <bf53c55b-b554-4a1e-9edd-043a02523e03@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k9ENGQIhbu0bxsa4"
Content-Disposition: inline
In-Reply-To: <bf53c55b-b554-4a1e-9edd-043a02523e03@linaro.org>
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


--k9ENGQIhbu0bxsa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 11:15:37AM +0200, Casey Connolly wrote:
>=20
>=20
> On 6/17/25 10:26, Neil Armstrong wrote:
> > On 16/06/2025 18:13, Casey Connolly wrote:
> > > Hi Tom,
> > >=20
> > > So I've been testing this a bit harder (really should have noticed
> > > this sooner) and it turns out using binman makes things a whole lot
> > > more complicated...
> > >=20
> > > Specifically, the new trogdor chromebook board doesn't need binman,
> > > the U-Boot ELF is used directly since they have their own bootloader
> > > beforehand.
> > >=20
> > > But since CONFIG_BINMAN can't be enabled in a defconfig and only
> > > selected by some other Kconfig there isn't really a nice way to
> > > handle this. The trogdor board doesn't add any Kconfigs of it's own
> > > and doing something like
> > >=20
> > > depends on BINMAN if !CONFIG_SYS_COREBOOT
> > >=20
> > > would be a huge hack...
> >=20
> > Can't you change to depends on BINMAN if CONFIG_BINMAN_DTB ?
>=20
> No, since this creates a recursive dependency

Hmmm. Is there further symbol games we could do here? Perhaps we need
another symbol around BINMAN functionality? I do need to re-read what
you said above and think harder, sorry.

--=20
Tom

--k9ENGQIhbu0bxsa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhRwSsACgkQFHw5/5Y0
tyyMVAwAoyvVgYHunYFP9sQbej4krb0Wciz/XfQDB78fSqA23u/X9OvFwe/gsRiR
SI6R08jWsLt6jcHH9f716YzyzzNs1fMj4WlMWE0q8q5oPYe28metNJXSq4ReTpoi
TOxYa1G0BcA+LxGOtClzuBeIMqJLkYjRUPrwAGLVnn1RZGVpLcy1moquDYw0LJTT
xR1lLee4yxxUfibtcr6HvCTSNPqJnqLkFAYgJYuaBNMe8vrDDOmnh4P+THATfZk+
G/lsaNlSjpqqJnfV8z22DVR+ymFpJAuxLXA94SrClrJjMAeSoD/XiMjDJ5pqNk31
icFCWhy04qEdoZqqdkv+GC+Gn3ebe6BWvayHRAMeGPsvSZRGeCd0GKpigQLg53WC
qQnqD9ftkWQ95wp9p4cu4OBWrYV8eksNn8pAuHm1O68lskCNV5LQb1Cy7+6lu5JF
Ml+1XXoltFlLPVerfipcw9auaFWzQoH9EaDrvoLdC3qgXOpCmzOel4O2McYhgJwu
ZcAmEfUi
=pOp5
-----END PGP SIGNATURE-----

--k9ENGQIhbu0bxsa4--
