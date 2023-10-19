Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE3CCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEA2D871C7;
	Thu, 19 Oct 2023 15:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JgyrBnG+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F81871BE; Thu, 19 Oct 2023 15:56:16 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A051D87196
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso12717220a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697723774; x=1698328574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vMBhQ4j3myuy3XLolQokK2xYnZ5x60TcZr42IQXJxW8=;
 b=JgyrBnG+SKKQiJCqk4HvjePq618e/oIZbu9pjQ6XrdqcTrUk8uOBwu0NtygATSm+Fc
 +6oE409Bzj1I2nT7IVfmsE2qBIsPFPs0Hx0ZGkBrG6HmYnIXoz6Yj1vYkYT65h4ltV3b
 pSpCVJ44/r1veyfDAuEUILAOxKbmQX1V7uIzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697723774; x=1698328574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vMBhQ4j3myuy3XLolQokK2xYnZ5x60TcZr42IQXJxW8=;
 b=MebkcMJarmX+ziSngOVGopmxa+X+yTCh4JFVW7MXeLUsN+mMcywAwvxSqMpz66rJMi
 /ZJuymW4ZC+6pp8acxvtjeBfwqEyAWFgf4u/X+Y89U6H9cDJw5lBd9/QKSYI30DP9Qso
 D5WAKmaPnzU3XUI/nZQIGH/rGSQUNbx89jWb//C49B/qNUmgWg+qqoLS+2sxn3kPnZd7
 CZ6picOQyiM4ZFrZxsC2Z/wM5TV3lja8afQgzNAj3Jq8xbAAMFztEAuPgdwqHu7mQWtV
 tCfRuStJk21xdkPiY88/3SbB43INWXL7vWQtHbvJNUIwxMrxd1qdFetwHg1oGctNh9RX
 EqLQ==
X-Gm-Message-State: AOJu0Yx5+Q0xLYyxH/YDZjGswFe3Je9tOcJo2xtPeuUSG1Rc+/qbhkR5
 vkJxr35yM7y8G9UXea8YzcPpoGdXE/iX1KHYYAHlPw==
X-Google-Smtp-Source: AGHT+IH9q/wBY0fkvt5MFcBVnOaZ+eUxMFnZItWSIMme/5IKN+anFQ+nG3g+aBUk8t8xWA4pGKeYNXX1IBKNgY5HPs8=
X-Received: by 2002:a50:9f67:0:b0:514:9ab4:3524 with SMTP id
 b94-20020a509f67000000b005149ab43524mr1792261edf.7.1697723774056; Thu, 19 Oct
 2023 06:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231016160611.1353458-1-devarsht@ti.com>
 <20231016160611.1353458-2-devarsht@ti.com>
In-Reply-To: <20231016160611.1353458-2-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Oct 2023 07:56:02 -0600
Message-ID: <CAPnjgZ1y1Strc7-qiDA6hG6sQaFKarYGaQZ1dGv_NSCyMbzK-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] arm: mach-k3: common: Reserve video memory from
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

On Mon, 16 Oct 2023 at 10:06, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Move the function to setup video memory before page table
> reservation so that framebuffer memory gets reserved from
> the end of RAM.
>
> This is as per the new policy being discussed for passing
> blobs where each of the reserved areas for bloblists
> to be passed need to be reserved at the end of RAM.
>
> This is to enable the next stage to directly skip
> the pre-reserved area from previous stage without
> having to making any gaps/holes to accomodate those
> regions which was the case if previous stage
> reserved region say somewhere in the middle and not at
> the end of RAM.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  arch/arm/mach-k3/common.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index cc755dd1bf..3978b9ccca 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -27,6 +27,7 @@
>  #include <env.h>
>  #include <elf.h>
>  #include <soc.h>
> +#include <video.h>
>
>  #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
>  enum {
> @@ -522,6 +523,24 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
>         }
>  }
>
> +static int video_setup(void)

Shouldn't this be in generic code?

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
>  void spl_enable_dcache(void)
>  {
>  #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
> @@ -537,6 +556,8 @@ void spl_enable_dcache(void)
>         if (ram_top >= 0x100000000)
>                 ram_top = (phys_addr_t) 0x100000000;
>
> +       gd->relocaddr = ram_top;
> +       video_setup();
>         gd->arch.tlb_addr = ram_top - gd->arch.tlb_size;
>         gd->arch.tlb_addr &= ~(0x10000 - 1);
>         debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
> --
> 2.34.1
>

Regards,
Simon
