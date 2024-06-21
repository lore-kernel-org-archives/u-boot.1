Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22DBC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 12:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1052880AE;
	Fri, 21 Jun 2024 14:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TeHMbaD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA8588405; Fri, 21 Jun 2024 14:51:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E8287D10
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 14:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718974291; x=1719579091; i=xypron.glpk@gmx.de;
 bh=rsGplqd6HaZkKE+EbaKOd63LmSmaYnboR3ycmxJWfNA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TeHMbaD1gKxtg1HTtFs0xNMjFPpX3zUciC+gR2HcBvLNXoAg3n6yyHLrxbRbwdFc
 hXZwxd7f26oBR7f8gC6hlrVXvefQvqhnPqFS/htBh0U1086J1H45vRpKfRi0ppFBM
 rMePsWd0zmU0PgLLixRIuvMebRsangl07lVwy31CRg+lo8vDMVOZF72H1L6CeUmGa
 nIpLRbxCCWZkmD6Sr3biWv1A8vAWMuIWWGVwaxv7QT7DgBc3ddJJoo7wha24QJZlJ
 xngPcV3GR5D++NIGn5Z1XoD7aElxStEZSDOm97+u1uCwlhouH/v/MkwM3GprMGXu8
 Vbq8mKusUPRt2ro/lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1sGDsx2blg-006JRA; Fri, 21
 Jun 2024 14:51:31 +0200
Message-ID: <f516756f-93f7-4064-9dbe-abbced5fbd93@gmx.de>
Date: Fri, 21 Jun 2024 14:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cmd: bootm: add ELF file support
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 quentin.schulz@theobroma-systems.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de
References: <20240621114210.51101-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240621114210.51101-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cK1wWj/EtGswCFsQWbkz7epoIkYpdCpx1j6z5mDdxQF7L0f7lJC
 q37nuw9OIUMZH3xuHw4NMjRfHixqty/ECWvsrt1ZXHvv4vufWIwBJOCbj3upuEPcKU/cQBi
 AX/pYaPFDL64QKxwG2OZkQSXxNkbX3RAlTv3tF8yB67/24JM6vUVVz6BCvilfW3NEGlg1Ha
 j/6M/p3xqWeNlCEVjkzLw==
UI-OutboundReport: notjunk:1;M01:P0:Lf/o9TaN3+8=;iOnwRsihQ4HBT17eSwBWJUFk8Pv
 zM3e9Gqkr2OAMkaQQ1j5NGx8ftat033tFrE/3rXOjr9EQ2aAPWAzADznr0XN0z6yjyljMNmoB
 uPL1wD979dpgUxMZKtr011PF28sMlSvoq/JW+/L0BxjoHVAi3XuIIUXTJdrlALf1689SdmHrb
 66jK0Igl6Uhzd5sz+x9mfEdKf5eIZJ4wiQoPFTYqLNKSQo52URcmj6BRdIHzYfyxK86n8CN83
 QYQBYlMfqKoK54yJDqHrrBxU3S4Wyso8kCtdT2uUb3oPgU7yiNI2PjC5TLWEoyM9hQNMSaSsM
 1H/w/e3NCIlZO8tH6y3qAVqZjYdNxr9DfSN5cLtJZrvbLFBAhRMJvzCkbmlaKdz8el2vof5ks
 uttOQNpjU6fHQQIRQ3/3w45w2wSYFFkoXyjHyn/UuioHDG1Jb808uLtikGY+7/8A3h6LBDQOF
 pqmNNZNrxhHoEdWztaVB9r1I8J+UVvFci+NoiudLqmqr5xnYl1RngCDXH5synA2GV/7f9XWrp
 yF6SkQtfQBDtYDHwpTdKlwDiNWTNRnzabFQpMoz86xHxXNckECqdcfcSVnz6PLn6+0Kp3RLja
 IkYxp9fExxJKxPrM08P1B89yvg+b05AqPH+kWP880ldmoqV+bDyIF2yfUsFb/PakFSx9e8vTl
 wUsGnBjUW80mi9qf769+0s+fhBGRcbSIO0nM75xnwoL0Ov7wY09s5MWo3JMgIxpm99zmG0s9K
 JbICPEsVEwl6aN3Za96B15XoB0NYVkUo6ggSVNpj9zAQLF6xqj33WKdeCklnhBAatpI2wrsJN
 hLZ3h1PEbkDyd5N3RAQUBtRta2flzq0GkYbfQUfdNLkKQ=
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

On 21.06.24 13:42, Maxim Moskalets wrote:
> Some operating systems (e.g. seL4) and embedded applications are ELF
> images. It is convenient to use FIT-images to implement trusted boot.
> Added "elf" image type for booting using bootm command.
>
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>

I guess a test could be added to test/py/tests/test_zynqmp_rpu.py which
already uses the bootelf command?

Best regards

Heinrich

> ---
> v5:
> 	used func from lib/elf.c to avoid dependency form CLI
> ---
>   boot/bootm_os.c  | 18 ++++++++++++++++++
>   boot/image-fit.c |  3 ++-
>   boot/image.c     |  5 ++++-
>   cmd/Kconfig      |  7 +++++++
>   include/image.h  |  1 +
>   5 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index 15297ddb53..6a6621706f 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -8,6 +8,7 @@
>   #include <bootstage.h>
>   #include <cpu_func.h>
>   #include <efi_loader.h>
> +#include <elf.h>
>   #include <env.h>
>   #include <fdt_support.h>
>   #include <image.h>
> @@ -394,6 +395,20 @@ static int do_bootm_qnxelf(int flag, struct bootm_i=
nfo *bmi)
>   }
>   #endif
>
> +#if defined(CONFIG_BOOTM_ELF)
> +static int do_bootm_elf(int flag, struct bootm_info *bmi)
> +{
> +	Bootelf_flags flags =3D { .autostart =3D 1 };
> +
> +	if (flag !=3D BOOTM_STATE_OS_GO)
> +		return 0;
> +
> +	bootelf(bmi->images->ep, flags, 0, NULL);
> +
> +	return 1;
> +}
> +#endif
> +
>   #ifdef CONFIG_INTEGRITY
>   static int do_bootm_integrity(int flag, struct bootm_info *bmi)
>   {
> @@ -535,6 +550,9 @@ static boot_os_fn *boot_os[] =3D {
>   #ifdef CONFIG_BOOTM_EFI
>   	[IH_OS_EFI] =3D do_bootm_efi,
>   #endif
> +#if defined(CONFIG_BOOTM_ELF)
> +	[IH_OS_ELF] =3D do_bootm_elf,
> +#endif
>   };
>
>   /* Allow for arch specific config before we boot */
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index f6464bcf62..9253f81fff 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2175,7 +2175,8 @@ int fit_image_load(struct bootm_headers *images, u=
long addr,
>   		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
>   		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
>   		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
> -		fit_image_check_os(fit, noffset, IH_OS_VXWORKS);
> +		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
> +		fit_image_check_os(fit, noffset, IH_OS_ELF);
>
>   	/*
>   	 * If either of the checks fail, we should report an error, but
> diff --git a/boot/image.c b/boot/image.c
> index fc774d605d..abac254e02 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -130,7 +130,10 @@ static const table_entry_t uimage_os[] =3D {
>   	{	IH_OS_OPENRTOS,	"openrtos",	"OpenRTOS",		},
>   #endif
>   	{	IH_OS_OPENSBI,	"opensbi",	"RISC-V OpenSBI",	},
> -	{	IH_OS_EFI,	"efi",		"EFI Firmware" },
> +	{	IH_OS_EFI,	"efi",		"EFI Firmware"		},
> +#ifdef CONFIG_BOOTM_ELF
> +	{	IH_OS_ELF,	"elf",		"ELF Image"		},
> +#endif
>
>   	{	-1,		"",		"",			},
>   };
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a2dee34689..613baa106e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -321,6 +321,13 @@ config BOOTM_EFI
>   	help
>   	  Support booting UEFI FIT images via the bootm command.
>
> +config BOOTM_ELF
> +	bool "Support booting ELF images"
> +	depends on CMD_BOOTM && LIB_ELF
> +	default n
> +	help
> +	  Support booting ELF images via the bootm command.
> +
>   config CMD_BOOTZ
>   	bool "bootz"
>   	help
> diff --git a/include/image.h b/include/image.h
> index c5b288f62b..9daaee15cd 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -100,6 +100,7 @@ enum {
>   	IH_OS_TEE,			/* Trusted Execution Environment */
>   	IH_OS_OPENSBI,			/* RISC-V OpenSBI */
>   	IH_OS_EFI,			/* EFI Firmware (e.g. GRUB2) */
> +	IH_OS_ELF,			/* ELF Image (e.g. seL4) */
>
>   	IH_OS_COUNT,
>   };

