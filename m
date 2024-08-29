Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB9DC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 875BF889FD;
	Thu, 29 Aug 2024 09:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ic6kj89o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E8688A2D; Thu, 29 Aug 2024 09:32:29 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E92889FD
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2705dd4ba64so164417fac.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724916743; x=1725521543; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sjcoFTNfCZBP6tX68Cd1SnBYkBMRw/bYtcBI4//7bI4=;
 b=Ic6kj89oN/RlcLA+3e+q/L9Two9E7sVI+I0DwpKWPHcUQavSTwMlT6f+2J5cQ/LRuJ
 lcVIgjxRIfuDMxeJuqmHb7DQspIEvoXMv6bXZ0RPp0555TUeDQmEaa+R01QcZ8SktnZ0
 tDspA0K4dCj830qtXdK89Us/oDlK5lOWwBjikFEgyORwjEAZYDS/SQoPfgpEMGvdGoeC
 pinE+PzFK1Qy7sa9SV+uvF1k4ORvq209ZQ2+TdtRBGM0B5wpa6DAg7uuddokXIiRzMAE
 S8eWRNvsWKsuxClfNKySCgE31PBhlj10L+/eesA3LFCjo4ulNh9qaMdfU2PkZSzFX2yE
 Tl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724916743; x=1725521543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sjcoFTNfCZBP6tX68Cd1SnBYkBMRw/bYtcBI4//7bI4=;
 b=fBVaYBzsT8ETDz2CEQb+b+jNCJMTeiTg87wV2qx3H0D+rIx6svqQ8J/KAPceVG9Ito
 1mmer7zxLs9bZV+y7GKYEpuZ0gvwUFHMtGZqCmYg7r6okWegamGtXdpyTcgc5qwUNoDl
 uDwRf7INtl6Mw2bWGrL+aFFbbxlPF/jX4Wq3sYflF44r2GElwBRcIIWWqmyJUGeINMCa
 osnaTTXa7AXJi3DK5LXnmsqeC2yEm4i7vuH6dreT9w2mGuaomHrowRHY8DuF3gSIopRl
 uCbVpRfp/P08qFCnI3QFr3G5+VKBkuFnAUkQFmklGlUiHYl634UZOpiq6sMwB+vV0vIP
 DAqw==
X-Gm-Message-State: AOJu0YwhOPucAET6btqz2ER9tN/Cg0mDkbfV3mXikhr4e6HesHqa45I+
 SEwqXGfjU7dF5TDV8t188jI1wBiLqlwCdeCNw+TctFqgQVVsRhTj1gh6KO+tddChJ32v59ZEMhi
 khqa3tRhpCQRrlXrjeuX/q250WeENC/vE808+Pg==
X-Google-Smtp-Source: AGHT+IEJdt4cQS7Ovsja+epqjyczdWH6Mw/v7WCykIG7T/GP93YhmnZphxaL3HuIHFv2Q4Wr8zYbX8bqJwbm0YIXbzA=
X-Received: by 2002:a05:6870:240d:b0:24f:d178:d48d with SMTP id
 586e51a60fabf-277902654f8mr2147876fac.31.1724916743126; Thu, 29 Aug 2024
 00:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <7f010d834c665c15888b7738a0ad16334fa03443.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <7f010d834c665c15888b7738a0ad16334fa03443.1724846454.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Aug 2024 10:31:46 +0300
Message-ID: <CAC_iWjK+iSgZ5Ey+dFQXNg5WtPc-WC3BccnQGeKv9BVKUmonMQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] at91: rename mem_init() to at91_mem_init()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, Jakub Klama <jakub@conclusive.pl>,
 Artur Rojek <artur@conclusive.pl>, Stefan Roese <sr@denx.de>,
 Heiko Schocher <hs@denx.de>, Marcin Jabrzyk <marcin@conclusive.pl>
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

On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> THe AT91-based platforms have a mem_init() function declared in
> arch/arm/mach-at91/include/mach/at91_common.h and implemented in various
> places. In preparation of the introduction of the lwIP networking library
> which also has a global mem_init() function, rename the AT91 one to
> at91_mem_init().
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/arm/mach-at91/include/mach/at91_common.h       | 2 +-
>  arch/arm/mach-at91/spl_at91.c                       | 2 +-
>  arch/arm/mach-at91/spl_atmel.c                      | 2 +-
>  board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c     | 2 +-
>  board/atmel/at91sam9n12ek/at91sam9n12ek.c           | 2 +-
>  board/atmel/at91sam9x5ek/at91sam9x5ek.c             | 2 +-
>  board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c     | 2 +-
>  board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 2 +-
>  board/atmel/sama5d2_icp/sama5d2_icp.c               | 2 +-
>  board/atmel/sama5d2_xplained/sama5d2_xplained.c     | 2 +-
>  board/atmel/sama5d3_xplained/sama5d3_xplained.c     | 2 +-
>  board/atmel/sama5d3xek/sama5d3xek.c                 | 2 +-
>  board/atmel/sama5d4_xplained/sama5d4_xplained.c     | 2 +-
>  board/atmel/sama5d4ek/sama5d4ek.c                   | 2 +-
>  board/conclusive/kstr-sama5d27/kstr-sama5d27.c      | 2 +-
>  board/gardena/smart-gateway-at91sam/spl.c           | 2 +-
>  board/siemens/corvus/board.c                        | 2 +-
>  board/siemens/smartweb/smartweb.c                   | 2 +-
>  board/siemens/taurus/taurus.c                       | 2 +-
>  19 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-at91/include/mach/at91_common.h b/arch/arm/mach-at91/include/mach/at91_common.h
> index 683e539b1b..8fec346c1e 100644
> --- a/arch/arm/mach-at91/include/mach/at91_common.h
> +++ b/arch/arm/mach-at91/include/mach/at91_common.h
> @@ -28,7 +28,7 @@ void at91_pllb_init(u32 pllar);
>  void at91_mck_init(u32 mckr);
>  void at91_mck_init_down(u32 mckr);
>  void at91_pmc_init(void);
> -void mem_init(void);
> +void at91_mem_init(void);
>  void at91_phy_reset(void);
>  void at91_sdram_hw_init(void);
>  void at91_mck_init(u32 mckr);
> diff --git a/arch/arm/mach-at91/spl_at91.c b/arch/arm/mach-at91/spl_at91.c
> index cde1700a28..0d1233cd10 100644
> --- a/arch/arm/mach-at91/spl_at91.c
> +++ b/arch/arm/mach-at91/spl_at91.c
> @@ -142,7 +142,7 @@ void board_init_f(ulong dummy)
>         preloader_console_init();
>  #endif
>
> -       mem_init();
> +       at91_mem_init();
>
>         at91_spl_board_init();
>  }
> diff --git a/arch/arm/mach-at91/spl_atmel.c b/arch/arm/mach-at91/spl_atmel.c
> index 62a7df8a19..7bfbadf048 100644
> --- a/arch/arm/mach-at91/spl_atmel.c
> +++ b/arch/arm/mach-at91/spl_atmel.c
> @@ -134,7 +134,7 @@ void board_init_f(ulong dummy)
>
>         board_early_init_f();
>
> -       mem_init();
> +       at91_mem_init();
>
>         ret = spl_init();
>         if (ret) {
> diff --git a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
> index 3bd94d0889..af486e977e 100644
> --- a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
> +++ b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
> @@ -125,7 +125,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
>                       2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct atmel_mpddrc_config ddr2;
>
> diff --git a/board/atmel/at91sam9n12ek/at91sam9n12ek.c b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
> index afc0c0520e..6f9abcbb12 100644
> --- a/board/atmel/at91sam9n12ek/at91sam9n12ek.c
> +++ b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
> @@ -167,7 +167,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
>                       2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
>         struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
> diff --git a/board/atmel/at91sam9x5ek/at91sam9x5ek.c b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
> index e5688c6cf1..f52b9a9773 100644
> --- a/board/atmel/at91sam9x5ek/at91sam9x5ek.c
> +++ b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
> @@ -181,7 +181,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
>                       2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
>         struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
> diff --git a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
> index 36995a927c..cb3cd7ac9a 100644
> --- a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
> +++ b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
> @@ -146,7 +146,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
>                       (8 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
>         struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
> diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
> index c775d593e5..15cbd0daa6 100644
> --- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
> +++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
> @@ -208,7 +208,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
>         ddrc->cal_mr4 |= ATMEL_MPDDRC_CAL_MR4_MR4R(0xFFFE);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
>         struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
> diff --git a/board/atmel/sama5d2_icp/sama5d2_icp.c b/board/atmel/sama5d2_icp/sama5d2_icp.c
> index 986da01639..6f0d578abf 100644
> --- a/board/atmel/sama5d2_icp/sama5d2_icp.c
> +++ b/board/atmel/sama5d2_icp/sama5d2_icp.c
> @@ -180,7 +180,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
>                       (7 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
>         struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
> diff --git a/board/atmel/sama5d2_xplained/sama5d2_xplained.c b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
> index c8a8eb4982..d104736fa7 100644
> --- a/board/atmel/sama5d2_xplained/sama5d2_xplained.c
> +++ b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
> @@ -146,7 +146,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
>                       7 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
>         struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
> diff --git a/board/atmel/sama5d3_xplained/sama5d3_xplained.c b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
> index 54cc3c4d90..f98322fb54 100644
> --- a/board/atmel/sama5d3_xplained/sama5d3_xplained.c
> +++ b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
> @@ -175,7 +175,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
>                       8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct atmel_mpddrc_config ddr2;
>
> diff --git a/board/atmel/sama5d3xek/sama5d3xek.c b/board/atmel/sama5d3xek/sama5d3xek.c
> index f2e1242fcb..28079a8151 100644
> --- a/board/atmel/sama5d3xek/sama5d3xek.c
> +++ b/board/atmel/sama5d3xek/sama5d3xek.c
> @@ -241,7 +241,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
>                       8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct atmel_mpddrc_config ddr2;
>
> diff --git a/board/atmel/sama5d4_xplained/sama5d4_xplained.c b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
> index 09ca16ca88..f9112fc532 100644
> --- a/board/atmel/sama5d4_xplained/sama5d4_xplained.c
> +++ b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
> @@ -184,7 +184,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
>                       8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct atmel_mpddrc_config ddr2;
>
> diff --git a/board/atmel/sama5d4ek/sama5d4ek.c b/board/atmel/sama5d4ek/sama5d4ek.c
> index 1f8b85f061..0bdc6adbdc 100644
> --- a/board/atmel/sama5d4ek/sama5d4ek.c
> +++ b/board/atmel/sama5d4ek/sama5d4ek.c
> @@ -169,7 +169,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
>                       8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct atmel_mpddrc_config ddr2;
>         const struct atmel_mpddr *mpddr = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
> diff --git a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
> index 64282ae9dc..37750137ad 100644
> --- a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
> +++ b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
> @@ -182,7 +182,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
>                       (8 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
>         struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
> diff --git a/board/gardena/smart-gateway-at91sam/spl.c b/board/gardena/smart-gateway-at91sam/spl.c
> index fb3ec48f9c..db9ba88188 100644
> --- a/board/gardena/smart-gateway-at91sam/spl.c
> +++ b/board/gardena/smart-gateway-at91sam/spl.c
> @@ -110,7 +110,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
>                       2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
>         struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
> diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
> index 7d73d1f2b3..cd27fc1cc3 100644
> --- a/board/siemens/corvus/board.c
> +++ b/board/siemens/corvus/board.c
> @@ -187,7 +187,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
>                       2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct atmel_mpddrc_config ddr2;
>
> diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
> index 946fbc3f22..e9e4bc348c 100644
> --- a/board/siemens/smartweb/smartweb.c
> +++ b/board/siemens/smartweb/smartweb.c
> @@ -238,7 +238,7 @@ void at91_spl_board_init(void)
>                          | AT91_SDRAMC_TRP_VAL(2) | AT91_SDRAMC_TRCD_VAL(2) \
>                          | AT91_SDRAMC_TRAS_VAL(5) | AT91_SDRAMC_TXSR_VAL(8))
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         struct at91_matrix *ma = (struct at91_matrix *)ATMEL_BASE_MATRIX;
>         struct at91_port *port = (struct at91_port *)ATMEL_BASE_PIOC;
> diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
> index bda12a9770..3764ab48ab 100644
> --- a/board/siemens/taurus/taurus.c
> +++ b/board/siemens/taurus/taurus.c
> @@ -177,7 +177,7 @@ void sdramc_configure(unsigned int mask)
>         sdramc_initialize(ATMEL_BASE_CS1, &setting);
>  }
>
> -void mem_init(void)
> +void at91_mem_init(void)
>  {
>         unsigned int ram_size = 0;
>
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
