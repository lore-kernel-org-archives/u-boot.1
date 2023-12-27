Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABE2C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC72877CD;
	Wed, 27 Dec 2023 09:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tStrTNC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7571877E5; Wed, 27 Dec 2023 09:30:37 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43C087729
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e7b9cca2fso1748126e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703665835; x=1704270635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fF7bmmqhLF6dflSFinOrlTXwdKQp5SGo240mVimWoJE=;
 b=tStrTNC3g5zDLYdY5vTzs8XIAq/RIyp+SNhI65TDAyfk+lxB20tkkGOzj06ZpqFYgB
 lwAtar1duIUppS2UuNCzby38hvyu9LNQHL6FkzewWAZek0zVyX+L8J0ZqV9iHV+mOjpr
 Iyx3KeNkcm64dJ+F5OQnM+PIynL3Unrx0UzyBDm4nEdEcWigT+EQaKAqyW80V/OvHLQY
 RDWo/HhSXwk1zwFH/uZUhrl0a1RnJnn3tADZ3SjbtXbZCi63W71XuKp2gi881BgeAqft
 dx8sdahkBlsX5ZGBrmhVU0sZ2uM+lCvBwIf7GnigksOZdVIzBycYi8GpSjpFy0DC9IpY
 KX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665835; x=1704270635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fF7bmmqhLF6dflSFinOrlTXwdKQp5SGo240mVimWoJE=;
 b=FuErubihZgMQpzxIlp6ExjDVteRMDRRXuHW4XF75BTLZm7PeZOzXTrs45fODHgZmKC
 fBhy5KQxCepdk03pBSiqDIINBWMk5+a2WlwfTwNdVqBuBXo9lTD3QZvAKOrJOiCX8s2t
 wleTLb7s0TTdvlsbpHggxRb6w7h1MEUyEnM8iX0xN1xj0fWhzRDEefREKB+TZzNVcq8H
 +Sgc6zEkx+ei6hU0t6bnmBkNiEI8SjI/AgY/mwQU0/mKtXbMUtbBUaDL04L02qd7+SZg
 g0Grpl5H+PToNpsW8bFlCmAwcXa+u3gVCPG6GbX7qBk/80a2xd8JUMOazPTlkUauOUjL
 J3Hg==
X-Gm-Message-State: AOJu0YxBXYFe1kXkNWOnbjQmzfP6Bvo+Sh2xGe5mYbyimSnkp16Vnuqi
 tUOlvYBuzpKpXux+y56ItuarpoBUKqzeWIAA5E5m2NL4ZxBAAQ==
X-Google-Smtp-Source: AGHT+IEha/ym/2B4HyGxIlmEpWMVGAFKjIMyN1AkHsoTk3Ab7rkzqMVwWw0aP6n+1NYWq2kAhEtEVyO/viYsZH88WrE=
X-Received: by 2002:a05:6512:3450:b0:50e:7124:8953 with SMTP id
 j16-20020a056512345000b0050e71248953mr1892990lfr.26.1703665835140; Wed, 27
 Dec 2023 00:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-5-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-5-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 10:29:59 +0200
Message-ID: <CAC_iWjKcR6yC7yG7SLQz_QCbxjCC2Ai4qB8hyLq4QW8t1BN2EA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] arm: armv7: save boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <sean.anderson@seco.com>
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

Hi Raymond,

On Fri, 22 Dec 2023 at 23:31, Raymond Mao <raymond.mao@linaro.org> wrote:
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
>
>  arch/arm/cpu/armv7/start.S | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> index 69e281b086..2ca63ca32c 100644
> --- a/arch/arm/cpu/armv7/start.S
> +++ b/arch/arm/cpu/armv7/start.S
> @@ -152,9 +152,22 @@ ENDPROC(c_runtime_cpu_setup)
>   *
>   *************************************************************************/
>  WEAK(save_boot_params)
> +#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
> +       ldr r12, =saved_args
> +       /* Intentionally swapping r0 with r2 */

That isn't very helpful. It's obvious what the code does here. Add a
comment on *why* (to keep the c function simpler etc)

Thanks
/Ilias
> +       stm r12, {r2, r1, r0, r3}
> +#endif
>         b       save_boot_params_ret            @ back to my caller
>  ENDPROC(save_boot_params)
>
> +.section .data
> +.global saved_args
> +saved_args:
> +       .rept 4
> +       .word 0
> +       .endr
> +END(saved_args)
> +
>  #ifdef CONFIG_ARMV7_LPAE
>  WEAK(switch_to_hypervisor)
>         b       switch_to_hypervisor_ret
> --
> 2.25.1
>
