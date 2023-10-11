Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE682CD6E76
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 14:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904FA8071F;
	Wed, 11 Oct 2023 16:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qedLq/Vd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269CB80422; Wed, 11 Oct 2023 16:20:23 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD0086D12
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 16:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7af52ee31so32357267b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697034010; x=1697638810; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P+9W2yM2I+1Plrmusm6YQgkIl5zcJjdLDtzFvTO3NM4=;
 b=qedLq/VdIPDo2ZJDWKSGfxARYo2sfWlQ+t4JfVlEGjTb3mP4bG1OMSlEJbQ26INHCa
 x5OOTvakSYjtK6woAbjbUZJrwpPjUmbvQh4eZq7hhY3fEKJDueU4Ildr4ZkiNtvCHvnP
 RWWQ+g7Co+F5X7dRB48gfbOIuhDTvx67vgJOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034010; x=1697638810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+9W2yM2I+1Plrmusm6YQgkIl5zcJjdLDtzFvTO3NM4=;
 b=r74iAJEeocWcrmxuej93xlK5aOKYlCaLdMCf8NITrEPya7xBJo4j7LTjNg/vrXC7Un
 /RctxNQlOtTE5CjnqF8hBqe6YxHr0vdDYP80kXgkDE6vI6QB2iUb7re2SJMz6ogaPS+C
 CZgjZkRkWhwSuItsAdloGcbF6rzNxO7Kh2oPtlIDAt4QKXldBCz5kRLAeS8FnhmIYZk/
 wxe3sKeKVW6aaMOw8qg4i1ECbKegKtqtnx+8u8qMXoRB0cccWiTQgWwQkTwPY0wNvdpv
 LMOtsd+KmD5ak5P8LrulW+K+xpksr/mtHLqftQXY41ynrTM6kkI50ai5CjQ2sMZlxVPw
 MRfg==
X-Gm-Message-State: AOJu0Yz/UziI8Aisk5lFVChJGfmKwoUuoXcihtLwc0ZKluNDgGvMehKJ
 sz1nRp2Upr/Hs96Ea4uwaon1wA==
X-Google-Smtp-Source: AGHT+IE3eDshXCUoZfzplCBLStSdflwpOHN5v3kr2j4Ss8E/omofR+DhxZaI0dOUl11uiIs+rn9xdQ==
X-Received: by 2002:a81:8647:0:b0:595:89b0:6b56 with SMTP id
 w68-20020a818647000000b0059589b06b56mr23765054ywf.28.1697034010554; 
 Wed, 11 Oct 2023 07:20:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a369-3392-aca4-1f00.res6.spectrum.com.
 [2603:6081:7b00:6400:a369:3392:aca4:1f00])
 by smtp.gmail.com with ESMTPSA id
 q62-20020a0dce41000000b0058427045833sm5210552ywd.133.2023.10.11.07.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:20:10 -0700 (PDT)
Date: Wed, 11 Oct 2023 10:20:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/5] configs: npcm: support more uart baud rate
Message-ID: <20231011142008.GD3119521@bill-the-cat>
References: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
 <20231011084533.2325296-3-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PkVMXIYay+CB+vT9"
Content-Disposition: inline
In-Reply-To: <20231011084533.2325296-3-JJLIU0@nuvoton.com>
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


--PkVMXIYay+CB+vT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 04:45:30PM +0800, Jim Liu wrote:
> add uart baud rate table to arbel(npcm8xx) and poleg(npcm7xx)
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>  include/configs/arbel.h | 5 ++++-
>  include/configs/poleg.h | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/configs/arbel.h b/include/configs/arbel.h
> index 891257bc93..c45b2ac137 100644
> --- a/include/configs/arbel.h
> +++ b/include/configs/arbel.h
> @@ -7,10 +7,13 @@
>  #define __CONFIG_ARBEL_H
> =20
>  #define CFG_SYS_SDRAM_BASE		0x0
> -#define CFG_SYS_BOOTMAPSZ		(30 << 20)
> +#define CFG_SYS_BOOTMAPSZ		(128 << 20)
>  #define CFG_SYS_BOOTM_LEN		(20 << 20)
>  #define CFG_SYS_INIT_RAM_ADDR	CFG_SYS_SDRAM_BASE
>  #define CFG_SYS_INIT_RAM_SIZE	0x8000
> +#define CONFIG_SYS_BAUDRATE_TABLE	{ 9600, 14400, 19200, 38400, 57600, 11=
5200, 230400, \
> +					  380400, 460800, 921600 }
> +
> =20
>  /* Default environemnt variables */
>  #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=3D80400000\0"   \
> diff --git a/include/configs/poleg.h b/include/configs/poleg.h
> index 1e96e838be..fd0e9a7362 100644
> --- a/include/configs/poleg.h
> +++ b/include/configs/poleg.h
> @@ -13,6 +13,8 @@
>  #define CFG_SYS_BOOTMAPSZ            (0x30 << 20)
>  #define CFG_SYS_SDRAM_BASE           0x0
> =20
> +#define CONFIG_SYS_BAUDRATE_TABLE	{ 57600, 115200, 230400, 460800 }
> +
>  /* Default environemnt variables */
>  #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=3D80200000\0"   \
>  		"stdin=3Dserial\0"   \

This is now CFG_SYS_BAUDRATE_TABLE, do you really need something other
than the default as well?

--=20
Tom

--PkVMXIYay+CB+vT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUmrw4ACgkQFHw5/5Y0
tyz0ygv/RvawwSHNou3cIp5fJJnavkZ+wm3GWb/uUAyiWiEib9uAMbv8NPbjWg67
A1KsUsijWcVuXIcfsC1U9AwwAs51HlsSRpNmSfgez7F4vZjKaGxCf8IaEvgEbVi5
w09d4cEFQRzJqc9jtHalRgm7VfhZXY0xCCAo4yK34Bxk+wiMliu6nBAPoK3rMyDC
dOHh1m3SMi7qNN4A438WxXfDMKFSrHFjQsRUwnIelw5NUasl66uS2tP5nNhuxpbM
jK9EV/Wuqag/TD9m4r0wV19RZlJwLF6z3wBxCCRbeXRFzmoqAZzj1XPHA6Js8cru
Aeq0wde0ULxvpcq9EI+td9WYkN+6UbjwgEWDQbsZmb/Es+huDeKEVySMQHEmNNkr
macAoAYLg6sx6nFTNbm4rhKJSde4pVns4AVLXqMBvmiu3VtBX1SD3rgnM0JPvRK/
1fDRpbLp42Ifk82iPdRHj6eaOfPfmYFxxi0YSrs5vwDGJ46LC2eu4RAX0OkgTmUM
cp1wxcCU
=7mn0
-----END PGP SIGNATURE-----

--PkVMXIYay+CB+vT9--
