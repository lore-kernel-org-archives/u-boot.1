Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4029FC48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 07:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33164876F3;
	Fri, 23 Feb 2024 08:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="na5UKSu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22BB1876D3; Fri, 23 Feb 2024 08:04:52 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F242987653
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 08:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d22b8c6e0dso213351fa.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 23:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708671869; x=1709276669; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g4IFDzHmF5JTMf1KXfwcP6sPjeTns8Sn3bOL8+CfCsk=;
 b=na5UKSu4+I8l9zLFWxhj+fmEX3vRYEaJdiT7/SPnlQjxb84awwMLa4xICJMXBT+HC+
 PoLl5KMarERKXOdafAkwgVWQRcXQAv9unB6nGOCITdUVYCpoGLm/nCWR+pE4oq+0/L2j
 7DfXOOqZJYiurMhzKggQFiPHxPhwK1anX/V7HnrXVQagdNOPWWNBiwhJmUpsvUrch4OM
 z7cBVkoRtdJLL8aJy/y1aYxcPVF18XvszjC3+EZyaolyMY1YJI0XhUuPpTRBxAnLn0UO
 xmzA2GGoO0S41WD6baJG0673MMNBRXAv4OdsfU1qpHYV4ZFEptH4iMuLfvGWvAErIx83
 R6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708671869; x=1709276669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4IFDzHmF5JTMf1KXfwcP6sPjeTns8Sn3bOL8+CfCsk=;
 b=AJEx4OUQm/krtalUMGnGt7u8gGbVIUKghqAW8PkSOSFtnmP/b3m4C96/NKZbXFnQAP
 wjdraQWGTH6kAb3ysGIcFg1rDrIwx0WrDHr6yeIaI7r0XE4ErRisks/gESk+a8zFCTtO
 48UWqpaHSlK6D0gTNdNv/Co80EKETxXMdVnBP50jnk63QjWj6TQW/C2C4Qvz2t28lOik
 L3/dujiJR6mXho20Zg63GfUASG3FkKtAUPlH3TxOhGdqeejwKVIoOYakt3Xk0G2Pwlkv
 aaBNTA+vB9IyYileG1JKbi7BOZUhSpPZCcHuluUG8B+fNXjzT6oTnS6KwU7y41Vb1sKj
 BxJA==
X-Gm-Message-State: AOJu0YxhhYST5BY+oVrAokF5r5FiXRM4ZExmEwwqCtjHcU17eTDzU+c1
 XjDU63dcBr5YM9qyzzDKjno2LNgHdL2zFG7/mO3LT4YAvrzTsINSi8ch3/Z9S8nQaGoAw9526gM
 ZqsxaOPSOMWa/SaS40xbObkRUkjR3IG96TWWUSg==
X-Google-Smtp-Source: AGHT+IFrT1V/L3erIX0GKoKH1v+r0xj3JJ6ggceSYivwkEOfs3sMW3zQbsYJw+u5/3Do+jzaJClCPZn3U5GmTol83hM=
X-Received: by 2002:a05:6512:3b11:b0:511:9949:25a3 with SMTP id
 f17-20020a0565123b1100b00511994925a3mr1019382lfv.7.1708671868798; Thu, 22 Feb
 2024 23:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20240203163631.177508-1-raymond.mao@linaro.org>
 <20240203163631.177508-5-raymond.mao@linaro.org>
In-Reply-To: <20240203163631.177508-5-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Feb 2024 09:03:52 +0200
Message-ID: <CAC_iWjKdx05wDSTsW1MxJWN2NvgHjkbfB_CGH2ECOQ1H2p3afw@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] arm: armv7: save boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Ard Biesheuvel <ardb@kernel.org>,
 Simon Glass <sjg@chromium.org>, 
 Kevin Chen <kevin_chen@aspeedtech.com>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
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

On Sat, 3 Feb 2024 at 18:37, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Save boot arguments r[0-3] into an array for handover of bloblist from
> previous boot stage.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
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
> Changes in V8
> - Use PC-relative reference for saved_args.
> - Add 4-byte alignment for saved_args.
>
>  arch/arm/cpu/armv7/start.S | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> index 69e281b086..7730a16e51 100644
> --- a/arch/arm/cpu/armv7/start.S
> +++ b/arch/arm/cpu/armv7/start.S
> @@ -152,9 +152,38 @@ ENDPROC(c_runtime_cpu_setup)
>   *
>   *************************************************************************/
>  WEAK(save_boot_params)
> +#if (IS_ENABLED(CONFIG_BLOBLIST))
> +       /* Calculate the PC-relative address of saved_args */
> +       adr     r12, saved_args_offset
> +       ldr     r13, saved_args_offset
> +       add     r12, r12, r13
> +
> +       /*
> +        * Intentionally swapping r0 with r2 in order to simplify the C
> +        * function we use later.
> +        */
> +       str     r2, [r12]
> +       str     r1, [r12, #4]
> +       str     r0, [r12, #8]
> +       str     r3, [r12, #12]
> +#endif
>         b       save_boot_params_ret            @ back to my caller
>  ENDPROC(save_boot_params)
>
> +#if (IS_ENABLED(CONFIG_BLOBLIST))
> +saved_args_offset:
> +       .long   saved_args - .  /* offset from current code to save_args */
> +
> +       .section .data
> +       .align 2
> +       .global saved_args
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
