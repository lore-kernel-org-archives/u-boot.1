Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959C2C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 07:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE40386FB2;
	Fri, 23 Feb 2024 08:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e3yecRhS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213BA876D3; Fri, 23 Feb 2024 08:05:04 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A841F80EED
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 08:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d208be133bso8127131fa.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708671857; x=1709276657; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v57OTTK+poX6sNUPEDs2NuVKTa5kvYBNtQUoSnze0sA=;
 b=e3yecRhSwOhMB757+pNFt57LIyzyAsjhqsoJBc4nskVLtNDJkYN0WppfIts5Iqy5ZH
 ck5p8WiU3nBXda0gH8pxZwQGtml4pN4hQAwdKXAE4Ngjz3HaiUoA5Csizvb0ZLtgeH8d
 ST8Y8NBNtzoGcmXrQJL//qSTmQw7+WUNxUA85WJKZnDSQ5+cbGtBAcDRba+ESB2Z3Iyu
 iMsT43hDH+S6TRUV/FqC6JmPA/QrM0YigXCzid93pgTBhYpW+T3EzADcooTuBo8WszFJ
 Qyn5sQh0ZTPgY/BJWeVdKn6WU/bFwavcwVHuIePo2PZiaJ6Ek9SpZT9zp2ocfwfr5v3h
 6kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708671857; x=1709276657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v57OTTK+poX6sNUPEDs2NuVKTa5kvYBNtQUoSnze0sA=;
 b=f7IOLbd+CkMSB+wa1g/ClzbSumPwi4SdwducGdtS3UvHwSTwRq1tWwmq79UCJw2KtF
 t6IC9/CEjoyVQl/MK0uR323YqUaw5uCfNH/2w2bLoW4yWs2HM1a6PcJajeraGzxNpqVo
 TD0Q3H7KKRFSLW2LT8hVQMQ1fwsjLwwBev7EkUic1gIBXYw0ehHhtChhR5MsZ66S3TKK
 gTnX6p9Jyny2qwXFO3vH5wL1UIjVrbEExpKYjNClGishIih1ZZLcJygUSeDzsccYSjF1
 ysUfu9Wn0sd/ZIWYxZxtbAZA4qCUjscjU56TIiCNGjmB5DnSCYabBxcdyomc0EeaYTp2
 N/yw==
X-Gm-Message-State: AOJu0YyG9L+kboUp2a8CSWOxKTT5C/se/MlZNgyVBGfnJfZZGrDrwZZg
 m+FZCQF8Au8ew3ITp4iFNOGeIei9XgIsh2aPynviNitZSBSJT+QT5+osXe/ed3CccCMUhAewaOu
 Fhl7osfHLqCBNUzRpQwLG5FO8LNXL5wV78MOKKg==
X-Google-Smtp-Source: AGHT+IFI8JzTDZNJSPzizMfRoJDqKKAAj3Dt1Srd2xCmdN5ulUx1ONQwSkIzl8mKpQ+Cyii1gbtU7PD/feHWYgVMd1s=
X-Received: by 2002:a05:6512:3da2:b0:512:ac10:a12c with SMTP id
 k34-20020a0565123da200b00512ac10a12cmr943127lfv.0.1708671857141; Thu, 22 Feb
 2024 23:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20240203163631.177508-1-raymond.mao@linaro.org>
 <20240203163631.177508-6-raymond.mao@linaro.org>
In-Reply-To: <20240203163631.177508-6-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Feb 2024 09:03:41 +0200
Message-ID: <CAC_iWj+SiWeRtUW3BG=j6r8zTQ1oaEEOQGq6w8JvGeyJjFUzBQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] arm: armv8: save boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Ard Biesheuvel <ardb@kernel.org>,
 Simon Glass <sjg@chromium.org>, 
 Kevin Chen <kevin_chen@aspeedtech.com>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Qu Wenruo <wqu@suse.com>
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

On Sat, 3 Feb 2024 at 18:38, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Save boot arguments x[0-3] into an array for handover of bloblist from
> previous boot stage.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Changes in v2
> - New patch file created for v2.
> Changes in V5
> - Drop the dependence on OF_BOARD.
> Changes in V7
> - Exclude the saved_args when BLOBLIST is disabled.
> Changes in V8
> - Use PC-relative reference for saved_args.
> - Add 4-byte alignment for saved_args.
>
>  arch/arm/cpu/armv8/start.S | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
> index 6cc1d26e5e..7461280261 100644
> --- a/arch/arm/cpu/armv8/start.S
> +++ b/arch/arm/cpu/armv8/start.S
> @@ -370,5 +370,28 @@ ENTRY(c_runtime_cpu_setup)
>  ENDPROC(c_runtime_cpu_setup)
>
>  WEAK(save_boot_params)
> +#if (IS_ENABLED(CONFIG_BLOBLIST))
> +       /* Calculate the PC-relative address of saved_args */
> +       adr     x9, saved_args_offset
> +       ldr     w10, saved_args_offset
> +       add     x9, x9, w10, sxtw
> +
> +       stp     x0, x1, [x9]
> +       stp     x2, x3, [x9, #16]
> +#endif
>         b       save_boot_params_ret    /* back to my caller */
>  ENDPROC(save_boot_params)
> +
> +#if (IS_ENABLED(CONFIG_BLOBLIST))
> +saved_args_offset:
> +       .long   saved_args - .  /* offset from current code to save_args */
> +
> +       .section .data
> +       .align 2
> +       .global saved_args
> +saved_args:
> +       .rept 4
> +       .dword 0
> +       .endr
> +END(saved_args)
> +#endif
> --
> 2.25.1
>

 Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
