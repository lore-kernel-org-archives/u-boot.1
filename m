Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D30D5E36C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 14:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B5F839D7;
	Tue, 16 Dec 2025 15:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C2vRNeAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6943839FA; Tue, 16 Dec 2025 15:01:11 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8163F83623
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 15:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3ec6c10a295so1966541fac.0
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 06:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765893668; x=1766498468; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RWYjQKGpXVlUBuIMH5NG8nHDN04doUdRwCvY0WvK3JQ=;
 b=C2vRNeAL4bRC5T7crOeOLDN46QudmulJ3T+Od8ghxXlKb8b3OTkQWq0OHQfZKbK0Bt
 M7WuELqAhsIcbp4br7J/nb3yEkGqrlaHlwv+OQij2RQZ935LEftOiSJ8vuOzh5kM31ko
 Cb8lPr9pc43ZLty2KoHJjYc5eXFqOpyiaBXTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765893668; x=1766498468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWYjQKGpXVlUBuIMH5NG8nHDN04doUdRwCvY0WvK3JQ=;
 b=rzN1T+fw4UVJjTi57Swq+z6D9t0fT7emv0wwyZAtCEXlQUDpfD7yWGJ11dmlyydvMg
 9xWSeuAdPHw+h0uUt1vnL/CP4LXw6D0L1azTMlTMpPYj1okKyIvyKMWM9as+87/2rZ9o
 LKIQfi9PCjMzRqZRhud5mX0UPPTJhluNcUd0t1MzOQImqDW+GKaxyT4NCQgzagqEzKQy
 3F1bcngL55Hn6q7Q5ns4zudJsqaGmQvO6J7ycgkZIyKysa6pQQ9h6ptUm9oLWcc0OEvX
 ZiB8s4KZZ7Cg7GrGT94nvLmXfGYlVhcJ/bjSMJg/Bya0V4funm8vMWq5cH5m6aarKRLH
 8axA==
X-Gm-Message-State: AOJu0YyZKiKOBCGeC5RG0bfGaROTtoiMl7ooFywWqN+Da4itHNvGmmE5
 htDDDDfNxipqUj8VQWR3pFWIRC6BmcOmQ4Djri5PxylQgzxxQcZGSNzrZpfUeaVFK2o=
X-Gm-Gg: AY/fxX6q2DfY2wucfsZ0VCeHUPoot6LU36bgBTekezWD8Jd9h3HdB4SErtYi8NapRl0
 vC57zkonDc3TUahYJnCsUabYqAua+BYvcKeQqE5AVeZyZWGgPftw6HSXtoOOueM9/3Hv7EexZ4i
 Gw/sEivJWsi8jHC2l5BuQ778rjjxmQXXfuoRjVTfF/i3WrmUW8u1GzIeRGk2I2YSq3LgAbXITcT
 95c14l9QcT52UTZLydHELrDSCKwsDRVHeLH6IY56E3foYuiUew1T2sgls8oRogm23SHIoHo2DFv
 Q/EzZ6ry9X0U1Ms9KIE04awXqrUjDTuqXeaQ2Jv/66z6J25eiS31RYie+YTuEUTFGkZ5gtOoHC9
 f0j084Ybu0QDU8jZb3pxitlN8saFb+aK3INKrY6iDdSgVYJUKuavBbZycaZxR0vgXY/ieyq6ca9
 5EkSkY+kS1zWHGkuESfKdXzxc2kIpbj8hqC5CwtuFFQN4gXlLLeA==
X-Google-Smtp-Source: AGHT+IEdMoPNS6UdE9LXV9FTfI3k+csraHhW0xbeFGXkVWkQGKnC8oTDKX0KQMgquZKyRNuhWbXMkA==
X-Received: by 2002:a05:6871:339a:b0:3e8:272b:effb with SMTP id
 586e51a60fabf-3f5f8718cffmr6816282fac.13.1765893667478; 
 Tue, 16 Dec 2025 06:01:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f614de94fdsm6366195fac.14.2025.12.16.06.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 06:01:06 -0800 (PST)
Date: Tue, 16 Dec 2025 08:01:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Andrew Davis <afd@ti.com>,
 Judith Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH next v3] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
Message-ID: <20251216140104.GU303283@bill-the-cat>
References: <20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com>
 <DEZHV1ELFZ43.E3FN619R0UNY@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EKiqcbCGdoHsojrP"
Content-Disposition: inline
In-Reply-To: <DEZHV1ELFZ43.E3FN619R0UNY@ti.com>
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


--EKiqcbCGdoHsojrP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 01:52:37PM +0530, Anshul Dalal wrote:
> Hi all,
>=20
> Any updates on this patch? If possible could we pull this fix into
> master as well for the 2026.01 release?

I thought the feedback was that this was a generic problem and so the
Kconfig logic should be universal, or there was an incorrectly /
sub-optimally handled case in the tiny printf code, that needs fixing.

--=20
Tom

--EKiqcbCGdoHsojrP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUFmHQAKCRAr4qD1Cr/k
Cht9AP4/1kGU+kYBAZpE1PeLTGd9CB0FjDf1ly4D3BkzlJOlpwEA6d1Mu+aGanAg
xnV0aZ1Yphe5mW4o3rp5u98+tVR4gQc=
=ZG3d
-----END PGP SIGNATURE-----

--EKiqcbCGdoHsojrP--
