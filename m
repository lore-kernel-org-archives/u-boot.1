Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5536DD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE09783CC7;
	Mon,  1 Dec 2025 18:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ulOJmk96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1649783D03; Mon,  1 Dec 2025 18:49:26 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E83D283C6C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso3619478a34.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764611363; x=1765216163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aoxxnNxUuHxZLj30kAU1Wl6nOQh/l/2REkZ659AMCt0=;
 b=ulOJmk96GDQflm8CqKRv7UZgJvosGFQs2uysCXCJ+jm9XAJnEMZb2VmQRgJQDu9cpu
 6Ykz/HIoScHnEBnMh+f6KDtPa1lrvYeuwGsbqSJ2A+2zzAmWXXJ7F7qoYjtfR5R7sSXx
 0E+3FAX9k5pnqpoXuG+E41ELhJLYhC+i74evA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611363; x=1765216163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aoxxnNxUuHxZLj30kAU1Wl6nOQh/l/2REkZ659AMCt0=;
 b=qRVjpVE2XqZvGPg2qt+QnxqhyDtbMCIIFhfM3VF2sMQ2H5apwDg6/fpKwFqTAE4vWp
 5UWvuyhQB0Aa5oSivPocnI7N2JB/KQpTv70LQZRDFxi+GaPyHn6m88BtBB3H0grlgpA/
 fBwDgKR0xYN+TrmnYStpbPWh2xg0hLqxwUByTuUhRQlTkePgiyqvmpMNT6k/wa8UcSAx
 UYjXgbyBw207PYM71aN9bC5gKuHUayuPnQwNf3cJSnEMIoXVb+1y3TLD95F2N1pm5EXB
 MvQe/EzF7CbhcZLnc8GxfAC55hiRuFDvJFAf8H2aKv307Oyn63g0pTowv9ux9fvhEEin
 J9JA==
X-Gm-Message-State: AOJu0YzDqA472Dbi6MQO/spRBQXTtrz43sntOskMKK45Ey17XFK6RGeL
 MM9FWoObaX7JS/BXRBDJe6J7tVBpeYm4iwgYp4yO/ThzUCLiA9MbBzITFmFw+hEZwUI=
X-Gm-Gg: ASbGncseUhkSJ/dmv5DzM2V+QOdysQUlS0cDhgco7VZfKyXL7jUWRHwTEGp4Cs8S6Kx
 ZuTgARfsmGqxLeEl/5vqwBQX6Vbs/4z4wVE9bsyKarW2aOv9IzBbIxl3S2euPIbvjvmehQav6+h
 QwDuvoKgXIUlJw1n7P6CIabPY4Icgq0HbZWyJL+f/26tzX2CIes5utm5cW0RoVnEXmlaKeq95L2
 1US5wuzPlBAKR2maVRym+KDKQdIUy9N7qju8DiJGtdv4O5ZB7oatPeeWEaWAP/6IyaRPxRNv3lW
 pFmW20tm07qu/bPcMf2oEhEs+zgSVZY/yXcGuUy5t4Dro9RKjo9Cy9teCJJ7CBl86KR5sIZBcwC
 5pWmNGtNva76KAaixLW+Z/t0XwCVAdvI+TlS4zNoE5v1k8uzGUIM6JBxfZq3qS0mZ2FkRqSa4SJ
 iVpwK5Zeju3KDpAw/5w3bSE+Y21x5zEIlBIB4mzmq8WSpIQtNxfw==
X-Google-Smtp-Source: AGHT+IFb9FqyF/OZXglBD5VbPUDh2ra2Nz6KXMm9aiHWgA2Tg6vfDgR4uceuw1TkKioR7SWqyRZeLQ==
X-Received: by 2002:a05:6830:4486:b0:7c7:6e32:dc72 with SMTP id
 46e09a7af769-7c7989ee704mr18241161a34.2.1764611362481; 
 Mon, 01 Dec 2025 09:49:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c910025e06sm4856299a34.28.2025.12.01.09.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:49:21 -0800 (PST)
Date: Mon, 1 Dec 2025 11:49:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Glass <sjg@chromium.org>, Sune Brian <briansune@gmail.com>
Subject: Re: [PATCH v2 1/5] spl: Kconfig: Add missing SPL_LOAD_BLOCK for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
Message-ID: <20251201174919.GA2247668@bill-the-cat>
References: <cover.1764574369.git.jan.kiszka@siemens.com>
 <db6aa161176dfcc4d2764e9411b4d195c9c3208c.1764574369.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yNfO8uuHPVBtiOjS"
Content-Disposition: inline
In-Reply-To: <db6aa161176dfcc4d2764e9411b4d195c9c3208c.1764574369.git.jan.kiszka@siemens.com>
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


--yNfO8uuHPVBtiOjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 08:32:45AM +0100, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> We need to explicitly select SPL_LOAD_BLOCK when USE_PARTITION_TYPE is
> enabled, just like the other choices do.
>=20
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--yNfO8uuHPVBtiOjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3VHwAKCRAr4qD1Cr/k
CkdTAQC8AG5OdAYxPv6HO8Rj1ILXRGjCAOPN95LMHQRYw1xWjQEA6/JthiXrTayx
NIxm/pJupCuUrE2QnMFzq/SBUhqhUgk=
=9xPi
-----END PGP SIGNATURE-----

--yNfO8uuHPVBtiOjS--
