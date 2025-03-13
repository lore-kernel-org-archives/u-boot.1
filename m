Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCA8C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 20:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEEC180FF7;
	Thu, 13 Mar 2025 21:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n8ZfC9Qk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEAB810E8; Thu, 13 Mar 2025 21:24:33 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF9F80756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 21:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7be8f28172dso90986285a.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741897470; x=1742502270; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UhTdiuJqryYYPdK5Fo4ljRpW8o2TAyDioH0rKtG3eEU=;
 b=n8ZfC9QkI8k69Bpt6z5hVS6EmdHuKTI6Xzt5z0cFdykU9u81P1X65xuC+1+pHxYgrG
 sJ62wxYM27X4YHR86QgGe7i821p+Cw8lYTPb50dMAjcuU0nKeCOud7QunpnJtpriSSqv
 3/E7f3bdx4JAwFTH7ufNgN4r3xeVpRSPE9csI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741897470; x=1742502270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhTdiuJqryYYPdK5Fo4ljRpW8o2TAyDioH0rKtG3eEU=;
 b=CDqxllbX4QZklm0j11L35k2RfQxIuH7WVrc0g1krnh7KHLuNEW0RQkhw6cqy/sk2ia
 VgYca5gxGPEcWwaVNVqDaUhy5klOgc7GYA+T7eT6ux3RXKvF4QJcdVW5bj1R+jsU4gkw
 wPGVZ44bppzTRCCP1Vgf6uAo+XmoTrJqlw5oM3jEJirMrbOHBdxaX/+VXZts/uWweeHe
 IRbbDnL/U4Nl5LzLp4Svu/NmYnLFpV0RexT6C8sgQNvciGGpBE/npbpTyVmd08moICEW
 UL9SQ1qSf1Mc+FkIaP2u1W5kNLwdve3RItBaX6dHizzR322xFPo3ayJ6iUZPgd9GaHfg
 KAjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh1W7F9ioOpsXDuLBduST6ySu+ZGIy9k5oM1S29s86Z8BGyqG9rf3Yoib2jTtJmdqT0h82LIo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8w8WHXasnuIb5E8M+uc8x2kCx04lz9VDdaqZuJoCuY0ASpK36
 o0LYqFQ5O8l0VnM6LuBCzbU1R2Ag8aevYrRGoVcYopFqYKSSkc0PWlZBnJvmEis=
X-Gm-Gg: ASbGnctIMrvZ/YNYz7MwkSvyI8vfOyraL7Ll1GrkAjvDMsVbGp9+8eJfw6yCunhuixG
 TsgBlksIjHR+xLqZQiA0iF6wm+wlIDFbL3blfns2I3BWib/O+Lfh9POI/62nbuPaL7SgdunDdfT
 lpLm3oyE72rxuDeYl2A/TOE6aDakouJ+UJReA39j+oaDr4gyVR5O+bt8eCqN10EGECqZLv53Vki
 BhIsQ+DZAWeeV6mURWeVDnfR5RBz+rNmQlpLZsRms3OU8h8bxrgDlhlMLXtYtMtRIG0uqmLCkhl
 cj/sXNi0TlerA+oD0h+4JgVizeooYSRTeC8YNOztqRBEIA==
X-Google-Smtp-Source: AGHT+IEfQtLa5yhPeVltoKxK34zVQ7wu4BFn+6ZAghRjKfEGW9NgmdLcTkrBiYL+SATjPs4werbpAA==
X-Received: by 2002:a05:620a:6406:b0:7c5:4de9:533 with SMTP id
 af79cd13be357-7c579eb43b1mr161941185a.5.1741897469951; 
 Thu, 13 Mar 2025 13:24:29 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d6fb39sm138165885a.85.2025.03.13.13.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 13:24:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 14:24:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: n-francis@ti.com, s-k6@ti.com, kamlesh@ti.com, a-shenai@ti.com,
 u-boot@lists.denx.de, s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v2] configs: am65x_evm_r5_usbdfu_defconfig: Fix USB DFU
 boot
Message-ID: <20250313202425.GJ2640854@bill-the-cat>
References: <20250227115456.283663-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IC3qvXBnpT3Vahnt"
Content-Disposition: inline
In-Reply-To: <20250227115456.283663-1-h-salunke@ti.com>
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


--IC3qvXBnpT3Vahnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 05:24:56PM +0530, Hrushikesh Salunke wrote:

> Increase the size of malloc region allocated before relocation, as
> current size is insufficient for DFU boot causing it to overflow and
> corrupt the stack.
>=20
> Fixed regulator configs are required by vtt_supply which is used by
> "am654_ddrss" driver. Without it during DFU boot DDRSS initialization
> is failing. These configs are enabled in "am65x_evm_r5_defconfig" but
> are missing from "am65x_evm_r5_usbdfu_defconfig". Fix that by updating
> "am65x_evm_r5_usbdfu_defconfig" to include "am65x_evm_r5_defconfig".
>=20
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
> This patch is based on following commit in master branch
> 57bbc4de75f Merge tag 'qcom-fixes-2025.04-rc4' of https://source.denx.de/=
u-boot/custodians/u-boot-snapdragon
>=20
> Changes since v1
> Instead of directly adding required configs to "am65x_evm_r5_usbdfu_defco=
nfig",
> updated it to include "am65x_evm_r5_defconfig".
>=20
>  configs/am65x_evm_r5_usbdfu_defconfig | 125 +++++++-------------------
>  1 file changed, 34 insertions(+), 91 deletions(-)

Please rebase on top of current next, thanks.

--=20
Tom

--IC3qvXBnpT3Vahnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTPvIACgkQFHw5/5Y0
tywh5wwAudEHPENSbLn+/4AH2m0q6QrnUpXS9Y/4vxMrcCFX80fLBDXYDykzNl5r
g6jTDPNEA4wnhkv7aM4mQVn73ugm+0VoOHalY/l4TjANEAdPxoKJCl+FwyBGUOXC
YiumI4KVDf0u1RTz17cRm3l9xZL1/g4OBQVVfWQAs7ijryscwIGpovaXI1LRHa97
UdJ88Frf3ts+tUzw67X6QIXNW0BCHLr1JM1LgJHPqpacwtaJdGM6w0ELSOEFJ4eZ
+xFBbkJYom7mCIHj8x6wofjSpxu6xvaehd77FVPKXh/GBS71U77OIzIdVhLpCohU
/efqGRIuOkA+0+Rzt/Pvcqo21CmAK/jcp0xvnejpfNat/fKAkI1IfNK60Q5oeTin
f1LMx578r6mKTnApziCmEvn1jq8dWgvLACILDAUdhqvEoRMuXr2Zqt0Mteb7Obss
4/985Q2JdiXRwGlOQRaisdEPv6iu1o24ASpuXAPvnfM8cH/FO/CDNeQD8ETdpU4M
+6MshqNC
=uuLW
-----END PGP SIGNATURE-----

--IC3qvXBnpT3Vahnt--
