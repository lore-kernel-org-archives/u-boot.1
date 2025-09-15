Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE348CAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 14:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FEA82AE1;
	Mon, 15 Sep 2025 16:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tB3Jkiwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2EA80B9B; Mon, 15 Sep 2025 16:32:33 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849D580B9B
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 16:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-32bd4f1b671so3199518fac.0
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757946750; x=1758551550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KRTPT2pT5CaZEajE199SbKZR+R+O2rFspGfXwxw5FMM=;
 b=tB3JkiwgDdJIaB5kn7m/hukHJ/OxAlsGhVokj8TEILTF5z9XH0FUqqvyGmhvZOt7co
 j7TCUddvdBIok4XI4bC1z1ldHjcjp+lgzd9KHBHsrJy6c8Soy2GGwz227AZPCmrD7qpM
 VucxnLFn00YoQTszR57LHTXUFOWg8fwEfb6aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757946750; x=1758551550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRTPT2pT5CaZEajE199SbKZR+R+O2rFspGfXwxw5FMM=;
 b=tsHpZ3/5t6sIjOAFb9ZDW/4eCPQFWA34640LMDV68GMPD55L0VQteq/JdcKp1EGede
 iTRvgUkMuoR2lok61ay8oZOp/SK0lw6mkGMYb96xi6P1qpuoYfPZlIV1ZElC5KpeQfaq
 CNys8cQqeQyW6R40LTFWBD9OHHn3KreuxG4beLicXeJX5VIgySBRXL/DbYv/eVZGKUv7
 oIikQWkSxcCjIwn/OhuJK4/IFf6m3K1m4SkuAQtk08Phh6h3/lwz8mcF7daLUy9mC08T
 fBAMrVGWIMA4NEUResoL5lobGzEa0FXLKCjS3fadaq1pF0MtmahFhU+gddnDg/w9UcSA
 aOyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV69azI9JH2TPAUM9XgM3U8CfQIyLL1bho6QAMW6yx5KltOeBWGBodqBL+ERKQBjKwsrpP/858=@lists.denx.de
X-Gm-Message-State: AOJu0YzGm92LL51knSw6dvGyR/9ttdWq6Q2wq133VdFiDxyqacvZD5+X
 noxCh1Yj09gXkJDqE73ynKnazNNkFMY5i7LZiJdolj8mmh6C24UqbcjaX4U4a0iF0AG89iUopOs
 69yrqClE=
X-Gm-Gg: ASbGncsdkpiCl9bhuE3zObN6ZU5IfLsCYpBidWRLlzKpOdT3Y/eTqGxoVv5/lDQCviA
 0UNws1XeadZUgmdj69hCWM4beViRZjKtNY7R76wlnvU1PK1riv3r79CErBiakTX+ostA5s7+8ze
 6I8fGwbo1THTnZPtwFq8qBxO17oQAtiU6IiaeAzxmgAaaKBEYTLL3p5/NvWnDL3dgUrvTb6xi8J
 LC6/ciUSkW2EREiv2cbvgV1FWpyzydfppOoKMFKQHPmikVYqszQfeSepHUJ7IZEORUqjFVLXWFD
 HlN7n4C51NsX4bSB82gHj2faS5vgDNO6yFWDsjldqbwX+IsuTAmCJhc31rXEzRWdSmfyMSqgRjv
 wifONl9XtoHrKMRkx9po+qtlsErysEdJ1fZdve8A7nKx9aPNuTQhUPT35CtgotHWnPrw=
X-Google-Smtp-Source: AGHT+IGtDtz5riiKAxKpJXATAyeEgtVPvvLW1vRlvSItGI8iQH8avm4qvpbQXHVWVxgs4HvTrdZp4A==
X-Received: by 2002:a05:6870:f697:b0:331:60a1:d102 with SMTP id
 586e51a60fabf-33160a1edc6mr3182787fac.16.1757946750199; 
 Mon, 15 Sep 2025 07:32:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d358c74d0sm3522471fac.26.2025.09.15.07.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 07:32:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:32:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
Subject: Re: [PATCH] riscv: qemu: Remove fdt_high default
Message-ID: <20250915143227.GJ124814@bill-the-cat>
References: <20250915-qemu-riscv-remove-fdt-high-v1-1-661178447396@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OmhzDTNPRl45NUzD"
Content-Disposition: inline
In-Reply-To: <20250915-qemu-riscv-remove-fdt-high-v1-1-661178447396@iscas.ac.cn>
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


--OmhzDTNPRl45NUzD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 07:45:49AM +0800, Vivian Wang wrote:

> Setting fdt_high to all ones is discouraged and does not appear to be
> useful for RISC-V QEMU. Moreover, it causes a boot failure when the FDT
> generated internally by QEMU is used while booting. Remove it to allow
> U-Boot to pick a suitable address and relocate the FDT.
>=20
> Closes: https://lore.kernel.org/u-boot/8397369a-9b0b-4798-9c30-3a81165657=
d6@iscas.ac.cn
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

I'm very glad to see this finally and would like to see the rest of the
RISC-V platforms follow and do the same now.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--OmhzDTNPRl45NUzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMgjdwAKCRAr4qD1Cr/k
CiXSAQDmg7yybBDYoTLQGZKS+2yVxkY4omU7Nr9fVef7+wlWBgD/ZSaPruGt5HA4
KViUb6WQgPlj4UkDmEFHnmPCKNmAogk=
=AwKb
-----END PGP SIGNATURE-----

--OmhzDTNPRl45NUzD--
