Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87605C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 15:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05896811C1;
	Mon, 10 Mar 2025 16:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eAvT6WV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD08080107; Mon, 10 Mar 2025 16:19:47 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76E03811C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 16:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2240b4de12bso72104515ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741619984; x=1742224784; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BotFI4jNYvhqNrtDPM4NFP0Wi1nCZqTZaG/0slasJB0=;
 b=eAvT6WV95+w1pyJNDyvwR52WLandu8ipK5laxX1YohFkFxrJNr6seVHlqXGcwgqiTv
 tbsbQlzFWwTYiFbPaPrvz+pOatVkuEgrgTej3wr3XLX8arAmoyhRmHprQ/kXLszc+XFc
 YJJeRIoTc/qtFhkeaJYDo7saa78f3G5pY/YLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619984; x=1742224784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BotFI4jNYvhqNrtDPM4NFP0Wi1nCZqTZaG/0slasJB0=;
 b=ulVIxlrpB+9kbI2aM6oSyC3sfCeWt1ni22/f9mVlb9FW5foVF2JGBgvNymg5hvlVtp
 uLyQiVTEOSWTnCtlykw9jFN5P4bV4vLzcIUIck6MEAwtV0aNdVmT443wGehBKyvgBHNP
 wkTb+sGDDTt0SXR+CG6EWktgHKTuVGXg8U5ZVjtQabNP6guphifRspqRawzonP7eaEoq
 a4VwC50+KQExyBBDsr0iMcP3JOsk5Zk28gnEW0gSFhE7FQKKMFm9sx9sqGD8si/sr6R8
 JVfVjLld2JwcpYnd9O5i+zfkkFPRGcq3CzgPP2KKa7oppYHlGkuaWa7CxA3cwltLUAAA
 HPqg==
X-Gm-Message-State: AOJu0Yxohs6a23SRFaKP9ZXglhpW+EMpGY4oTp+fD4jgPR7gioVuFxN3
 5+wBsW39TkX50mT/C+5wiUZV2VyINnX/pTK4ysaTwclH5g0qc1U0Hkm+CTuF7sA=
X-Gm-Gg: ASbGncsMBnuMZCsVHK03z1HKSR68Q5qAobBiaYOZxj8E6yOAZX8zNOpQ6xORf1jd8D0
 rPQ20QrqgwJLQ2LRZwTjBdrQdh5Mxfad9yR6gP7wyDMvZ90d8TwVcil1Htnl1Wyxvq1Z/a4i/qC
 tB2bd7MOjDcu/dI2LuM9irZtXvFDsH9+bcXb7TEa/ka3RC5mlwI3u+HT2x+3mt5JtDHkooXbrMv
 dqEOIeKe9j8vbk/SbJKr01ajSlizN9HiGb/QMLydHjec928LS/4SwlWSEmtJYa0MwALzu5Z8RHu
 481L5cR4znHcVlj9zh8q9C14RqeLD1/aNYAKckSZs9XzAw==
X-Google-Smtp-Source: AGHT+IE7FxpNXslTZnT/bZjwfhw3E2+jjP/CkZ1gYUA8V786nNdTJkrhmnTQ71P1587s1BS8AZPZ+Q==
X-Received: by 2002:a17:902:d54e:b0:224:1ce1:a3f4 with SMTP id
 d9443c01a7336-2242887b415mr253586885ad.1.1741619983994; 
 Mon, 10 Mar 2025 08:19:43 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736dc222405sm1910379b3a.78.2025.03.10.08.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:19:43 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:19:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 09/12] fs: exfat: Demote filesystem detection failure
 message to debug()
Message-ID: <20250310151940.GH2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-10-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i9Vzmnq3zDtiOjy6"
Content-Disposition: inline
In-Reply-To: <20250308201533.1315951-10-marex@denx.de>
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


--i9Vzmnq3zDtiOjy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 09:12:13PM +0100, Marek Vasut wrote:

> Demote "exFAT file system is not found" message to debug(). This is
> printed when U-Boot attempts to auto-detect the filesystem via generic
> filesystem API by attempting to mount the device, and fails to do so
> because there is another filesystem in place. The libexfat-fuse code
> prints this an error, which interferes with 'test_gpt' test. Demote
> the message to debug().
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--i9Vzmnq3zDtiOjy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPAwwACgkQFHw5/5Y0
tyz+5wv9G5azZiRbfEzEjGE/enEayKgdFiC65p7VgyskPgwlG/2uvJqYVfbba8fe
YzRv+CguqFzEs4cSqczRiCoqh6/TOoR/O0GR0J+gbXpvPMiICyXqYexcd40aIqSv
ewVsCoprYxCuC4Cc2NdorMZPH+MOUerFmeL7LqUoL/rbOPZ4Lge0kcLUDK3C62sl
19soSQ41uLKf8Z0IgUDErNCShhjMxTveEyQKflvpeTsEG0k1Fy44ratvVfzteruE
VyizSv0NN77dEyHqUJpbE4/BdKhFgBjtoXi4pmx7IRRvXNxCUKoUsZd/8ZyzkJvV
AJwvr60q8LJaeynMHVpP5GrEt1yVOicol5Dk/WuyWjqqkPWMXgJijmedr6Rc2lAU
lC8GUwAtxeLkELBHzSF+81rhC4Rz7L5OX35Zimy0gNLxXXNahDc15lU+q+M6l9lb
COkHOUNVne0iZhi/TKFdyZaeh04Wzkl1jxYrI8FDwkY1avt62w8ZtFUM4JcRgcoE
7tVRQ4HQ
=qrG3
-----END PGP SIGNATURE-----

--i9Vzmnq3zDtiOjy6--
