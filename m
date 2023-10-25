Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2D1C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 12:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6124C86EF1;
	Wed, 25 Oct 2023 14:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hey08UCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D95786B75; Wed, 25 Oct 2023 14:10:38 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0300586EF1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-457c19ebb3aso2039405137.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698235833; x=1698840633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/XjQwMSrpveSNtOfgwJcjVLRj1OJBrqOs6s7vuBGiYI=;
 b=Hey08UCwa/fH8/Vt/bN4dvsFrc+mXsD9Qb7y4xtGC+0oHO7cOb3s27wys5kvhl8LV2
 CqlncSoWcJKiOSKpm14J+5RrLmgtzAKR9DwWKV17bcfLMnx/Bx/tvXY5IPu1HywKOIDC
 E1bBYcpFi0t//2EJz7it4uQOrHSiHG86G6ISm6m9rmoJzgye2FW2BBYCt7fCVTxXXSZc
 4PVv/ftZFiw/xQmSmFpQ2dPe0E4hy45xvwHxpd4TLgkPEJFihSayFA+P166nOanm9ngE
 NTkkjwu3Un1ZiK3QFW4xkJ5T0E38JLyilHokPynHeCBEi8LpHevI6fHBDNmHTq3WPkPt
 nmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698235833; x=1698840633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XjQwMSrpveSNtOfgwJcjVLRj1OJBrqOs6s7vuBGiYI=;
 b=m80UOnsixYIjLPInWoUbVHYtRKmwHF/vMSxuI7/eRW662PQLMO94jQXL/Dp1MpSeZB
 EIaw/V6Z/Xh4lkkBPqxSCmZCrXQncfasIEWVYwUmVyY13FCaO1x0gBWGb30i5JLzeu9P
 P1jyumjUx8ej00yTUA6vhG/59Zy52cH7wWOFqmf56w4SCXqTKcHfK6ZZUWPpD6QcLT89
 rvWwCldgNNtYcGQ4L1WLWbrCFb7FFSbnIVhEG2bXq9yX6NkPtNDJW15vOr1nAFePR7Qs
 +nT07kRiieL9gYrcr0hykdwSwWvyy0z9e8WMtNuWcZyQWwJrYehy08kEkaBRwWVODbXQ
 mJOA==
X-Gm-Message-State: AOJu0YxnvgpjCIVyqyp8ra23ehlf17t1irJu3Etn/NXCu4RjaARu+yB8
 fvgsxXj8a1VjV7JnomVPOYxulqkkhPjsfE+LlFZ3rg==
X-Google-Smtp-Source: AGHT+IFLWkNK1O+btOFA61S8rcs7TgCyLYCH3DYRo7AjPUqWCdGt2R2UMBnLxm8GG3piVVW2CBo+h7yfUoz22TRt7qY=
X-Received: by 2002:a05:6102:5d:b0:45a:98d9:38ea with SMTP id
 k29-20020a056102005d00b0045a98d938eamr5266001vsp.16.1698235833243; Wed, 25
 Oct 2023 05:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 25 Oct 2023 17:40:22 +0530
Message-ID: <CAFA6WYObsw7M+j6miQWYLVxd97v-d-RGwtBK+Ygk9v0W41ygNw@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm: mach-snapdragon: Qualcomm clock driver cleanup
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Konrad Dybcio <konrad.dybcio@linaro.org>
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

On Wed, 25 Oct 2023 at 01:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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

Thanks for your cleanup work. You should have at least CCed the board
maintainers (board/qualcomm/*/MAINTAINERS). Were you able to test this
series on all the existing Qcom platforms supported?

>
> Further details are included in each commit.

I will give this series a review.

>
> The primary goal of this series is to prepare for enabling several new
> Qualcomm platforms in u-boot as well as additional peripherals, while
> minimising the amount of copy/pasted board-specific code.
>

I suppose this series would move us closer to directly importing DTs
from Linux. Do you plan to close the remaining gap (serial DT nodes
are on top of my head) before adding further platform support?

-Sumit

> This series conflicts with a previous series introducing support for the
> Qualcomm RB2 board [1], I plan to resend this initial support pending
> acceptance of this series and several other cleanups.
>
> [1]: https://lore.kernel.org/u-boot/20230324080418.3856409-1-bhupesh.sharma@linaro.org/
>
> ---
> Caleb Connolly (7):
>       clk/qcom: move from mach-snapdragon
>       clk/qcom: add per-platform configs
>       clk/qcom: move ipq4019 driver from mach-ipq40xx
>       clk/qcom: sdm845: add register map for simple gate clocks
>       clk/qcom: use function pointers for enable and set_rate
>       clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
>       clk/qcom: fix rcg divider value
>
> Konrad Dybcio (1):
>       clk/qcom: handle resets and clocks in one device
>
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
>  .../mach-snapdragon/include/mach/sysmap-sdm845.h   |   3 +
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/qcom/Kconfig                           |  52 ++++
>  drivers/clk/qcom/Makefile                          |  10 +
>  .../clk/qcom}/clock-apq8016.c                      |  41 ++-
>  .../clk/qcom}/clock-apq8096.c                      |  41 ++-
>  .../reset-qcom.c => clk/qcom/clock-ipq4019.c}      | 165 ++++-------
>  drivers/clk/qcom/clock-qcom.c                      | 303 +++++++++++++++++++++
>  drivers/clk/qcom/clock-qcom.h                      |  96 +++++++
>  .../clk/qcom}/clock-qcs404.c                       |  97 +++++--
>  drivers/clk/qcom/clock-sdm845.c                    | 265 ++++++++++++++++++
>  drivers/reset/Kconfig                              |   7 -
>  drivers/reset/Makefile                             |   1 -
>  24 files changed, 938 insertions(+), 605 deletions(-)
> ---
> base-commit: 30d01b582f2274eb8c808026c5fb4c33e9f2210d
>
> // Caleb (they/them)
>
