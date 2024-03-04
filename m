Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D0DC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C755488048;
	Mon,  4 Mar 2024 16:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QDsEPxSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B0CF8803E; Mon,  4 Mar 2024 16:27:39 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FAFA88035
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5a0e5c2d339so2875970eaf.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566055; x=1710170855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d2iet0f6Uv8ZRloeYdRsiEdPB7GyhJyoeDrmX4IUhuc=;
 b=QDsEPxSkPAQ6xeMUaohyfFvPw5gKGJ4Thmqpoad1tF3n0R/+ZGEPm2fQ4m4/iDZr93
 Aa9CUsPPv2TuFsAqtRXwYcKPMM5ck7ykz4Rfgf4STEBWRNtn8+rJrCMn2EgONai6B3ti
 6NAmsvdA82XQYeyGUK4GL2ec0G3sITiCwWJ8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566055; x=1710170855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2iet0f6Uv8ZRloeYdRsiEdPB7GyhJyoeDrmX4IUhuc=;
 b=Hhoe3XDgja4UWKgdjq7NQE79bilxAmHsrmBXGFuuXcmbCKJqWwHfwrALJ5owJqMv8U
 arpRxK8DWSFl45l2OS9pQ0NIIJG4SGGA5ytk4ZigZ7qasnILrvsui74Dj55CGNJ2vMve
 kPNQBFdVQD+U7/rXA/UTfOR1waUqhrWqUa6R5dozRccl1qsblj5iAHM8MwQ7oGL6lKgT
 naRN9qJp9RlLha8173XCs862K1NS2ivmwck7sJJBzS2Jq9esHGHtzMRzdEshYwMZQQ/4
 tQh+5VL2mDMafDRWj053eVxmRyrw2f78CUSzA/dDftQa6FKg7Bg42cyVdXKjYkT/oUPa
 8sSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhKM0McxM/Iz2BWvEJNTlWKL3A2XCkm/iQSEoVmff9vyvcmMF8xL07pVvSdKHvg6fy1S7dVogvLC2o1bmR6PS9aLPItg==
X-Gm-Message-State: AOJu0YxOEw/TWBZqY59MLccSkgJuX1ProkElx5kL6acYNOpVPnl6vBJa
 reMSNVlaOvyFzzIF0tlmKPCNEvlvnJTTire3nWIziz1FGfxJXZM5fo3ELhqfeak=
X-Google-Smtp-Source: AGHT+IFYXnKBAikb7S0A54gSX9rQjTqq4yzkgGFIlw98r3ToBHOSucjTeIBKnLYyvvDjZf8FNW5rdg==
X-Received: by 2002:a05:6358:3a1a:b0:17b:5e32:6009 with SMTP id
 g26-20020a0563583a1a00b0017b5e326009mr10495396rwe.11.1709566055679; 
 Mon, 04 Mar 2024 07:27:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 mc7-20020a056214554700b0069030a44682sm5167333qvb.110.2024.03.04.07.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:35 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] boot: Only define checksum algos when the hashes are
 enabled
Message-ID: <20240304152733.GT1523872@bill-the-cat>
References: <20240215171218.3728744-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kGZ2lidTEK0QSuJm"
Content-Disposition: inline
In-Reply-To: <20240215171218.3728744-1-sean.anderson@seco.com>
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


--kGZ2lidTEK0QSuJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 12:12:18PM -0500, Sean Anderson wrote:

> Don't define checksum algos when the underlying hashes are not enabled.
> This allows disabling these hashes in SPL (or U-Boot).
>=20
> Fixes: d16b38f4270 ("Add support for SHA384 and SHA512")
> Fixes: 646257d1f40 ("rsa: add sha256-rsa2048 algorithm")
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Applied to u-boot/next, thanks!

--=20
Tom

--kGZ2lidTEK0QSuJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6GUACgkQFHw5/5Y0
tyz3IAv+O7VIzAAlPn7/TfL2sYbUcUGc5pZvCu6caaW6LqHcZ9gqIjEqkJAED6wn
I2+IO3buZFEdTBEZhdIiA0lagFa47nRjL5HNAHuG10Ed+8OUey4WQT1/429641WJ
gJPvnULPY+VBjuVBTa0tMviyILlHnKeJ4qSzseeWuMQdQH6l9h6cjgd1Kq5BhNGe
vBv5FtE4BXMtmjTrKIUKBM55uyq24Fy6o8CU1h2CRD+h/sHSbhmcNcMH+pBi/YuU
wTgctDvUQoamovG9pKORXffWApUbu4V+9QqHwHRlpUNY5IrOf+q1ppz3Vi2jYKQA
mWzUh55swBlOP28UQnFJOrz6QF/CE0AnLM33FkulLt9jdR6oe89NVbH4b3E7KPUe
3atNME18O+5tC80Kt8dWkaSwTo+/8lCJGIBOmMVzCZ5KQsvtjUSVF2lDnZHIoCem
LAfuAumsi65qeEDbqS0WMnBHF7y0W4CU1MfqQ9UaBFQXw0j/cqI4eEL9AyG0+wpj
6oNjVTyW
=Thm+
-----END PGP SIGNATURE-----

--kGZ2lidTEK0QSuJm--
