Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F85EA7944
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 20:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C67839A8;
	Wed,  4 Feb 2026 21:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UJZSS/lC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5063483A5A; Wed,  4 Feb 2026 21:36:09 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DB0800AE
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 21:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f09874c4cso152374b6e.3
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 12:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770237366; x=1770842166; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GPuhdYXuChIl+9r87KcmcgshWGsYwZhc39CNi5WCq8M=;
 b=UJZSS/lCojISTV7kXSP939nXgFrcw4uqXW0T0KaMDCOzKMs+TWUl6KDnvA3rojwdct
 DrTNX+l4vUhnlEiTwvLPOsHSQAwte3SXtG8i1vkIO1K5D/nk+GG7O10P7fp2Jj6M3VBU
 X42uEuWJdSfYMhU8mFDi3o3+ZRI0QGqcusAiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237366; x=1770842166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPuhdYXuChIl+9r87KcmcgshWGsYwZhc39CNi5WCq8M=;
 b=lnTjzF9BSuyqggxrTiheimkXI+ZPzNfo5lzOtqGx24zSS/WULG40J2h8jMulcaPS7b
 JahAX4jIZUNvhcSHNcPOGzjbotPq1B4vrXP/XKsA80PJIF0AfrJY9HEISdnSTOdbwXlg
 TdvbH7rMsitK0mf/1NfG7CwaVpuMf9RmpUEJGVNSG5UdPRLsigSccJR0bYRYEZ4d9N3Z
 E+iv9VXkbvJzcBvV9LfN7HPmg12r+AHzSeCVsf8pDH5ReXpf5W400Qn3jBt/WTOIois3
 SvA2BMZQrREFsRZ3PI5FiMSpvn0/oUMd+HTLeuXfJ/adNC12dFtLSocAChqskXRCqjuT
 USLg==
X-Gm-Message-State: AOJu0YwBsgF/2/8H6/iCsC1ZoKTtGuiFXx8QAi4HXamz6JFd/ZQumiJq
 NZLyZykHOXpLsQz0B8Nuro5gYcLWzwtPfcfWQg2CIXgfd36kOV5EBj+jgnVt5KhQTi0ojJhijuC
 ObB6SNsU=
X-Gm-Gg: AZuq6aIadi33fOZOtxf9IzCvRJ6dAzr9L6j8dOKwF2hh73FjDgwdIMrr/16JgQwnLlz
 GHC0Py8skJWR6OUYEKGwrKIWZBQ9ES9Ent8VC7jC2Be127cGE0B1lmP0xkjG1yrwBAiNCGprmPo
 urV4DvPyMGiszuN/keUeYeEzFowuq/IN73sYTlZ5jI/gD1RRjUjg6+qmvf3mAu/ffT0+fDEOnVt
 FBs/NnCQZ7oQL1jpjbSkP8k81qjKoFVHN2bQwIkcqKNhFihpLGLjKWaUyqAcQOa7gTuhhgd3tZS
 Azep72JA5Sqy0Gjr813cNvqdZ0OaPM8fOiSfaFz1n4LskxADOeKnuMuBwSam/uOpHYqdkjCinmn
 VtqdJlU5AoALl1hZ+2kK4jj8b5XxXwITSLhLGoBoeOJm38EyU4twmpo5zHratsL2tnO7cZsmLQF
 A8exUCPcg4j9QEWPviJQCrwj8yxHhbnzFTAIxhzKpFdF2vng/CJpstIAwB8BW/dpnSAs0Kq3FeK
 y6sHHVIj4QegKhSFi2Jcs1W1S2vKxzjmeoMzW0v2b3R9FRwUA==
X-Received: by 2002:a05:6808:6ec2:b0:45e:a76f:2f43 with SMTP id
 5614622812f47-462d587b663mr2202698b6e.1.1770237365736; 
 Wed, 04 Feb 2026 12:36:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462d6801c33sm1967877b6e.20.2026.02.04.12.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 12:36:05 -0800 (PST)
Date: Wed, 4 Feb 2026 14:36:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Phil Sutter <phil@nwl.cc>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] board: Synology: common: Fix typo in Makefile
Message-ID: <20260204203602.GC2603314@bill-the-cat>
References: <20260204202936.21585-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hLTA9FRDxR6a8wTK"
Content-Disposition: inline
In-Reply-To: <20260204202936.21585-1-phil@nwl.cc>
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


--hLTA9FRDxR6a8wTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 09:29:36PM +0100, Phil Sutter wrote:

> Due to this, legacy.c was neither compiled nor linked into the binary
> and thus booting legacy DS414 firmware failed. Missing atag setup led to
> no console output (and probably stalled boot) after:
>=20
> | Uncompressing Linux... done, booting the kernel.
>=20
> Fixes: 9774462e34faa ("arm: Disable ATAGs support")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Whoops! Thanks.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--hLTA9FRDxR6a8wTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYOtsgAKCRAr4qD1Cr/k
CikQAQCvqUhCTmPk2wZzmkO4XEnoyIflXcBartCMgbkTxpf1aAD/b+7SapHPVe5i
EbvtSb1eIJdJPQDs4Ki7N72alFs1tgs=
=lZ11
-----END PGP SIGNATURE-----

--hLTA9FRDxR6a8wTK--
