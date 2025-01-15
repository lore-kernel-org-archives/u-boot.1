Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42ABC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9EB80657;
	Wed, 15 Jan 2025 15:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AQyszzcJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E46E806FD; Wed, 15 Jan 2025 15:35:15 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62ECF80269
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-467a6781bc8so48779901cf.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736951712; x=1737556512; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HapbBRyF5ebOkkMTxrqkWdHxqS6tWBgSiuB1xBmjfYQ=;
 b=AQyszzcJdqJOXUcGnWNSVUugAE/dhCIER0ALD/EiGzxUM3N9N2RHGT/qWhUYciLSfo
 3iiyttTCLwMtcsId6izVjmjsictfFjFboCTmlZEVYM+wHtz/pLc5shVM8KrJ4INRkd96
 PgW+Yj9cxgXKglcIHMHX1dL9ZFRZa/4vP7KI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736951712; x=1737556512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HapbBRyF5ebOkkMTxrqkWdHxqS6tWBgSiuB1xBmjfYQ=;
 b=agIG3umHLREcj1YFZsynvBUddOXJ7e+d9i/WRz3auH2dYcpIFisb0HFgX0zhK3yue7
 iGmpm/VWxxcehNUoCSn0VTB5WmfPWKiAOfeSWOJwfhTQlr10yD0FdY5AR2IjK7xm9eia
 ZWNXj9ZRHU9JxRtbVJ5i+G7qiZV9yQE2yzMGBz/lXFHMhIDcbCpx/V9AFvZarlzuGU9x
 vhW7Mh6MRMFRE1a4oPgEawUEKX+pY1rNDUYG2wlY7QKBHdIuCXozaPmTi2PB0D5uQVD/
 DD7UIycxCWBtT5rDRHRWOnWdRPYv3n/nyLYcm+F1mFwQpiHNlXLHQdIIVbMFdpWIvZ8D
 KUYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSwLjZ1R0CnR10FfdMpvPVAcNOS/qBGPHv7jkJMAxLWTB3esJY0BfoAFEPPDUgmSUYIdZVi8k=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6+kxAlC54f+b2lrNAorsubakaMbhoqqZJQJQw2dG+tATVne3K
 oK7O1CJzlTaR5m9u+KhKhd9+W505ddl890KroPIeTOZcSkeIpOPsW185oySe6Tg=
X-Gm-Gg: ASbGnctRQ6EamNIynnb8AXCfwA6M3Begsj0FBXoLASl7eAFWQBzGi5mhFLLAfAgHrKd
 wDXqNX8fT+U7iZb8SRDwzF7zF0MxF/9TUFtIVFBHMyFWSw8pz1eh4kkJo4YbqT9maVFe8YUrTNz
 iDuOlN0zRTvjcvip9EK6ESHGLdx+jDsTGWGhG8BXWAd7g6+Pu5vsv18MHY660XtLQC1yUJO/QMZ
 gYPIwPQdFKcYxffj1dMXK0SVnjzdXGTg2qZDHpk1pHDHw9GT+0p2w==
X-Google-Smtp-Source: AGHT+IHf/19fuQH37Q6QU5K+WpNuOwQNpT3kF8r8UEiZwaJbNp7a+3WEx68vu3fEY2oZlb4S7VJt/Q==
X-Received: by 2002:ac8:5912:0:b0:467:597a:be4d with SMTP id
 d75a77b69052e-46c70ffe9bdmr427691431cf.18.1736951712306; 
 Wed, 15 Jan 2025 06:35:12 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873ce201sm64975681cf.55.2025.01.15.06.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:35:11 -0800 (PST)
Date: Wed, 15 Jan 2025 08:35:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] bloblist: fix typo in code comments
Message-ID: <20250115143508.GW3476@bill-the-cat>
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-2-harrison.mutai@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JTjc4nChTopflsGX"
Content-Disposition: inline
In-Reply-To: <20250115135209.13946-2-harrison.mutai@arm.com>
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


--JTjc4nChTopflsGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 01:52:04PM +0000, Harrison Mutai wrote:

> Fix the two typos in the spelling of same and set in common/Kconfig and
> include/bloblist.h.
>=20
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--JTjc4nChTopflsGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHx5wACgkQFHw5/5Y0
tyzV6Qv/Y8BUuC3OVeiWXHh1tGCCYOZllxmR0oJ8+ZG5TZeMVuVG9zyq3W11ebDo
eMaage+YFZzxGovgrdtsIbKsBPo9rBiH6cBZB6Hhfy5YyIqrA+1++xzcqMEvTb/s
MB35LuFjtHXiqR28SQV5nkatM8T1pMiud6IFh3UlYYQL9CUOIobcklZHwrAx2Hab
g2WRMp3e75HX2J02QLEFA9wMS4Duux1hZwhCCFs9kSiEDfnPUo5KAYGFEEuN2Dsm
d1ggFOeKyHPo727ZoS8bZFJ3C0MJveHUk8PaeaEzS0HES7Ug0fAZUdN4qXprhRHs
mBP9WtFI1ziftusO12+IMMh7KhkMGwnk95ie4UYBSJglFxzE3JmkEd/qAGGNm0rw
QrLPSunjraIwakitLF4VED3/K/NEp9j38U1Hd4fBgqVu68K2KhtWurETr25Snr6Q
4ttKvbhSuiqIFTJ3RG/mPYUIlZtp8JMTU/soQM66MOcCmXz4nXIbHEaxnOZoS0Wr
771JMtoR
=zIJ3
-----END PGP SIGNATURE-----

--JTjc4nChTopflsGX--
