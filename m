Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A6AC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 20:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6048210A;
	Mon,  5 May 2025 22:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YSFlvvyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26334820EB; Mon,  5 May 2025 22:07:58 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67EB8210A
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 22:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2c2ada8264aso4030812fac.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746475674; x=1747080474; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1tCcuyD5oUtVRbP5wOIs51M049uqd8PFzGjDTGlcJwI=;
 b=YSFlvvyTRjKAdT0xUjr3dVoqFG/JcHd5FXue4flnB2OiAxG4cL0aIL6C/zJPSoYoKm
 dE/gaXAY2Siys2ciW4VwNw9SBUoDs65kH6UbH6vxxzDIvO+BqGFwQ3FDKVEDr9S3Wwfa
 WPlMmChJvMqfJQwGi4YwPZk1Qc+QFjFWwyFh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746475674; x=1747080474;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tCcuyD5oUtVRbP5wOIs51M049uqd8PFzGjDTGlcJwI=;
 b=rWwEXBM/n1fHmOp5MjsyawQ6woXhTMXw5RxQE7ZFLtEaNdLHuBYRg3H5DNel+BqQ9J
 8PfAMTShuD5X4cRAPlDnWq+uJTgP8/OcnW9kojkdYmzeLygkBUApL7vZEhJ6JpuJIeKY
 wCi5Fr3indyjF8A0+Mn+4bB66PcFXTLtWFK7lNx5Id/MkBXO0hbj3E0XjQ2tWITPAqiz
 5j8PKL3xm4Fcp5KgLq+u+whhHHo8e/TOYfIYpmkaVy7Te1LwU3z545TRHElAyXFjK39X
 YRq1OmGNSX/oVVN3lD+brY/ayqT8fQBXF4eNU4yvLZMNMI+hZus8Otv4ZonFOZd9Pans
 P0PA==
X-Gm-Message-State: AOJu0Yz51y7qql9QZxMH9yq1uZmut5kBg8Y/w6jQd/miHTAIES2HWY4B
 MbZGTknESyHNaJwOqYXibUB8sbw2Nq/egQYpmc+pHtnreKmhkABtge+hqNKurBsVge+RlE+T7RP
 KN+A=
X-Gm-Gg: ASbGnct4DRK1ojTBjz5hjdEKOuhDWRTcPQ7RTP4CUNpSFq1aGgyC6mRKCbc3iuNfIIO
 ItxefagfBbm34ZqoyY60kwN6ZDxLyAM4HqSBw5uTm1kFxlmlwonjnEhck+8XdH2XFzCmFVh8GUi
 vH49SBed83vWB+bZ6CwnyXP7cil8nQ39uhq2QzQdWHXZ6Cq5PqwCLmMATecuT0337Lq8foElBlx
 c1hPH3jkYYIbTMYkD19QuJfmC7lwIhRWTFMiyTf2GPnoQttKC9oz1uiaa1NNXheu9izOT61aMzg
 l+Ef4isQeSJ1q5dycTH/tlZpMPSwg774OxiREznsJBRiMsRLZ+jtX/ne8kgZGPCK9TEwL7yjZt3
 OIw==
X-Google-Smtp-Source: AGHT+IFBV7L8oiHcGFDQK3SWswSPaVTaSxrLhckt0NzjzJRv2lQCpymScCm9u8nMJyTGZ1TAD+VaCg==
X-Received: by 2002:a05:6871:1c5:b0:2c2:561c:47e3 with SMTP id
 586e51a60fabf-2dae835f3d4mr4008680fac.21.1746475674599; 
 Mon, 05 May 2025 13:07:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0e59e30sm2211748fac.3.2025.05.05.13.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:07:54 -0700 (PDT)
Date: Mon, 5 May 2025 14:07:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Johannes Krottmayer <johannes@krotti42.com>
Cc: u-boot@lists.denx.de
Subject: Re: ARM - Linking issue with binutils 2.44 (dangerous relocation:
 unsupported relocation)
Message-ID: <20250505200752.GL5430@bill-the-cat>
References: <640da044-55d0-4491-afea-3e9d9dc0179e@krotti42.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pDUt71D98b0QcsLi"
Content-Disposition: inline
In-Reply-To: <640da044-55d0-4491-afea-3e9d9dc0179e@krotti42.com>
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


--pDUt71D98b0QcsLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2025 at 03:12:07PM +0000, Johannes Krottmayer wrote:
> Hello U-Boot list members!
>=20
> There exist an issue with the newly GNU binutils version 2.44 when
> trying to build U-Boot at link time.
>=20
> Error output:
> $ make stm32h743-eval_defconfig
> $ make
> [...]
>    LD      u-boot
> arm-none-eabi-ld.bfd: warning: -z norelro ignored
> arm-none-eabi-ld.bfd: arch/arm/cpu/armv7m/start.o(c_runtime_cpu_setup):=
=20
> Unknown destination type (ARM/Thumb) in arch/arm/lib/crt0.o
> arch/arm/lib/crt0.o: in function `_main':
> /home/jk/Projects/U-Boot/src/arch/arm/lib/crt0.S:170:(.text+0x44):=20
> dangerous relocation: unsupported relocation
> make[1]: *** [/home/jk/Projects/U-Boot/src/Makefile:1824: u-boot] Error 1
> make[1]: Leaving directory '/home/jk/Projects/U-Boot/build'
> make: *** [Makefile:177: sub-make] Error 2
> $
>=20
> I have tried to fixed it with success. Simply added the assembler
> directive ".type c_runtime_cpu_setup, %function" after
> ".globl c_runtime_cpu_setup". under the path:
>=20
> arch/arm/cpu/armv7m/start.S
>=20
> The binutils patch with cause this building error is explained
> at least in the following commit in the binutils git repo:
> 31ed3a9d691493486f6e32357d89a55229dbdc0a
>=20
> Extract from the log:
>=20
> "This patch emits an error instead, and warns in some other
> cases, to encourage users to add the missing  '.type foo,%function'=20
> directive."
>=20
> But I don't know if this only exist on ARMv7-M.

Thanks for the report. Would you mind submitting a patch to at least fix
that case? It'll help in the future with other reports.

--=20
Tom

--pDUt71D98b0QcsLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZGo4ACgkQFHw5/5Y0
tyzvngwAkk8lHDYkDAIZiaztrFteiZpI9I8D01kLnmayjMaPMrjn6MsHYgfqEKWH
0OA7Z0K083ntN0jasdgjd0osI9NmFfTquEWmjclFIrDppw2PZNVzIa9H+duuqqBo
BG58es1uTFk5CWrCB8couzqvm0+eX7CCwsSn77qrDJJuWFhmtp72IHGQsQElTrJ1
rZqWjU5ocPZMVTiLrhPaxKylQGw+zwByPB5DeNukbeV8AGICLhVS8UEnMRj2HVFY
Kxo+JobTNq/QkFaHVg7fxjqDGmGsqUJxgQjvNr1sF62riA/TYbRvCnhGkxG52OGi
uy4intTAHPtXVCiks2Lyni/AQeYBrSFhSB3ywUnti4TxhqEwgRMlxh2vYIswWXqY
BR45kiM++lLaJtd72HyxJY1FljpMO6jj2Ii0r1a/AVfQ7LN6ipCMnmK5dJWskUB6
Jl+vRzuI4G07mz/B+vk4ICh0+e0MZwkVxjjK9et7iUOxeFcIAVJyORK+QGcEs56Q
PXy354wh
=5foI
-----END PGP SIGNATURE-----

--pDUt71D98b0QcsLi--
