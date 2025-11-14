Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC2CCE8D60
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87FB84137;
	Fri, 14 Nov 2025 18:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="djj/LMO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFDB841E7; Fri, 14 Nov 2025 18:20:01 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E332D840B3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 18:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3d18422565eso1542247fac.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763140797; x=1763745597; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OlyB2olmc/KZ0XkuObLx0VtXSINlcdrzMSg7HMRFlcs=;
 b=djj/LMO2g9zktPxmtpYQ6XL8iYnoRoR8Zdg+6hJ96yS8S+qcU7AASMfYOJYJbfAe8W
 9kbTJdKnRXy4Ct0O86JwGibXw87BD7897mPdbtxDM9HP4YXUpNIDHodVFroLTET1qXX0
 ohVVBR4KNtocHHs0PIHLaTGc3mu94QNwmkLZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763140797; x=1763745597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlyB2olmc/KZ0XkuObLx0VtXSINlcdrzMSg7HMRFlcs=;
 b=QPfLzUAlU6BV8N7qTniWoYIyKfG6rTWyXATK+KcQB84Y2abH23QVxPakOiVdgWtwzj
 gwEncQ+BF/8ZKr2zi98+AsLFLzdbPevi2DKC9vKEuAlndyxk/beu03stJwWSYUuHqVr0
 KNAzqQRY/oBPNPgAFu4+E8CLcc+l/3yW7GYckTwD5dSWOlVFkADSikdSXVbvObiFZ9Pq
 rAL3UnSZiz1r7MbODdTCiisoxXicBJINprKhhStTTOFlR1PCTZ2EZ3EYscRVR+j5OnD6
 3uaxXfnHFnUBGnG1Ejyl9q4aCsmd6Pl7s+5wMBJRs9ikkn5RpWFw1VFm7EHH5CoAMpYd
 ABew==
X-Gm-Message-State: AOJu0YwyHMna8pqCIm7ZgECWCvbcNh/wyMaXz4YmkMCSQflsBVx+E7Cx
 2CcYG2PlvsIBUAfyhr+d9BeoVnNAYGhkmxz7VW4lummz0TaPr1kY9881M2CCrNGi0cQ=
X-Gm-Gg: ASbGnctLR98yN22RVl6nxiFRGo2UQXnjIlU1nZX8QWpsI645QG+OgsxYvVkPluEMIzG
 7ehc85JZQZBDx/5/fzTHJxl0xVaeZb5MuBBwwYFcK73OF4KymLxiaKqCBPKwz/1pRLkXN+26ida
 uuza+SqXYog/bBPN+HzSEcjYPCpv8WwHlLW+dfU16Yw2ki5rIbAhervmXx+bmsIQ3gvxH9R47Og
 oqWyHHrFd3wVYWc1E+qFri8ZW9DkmEVayGUw994YbivXv5hVLFgbl29nRZq5BrQZaK4u4jkh8Om
 HLABR+kGrHN97xukhrgSpSmiCb3qDE7tEz41lsCJ9tQO5PRKNerjqcUUc1gKMCvZWls/57hw3Wp
 fz/ELBYGwr9cITXQjnWQncwviEi9l22Yvy59P/Zjx/ngMvFnJCzpBon7oGx70sFMs6fajPA0/Eb
 ZX5hrgaqlqAU7cGnAYUiINFL3h8dEaEbLRNkMk2/4=
X-Google-Smtp-Source: AGHT+IHbS/+jsefFUbJNaKkZmUR5OvzALqR3isApmG0zPtP/FU+MNgKoN1RZLpi+HzT8DdxqZXoy1g==
X-Received: by 2002:a05:6870:194d:b0:3dd:6bdb:e741 with SMTP id
 586e51a60fabf-3e86916c498mr1819441fac.26.1763140797693; 
 Fri, 14 Nov 2025 09:19:57 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522637e1sm2988364fac.12.2025.11.14.09.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 09:19:56 -0800 (PST)
Date: Fri, 14 Nov 2025 11:19:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>,
 Li Hua Qian <huaqian.li@siemens.com>, Peng Fan <peng.fan@nxp.com>,
 Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v4 1/5] smbios: Fix duplicated smbios handles
Message-ID: <20251114171954.GC6688@bill-the-cat>
References: <20251114170615.17698-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vlt+wL1ho3Ef/+u5"
Content-Disposition: inline
In-Reply-To: <20251114170615.17698-1-raymondmaoca@gmail.com>
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


--vlt+wL1ho3Ef/+u5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 09:05:58AM -0800, Raymond Mao wrote:

> Some smbios types can have multiple instances (e.g. Type 7, 9, 16, 17,
> 19), thus the 'handle' argument should be a pointer so that the value
> can be accumulated when writing all the instances.
> This also fix the observed duplicated Type 7 handles.
>=20
> Fixes: bcf456dd369e ("smbios: add detailed smbios information")
> Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes in v3:
> - Initial patch.
> Changes in v4:
> - None.

This really needs a cover letter. If there's no other feedback for this,
please just reply to this patch with a cover letter, so I'll have good
content for the merge. Thanks.

--=20
Tom

--vlt+wL1ho3Ef/+u5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRdktwAKCRAr4qD1Cr/k
CvizAP90JntJAh0LCm5lOaY2kwPWwANJqiJsVp2mmLBYlr24LwEA+libFO2SJuD1
xXcDZuzY9coi3AoQtoFhNXYbR51QKAo=
=qsql
-----END PGP SIGNATURE-----

--vlt+wL1ho3Ef/+u5--
