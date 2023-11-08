Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EE9C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 13:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC088718B;
	Wed,  8 Nov 2023 14:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nL7uCXct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C988718B; Wed,  8 Nov 2023 14:29:03 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B40E8716E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 14:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7af52ee31so81791737b3.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699450140; x=1700054940; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hUPz4ITuXyYVSNR0Dm84bMPIsJD6ysFTQ293x0rzgKs=;
 b=nL7uCXct3T8QaFFPmyacWzn3+CyEhcr3RKj1rQWD04ooQx7xiFxZfLFAdyvW9LeZ7H
 uHqUL7SdPdqNtqCZzNj7ev5XD6lPvkSZThAsXF5nKemA6Pbp6pTT8lLN7ISg+lRreg1h
 3fD6+p2KYj4R4DSoFG39aSVzKytBibzqF3E84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699450140; x=1700054940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUPz4ITuXyYVSNR0Dm84bMPIsJD6ysFTQ293x0rzgKs=;
 b=mwg6kP9H85W3zjgMOUcJBQCACZZ2I1OsehfwbZpqrZx/Lc/W5OtI2WHsuZ1f4hHDqV
 Ajq2XsLCmxy5B7nYQla3I1WtGf9bns1ySZ+7celExJfbPieVZV2hHqs9fgP/ZIoFC+pg
 RUZNFh4GBSkFS7Cp7yY9b0i7CtBXXIE9PY/tsrp9rOC+rvy7ZyC7KdlG7LVH4z/RYhGa
 OkHx9hcbR+lIGzxFkSte/gxF4EQ56dn13EKHOu6ZQKXCPjDz2EQtrP4Dcd07zi8TFOXK
 BtbcyAt0NzB9Ii6mqTopE37EqSCWcH/sx3JkBwPsZDIMeDHSgCMNl8kQC5HAPSDKcug1
 5ccg==
X-Gm-Message-State: AOJu0YzDEXwy3/RoQtR2oMPbgAAHV0ENeAEWtNrGlPtI6vnc4VPu3Au+
 gwaGJgf/XkOwTPhrmS8RwGsl4w==
X-Google-Smtp-Source: AGHT+IFsdyI8V5/2TfDrU2uxrOr/Aad9MpWfLg66DUE8ERhJz2hAEGmIvdPCetGtlGRGX6oiF3b8RQ==
X-Received: by 2002:a81:52ca:0:b0:5a7:fc20:7848 with SMTP id
 g193-20020a8152ca000000b005a7fc207848mr1558135ywb.1.1699450139889; 
 Wed, 08 Nov 2023 05:28:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a819e0d000000b00577269ba9e9sm6833973ywj.86.2023.11.08.05.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 05:28:59 -0800 (PST)
Date: Wed, 8 Nov 2023 08:28:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com--compose, KWLIU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/4] board: nuvoton: update console environment variable
Message-ID: <20231108132857.GI6601@bill-the-cat>
References: <20231108004027.281383-1-JJLIU0@nuvoton.com>
 <20231108004027.281383-3-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xp7ukjuOjkxuNM9L"
Content-Disposition: inline
In-Reply-To: <20231108004027.281383-3-JJLIU0@nuvoton.com>
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


--Xp7ukjuOjkxuNM9L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 08:40:25AM +0800, Jim Liu wrote:

> If CONFIG_SYS_SKIP_UART_INIT is enabled, calculate the
> current baud rate and update the "console" environment
> variable.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>  board/nuvoton/arbel_evb/Kconfig |  1 +
>  board/nuvoton/common/Kconfig    |  9 +++++
>  board/nuvoton/common/Makefile   |  1 +
>  board/nuvoton/common/common.c   | 71 +++++++++++++++++++++++++++++++++
>  board/nuvoton/common/common.h   | 11 +++++
>  board/nuvoton/poleg_evb/Kconfig |  1 +
>  6 files changed, 94 insertions(+)
>  create mode 100644 board/nuvoton/common/Kconfig
>  create mode 100644 board/nuvoton/common/Makefile
>  create mode 100644 board/nuvoton/common/common.c
>  create mode 100644 board/nuvoton/common/common.h

Please:
- Don't include <common.h> in code, and audit the rest of the includes
  in your new file
- Don't name the new file common.c (and common.h) but instead something
  about UART, and then only build it with your new CONFIG option
  enabled, so you don't need a build-time check in the function itself.

Also:
[snip]
> +int board_set_console(void)

This function only ever return 0, make it void?

--=20
Tom

--Xp7ukjuOjkxuNM9L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLjRYACgkQFHw5/5Y0
tyxn0Av/dCsXpDboFA/Z/XaCKtiQzFf5wKuYLq6n6SdT3LeLqW/v4J4zlXcGKwKl
0tCjzKi/7x3D5vSti6WCWxb7PFBZiSflSz+Q7Nl5e3W+xcD5cOMnsAAVEt4Tx3L4
zBxHEToFPT28bfzGQNobl6EqUznHqyiI9CLSbYj21dn7VYqUKkHMul4L4eXaeIWx
fp7Y/zlqqfC2q4Gm60CMCV6U0AJFAPLjy5rF9vHEMf5fPriu7WYwkDK2H3ZBIPb/
kJyBgIHfpEzery2otPKyQtCBXHDV2qsF8IcpraGHZZT2Y/2x5xzbmZFomLRH/eB5
w8HYiLdF/li+PRGguHcakKU9Gek+QKG003VSRPcf9v0NTQjPEop2NaGorrsgFJCi
/sRKSwyHnKD0mnwK81nE+leX8Ko9Opdd7wegGvoJBRTzeNE80ktSDnzx0VfKkZIz
q5KKgc49NdyCwGcBd894GOcAxZ8IOBeVHFU0nUHUTvx+8AFVaRx/4KLg9gZBZ9cp
raq+vJnA
=VAu7
-----END PGP SIGNATURE-----

--Xp7ukjuOjkxuNM9L--
