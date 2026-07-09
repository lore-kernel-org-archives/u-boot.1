Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5ECC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E4384AB5;
	Thu,  9 Jul 2026 03:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ly/Mmsiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E196784ACF; Thu,  9 Jul 2026 03:52:18 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F55C84AC8
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4518ad44e83so264984fac.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561935; x=1784166735; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ikB+jRX9mObpQiMPqGDjl3eVCwHn2zu8TR2liZwrWU=;
 b=ly/MmsiqdStsqcxfzSjEsnwml7iOfyLkwUjuWr6i97hZTGt/a301SJdkkLY+pVkb+A
 v3THhQ/VQSWhHtMWmAm71oP4V8It9ZwOO+7nLngLjiYKsSO8R4i3rEkuNK1DTo//JLeq
 57yatggJmalAKotqKxEM/eLByMTRMqf1uI6OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561935; x=1784166735;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ikB+jRX9mObpQiMPqGDjl3eVCwHn2zu8TR2liZwrWU=;
 b=THHaisnROxhpg8RvHdlhzxuDQ1sYz3CoF/VDgVEo7gR4C6e54RzTAJcBi65EmcSrma
 P2XDiNdLPZ0PBnc76p80LrgZJ0gJcbr66f/P7ap4yyCF/6uy+55O+WhfoWUbSpkCRW+M
 gqGdoNN06EQ65unKwhCR27Ru/ZAc8cJHRDo2gz9/91Mg6wAfnxewRNIRZlLZ2EE9prhb
 bnlvgDVtMD0/PQmXBdinF1fEfFQDKTU7CYsX2ai+ZGIXLYQ0vSer1m3IReijlxIhFp0o
 Js/e0Vv6S+maXO5P8+Je4NquRY01PxwOIZP7kEcdoHYWN6GgGYbeS0QIXHAmQNb80ud6
 4l5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRGFlDo+lnWSpFkRJh+WeoiMUq/NaGgoympwnPcrRcBvRitszOsf88MG4/qckYLS3gcbhSbMA=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl1QBDSeI/XslsnCrDkYyFlAipVs0rHQUPFqNP9lylwJjwZtCZ
 jiNgTNsPp+LHdVS3Ta2gEBP14hWsoYpwlVZfRMgFJy+pWl8Yilewa5T5gDcel4WfDBY=
X-Gm-Gg: AfdE7ckbMvsG5DelpdEuKvNj4MjX/WqY2IK+vmcVcbBDXF0QefwOa+tybm8ccYArnMq
 w6xMvmxpKLCqxOJEc/w77q4RkO3unaBhgtUgvtW2QNeBAwLi2G5Eklq/A4sK2V+kUT/M3QzENep
 FQpKYoZDYfNGcze7LLmrhsnEjdxSclrOCr6wdyRo+CTJ9UlE3A+noHUdC1OdkfAVkHPEbzKj5Bi
 ETE6cmtG/I8JjF/UkYU9dnJdb5wqvvWuqoS+usIjnfxVdwzOfl3T7e+roKE3vTvMR2YHgi7V1bZ
 jbSV12lBaukepITgkw80Vt+ofjP/UgrR3Ptk3szwHpmS/+jHNEpTF4RNMGtSXExaieOfjhjZESv
 QuS6YqxdeIfLhIcJi9dTWyOiJyFi3J7v7qKbidhwUR1bYqGF3hcIP9ihq05rGtiEXoWz8AWG0RV
 8IIU/4kpng3gv9ZMKy6PYLRHa22j5O5SEJBfboW6ZfBNThlTust8B8Zrnel3odIe9CkWTzPkyxY
 HBB1cWG2NwRMfJypJjQQcVGo4WNPOzEVDXyvw==
X-Received: by 2002:a05:6870:8a20:b0:44c:440a:6692 with SMTP id
 586e51a60fabf-451637bb19emr3297766fac.9.1783561934932; 
 Wed, 08 Jul 2026 18:52:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45190b7d08asm647711fac.0.2026.07.08.18.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:52:14 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:52:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 02/11] dm: core: Drop redundant CONFIG_TPL_BUILD check
Message-ID: <20260709015211.GM749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-3-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PTcHISlTWAnpql67"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-3-jonas@kwiboo.se>
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


--PTcHISlTWAnpql67
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:28PM +0000, Jonas Karlman wrote:

> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
>=20
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PTcHISlTWAnpql67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7+ywAKCRAr4qD1Cr/k
Cm2KAQCX0jlzRlCyWhw/5HKdF/HR5KExdrFlvR/2yX6xT+8/kQD/VeaHdNwf/lNk
8FNl/l4vVS6VWFGz38b0hgCf2CPVPw0=
=dwHG
-----END PGP SIGNATURE-----

--PTcHISlTWAnpql67--
