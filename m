Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A59C61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 07:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ADF260829;
	Wed,  2 Sep 2026 07:26:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sTtZ2uB41XgF; Wed,  2 Sep 2026 07:26:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788334002;
	bh=4BG0s4frpPuQ1r4+CFqUtBmdLvhT7NvShngZkBYLeYs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YhUhCflea95vI/ycIibaVvgXcNlQltl/P3URq4Xe0mMGLxi4EBiltKzpzU+jI/Cr1
	 VZLK5hhyHvWuyG1XcQqeVcDBlNVDHF0qE63+BsFR8pm2k3H3nSXblaVW4rQe4j9AIU
	 MhwY2jsrzcUrwGlX1tVz7ZsUijEevMrMMMBoIFy//BGkGeQ9uy5S/JrfYIEhtgW6Hu
	 L3oK8HHXG3cs3GyWJfz/ig6rXiAGD9nMKrEKQLOTqSmXjEuZtvPFeIB2P6gGhjbSlA
	 BkA2qKnIQ3wAJlo3a2+VIK/3Obp57jyPbr5qV16q5uIxciPFz8D6aLXfVpWDzfHch1
	 JJVUq4HPBLqvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7152A6080F;
	Wed,  2 Sep 2026 07:26:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D98D755
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D511607FB
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3CkWf1zTb4IU for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 07:26:40 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=gGFKFkLo
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0065C6080F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:26:39 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15e592da74so76462466b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 00:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1788333997; x=1788938797;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4BG0s4frpPuQ1r4+CFqUtBmdLvhT7NvShngZkBYLeYs=;
 b=gGFKFkLoK3gY1lV+30XJck07lavf+g5H80BUSqvxQpy8e5bZ91B1B+MUaIkkft3fHe
 o4jwuPzkkFDZlO9LisBTYM99RLcLeki+sYpbMckl7HhbfAtgHkNfAi/8bqbD3Zmvjoxu
 FJArGnDMECbAATXlW+71wlA3MM3kzk1/XaWEWBuhQ8vtEuO8klb0PBKZW5IV9ORnWhjk
 7e17fCT39uz+foiHIuz1MYZL7y8wwPTvIGn8bRYsCO1pufKJ6FQgtntBqvHYrYFcZCC0
 4gOLn8DEoNoPri3GHnFx58MAtvECb9gAB+XUiUQxbVlfW9NTBZmJP7eiEVYpGzh4badp
 awMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788333997; x=1788938797;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4BG0s4frpPuQ1r4+CFqUtBmdLvhT7NvShngZkBYLeYs=;
 b=pf4Uxe4OPol8K9036i06Oh7+4/2/O5eRC6z3hQQ8bqeRVmk5DjqBnmjWxWNnuAIDGj
 g0EJ5Z8OTYNa2j/xgJjHGpC3y7C91+o1ylDV3QpGL36SLu6bvhsuBxuGUrR9G422qqnG
 80KuqX3pEB/SG4cAjyGRUsqNL2HrlYdWRmklHbpnNiIePICop8eb13BbB2Wt2fIMi0sr
 Wd3p7j255Q/qGdtnXt2pOoHQIzMZ9iUNqZWRsL5fQJj41e8v7V+gDkKWRSgdFUi7KBCF
 76e2F3NyIkSEIb1byJwSm7Z63q4lO8rsw7zA6MvAMUxVQHjXJRriQMNycRmXzbevUlZe
 Tj4A==
X-Gm-Message-State: AFuF++ksl5w1a/+g4WsG3YZ41JS7+Io8meee7GMb6BQYE8+4BgV8/rnr
 y284CO96pXG/nDIAo1eHPlLpxXcxAAUJ9ARQw+yWwk/+tN1z7jAWg9Uy7Ox/WFgNssReXuzeAfJ
 OH6XMGTJr
X-Gm-Gg: AYBFou3pd9XJIqsi0YnxmTZkYmQtJ0t3IJRi8lQ12RmsSbxbopIeevTTX7TX2Zmbnae
 mRst8pON4vU8UMJRR4jnrsIMHrax1xcyG9DORXDkzt0vyABa6CfV84FKURucu57TkD1gfu9sxYi
 +cNl/OkR5XiuL4rykK6a6FbqJqBrroGEzmozXCeOzZTJ1hQxMlU3ZLaGT4rBbgz/USgkuxFp2Ly
 SsPjLaAtNLgxjGre48corUk1X/dhzSo/smk66ojVsuSF8QPYS8NQqxVzxU3sJDQUnENHmHVq70d
 A/bcU3JKM+0Mg7cAXRwelIsbuvTvcyExRXQamdilfAzRwp6fIE0Pf1FRxtGTddltkWsu6Hff7V/
 cpFOb2urK0OE9k4ks2VEcMXbmP1SnwA6x9fQrzZGvBc8c/A0kdCfogGE8GoEbQvEb/BigFhcUFr
 WdTNvMtqklKBezaheQJbz3uDwQLLt+gCJgD3xf7VykQd/G9b8wgcPHQt/SynIB/79qPhw4vTFAh
 +fBJdlWOn+2mE/nRt3NKgHFfggti9OUG9tBjT1kSRttAA==
X-Received: by 2002:a17:907:7243:b0:c16:14d1:b529 with SMTP id
 a640c23a62f3a-c25d55fe069mr139495566b.18.1788333997371; 
 Wed, 02 Sep 2026 00:26:37 -0700 (PDT)
Received: from [10.0.0.13] (89-24-185-125.customers.tmcz.cz. [89.24.185.125])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d002df62sm81696066b.15.2026.09.02.00.26.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 00:26:36 -0700 (PDT)
Message-ID: <c6495ace-4c3b-4da5-baec-a4c7a4331e88@monstr.eu>
Date: Wed, 2 Sep 2026 09:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: xilinx: versal-net: move
 platform_id/platform_version to .data
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <067b90dbb09718c8c9b73a049702e2df30544849.1787745885.git.michal.simek@amd.com>
 <5908d1dcf2a650cac2b22d82e7f789b978f70748.1787745885.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <5908d1dcf2a650cac2b22d82e7f789b978f70748.1787745885.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/26/26 14:04, Michal Simek wrote:
> From: Suraj Kakade <suraj.hanumantkakade@amd.com>
> 
> platform_id and platform_version are plain uninitialized statics,
> placing them in .bss. U-Boot's linker script overlays .bss at the
> same address as .rela.dyn (the relocation table), which is safe only
> if nothing writes to .bss before relocation completes.
> 
> soc_detection() writes these variables during early board_init_f(),
> well before relocation, corrupting live .rela.dyn entries. When
> relocate_code() later reads the corrupted entry, it writes to an
> invalid, unaligned address. QEMU 8.x tolerated this silently, QEMU
> 10.x enforces alignment checks and traps it, causing U-Boot to hang
> right after printing "DRAM:  2 GiB", never reaching the console
> prompt.
> 
> Move both variables to .data via __section(".data") so they no longer
> share an address with the relocation table.
> 
> Fixes: f6aebdf676ed ("arm64: versal-net: Add support for Versal NET platform")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-versal-net/cpu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
> index 7df7c49ac711..1555751da2e8 100644
> --- a/arch/arm/mach-versal-net/cpu.c
> +++ b/arch/arm/mach-versal-net/cpu.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2021 - 2022, Xilinx, Inc.
> - * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -151,7 +151,8 @@ u8 __weak versal_net_get_bootmode(void)
>   	return reg & BOOT_MODES_MASK;
>   }
>   
> -static u32 platform_id, platform_version;
> +static u32 platform_id __section(".data");
> +static u32 platform_version __section(".data");
>   
>   char *soc_name_decode(void)
>   {
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> branch: xnext/data_section
> 

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

