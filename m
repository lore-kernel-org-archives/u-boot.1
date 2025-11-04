Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0B5CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 10:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565238144A;
	Tue,  4 Nov 2025 11:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ly3+6oAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F3A9836D1; Tue,  4 Nov 2025 11:31:27 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 155BC8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 11:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b6d4e44c54aso702286666b.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 02:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762252284; x=1762857084; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4KmBj2O87f5D87GY1TjfxwLKUwpUgKyxFBzq6XCIUn8=;
 b=ly3+6oAEZMrWDp4eNGt29LcmDzG27hoWZZYajsmAEPi1nXcNK8lNdb7grH7dHNJh0x
 SksM3A+frflc/MqmeUW6Ru35jY61Dah3bV9mlUSVuK1FerLoB/Uw3hvHkFNJtXaVviui
 2RM3yNkRzLpkMmY3QIdOZ3pH3wmJ6wqvdqIh1/2i8DsoEMdAbXZGbSbrIco6CImP884b
 Qo4dG7g8j/iTsskx+4sC5AWAZUD4ROn1nzjs20FwkXTrv3KDR2XPxDBBPzMmjg7HOgf/
 vsmLXLwCQhCymcmIw++Z+STz4RmbCjytDEJz9KZ4H3xxb2HdCtlygq2XXHWugUuGFEhA
 lJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762252284; x=1762857084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4KmBj2O87f5D87GY1TjfxwLKUwpUgKyxFBzq6XCIUn8=;
 b=MS8TdFYlptHXdPzBVZ2XQkQi0FU4QWpY5/2SjvPjxei7DmvveXPlMzY9KGDDu/Uj0n
 Kpfw1Xnqlnr4saKzZmLOtSzdaQFHsTu3Kw6Xj1HloH7NAv/B3H8OzUMtkFYxf294ubyn
 RNRI7jv77IHDfiaoKh9gN+Vc2ooSYk5+W+MSV4hx3wyoc8VM1+ReN1xnpbMc1edCuS9+
 eYzRkJ/Hu8Z+sX3j5Z8jtaNnVXQofsceMn4o3Z3KuKi3Vqwx+Dj2VSoUGg8AqbhqBeiF
 lo9GBA+Vpx0iisoZVn8kc+xYJoIYJGMOCmlIOMT3LwhrsQtyD+JbD0Zk6hjuCLxbBFrs
 p2cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaUyGlUYy08h9UTvYou3BpZL/F44Ht9Mv/+zXuKM2d5kTvoTwAxQ3hFYl09nuZl5/FwJ0S3xs=@lists.denx.de
X-Gm-Message-State: AOJu0Yww6xH+pjsoym+pQQKS8PqNMe7wjjPck1QlWn7pLM6dgESC4g8v
 vxDdhhEN6rcen5ut4KvqBUE0XHqYKGbmO3aDwdLRpTSPzGXg1IZb0B6G
X-Gm-Gg: ASbGncsA+UxPoUm2oilAU1ZmlwO6aPsQKc5+3ba0+scg2L84zoDfTD8EVITqcrvqHD6
 OMTG3K+naoT2HYBuwWnXVtwLIbucNPsbuCW//HLr17r2lFcy1YTklLSLPpZKUrS03djFF0aZdoN
 Pzan2hLVzsXU3cGJNHzwojt5/Bn1PNAmrnBSqLqkFuUd68BdnVC0sSoJDzThUv5ne3yEcyQ024Z
 eJ3ubOahRrUsiA4Y0FL3i4Ncr38Y7C9OIV1r/O1aXrBrI4Rw/mdU+MXUJN/yE+FymZ5kZx6Td2/
 w/LBtuFLBtVPJEuBSk7NgyllS7zYhCBfqf4bm7aVKlBqJTjIs0cqU4GQfPh8G6ryb74SGegefAw
 lTGdGSh2gshbCkWOK1Ei1+vjy6C9Huiu8kXJbxMdXQ7Zz+Wp+hO9Rj+FIksUWUzc8MwuzSPlWES
 8bqcTHbZenl6OemT9PhtQIxW5go4nIs0d47ZGWPyy6+bAM6cFZ/u2s
X-Google-Smtp-Source: AGHT+IFg6BjSq7Y7/lbCPcmGvuHI80ShwYAvmIpDQeOpF1hBZDa1jNlgV8T7YHwniPql+nOijIZ58g==
X-Received: by 2002:a17:907:9482:b0:b70:fede:1b58 with SMTP id
 a640c23a62f3a-b70fede21e9mr599795666b.2.1762252284201; 
 Tue, 04 Nov 2025 02:31:24 -0800 (PST)
Received: from ?IPV6:2001:b07:aac:705d:43cc:7fdf:1c4c:b2a1?
 ([2001:b07:aac:705d:43cc:7fdf:1c4c:b2a1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b724034ade7sm171369866b.69.2025.11.04.02.31.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 02:31:23 -0800 (PST)
Message-ID: <b8f377dc-7ddb-49c6-a480-a2bc13503b09@gmail.com>
Date: Tue, 4 Nov 2025 11:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: armv8: mmu: fix mem_map_from_dram_banks
To: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Moteen Shah <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
References: <20251031-k3_fix_mmu-v1-1-3f3cb6f8b3dd@ti.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20251031-k3_fix_mmu-v1-1-3f3cb6f8b3dd@ti.com>
Content-Type: text/plain; charset=UTF-8
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



On 31/10/2025 17:17, Anshul Dalal wrote:
> mem_map_from_dram_banks calls fdtdec_setup_memory_banksize to setup the
> dram banks though that is expected to be done by dram_init_banksize as
> part of board_r sequence.
> 
> This has the side effect of modifying gd->bd->bi_dram as well, therefore
> this patch removes the call and updates spl_enable_cache for K3 to call
> dram_init_banksize.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Closes: https://lore.kernel.org/u-boot/20251027165225.GA71553@francesco-nb/
> Fixes: fe2647f2a0d4 ("arm: armv8: mmu: add mem_map_from_dram_banks")
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 6 ------
>  arch/arm/mach-k3/common.c     | 1 +
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 672ec16d4834be501d5bfa343af9537aa9285252..0309da6d3971af6f2a349ce0760507765da9af4f 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -61,12 +61,6 @@ static int get_effective_el(void)
>  int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 attrs)
>  {
>  	unsigned int i;
> -	int ret = fdtdec_setup_memory_banksize();
> -
> -	if (ret) {
> -		log_err("%s: Failed to setup dram banks\n", __func__);
> -		return ret;
> -	}
>  
>  	if (index + CONFIG_NR_DRAM_BANKS >= len) {
>  		log_err("%s: Provided mem_map array has insufficient size for DRAM entries\n",
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 7c06764af8256b7fd27f8e7f208a597b1b91652b..82a31b5178b9b5abdf7eae68cbbd22fe2a86dbee 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -311,6 +311,7 @@ void spl_enable_cache(void)
>  	int ret = 0;
>  
>  	dram_init();
> +	dram_init_banksize();
>  
>  	/* reserve TLB table */
>  	gd->arch.tlb_size = PGTABLE_SIZE;
> 
> ---
> base-commit: 08bf42e1faa4411cd347c2e370da790a0116e318
> change-id: 20251031-k3_fix_mmu-bd62988ed62d
> 
> Best regards,

Hello Anshul,
this effectively fixes the regression.
Thanks!

Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
