Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4136CAC5A8
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 11:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F7F480B9B;
	Thu, 18 Sep 2025 13:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KaOgCa83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661EC81E13; Thu, 18 Sep 2025 13:55:32 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C95380107
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 13:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71d5fb5e34cso8865717b3.0
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758196528; x=1758801328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9gxRhFkhqXSyWYrgq/2pd3b+LqLeJZ71u0mdoLhdJcw=;
 b=KaOgCa83E6gkPmoUKVg0j7ReLHPhKiOjuhsda20wxUt1AZGiZA1KujD4kj5WFZXkcI
 hnPoJFcL69NnSpn6vaSeffW3t6BPTN5qZPz0acZeJnTUzym5z/DRrs39ccDbgJUAWVTL
 K5FwXZmEhssxPtASzP/ZeQTTnDWWEbT+XuzK9Q7viJpC260VbH7QFnotAc9dfIyTexBb
 lUX8WJ1DoknIBCZgbLziA2vYKxKwQ8NKwIZbPDaL6IpgGDMajJh25J+hEa3EJeVoHrjn
 wvWpXLFtiIefa++4DUVMSPpg4T/nDfTgWnhhQDKbIc066K8HnZGh11d7RRN3SMRnaIn6
 cwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758196528; x=1758801328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9gxRhFkhqXSyWYrgq/2pd3b+LqLeJZ71u0mdoLhdJcw=;
 b=ESWg2frfg2nyJuAf2aq+/+q86vznJsISUQ4TOOf8tHEwsnwdNl/Jd3cz+uRMNr/mpY
 Dx8nz7pjC+NOO8YiEuQZbABrP8abvWgok2WCFujqNSMl7hWZM4fvG7ISLE7qsHpZoZeb
 728byC3YuBsQCARS+IHVQ4lcTvwOyIzk1KSReiX7j0qUcon1AP1r1DC3w1I5bt1FhyS2
 JRP77vW3XbbqJsGw0X+Js2khyE6K10q+zqVG9csaGgpKjqmFNCykYeNXE0b/bo9qwOLW
 jLBjAuQwNI6LvQg2TatvUTVkokQrH4+vfYnPOh2z8hY8DwnazmIQFxK/ijrc4tlbb8nD
 nLqg==
X-Gm-Message-State: AOJu0YyNJQ4OOt9lo9O18AxOjFVLtTJBsh/WRBP5q3LK3DhBVTamxciH
 635l+JnE3q4qKqQPcLZH8dvfcsbIlxsWdDKcyyzZgCjznf29uhrRNJaQPoQ7oLGfWAq0YQvfCWu
 6J4b5hB+i34x0exWDffMRTQX0VvtgzFM20Qa/mHeelw==
X-Gm-Gg: ASbGncsb6uinx6edAa7eQ0efCC0Ml1OeVnqSVBgUSbP/lUbTw7tlb3h0hljGPqtdiU6
 CM27zLt1JsO6DdA6QfTMpU/414F+X69MGf1FwHclL16GlXT/w6jtBJRUIPU/yZCgG9vB4vWJtIh
 d25VOhn0DBqZkwgifMkA5k7iBDGB+bhEoLkqxGg0LZI/w58rqeKrLfPYRF4qOCV4z/0HCkc+rRG
 V55EKkWTPlQFSYcsRI0Xw05NlpG4ENvMDztaKuDSIxSdU+UwyAH4ybhfx3POAOWfpjRCnD4yGtT
 5z5Cob6VEPv037J3yWSKQfMF5VB9RQZku/J0eR4T9LIbVGkzhxfmtYksS5TOZEMIq33gs2LmHei
 a7gii
X-Google-Smtp-Source: AGHT+IEqc5FdDLP4N9Joay/J3iX1/Zkx9jzuhJwv1Z6JGlnpdUjRmy7Qle+jtmNpvqDSkPCUBauuY1WtnKTbIKGv2xQ=
X-Received: by 2002:a05:690c:9203:b0:733:d35b:d7f4 with SMTP id
 00721157ae682-739708b4be5mr22587557b3.21.1758196528047; Thu, 18 Sep 2025
 04:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250916112205.238811-1-anshuld@ti.com>
In-Reply-To: <20250916112205.238811-1-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Sep 2025 14:54:50 +0300
X-Gm-Features: AS18NWCLKBvuNP1fLwsuxZLgzvR_u6HnlwwTHLsYnHzoD4i24wTGnsFtYoXcX3I
Message-ID: <CAC_iWjJcH1F-=7kgZDEs9z+2Y_j6dOMM7sMaXCMtAEqyTi14dQ@mail.gmail.com>
Subject: Re: [PATCH -next v1] arm: armv8: remove redundant definition of
 mmu_status
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, 
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com, 
 afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com, 
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com
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

On Tue, 16 Sept 2025 at 14:22, Anshul Dalal <anshuld@ti.com> wrote:
>
> mmu_status is used in io memcpy functions to prevent accesses to non
> 8-byte aligned addresses when the mmu is disabled. Though there is a
> redundant definition enabled when icaches is turned off by setting
> SYS_ICACHE_OFF.
>
> This patch removes the redundant definition, allowing mmu_status to
> properly report the status regardless of config settings. This shouldn't
> be a problem since access to non 8-byte aligned data can be done
> irrespective of icache state.
>
> Fixes: 268f6ac1f95c ("arm64: Update memcpy_{from, to}io() helpers")
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/cpu/armv8/cache_v8.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 1dcb6007475..74814601483 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -1184,11 +1184,6 @@ int icache_status(void)
>         return (get_sctlr() & CR_I) != 0;
>  }
>
> -int mmu_status(void)
> -{
> -       return (get_sctlr() & CR_M) != 0;
> -}
> -
>  void invalidate_icache_all(void)
>  {
>         __asm_invalidate_icache_all();
> @@ -1210,17 +1205,17 @@ int icache_status(void)
>         return 0;
>  }
>
> -int mmu_status(void)
> -{
> -       return 0;
> -}
> -
>  void invalidate_icache_all(void)
>  {
>  }
>
>  #endif /* !CONFIG_IS_ENABLED(SYS_ICACHE_OFF) */
>
> +int mmu_status(void)
> +{
> +       return (get_sctlr() & CR_M) != 0;
> +}
> +
>  /*
>   * Enable dCache & iCache, whether cache is actually enabled
>   * depend on CONFIG_SYS_DCACHE_OFF and CONFIG_SYS_ICACHE_OFF
> --
> 2.51.0
>
