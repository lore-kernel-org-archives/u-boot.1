Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9204D20683
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 22:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA128806A;
	Wed, 16 Oct 2024 00:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g6IRokXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C41B187F19; Wed, 16 Oct 2024 00:52:50 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1890F88216
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 00:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b115d0d7f8so33534985a.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729032767; x=1729637567; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FY8C1CeAogn0+gLT7psVb27HEjVEe52fHJXiglhlTHU=;
 b=g6IRokXiUQbRZSlo9luMgO6LIar767hDttJyz5EsH8c6Fwg5FTiOhGFS9THwqUAGU9
 Jd4ANYa3RAr5oQL03seoaCzUiez1sH0BSgLtIqt4EtYrIYV6A/pzLaPkJ6LURtD7LMyM
 gCTo3MfeHAXjA7DZabsFCJVnjsLzZxA/TqMVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729032767; x=1729637567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FY8C1CeAogn0+gLT7psVb27HEjVEe52fHJXiglhlTHU=;
 b=CWo0V7tbgbxyC3LNq8oeGdeNU8GJpoOWRHxRSLAHQ0oV3MCOGsoCZzBrLYhjfndkdx
 A9iLvP7ljiAmzUMR3ccMSGqD3EFDyO2BdZCXgVyH0dTX+atgxvGvrS4Z8ENGOJ3dWf40
 qDYVUVVKSZ6ucDZ7HJuyXGCPhhehkv/Tdd+xgyEP+xavWMbhGh7Fb3O63ebKF+YT1TkC
 J2JD+KcXbHVwDNGPEehfmMekSG4ufzBoIfiFuxAFyeheB8MSWD48d5CabkNbUA2kzPuS
 9cu+yUcgCMzBQlH2oE+q2BdcFO825zCxi50sYENWTNEfs26jmsiNy48FygOMMXhxfBmu
 tVoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwAmHESnZvhXjmV7MkUMee5pDUmgZeF3B5Sg134a9kieSm5rBKf7FCWchsX/1WkMY+8828znc=@lists.denx.de
X-Gm-Message-State: AOJu0YxryXweKNoiKpeJwEJ81EmIQPZmAcxJhApOVcSc21VmIv7VutN3
 HjTMBMUbzJiTaDJMjb9/odYMPM43XyiuZx7akNAOaz8JQQCncz6YoaDMg7HWeEw=
X-Google-Smtp-Source: AGHT+IFGoph4oC2GXqgyOoTaEsq7umkzGfdyeI3Km0um1JLd03Y42obuZWT+qrFuS19AmdhyAcRNRA==
X-Received: by 2002:a05:620a:1910:b0:7b1:21c4:ecf8 with SMTP id
 af79cd13be357-7b1405da312mr399969585a.28.1729032766646; 
 Tue, 15 Oct 2024 15:52:46 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1363b4fcfsm117573385a.112.2024.10.15.15.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 15:52:45 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:52:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/2] Makefile: Drop SPL_FIT_SOURCE support
Message-ID: <20241015225241.GA6412@bill-the-cat>
References: <20241004230756.371153-1-marex@denx.de>
 <172902143755.5381.3133865412226742988.b4-ty@konsulko.com>
 <8cfc2a0f-dfef-4528-95fa-298bfc701ac7@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q1Dsf2z0E0ogpZNo"
Content-Disposition: inline
In-Reply-To: <8cfc2a0f-dfef-4528-95fa-298bfc701ac7@kwiboo.se>
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


--Q1Dsf2z0E0ogpZNo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 10:48:12PM +0200, Jonas Karlman wrote:
> On 2024-10-15 21:43, Tom Rini wrote:
> > On Sat, 05 Oct 2024 01:07:13 +0200, Marek Vasut wrote:
> >=20
> >> The SPL_FIT_SOURCE is long superseded by SPL_FIT_GENERATOR which
> >> is long superseded by binman, drop SPL_FIT_SOURCE support as there
> >> are no more users.
> >>
> >>
> >=20
> > Applied to u-boot/master, thanks!
> >=20
>=20
> Look like 5b9261fb0b1e ("Makefile: Drop SPL_FIT_GENERATOR support") may
> have broken ARCH_ZYNQMP, it still seem to use a mkimage_fit_atf.sh and
> CI pipeline now fails:
>=20
> https://source.denx.de/u-boot/u-boot/-/pipelines/22715

Sigh, thanks.

--=20
Tom

--Q1Dsf2z0E0ogpZNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcO8jIACgkQFHw5/5Y0
tyyhlwv/VOvw0q4JmMcSIm32/NQwL823WnnNONqV1ayCOAgSnP/+J+cABKn6/Svr
NEcr3N/0U6P1swb2KW0wcrrPMX6nfpIslCS1yqhiQMeArxpdQH+jdU+zVbFaTMhU
mKqIw3+fVn9E0+L1xEHvjk+FzAdmOYY3HmDC6S5iaQpQ/9s5bMDN/zgQgYCtN9wP
5xqg64eyr/CnFKRVl6xmIFH1xaEE380iO9uCVdoeUDb8ZMaCeBBvDGf30z2WYEQj
TqKRkSSZsMG35dEmhHwZOenbFIXWL5rQTLqgFa2Zokpcqv7VdiuSmclc/Nff2Wu4
fyAshfopEWHUtOpmPxpn5yPN6bJFiNTisT2Qw60dJQT1AX07S9665fXDxsnHCuNH
WJkOev95P+P7y2VCVkDoUwVaOcDRzLsrHcdzOcu1+m41HcTgJXvCLg3IAxBGp28L
iyzwHrVdknfqs5Er5VJjm77P05HnE6iLXhAN83fOuj7vE1i2Viez+coOMZ9z3Rxe
3OABcBfc
=oBbH
-----END PGP SIGNATURE-----

--Q1Dsf2z0E0ogpZNo--
