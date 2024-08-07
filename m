Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C1DC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E9D88CF6;
	Wed,  7 Aug 2024 19:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gTniXSUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD3588BDB; Wed,  7 Aug 2024 19:52:53 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C169088BCC
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7093f3a1af9so51099a34.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723053170; x=1723657970; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=roSAEvryMn4Ntzp2raP7pt03mRdhZkMPhVwZ8ADOk9s=;
 b=gTniXSUb/eUMtANvX11wX+nfwwTUXT6bDQwdgvVoMKFkxJSvIyipjNJI8ZtKk4kWcG
 xFEWw49eyGMRGP5T9+WFMbLwTBE+a55lUnQxqDsy6nmMJ2BSK1kLUNEzKb7QJXGdJ6TT
 ziCaKoYwDLXnZSG0yZHobFCHGNAc3taEEduxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723053170; x=1723657970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roSAEvryMn4Ntzp2raP7pt03mRdhZkMPhVwZ8ADOk9s=;
 b=fqEr9DbJ+hzKCAWW1KdZUcTUUCs73JeNT2dTAIf5+9eiMDNKtnhTQdO1ZThkuZ7u0d
 hjF0bLA8oppAPIgYTGwUGr3IM8T/jrxMVgHTWgNfd60bGu2aAtzWeXfN2gbQwK7k1Q8L
 jgrcNSfCyQrJR2cugY0t4dbPRImHay2d1lFxl5txupgmwRJhtYOYQWB1YzJxWVMWS8Ow
 aGorPyC4Jy4KD/7gwYiLCke6ClJJobFbt7nKkkx2DQ0MmLg/wfjm8gmJ9YbaQBdsjorY
 c4mTVxwTHEGHboLawHdlM4hc5oxMuTQ8K3ydXpCYldDD4zE6+YdxXh1cKI7bIBX5gaW+
 CkWA==
X-Gm-Message-State: AOJu0Yzsovbnd1EbRukNydL+yexW+3EQKSzLU8zjzwf2DDR+l66VEX3T
 N4W8XMCQP5gN2/CBoi8i1Wf1BazBOALn6lgIzqcZmn2lKQto1hU6jwMWvrGsHpw=
X-Google-Smtp-Source: AGHT+IGJmbpWpSihsgPWhJ8mgkB2xmvddgr0T9IrWACCxza5v5MMSD3oYBDsKZYjANhqFxb9vQwEZg==
X-Received: by 2002:a05:6830:6011:b0:709:5b1e:f412 with SMTP id
 46e09a7af769-709b320cf9amr26215850a34.8.1723053170503; 
 Wed, 07 Aug 2024 10:52:50 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31eaf2efsm4860747a34.28.2024.08.07.10.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:52:50 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:52:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v8 22/23] test/py: add HTTP (wget) test for the EFI loader
Message-ID: <20240807175247.GG1626301@bill-the-cat>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <9b055b18f84755d775bf0cf4064e66801608839c.1723050310.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SJtkdztm8zx5gk3k"
Content-Disposition: inline
In-Reply-To: <9b055b18f84755d775bf0cf4064e66801608839c.1723050310.git.jerome.forissier@linaro.org>
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


--SJtkdztm8zx5gk3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 07:12:06PM +0200, Jerome Forissier wrote:

> Add a test to test_efi_loader.py similar to the TFTP test but for HTTP
> with the wget command.
>=20
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
[snip]
> +@pytest.mark.buildconfigspec('of_control')
> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +def test_efi_helloworld_net_tftp(u_boot_console):

This should also depend on cmd_tftpboot (existing bug).

> +    """Run the helloworld.efi binary via TFTP.
> +
> +    The helloworld.efi file is downloaded from the TFTP server and is ex=
ecuted
> +    using the fallback device tree at $fdtcontroladdr.
> +    """
> +
> +    do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
> +
> +@pytest.mark.buildconfigspec('of_control')
> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +def test_efi_helloworld_net_http(u_boot_console):

Then this needs to depend on cmd_wget as well. Kicking my local build
scripts to add wget and moving on...

--=20
Tom

--SJtkdztm8zx5gk3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaztGwACgkQFHw5/5Y0
tyxCbQv+K0fcyOHQFiqMRiAevVq0gN8/luATUP5pwLcujhYbdgzLURsVgaig7DG+
eNwfa/3IHbSuh53FX2e0E9VAdnsEay6diQmKF88IgMZ3jdNoEMwj7S/gvB7wAaaE
0KFbeLdvM3eOBUGEfB2SH1VgHf6enhdIn6g11FaS4Dc7J1kmVvovoa28ppM4mXuz
sjimyd9XW0ce6OZBfH+9qjhUzrsfmsoFDcfSmZa5xbaTDzSlc7Vw1ENEQSNBzsQs
Zn8APvEsWykxZkTvpc5sF9fUsKg6kGpSk4cLURARdlGfSCTZzT9dkLD641KccPMb
VZhRfPDfUKcpnIkiJv0ZSJjemefbAIQ03mQF7bXOzR0XgYAr4fuhcT/KK3mcS7v/
kJ7ihG+M/g/gq321KauKnGpf0bCXDVfV64ESiXBmVEtc10tedKtSrZhwewOauoa/
dpM20M1thOaRAIB1FCtf3TpZyKbqK05m5IBZ6hnjK+4d31whsmGBQKMvn2jOhM43
bUg0shnD
=Bvha
-----END PGP SIGNATURE-----

--SJtkdztm8zx5gk3k--
