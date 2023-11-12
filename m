Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441BDC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 18:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E60B86D3F;
	Sun, 12 Nov 2023 19:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UkcEpIp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687E886DCE; Sun, 12 Nov 2023 19:04:03 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F3CF86D33
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b4145e887bso2154807b6e.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 10:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699812240; x=1700417040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hiW+udNuiTcbK6W4FaL1Wng3K59antIuzHFLJrYGw2w=;
 b=UkcEpIp43J4ILlfeMcr1LYQU8geB4buf4F8u8yzp0Y1DrLQ/XdFVR+0CwLDd0DkAX5
 u1Uis7PPD9o3DzCBGEM5WYbXj3QFJHibPy5uxGILF99HaaW9nXAFAdNYIbEF4y8In3ZW
 dhNjoMSU2yTVG0sDRoeZYTjxfZ0zdW45d0g9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699812240; x=1700417040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hiW+udNuiTcbK6W4FaL1Wng3K59antIuzHFLJrYGw2w=;
 b=WwbCgmMdz6XvVQuvslbIGm6xf2NrTj7k7zppTBpIdkJg9CV0aLfndJfm4hfzc2eZUA
 D9oWHoQnUQaKhulUYjR4grE38e2wI5JL+osM+CNAOkMwMdxcV07xyayoNz/4lbpOdoeQ
 5JRkZJQMZzh+OvLyFBpd7r/rhFgy5A3QqwMiJX9CFrij5QT1zmv+L/jIGQzggjZzRgTd
 lb1grMWoNbj115JAUEoNi8PUOpAeh+rCcXPOtj1Zgf+XP9i9LQArqcbXbvQSZo7REmTb
 frCQZGhKlS8oTaeZMPIA8JlNg5bFxvpNkOQtCkWNrwTL8a4ugsduOpDStSKVWOrt+0J1
 3yJw==
X-Gm-Message-State: AOJu0YywRbUu0/lA/dZLkGz7vPw3ozSGciPnd8SCEU19CNyFckCQ61Z2
 sWXSAz0wb7JrnvnMF8IOoHLLP+EV9spI8CqvNm+DXg==
X-Google-Smtp-Source: AGHT+IFDy6yWlMJvmsFJhuzyqcu8DefH4Xhs+ahkuZCLmTF3d3zz/hsQHgkIW2m5XlLyPSvdIzEC/Q==
X-Received: by 2002:a05:6808:1522:b0:3a9:cfb5:4641 with SMTP id
 u34-20020a056808152200b003a9cfb54641mr7123547oiw.48.1699812239838; 
 Sun, 12 Nov 2023 10:03:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8be2-1560-728c-e0db.res6.spectrum.com.
 [2603:6081:7b00:6400:8be2:1560:728c:e0db])
 by smtp.gmail.com with ESMTPSA id
 ov5-20020a05620a628500b00774133fb9a3sm1286910qkn.114.2023.11.12.10.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 10:03:59 -0800 (PST)
Date: Sun, 12 Nov 2023 13:03:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 4/4] efi: Avoid using dm_scan_other()
Message-ID: <20231112180357.GD6601@bill-the-cat>
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M0MP/DQbEJ8mBEHL"
Content-Disposition: inline
In-Reply-To: <20231112155808.135585-5-sjg@chromium.org>
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


--M0MP/DQbEJ8mBEHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 08:58:05AM -0700, Simon Glass wrote:
> This function is defined by bootstd so using it precludes using that
> feature. Use the board_early_init_r() feature instead.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  configs/efi-x86_app64_defconfig | 1 +
>  lib/efi/efi_app.c               | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defc=
onfig
> index d6b6c3d82995..e6a62b30dd09 100644
> --- a/configs/efi-x86_app64_defconfig
> +++ b/configs/efi-x86_app64_defconfig
> @@ -17,6 +17,7 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01=
000000"
>  CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> +CONFIG_BOARD_EARLY_INIT_R=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_PBSIZE=3D532
>  CONFIG_CMD_BOOTZ=3Dy
> diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
> index c5eb816655ea..1bced775a4d0 100644
> --- a/lib/efi/efi_app.c
> +++ b/lib/efi/efi_app.c
> @@ -302,15 +302,14 @@ static int setup_block(void)
>  }
> =20
>  /**
> - * dm_scan_other() - Scan for UEFI devices that should be available to U=
-Boot
> + * board_early_init_r() - Scan for UEFI devices that should be available
>   *
>   * This sets up block devices within U-Boot for those found in UEFI. Wit=
h this,
>   * U-Boot can access those devices
>   *
> - * @pre_reloc_only: true to only bind pre-relocation devices (ignored)
>   * Returns: 0 on success, -ve on error
>   */
> -int dm_scan_other(bool pre_reloc_only)
> +int board_early_init_r(void)
>  {
>  	if (gd->flags & GD_FLG_RELOC) {
>  		int ret;

Should this file really be board/efi/efi-x86_app/something.c ? We don't
define this function outside of the board directory today. Or should we
just move the function as the rest of the code is used in other EFI
applications we build (or no, the hello world one is too simple to need
this) ? If all of that sounds too wrong-direction, can we use event
lists or something?

--=20
Tom

--M0MP/DQbEJ8mBEHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVRE4kACgkQFHw5/5Y0
tyxRAwv8DC8PBtsDv7+A0c2nHqtndrmVe4YV4CJk+XYmywYduoX9T4whh0JrZwn9
HbzzXeNbgcro3P3K141OXDrw8HagvJSGDOzlJdsvlnbVTXA2F0RmaKT9wINozv48
pQ5fiW6uEiQhiBNaL1yQPv+81/3uS+mup/OxNIAeTkyrDAMB+9gx5iFwypbRUma+
kWcLP9ykknTU7HQDnsosVIWey6GP6k/Dhbu3oB+yuj1xNvB3ayehg8yhSs13ywMj
bmnAiUzyQWmbfDTwOtpSyonRZxyFbO9y65fHXU2k1yTWBe0GM7jPmCDGIuMp5QIY
nhl7bwQwHitdWQP6HY1LJAOZ7p8/pb5X9GgxDJ2Sk8ZNuCtwPYc9SVq3kr20eu8n
XZgMox6EwacW8ZJ2lyclsp5fv3fhapBRs9PEDEtPYTh1H7V8fl71k7ia7kRZ4gcH
C0r2WDAEA1ZQRpZqtakhjQmLNJoPXBUjFa9Imk4V7NsM8f7YBXxAqnJw5CHQ1XVL
Gnt1XiYg
=Fnwg
-----END PGP SIGNATURE-----

--M0MP/DQbEJ8mBEHL--
