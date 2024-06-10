Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCD5C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 08:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8438844F;
	Mon, 10 Jun 2024 10:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pF/sLiA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E078812B; Mon, 10 Jun 2024 10:52:50 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5753188476
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso34636775ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718009567; x=1718614367; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nfgx++IdmDkV9q28M5fUuoocaiEU5XkCeMBi3+tu7/8=;
 b=pF/sLiA9IgUdw8qRNvtTjokvVAFPhNNvyGlWCOvP3Dn+D061ugMT+5yMaVVcUQNL71
 Sd6c04ItxnIcFc7Ksh0Q0dHP9MODEIBUv3RHtc3eJccGUo9QweDgcGepGN46uFmVx+SV
 xRLCdFlCMjrVS2uS9mKMdPQI5OnxPLHWcaPNMSCJB0mKH89QUt1WCMNoY4nm1HFcX/gg
 MI4xl53bQBK2Umr1X/NPNtetbEtHhmvI/tb1IuqiinqPgjKX5cT4cKfJx98DEMVwim3u
 hQJNmVZLqdbOawmIfpYKVzz/1l1wXPWEEOONWxWMwVg4buKP41uX4APTclOuE85ixW2e
 dIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718009567; x=1718614367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nfgx++IdmDkV9q28M5fUuoocaiEU5XkCeMBi3+tu7/8=;
 b=giq/dJHSIvQkGczMq6mE0yz6iBZstmm/aCd60oNkDlxiCqKyHb4GwJ58TGxLg2L/91
 RsyPMDavinGNcyUaFEzOah7avsTVLH38nhYZ+9QnWrQyxhMlIZxDQOEtJAd9RdCBghsF
 ZF6oxmKhgd4LDD90YPZSv0qLKi6ROdd5h7xli2MYdYQgJ1v3H4P9X49IbNukitr0fJtz
 3l7SuqGJQJ7d6iZxSgoHSqRA2zmY3x7KIovZf2qZ9rkyx+seImfP2orTqv4j9IFfSCnH
 OF1dWVV3eWJZkRgSvd0fmM5lijjIwSV6K+oqMF5lpYMZluYvubtKzj9Z+wYDQX3cIhsI
 5rcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdnhaHsAvVW+qi1iFrQrwUB+JpRWZhDqDLfePrOSxLQBnrmW54W2iWIvtO28lzSPLR1GTDDngXIyacWrweQLm6g2BTQg==
X-Gm-Message-State: AOJu0YxvQbgbhKU1uNfut9pLoy9goI85VWbZwDHVtbHNg4bvHRC6T6k7
 hs37KnWO74t1E9KEIhtNx+5FOZOk6QM9BPaeDEtZJvAwZkNvncY0fGNnRv4nHQv+2S/tn5/ENut
 JnzPJ+VstmNFYHpMLcCk6ta92Eg07g8P7AQc3HQ==
X-Google-Smtp-Source: AGHT+IHfOjwt8A5qQMH376riIw8RJEBtDBoRSHAmMGpuGzABlitK9Jcn0d299eh2bYAflcsSUK+uySvR3qSBMRY5hHk=
X-Received: by 2002:a17:903:230c:b0:1f7:2134:e8a4 with SMTP id
 d9443c01a7336-1f72134eaeamr2225525ad.49.1718009566801; Mon, 10 Jun 2024
 01:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240607223858.1971290-1-j-humphreys@ti.com>
 <20240607223858.1971290-14-j-humphreys@ti.com>
In-Reply-To: <20240607223858.1971290-14-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 11:52:10 +0300
Message-ID: <CAC_iWj+HiuTJKX2PND07p6uHU+K7-0vBTFX_+i=6Pg74DK2uVA@mail.gmail.com>
Subject: Re: [PATCH v6 13/24] board: am62x: Define capsule update firmware info
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
> defining capsule GUIDs for the various firmware components for the AM62x
> SK.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  board/ti/am62x/evm.c        | 34 ++++++++++++++++++++++++++++++++++
>  include/configs/am62x_evm.h | 24 ++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index b3e8680dfab..9bdd0223cdb 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -7,6 +7,7 @@
>   *
>   */
>
> +#include <efi_loader.h>
>  #include <env.h>
>  #include <spl.h>
>  #include <init.h>
> @@ -46,6 +47,39 @@ int splash_screen_prepare(void)
>  }
>  #endif
>
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .image_type_id = AM62X_SK_TIBOOT3_IMAGE_GUID,
> +               .fw_name = u"AM62X_SK_TIBOOT3",
> +               .image_index = 1,
> +       },
> +       {
> +               .image_type_id = AM62X_SK_SPL_IMAGE_GUID,
> +               .fw_name = u"AM62X_SK_SPL",
> +               .image_index = 2,
> +       },
> +       {
> +               .image_type_id = AM62X_SK_UBOOT_IMAGE_GUID,
> +               .fw_name = u"AM62X_SK_UBOOT",
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
> diff --git a/include/configs/am62x_evm.h b/include/configs/am62x_evm.h
> index c8fe59b7531..0d98f14a4bc 100644
> --- a/include/configs/am62x_evm.h
> +++ b/include/configs/am62x_evm.h
> @@ -9,6 +9,30 @@
>  #ifndef __CONFIG_AM625_EVM_H
>  #define __CONFIG_AM625_EVM_H
>
> +/**
> + * define AM62X_SK_TIBOOT3_IMAGE_GUID - firmware GUID for AM62X sk tiboot3.bin
> + * define AM62X_SK_SPL_IMAGE_GUID     - firmware GUID for AM62X sk SPL
> + * define AM62X_SK_UBOOT_IMAGE_GUID   - firmware GUID for AM62X sk UBOOT
> + *
> + * These GUIDs are used in capsules updates to identify the corresponding
> + * firmware object.
> + *
> + * Board developers using this as a starting reference should
> + * define their own GUIDs to ensure that firmware repositories (like
> + * LVFS) do not confuse them.
> + */
> +#define AM62X_SK_TIBOOT3_IMAGE_GUID \
> +       EFI_GUID(0xabcb83d2, 0x9cb6, 0x4351, 0xb8, 0xf1, \
> +               0x64, 0x94, 0xbb, 0xe3, 0x70, 0x0a)
> +
> +#define AM62X_SK_SPL_IMAGE_GUID \
> +       EFI_GUID(0xaee355fc, 0xbf97, 0x4264, 0x8c, 0x82, \
> +               0x43, 0x72, 0x55, 0xef, 0xdc, 0x1d)
> +
> +#define AM62X_SK_UBOOT_IMAGE_GUID \
> +       EFI_GUID(0x28ab8c6c, 0xfca8, 0x41d3, 0x8e, 0xa1, \
> +               0x5f, 0x17, 0x1b, 0x7d, 0x29, 0x29)
> +
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>
>
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
