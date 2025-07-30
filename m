Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A83C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5D738211F;
	Wed, 30 Jul 2025 19:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lE8E7U3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07EC82BA1; Wed, 30 Jul 2025 19:23:37 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CFD7803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73e810dc01aso42260a34.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753896214; x=1754501014; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lWG7/aYF6V47dQ4cbXAXo8WjlLCM2NmBbfSPpphwqAI=;
 b=lE8E7U3lb8cfhoOktJBwiqavPuSbKuWh5GV5QoR0ytRZuWBFz1VR8kWRKjF66kdYP/
 s9f+BZPSqmZxS7EH69x/5CKGIiZEzlT5o6k+d4ZCbjs2kBqY974CxkJV2kK67xp1S17F
 nl2E5RFATv+Hgr0dR/EZCufg6iCztxEAS/KDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753896214; x=1754501014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWG7/aYF6V47dQ4cbXAXo8WjlLCM2NmBbfSPpphwqAI=;
 b=r8xtRzoEsFHB0lQESlk7TiYX0M19Gt15sl5USwkksqaIT24jO9BEyoIGA7meJ4SDJJ
 EceNpAA6UoFmF6J05wWBt1wUQl7ogzsQct7DxZeH3t4m7Y6JOJJm94tYSGaDGBq+tPS+
 hx04MBBxzw+pIXkTto102ukedaSheHwJ34Q15cBMHxDM0zeeCZIK1J45/g1Pf0o5F3m+
 pIPfojYPCokKBKC/wlu3hp+/5GJlXYCDZK+nITM3ofW3TqE0SAAqVyup1L0vq3oQO4mz
 B1YJqZK1GT2sRr/JUws/zMKflHupc2aQNH1g0uNi/bXsAzx79Mv7LCev/UooxiAzNj5j
 3FwQ==
X-Gm-Message-State: AOJu0YzsgzJYpou6YcTkMKsUcADCjFrR5RMQO2DEn7HjjFKmetAjzWRp
 SSToMDmY2hlVOId1yPhOcLN1j4f/JYzEZp6C8t9DeDpFwRPGbMlCr5oRAW3tZjbnNm8=
X-Gm-Gg: ASbGnctoVkjLlLIHffnDnhXA+BYs9RWeo9BD1AX5IQDN/x3fZ9nQuzbCZ0SVg8PEQ8V
 Q/bn8jiEgq3Z0vPqsITsAjZHE2M9qONIteHgPHC1zYVC02KOwP3dxBAQfoGd1NTy7vwSMujmG7h
 EACv+BVa6tAzBeAkMDIhUE6nF4CCZfbINPoV8Sd1iZo7shQHbjNyLUC2caikEE1PNTn1Q6gG43+
 nu/VMqo/iTQ7WBL0PpyATtTiLCoVI7j3PlLUE1o2GYagh93ag/80WrsRV8lnJG66mmacjMtz4lY
 hwkwTE9DwZ98/0kZT5Kn1RYF/MThCZgrp0buaBD6umArGOyY+Nkfw40LiXco78Gmtpmaxw5wCn4
 HX6CWDKQGpjGDtAmu5madq35djGuVt4DcHHBLn163rV3iJXksqUFPIiTt
X-Google-Smtp-Source: AGHT+IE2lzUaSzTBp2k7Ec9aYSUrUKUlfyfn+Bv6tTmnfi1OgbHlro822VMjBQSIaTjkCoayoHpPrQ==
X-Received: by 2002:a05:6808:d4d:b0:41c:9719:478c with SMTP id
 5614622812f47-4319a66bcdbmr2626813b6e.17.1753896213801; 
 Wed, 30 Jul 2025 10:23:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-42c7b55be77sm1891016b6e.14.2025.07.30.10.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:23:32 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:23:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] CI: Wire mbv32 combinations
Message-ID: <20250730172330.GT1807455@bill-the-cat>
References: <dc52619a474c6374d43e7fb232480cab3392b00a.1753874707.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gWxyFyP1tQWwvvgt"
Content-Disposition: inline
In-Reply-To: <dc52619a474c6374d43e7fb232480cab3392b00a.1753874707.git.michal.simek@amd.com>
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


--gWxyFyP1tQWwvvgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 01:25:09PM +0200, Michal Simek wrote:

> After upgrading to QEMU 10 by commit 1d782a3f229c ("Docker, CI: Update to
> latest Ubuntu and Dockerfile") let's wire mbv32 which is the part of QEMU
> to have it under regression.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
> gitlab I have tested.
> azure I didn't test it but did blindly all changes as they are in github
> one.
>=20
> This patch has be applied on the top of this series
> https://lore.kernel.org/r/cover.1753182218.git.michal.simek@amd.com

For v2, take this via your tree.

[snip]
> ---
>  .azure-pipelines.yml | 20 ++++++++++++++++++--
>  .gitlab-ci.yml       | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 4 deletions(-)
>=20
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 8209d2b329cb..76a0ba097f93 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -258,11 +258,11 @@ stages:
>            ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/p=
y/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
>            ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
>            ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
> -          if [[ "\${TEST_PY_BD}" =3D=3D "qemu-riscv32_spl" ]]; then
> +          if [[ "\${TEST_PY_BD}" =3D=3D "qemu-riscv32_spl" ]] || [[ "${T=
EST_PY_BD}" =3D=3D "xilinx_mbv32_smode" ]]; then

You missed an escape here and it should be:
"\${TEST_PY_BD}" =3D=3D "xilinx_mbv32_smode"

>                wget -O - https://github.com/riscv-software-src/opensbi/re=
leases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>                export OPENSBI=3D/tmp/opensbi-1.3.1-rv-bin/share/opensbi/i=
lp32/generic/firmware/fw_dynamic.bin;
>            fi
> -          if [[ "\${TEST_PY_BD}" =3D=3D "qemu-riscv64_spl" ]] || [[ "\${=
TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; then
> +          if [[ "\${TEST_PY_BD}" =3D=3D "qemu-riscv64_spl" ]] || [[ "\${=
TEST_PY_BD}" =3D=3D "sifive_unleashed" ]] || [[ "${TEST_PY_BD}" =3D=3D "xil=
inx_mbv64_smode" ]]; then

Same here.

The rest of the Azure side looks right.

--=20
Tom

--gWxyFyP1tQWwvvgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIpVEgAKCRAr4qD1Cr/k
CoACAQCoPyfquQCaskp1T7WNnjiOvMhSauJSoPlD9jHJmmyqAgEAn8/JwGk9BxVP
79G5DQx5FVN/tJcNe7fXIXg/Fa8PGAg=
=Y/j4
-----END PGP SIGNATURE-----

--gWxyFyP1tQWwvvgt--
