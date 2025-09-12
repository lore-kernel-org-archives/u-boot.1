Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16488CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 06:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5011D8334F;
	Fri, 12 Sep 2025 08:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S0ZSds/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E35833EB; Fri, 12 Sep 2025 08:00:36 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3822483322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 08:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71d603acc23so10297177b3.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757656832; x=1758261632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NW2HEyAQzVTxhCVmcNqyriQyhPYNOLEnJY1JyC7DC3U=;
 b=S0ZSds/lR45l/IMRNNYS3RpCLraxJaTQFlg5uZNpqTqNcyo+qX+ZpN6n9SqmHLsjLp
 QL3bls9+KfsO9GAl8CnfNoytypkqLWm1KAB6VuF5wkB52nBvRWpSFaJPMifjDiDp8juS
 uPecDl7ZXxiUcEt57eDv4JnpVenzx4uUkZsBtAI2cENVICv3fzO/mZS1Dya8hSvmt8hV
 LFY/fmNWOF2OnYWgMPQY0/hU9dgQ1gEtllNWSdB/7LgaSsmdlue9ArMkfrjYpH1Y3PyS
 QAOestb6al6ouHIiFhPZ0iVgblK09Fm/ZETRZZfocjKKVPYHwTmbMpldC+Rg1gmVOyXZ
 DwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757656832; x=1758261632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NW2HEyAQzVTxhCVmcNqyriQyhPYNOLEnJY1JyC7DC3U=;
 b=D+Efwi7FTeZS+I3qS/vDSSEzmYWh8u3WCujvgw5wFbwHUR1Xme94X1yhlAC+Crgw+F
 Wi3T/nNQy5GiA/ruDr60+wUDW4zhEz04T2C/ntGkG8syOP4GSnvAlf25GIQ/3SDZhn9D
 +oGNWnADtz0C6QTB3B+J9bylxt9+gXIe8OdfL+STfb0rYWHdp0As+IHKIJwh/4RMGSHh
 QOpRoG72FlTiasMEXcPcAqyLRMRU8JTA9Hp0EfZJc5vAox5z0UYtQCt19oTLMjsJ2ING
 3o32/E7jkglLlpSVyYjCiYmKkdLghnsGeplhPneod0P5gwhXik1dZGKzwWFe2aR4xcfI
 HKtA==
X-Gm-Message-State: AOJu0YyFfhgveLcK/jeQpH81H/gX6/KpSw1ooDAWcAJZfJAjKTasWDOx
 7EJI6X1K+Bse2LhtmTBn9YzEHkYwqpxcNeu9RYbcOomvAUCwPLcrrz+K4hY+iSFoG0t3u1W7Rg6
 s3TrY0vk3bJ3gwLVWUspK4c+K73c+ziefCR2p1LsRCA==
X-Gm-Gg: ASbGnctKreItxj4z7c/2XOb5Nx8WKcGx8jKTdKvyqN8CvzUwrFaZpkaDHCaveR1Y2lJ
 l/ODr2dUHxjarMr7S89kyiS81jqdglwvSAE3kBgTL0EDbK/63NWFC1kS/PvMWwEJ633pJ9DXDWo
 H/nFdmvR6eENinlWo1AboAILiO6l2wyhE1nU7Kazb05RhDuxngwI+xbAtdt/xBhu+IYmYcjDIl3
 HAj3iL/p8Ym2e9Ec2luDqVY0qnAoPh9O2B1TCTaLz4KS9APNhp5ibDIzUacAu2Oz7hfc/jfvUT/
 dYWVK34GI3O7PjdX+MUi6F6ObNmOZ9CWHtvT2SxCo3p9PFYPMGaBRHXwYWx8yFI=
X-Google-Smtp-Source: AGHT+IFBL3QKi9LW8zDD5yqd7BEfdIYMJEl9lc3/yMHayojeCsTAcLjhVb6y0nBqou52DQkubsDI01KNgt3os6LfmtU=
X-Received: by 2002:a05:690c:4a11:b0:730:4c94:be16 with SMTP id
 00721157ae682-730626d4cb5mr14815517b3.5.1757656831669; Thu, 11 Sep 2025
 23:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-4-anshuld@ti.com>
In-Reply-To: <20250905081902.489345-4-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Sep 2025 08:59:55 +0300
X-Gm-Features: Ac12FXzJGo70nOQybJkxdPYMiD_2W1roY3Z-9R_4eTthBw-NLg0moYHe3tjoNbU
Message-ID: <CAC_iWjJhJfQpRjx9qumKZn6cHKOfj2QvhGNbCuHs7S2NFGMNZg@mail.gmail.com>
Subject: Re: [PATCH -next v6 03/10] arm: armv8: mmu: export mmu_setup
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, 
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com, 
 a-nandan@ti.com, afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com
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

On Fri, 5 Sept 2025 at 11:19, Anshul Dalal <anshuld@ti.com> wrote:
>
> The mmu_setup function configures the page tables based on the board
> supplied mem_map struct array. It is called implicitly as part of
> dcache_enable but this limits us to only be able to use APIs such as
> mmu_change_region_attr only after caches are enabled.
>
> This might lead to speculative accesses before we can unmap a region
> that is marked as cacheable in the static memory map.
>
> Therefore this patch exports the mmu_setup function in mmu.h allowing
> users to have more control over when the mmu is configured.
>
> For K3 specifically this allows for the following configuration sequence
> as part of enable_caches:
>
> static mem_map fixups (TODO) -> mmu_setup -> carveouts using
> mmu_change_region_attr (TODO) -> icache/dcache enable
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/include/asm/armv8/mmu.h | 5 +++++
>  arch/arm/mach-k3/common.c        | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> index 6af8cd111a4..3807c702fb6 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -197,6 +197,11 @@ struct mm_region {
>  extern struct mm_region *mem_map;
>  void setup_pgtables(void);
>  u64 get_tcr(u64 *pips, u64 *pva_bits);
> +
> +/**
> + * mmu_setup() - Sets up the mmu page tables as per mem_map
> + */
> +void mmu_setup(void);
>  #endif
>
>  #endif /* _ASM_ARMV8_MMU_H_ */
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 9d6c6fea451..e9b48b528d6 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -30,6 +30,7 @@
>  #include <soc.h>
>  #include <dm/uclass-internal.h>
>  #include <dm/device-internal.h>
> +#include <asm/armv8/mmu.h>
>
>  #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT       0x00000001
>  #define PROC_BOOT_STATUS_FLAG_R5_WFI           0x00000002
> @@ -261,6 +262,8 @@ void board_prep_linux(struct bootm_headers *images)
>
>  void enable_caches(void)
>  {
> +       mmu_setup();
> +

mmu_setup() will run twice here. I assume that's ok ?

Thanks
/Ilias
>         icache_enable();
>         dcache_enable();
>  }
> --
> 2.50.1
>
