Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B17DEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0678649A;
	Wed, 23 Aug 2023 15:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fN0fBShv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D0B864AD; Wed, 23 Aug 2023 15:36:19 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9353E86480
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5256d74dab9so6985200a12.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692797776; x=1693402576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ae7jw3tWfaVuZGn6nbI4kooxPB5oSD9pVFDOKAk4XC0=;
 b=fN0fBShvNfSh4M5T2/SwQpktlZzrWxQMvRHG48Ot6m3/v7SrPdNIvR3njtshMLmo0o
 SXqLfLqVysJdijv7z/Ud7A74F84i1eTqQwyYTHTAWSY5/2DQQdgu1GY/wJxRHsiUjs5a
 Rplddiq+rvUGickSSHUTBG/cNDomrwvXboBYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692797776; x=1693402576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ae7jw3tWfaVuZGn6nbI4kooxPB5oSD9pVFDOKAk4XC0=;
 b=lQj8EIRvVoWZsO89euzk1Xz9Sz3QHLUFd6gM9TcKVoljtS8wl+fuxGkEpjZT66/+bY
 N/OSN10BVJrJh4HFwZ71oQCyd8KFLOVx/Ex54zeiyS5HPYtnehRQ0WxHNtbdn2C6e3x+
 0j++FAvEFlAqLPWisQHIhrNQDqNfe4yJISBMrqCgAPSvAE3jv2EGSBYm8ovlHYV0rUj/
 vUi6Q0JDVXdbRvsmCYZGCAmXRF+T+rQB2L4BXT/OBrCDUNplwMnHC6kgNrvX/ZEUAwDO
 qrLlD9bfofIhaHr7z6uB9kux/B1vwnyACQhaFPl5mYa1Cp2uVAPkBQ0LVaxq/vphPR9H
 a6ww==
X-Gm-Message-State: AOJu0YyupPRoecaVrCAg+rQMiXoePNgvl0XhKXn1udxlLoW90jOIICBH
 UuFVrFFa5Oc/hZRlLOpAcZRg4ymynvX8SdNZ/Kl1fIR5mFrC/lWY3hw=
X-Google-Smtp-Source: AGHT+IGD/pxphvFTRtvCgNlEIKvhk3QZF2IxV7ASnMDFDAw3mGWOfhdvaxBtNieAffIbma/LNIr0uRELesSM1ns0K0A=
X-Received: by 2002:a05:6402:2039:b0:522:c0ea:15f with SMTP id
 ay25-20020a056402203900b00522c0ea015fmr8985322edb.41.1692797775961; Wed, 23
 Aug 2023 06:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230818052645epcas2p3df52c8522cd903f869d366fed46ea89d@epcas2p3.samsung.com>
 <20230818051103.2427590-1-chanho61.park@samsung.com>
 <20230818051103.2427590-3-chanho61.park@samsung.com>
In-Reply-To: <20230818051103.2427590-3-chanho61.park@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 07:36:04 -0600
Message-ID: <CAPnjgZ0nE6mPDeTXb=7G5RM+o++iK6+uvVtGKT2f2miheOPxLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: cpu: make riscv_cpu_probe to
 EVT_DM_POST_INIT_R callback
To: Chanho Park <chanho61.park@samsung.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
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

On Thu, 17 Aug 2023 at 23:26, Chanho Park <chanho61.park@samsung.com> wrote:
>
> Since the Patch 55171aedda88, VisionFive2 booting has been broken [1].
> VisionFive2 board requires to enable CONFIG_TIMER_EARLY but booting went
> to panic from initr_dm_devices due to lack of a timer device.
>
> - Error logs
> initcall sequence 00000000fffd8d38 failed at call 00000000402185e4
> (err=-19)
>
> Thus, we need to move riscv_cpu_probe function in order to register
> the timer earlier than initr_dm_devices.
>
> Fixes: 7fe32b3442f0 ("event: Convert arch_cpu_init_dm() to use events")
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  arch/riscv/cpu/cpu.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Applied to u-boot-dm, thanks!



>
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index ecfb1fb08c4b..0b4208e72199 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
>  #endif /* CONFIG_CPU */
>  }
>
> -static int riscv_cpu_probe(void)
> +static int riscv_cpu_probe(void *ctx, struct event *event)
>  {
>  #ifdef CONFIG_CPU
>         int ret;
> @@ -79,6 +79,7 @@ static int riscv_cpu_probe(void)
>
>         return 0;
>  }
> +EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
>
>  /*
>   * This is called on secondary harts just after the IPI is init'd. Currently
> @@ -95,7 +96,7 @@ int riscv_cpu_setup(void *ctx, struct event *event)
>  {
>         int ret;
>
> -       ret = riscv_cpu_probe();
> +       ret = riscv_cpu_probe(ctx, event);
>         if (ret)
>                 return ret;
>
> @@ -149,12 +150,6 @@ EVENT_SPY(EVT_DM_POST_INIT_F, riscv_cpu_setup);
>
>  int arch_early_init_r(void)
>  {
> -       int ret;
> -
> -       ret = riscv_cpu_probe();
> -       if (ret)
> -               return ret;
> -
>         if (IS_ENABLED(CONFIG_SYSRESET_SBI))
>                 device_bind_driver(gd->dm_root, "sbi-sysreset",
>                                    "sbi-sysreset", NULL);
> --
> 2.39.2
>
