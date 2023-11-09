Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF98C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 19:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E1986E5A;
	Thu,  9 Nov 2023 20:24:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="guUqqwGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E8786DCE; Thu,  9 Nov 2023 20:24:27 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E123786DCE
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 20:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6cd1918afb2so733493a34.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699557863; x=1700162663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tCtARyKrRcIRmLxKxjRGuWZ6wIM910Q6BqV5QZ3N+zA=;
 b=guUqqwGXKvPS5RzBgSQL30/gusBgVcbgBmISrYtSCAobuFke+GgXFXDemQwXeWgMpr
 MHfuzH3KJGUxq2LHGmfe/qDo1IK2Wd1LPj98fIjWSv12N184zqpS37qncl5TpS2r1Y90
 6U7I6xBbRYQe6IW5SFkWPQAcykqVxQnq14Bpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699557863; x=1700162663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCtARyKrRcIRmLxKxjRGuWZ6wIM910Q6BqV5QZ3N+zA=;
 b=BsAxaRBigg362adaQH8s+84ch9z69fMn2CmxHzXwwkEct1BOBRC6yN2Vd+Tb80YQc8
 LMWwv5zTipRUbXWZeOo3QhfjGHkAt4PGuC9RjD8HClqPjtLpXOz8h7GNMsszkO78FrDi
 YCbLqZy0Nz37/gkRR2tetLDnxJJY1kRl7vYNZkwWjk/e9u8+49ZXdg7LrsXLYAj96WI6
 77V1/SvO4venqnqbKRs/keRmziPWaVADBPVrA2VZs5qX0ieToVHaKDNrycLkmbiDVuya
 FLljmy4sjTSpVvIIx6YbkK0Xc6G2f71P+nscvtJ0o8tVK011DoMAW2hV+/2J+qHH108z
 AVMA==
X-Gm-Message-State: AOJu0YxQzvvjGfiHNRidebpXCDi3zUrw+o+MDjFOWmNkEGTIAga6hSMF
 c5nH0fitfflQaZRunDYQUmBh+Q==
X-Google-Smtp-Source: AGHT+IH7tSkj7PBV1aDkzY6Fwq9LaQmuW2ClTjFA4LaFgf5Ovm2Bqf8GxOraBUM30JTkiSmr1JnV5w==
X-Received: by 2002:a05:6358:52c8:b0:16b:6ea4:d71d with SMTP id
 z8-20020a05635852c800b0016b6ea4d71dmr7201305rwz.26.1699557863122; 
 Thu, 09 Nov 2023 11:24:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a05620a288300b007756e75b91bsm118751qkp.78.2023.11.09.11.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 11:24:22 -0800 (PST)
Date: Thu, 9 Nov 2023 14:24:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] acpi: move acpi_get_rsdp_addr() to acpi/acpi_table.h
Message-ID: <20231109192419.GH6601@bill-the-cat>
References: <20231109172302.54324-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BaLi60NQB9Zm0WE+"
Content-Disposition: inline
In-Reply-To: <20231109172302.54324-1-heinrich.schuchardt@canonical.com>
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


--BaLi60NQB9Zm0WE+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 09:23:02AM -0800, Heinrich Schuchardt wrote:

> Function acpi_get_rsdp_addr() is needed on all architectures which
> write ACPI tables. Move the definition from the x86 include to an
> architecture independent one.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/x86/include/asm/acpi_table.h | 9 ---------
>  drivers/misc/qfw.c                | 1 +
>  include/acpi/acpi_table.h         | 9 +++++++++
>  3 files changed, 10 insertions(+), 9 deletions(-)

My question here is, does this work right on non-x86? I know you can
have ACPI without UEFI on x86, but elsewhere doesn't the location have
to be provided in some manner by UEFI? I know I'm thinking that's the
case with SMBIOS (with a few exception).

I'm assuming you're doing something here with qemu and its qfw interface
and risc-v.

--=20
Tom

--BaLi60NQB9Zm0WE+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNMeAACgkQFHw5/5Y0
tyw5AwwApYHfCBZgrf6eWtPJ0NoyJEl1vuik1Eh7BYsx6DwqTXUJn2IsDWa9gCQl
7AYlSnKwzZCC2UWBZd3L6EubrzOSLiscsN0h15bjT7RBVms9h83uAr03osX9Xzek
u4sttDSkDVr2PMHOSKwLHVWaEP7z77ZR0oz8sw1iybwkpi59kVOCYeZkcFOCUdAu
THwFxQuYm3Nt3EOU2OZbqc5OYhz1jSS18YYkto2yyPoer9yDlOImK90lEJmHb8Ap
t/KziwEQep35RqXPovFrswXtfRd1zLMKsRKat7h5rXvtTyXuVlyYYqpmbrs9nLzi
fTYBn1isrGEo4ykSyH+17LSebSqujf4zWrqgru6m61nVKHu3Ie4sKiVEVcYn9iHe
/vAdXBG9OEpLgHeyiD9TbfutccjmL1TZQZ+WNurm/N5Kc3txAKCGLQPXs13vUBsq
jxvX2Exs6T6e7aF/QC9P1NN3OhqPNK5TabAfJ0nXMweBlhc/ZSrp/unzscX4Cq9d
w1VnenO/
=/j8K
-----END PGP SIGNATURE-----

--BaLi60NQB9Zm0WE+--
