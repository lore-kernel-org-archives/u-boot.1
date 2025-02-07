Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64600C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 15:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94ED9801BE;
	Fri,  7 Feb 2025 16:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O/xMVMlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2025F80141; Fri,  7 Feb 2025 16:50:56 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 925F280141
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 16:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7be8efa231aso201436085a.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738943452; x=1739548252; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RP/oM2ajBnabJhS6Ve4fIy/0V3TOgahIvtTv+bwfKQc=;
 b=O/xMVMlvioWIITFLQkCjoZr+8CHry5D1lrS1hNuLSO34jbUztdIorzelc0dH8Vjerr
 Cl4jQs9EWkcWk3XbutuiDgf0QHRIJ3yO2VK9r/eGUbEkeUX7e4cf55hJufLt1OjBETqn
 7QZ1aGI39rau70t/KsMgO+aS8VIJxiqwbmNlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943452; x=1739548252;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP/oM2ajBnabJhS6Ve4fIy/0V3TOgahIvtTv+bwfKQc=;
 b=sVeWRrx98GEGRnYyotKGoy5S1FmJpWpt/MpO7NatxBmJqaBsxqEUZbmUT2rqhkH9UY
 uvAzWjpgxZ5YC0OWovwYsdZ6FepLLCAeo/YnXkg5ohp4+Eri9LRvWIJ3slAfjtCKjhFV
 RZPMP5qqodXJjXY5lJkxCuh8D0bsT0m2HQKuewXF1b/6TIg/NdVbec9SuUSto/zOtwqk
 YGMegP712Gtqi3+dAiVXtOJL1EnbnY23YWqDHw3AhUKgntXTPjY94QI7d5wvvhWv2WQV
 +K0yhbKW3eFGLuwQ4EKET6AbUhZb15MZ3g0EXPncC/0Ji0jQpynue+9WgUh4MsQ3apR3
 SgGw==
X-Gm-Message-State: AOJu0Yy5N5YZgXN7qU/4Ti1V9PlbCRNfpTL6kYNCh2dh2Q844FV74GgC
 8CIXzFW84isHS2v8kOAv9fyf/NtRIOWSZjU3GWxv9dQn/SuH1G1Hef6X8g+qV0kj2Nw29FnX4tE
 viMo=
X-Gm-Gg: ASbGncvJ9Z/NKwrs1tjGFmyXdPCJV/PdPc8QpXjBBjpsftC0+sef78UC0M02EBmcRJW
 PcRiHhTmTbpfAHwcOLJYJGgygN1NUV1X47BlHJX+5dF4uVOP8yWE9zFRAkaZU6fqW9mzS4Lux5M
 OVIItM9sfPeUsNN8JA2rzrs93EM3T7hSD0uGSSbWsyiP5xYaXyAHRvZDRTyvRwlRIdvpnmK2rML
 TVXmVg/PUAza4Yd7y650FuzM1M6gmztvU5Gk+Vn5EM3sTrILCxNWAMSNJyzzQpH9Gg90axJkvfp
 7vTRy7d442WTRQ4=
X-Google-Smtp-Source: AGHT+IFKTaeSPgBgGkS5+nJdtE+hxQ4Pe37U5hLrCDaQo3Lo2WakHmaeXh/0tOXmhpcKnd3Mc0+AgA==
X-Received: by 2002:a05:620a:d8c:b0:7bf:699f:c80a with SMTP id
 af79cd13be357-7c047ca183fmr648079285a.36.1738943452277; 
 Fri, 07 Feb 2025 07:50:52 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041e9f4basm203061385a.67.2025.02.07.07.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:50:51 -0800 (PST)
Date: Fri, 7 Feb 2025 09:50:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Bar Or <jonathanbaror@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Security vulnerabilities report to Das-U-Boot
Message-ID: <20250207155048.GX1233568@bill-the-cat>
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N3W3MerBxn9gzdmH"
Content-Disposition: inline
In-Reply-To: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
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


--N3W3MerBxn9gzdmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:

> Dear U-boot maintainers,
>=20
> What is the best way of reporting security vulnerabilities (memory
> corruption issues) to Das-U-Boot? Is there a PGP key I should be using?
> I have 4 issues that I think are worth fixing (with very easy fixes).
>=20
> Best regards,
>             Jonathan

Hey. As per https://docs.u-boot.org/en/latest/develop/security.html
please post them to the list in public. If you have possible solutions
for them as well that's even better. Thanks!

--=20
Tom

--N3W3MerBxn9gzdmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmemK70ACgkQFHw5/5Y0
tyynpwwAgXVt/5lvh2gyhKmRzxGBSqKfgTNUvi9QAWZ+GE8ew2sb1qsnjAyzs4bF
iksrhgvcC2m1PpiA3niBXczSKzgpIfbsqHhrs/QYE7mhY1z0e52PgEFHKtKyo+O7
mE5UKLdjKrD/lDKK5SzPhl5+vRNy9F7QHR2Qsmw5SbkjzUFfix6XlZ2WCd9i7AsZ
mzEzT4tvyYDDjD5AFiMS4dK6qZjIrdmx6zQcCHxHaGnct3rxcSu+yH9b+xjyXBGK
eB0JCt3u0AsHkYphl8HecO2f4rOrhRVYisulsHAHCnx0By/TXmHtPlXNTlCZ8x0r
JG6uuRDKo9aT6yU9llfclWNIovnZGLMJ6IGsmNKtLHji+lQhNIDbx4+vsoCRQZc7
c1z3BpzvUABeOWFOGoYSnggpQ47/DQqNjXar9SRpnoFNm0W8qmImsOV0NtV1w+Kr
P/GAVYYlz68MLZabf28z+6krrucROjop4dtufi41l77EzuzCXRRk5wdhAXQ9/Yo6
XwcDHMSF
=J9u5
-----END PGP SIGNATURE-----

--N3W3MerBxn9gzdmH--
