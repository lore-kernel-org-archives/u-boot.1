Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CF7C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 15:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5669987D1A;
	Thu,  1 Feb 2024 16:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GJ/5Uls9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E3287D0F; Thu,  1 Feb 2024 16:40:25 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350BD87D1A
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 16:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc6af9a988eso933791276.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 07:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706802022; x=1707406822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nlv7jhv17qvDgbbQmIswSv5v2FM8BtXFY5j85oUQ/9Q=;
 b=GJ/5Uls9XI8HQKGtE4MS0X241XtPhclu0mIoVawMd23fxSQljDc+/Ie3Z9MYpJaE3d
 9rJ8zhcVIpXb9DrQF0pEn1Rdnw/3lBIicxpQGC8tfFzEEDj88tjsJCpuFLnJiWQTMn0V
 F7dyvQ4EluSRO4CKhcAQVKYlhg1vhgCd/RHJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706802022; x=1707406822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlv7jhv17qvDgbbQmIswSv5v2FM8BtXFY5j85oUQ/9Q=;
 b=kVdsOpCy6beokd1Zr810S0QfptKkzVpqlBYP39PyxcMbFho1tyXqcaz+WlUTAxfNrA
 UWPip9FjSI8Zk/r2YHQrIlNgivXNtICFE4KD26J0dc0wPvSD1b35Ortir+j80ZTmKbWs
 oVgcZBu+QEeX7hm7AAwZjNPTdULk/A2nCtB9SVN6HN+JVnu8NlVAggfYyg3+9tIbSFxp
 3Hm/liJJG8wDCzBiQEjHLRTWuGafcIqgTMkAXK8pyV3AYnzi5ZpkpwxL88h+HWkqGIUq
 +p04SAGB9drjbJGzLLPrH8cAj0sUiZIEkYyM/z/ynWRK/Hb6alSzQERUsP1UarD8pcMa
 DAcA==
X-Gm-Message-State: AOJu0YyQFyGNmOUE521rgCgzOHEsm0pY7IqkjHSj3Cy5xnR8f9Bcw1fw
 hFiX85T+ncN9Oj61F2alPJsYqNy4Z82q7Amz2DjnxpSTpB6uGMRn/MBsqrLrBxU=
X-Google-Smtp-Source: AGHT+IFQqAMIAa2Gouvgftko1khNFgc4saqVbBpYBMXShdtab5B8V/qME11v5kssZ3WV9+l0A53jWQ==
X-Received: by 2002:a25:df14:0:b0:dc2:405b:5930 with SMTP id
 w20-20020a25df14000000b00dc2405b5930mr5905801ybg.8.1706802021926; 
 Thu, 01 Feb 2024 07:40:21 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWIBcqf4sZPrnCjgvXeks1VevEp3ZCiF2df7uep1fppII1RqIscAkiSBbguePnMRGLb4zVleElADg6Gd2HdG8TkDo6UOyjKvaoInl+kXsrt2KVC8ybqDt7wgi7mzzHLND/yeV7+T/tQexNCaKzD/ppB/4bxGvhLyDWDYxYccVYchdeC42IGTOxj20XJ6E5MAub1y43kn4svcp5AWkSFd3RAoNFb7aOfsRhYY6VdNp15D3Zh
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 c2-20020a258802000000b00dc2366900f9sm4061801ybl.65.2024.02.01.07.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 07:40:21 -0800 (PST)
Date: Thu, 1 Feb 2024 10:40:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Ludwig Kormann <ludwig.kormann@ict42.de>
Cc: jagan@amarulasolutions.com, andre.przywara@arm.com,
 jernej.skrabec@gmail.com, iuncuim@gmail.com, cfsworks@gmail.com,
 samuel@sholland.org, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] sunxi: sun4i: Introduce KConfig option
 SPL_SYS_CLK_FREQ
Message-ID: <20240201154019.GX1152441@bill-the-cat>
References: <20240201133014.578083-1-ludwig.kormann@ict42.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mxJhK5krGNGZfx3Q"
Content-Disposition: inline
In-Reply-To: <20240201133014.578083-1-ludwig.kormann@ict42.de>
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


--mxJhK5krGNGZfx3Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 02:30:14PM +0100, Ludwig Kormann wrote:

> This option can be used to modify the initial SPL
> CPU clock frequency.
>=20
> This follows an earlier discussion regarding A20
> CPUs dying after reboot in SPL initialization due to
> incompatible CPU clock frequency and core voltage. [1]
>=20
> First attempt was to update PLL1_CFG_DEFAULT to a fixed
> lower frequency (144MHz), which fixed the observed issue
> but might not suit all A20 users. A KConfig option
> should be the better solution.
>=20
> [1]
> https://lists.denx.de/pipermail/u-boot/2024-January/544897.html
>=20
> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
[snip]
> +if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
> +config SPL_SYS_CLK_FREQ
> +	int "sunxi SPL CPU clock frequency"
> +	default 384
> +	---help---
> +  A static value for the sunxi SPL CPU frequency, must be a multiple of =
24.
> +endif

This should really just be "depends on MACH_SUN4I || MACH_SUN5I ||
MACH_SUN7I" and then "help".

--=20
Tom

--mxJhK5krGNGZfx3Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW7u1kACgkQFHw5/5Y0
tywBaQwAiR8hTU3mgCHYyNjKHtrI/78RXtGayGHMtLbRpOKgUssZzda59kUocT8H
vfsboz2mv0NhSkPCkYCOEu71uHxKrbjPZwGQeh5j1Tz1RGVvu256sRmuBn1sJ10J
CJGo5eMW7RZv9rZ3d/bha2F2Bxk8wpKuTvTlm1U78dIWar51U0QCLle0a6nvrudK
+7A+NqCfKHOGOxqrsITQu5ZdHJM+e9AqLoYoiBpe4OhlOtPX6ixH9RUgRzoEYpRN
xOrD3/q7CC2YUYslEOVIWhjrH82UxY7vmfL2hyFfs70jlfTDnsbshqo1CTTUXDv9
ppEgBk8Gx/TLgFP/zp/0DVzhsgkYI7b1381DxnT3vE47ynTZEPWLWneT2kzHEzFr
MS+Mv/b2vc6ZKf3lUyKeLBm5GtaKnfad5I6fpPb/uKhnVHIcTpK1TNvoUPBLP/6b
/nL7Kg0//joq0Rv7cHFXzvTKMRfIOPnUez45ECn3quCCz+cJ3HAnHb2bPf3PNQb3
LI2ttJmZ
=tyQ6
-----END PGP SIGNATURE-----

--mxJhK5krGNGZfx3Q--
