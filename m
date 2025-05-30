Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829EAC5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 14:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF65A82B70;
	Fri, 30 May 2025 16:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L1pXbST8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D844A82B97; Fri, 30 May 2025 16:14:07 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52D782B5B
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 16:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-476977848c4so22708861cf.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748614444; x=1749219244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jbBk605LBpO2MVpcEITJYH6Erm2Ghk4/ILepjslkfMU=;
 b=L1pXbST8EwHpI4hD56YKav0CTxYKDLGq0zGK7eCe9iN+m2+jISy3ZlpbotCmqA42qF
 RvWa3UlrNWxwxvxsHB7EuFNsTzZMY4fw+3JmXmN6q8UUM3E6tqzJuWt2VKyxEBS+HzMc
 wSjEgOz/r8O7qhHjITnA8Wqe+0USJRDTcYKzhOzIUcQCf1aQae3uBI36CENAqz4WbSar
 6Xq0pVe/8SBgbZqNVQBPJlUS71AxPXG3mgCHKbo5ggHFmgsBL5dyo/CtknVZp8BojAOC
 +gtAwZuABnnqboaVc7ZvuvKNhXaDt29t+rZPkFiraeBNQOOElxtjo82NKuwI8Hwvb5c7
 brMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748614444; x=1749219244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbBk605LBpO2MVpcEITJYH6Erm2Ghk4/ILepjslkfMU=;
 b=gkjiGNrO72N0zvT+95CKiknsicC6Yr7q1IH5iUfiUnug/Lg2XwYT5nO0n1oA7b4frF
 S1+EgvMjLeAc4dT7yZrzpBKYTEO4fc2AzengMGzyYpmyRAzzxYXGNoUeXjGWZ0nRuk8Z
 vPVRvMoSol6GulpizlDC9SgR10tOxR9OWQRjPvUCH/9Mfe0P/MyAd/AzK3F+N0G8DB44
 FHS+okLSehMqNtpSe37O/j8ByejK37VH7m3cNqqnaEXam7OOpE557BylF9MBfR8U/WyS
 zrg+LD/UxJSFXzfTMbLReI8Hmkw1tRe1BPa6h4Hwv62QPju8D6D7VmdbexN+zaTw7Xls
 fuUA==
X-Gm-Message-State: AOJu0YyxC9IycHowx6cHuAjHbNmSC3RLmfXNoQWE+CGs/fpUM+FB8vqk
 tyxEn8E8WykqpLZQxg4jQgLZOFCICOp3iPqiggGFgFfkL+9z0WbJ8E62lciYmq784PYwNGnKq3C
 WDzJxnp3IohHvlZ3Pq+FBgVv1SZN8y8EWmSmI7spXUTHpkifVFYc8kMw=
X-Gm-Gg: ASbGncuRbf/o42kNJObp1NyGiaFLzMJaPEuuuiiUR1z89RSN614qrXEv7zEYZfKD8NR
 uM4K1MlPrZOzn74rhbvkUrAwxhCUlr4YH3UYWk925fSPZpZ1HITl8SUs92sT5kgmKjaHKxcexQk
 hfHiCEH97TJ7dM5XvVDV+c9WylVuX2/xpOOvNeGszC/FPR
X-Google-Smtp-Source: AGHT+IG4oGFjWwie4fQO0N0X2lNPOAzNT/UGRfimEPhMcf+2v/wgIU6yg06Dqps7Dmri+94J1IIyZtdA6QYaS8OU6kI=
X-Received: by 2002:a05:690c:6813:b0:70f:8883:eb1a with SMTP id
 00721157ae682-70f97e2eae1mr54826567b3.6.1748614433844; Fri, 30 May 2025
 07:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250527210436.1488428-1-raymond.mao@linaro.org>
In-Reply-To: <20250527210436.1488428-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 May 2025 17:13:18 +0300
X-Gm-Features: AX0GCFv_UfMZjEhfhcv1wAhzKdt7983Sbt-Tw0cIJOmoXNDlqi4ivc3Fxo3SEFE
Message-ID: <CAC_iWj+rSHWdhXk9rP_Y7SQxM1a3UbtQGJ0a=Zza0wMndYR6zg@mail.gmail.com>
Subject: Re: [PATCH] armv8: fix Clang warning on writing 32-bit variable to a
 64-bit register
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>
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

On Wed, 28 May 2025 at 00:04, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Clang is stricter than GCC when it comes to inline assembly and expects the
> register to be written with explicitly same type of variable.
>
> Fixes: c0e1775a867c ("armv8: Add arch-specific sysinfo platform driver")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  arch/arm/cpu/armv8/sysinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/cpu/armv8/sysinfo.c b/arch/arm/cpu/armv8/sysinfo.c
> index 850142da37d..ff0abee4c6b 100644
> --- a/arch/arm/cpu/armv8/sysinfo.c
> +++ b/arch/arm/cpu/armv8/sysinfo.c
> @@ -134,7 +134,7 @@ int sysinfo_get_cache_info(u8 level, struct cache_info *cinfo)
>
>         /* Select cache level */
>         csselr_el1 = (level << 1);
> -       asm volatile("msr csselr_el1, %0" : : "r" (csselr_el1));
> +       asm volatile("msr csselr_el1, %0" : : "r" ((u64)csselr_el1));
>
>         /* Read CCSIDR_EL1 */
>         asm volatile("mrs %0, ccsidr_el1" : "=r" (creg.data));
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
