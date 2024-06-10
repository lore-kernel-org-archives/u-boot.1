Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F38C27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 08:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31AB088413;
	Mon, 10 Jun 2024 10:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RJD0WArY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5025E88431; Mon, 10 Jun 2024 10:49:34 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F27B5882ED
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f68834bfdfso30640115ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718009370; x=1718614170; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qPcCOBxZfzK0DLpt51JRx5qf198Al7hD9M9DFakPsAQ=;
 b=RJD0WArYWWzwlTvFPdQuzRYksHPyHoX5BOKFbTyXOcDOCkYYYZeRvdzpkS9ll6DKOB
 hci9Nev4srCYffKWOegGwtKkm/UhKjU+GuS8UFDveXYPMn1DzWAOdQbdQH56GPl5WTqs
 GCLNCPOiSSOKSsrv/EsejDYPjBtIvXGmv7+LpnnCyNhYoeTl/7yay3jyt2ttBnwaRyte
 YLwpWD87bYiamV0xHxrp/rUNjhUl8cKlC0ZEepRYqtGo77ZXmPYmkK1k9Hn2R2eDQxaQ
 zb3uqvq9+LM/msSrScLT8KuaXq5KfF0HPeU6CZg5OKwuKhgYWAZGBBia/h9ZX2lmGfE3
 UCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718009370; x=1718614170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qPcCOBxZfzK0DLpt51JRx5qf198Al7hD9M9DFakPsAQ=;
 b=L3yQp+x1isJ8imihdwcBl5br0bgYntGZ6J6AXyVvtzsrz5TcHkc/1k+OURHBVUDC+l
 C+wTr/vs8L1zaeOjzmuvBOFeXyT1ELrsJwEYQ0qx/H/YMvlXFnGtYe3lJszRmmDyk/f5
 g3m3XX8bFdN62SFAAur6BjWDeX9XrVtvv6zJtkvOFdhRRmKWmf8caljCn6xuRivV7yQN
 WzAYtJOKoqW3kLYbe4zihfCR4yuQFM0ON2QiDd1r2m590opKHi7/8PgTkdzaLHFc5qzw
 9Y7ZeWL7/pGLdRdqUOfOrKxiCjNRi7RFN5/IJdnz9KWJBwi+3ohv77wncheB7GjbkU29
 ks5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW09oVo0QhltsMpFBRPsP6vHPQB9gfpAck2c7MEfWdMuIihM3ktDbq8P8+/7qywH+iE3bh5S/p2skRxtxS8VhnvhqYFsg==
X-Gm-Message-State: AOJu0YzQYz/ojvoYxbtPEnopwQhvXC/Z+m0sRyYVJiwOIHwYcLbnTKGJ
 f+Ep/3lnQGBusy01awpKvAZ4De369ifXReQcRqyr7g2XCL3JNCT79m0dN96baS4FM/cYtrJlEgz
 9lWByqwXfn6Ii7C7FUiikdKwUVGjOlKJ6Z/aDQA==
X-Google-Smtp-Source: AGHT+IGvtsQQndhk8bsnTjsGJOU7b3SpY7TgeH2tLJrKwJeWplQPblFPqVnaPoxKe4mBWVfsCuk1LCWmxoMCn46fZuo=
X-Received: by 2002:a17:902:cf04:b0:1f6:f5bc:51c5 with SMTP id
 d9443c01a7336-1f6f5bc5391mr56183615ad.47.1718009370355; Mon, 10 Jun 2024
 01:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240607223858.1971290-1-j-humphreys@ti.com>
 <20240607223858.1971290-8-j-humphreys@ti.com>
In-Reply-To: <20240607223858.1971290-8-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 11:48:53 +0300
Message-ID: <CAC_iWjJhmOaS4UrFXMsRDhTGpEtQqDPSz6HwqeREwfVyO3Vx3w@mail.gmail.com>
Subject: Re: [PATCH v6 07/24] board: j721e: Define capsule update firmware info
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
> defining capsule GUIDs for the various firmware components for the
> SK-TDA4VM.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  board/ti/j721e/evm.c        | 40 +++++++++++++++++++++++++++++++++++++
>  include/configs/j721e_evm.h | 29 +++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 539eaf47186..f3452ff0a8f 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -7,6 +7,7 @@
>   *
>   */
>
> +#include <efi_loader.h>
>  #include <generic-phy.h>
>  #include <image.h>
>  #include <net.h>
> @@ -32,6 +33,45 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .image_type_id = J721E_SK_TIBOOT3_IMAGE_GUID,
> +               .fw_name = u"J721E_SK_TIBOOT3",
> +               .image_index = 1,
> +       },
> +       {
> +               .image_type_id = J721E_SK_SPL_IMAGE_GUID,
> +               .fw_name = u"J721E_SK_SPL",
> +               .image_index = 2,
> +       },
> +       {
> +               .image_type_id = J721E_SK_UBOOT_IMAGE_GUID,
> +               .fw_name = u"J721E_SK_UBOOT",
> +               .image_index = 3,
> +       },
> +       {
> +               .image_type_id = J721E_SK_SYSFW_IMAGE_GUID,
> +               .fw_name = u"J721E_SK_SYSFW",
> +               .image_index = 4,
> +       }
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;"
> +       "tispl.bin raw 80000 200000;u-boot.img raw 280000 400000;"
> +       "sysfw.itb raw 6C0000 100000",
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
> diff --git a/include/configs/j721e_evm.h b/include/configs/j721e_evm.h
> index c26438c8684..a5140ea6a11 100644
> --- a/include/configs/j721e_evm.h
> +++ b/include/configs/j721e_evm.h
> @@ -22,6 +22,35 @@
>  #define CFG_SYS_UBOOT_BASE             0x50080000
>  #endif
>
> +/**
> + * define J721E_SK_TIBOOT3_IMAGE_GUID - firmware GUID for J721e sk tiboot3.bin
> + * define J721E_SK_SPL_IMAGE_GUID     - firmware GUID for J721e sk SPL
> + * define J721E_SK_UBOOT_IMAGE_GUID   - firmware GUID for J721e sk UBOOT
> + * define J721E_SK_SYSFW_IMAGE_GUID   - firmware GUID for J721e sk SYSFW
> + *
> + * These GUIDs are used in capsules updates to identify the corresponding
> + * firmware object.
> + *
> + * Board developers using this as a starting reference should
> + * define their own GUIDs to ensure that firmware repositories (like
> + * LVFS) do not confuse them.
> + */
> +#define J721E_SK_TIBOOT3_IMAGE_GUID \
> +       EFI_GUID(0xe672b518, 0x7cd7, 0x4014, 0xbd, 0x8d, \
> +                0x40, 0x72, 0x4d, 0x0a, 0xd4, 0xdc)
> +
> +#define J721E_SK_SPL_IMAGE_GUID \
> +       EFI_GUID(0x86f710ad, 0x10cf, 0x46ea, 0xac, 0x67, \
> +                0x85, 0x6a, 0xe0, 0x6e, 0xfa, 0xd2)
> +
> +#define J721E_SK_UBOOT_IMAGE_GUID \
> +       EFI_GUID(0x81b58fb0, 0x3b00, 0x4add, 0xa2, 0x0a, \
> +                0xc1, 0x85, 0xbb, 0xac, 0xa1, 0xed)
> +
> +#define J721E_SK_SYSFW_IMAGE_GUID \
> +       EFI_GUID(0x6fd10680, 0x361b, 0x431f, 0x80, 0xaa, \
> +                0x89, 0x94, 0x55, 0x81, 0x9e, 0x11)
> +
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>
>
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
