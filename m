Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3B4C001DF
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 23:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F4A88710A;
	Fri, 20 Oct 2023 01:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u7lfd6dV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06D88718D; Fri, 20 Oct 2023 01:34:50 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F01F087025
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 01:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-565e54cb93aso164793a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697758486; x=1698363286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Hd/qKqG3gSSHW74Tw7rIcn+dTqFybn45C0ZKuRbOyU=;
 b=u7lfd6dVYVZsxUmHW3rARFU8y9ptYltLGZMgCxHsLVsxTfP5DhIg5AkL2YlgG+4+TL
 y3enapUtYCuIgokS/T2Wa/0q6v/afYeZ1drJY85AV3NrBUTQhsZIBGpvLGjZ4w27M0rC
 tGNw6cPxmy1GpuAB1D3iok6gM4Oc6VX6NkEVaCBPqb4eKd7DG8/vFF/aOBO8bOXRUh21
 JXVX82dh09uA4CfvvQ2/JfIZN3d0u4BsuwKPudgU5BaVhDuuiLzORZPFPUb3NgnnL7LX
 BE5kyjm1ZsqOab2xSV2z2Mb5wy5uPb9JZbg/N0Y4Tri+NqFocZRrQbV2VB7i8+drIOpg
 Q1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697758486; x=1698363286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Hd/qKqG3gSSHW74Tw7rIcn+dTqFybn45C0ZKuRbOyU=;
 b=dfNHSbfcFK/vRoQu5RMt9JRI15OjxEoN0kvdILU0OIWZWnaWJ66BE6des9ih6oAqNv
 bXmZVTT2ZPquQwj2Gw3j55GbEauzpQ1oBG5sCucV16fJc8piEjTTpiRxQJ0NQ+YVEc+R
 agJOVKv5hJ+U3Ph7TdJODLDQ8SNDsoNNNsggT4EZ1WtYyZrXn7pd87nEmg1yF/quxBa4
 Da2xJ8J2IycCeKGmqGuhP6Ue2JyBGzci/6N55YA2aaFgnuzybKVJs+WwyYUenncw8jSH
 wazFGlqXodY7WR7hWhkPgBqkCW6SHd9zCD2R9iCcvRYgpEdyQLTtqErwCEUeB85Pm4/i
 2DkA==
X-Gm-Message-State: AOJu0YwQ0mDPgajWU85p3474Smjd5z3wurmy5WmuSUsEOs7sBGlahcL6
 Bz4EsOiXYzZ6eAVtepCW51lOyk6fBR7cNpTmGu4sNw==
X-Google-Smtp-Source: AGHT+IEB5cvnn6kSxC6zMaEMMg45UKEFNxrmXswkXfyleDTRg42dE32BYmA5i+uVrRehBMCf/eUOM5EZhZaqk5d64To=
X-Received: by 2002:a17:90b:2b85:b0:27d:1339:9176 with SMTP id
 rs5-20020a17090b2b8500b0027d13399176mr355852pjb.25.1697758485979; Thu, 19 Oct
 2023 16:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231019135419.162726-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20231019135419.162726-1-ilias.apalodimas@linaro.org>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 20 Oct 2023 08:34:34 +0900
Message-ID: <CADQ0-X9BxxTqetEXjUBGQj17oKtxN9XG6qiw_ha85W-WgiPS_A@mail.gmail.com>
Subject: Re: [PATCH] board: synquacer: Update the flash image layout
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, ryosuke.saito@linaro.org, 
 Jassi Brar <jaswinder.singh@linaro.org>
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

On Thu, 19 Oct 2023 at 22:54, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The SynQuacer Developerbox, in EFI mode, supports A/B capsule
> updates and single image ones. The flash layout in the latter case is
> outdated, update it with the new offsets and images
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  board/socionext/developerbox/developerbox.c | 23 +--------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)

Tested-By: Masahisa Kojima <masahisa.kojima@linaro.org>

Thank you for fixing this issue.
I have tested both A/B multi-bank and single image(multi-bank
disabled) capsule updates work fine.

Thanks,
Masahisa Kojima

>
> diff --git a/board/socionext/developerbox/developerbox.c b/board/socionext/developerbox/developerbox.c
> index 9585944d80c1..ac4415ff3bbb 100644
> --- a/board/socionext/developerbox/developerbox.c
> +++ b/board/socionext/developerbox/developerbox.c
> @@ -20,39 +20,18 @@
>
>  #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>  struct efi_fw_image fw_images[] = {
> -#if CONFIG_IS_ENABLED(FWU_MULTI_BANK_UPDATE)
>         {
>                 .image_type_id = DEVELOPERBOX_FIP_IMAGE_GUID,
>                 .fw_name = u"DEVELOPERBOX-FIP",
>                 .image_index = 1,
>         },
> -#else
> -       {
> -               .image_type_id = DEVELOPERBOX_UBOOT_IMAGE_GUID,
> -               .fw_name = u"DEVELOPERBOX-UBOOT",
> -               .image_index = 1,
> -       },
> -       {
> -               .image_type_id = DEVELOPERBOX_FIP_IMAGE_GUID,
> -               .fw_name = u"DEVELOPERBOX-FIP",
> -               .image_index = 2,
> -       },
> -       {
> -               .image_type_id = DEVELOPERBOX_OPTEE_IMAGE_GUID,
> -               .fw_name = u"DEVELOPERBOX-OPTEE",
> -               .image_index = 3,
> -       },
> -#endif
>  };
>
>  struct efi_capsule_update_info update_info = {
> -       .dfu_string = "mtd nor1=u-boot.bin raw 200000 100000;"
> -                       "fip.bin raw 180000 78000;"
> -                       "optee.bin raw 500000 100000",
> +       .dfu_string = "mtd nor1=fip.bin raw 600000 400000",
>         .num_images = ARRAY_SIZE(fw_images),
>         .images = fw_images,
>  };
> -
>  #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>
>  static struct mm_region sc2a11_mem_map[] = {
> --
> 2.40.1
>
