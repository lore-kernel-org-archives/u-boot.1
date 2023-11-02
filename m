Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0964C4167B
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E4A874B7;
	Thu,  2 Nov 2023 23:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PGCd/LAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74094875B5; Thu,  2 Nov 2023 23:46:27 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B772F87489
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so2495740a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965180; x=1699569980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BamMOqmFcGiIgEiy3N1QvZJLWrpRqXsQHgBNFl3sphg=;
 b=PGCd/LAVG3taDEjkS+RB3BCscI6XGVOqgFcyke78hPycZ8rcCe4HI9PKWC72AcCkyq
 oZx8Mo2jN87gB5LbGIHOvxXILHz2PX89ky3zgnzu1P7CYHinQ+HW2mpOIPGOp3ngzGQL
 k11jrs/5Tva8yyISfwhdSJQubB2bXb+EztaZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965180; x=1699569980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BamMOqmFcGiIgEiy3N1QvZJLWrpRqXsQHgBNFl3sphg=;
 b=tQf0gNMQp4yHXklUm9O9MoEh2+pH2Jyb3FOOdHZ3SWcKjlFlQgrOmNZvfXyrWjw42U
 t/pDu3zdtsP8ycy6j9oZOpAeggHonqyeYenUKnzeFJmheIO3H3wBHkepw1NYPDjA36Jb
 Rrv26hF5Rp8JMPqa+LEJ4aJI62opkqQ7qytAXAbnhpW5lgH3TxSQAaNG+xH3UeCNc9WS
 EdmaXZeqAJgApkEhYz9QSc2oN8/VqGnqocOipLDHpLbqdXsRN4yUqs0qFhyf+6cMlSAI
 Y/yCzLVAb9+ZDOEGxEAAAhsADsxTcERHTU5UARGTOo7feJ+g8prulmh/WzwC1t0i4SWD
 OXvg==
X-Gm-Message-State: AOJu0YxwW6M2q70k3DMHYDNUDZ3lcXWBUx37BnYAJVhNRtbR0uH6Ir96
 GyqWbas7TASlLItpi6d8+uRbRdJR6jodP3rLwso0vw==
X-Google-Smtp-Source: AGHT+IHOyH20u8Xli2Whb4rUxssKR4a7mDHqLzibI8omX+kDVEMtka5T3nt3JQ6kGjcHTWVEKIJzvTTkbCSlPB3HIhw=
X-Received: by 2002:a50:d482:0:b0:543:7706:af82 with SMTP id
 s2-20020a50d482000000b005437706af82mr7018115edi.32.1698965180103; Thu, 02 Nov
 2023 15:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231031131208.435268-1-devarsht@ti.com>
 <20231031131208.435268-2-devarsht@ti.com>
In-Reply-To: <20231031131208.435268-2-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Nov 2023 22:46:06 +0000
Message-ID: <CAPnjgZ3U_HDUfm+GBDSm44FZFx7n5nrZbM3gHHYkyYj7P2582w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm: mach-k3: common: Reserve video memory from
 end of the RAM
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

Hi Devarsh,

On Tue, 31 Oct 2023 at 13:12, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Add function spl_reserve_video which is a wrapper
> around video_reserve to setup video memory and update
> the relocation address pointer.
>
> Setup video memory before page table reservation so that
> framebuffer memory gets reserved from the end of RAM.
>
> This is as per the new policy being discussed for passing
> blobs where each of the reserved areas for bloblists
> to be passed need to be reserved at the end of RAM.
>
> This is done to enable the next stage to directly skip
> the pre-reserved area from previous stage right from the end of RAM
> without having to make any gaps/holes to accommodate those
> regions which was the case before as previous stage
> reserved region not from the end of RAM.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2: Make a generic function "spl_reserve_video" under
>     common/spl which can be re-used by other platforms too
>     for reserving video memory from spl.
> ---
>  arch/arm/mach-k3/common.c |  2 ++
>  common/spl/spl.c          | 19 +++++++++++++++++++
>  include/spl.h             |  4 ++++
>  3 files changed, 25 insertions(+)

>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index c3006ba387..03e3b46282 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -537,6 +537,8 @@ void spl_enable_dcache(void)
>         if (ram_top >= 0x100000000)
>                 ram_top = (phys_addr_t) 0x100000000;
>
> +       gd->relocaddr = ram_top;
> +       spl_reserve_video();

Need to check error here

>         gd->arch.tlb_addr = ram_top - gd->arch.tlb_size;
>         gd->arch.tlb_addr &= ~(0x10000 - 1);
>         debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 732d90d39e..89172f2ebf 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -41,6 +41,7 @@
>  #include <fdt_support.h>
>  #include <bootcount.h>
>  #include <wdt.h>
> +#include <video.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>  DECLARE_BINMAN_MAGIC_SYM;
> @@ -151,6 +152,24 @@ void spl_fixup_fdt(void *fdt_blob)
>  #endif
>  }
>
> +int spl_reserve_video(void)
> +{
> +       if (CONFIG_IS_ENABLED(VIDEO)) {
> +               ulong addr;
> +               int ret;
> +
> +               addr = gd->relocaddr;
> +               ret = video_reserve(&addr);
> +               if (ret)
> +                       return ret;
> +               debug("Reserving %luk for video at: %08lx\n",
> +                     ((unsigned long)gd->relocaddr - addr) >> 10, addr);
> +               gd->relocaddr = addr;
> +       }
> +
> +       return 0;
> +}
> +
>  ulong spl_get_image_pos(void)
>  {
>         if (!CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS))
> diff --git a/include/spl.h b/include/spl.h
> index 0d49e4a454..9682e51fc1 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -825,6 +825,10 @@ int spl_usb_load(struct spl_image_info *spl_image,
>
>  int spl_ymodem_load_image(struct spl_image_info *spl_image,
>                           struct spl_boot_device *bootdev);
> +/**
> + * spl_reserve_video() - Reserve video and update relocation address

This needs more detail about:
- gd->relocaddr
- where the video memory is allocated
- where the allocation is stored (in the video-device plat?)
- return value

> + */
> +int spl_reserve_video(void);
>
>  /**
>   * spl_invoke_atf - boot using an ARM trusted firmware image
> --
> 2.34.1
>

Regards,
Simon
