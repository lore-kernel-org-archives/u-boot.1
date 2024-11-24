Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DECE668B9
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 15:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6AF89523;
	Sun, 24 Nov 2024 16:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BcFoEYQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D756B8952C; Sun, 24 Nov 2024 16:57:06 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A04C68951D
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d83bff5fe4so11760966d6.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732463823; x=1733068623; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WKBpaejFxBY14vQv/OMftRJE5nGSoQkrkhrcVWWFHro=;
 b=BcFoEYQaJdMDvuQOBShxF4M3yP4z299O9co1qkujI7pRc7OymVTAEsLZAd/E5l/df9
 Fa+YiZQIu4RORFWJE1nVzKHr2oZFafTyXT0n+nIZ+lsVQymM3RRJuyP/6TAl1XqhXjZI
 5hw/KSTk6XpX+YLW7L+Qpto/Iu3JuGOMHGPY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732463823; x=1733068623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKBpaejFxBY14vQv/OMftRJE5nGSoQkrkhrcVWWFHro=;
 b=TZxSwRzVq+dZ2lrpL/ems07gqJs34LxFpdUDIMfPmGos7w0MHTbPdSGZhmY1ScWBt2
 liLg0dLL9NyR1YnNH1m4O3DbaZuBOXrtMB4bDzczsgVbFTLQN+o8vcSYqu1cn/T3ih6s
 fTg6KDL4HTrqjTGoSEwZqZmJKXWCo7e0+27Q8R44sq13Itwzz1WfkWf6yy8g7ILo+B+Z
 IKtIqa99+eg7QOfV1138SZvYK8CfSMKIwd1FV/QOtjHRdE8UpBAteitAfwOJ/5Jt8H9s
 gIlsL8A+N5uLF4t2cGFcp3zdp3zHeSaAmqDrliV+DsKm4W5hG5mrnmJylI9vmy1LrV3o
 pPKQ==
X-Gm-Message-State: AOJu0YynPI7aZX7pY6REaN21uRW/3WapXi1t6J7/TCye/fXPdxIWyw8c
 jawVZw5+VejemG8dmglTjxl5CyOi/DaCkhO8i+2o57k2hGtaPfNdEnW4hmjAPFc=
X-Gm-Gg: ASbGncu0HPlbtbXJc1jK2eT963pU0eiyE3u0mTfTMfl1uZtsv9+a9lYUOwr6G2q8JHp
 50jCIZv7llXN/hTb2QlFMj/S7D5o6xO3CtkI1fzPBx7ElQiE7p0t4YxMfg8+/rnz086ssuVqPct
 JLXqDC6qMAmX+wnMY12idfg2rhgyASByQtqLtw1XXEhPmBxAq6M14HshMkVKkDAf77wNUmVSU3x
 Nu3sGPm7DnszhGMKYVg4GNbfhe4HNm4gSQx7HOmBkX6jzMrmw==
X-Google-Smtp-Source: AGHT+IEzRlnY7IdbS+jfURF2X0LNBu+awN8VvioVxK6vSI7C2cWEl5vayY7nySPxJ7oC74JxN5akEg==
X-Received: by 2002:ad4:5bcf:0:b0:6d4:36ff:4354 with SMTP id
 6a1803df08f44-6d4511555e9mr154399836d6.37.1732463823487; 
 Sun, 24 Nov 2024 07:57:03 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b2509dsm32479266d6.83.2024.11.24.07.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 07:57:02 -0800 (PST)
Date: Sun, 24 Nov 2024 09:56:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 03/10] Add a command to find a load address
Message-ID: <20241124155658.GC3600562@bill-the-cat>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-4-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iEo+nLbvtz690P5E"
Content-Disposition: inline
In-Reply-To: <20241123195616.305687-4-mjg59@srcf.ucam.org>
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


--iEo+nLbvtz690P5E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:55:02AM -0800, Matthew Garrett wrote:

> From: Matthew Garrett <mgarrett@aurora.tech>
>=20
> For systems with more complicated firmware, the firmware memory map may
> vary significantly based on a number of factors. This makes it difficult =
to
> pick a hardcoded load address. Add a command for finding an available
> address with sufficient room to load the provided path.
>=20
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>=20
>  cmd/Kconfig     |  7 ++++
>  cmd/Makefile    |  1 +
>  cmd/addr_find.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 cmd/addr_find.c

This needs to be reworked on top of how lmb works today (which did
change post v2024.10) and looks a lot like what
arch/arm/mach-apple/board.c::board_late_init() was doing, even back in
2022. Do you end up using this functionality on more than one board /
family of boards? The easy path is likely to just follow what mach-apple
does, but the more broad path would be adding an option to configure the
key environment variables that are used as buffers and documented in
doc/develop/bootstd/overview.rst / doc/develop/distro.rst dynamically
rather than statically.

--=20
Tom

--iEo+nLbvtz690P5E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdDTMIACgkQFHw5/5Y0
tyxVBQwAowF0o6Ks0t/SqW/xQUPEYFkOEhFKq7YnVNBwyzLTOrDHwU8zEX0n1H7F
BqROFN381wOSR7wo+y3gK3V3mO1O79/P8sCZNZ5PhQnxnpLp27JGGu+/E/bGRvO8
++xxS8M5kFzoYQxU7qxjq60J5HxQ4Hhu6Rgh9xfbGfHAQQoTaGT0TtAWtyXjG1Vf
lhxKC3sGJp7dgp8DgjU/x2V6NGvDNeRnAe0hEXhd0pxRPjgh0PqXWO3GmAHVXzbx
8ai7bnF1qNwmBdWhi3OefuTtn7U7ILO9iVpwbVELsnGvhVIjHYq6M4sDShL0QA+i
Oi/kqPWCrS524alR6WgQgWJq0vuKZW9GE2r4r0xj7i/pB/Lci4wxGyixYNvZEhh1
JzfyiizhSxp5r6Zg+LzPCZmOykeK48Wv2B8M7DtozMMfLEPB9I287H9AogcYtVwY
IJeIJixNEhmdpgEBvFi1hLowu+smFGtUbjGU17zrG7+Z16ocLsyy6mIUV1Vr+RS5
NdiL4wYC
=Z1Ol
-----END PGP SIGNATURE-----

--iEo+nLbvtz690P5E--
