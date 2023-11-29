Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F4BC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 16:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329D087638;
	Wed, 29 Nov 2023 17:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pVm1TMYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2807A86516; Wed, 29 Nov 2023 17:58:04 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2216987775
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-db498e1132bso4149757276.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701277081; x=1701881881; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=47laEALiiWYxRORgsSj/ObnecFX7kYxR+/2Fj7tR5ZA=;
 b=pVm1TMYlc0tBzSF3IcGLlsDFwhOtTQJXS1qfoLFm5kNXyCNh+JoWBPV2xkZ9gzJ2dS
 oXMqMAHKZMSTw/8gwn/xAWOXGpc5WwDwEWss+NiVSwMD7gvNnRIMMc1UarQ3yP4Y1S7c
 r75mdOEXY4Ta8HvHAkuh9OBEnpDiSlZusrVZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277081; x=1701881881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47laEALiiWYxRORgsSj/ObnecFX7kYxR+/2Fj7tR5ZA=;
 b=Onya1F22KEhUyPosm4INt9q71SD72G8YV3n0LB4j53EMgoOMc6uVQwsIEti5aa8Z+B
 /E2k1ZMQrYGktWY86WMljCO0mRXaqSYBWvAD+uY+hGf6K+18b+5p5hzSXt9Qx45fEUtU
 vRcMwWNtQdiQnomLQYVTHHReuvWW9x6EIA4j5MMguPuc/4GPk0ODNvhTVSrFEb3RvCCY
 d+zJTD4Z9asP90szkEJpmdMbWnZxY2CD/9KvCP9CUjXPk+x8wwsyEUekuPONy1gRvprh
 Je1jxjY1pF8zfLA9drS12Vw6NDhzD3GG7+Ck/on+xcMlM58l9inUBePWrzSsB8dEHDjB
 1rIw==
X-Gm-Message-State: AOJu0YxBy8uKhdDd/8rP0UtZsN4FXyTOoyIKLbX2M7I5AI8HV0m/wojd
 FGohJ8vMsYsWKJOfTXG13tTpZQ==
X-Google-Smtp-Source: AGHT+IHS9BSmCVpTOZNMpAJVu+s81O/jLbUD31XXiwwwZMSw8o5C31aeRRd7hI0OX5PVrJYnOExc5A==
X-Received: by 2002:a25:86c3:0:b0:dae:44c5:a15f with SMTP id
 y3-20020a2586c3000000b00dae44c5a15fmr20303756ybm.45.1701277080749; 
 Wed, 29 Nov 2023 08:58:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a5b0151000000b00d7745e2bb19sm4159936ybp.29.2023.11.29.08.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:58:00 -0800 (PST)
Date: Wed, 29 Nov 2023 11:57:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Alex Bee <knaerzche@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ovidiu Panait <ovpanait@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] timer-uclass: Always use "clock-frequency" property as
 fallback
Message-ID: <20231129165758.GL2513409@bill-the-cat>
References: <20231114211127.52443-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JWyErlVdAQYx3UVF"
Content-Disposition: inline
In-Reply-To: <20231114211127.52443-1-knaerzche@gmail.com>
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


--JWyErlVdAQYx3UVF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 10:11:27PM +0100, Alex Bee wrote:

> Currently the "clock-frequency" DT property is only being considered as an
> fallback if either there is no clock driver, the clock driver implements
> the request-op correctly or there is no clock defined for the timer at al=
l.
>=20
> This patch makes "clock-frequency" also being picked as a fallback if
> getting the clock-rate fails, since clk_get(_by_index) will return no
> error, if a clock driver does not implement the request-op and does also
> not support getting the rate of the clock in question.
> timer_post_probe will take care if the property does not exist in the DT =
or
> is defined as 0.
>=20
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--JWyErlVdAQYx3UVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnbZYACgkQFHw5/5Y0
tyxp5wv+IsVqomSms2Txz2CKGK1dbF+QWXJO6+68AL8whw5KuRFJOL93IIYQgs5E
dyapvRlPuzzg4XKV0RRWZbvtaQbZr2BJRuuDDmF6FWbYTcs7BpDULwpYaPYO209f
SEgTmdNhbYxFaK0lPaGOGZ7arp6EPllUdmS7rbcCCUfe/IBDL93l2m3TF0+uWOmG
sYVL48+EnkC+G3qnLqh/LMb1UuQweF9QXREQz0D5z5tLcxK2qnkXilJwHADMeQsc
hySl3k9jKTptV+eFPElsyvnBL6H8/nfpHU0xXJYJ24ZyW89xC40rnYOpNsXwT3dO
JfnYman3F+/ZAri6ebA48+SUxiOJXutyltA/hIYG039DBc/XAejK60NJWbUW+0Wh
Z7kWdZZE/Tc/cc7ua2KP/Z0URpFtrVHvfZb0Hl+Z/FKcTp+ogzJUGS1fBLL6iuOF
TAXoLck3DKTFBBbWcPEexe618Xn0dQzJFE19u77EhNoSRxeaDm9ohA7cpJcXMsu1
H2WIyhu6
=Wofj
-----END PGP SIGNATURE-----

--JWyErlVdAQYx3UVF--
