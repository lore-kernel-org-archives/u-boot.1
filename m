Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCCBC4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 15:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32DF786F8F;
	Thu,  2 Nov 2023 15:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hL5RMhVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 540A286F8F; Thu,  2 Nov 2023 15:53:40 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE43F86FA2
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-45d69a97b17so377228137.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698936811; x=1699541611; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Td8D+hmO6YwzysknhvjcwIgCWXQZSagFxL9z7DvsUY=;
 b=hL5RMhVir20m1uqQy9DbccjIxmEIo9U/HttCyOqxddSKa48AIp/Oolvtccq2yJO1yP
 /VsVNsORJYqX62am5rOuNs939a+aiUXMRO7ig52ORdVXheAgfs+M2aN3TOedWv/afqpY
 M6Tr1ACHzOmTBIZwnWBLLIWpxI0kz1E81yN8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698936811; x=1699541611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Td8D+hmO6YwzysknhvjcwIgCWXQZSagFxL9z7DvsUY=;
 b=Ycb0S3ZtSX1KoNmc/aiV7M4VhQCHbj2IBbXoN8TsZSTwlYOaV+A/6Ml9OYtH4AKJB5
 em1PFmKfRTd3Ryb9IyJitMpuICyNAm7nwsKi+SgC+V5Jl+T2WZZYlpNaSJ83kX0U+ofF
 ULbk7Gcye4x/8T+2M90O+VzGSkV7QJbnykZdNAOxhy9OL+3prcw5XejiXWXT9Oe8mvEg
 YH5dLD/cbZNiutDXvnkdkrrwwp2u4qsFxh/yGYoTUSkJbme+WKdHTKJY1rMcTesEYHCo
 f7vkmxClH+2D+rGY8ec8fsKJsRtW1+FbSkXRgGpywJ330hBVCbfTJjZHHq8eG+kXM988
 m8jw==
X-Gm-Message-State: AOJu0YyL54rblKIEJacPTdl9jQq6ErYLPyLfVK2f2VDEOCg3f+SBGdp2
 8GdrIbE1Id7hPpMBiGV3tbQDBw==
X-Google-Smtp-Source: AGHT+IFx12u5i61RuJX7wJcgxD/OHUW19KHq6C15WKu9UXoAa/Kaglw2DZ8pg/3sswsDYPYYOkWjmQ==
X-Received: by 2002:a05:6102:10da:b0:457:d682:913e with SMTP id
 t26-20020a05610210da00b00457d682913emr16840595vsr.32.1698936808029; 
 Thu, 02 Nov 2023 07:53:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 z17-20020ac84551000000b00418122186ccsm8364qtn.12.2023.11.02.07.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 07:53:27 -0700 (PDT)
Date: Thu, 2 Nov 2023 10:53:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Yang Xiwen <forbidden405@outlook.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Jim Liu <jim.t90615@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>
Subject: Re: [GIT PULL] CLock changes for 2024.01-rc2
Message-ID: <20231102145325.GK496310@bill-the-cat>
References: <1244a946-5e87-d470-ae66-0e56c5cbd36d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nNtSSEMzvuglmllo"
Content-Disposition: inline
In-Reply-To: <1244a946-5e87-d470-ae66-0e56c5cbd36d@gmail.com>
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


--nNtSSEMzvuglmllo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 05:03:29PM -0400, Sean Anderson wrote:

> The following changes since commit fb428b61819444b9337075f49c72f326f5d120=
85:
>=20
>   Merge branch '2023-10-24-assorted-general-fixes-and-updates' (2023-10-2=
4 19:12:21 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-clk.git tags/clk-2024.0=
1-rc2
>=20
> for you to fetch changes up to c4b52fda6924e92c6745351f32c4cafc36034170:
>=20
>   clk: also handle ENOENT in *_optional functions (2023-11-01 15:14:51 -0=
400)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--nNtSSEMzvuglmllo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVDt+UACgkQFHw5/5Y0
tyy4SAwAkL99mGlYFDXPmjFjJexZL8kBlPpKdMkktzrYAMo0tgYlzLsaQZ26+7RX
+dh5BkYTB6/nrX5K5fq4mTmGxmt0uqVVP/N31tAwDCsXw/6EvBOgfqq6Tln3sQKs
PSzT9QlYHOj/Be+/dW8AUFsuxIVCBNeCaaHfbuu9JXGIJP0k9s+3MhDud4sB0ufQ
NSwcQ1n7M+hkaWptn+nXoBE2H2GvibkZaZ/H0kaPdyisgdJ/rB7bZjXp9/70CpvM
8gDYNPRYi2AxhVX4thGYX192imRGcM4Q4TZl0cl7VqWchVSy5C0pQfDZ03AKLcBQ
HYoWT7X0ZfOwiitc9WkRToAESlZ+pYiQAGK/WLEkpZ6jbpHCi3XC7K+fU2Sp9yIC
kEreva4RbTXUAw2SGn2TwB9pQP5vOleCFcv7cnrFEkHYI1+lOSTaQRrnq3bt59mL
s+Um9WiEu5IxzHNbgxIPDP0TvwEcVsUz8D7Tacqa3HTb1OWcNjwXILHVfKWw28zy
x7vdzDsQ
=e1TE
-----END PGP SIGNATURE-----

--nNtSSEMzvuglmllo--
