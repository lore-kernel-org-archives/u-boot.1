Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A307FD715EC
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 17:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA26A83B72;
	Sat, 24 Jan 2026 18:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OkxzDmtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0B783BC8; Sat, 24 Jan 2026 18:05:53 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6EA83AEE
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 18:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45eabce608dso1813777b6e.2
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769274349; x=1769879149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MCmy233YeViV/wWQ4yxfzs/jKQRPTJlzAjA6K6CvWgo=;
 b=OkxzDmtIU016U5+LfxQHUtjuhKhZu2qZyJt81IIh2cRlTSGtqJ/7lZjmorGLJRFD1X
 9MRyYx6oO5RiQwNTfTxqPwcCfjSne9AaPkaufT3PjHgLN8+c2BQgC8LdNpgmoZ9C87gJ
 d7nxigKCf5s2aAk5xDCahehcmQg/UK3tmgl2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769274349; x=1769879149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCmy233YeViV/wWQ4yxfzs/jKQRPTJlzAjA6K6CvWgo=;
 b=iFHNTolLgtje5QlbEf0SN00EzV0wnFx+v6O+Aw+kvaAB8C08V62+SXp8lfAMFsUdlr
 S3rcHIoAaUlyMJaY6BxDiowKv4ggPvQ4GMXnGa2oWEBnojY9Suh09lw3kVdHV1upvZHH
 QIMAs2EGBzmP8pZGRJUiFiKZ82A2+2vtyv6drEuHDHQn4OUwfsDUcNWV60cirYeyf6kQ
 4vZaCmznZoMPGKXBWlR8Nayy5cRK54ykrJ4hM4eTulvIM+sR0/UwQitLOdvfaazPnx6F
 rHs+4rmq+mM+MIiJoaOgAeJJaQSIFK5sce+QCG1jUpUxYjCpQbnHFfXm+pU+9k8r03Er
 My7w==
X-Gm-Message-State: AOJu0Yyplo9eZ1XopB8ARZwA3in2jQsXplKIEuRhw88z8fqsrQPbj84P
 0qAGpgBqcs/1SaytKh6Bq5LQspBrAXBZf4Bhs98vx1rvJbKI8IQA2CD5hvnj9DcdGWw=
X-Gm-Gg: AZuq6aI1hhEd+Fcdz5FicNjsFMbfnGlnyy+SU3l/vBHw825/DMVNJSdTWr16ihMwRG7
 ehutRWgZjifeUQUYycnv7zAVPHkmadq1DQ0YK8Eq1Q4R/K40OzimP1IczLVvFPzITm5yIleiJeM
 GPrYN0+g9i7IJFzorqtjbJ9GBQazCoKuYUibN9jYLW/fHwSADwDLD8+HWyLWUWeRHtM+bbM58Kf
 oLP5JlyfOm0+CcjFtq/5oVEoD/X756MWF/qqBgHaS9QQ1FoB34AW2IB8LBIlb5Edy4v2KNvdk9K
 JLJmp7Wh/5C833Q9kS7mHWebtLvKGVfQfTIoqbVvzvYyE76axOUJ4i2sWgMiqIJvuPhU0PodN9k
 EinhEky7bp1vWXHJ3cNtJ62XPLHrtvuCa7eTJnW+P3DsqgwHDv8MX5d2iSGa4SbyQGRC3GvUP7k
 opY28NWreDezeqTv0MEZ47hq9AJWl10TBWiVpo6KZJUsyXVXohPe6NFOyo/P0NOLfy2wYGfmlXt
 bFKxeWu39B5lhmfvyfYkF5eS4mOLJy400Jb2Qk=
X-Received: by 2002:a05:6808:4f6c:b0:45a:54f0:7b0d with SMTP id
 5614622812f47-45eb1ab8048mr3448256b6e.13.1769274349205; 
 Sat, 24 Jan 2026 09:05:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45eb42530e9sm3193026b6e.16.2026.01.24.09.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 09:05:48 -0800 (PST)
Date: Sat, 24 Jan 2026 11:05:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] dts: add Exynos vendor support for OF_UPSTREAM_VENDOR
Message-ID: <20260124170546.GS3416603@bill-the-cat>
References: <20260124-dts-exynos-vendor-v2-1-89eb2866d43a@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XnaV42cZuVczYsUT"
Content-Disposition: inline
In-Reply-To: <20260124-dts-exynos-vendor-v2-1-89eb2866d43a@disroot.org>
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


--XnaV42cZuVczYsUT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 10:28:24PM +0530, Kaustabh Chakraborty wrote:

> When building Exynos boards, configure OF_UPSTREAM_VENDOR to build all
> device trees in:
>  - "samsung/" for 32-bit ARM platforms.
>  - "exynos/" for 64-bit ARM platforms.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XnaV42cZuVczYsUT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXT76gAKCRAr4qD1Cr/k
Cs/fAQDGSuU1n24oZbcuewVOu69ubRc1RB2E0jmEsXXZZ/eLHgD/fcnrRAlcHiYX
dF8UFqiRTgE+GH0tN+RpBeJZ/IkSSA4=
=Y+ED
-----END PGP SIGNATURE-----

--XnaV42cZuVczYsUT--
