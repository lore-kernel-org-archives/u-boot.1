Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82E7D41C37
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 13:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3466E83A26;
	Thu, 11 Dec 2025 14:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y/BXfqw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D3B83045; Thu, 11 Dec 2025 14:47:34 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ADDF83A26
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 14:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-450c576a335so44071b6e.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 05:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765460851; x=1766065651; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yGR6keGTg5pbwcyBCnFw0mRMben3yiGcEbeR0mql2iU=;
 b=Y/BXfqw9Oip+WRkdsnIc9ToaawrjOXTC5ArDXZfuhUm3bC4kq2sy00K33UWrX26yUN
 8sYB1xJc4fFtrY9qa1TQExPFPFQM15vs7WybAu8AKihf+l7h2fk8uHowsvCefb3DExR2
 /C1dZNFuv3/MxZAIwXH7jypDJEVcU0HtOkyvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765460851; x=1766065651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGR6keGTg5pbwcyBCnFw0mRMben3yiGcEbeR0mql2iU=;
 b=GKNhtgCpw/5a8NHDfYkSOSzauFPPacxjIADddtnCioLgTyM3QVOsTNjbPaEBBx9nNx
 pQ8UXnC9DC+L8YaQyWIXfvGjMS4LFx0Ow7E7NnG43z17Nzee2vyuU3fmOy0ZUmZ4RWdp
 BYpcVdFiNzCXj7nf62ZzHz4cmOo5728fkhcNnxtUq6LVuU+a3tU6xK6TqoJbcjPMbK3A
 d/hCufvnCogmobuazGzp+AJjbYbEf+mz2swXMinMmPqTKAK7ytr9T6WRTzpH1TSpCkkZ
 EgVR3lRf7tMGaZtVaUqEMh8oTGfQ5z3kjjRDLvwJHD0kyttULSkxNO4S8CNUVAU050ya
 aZMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzBLVTLPQ0ybOzEDM1Jm3tBFXuahpkwdQSSNefUJdQD8EtL32lFWYVmnMwbNijU4DRFdi/+aQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyDGFdEwc+rGwQZCDnPM3y4aDTpFGJkJ3GnHub7cO1KQGHD3TeQ
 oytnsqJ5OBeYw7bfIhCtGeJcqbOkv0ZboH3A1wQ3kgExJIt7ao8dPkPsFY9mBNt3DBSmw26dIdO
 QLBevpqg=
X-Gm-Gg: AY/fxX420jKxDAlp502/Rxp7m4AHgi6WrpC58mLPpRmxu/oKqqBaiMBYM90GJQR2UYs
 mVvT8yuQEPqS7esgoYxkWJviQloLFSCan+O49Vx/2AM6XLSrVsnXssmu5BgAXCGuBepakbBq/JB
 RpPPVU0ws1qslBXIRkHvmo9O+tnHem0ydqVVsSSCZ7yAs0TcZuhkn6ljIgD3l6KbBvwiRgJW0yB
 Hyis//hDE+gOVnNADuMlG08SJcrmI2PW0ExBZpswdsDHlZ3g/kNPUrUxaxaZX7bWE1TKHXK8etM
 RKbzzC4x4pT5UZm/xlDbS2o8rmHIqLddzZtXrsq3mydFL44zQ488+q4M5XL9dWVtWswqth1P6jb
 DQYkV1pgoF9YhcDp5uoZaeGdozQPdcT4nR2G1Y7ToiCGTIYqMHNgNG1iWKUVCxha2JutlRvLEhD
 8iG8htGH15qRw7JKHnbzoOCxZRKzAnp6yLCseEKg/NyyYnxe6/Ng==
X-Google-Smtp-Source: AGHT+IGwvKA+bH29hU/UsvBwNe+GpytMa3befDHH9/IJxMS2xAu42eHJRWL7gAsLQfMbDnk3NQrm7A==
X-Received: by 2002:a05:6808:1485:b0:44f:6d70:45af with SMTP id
 5614622812f47-45586356470mr3295568b6e.9.1765460851075; 
 Thu, 11 Dec 2025 05:47:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b992d6sm1051808b6e.7.2025.12.11.05.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 05:47:30 -0800 (PST)
Date: Thu, 11 Dec 2025 07:47:28 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] power: regulator: Fix dependency of SPL_DM_REGULATOR_GPIO
Message-ID: <20251211134728.GN303283@bill-the-cat>
References: <20251211100119.2470728-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zRE7a9USfNu6s2zp"
Content-Disposition: inline
In-Reply-To: <20251211100119.2470728-1-peng.fan@oss.nxp.com>
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


--zRE7a9USfNu6s2zp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 06:01:19PM +0800, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> gpio-regulator uses dm gpio API, so it depends on SPL_DM_GPIO, not
> SPL_GPIO.
>=20
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--zRE7a9USfNu6s2zp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTrLcAAKCRAr4qD1Cr/k
CohhAQCNWu8Y5AXLFuVcbDv9gwoTIL1EKLFRosscweHH+HehvAD/Utts25vFHOAr
tGg6PMcEY0gJ/jg9pVxLumqGE1dSbg0=
=aL87
-----END PGP SIGNATURE-----

--zRE7a9USfNu6s2zp--
