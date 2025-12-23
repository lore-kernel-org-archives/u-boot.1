Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC63E6FE24
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 17:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03B08416B;
	Tue, 23 Dec 2025 18:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XlsJKOi2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D9558416C; Tue, 23 Dec 2025 18:58:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5754884167
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 18:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766512694; x=1767117494; i=xypron.glpk@gmx.de;
 bh=nVF4Y2h/P4VQATxGl3rNSOaaq/dvPbEeks4W1z8yFYw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XlsJKOi2J+cFpMRSI1Bc3vfp+BG+UQVmnKiPYPbrLT+mxV6Bnrb4oDiYLIMBZF/A
 pRxeNJpqQpKtIKoAxU8FqkpR4yTiA9RhRNp545EPjP/tafIpIOAqAS2PlrZzCPLbl
 /Vw+DdrFi53J5fTqE9uIgBdmvR/ybnV5kmPpaSLyVpALVqJr6ck5oLLe9GgKE9hj+
 zviBJcBr0ti/4LeaLGd4mthb2Eh3ujJUuIWjCVNfCGshIC5sQx0b1lf3I6bF3QgLb
 hADN+J8UlErBiB/NYW/M90cj0pYR9RG4Ah2S7SkBGn8oh0AvmewDm+VzT87BkZhFx
 +VJHSNLgyZuNMiLj0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.125] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1vt3PP0goP-00tjia; Tue, 23
 Dec 2025 18:58:14 +0100
Message-ID: <d7313d07-7b4e-4f89-b2fd-a6edcde31528@gmx.de>
Date: Tue, 23 Dec 2025 18:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] configs: sandbox: Enable environment in SPI NOR
 support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <20251223143130.16266-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251223143130.16266-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Zaaa1hqp3ixWzcjH6Qh4raUVOJSSJy9jijfFAkT0hY7+YvzNd2
 83erUJYBBjvIXRW11NfgLG0n3w0jcWlaFzmVAMRgziEj1OLdNZjb58dxEp3p6ZRnEy/J8wM
 gHo7q4LwmyMUUgWUUS0qKXhA2wvKOs2413kApYmdeMHFteET0blw9p3Sbxynjx6mDA2tAMp
 mCOxBGXgNe8BL/+3dC7ww==
UI-OutboundReport: notjunk:1;M01:P0:5/ijEl9/0JE=;AcV/9GBtI5nVVMfpf+cMP+wEqZW
 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
 Z1V0Ect1pfVZKRWBEfssY8k28LBiT
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

On 12/23/25 15:31, Marek Vasut wrote:
> Make environment support in SPI NOR available in sandbox,
> so the environment storage in SPI NOR can be tested in CI.
> Enable redundant environment support as well to cover this
> in CI tests too.

Applying: configs: sandbox: Enable environment in SPI NOR support
error: patch failed: configs/sandbox64_defconfig:106
error: configs/sandbox64_defconfig: patch does not apply
error: patch failed: configs/sandbox_defconfig:154
error: configs/sandbox_defconfig: patch does not apply
Patch failed at 0001 configs: sandbox: Enable environment in SPI NOR suppo=
rt


@Simon:

Can we move the sandbox documentation to doc/board/. This is where all=20
other architectures are described. I has a hard time finding that=20
backing file is spi.bin for this functionality.

The sandbox driver should properly detect the SPI size.

$ truncate -s 8M spi.bin
=3D> sf probe
SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, total 2 M=
iB

$ truncate -s 1M spi.bin
=3D> sf probe
SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, total 2 M=
iB

>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Enable ENV_REDUNDANT_UPGRADE
> ---
>   board/sandbox/sandbox.c     | 1 +
>   configs/sandbox64_defconfig | 7 +++++++
>   configs/sandbox_defconfig   | 7 +++++++
>   3 files changed, 15 insertions(+)
>=20
> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
> index d0bb3e3bb48..13006a0ffc2 100644
> --- a/board/sandbox/sandbox.c
> +++ b/board/sandbox/sandbox.c
> @@ -89,6 +89,7 @@ static enum env_location env_locations[] =3D {
>   	ENVL_NOWHERE,
>   	ENVL_EXT4,
>   	ENVL_FAT,
> +	ENVL_SPI_FLASH,
>   };
>  =20
>   enum env_location env_get_location(enum env_operation op, int prio)
> diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> index 70c757640c0..22de4acbd88 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -2,10 +2,13 @@ CONFIG_TEXT_BASE=3D0
>   CONFIG_SYS_MALLOC_LEN=3D0x6000000
>   CONFIG_NR_DRAM_BANKS=3D1
>   CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_ENV_OFFSET=3D0x0
> +CONFIG_ENV_SECT_SIZE=3D0x1000
>   CONFIG_DEFAULT_DEVICE_TREE=3D"sandbox64"
>   CONFIG_DM_RESET=3Dy
>   CONFIG_SYS_LOAD_ADDR=3D0x0
>   CONFIG_PRE_CON_BUF_ADDR=3D0x100000
> +CONFIG_ENV_OFFSET_REDUND=3D0x10000
>   CONFIG_PCI=3Dy
>   CONFIG_SANDBOX64=3Dy
>   CONFIG_DEBUG_UART=3Dy
> @@ -106,6 +109,10 @@ CONFIG_OF_LIVE=3Dy
>   CONFIG_ENV_IS_NOWHERE=3Dy
>   CONFIG_ENV_IS_IN_EXT4=3Dy
>   CONFIG_ENV_IS_IN_FAT=3Dy

This line does not exist

> +CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> +CONFIG_ENV_SECT_SIZE_AUTO=3Dy
> +CONFIG_ENV_REDUNDANT=3Dy
> +CONFIG_ENV_REDUNDANT_UPGRADE=3Dy
>   CONFIG_ENV_EXT4_INTERFACE=3D"host"
>   CONFIG_ENV_EXT4_DEVICE_AND_PART=3D"0:0"
>   CONFIG_ENV_IMPORT_FDT=3Dy
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index dfdaaff1eff..97f5d5dc074 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -2,9 +2,12 @@ CONFIG_TEXT_BASE=3D0
>   CONFIG_SYS_MALLOC_LEN=3D0x6000000
>   CONFIG_NR_DRAM_BANKS=3D1
>   CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_ENV_OFFSET=3D0x0
> +CONFIG_ENV_SECT_SIZE=3D0x1000
>   CONFIG_DM_RESET=3Dy
>   CONFIG_SYS_LOAD_ADDR=3D0x0
>   CONFIG_PRE_CON_BUF_ADDR=3D0xf0000
> +CONFIG_ENV_OFFSET_REDUND=3D0x10000
>   CONFIG_PCI=3Dy
>   CONFIG_DEBUG_UART=3Dy
>   CONFIG_SYS_MEMTEST_START=3D0x00100000
> @@ -154,6 +157,10 @@ CONFIG_OF_LIVE=3Dy
>   CONFIG_ENV_IS_NOWHERE=3Dy
>   CONFIG_ENV_IS_IN_EXT4=3Dy
>   CONFIG_ENV_IS_IN_FAT=3Dy

This line does not exist.

Best regards

Heinrich

> +CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> +CONFIG_ENV_SECT_SIZE_AUTO=3Dy
> +CONFIG_ENV_REDUNDANT=3Dy
> +CONFIG_ENV_REDUNDANT_UPGRADE=3Dy
>   CONFIG_ENV_EXT4_INTERFACE=3D"host"
>   CONFIG_ENV_EXT4_DEVICE_AND_PART=3D"0:0"
>   CONFIG_ENV_IMPORT_FDT=3Dy

