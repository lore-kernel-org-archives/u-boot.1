Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1108C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 12:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1FD876FB;
	Thu,  2 Nov 2023 13:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CwjTS5Uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E506586758; Thu,  2 Nov 2023 13:25:36 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5CE87772
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 13:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7b625ed7208so336341241.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698927930; x=1699532730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E5sKQ2DvqNRA6UhesxJNYjDhXTFJnyORIZ53cKVsK1o=;
 b=CwjTS5UykgdQC+5zbs/kUnuTuLXz93y413AEIGKFOMLbA1Ak+9roB1iMwvZw9DumHk
 xJLPDT1st3AlSCAGKYONp2y/pa72GJ3yAg1EWnRHlGV1m2AmpoWLvU7b9nQ36d4h6wGO
 dsHFpRG3h6iHbAREYknPzM5uzLpLJ+Rds4Z/ZOZA9Mq/y2AEy7Qbws3ur3WYRPxOnEYL
 DS+Ys6hRB3nnhBmcFvAeKLmopibmZZ+W8z9MGxxGDOEONd70L9ClcvXm0eiND39O79um
 uwmoVmi+7SPNEWZBhPjEfHPlhwZW8GFxj69psHm5HHVTyMltHxxMMnfoBAn2U31t435h
 xYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698927930; x=1699532730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E5sKQ2DvqNRA6UhesxJNYjDhXTFJnyORIZ53cKVsK1o=;
 b=gONWlTLnioxSCsX2wz40zjmK3E++ELygSGLdGcIpth7+eF9i4trjmmezxoxVaAITMQ
 8QofYEQI1Gsrq5wI3NF6RH9hV0jkgYEI8oE1LC+2ZPlC1yCjFtZ8OmumZTAElW32OyPu
 CeQhpdsYH5jZ7t0ttpW0Z3AM/1B7UMNGVDIuCmAWOc8JoaI8eN+CTocNc4p0FOIR+QjT
 TXy1GsfBeP1XLTgq8N7LR15NzGMXxTf0d71DLX9NDgS5Oh/HR73WbbGO7C4Ph/J3R0Zf
 TFSnedZt+XmJsYCGpPHgowBVjRQsxkXjXinUdLMCaiaoPngWgv7Jp2Pwks1zCmRFyk4J
 B7DA==
X-Gm-Message-State: AOJu0YzueUmCv9Uh0rzrrqxIOaGjzwM9iCQ8FB/P4LE5MIOGQEXn2iCz
 sloxofRny/73+ck78HbD4u0DBh95QpeebtEVw3ndcg==
X-Google-Smtp-Source: AGHT+IGV5loPqDHjTwlALM8KRg2R1WEm2hG/4806sN8v1yetiEv/EdgwW9Dvp2GdyLoXWyZB/SNTf6mQwPO+zQU0Y7U=
X-Received: by 2002:a67:c291:0:b0:457:d479:574d with SMTP id
 k17-20020a67c291000000b00457d479574dmr17336701vsj.12.1698927929856; Thu, 02
 Nov 2023 05:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 2 Nov 2023 17:55:18 +0530
Message-ID: <CAFA6WYNx46zQaA_DFbRs4v-9jKKoUoMavO42hQFxmm76CvO9MA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] arm: mach-snapdragon: Qualcomm clock driver cleanup
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
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

Hi Caleb,

On Tue, 31 Oct 2023 at 03:53, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This series begins making some headway towards cleaning up Qualcomm
> platform support in u-boot. The following is a rough overview of the
> changes:
>
> * Move the Qualcomm clock drivers out of mach-snapdragon and into clk/qcom
> * Introduce per-platform clock driver configs to decouple Qualcomm platform
>   support from mach-snapdragon targets.
> * Add the IPQ4019 clock driver, removing it from mach-ipq40xx and introducing
>   the reset map.
> * Merge the qcom reset driver is into clk/qcom and rework it to be
>   compatible with upstream devicetrees.
> * A callback model is added so that multiple clock drivers can be
>   compiled in at once.
> * SDM845 gains support for enabling/disabling all gate clocks (CBC's) by
>   way of a new "gate_clk" abstraction.
> * Preperatory cleanup work is done to simplify the bringup process for
>   new platforms.
>
> Further details are included in each commit.
>
> The primary goal of this series is to prepare for enabling several new
> Qualcomm platforms in u-boot as well as additional peripherals, while
> minimising the amount of copy/pasted board-specific code.
>
> This series conflicts with a previous series introducing support for the
> Qualcomm RB2 board [1], I plan to resend this initial support pending
> acceptance of this series and several other cleanups.
>
> [1]: https://lore.kernel.org/u-boot/20230324080418.3856409-1-bhupesh.sharma@linaro.org/
>
> ---
> Changes in v2:
> * Added missing headers in clock-qcom.c for "fix rcg divider value"
>   patch
> * Use writel() instead of setbits_le32() in "fix rcg divider value"
>   patch to ensure that writes are propagated to hardware.
> * Adjust RCG configuration to be more similar to Linux
> * Remove sysmap headers and define macros directly in platform clock
>   code.
> * avoid renaming msm_* to qcom_* for now
> * only add relevant gate_clks for sdm845
> * Link to v1: https://lore.kernel.org/r/20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org
>
> ---
> Caleb Connolly (6):
>       clk/qcom: move from mach-snapdragon
>       clk/qcom: move ipq4019 driver from mach-ipq40xx
>       clk/qcom: sdm845: add register map for simple gate clocks
>       clk/qcom: use function pointers for enable and set_rate
>       clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
>       clk/qcom: fix rcg divider value
>
> Konrad Dybcio (1):
>       clk/qcom: handle resets and clocks in one device
>

This patch-set fails to apply on the u-boot mainline for me. Care to rebase?

-Sumit

>  arch/arm/Kconfig                                   |   2 +
>  arch/arm/dts/qcom-ipq4019.dtsi                     |  14 +-
>  arch/arm/dts/qcs404-evb.dts                        |  19 +-
>  arch/arm/mach-ipq40xx/Makefile                     |   1 -
>  arch/arm/mach-ipq40xx/clock-ipq4019.c              |  88 ------
>  arch/arm/mach-snapdragon/Kconfig                   |   4 +
>  arch/arm/mach-snapdragon/Makefile                  |   5 -
>  arch/arm/mach-snapdragon/clock-sdm845.c            |  98 -------
>  arch/arm/mach-snapdragon/clock-snapdragon.c        | 181 ------------
>  arch/arm/mach-snapdragon/clock-snapdragon.h        |  48 ----
>  .../mach-snapdragon/include/mach/sysmap-apq8016.h  |  39 ---
>  .../mach-snapdragon/include/mach/sysmap-apq8096.h  |  37 ---
>  .../mach-snapdragon/include/mach/sysmap-qcs404.h   |  88 ------
>  .../mach-snapdragon/include/mach/sysmap-sdm845.h   |  42 ---
>  board/qualcomm/dragonboard820c/dragonboard820c.c   |   6 +-
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/qcom/Kconfig                           |  52 ++++
>  drivers/clk/qcom/Makefile                          |  10 +
>  .../clk/qcom}/clock-apq8016.c                      |  60 +++-
>  .../clk/qcom}/clock-apq8096.c                      |  56 +++-
>  .../reset-qcom.c => clk/qcom/clock-ipq4019.c}      | 160 ++++-------
>  drivers/clk/qcom/clock-qcom.c                      | 309 +++++++++++++++++++++
>  drivers/clk/qcom/clock-qcom.h                      | 100 +++++++
>  .../clk/qcom}/clock-qcs404.c                       | 167 +++++++++--
>  drivers/clk/qcom/clock-sdm845.c                    | 190 +++++++++++++
>  drivers/reset/Kconfig                              |   7 -
>  drivers/reset/Makefile                             |   1 -
>  include/configs/dragonboard410c.h                  |   1 -
>  include/configs/dragonboard820c.h                  |   1 -
>  include/configs/dragonboard845c.h                  |   1 -
>  include/configs/qcs404-evb.h                       |   1 -
>  .../{qcom,ipq4019-gcc.h => qcom,gcc-ipq4019.h}     |  73 +++++
>  include/dt-bindings/reset/qcom,ipq4019-reset.h     |  92 ------
>  34 files changed, 1057 insertions(+), 898 deletions(-)
> ---
> base-commit: 30d01b582f2274eb8c808026c5fb4c33e9f2210d
>
> // Caleb (they/them)
>
