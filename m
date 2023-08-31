Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4CBC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 891BB865AA;
	Thu, 31 Aug 2023 16:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RwIOmnfz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36997865AA; Thu, 31 Aug 2023 16:12:32 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69456865A9
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58ca499456dso9858687b3.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693491148; x=1694095948; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=udecg9Q34uMJIUNjrB9CWuLD7lV7RdhYUE2IHXJ8AEQ=;
 b=RwIOmnfz4yUMmgo3DH3YJZxVFEO5r1GLu/xEX4t7zxpWpA3SoH4lJZ6xfUFxebUaL9
 LVEku7z60XQVy8U+0LfVjLmCSRI2/nlRjfglunNSMFlJyweTzQgu0ke51QvWp6IDSsWp
 rxV3OUm2q/A7IMKT55UEvHaEbAOUe1ypEN4cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693491148; x=1694095948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udecg9Q34uMJIUNjrB9CWuLD7lV7RdhYUE2IHXJ8AEQ=;
 b=Dwi2b947vYJB3zLBcepAEiz01dRZ/JUoaqEL/JebDqzSxrT1OJrpl5049Kt6i+lG/k
 QxNwmUp8aA0GuJCdGloTxV22q8Eu0t8idy6hY/DueZ/YKNOVmsmV7TEVhwF+ZCZZVzwz
 VJWdPAqEcY4Y+MHgGqEUOEJFtxbPkO9xzIpLMzney/YOh0IZY8/YIihp4DmC8/cVYdmN
 GfzgqHB+A0Bx6LbKIk7YpmIQ9pV5YfHwzu+w+UuHYI6r8ywpfetMhJKXaRBZGIJgYAad
 +gz3JWqgUqRw5G+xXq1O6ndS0cSB67rb/IGfIWuPL8+5497/rkSpLLLhO6N8wC1LiA6z
 aQXw==
X-Gm-Message-State: AOJu0YxjC8IEg/osNruX5r4WM5m2uijaqt5C1ljyjRhS4agO2BMR5o/8
 kQher5FDBgCkAgDcRSvVY9KzsQ==
X-Google-Smtp-Source: AGHT+IGV951x0S1kiyWt7BHkZJvOZfvQz0k8XyvItNCCKRFlK5Cbh+0xvap2PFgaMl8umXlS13ojuQ==
X-Received: by 2002:a0d:d896:0:b0:56d:9e2:7d9e with SMTP id
 a144-20020a0dd896000000b0056d09e27d9emr4864221ywe.21.1693491148151; 
 Thu, 31 Aug 2023 07:12:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 d204-20020a0ddbd5000000b0056d51c39c1fsm429276ywe.23.2023.08.31.07.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:12:27 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:12:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 00/19] Kconfig: Tidy up some options
Message-ID: <20230831141225.GV3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OC7oYSvjcp7rxD9I"
Content-Disposition: inline
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
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


--OC7oYSvjcp7rxD9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 09:52:54PM -0600, Simon Glass wrote:

> The view from 'make menuconfig' is confusing in places. This series aims
> to improve the top-level menu and also the boot menu.
>=20
> It also groups FDT-fixup options tegether, at least the ones I could fine.
>=20
> Finally this series marks the distro scripts as deprecated, so people have
> a pointer to standard boot.
>=20
> Changes in v2:
> - Fix FMU typo in the subject
> - Drop now-unnecessary depends on FWU_MULTI_BANK_UPDATE
> - Mention in the DISTRO_DEFAULTS option that it is script-based
> - Expand and rewrite the commit message
> - Use the word 'Mark' instead of 'Make' to improve the English
>=20
> Simon Glass (19):
>   lib: rational: Move the Kconfigs into the correct place
>   Kconfig: Move API into general setup
>   video: Hide the BMP options
>   video: Move BMP options and code to video directory
>   net: Move SYS_RX_ETH_BUFFER into the network menu
>   FWU: Avoid showing an unselectable menu option
>   test: Move POST under a renamed Testing section
>   boot: Move fdt_support to boot/
>   Move fdt_simplefb to boot/
>   boot: Move some other fdt-fixup options to the same menu
>   boot: Rename Android-boot text
>   Kconfig: Create a menu for FIT
>   Kconfig: Move SPL_FIT under FIT
>   spl: Tidy up load address in spl_ram
>   boot: Make standard boot a menu
>   Kconfig: Move TEXT_BASE et al under general setup
>   Mark DISTRO_DEFAULTS as deprecated
>   boot: Join FDT_FIXUP_PARTITIONS with related options
>   boot: Join ARCH_FIXUP_FDT_MEMORY with related options
>=20
>  Kconfig                         |  67 ++++++++++-
>  boot/Kconfig                    | 202 +++++++++++++-------------------
>  boot/Makefile                   |   4 +
>  {common =3D> boot}/fdt_simplefb.c |   0
>  {common =3D> boot}/fdt_support.c  |   0
>  common/Kconfig                  |  20 ----
>  common/Makefile                 |   4 -
>  common/spl/spl_ram.c            |  19 ++-
>  doc/develop/bootstd.rst         |  23 ++++
>  drivers/video/Kconfig           |  11 ++
>  drivers/video/Makefile          |   2 +
>  {common =3D> drivers/video}/bmp.c |   0
>  include/net.h                   |   9 +-
>  lib/Kconfig                     |  17 +--
>  lib/fwu_updates/Kconfig         |   9 +-
>  net/Kconfig                     |   4 +-
>  test/Kconfig                    |  12 +-
>  17 files changed, 220 insertions(+), 183 deletions(-)
>  rename {common =3D> boot}/fdt_simplefb.c (100%)
>  rename {common =3D> boot}/fdt_support.c (100%)
>  rename {common =3D> drivers/video}/bmp.c (100%)

Please run a world build before/after and check for both size changes
and Kconfig unmet dependency issues (which CI does not catch).  Based on
at least the BMP patch I suspect there are problems and unintended
behavior changes.

--=20
Tom

--OC7oYSvjcp7rxD9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwn8kACgkQFHw5/5Y0
tyz01gwAm4ICDgXL1jgLxYgPyeazKB7QN9T9YfkdKh1FRH/1w0k0q3bId1/3xzUu
xbyjCwgpujISVfZNnbJKT9DPiE15upR8GNhSr0t3NOLoT85pPqxYVZ8x+27YgVBs
HuReWzzsqNQceA16r9r1j9ilqldXMoCBkh8L/TtSBs4WHZ1H5nbdKDn8kp5+MVWa
ac3IiGkEw7mQtfACaDbrZUwN1urCZwRrY8QjM/uBZ9oD3ezPzr9++C4S7510oajU
cATuGFkxEU4NpYd6LLYd6mHOxMhHqKRAzarYzbytiqVYC9rwsf3EofNOH/VIsIy7
xP1kqNRaBtctP93DSBaIGfuKka6xgw8g/Q7AH3vYnnIYGl1h/ZMlVymPhAV25PmG
RIscioF0ACZ9Ic5qmSaMp4uFM0prdpcB1Ok0HAW5TpaD+d1KeWvyLO6TK+S42kVW
+astgzOInkOBEZ+vn60ML+7piKH8WZOBl1927Q0qsY+4UDm/7AYADnaxjBhakKwm
aB/MTD8f
=q/ZU
-----END PGP SIGNATURE-----

--OC7oYSvjcp7rxD9I--
