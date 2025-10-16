Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BF2CCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 17:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D414C83655;
	Thu, 16 Oct 2025 19:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cHsq0x+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F07F835FD; Thu, 16 Oct 2025 19:04:58 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B415835FD
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 19:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 91D013F718
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760634293;
 bh=FZkBwVbzhNqUvr8riSmOjaxjrslBL3ainTUjwkgPDsA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=cHsq0x+3Vn2aXp2j4sb5W5pHTMmp0ZzeRSM6ViJBco+CLy1xnK8fBkeLZJ2bT0f3L
 IcWAdLgh6HVSrcVKgh5xXL7LhPyv0oNfLWRC8yjkZ1JcDrpr3QrF536ufb7lEk/F88
 /sqWwpGgSwpHF3MgU1pxXU+o1tfo8BtmeGxOewzlh0wG5398aDIPmOQm2ygRhQTsXz
 99vy8s/dhbkPvvrAgmrQo1NOA2cqMpxXkwyiTy9W3CoPqJIKZBA3XnVXrUMiMrZya+
 6OBq6a3PltBtFDJGNCrP1lk18suboz0UGkNNcpQKqxfJ8DiMZUKWbfMXroGfAO215M
 U2KRWB0VKvN8/fDBHlSStIHZPKI5gEiAHdUZy2rvamagrtzsd9vSZMcVhJXyKTCKfr
 fle+3WAJ0j/HzC2op9Hs31FqyCDaVSpSQ6Tk2RdvHjnosQK6Wm0lP7CnyHdtmCoMNw
 UMxmpj+TnRns4p+mwByBrNKgvj7/ggmVGuobWN4YB6AjmHXqzaHQO7xVQzoJPkuScU
 nyNKs4gre8Q2lvL4huTJyInEe0Zm+tiAi3UHRSY0NNFSu7WfPaTRWUYGTNR8hMIZ9B
 S1QjGUal5KtXe03shb7QBjzzLuKqek7bb7KjQL1JGSoXi+Lx2bjNMzWPi04JO+H5sZ
 bTtsBPjQbV31Ilqb4XUV5wwI=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-426d3ee72f5so1000986f8f.2
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 10:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634290; x=1761239090;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FZkBwVbzhNqUvr8riSmOjaxjrslBL3ainTUjwkgPDsA=;
 b=CKqKTgLMkVK7S38242Ee0MKIl2uLF9Jk2Pc1trMVd9tntB3QV/yHAPMSDPiTX/q4EK
 DoyEetZIdNOSW4djn34DwPSlpQJn0MgouwpzHxT3AItQsM64tp/dgYZJcumZEEqFfev0
 600CiPq+XFN8F2lsMqpRtLaLqs0BP5zu3l693um6FiEB7n7B3MVCYTeJj8b56kBVJlqn
 ER6qj73/cupeR1eWsmuxYppbLQd6/LT0nuIKikch+z22NYgPJ6IG4VvNqIv7/ATOpx0Z
 aN76mVovvWK+o/9pcc5hzs5CWoLFrEXZJHuNkQvw6ZiUuwE7Yt3eoBU+pkjv5lg+K5Tk
 pvNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiiJWj8tkxtBnPcxtPVTsc5Qye0q47z8+hN5Woh1Efev+6AwxT/1z4Tsos2fjhAZR3M6RL8RQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4aYSL1qKtkwgnvVQVW1eO+Dw6WQNCAxEEg71wVHZwrO///+NN
 Exa1alQnRKd3SfE01hoDdX7VomXJfH0fvUtNqE8lq6Pefc/fsV0OUlhcao3dYQr8BMBnKZJHb95
 3s3LNaEJ1ej8og9L1xmClpZ7s9sye/S4sdgI94pW4wOnQjJ1J9eG1mn8gQ7wIXR7BNGCenlU=
X-Gm-Gg: ASbGncuIVBBo7zz/FHZ1IgHl+AHPXZV+8JmbvurcVgMbOUkWwVm5s+NS3v8+qZY3EKu
 7iv+EgFL+W+owd2chbCyM+52Zz2nEHFu6nK3UVaXRCBhJDKmdE+UHvnCe7pMZAI+dqlIufgCrvK
 A1yx64BJ7KhHH0kH5krL0oWl0dAictqd7pALocCpwFNapRdcqNHUKH7S7XTqF5ZoOCj6ZB0vsF8
 RK8qMfXeA2hXeeqE1qLd5Tnth0YlwnwDT0WHaPUGQ7zmVe/dmrHk34+xpHPGSRj0LONB0gI/XoO
 sdDXcXrrmey8wBrHErk5dVICUh96637L025oU8VlT6tgOlKmPHpTghNXJ6xxOZCyWn4KjGuU6XY
 DGwUKV27JyrJQKynlBLFugB04P/LTpPF52V+3i3r69JSlB3WICRqRD1XVz3ig78vluJXy/wKg
X-Received: by 2002:a05:600c:4e93:b0:471:672:3486 with SMTP id
 5b1f17b1804b1-4711787dfecmr6440455e9.15.1760634290539; 
 Thu, 16 Oct 2025 10:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESQJIwmCLIsNFss/avkKGckcznJAJSK03kwrDxxbh0Q0EvkC6vznjPUTt3OU08tHU9zAb/dQ==
X-Received: by 2002:a05:600c:4e93:b0:471:672:3486 with SMTP id
 5b1f17b1804b1-4711787dfecmr6440165e9.15.1760634290056; 
 Thu, 16 Oct 2025 10:04:50 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144d1765sm50110755e9.17.2025.10.16.10.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:04:49 -0700 (PDT)
Message-ID: <9fdc0e15-c37b-4f1b-8148-bf3de590be0c@canonical.com>
Date: Thu, 16 Oct 2025 19:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: consider CONFIG_RISCV_ISA_ZAAMO in SPL too
To: Yao Zi <ziyao@disroot.org>
Cc: Simon Glass <sjg@chromium.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>
References: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
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

On 10/16/25 18:58, Heinrich Schuchardt wrote:
> Commit a681cfecb434 ("riscv: Add a Zalrsc-only alternative for
> synchronization in start.S") changed the hart synchronization in start.S.
> It uses CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO) to determine which method to
> use. If the macro evaluates to true the old behavior is maintained.
> 
> The macro evaluates to false for SPL builds which was unintended. Use
> IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) instead.
> 
> This fixes a boot failure on StarFive JH7110 based boards.
> 
> Fixes: a681cfecb434 ("riscv: Add a Zalrsc-only alternative for synchronization in start.S")
> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Hello Yao,

It would be worthwhile to understand why your new method does not work 
on the StarFive VisionFive 2. I only addressed the Kconfig issue. But I 
suspect there is something broken in the alternative pass.

Best regards

Heinrich

>   arch/riscv/cpu/start.S | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
> index 6324ff585d4..87b3ff0f93f 100644
> --- a/arch/riscv/cpu/start.S
> +++ b/arch/riscv/cpu/start.S
> @@ -151,7 +151,7 @@ call_harts_early_init:
>   	 */
>   	la	t0, hart_lottery
>   	li	t1, 1
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> +#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
>   	amoswap.w s2, t1, 0(t0)
>   	bnez	s2, wait_for_gd_init
>   #else
> @@ -184,7 +184,7 @@ call_harts_early_init:
>   #if !CONFIG_IS_ENABLED(XIP)
>   #ifdef CONFIG_AVAILABLE_HARTS
>   	la	t0, available_harts_lock
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> +#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
>   	amoswap.w.rl zero, zero, 0(t0)
>   #else
>   	fence	rw, w
> @@ -203,7 +203,7 @@ wait_for_gd_init:
>   	la	t0, available_harts_lock
>   	li	t1, 1
>   1:
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> +#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
>   	amoswap.w.aq t1, t1, 0(t0)
>   #else
>   	lr.w.aq	t1, 0(t0)
> @@ -219,7 +219,7 @@ wait_for_gd_init:
>   	or	t2, t2, t1
>   	SREG	t2, GD_AVAILABLE_HARTS(gp)
>   
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> +#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
>   	amoswap.w.rl zero, zero, 0(t0)
>   #else
>   	fence	rw, w

