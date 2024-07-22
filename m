Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715A1C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 10:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B705287EFA;
	Mon, 22 Jul 2024 12:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="JjQcN5Sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C6787F82; Mon, 22 Jul 2024 12:08:59 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5053C87E50
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 12:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52efc60a6e6so2260712e87.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1721642936; x=1722247736;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nQjMvPb4Y9vGOyi5AspPKr3a0lJJCwL1Za1fvW0YMIM=;
 b=JjQcN5Sdfv0yLsd3s+jW/J9Popx4ZTAXk8FPf5f4ul1HcMaexqfwAYHJzoUNueYWCj
 jP0FHWMIojTIEgCHmeYFgrml6s6Un8AT3kXCyJcEAygMWZnLITFWeH8oYmfZhsFLkKPO
 atBTKHhB6aPpBPr7px9kVk/y4qW1jPnG8xTIxL4a1eHC8pBg7D1jfITbtPxp6fecAT6X
 JgDMgt40aXIqImR/PBDSX/Sdigxo7WscYrDzc47ZejfRfbI34oLqedhS6XlZYXTeECUa
 MUXGH3+MVOs3og8HBqJk1AMiE3BvyKkMT+PGE1P1EXNSEYPcc8ZhLW0UqKM5nclgPdQo
 MfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721642936; x=1722247736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nQjMvPb4Y9vGOyi5AspPKr3a0lJJCwL1Za1fvW0YMIM=;
 b=lWw0JtRFmEe8lC+tHkktqLjzM7ePPraCs6TMYcrzZ2EkD+vlN5LlPMJAiRjJXAfsBK
 jMG9RkWl3Br8e2oKdIrvfntK+oUJIdAghQW9gQJLEK8hmhEZDHq+axhtJpzUQHBIVWNO
 US3P3WVs3QV2JdPgQhhlVxCjP31LbaNc1ZX/TxRKs3WWs8/kkWZNKjQgTHzB5klcZlHI
 QBaOWooW0SKItpgt+UoycdGJStn/EJ1QuRVftDswKYo0PyxQbzfbYwqBp6yqDR2SEYAR
 wS4sC0Yqu9aY0+Bgcb1y8qJQLI3po5M66Qx+e4xaqcVH1g6//n0uPR70XUVrtc4jBxNu
 z+yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqD+/D5TJE0oF6IGBVzpFUtPCgQYxVRqT1MwREjbC0JDHQF/q0q7Xjr10rqfG3z2bvqXmNcleivLrczQ6afpdnIQ43mw==
X-Gm-Message-State: AOJu0YyYJsit59rqUz6/G+h3CMSryISwmKRR7CWAoiixLN+dnNioYdYu
 zTzEDLIowFmKpqpjGKi9P7yj9l6cQJaVStVP9JkMCE+HeGtBSKvbpx74gGTO/A==
X-Google-Smtp-Source: AGHT+IGSvFULDFDh+4XDASSdDZbbvM3G+zPF6CKr2z+araIJ40CyjeIx7pwW7xZUldHsk6gqy29mdg==
X-Received: by 2002:a05:6512:e8e:b0:52e:9cc7:4461 with SMTP id
 2adb3069b0e04-52efb52266fmr3440536e87.5.1721642936419; 
 Mon, 22 Jul 2024 03:08:56 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c91db6asm408187966b.148.2024.07.22.03.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 03:08:56 -0700 (PDT)
Message-ID: <20d1a83c-9463-40b6-b0b6-e43c57614b8f@monstr.eu>
Date: Mon, 22 Jul 2024 12:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/37] board: xilinx: Remove duplicate newlines
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
 <20240719104948.323791-37-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20240719104948.323791-37-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 7/19/24 12:49, Marek Vasut wrote:
> Drop all duplicate newlines. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
>   board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c | 2 --
>   board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c    | 2 --
>   board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c    | 2 --
>   board/xilinx/zynq/zynq-zed/ps7_init_gpl.c      | 2 --
>   board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c     | 3 ---
>   5 files changed, 11 deletions(-)
> 
> diff --git a/board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c b/board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c
> index 602a789e775..e7f1d6ef5ec 100644
> --- a/board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c
> +++ b/board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c
> @@ -4060,7 +4060,6 @@ unsigned long ps7_post_config_3_0[] = {
>       //
>   };
>   
> -
>   unsigned long ps7_pll_init_data_2_0[] = {
>       // START: top
>       // .. START: SLCR SETTINGS
> @@ -8263,7 +8262,6 @@ unsigned long ps7_post_config_2_0[] = {
>       //
>   };
>   
> -
>   unsigned long ps7_pll_init_data_1_0[] = {
>       // START: top
>       // .. START: SLCR SETTINGS
> diff --git a/board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c b/board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c
> index 9343683f4d7..48001269cd7 100644
> --- a/board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c
> +++ b/board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c
> @@ -4167,7 +4167,6 @@ unsigned long ps7_post_config_3_0[] = {
>       //
>   };
>   
> -
>   unsigned long ps7_pll_init_data_2_0[] = {
>       // START: top
>       // .. START: SLCR SETTINGS
> @@ -8483,7 +8482,6 @@ unsigned long ps7_post_config_2_0[] = {
>       //
>   };
>   
> -
>   unsigned long ps7_pll_init_data_1_0[] = {
>       // START: top
>       // .. START: SLCR SETTINGS
> diff --git a/board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c b/board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c
> index 6b153aa3796..76ef5d9323e 100644
> --- a/board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c
> +++ b/board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c
> @@ -4136,7 +4136,6 @@ unsigned long ps7_post_config_3_0[] = {
>       //
>   };
>   
> -
>   unsigned long ps7_pll_init_data_2_0[] = {
>       // START: top
>       // .. START: SLCR SETTINGS
> @@ -8421,7 +8420,6 @@ unsigned long ps7_post_config_2_0[] = {
>       //
>   };
>   
> -
>   unsigned long ps7_pll_init_data_1_0[] = {
>       // START: top
>       // .. START: SLCR SETTINGS
> diff --git a/board/xilinx/zynq/zynq-zed/ps7_init_gpl.c b/board/xilinx/zynq/zynq-zed/ps7_init_gpl.c
> index 6f2edf16c24..67642798b41 100644
> --- a/board/xilinx/zynq/zynq-zed/ps7_init_gpl.c
> +++ b/board/xilinx/zynq/zynq-zed/ps7_init_gpl.c
> @@ -4026,7 +4026,6 @@ unsigned long ps7_post_config_3_0[] = {
>       //
>   };
>   
> -
>   unsigned long ps7_pll_init_data_2_0[] = {
>       // START: top
>       // .. START: SLCR SETTINGS
> @@ -8195,7 +8194,6 @@ unsigned long ps7_post_config_2_0[] = {
>       //
>   };
>   
> -
>   unsigned long ps7_pll_init_data_1_0[] = {
>       // START: top
>       // .. START: SLCR SETTINGS
> diff --git a/board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c b/board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c
> index 04d2e5f1375..6a3236ce2d2 100644
> --- a/board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c
> +++ b/board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c
> @@ -4082,7 +4082,6 @@ unsigned long ps7_post_config_3_0[] = {
>   	/* */
>   };
>   
> -
>   unsigned long ps7_pll_init_data_2_0[] = {
>   	/* START: top */
>   	/* .. START: SLCR SETTINGS */
> @@ -8313,7 +8312,6 @@ unsigned long ps7_post_config_2_0[] = {
>   	/* */
>   };
>   
> -
>   unsigned long ps7_pll_init_data_1_0[] = {
>   	/* START: top */
>   	/* .. START: SLCR SETTINGS */
> @@ -12477,7 +12475,6 @@ unsigned long ps7_post_config_1_0[] = {
>   	/* */
>   };
>   
> -
>   #include "xil_io.h"
>   
>   unsigned long *ps7_mio_init_data = ps7_mio_init_data_3_0;


Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs


