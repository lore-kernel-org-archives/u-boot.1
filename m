Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE34C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4CC81FEE;
	Wed,  2 Jul 2025 08:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M1AQ1Kz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E486B8206E; Wed,  2 Jul 2025 08:38:56 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C29A18003E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-711d4689084so70067017b3.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751438333; x=1752043133; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v378iAwHoCdaWrt8W7BFT9h9SO/8WQiHGn1H6/QF3ZA=;
 b=M1AQ1Kz9Zv2zwt8oYvLu43hQ6OGUUi/Bj5hH9JZwl39YGxHfX43RlhzTMoA3Wq+W4s
 t0z5EMrIEsLqVPRHOtGi4MhV1gq+dWIimcDO95tO0CTrFXZWhBGoGg7dSaFEoTXEc8ct
 P51giWfVhaXj8ectGSU5tvSAPMc6NnSt/sFLkjCrObQQmL2XXmB2T2zIXyHLT7uQVJBP
 hKNWTV/u/ANRidPMWS81hjQLo1uJ4C0PaXQp0lfxkefQNSwKSXzApTeVqBZaiHowwfZ5
 lrhODmmWUCRbbAnD2SlXpfYk31N9FCSUxXosAMJRXw9IqWQNm07ZSVmeakNPOegisSNq
 jnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751438333; x=1752043133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v378iAwHoCdaWrt8W7BFT9h9SO/8WQiHGn1H6/QF3ZA=;
 b=PatQa9OucVlJKebcSjgTd66PH1Y1WBx9sIgYj0QDDt10hvXcuEIdQnRJeInyfGuejW
 9XHFdW5OmQ2Wq998CpXwK9lkKFt69ftxfT8nd2ic+S/GFfCiUh5SmPHz885zK1xtxc3q
 7Wat/EfyRxM+pPjEDglVQd1Jxk/V3jai9I5rHoyFygTDuALEXduhIWTITg1mQsSzwnu0
 E0f5QtjM2iZoS23XYGoJZtDCMOMO07RZQwPNTj0hcHFiQYSreybowruNPlHaui+++quX
 92Pnt89/OO++c9aOLbDzb0DZj+Xl2WMIzANSGb5pdsOpz7qCRALvRLRi8E489wmUY5Vt
 WWrQ==
X-Gm-Message-State: AOJu0YxjhiNQufrBnpJwsCQQxrWQMQQ13m7Tg7VwnS0PZGoVCdSe9JGD
 lHo7qjIf12qGZdZ14ETL2Mg7AVf/u89t7ZuDseesH6Hlls33ZMyD9S2D5rxGjDGLMl24fQF9Gaf
 25gvmfSmHVSU+3QOOvNXlwuLw+DbaUXf17vG85t3hjA==
X-Gm-Gg: ASbGncuf36gmaXULOEMUi90rOWlpVCZXpctjipNgbBNf+us3wFQJOApzc0tuGozmHXM
 ttkB1YdWP+bL9FaCE6gYwJYrgVo3wMOlrbA4RccWluGlhLTv2xpSV1KGctPRXd+nkgBYnrfyyEk
 T0F5VMFNmyubawz7nQl4TDfhTpX8s/2niBj2mIFaiSsP8N
X-Google-Smtp-Source: AGHT+IGJeg/e9csWkTxQyBRUT5mqFpdfiDh5TLBooObya7DHUftQj6WtFPTRMHhKDmNIaBlMtu9mbWiOyFZkurgMGMc=
X-Received: by 2002:a05:690c:309:b0:6ef:5097:5daa with SMTP id
 00721157ae682-7164d56acc2mr21885607b3.34.1751438333552; Tue, 01 Jul 2025
 23:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <8c1f0b439062476c609d8d30247041556c0b69f6.1751438036.git.michal.simek@amd.com>
In-Reply-To: <8c1f0b439062476c609d8d30247041556c0b69f6.1751438036.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Jul 2025 09:38:16 +0300
X-Gm-Features: Ac12FXza3SvgprGEga9Tu2i8TOCWToKv02-ER6eWmaWGTGpB7prVTsBg3-NdGaY
Message-ID: <CAC_iWj+abLHTd736=LxQ7-q1TnVuCJBcVY++cqG4KWuJP=r3ag@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: zynqmp: Enable rng-seed generation
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Anshul Dalal <anshuld@ti.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>, 
 Srinivas Goud <srinivas.goud@amd.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Michal

On Wed, 2 Jul 2025 at 09:34, Michal Simek <michal.simek@amd.com> wrote:
>
> SOM has TPM with RNG in it that's why enable rng-seed generation.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - Free alloc area in case of error
>
>  board/xilinx/common/board.c          | 34 +++++++++++++++++++++++++++-
>  configs/xilinx_zynqmp_kria_defconfig |  1 +
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 8ffe74299016..f258675d7772 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * (C) Copyright 2014 - 2022, Xilinx, Inc.
> - * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@amd.com>
>   */
> @@ -712,3 +712,35 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  }
>
>  #endif
> +
> +#if IS_ENABLED(CONFIG_BOARD_RNG_SEED)
> +/* Use hardware rng to seed Linux random. */
> +__weak int board_rng_seed(struct abuf *buf)
> +{
> +       struct udevice *dev;
> +       ulong len = 64;
> +       u64 *data;
> +
> +       data = malloc(len);
> +       if (!data) {
> +               printf("Out of memory\n");
> +               return -ENOMEM;
> +       }

Why don't you move the allocation just before abuf expects it?
You can get rid of the free() in case of failures

Thanks
/Ilias
> +
> +       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> +               printf("No RNG device\n");
> +               free(data);
> +               return -ENODEV;
> +       }
> +
> +       if (dm_rng_read(dev, data, len)) {
> +               printf("Reading RNG failed\n");
> +               free(data);
> +               return -EIO;
> +       }
> +
> +       abuf_init_set(buf, data, len);
> +
> +       return 0;
> +}
> +#endif
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 22ba8a7cc158..3e2ac6144050 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -46,6 +46,7 @@ CONFIG_USE_PREBOOT=y
>  CONFIG_SYS_PBSIZE=2073
>  CONFIG_BOARD_EARLY_INIT_R=y
>  CONFIG_CLOCKS=y
> +CONFIG_BOARD_RNG_SEED=y
>  CONFIG_SPL_MAX_SIZE=0x40000
>  # CONFIG_SPL_BINMAN_SYMBOLS is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> --
> 2.43.0
>
> base-commit: ebd8a8ae95f6dc8548139aafb975da553af3bd04
> branch: debian-sent3
