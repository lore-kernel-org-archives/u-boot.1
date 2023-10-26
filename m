Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F332C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7662D87649;
	Thu, 26 Oct 2023 20:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R9EJbPer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EBF87B51; Thu, 26 Oct 2023 20:58:41 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD4B986FC8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507be298d2aso1864415e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698346719; x=1698951519; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F5UQZBMZ3na+0lv17IT5bO3/rHRiLneXWEIHq1ys77U=;
 b=R9EJbPerSMZTvJaBZnf42l4V10nzQjbDfcszozlg5vVb3io8KAHvehevwhFnA5RX4Y
 cpa197ssVEZPf/0gnP5NO1MN5MZMl+UL5FU98BrCXnp83Ks6Aj3qcQnnM/i1Sncj1FFp
 K1aS4Ra54+3hQJVylmll73rK8Z174m+cIOPUIUvrHFzPxTcmyh109pdOi1PPnzE8hCII
 WwxTF9dO+2W2URYpuE3GNhY4Py8Ze6aST3ZQ1VZQBvG8u1Vh+LCzoUREimTH8i/A8ASu
 tY+8YsuIqreW5yyELsCXthe1IqDgqj1G1YKDpst/QzoUT0D9+Hhd0uDqmOgpEUf/BVka
 KVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698346719; x=1698951519;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5UQZBMZ3na+0lv17IT5bO3/rHRiLneXWEIHq1ys77U=;
 b=eBfJtDXVn39RhQpEzk7vm2/lHHc2LTpY3ZPaRTuK80XG83PYQxojpfLC/Vc7DIX8Cg
 HbATCukfqlj4+i+jUzCpCC3xPUGB15x9x1zFL5IYQiksuxHr5BqfNhqN3AlR+kLXGL+Z
 QuP1oKryOt/cUZdCtZDpUk1H68Zh9OBBSsn1n7TbSKZNRD51m6VZyyHhtyiStKrCL/5r
 u4S6U8HVAn1XaWJmUcYPZ/VTo+XCCuZgkeFIb6RYP9NShxvrgY09moLT6QSrakpb9knl
 qeVAeYothRwsOtVMLY1iLN3l8uMmCni7hJv2X+94uxq4Ll1855hnbEShM5pFuSQu27Og
 Smag==
X-Gm-Message-State: AOJu0YzforrLqErKH0q/Z1wrwDpFFd5E/C1K0U9pmmgCeL6bjc2HQkip
 rKB2M0XX4asWNLvyApNq1kQHS38mLbrtM6odYSnd3KHsMaydjs4r
X-Google-Smtp-Source: AGHT+IF2FW5OSEMrxwUfXUKJRdKAjDcPNHKU0ctJI/3laneIeMZlVWsWHQK9H5dTmGF7zFCfV7r9Naw452msvo3jeZE=
X-Received: by 2002:a19:771a:0:b0:507:9784:644c with SMTP id
 s26-20020a19771a000000b005079784644cmr232562lfc.26.1698346718959; Thu, 26 Oct
 2023 11:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
 <20231025065103.3101666-2-masahisa.kojima@linaro.org>
In-Reply-To: <20231025065103.3101666-2-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Oct 2023 21:58:03 +0300
Message-ID: <CAC_iWjJ2nNjLeJe201Nx1Uay2xqMgesZdzzsUOO8bpUe3_VXvw@mail.gmail.com>
Subject: Re: [PATCH 1/3] board: developerbox: remove obsolete NOR flash layout
 definition
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, jaswinder.singh@linaro.org, ryosuke.saito@linaro.org,
 sugimoto.yoshio@socionext.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 25 Oct 2023 at 09:52, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> There are two kinds of NOR flash layout for the Developerbox.
> Capsule update for the old layout is no longer available since
> it has small capacity for secure world images and can not
> house the TA such as fTPM.
> This commit removes the definition related to the obsolete
> NOR flash layout for the UEFI capsule update.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  include/configs/synquacer.h | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/include/configs/synquacer.h b/include/configs/synquacer.h
> index cd7359c2f8..e36e63e81e 100644
> --- a/include/configs/synquacer.h
> +++ b/include/configs/synquacer.h
> @@ -40,20 +40,6 @@
>
>  /* Since U-Boot 64bit PCIe support is limited, disable 64bit MMIO support */
>
> -#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
> -#define DEFAULT_DFU_ALT_INFO
> -#else
> -#define DEFAULT_DFU_ALT_INFO "dfu_alt_info="                           \
> -                       "mtd nor1=u-boot.bin raw 200000 100000;"        \
> -                       "fip.bin raw 180000 78000;"                     \
> -                       "optee.bin raw 500000 100000\0"
> -#endif

We don't need any of these because we use the .dfu_alt_string to
generate those right?

> -
> -/* GUIDs for capsule updatable firmware images */
> -#define DEVELOPERBOX_UBOOT_IMAGE_GUID \
> -       EFI_GUID(0x53a92e83, 0x4ef4, 0x473a, 0x8b, 0x0d, \
> -                0xb5, 0xd8, 0xc7, 0xb2, 0xd6, 0x00)
> -
>  #ifdef CONFIG_FWU_MULTI_BANK_UPDATE
>  #define DEVELOPERBOX_FIP_IMAGE_GUID \
>         EFI_GUID(0x7d6dc310, 0x52ca, 0x43b8, 0xb7, 0xb9, \
> @@ -64,10 +50,6 @@
>                  0x33, 0xe0, 0xb9, 0x16, 0xf3, 0x98)
>  #endif
>
> -#define DEVELOPERBOX_OPTEE_IMAGE_GUID \
> -       EFI_GUID(0xc1b629f1, 0xce0e, 0x4894, 0x82, 0xbf, \
> -                0xf0, 0xa3, 0x83, 0x87, 0xe6, 0x30)
> -
>  /* Distro boot settings */
>  #ifdef CONFIG_CMD_USB
>  #define BOOT_TARGET_DEVICE_USB(func)   func(USB, usb, 0)
> @@ -107,7 +89,6 @@
>         "ramdisk_addr_r=0xa0000000\0"           \
>         "scriptaddr=0x88000000\0"               \
>         "pxefile_addr_r=0x88100000\0"           \
> -       DEFAULT_DFU_ALT_INFO                    \
>         BOOTENV
>
>  #endif /* __CONFIG_H */
> --
> 2.34.1
>
Thanks
/Ilias
