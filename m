Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960DAC98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 11:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 484CE60BAB;
	Thu, 24 Sep 2026 11:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UW9ZkfNrtaul; Thu, 24 Sep 2026 11:48:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6521D60B73
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790250502;
	b=E68/YpjQsvCWPUCvagXOOYFk0Ine4gxJaL6uDdDBWNMfMi3z9QK8YG1n7msYvYVUSHfT
	 fBOMdq9Mg+gV1C7NjR3Ov1HRfZoRXWHv7fm12Q1ln1HjInZdoDvx4SkCRmSmDz1M63Ns1
	 zJyA1lbuIE0r19dUHEjXaNKB8PVzOVwVgK+sEo6UHcQfraVB9ZuQQrIBG0W7DYjKFzCF/
	 e6QiXm4mWtDegO3Sn0MHibGx2710xuWzEGGQUWK7dJ0Ao4eZb6jNxZP/yd4BX4ECU4pEB
	 2PJeN0t6UUcZMfqvEjm+4Ul9/JO3a/R9G5l9QD+hHeAvgD9hWRj8zVazx+uJCeCPzcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790250502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h/I5KlOTnG4QXX5YzH77COh4IFWM9lzgAXuiz3+mZbw=;
	b=g/QcsklsjuTiclni+NstqjTPq8r3taa1bc73H3AXjg61BVGrO8X3Y2sTiGnq1QOiSuww
	 stQ76aBv9+8EDiJAda6EeAVcRF4XN8zxQGa++FVMrCyiaKOZIxU91LTBXLTB6B3RZEHW7
	 nA0QRU/TyeRFwcrXWqW0DBPRLqQ2hHYygzs+q81TlCF+Lp8PgVtUiyBd7rSYPa9BjOakr
	 +rC8G4KAU7/hzUMGXVzevtl9LvIAPifPL9mlWeQdYMZNqDHAYQaaP3eJnpnWecJs8FwZr
	 AeW4SX1OokN8GeY8kO/bLwnqMUvdU/sE3SA57Jc1iu4e/y2G7gxL/4EPkJgakuadgCw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790250502;
	bh=h/I5KlOTnG4QXX5YzH77COh4IFWM9lzgAXuiz3+mZbw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mbFnOo0B/jzSXdXQKrzEQO/kzNOM7GpJZGJRec3Bw9KnwGDdJ437tFnxqOAXaqyKF
	 Da9KVgwyriLw5M+4VXyhm7kfwHDSk9hkgVU8hWwd7rA4hSYkhMOGTzSxeQF0LaaxxD
	 We9oShfeAJuXnWELMAF10apnZWn9rjnJiBo9ygOzw/LkrhLolBSHWtUuorNGpw0hx5
	 ijjz+zg52ZWrreg8r5qEKTPaJtBO7njC3QgWOGqDU0fiIb3CkQUQ1EYrcBnRLIzxjr
	 qB8BoihqfIM1rZWJy84fwfGfANoWGX2q/m2gtIG1i/sqOBcWLN9Z43mimbe+ufHhWg
	 5sh0CW6rRvL5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6521D60B73;
	Thu, 24 Sep 2026 11:48:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B3B735A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 11:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDA62818A1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 11:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sDUw7kGEJ3Mn for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 11:48:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CDC11818C9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790250500;
 b=IFar2x8POn5Uzm2IFtupVT8N+kvyS18laqXAywLolKeJwD8Xx1fr4yAQnxgU49QOg/Y7
 s/VBC9UfDYpEUpAdE2rm1DoTq3QKPuRpdJ9SvPJp9q8qiH96Gca5BlQWgJvT5Gv1j8+HM
 lS/Kr9NFMye8sMU5OFDWfPLL6EJOplmEgaeq9UNSrmzlCQaFlPJUnQi1R0bCyZbCxeHwT
 /Il+uFuWFxyHWCITrHS6G9VvIpidLDsy6k3EpHxufnEbnG2xlLr/RYkPnoWIeEbpeOKCe
 4KcU6Kpq3zGOP4n7kV7kfu2NJRA4n4nLQwAhiozyoKYUOeuOrHncui81KNqYIs68bug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790250500;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=h/I5KlOTnG4QXX5YzH77COh4IFWM9lzgAXuiz3+mZbw=;
 b=GDVP0ab2Cm4YCsdOtiFtTuh+rUNz8xGh4+oDxzDcfVVRUSa7Y/SrXU07NJPOLzf2J2QN
 i4lknwEOFgxHZDrGCmIaZ+k0oUdLGuxc+Dh39w8bCe339b5bAeqK+ENz8OAJIjvoWHBMG
 CkHMm+5QRohy5Zq2sn/wKr3+O49xpNvb2CbZtIFiOuLqTmISaVfxWC3/53/iCGO2djS0i
 4dipx3fVquxkR7Fb9o1cEpGEeE7aYVPjnC2TISyFBa8SX017OSjmVanUJ9DNC/NR+5+5V
 aSIuWPPuaZ1hNIPG9jJYdKrrAR1oyVvFZ9GIAnCpJ1UTkpSn86Y++N3MSv2CzXhstsw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WOM7eopW; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WOM7eopW
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDC11818C9
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 11:48:19 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so13720015e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 04:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790250497; x=1790855297;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h/I5KlOTnG4QXX5YzH77COh4IFWM9lzgAXuiz3+mZbw=;
 b=WOM7eopW1UvCL65kLHyQqALL9MsiZLXph+SAMzX/o3zQI0LT64pxHVC255cV9a9qMd
 7TwOSCzPxHEhCzgTbwx6F2ZDb+qBQQXjO2b/tS7lRmnhK2ShUOw6GIg5py7ZszjXjZON
 mQ5Y28chVNc2n+jtz60nupwBe2SqcjhZ2jmrDvY7awJORkl+m+mBpJcT8sJDfm1UdBmn
 PPEnwVogz6w+19J87A+AbqpON1GrSHhFv1Xs4zbTi56vOoWRDRUdtRs8sYYC9np1BwCJ
 EcelcdCd/VetTEb9AiO44BVkAnU/NzVRbxxabLTWDoIqjnZXwTSboQK2BB60WsfDDNFE
 w9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790250497; x=1790855297;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h/I5KlOTnG4QXX5YzH77COh4IFWM9lzgAXuiz3+mZbw=;
 b=z5u8enx3/ihE4bqHTvYdP5j+qQ8bbgeMjUl3W1wT80Myj1oF3BWg3lueXsy7rW+aSW
 D8XrDimbSaLODFxTruIFloCqFz1JtAaFDiKytj1YJ2VBi+HaP+/rNgfr/hfuqi7wm4g5
 ivxU0LMZzkmFBl9PMYMzwRt+9YiEPxKHOt9BNZXQGOgzdVN9+3h30eP+vW+ZsuoJDBNq
 aKPJJHYrzHQjpM7ibqclvtN51qXaWS4j412GX051uHkeWJfVeYhvtwtbh/9W+1aM8xPP
 J7Onfw24J2Dp+zY6jWC8tLq4DbI2wGn12lCtwcFytUSgGS2LzSE+WtYF6WRX2e9AbwBC
 njpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0C9QaUJ74Nuo6sB5jTspRo/QtBBEncPhM77CMBbIjQ1mibd3cp/dASTvfMnrC1YRx73oYvvc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kzq/cbVqDuVfIxhhBj+5+0sfU3e3CcNMCypf9U0CqtYI0LHJ7X
 bpkJi+0Pc6PweF64AVFWaRHsbXZ3eyK0hAQKbTMt199SY4D7qJkobBDeMBqrL6Fk6YU=
X-Gm-Gg: AYBFou0pG/hLNBs8ry9v5LFhW4e6XQKrogTeIjF2v4QopXln9uI77N6jvfYHaujyCHN
 enf6TVklzlFNU2/wGM5KqxsnIZBeHRfKYlEEoyu/7925ydjL7wWuvuz5721fpD+ZfnwyNgpsCXR
 SmbLvDMwDrzPwmJkIwpvcJtvMkTKSEJsw74pDL5IvBEXm7Ytd6Lg0pVKj3+uu/pruaJTpBqFR77
 4/pBH7QWtWAegR3Lx2aPqmVkWhQqRFFizOKsfsuhcnteaApTCunGaYSNwZSTOZyy7a/DijHPV2O
 3BBjGs7dIpz3TD/cBVo1SH6LpOcPv48C8guKLK+8/L/5k4IuIHB5vHB8Q/TRCpJr2Pho0VHEXen
 ewLoXfNsYY1JbSWMK7hXSIFbD5dekobokNPHgqwyajZA6xdXWwGs4GOK3eoZPwuhITgDfwBGiRu
 H+yMO+D3/qJZA9WXx38QUYk2i9tuS56alB3Y0kLX0K0xxZ/Yo+I+XlqKxZSVx3qTfhSRswpCw5o
 dT+k+R3siM=
X-Received: by 2002:a05:600c:1c0b:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49fe66dfe1amr47005855e9.24.1790250497243; 
 Thu, 24 Sep 2026 04:48:17 -0700 (PDT)
Received: from [172.18.183.38] ([185.104.138.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cbd134sm63495555e9.9.2026.09.24.04.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 04:48:16 -0700 (PDT)
Message-ID: <7f76aaae-5c18-44db-9252-7fe29e4aa42c@linaro.org>
Date: Thu, 24 Sep 2026 13:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mach-snapdragon: map DRAM bank gaps to avoid
 reserved-memory MMU failures
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, anshuld@ti.com, linux@smankusors.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20260917091932.4150797-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260917091932.4150797-1-aswin.murugan@oss.qualcomm.com>
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



On 9/17/26 11:19, Aswin Murugan wrote:
> build_mem_map() leaves gaps between DRAM banks unmapped, causing
> configure_reserved_memory() to fail when a reserved-memory node
> falls within such a gap. Map inter-bank gaps as MT_DEVICE_NGNRNE
> regions and reserve space for the additional MMU entries.

This is the issue that prints a bunch of errors right? This is a bug in 
the logic in fdtdec.c, it is CORRECT for us to not map addresses that 
don't exist and if accessed will hang the bus. Please address the broken 
logic instead.

NAK

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   arch/arm/mach-snapdragon/board.c | 30 ++++++++++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 35735f1551c..6d25d8ea599 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -39,7 +39,11 @@ DECLARE_GLOBAL_DATA_PTR;
>   
>   enum qcom_boot_source qcom_boot_source __section(".data") = 0;
>   
> -static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
> +/*
> + * Space for one entry per DRAM bank, one entry per inter-bank gap,
> + * plus the peripheral block entry and the terminator.
> + */
> +static struct mm_region rbx_mem_map[2 * CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>   
>   struct mm_region *mem_map = rbx_mem_map;
>   
> @@ -584,6 +588,7 @@ int board_late_init(void)
>   static void build_mem_map(void)
>   {
>   	int i, j;
> +	phys_addr_t prev_end;
>   
>   	/*
>   	 * Ensure the peripheral block is sized to correctly cover the address range
> @@ -599,12 +604,33 @@ static void build_mem_map(void)
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
>   
> -	for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->dram[j].size; i++, j++) {
> +	/*
> +	 * Map gaps between DRAM banks as device memory. These regions
> +	 * are not usable RAM but must remain mapped for attribute updates.
> +	 */
> +	i = 1;
> +	prev_end = gd->dram[0].start;
> +	for (j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->dram[j].size; j++) {
> +		if (gd->dram[j].start > prev_end) {
> +			mem_map[i].phys = prev_end;
> +			mem_map[i].virt = mem_map[i].phys;
> +			mem_map[i].size = gd->dram[j].start - prev_end;
> +			mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +					   PTE_BLOCK_NON_SHARE |
> +					   PTE_BLOCK_PXN | PTE_BLOCK_UXN |
> +					   PTE_BLOCK_RO;
> +			i++;
> +			if (i >= ARRAY_SIZE(rbx_mem_map) - 1)
> +				break;
> +		}
> +
>   		mem_map[i].phys = gd->dram[j].start;
>   		mem_map[i].virt = mem_map[i].phys;
>   		mem_map[i].size = gd->dram[j].size;
>   		mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | \
>   				   PTE_BLOCK_INNER_SHARE;
> +		prev_end = gd->dram[j].start + gd->dram[j].size;
> +		i++;
>   	}
>   
>   	mem_map[i].phys = UINT64_MAX;

