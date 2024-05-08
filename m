Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5605C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 09:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D43E87E30;
	Wed,  8 May 2024 11:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zldwis7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE9B8830D; Wed,  8 May 2024 11:14:50 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B4787DEB
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 11:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-47eff2a6699so1338539137.3
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 02:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715159687; x=1715764487; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2NSdW2dMKtBBZ5KpZFZL7cx9j9aVvoxvFmt003hFOk4=;
 b=zldwis7pjt9gNJ07BulfpAuJN8fHjOBY/7gKC4E9yO0PvDMejX83sE0aXGPhcTcNoK
 /L/7VYf6vMXnPiqBAKtrD2FwisYY70TUSa3b0YR2saTZIgqtHoCrfcVQpPWWjIBbeJ71
 dzpMTR0C+ihcBFEgkt6/arOiFktMZPnjFIYHeOs4pUFqufmHWACyHUVzOZ23DRJ81XFA
 Hq9T9kqAgqItkHT1HrJXkBog2knQxyoKOgTxYXqoXeLxys3UaoFGC/yqhAbMITxORFFr
 UL8lpPm3QTQMogBwmsVYtOLS5xpVuCAUtJwOopxs9yOETqQQdcm1OR4ze2TcL7C5qh+Z
 KViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715159687; x=1715764487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2NSdW2dMKtBBZ5KpZFZL7cx9j9aVvoxvFmt003hFOk4=;
 b=joaATuSPiklFYKc+EAbdND0SBYsqhOczXEcxxVRtzD1TB9R5T0PsMw5h1IWLL2wwV2
 WY9wNAaj361aEPosQHrLv7fjZirUNICsOfU9LMCNmAZ9/N7hgJ5dj0H3CTRAOMl6S5Z/
 NjMnTJTl2kz0kNgfYFmT6AgFKvq2kqI46qxmjnQlbNpF7b/d5HemzZ9ztHVTGEQ2UTXh
 6oE59AjMlkfLaGxWDHNgy+2j6JCwBZ3aikgxAWDNz3dXcS1NEIqbVsLPwWYuoaB+U4cg
 AZbewMPY7h62kewPfz2/Z4U0rGsleN1cz0pjoY5nbrbf4qYVOXVP8f9SkI923kY69s1E
 E9hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNe2MZx4IbEaSILuRRw+cJN8Kt8HR0lN1aOu79g7viu0+k23FabWRI0xuDGOqIy8vxYEJgtSAclgVVKlk0V31uXCQ98w==
X-Gm-Message-State: AOJu0YxXkrquCPDsK8vEuu7TEqf2hSNvDPQvDYvT242KclMxL8jonvdd
 2dRCVDC5dfsVX9EWYJVtX+kvp4Udp041KXpQZAilAFuhmUtRGejPK96Ghb2a5qOK5I8Ytd/5Gj5
 8OsdJTWMPj7bMEOzyIYZe1xlOPWffPdkDtbGaBg==
X-Google-Smtp-Source: AGHT+IH0i7mRdZ9q7KTnaAmmXVYSinwtaneAY3hbty99ppiTvASQxAk+vUYT/vYK01y72HKIMszzWa+ki+z8fP7lyz0=
X-Received: by 2002:a67:f8c4:0:b0:47e:f811:747a with SMTP id
 ada2fe7eead31-47f3c2c973bmr1911707137.10.1715159685962; Wed, 08 May 2024
 02:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
In-Reply-To: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 8 May 2024 14:44:34 +0530
Message-ID: <CAFA6WYPEK0CeK-WATVymNSzYR6U3+gKxu0TpBeCQ7a03C7PObw@mail.gmail.com>
Subject: Re: [PATCH] mach-snapdragon: do carveouts for qcs404 only
To: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
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

Hi Sam,

On Wed, 8 May 2024 at 00:11, Sam Day <me@samcday.com> wrote:
>
> The newly introduced carve_out_reserved_memory causes issues when
> U-Boot is chained from the lk2nd bootloader. lk2nd provides a
> simple-framebuffer device and marks the framebuffer region as no-map in
> the supplied /reserved-memory. Consequently, the simple_video driver
> triggers a page fault when it tries to write to this region.

How does the corresponding Linux kernel driver handle this? Is the
framebuffer region required to be mapped as normal memory or device
type or something else? Similarly would normal memory type work for
all other reserved memory regions marked as no-map?

-Sumit

>
> As per Caleb's advice, this simple patch only does the carveouts for the
> qcs404 SoC for which it was originally designed. The intent is to do the
> carveouts for more Qualcomm SoCs in future.
>
> ---
> I'm not sure if it's feasible to get this in for the 2024.07 release,
> but it'd be great if we could - it's the only thing that breaks U-Boot
> master on msm8916 devices that chain from lk2nd.
>
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 3d5994c878..b439a19ec7 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -467,10 +467,12 @@ void enable_caches(void)
>         gd->arch.tlb_addr = tlb_addr;
>         gd->arch.tlb_size = tlb_size;
>
> -       carveout_start = get_timer(0);
> -       /* Takes ~20-50ms on SDM845 */
> -       carve_out_reserved_memory();
> -       debug("carveout time: %lums\n", get_timer(carveout_start));
> -
> +       /* We do the carveouts only for QCS404, for now. */
> +       if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
> +               carveout_start = get_timer(0);
> +               /* Takes ~20-50ms on SDM845 */
> +               carve_out_reserved_memory();
> +               debug("carveout time: %lums\n", get_timer(carveout_start));
> +       }
>         dcache_enable();
>  }
>
> ---
> base-commit: 1c40dda60f5f7e83a6d6f541cf5a57eb7e8ec43c
> change-id: 20240507-qcs404-carveout-only-7a15bbf3fd89
>
> Best regards,
> --
> Sam Day <me@samcday.com>
>
>
