Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366A5C27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 08:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF988813F;
	Mon, 10 Jun 2024 10:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SolLnGZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24152884A9; Mon, 10 Jun 2024 10:55:20 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB48D85B66
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70599522368so397410b3a.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718009716; x=1718614516; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PuUZYaeNsuCBr0lgw5rU7kZKE+PowaB6GVLVPdfHSNk=;
 b=SolLnGZayGXiKgt9p8XCphGMxV8lExLiPJ6Z87nPpsEjQXJHxLC3x5w5KhHMnXuNCx
 g/23adO99IjPySugK5/g8RkSCMzBT/o3HO/0uhyBVYHXZMWN2vcNAPEOh2eQW1yQrgXG
 +ELdllsWWkOe2A81me8Kp7xTGqbu0xMI+hZK5aBTTRcwnaz8B17zuk4B0ndMteNXnraC
 2WvDgyzqxYyTC3zaUsICiN+Il2VeGaW/b4vlJLeVAVnA2rtlVgK2Ra3kIErTl8be8anj
 ouaffI5nqmw3SxlkXCDzqx9r+87DzUXqBe7Nkjm8FKltIC0DV3ujeeiDaxeOAfnjCHaZ
 TTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718009716; x=1718614516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuUZYaeNsuCBr0lgw5rU7kZKE+PowaB6GVLVPdfHSNk=;
 b=Dm8fpLPY8Vpx26pfe6vg5Q8S3Etyi5WHm3vIUw6QFfoNuod3JCxBI3TglMMWcuOpSm
 TUSqu/QnUck1sMwYv96ymQF1yLFQyk4PRgIYzcY61A31UZoRI1WyT8IkyOgMqkXHkPVr
 jrkSIA9/5/YpNxCpYL1SFnZO2BavE5bHuF/HitkCFtpJT1ARf2ZDToA95cjjmNOdDuwP
 bjQ+Qj9ENlkO7Cu5kiFmsCcX6TjWv5BR4S5+sUaBRWEfuF/BSZ6kZ3VIMd06cCqnWBkW
 9iZlvN+YiXCYsDHMvCJNIuNDZgr2vnUR1YbS03AFcidEy3KitOLYYUJTU+ohFhxQ4fVO
 jkxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA48rfIwqcV56CEuqS6dNhfTZlo9XfISE20256zbiT/ev/6HW4AUNoli/f3puFkTLGmx28Wjakqq4bDTbh8OZoH5PyLQ==
X-Gm-Message-State: AOJu0Yync47VmYDCfGRqxJLOAJgisFVAgYO7eMf5X21srCU9WAka49s9
 jAiy6jp4eUYYy82gJMacmSSweJ+ifCb6Jucl+gAj+7cEiZryL3jsc/j5yUFtW1A3RGDkQzqciov
 negjFnRmYgmiHLWpnd0Nv4NIXA15gmNLsU3E3NA==
X-Google-Smtp-Source: AGHT+IEfcFdu2DKKqsxKH4dO68fFHtnrVcUarK5YaSAkJDAGUgb6IeWX9kunV3UgkHUz68zGdSh738kqeG7aa/YK/4E=
X-Received: by 2002:a05:6a21:190:b0:1b5:d36a:5d6e with SMTP id
 adf61e73a8af0-1b5d36a5e69mr4003207637.43.1718009716219; Mon, 10 Jun 2024
 01:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240607223858.1971290-1-j-humphreys@ti.com>
 <20240607223858.1971290-17-j-humphreys@ti.com>
In-Reply-To: <20240607223858.1971290-17-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 11:54:39 +0300
Message-ID: <CAC_iWj+bxKR1f1cFjhHu5+g=u7zccw7oLLJN637D7M1eNE77dg@mail.gmail.com>
Subject: Re: [PATCH v6 16/24] board: am62px: Define capsule update firmware
 info
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Judith Mendez <jm@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
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

On Sat, 8 Jun 2024 at 01:39, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>
> Define the firmware components updatable via EFI capsule update, including
> defining capsule GUIDs for the various firmware components for the AM62px
> SK.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  board/ti/am62px/evm.c        | 34 ++++++++++++++++++++++++++++++++++
>  include/configs/am62px_evm.h | 24 ++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
> index 97a95ce8cc2..1a2c46c462b 100644
> --- a/board/ti/am62px/evm.c
> +++ b/board/ti/am62px/evm.c
> @@ -6,6 +6,7 @@
>   *
>   */
>
> +#include <efi_loader.h>
>  #include <asm/arch/hardware.h>
>  #include <asm/io.h>
>  #include <dm/uclass.h>
> @@ -13,6 +14,39 @@
>  #include <fdt_support.h>
>  #include <spl.h>
>
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .image_type_id = AM62PX_SK_TIBOOT3_IMAGE_GUID,
> +               .fw_name = u"AM62PX_SK_TIBOOT3",
> +               .image_index = 1,
> +       },
> +       {
> +               .image_type_id = AM62PX_SK_SPL_IMAGE_GUID,
> +               .fw_name = u"AM62PX_SK_SPL",
> +               .image_index = 2,
> +       },
> +       {
> +               .image_type_id = AM62PX_SK_UBOOT_IMAGE_GUID,
> +               .fw_name = u"AM62PX_SK_UBOOT",
> +               .image_index = 3,
> +       }
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;"
> +       "tispl.bin raw 80000 200000;u-boot.img raw 280000 400000",
> +       .num_images = ARRAY_SIZE(fw_images),
> +       .images = fw_images,
> +};
> +
> +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> +void set_dfu_alt_info(char *interface, char *devstr)
> +{
> +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +               env_set("dfu_alt_info", update_info.dfu_string);
> +}
> +#endif
> +
>  int board_init(void)
>  {
>         return 0;
> diff --git a/include/configs/am62px_evm.h b/include/configs/am62px_evm.h
> index 06b12860e21..57a1ba9dc3c 100644
> --- a/include/configs/am62px_evm.h
> +++ b/include/configs/am62px_evm.h
> @@ -8,6 +8,30 @@
>  #ifndef __CONFIG_AM62PX_EVM_H
>  #define __CONFIG_AM62PX_EVM_H
>
> +/**
> + * define AM62PX_SK_TIBOOT3_IMAGE_GUID - firmware GUID for AM62PX sk tiboot3.bin
> + * define AM62PX_SK_SPL_IMAGE_GUID     - firmware GUID for AM62PX sk SPL
> + * define AM62PX_SK_UBOOT_IMAGE_GUID   - firmware GUID for AM62PX sk UBOOT
> + *
> + * These GUIDs are used in capsules updates to identify the corresponding
> + * firmware object.
> + *
> + * Board developers using this as a starting reference should
> + * define their own GUIDs to ensure that firmware repositories (like
> + * LVFS) do not confuse them.
> + */
> +#define AM62PX_SK_TIBOOT3_IMAGE_GUID \
> +       EFI_GUID(0xb08471b7, 0xbe2d, 0x4489, 0x87, 0xa1, \
> +               0xca, 0xb2, 0x8a, 0x0c, 0xf7, 0x43)
> +
> +#define AM62PX_SK_SPL_IMAGE_GUID \
> +       EFI_GUID(0xd02ed781, 0x6d71, 0x4c1a, 0xa9, 0x99, \
> +               0x3c, 0x6a, 0x41, 0xc3, 0x63, 0x24)
> +
> +#define AM62PX_SK_UBOOT_IMAGE_GUID \
> +       EFI_GUID(0x7e6aea51, 0x965c, 0x44ab, 0xb3, 0x88, \
> +               0xda, 0xeb, 0x03, 0xb5, 0x4f, 0x66)
> +
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>
>
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
