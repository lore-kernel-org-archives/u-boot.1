Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5C7C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 13:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC43387C15;
	Fri, 26 Jan 2024 14:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YFTQbWPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FEB87C24; Fri, 26 Jan 2024 14:16:33 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFF6E87C15
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 14:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-510133ed214so621391e87.1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 05:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706274990; x=1706879790; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wuTIXULZHMFgnaSsQOJAiOlM1GXOKarmEf+CuOZSotk=;
 b=YFTQbWPQgC5gFe5qeXtrvW05BUGxxbXvd36qEYP95X40Vzbs72uxaRWusaMsSdJIVp
 ES2RdwRecGU/FKp2aK9tOxKNVKRTIx1I2B2/Tt5fUsNPNxZEMZ52/QXkNsabxGwIGJcY
 nchv72m/HNI/+9D4QTSoWl2Z9uzRcj9kS/tv7DWt3BqMnSgxsncUvvfP8x5kV9wElO4D
 006uQZYxgV2gVRNQPJcIcYu1Atn5VEY6Dh+1M3XM4YY5nyAXYKKJ6N3bgYc34i1yLUm3
 WyYnPtdR7v3CzibXM+HRtlbduyqZ4iwyoXsWpPQuZUWPQy0K7QUOOdjya4x1stUJXQ6z
 RSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706274990; x=1706879790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wuTIXULZHMFgnaSsQOJAiOlM1GXOKarmEf+CuOZSotk=;
 b=FZLY8RNdfqZC3K1Ldkho8TEf/khSDsYOGZPoEHmu6mnOSPleOEXoIFOBZaYGTCTQei
 I0qz0vPpHm/Ejak9vcbKKVyTXN8lH5Z4bXH6EDJp2k7kav+0ftauURzsjAq5onBpw2eR
 CiUCYpRDNrfL8zUfBP3Tut+p7mxSgewxpmBAiiVOljuCjrnJVNDKU6LvI3/5pU4yMLnL
 wKiTsDSlx4xLcuznbaV/irj6P5cWf9DhU/F1mZ7sNfmAohz/ZakF9yqQS8nTgL/H60OM
 1jU8Cmw9hWvk69yEAz+74kO9wZ7jaVClmMdpB8w4AQd8E0xP+VH198/XuWOgLqCa2pfh
 MtqQ==
X-Gm-Message-State: AOJu0Yww04TUugJQGpUevCnpVsOZ8UXheyipZyEEMk+WLWAUwjier9cz
 T0M1d0fcyUlBL6DJTqsfI8ttR7XTivOlFMSqgu/KvszWNeQGmreIVpkEWHxwPsBX/VsZZbJTljD
 9mskcvsuWlr9h3dFSnSBG1+cc2BLh6/Tx7/+7iQ==
X-Google-Smtp-Source: AGHT+IGOrDkof3z1iHTIg43Ot9RiO8GtWQi5t848rl7Ql4WCqKuBnCxI5iqVWEhBF8UOWuXiwQRW2sk7pBSSUBxm2SA=
X-Received: by 2002:ac2:48ba:0:b0:510:e07:81ad with SMTP id
 u26-20020ac248ba000000b005100e0781admr636363lfg.6.1706274990044; Fri, 26 Jan
 2024 05:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20240119151007.715348-1-raymond.mao@linaro.org>
 <20240119151007.715348-5-raymond.mao@linaro.org>
In-Reply-To: <20240119151007.715348-5-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Jan 2024 15:15:53 +0200
Message-ID: <CAC_iWjLfZn67xdb51-dMAZ2k3fPK83hQxGiHck1Oqw3QgGGV8w@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] arm: armv7: save boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Kevin Chen <kevin_chen@aspeedtech.com>, Sean Anderson <sean.anderson@seco.com>,
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
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

Hi Raymond

On Fri, 19 Jan 2024 at 17:12, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Save boot arguments r[0-3] into an array for handover of bloblist from
> previous boot stage.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
> Changes in v3
> - Swap value of r0 with r2.
> Changes in v4
> - Fix a bug when saving the boot args.
> Changes in V5
> - Drop the dependence on OF_BOARD.
> Changes in V7
> - Exclude the saved_args when BLOBLIST is disabled.
>
>  arch/arm/cpu/armv7/start.S | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> index 69e281b086..91691062c1 100644
> --- a/arch/arm/cpu/armv7/start.S
> +++ b/arch/arm/cpu/armv7/start.S
> @@ -152,9 +152,30 @@ ENDPROC(c_runtime_cpu_setup)
>   *
>   *************************************************************************/
>  WEAK(save_boot_params)
> +#if (IS_ENABLED(CONFIG_BLOBLIST))
> +       ldr r12, =saved_args
> +       /*
> +        * Intentionally swapping r0 with r2 in order to simplify the C
> +        * function we use later.
> +        */
> +       str r2, [r12]
> +       str r1, [r12, #4]
> +       str r0, [r12, #8]
> +       str r3, [r12, #12]
> +#endif
>         b       save_boot_params_ret            @ back to my caller
>  ENDPROC(save_boot_params)
>
> +#if (IS_ENABLED(CONFIG_BLOBLIST))
> +.section .data

saved_args needs to be aligned.
Also, the literal pool entry for saved_args will contain an absolute
address. Does this code run before or after relocation?

Thanks
/Ilias
> +.global saved_args
> +saved_args:
> +       .rept 4
> +       .word 0
> +       .endr
> +END(saved_args)
> +#endif
> +
>  #ifdef CONFIG_ARMV7_LPAE
>  WEAK(switch_to_hypervisor)
>         b       switch_to_hypervisor_ret
> --
> 2.25.1
>
