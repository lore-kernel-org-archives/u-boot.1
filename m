Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DE7C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 19:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349B086D62;
	Sun, 12 Nov 2023 20:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MVUT2nTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C99A186D11; Sun, 12 Nov 2023 20:46:48 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE2A86D3C
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 20:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-778a47bc09aso255483985a.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699818405; x=1700423205; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K7R8u2Q6CtmikrP0hWA3hQM//U0+pjJLqydndEGkhv0=;
 b=MVUT2nTtcYxuKx+ffFMGPluov7D+iYYVyvDwKiGfnHxt9PgkRD0tfXpRQajDx7NIHd
 7eo7MYYnKUFLA7Pj35NxBvZbLRbor0byj+Z+8COiJa0M5ahEY060O0/rIHEjddg1lkzw
 e7lk7GFx5aEXCUrdQTK4GXY14QkpYR2gDWYnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699818405; x=1700423205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7R8u2Q6CtmikrP0hWA3hQM//U0+pjJLqydndEGkhv0=;
 b=QSEziide+p3FK4D6n6Tm3gKn2RsHdkuEgJ3e81iMB93Uy8en1NjVqZSx2ge5zEGIhb
 yHhEOpnYm7ZjDbJSGsMnIOqDQMB2TKOb3RCTkSrX1LeaPsd4aBlpIIkApYnw5HPaapB+
 mWnsD9htRdq+U2wCcOKb2SzAiRaQ6MFKSvLb7IkeuMQ8XbO9aFpV763OA2++M5E579wY
 IEaGcCTVijvxc53jBNFXGd8/5s3f8iYPyfDaNiI5ArqiZU83qHg7FpPBKS8UAYGIwWLE
 Sw58eVJJ8T7Yk13OnFqnQt+VxeFQjTI6BJsTRPBpJXFNl/bSy7k2l+pjbran1KV7YOte
 J9Yg==
X-Gm-Message-State: AOJu0Yy2IGVe9QFqkzcJ/DuNQyY6Jt1bv8MuP/A7CNNm3Sgt4IAAdS1f
 L9kFunv/m7se3o9/QonDGP+NGw==
X-Google-Smtp-Source: AGHT+IEhphqZohQY6HIsO/l0T5j5qRB3GyiOefMbFirEAnLItwKG0QMbWyur5mm6x0I9+Ch1AGS2tA==
X-Received: by 2002:a05:620a:171e:b0:777:659d:7fcb with SMTP id
 az30-20020a05620a171e00b00777659d7fcbmr6965971qkb.36.1699818404985; 
 Sun, 12 Nov 2023 11:46:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8be2-1560-728c-e0db.res6.spectrum.com.
 [2603:6081:7b00:6400:8be2:1560:728c:e0db])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a05620a109800b007757f6558b3sm1334827qkk.95.2023.11.12.11.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 11:46:44 -0800 (PST)
Date: Sun, 12 Nov 2023 14:46:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 4/4] efi: Avoid using dm_scan_other()
Message-ID: <20231112194642.GH6601@bill-the-cat>
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-5-sjg@chromium.org>
 <20231112180357.GD6601@bill-the-cat>
 <C8077CF5-6258-4699-9204-BB9B23F391A8@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eANfbVYrroTw8lsI"
Content-Disposition: inline
In-Reply-To: <C8077CF5-6258-4699-9204-BB9B23F391A8@gmx.de>
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


--eANfbVYrroTw8lsI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 08:19:57PM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 12. November 2023 19:03:57 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Sun, Nov 12, 2023 at 08:58:05AM -0700, Simon Glass wrote:
> >> This function is defined by bootstd so using it precludes using that
> >> feature. Use the board_early_init_r() feature instead.
> >>=20
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>=20
> >>  configs/efi-x86_app64_defconfig | 1 +
> >>  lib/efi/efi_app.c               | 5 ++---
> >>  2 files changed, 3 insertions(+), 3 deletions(-)
> >>=20
> >> diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_d=
efconfig
> >> index d6b6c3d82995..e6a62b30dd09 100644
> >> --- a/configs/efi-x86_app64_defconfig
> >> +++ b/configs/efi-x86_app64_defconfig
> >> @@ -17,6 +17,7 @@ CONFIG_USE_BOOTCOMMAND=3Dy
> >>  CONFIG_BOOTCOMMAND=3D"ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot=
 01000000"
> >>  CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
> >>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> >> +CONFIG_BOARD_EARLY_INIT_R=3Dy
> >>  CONFIG_HUSH_PARSER=3Dy
> >>  CONFIG_SYS_PBSIZE=3D532
> >>  CONFIG_CMD_BOOTZ=3Dy
> >> diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
> >> index c5eb816655ea..1bced775a4d0 100644
> >> --- a/lib/efi/efi_app.c
> >> +++ b/lib/efi/efi_app.c
> >> @@ -302,15 +302,14 @@ static int setup_block(void)
> >>  }
> >> =20
> >>  /**
> >> - * dm_scan_other() - Scan for UEFI devices that should be available t=
o U-Boot
> >> + * board_early_init_r() - Scan for UEFI devices that should be availa=
ble
> >>   *
> >>   * This sets up block devices within U-Boot for those found in UEFI. =
With this,
> >>   * U-Boot can access those devices
> >>   *
> >> - * @pre_reloc_only: true to only bind pre-relocation devices (ignored)
> >>   * Returns: 0 on success, -ve on error
> >>   */
> >> -int dm_scan_other(bool pre_reloc_only)
> >> +int board_early_init_r(void)
> >>  {
> >>  	if (gd->flags & GD_FLG_RELOC) {
> >>  		int ret;
> >
> >Should this file really be board/efi/efi-x86_app/something.c ? We don't
>=20
> The EFI app should not be x86 specific.

Yes, I suspect a follow-up would be to do whatever is needed to target a
given architecture with the U-Boot as EFI application board.

--=20
Tom

--eANfbVYrroTw8lsI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVRK58ACgkQFHw5/5Y0
tyzQbwv+LvDhKyjzF1oxNKuDmLsDjPBTEbPcQeSOWjwfQzsRpooF+jrYsyX6stP3
dDsvP4RKthaKx6MdbV5PgUKbqpj9TYV2JPzjHOIA17jqDrcPJ8P15tCiTwCyAsmw
nAZ8fjJx4CEnlJblxmm/KLOjSjp8TAH5XSm/FO9NO54/5/ee50/ROFndRcM89LjM
39WZcMrS9n3Ag63dcz/dTpMRKMq2sIjabtKdiDFADrSMLXmQSSXZSnwmsui9Donm
biltXoU5LLqBcmLsj/RAuiihGSB41xBH9Z7lIMm/mMu+9GQhnfwBdk0lVAYJcImM
6EMovhsFXDAQhPAm4sy9xKqLTuhU/qx3995cI3XU7qHXWEPvL5hXQxxWsYV7JXEW
J4fZalICUbWo+egsEpE3ZJpeDsy3ViWYbDcVacPogmeCe4J5iog15fSwyTWMwLNK
m2+bHhpKgA8XVzei4Ff7mSJcMNzVjY7qvNsWJBcThbnhxnPYyx0e+l6nkwTHclgz
W4y6ynKq
=ZHhh
-----END PGP SIGNATURE-----

--eANfbVYrroTw8lsI--
