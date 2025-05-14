Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51188C3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 21:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8CC282B11;
	Wed, 14 May 2025 23:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QVW21vCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC1382AC1; Wed, 14 May 2025 23:58:38 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF7782AC1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 23:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-401be80368fso152827b6e.1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747259915; x=1747864715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P8f1N7D1b7dI2aR6kg1ROpBubzBiQHmoVZNtDpjLJb8=;
 b=QVW21vCc1JymP/nDd5TP9Xz4z8mFnfP3FfC9seB8pe6Ql3emrbc59W5a9nU4rwaKo8
 KwVWrLBITitRMqyHc3XdvPo+k3S++FzNZkRV9a+QchFqTeE5M5BfVf9/KgcefPqEyKDn
 O7x3AacQgUH2ITOjWGYcmXy1AI7P8pN8QlIFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747259915; x=1747864715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8f1N7D1b7dI2aR6kg1ROpBubzBiQHmoVZNtDpjLJb8=;
 b=wr5JaKKCxEgUA1bTlK1AvGBleLAfyhkG3VpgJr52rMZFcEOVtwbUtQ+JBieu/iWtUS
 nfHCw2H4/6SxSmIru/rPc/kw4lIvsIBypnzBj8A4zWOaIx1smE30MN4pyBLfQpBUYprx
 gNI9YxFhkrdUPl7qEZtTqhKA9RGFlvuyk3pJp/m5YLjFcJ6qW1OQoedfqxE43a2SOqGq
 OXWi8+Dl2PEaYNc+OFj88SdA8zWNiaVlJfvXZtN6IY71npONqgJrgmDXTj5oGcQnFdGG
 30rAylqSCmDJzssbAc51Aucsg3Q8l6UVxQ8SEAVRTigmOv37dAHPMnVk7KCo5AElwemh
 Ro1w==
X-Gm-Message-State: AOJu0YxKIvUYlcMame5/6vS8zv3V0GLg7U1TOMPJEZzQSHhudIkfSDXb
 aiiHcKBOaLfKn9z9FEXQpzOCoZPFl/WVNEsJjJbMR/j9yb3E1gP08iSxf+qcQ/I=
X-Gm-Gg: ASbGnctKNtrlyhProBsWpTWT0j8MeZpzvP4b/TI2toovjlD+w2Nc7O5vwo/8qI2CF/w
 Q9mSaBpB/KovajRI9fJlvp1Oy6pCrc7JrAdypyv+Asm/WuyLPM6dahalmotf3VaQbV0TWF71elC
 0zPwxtXBe7e4ZWx0zd6P7X+dw9S74QNV3hoqXUdhDAgqf1fSDxE3U+NDwNi21qkpVkOV07ItQH2
 XPHERWzenPb9WjpchozUPcvOUsZ3Q0Fo/ZEFSteFq4URAvguw10PMKp9qrt/DTcb4Yhw8AFuH6w
 KX35+KLl3NbXrnJ5NFcYFfhFlJFwOjlMRXz9SLxkaqcdxjJd9KXJobUeGkPzNqHpMsFTetOajOI
 C0+rfDZHELHJn
X-Google-Smtp-Source: AGHT+IEGHL01FBDGToFxgrR4NBMdThMT6zR6AOiCktw2xanX/g+SFmewV2MYLMKi05W3y4kRkYn/8A==
X-Received: by 2002:a05:6870:47a4:b0:2d6:af0:8d8e with SMTP id
 586e51a60fabf-2e32b0658cdmr2711692fac.2.1747259914933; 
 Wed, 14 May 2025 14:58:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba06ddf08sm2857981fac.16.2025.05.14.14.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 14:58:33 -0700 (PDT)
Date: Wed, 14 May 2025 15:58:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v4 17/22] passage: Add a qemu test for ARM
Message-ID: <20250514215831.GE603748@bill-the-cat>
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510134253.1581164-12-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NohrJ/0MPKJQsWJL"
Content-Disposition: inline
In-Reply-To: <20250510134253.1581164-12-sjg@chromium.org>
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


--NohrJ/0MPKJQsWJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 03:42:15PM +0200, Simon Glass wrote:

> Check that the standard passage works on ARM, by setting it up in SPL
> and making sure that it comes through correctly in U-Boot proper.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v3)
>=20
> Changes in v3:
> - Add conditions to avoid enaling the test on qemu_arm_sbsa
> - Add support for a 64-bit test also
>=20
> Changes in v2:
> - Add a devicetree for qemu-arm so that qemu_arm_spl can work
>=20
>  configs/qemu_arm64_spl_defconfig |  5 +++++
>  configs/qemu_arm_spl_defconfig   |  6 ++++++
>  test/py/tests/test_passage.py    | 13 +++++++++++++
>  3 files changed, 24 insertions(+)
>  create mode 100644 test/py/tests/test_passage.py
>=20
> diff --git a/configs/qemu_arm64_spl_defconfig b/configs/qemu_arm64_spl_de=
fconfig
> index a9ed47c8d3b..60651f80938 100644
> --- a/configs/qemu_arm64_spl_defconfig
> +++ b/configs/qemu_arm64_spl_defconfig
> @@ -33,6 +33,10 @@ CONFIG_USE_PREBOOT=3Dy
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_PCI_INIT_R=3Dy
>  CONFIG_BLOBLIST=3Dy
> +CONFIG_BLOBLIST_PASSAGE=3Dy
> +CONFIG_BLOBLIST_SIZE=3D0x4000
> +CONFIG_SPL_BLOBLIST_ALLOC=3Dy
> +CONFIG_PASSAGE_IN=3Dy
>  CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=3Dy
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  # CONFIG_SPL_SEPARATE_BSS is not set
> @@ -47,6 +51,7 @@ CONFIG_CMD_EFIDEBUG=3Dy
>  CONFIG_CMD_TPM=3Dy
>  CONFIG_CMD_MTDPARTS=3Dy
>  CONFIG_SPL_OF_CONTROL=3Dy
> +CONFIG_OF_PASSAGE=3Dy
>  CONFIG_OF_BOARD=3Dy
>  CONFIG_ENV_IS_IN_FLASH=3Dy
>  CONFIG_SPL_DM=3Dy
> diff --git a/configs/qemu_arm_spl_defconfig b/configs/qemu_arm_spl_defcon=
fig
> index 9c4408dc73c..cf8ac703577 100644
> --- a/configs/qemu_arm_spl_defconfig
> +++ b/configs/qemu_arm_spl_defconfig
> @@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DEFAULT_DEVICE_TREE=3D"qemu-arm"
>  CONFIG_TARGET_QEMU_ARM_32BIT_SPL=3Dy
>  CONFIG_SPL_SERIAL=3Dy
> +CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x9000
>  CONFIG_SYS_BOOTM_LEN=3D0x4000000
>  CONFIG_SYS_LOAD_ADDR=3D0x40200000
>  CONFIG_DEBUG_UART_BASE=3D0x9000000
> @@ -34,6 +35,10 @@ CONFIG_USE_PREBOOT=3Dy
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_PCI_INIT_R=3Dy
>  CONFIG_BLOBLIST=3Dy
> +CONFIG_BLOBLIST_PASSAGE=3Dy
> +CONFIG_BLOBLIST_SIZE=3D0x4000
> +CONFIG_SPL_BLOBLIST_ALLOC=3Dy
> +CONFIG_PASSAGE_IN=3Dy
>  CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=3Dy
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
> @@ -44,6 +49,7 @@ CONFIG_CMD_PCI=3Dy
>  CONFIG_CMD_TPM=3Dy
>  CONFIG_CMD_MTDPARTS=3Dy
>  CONFIG_SPL_OF_CONTROL=3Dy
> +CONFIG_OF_PASSAGE=3Dy
>  CONFIG_OF_BOARD=3Dy
>  CONFIG_ENV_IS_IN_FLASH=3Dy
>  CONFIG_SPL_DM=3Dy
> diff --git a/test/py/tests/test_passage.py b/test/py/tests/test_passage.py
> new file mode 100644
> index 00000000000..4d95287fe55
> --- /dev/null
> +++ b/test/py/tests/test_passage.py
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2021 Google LLC
> +
> +import pytest
> +
> +@pytest.mark.buildconfigspec('qemu_manual_dtb')
> +@pytest.mark.buildconfigspec('arm')
> +@pytest.mark.buildconfigspec('of_passage')
> +def test_passage(ubman):
> +    """Test that the standard passage on ARM from SPL to U-Boot works."""
> +
> +    response =3D ubman.run_command('bdinfo')
> +    assert 'devicetree  =3D passage' in response

Why is this test QEMU specific? This would be at least as interesting to
run on vexpress_fvp_bloblist and then any other real platform which also
uses this in the future. Since the time to run this test will be
negligible I don't see why it should be omitted elsewhere.

--=20
Tom

--NohrJ/0MPKJQsWJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmglEgcACgkQFHw5/5Y0
tyx7rwwAnRSpMDkaM3NnZgsLNClRnPDEV6jCXJUChpJTqw7LjlEURaf2Ule+89bV
luZ2HRX7eq7IGXAAiaIxOIwyZJzz1uBQs5j1kgtMXMCccWDloTz8ROaFwUIeKe6M
sNI/PUEA0DsMv842PkMKLCvLTB6STtL8YyEghktT+L5b1xfdnZN44rp8RReKvTny
UDGMGa7f98iGkiFHS679SykQDjEBgVnTuukXdYUe4pKu7A3CTNP7HHSC3t5iv0eV
iJ4ynLlBpFtUSmoeDebBAiRUI2OXle5XUO8La2n7/95iJHOX9cr6NIXbglocGR0X
BHIcVrLyz1+yudOWZSrq/pcMJu1aE18586fPHJSoA1nhzFNbQkKJIlimZgLIYCfI
dPGAwcUMy8F4lD+qVU2gkVmDjJxrhf7McjGYWIsd3pepgBBEEc7mp/YB8uWaGy00
ZnB1IQuCvTqnCEyf1cv78n5/vCg77V/orCmOI3uBzgPbf2gdi/v8rjb1Yl7AMDqL
NhdQxjCq
=aJoQ
-----END PGP SIGNATURE-----

--NohrJ/0MPKJQsWJL--
