Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3044AC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 11:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DC186BDF;
	Wed, 15 Nov 2023 12:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mJufw19B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114C887102; Wed, 15 Nov 2023 12:09:09 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 282E686996
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 12:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700046545; x=1700651345; i=xypron.glpk@gmx.de;
 bh=mGPwC1Z5Y5XscLjouxPrPQZg/P4slPBt+GotiR5kJoc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=mJufw19Bdj/up06HHOev9X/3E4U/1QRCcMvAJRcec9GDWHvV48ash/w+U42dENMk
 g9sWlyH9RDGx2yOlnkbg5N3nFMI/pQnCKDvz/WmpHDtaAuaW3kHql0Ird3smeVE2e
 abEsvVIYXDhKeBnTZpLIErvs/xVBHozMHP7n3f93j7oVROUpjltUQQINXo+VkqiPP
 6PeJqrynEiV/zZ67tdpj6W+1LObY3zAH95GLv0Zv97vGeZjX3zX2LaEcImUo5WVDF
 ArBrc6o4mavaW/gGtuup9UwqnMsXd82UcekuDAMe4EzuwZ44IRrgQumkDCXcnAv+a
 ONUTAmyLGnnIfaj9oA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1r5ho81b69-002Ui9; Wed, 15
 Nov 2023 12:09:05 +0100
Message-ID: <d643e467-cd35-4b15-907d-a8e79a2e4bda@gmx.de>
Date: Wed, 15 Nov 2023 12:09:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/20] efi: x86: Correct the condition for installing
 ACPI tables
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230920030027.1385833-1-sjg@chromium.org>
 <20230920030027.1385833-12-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230920030027.1385833-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pyE0GavDygBiuyNDHdXIW6jGHZF0Sn9oDwWvuE3uTa9hhL4Zyqv
 OUVmMCQk7TDjx7zA/HMHUc1ZeI/dCXo9r1Go6M20Pixqb4tFe4FoEqizJgauKfkTX3X7w/O
 l1G2q+RLy63hS1c9h4XWGG1iZCkfWD2g+Qjy1M9xL0x22pBGR/ZNalVtj4nT2tQ37SRA8ze
 VuSlitBJscpcfI7muTfkQ==
UI-OutboundReport: notjunk:1;M01:P0:6bLWWa8BebI=;410bsUGZpJwb2FvEi+43J40B1mc
 VObbtLSFVEkOdB/fHvG60j1k0XqKZQK0lsxwpcgYAcRZ/8vaaU4h6PStljFu7MgAjFVRLNWUY
 NpZddMT+kJdgPq2k3cFU10JGVL2s0kQtVcN2Bf3ybKW0Mm5fOjD/BAF/Q8UKyye5ZaLj/Oh9a
 6tTcEOAvzA2DYQNSqeSJE0bIkIZcU0zl8k5jseBMCqwR0/nmMVFKs7/BEv1NH3BErTiMl714j
 qQeMUa8EZwD09VVfDdJFuqgf3k8WU6WiWE3azROIaCpfIF9Jo7UeC6JM/7lAiAzCSs+vb4oFG
 KqjExui5PX65ZblGvRLHdsDu91RQ1IE1Ssrp7zaum2vQcnE3tpRVqYQbm4BrNL9nAfauRVwKz
 DbVEWNJSoegmeoFMNl4qEve2WRq1Y2JNbcAExZ7e58yt47KktP+9h7M7eO1GQGsvc7afEGiac
 Ba9qg0fOrEhSsctboKw4gNoCes4+b7a2GHTOn9V+i/RarzIPhxPjiqQkrslPW4Cuib+90T6XA
 W1aY0BIJn+x/HSX5B7779Sfu+G3s3E4B7qQqlUJiRApD6J81EwAbesqN0Sd842q1dZbQKs3lv
 ZaWT4zk5SFnLBCPy8soDaQPXZcTyGDkYzZNTEnYWixPdaJKIl6aLavo+Pkw/xxRyyZYkWq9xA
 uoBFcTSF6kv3HEkgUFnp8wys1ETFKbaKxjZM/IGpLNGX1xcMKB+ISUyH6oiRuABNXrIv8xmq0
 iS17oB5PaoxGj7qweRZVBnC+2E3DsFStSXMZvOblcNQRMYfYtn5pk3e+dAzoWGjMf+ArBOK09
 qFgIn2PWPqmHWEYksezNwHICY0yT34hJYehPN1dVJXebQlkL77kPzhyXElmMvMNblW1e94lSb
 RpI8hGSt8MCcTieg8kotB8myGm1TAzmRx7C+YIKfM2A9IMM9f92BGvsFLD5IfCvY2OdnnsSWl
 3Cau+REOVTd+OvCoS0WUerA2l/c=
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

On 9/20/23 05:00, Simon Glass wrote:
> It is not always the case that U-Boot builds the ACPI tables itself. For
> example, when booting from coreboot, the ACPI tables are built by
> coreboot.
>
> Correct the Makefile condition so that U-Boot can pass on tables built
> by a previous firmware stage.
>
> Tidy up the installation-condition code while we are here.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch
>
>   lib/efi_loader/Makefile    |  2 +-
>   lib/efi_loader/efi_setup.c | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 1a8c8d7cab5c..0eb748ff1a59 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -78,7 +78,7 @@ obj-$(CONFIG_EFI_ESRT) +=3D efi_esrt.o
>   obj-$(CONFIG_VIDEO) +=3D efi_gop.o
>   obj-$(CONFIG_BLK) +=3D efi_disk.o
>   obj-$(CONFIG_NETDEVICES) +=3D efi_net.o
> -obj-$(CONFIG_GENERATE_ACPI_TABLE) +=3D efi_acpi.o
> +obj-$(CONFIG_ACPI) +=3D efi_acpi.o

This change merged as
53e8e6f98679 ("efi: x86: Correct the condition for installing ACPI tables"=
)
looks wrong:

For QEMU with CONFIG_ACPI=3Dy and CONFIG_GENERATE_ACPI=3Dn I get

     EFI using ACPI tables at 0
     Error: Cannot initialize UEFI sub-system, r =3D 14

Device-trees are only suppressed in the bootefi command if
CONFIG_GENERATE_ACPI=3Dy.

Currently CONFIG_ACPI=3Dy only indicates that ACPI libraries are built. It
does not indicate that ACPI tables exist on the platform.

Best regards

Heinrich


>   obj-$(CONFIG_GENERATE_SMBIOS_TABLE) +=3D efi_smbios.o
>   obj-$(CONFIG_EFI_RNG_PROTOCOL) +=3D efi_rng.o
>   obj-$(CONFIG_EFI_TCG2_PROTOCOL) +=3D efi_tcg2.o
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 58d4e1340233..ad719afd6328 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -321,11 +321,11 @@ efi_status_t efi_init_obj_list(void)
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>   #endif
> -#ifdef CONFIG_GENERATE_ACPI_TABLE
> -	ret =3D efi_acpi_register();
> -	if (ret !=3D EFI_SUCCESS)
> -		goto out;
> -#endif
> +	if (IS_ENABLED(CONFIG_ACPI)) {
> +		ret =3D efi_acpi_register();
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +	}
>   #ifdef CONFIG_GENERATE_SMBIOS_TABLE
>   	ret =3D efi_smbios_register();
>   	if (ret !=3D EFI_SUCCESS)

