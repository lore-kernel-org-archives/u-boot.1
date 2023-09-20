Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BFECE79AC
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 07:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB66686BFC;
	Wed, 20 Sep 2023 09:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mSwR4Cfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B9986C48; Wed, 20 Sep 2023 09:20:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1581286B69
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 09:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695194401; x=1695799201; i=xypron.glpk@gmx.de;
 bh=zk/4VmNVEDijn8NE5rWODc82CS7RAmFsEhOGAwGsN9Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mSwR4CfuGFEYTvJErkgP+QmWuSUjBcmR+8nPi4u9EECZTvXO+5krPelYDTz1TF9mnqP1W/wLrZt
 JyvSG84yjKiwGdD2L4lX8G9Ali8WtZ3gPEXR/V402gGtMkcDug5WEN+7Mdz/6SbLjIokACppARPGh
 5n3syJf9udpOTm+RD0ZS9RouGDKKVnOTxZTnGXc14CHpZ+6GgN9g+YmPgeGADgtJEtDbBY4uDasdL
 38lgYh5sNEbonqpDdxJOL5UlcCsZZJ7C72VfpA0rIN6dTW6mEDQVYkvgqXJYGag0GKRpE3kV8j71r
 DsNj6AXq2Hr7FaZYf5LVvasB4ehOl+hvQSZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1rITEl35dO-00b4ZF; Wed, 20
 Sep 2023 09:20:01 +0200
Message-ID: <6c3f7c16-c67b-4c7d-9d91-0e214702fa88@gmx.de>
Date: Wed, 20 Sep 2023 09:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/20] x86: coreboot: Drop USB init on startup
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230920030027.1385833-1-sjg@chromium.org>
 <20230920030027.1385833-9-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230920030027.1385833-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:maGYHrd0hX1AIvjf/lOyTBs7wEP0hqXn8SAJ9+X+Kwebud6VvQX
 WijiTeZUycgT/N+wLytFJjtIkB/gPGscfIrgtPhreKZH6vTYnbv9Nd767hjPTD7JnryVrxZ
 c3BDvXND7Zai3ucTTrYWroDvZyUJ422Y2KyrD+rAE5XaLXOFypze4YougPA0uYJ80TH47Ae
 BV2k7F9lPrRlgpk9wdZBg==
UI-OutboundReport: notjunk:1;M01:P0:l00ueKkqaOY=;fOkmMDLqczkqfJnNoNROMre1kCX
 gE+n205yws3VzILp9Km/ykOcm8DN+A8iA8UQyFCkA4JfIFnhsNwKRVrieoqZG+7UvhJacYe7A
 jkSvBMc67elwDh2K/LErVgY0yM7q8cXFYRIeYpxISPk8COeMz3D6Z5YxxwtLTDCiu3BXsnckj
 ba9ctkxftwN/R7D/lBelqh+0aa9XMsZRe3RlSBbklZ+0WLqw9oJmv94nD8RpPkNAf1ymhyyFZ
 Pv9J2P6t9GwVQn25b3bSC9WY9N2N14lmMQiw8zEfF/t8NaSMagYi2PREV3LXfqBw0sfJmsj+z
 NWTraPid6wfWX0+iSGMVjKbJcvOu26xs0x1HlBxS1T3fAEmL0JISV2GRnjh5Z1YdUHCNgWkw2
 B6j9sXBcLmZTSwXZiGvn1nSKAuRBPi2HxHsJ9EbTFCTphTBBrA/xW6YqIskQgudt2AxYR7j/v
 9Ka7HjOAoSrNGpR+AZRlS+8CWi43czSAIv59rPVrlffniAaqL27SGizUCUbxgAdPeYSI1FOdg
 YPWY/icHdA9/JyugmuSdB2jX8ut601dPVVFOHGogfpkuwDdgEIRNOAblVfWG3tEnGpvklu0pd
 gayZ1An3+JdLyr+QfhoSBjhF9gfQG7pdbxbrcExiCMEbH8DKfsGYhTUa1myQjcnNgguq1OjVi
 XWABTzJB2T12LGXdt72RU5d1nltiQS7AhwX3i2aLGNTeK0w9SfHrdb/GldQbnQBnYj0NJQvMj
 pHlgReTaakN0dAo/QYMqemcGiUJw08fEYIvgQZTZVz4AdkI+H1c84vo2C3XbIKBfOD/obv5tp
 RKZKMIDzecL8tp3FeQpqd0fGwa4zD/i3qxE3/xkF1P+v8uY8txL3ZGU0npBgAVAJ2HNAW0746
 Ugx/RVJ2yPZmFvsHy4Sk1XdI9ZkWDvr4rwi1YICz6mEQJx++/QbgC2MNMZGntkNKY3OFrbbJK
 vddlpQ==
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
> This is very annoying as it is quite slow on many machines. Also, U-Boot
> has an existing 'preboot' mechanism to enable this feature if desired.
>
> Drop this code so that it is possible to choose whether to init USB or
> not.
>
> Use the existing USE_PREBOOT mechanism instead.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v5:
> - Make use of the uSE_PREBOOT mechanism
>
>   arch/x86/cpu/coreboot/Kconfig    | 1 +
>   arch/x86/cpu/coreboot/coreboot.c | 4 ----
>   2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/x86/cpu/coreboot/Kconfig b/arch/x86/cpu/coreboot/Kconf=
ig
> index b97c27790419..178f8ad18162 100644
> --- a/arch/x86/cpu/coreboot/Kconfig
> +++ b/arch/x86/cpu/coreboot/Kconfig
> @@ -25,6 +25,7 @@ config SYS_COREBOOT
>   	imply FS_CBFS
>   	imply CBMEM_CONSOLE
>   	imply X86_TSC_READ_BASE
> +	imply USE_PREBOOT

For automatic initialization of the PCI bus we have CONFIG_PCI_INIT_R.
Wouldn't it be preferable to also have a CONFIG_USB_INIT_R instead of
relying on console commands in CONFIG_PREBOOT?

Best regards

Heinrich

>   	select BINMAN if X86_64
>
>   endif
> diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/co=
reboot.c
> index da43d66e95d7..82fe4c71cd27 100644
> --- a/arch/x86/cpu/coreboot/coreboot.c
> +++ b/arch/x86/cpu/coreboot/coreboot.c
> @@ -86,10 +86,6 @@ static int last_stage_init(void)
>   	if (IS_ENABLED(CONFIG_SPL_BUILD))
>   		return 0;
>
> -	/* start usb so that usb keyboard can be used as input device */
> -	if (IS_ENABLED(CONFIG_USB_KEYBOARD))
> -		usb_init();
> -
>   	board_final_init();
>
>   	return 0;

