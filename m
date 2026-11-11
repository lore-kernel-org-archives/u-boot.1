Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C15606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j37uhqA5;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=LrwRVIfh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E4578101F;
	Wed, 11 Nov 2026 16:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a7fJKPjRJIvz; Wed, 11 Nov 2026 16:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6948F811CA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794414205;
	b=cRJArTrrpS6NT+gD0ohOtoOuCQE9GFz4csMY4qzpQdK32KyJmxtZb5iRthUSRfPnP/wV
	 ceOjqtGsx09ytja7CWW3DcJ+pumUcrCHG8BhVmBwe6wVN/PCQGSbO+wa63IoaigOCLgCE
	 8euiKl5fELB1145FVaMaIzaqRIqzj5wirF5o4BocO8UXpe6YrIVgYfkr2+Sl+Fg70+gx5
	 3HlHA56hO+tU5OQ0kjQdu5dnt+cv67//xwMO38he6/YhDyGfkaS3VYFKS8JtA6UUlWilq
	 OwvYtQadvBAU9E5QgrlZQvlc4eJpI2qZMxbI4GbJms/5EMSN4DipdZ6C96z4PC7Tbog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794414205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q6cQQt4IkJZKjxSRoTKSkDg7za1IyVkmM/e55rg3NDk=;
	b=cTqTAw5NbA0QOC/NP2Jwr24yEwtk7KftmR6sqhJayH8MGgez79giinMAFN8atK3ijFO9
	 PsMADIj26/s4Q7BVQxiM99jKUUYIawd6yzgJdrvYoRKZZU/8Qf9rVSLU8mOfe6OLiG1p3
	 gVP50w/BlqrmW2yvRuX3ZE0BORqz5ZyeLHwt5wHXIuC5DLNKEcRCJhRpMDOiSpyTkk+oX
	 ji2mNr9IGQBOep/THRyE8VOXAVfGIIw0v0KkuIod9kJFPsmiQKot52LDn/ACbgw9d0o4j
	 HjNSqmux15n0BXQrWJ/r4MMcHQLNvzAu7CjO16//Iykn6aUDwr+qvrn2Yce3SM0it2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794414205;
	bh=Q6cQQt4IkJZKjxSRoTKSkDg7za1IyVkmM/e55rg3NDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j37uhqA54QTVjGPpAsNu3CFQepY8YVy6wm68LHdnBKQGJGG6rQsMUG2fwj/YjCXKM
	 dn3hHdaiG45J6LMQQFeWw2nVDFwUKCQKzBPwPvN+iUVRxEeEiYGbCRiRQIHCTuQ0D1
	 kXAl3Yz5dGmHrujoEEhE25fdytVlFsngPz7BvefCJRcj7NZXN+TR5AYv/CT6p5KwTV
	 LUXi/OxjT/BIEBUh8jBVZZ9c7p53Mbknmk5/CHUI3ioMy7R+eNsakrCBJkiQcfEQSO
	 I+O2BebunFx+dtrRA2Nh0ZsGhouCGELnZDHj0Ka8AXdI+oZHr0l6klqBNCIByQmgFt
	 odtPrH7nep7TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6948F811CA;
	Wed, 11 Nov 2026 16:23:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2856E2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 194CC4016D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZ9zyJcGE8RG for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 16:23:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A4CE74006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:fff0::42af"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::42af; helo=smtp-42af.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=LrwRVIfh
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::42af])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4CE74006F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:23:21 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPpjM3H9zznWW;
 Wed, 11 Nov 2026 17:23:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794414199;
 bh=Q6cQQt4IkJZKjxSRoTKSkDg7za1IyVkmM/e55rg3NDk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LrwRVIfh0kpr/tFKVTGl3EHAMx3jfRhO0+lhw6yKqvScCOOnin91eC0yY0J4yv2V5
 Me7xHw6ZBtR/jsNxVBKtIoX9h//dfFaUAsh3E63tT5whqu9qLaOhf3lG0L9erGSW9S
 RVZG9yxamjh1QciV1ZcekPhc7BQCuoZ+KiDcEnAH0X2IafDfug6x46SA1ZbytZzMZm
 j2ZnMBEUy01mo2Ct7rZCa5r3k+f6o8HbHIfOoX9hm0n6BZskSw2QTmI7E3DuJ7Mi65
 4WL+LnmChjLvL3AdCFaBideGO500fQKKfLtg4AJVMejfEnliH5Hs3KUBhOlU7D1mQT
 uy/gHaYmiRrXg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jPpjL5Hw9z8xJ; Wed, 11 Nov 2026 17:23:18 +0100 (CET)
Message-ID: <29c060b0-17c1-43a8-90f0-f517ac874268@0leil.net>
Date: Wed, 11 Nov 2026 17:23:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ram: rockchip: add config option for tinier debug
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-4-b82ff9c860ba@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261025-ddr-multi-v2-4-b82ff9c860ba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> Selecting the RAM_ROCKCHIP_DEBUG_TINY new configuration option, the
> debugging code prints only the SDRAM type, frequency and size, limiting
> the required space. In this way, the debugging code can coexist with
> support for multiple SDRAM types without exceeding the output size
> limit, such as in the case of the PX30 SoC TPL.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   drivers/ram/rockchip/Kconfig        | 11 ++++++++
>   drivers/ram/rockchip/sdram_common.c | 54 ++++++++++++++++++-------------------
>   drivers/ram/rockchip/sdram_px30.c   |  4 ++-
>   3 files changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index f51ae6a4542..98770659cd2 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -24,6 +24,17 @@ config RAM_ROCKCHIP_DEBUG
>   	  This is an option for developers to understand the ram drivers
>   	  initialization, configurations and etc.
>   
> +config RAM_ROCKCHIP_DEBUG_TINY
> +	bool "Rockchip ram drivers tiny debugging"
> +	depends on RAM_ROCKCHIP_DEBUG

question: do we really need a new symbol for that?

Maybe we can simply have a constant (e.g. DEBUG) defined at the top of 
the file and check on that. I am trying to think if anyone would want to 
have this configurable in a defconfig? If it's only useful for quick 
debugging, I don't think it makes sense to have a symbol for it.

> +	help
> +	  Limit ram driver debugging info to sdram type, frequency and size.
> +
> +	  Help to keep basic debugging information while minimizing consequences
> +	  to ram driver footprint. This can be useful when configuring the ram
> +	  driver to support multiple sdram types in a very constrained context,
> +	  such as TPL for PX30 SoC.
> +
>   config RAM_ROCKCHIP_DDR3
>   	bool "DDR3 support for Rockchip SoCs"
>   	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
> diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdram_common.c
> index b46de5d9044..519bbdb4e60 100644
> --- a/drivers/ram/rockchip/sdram_common.c
> +++ b/drivers/ram/rockchip/sdram_common.c
> @@ -44,36 +44,36 @@ void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
>   	printdec(base->ddr_freq);
>   	printascii("MHz\n");
>   
> -	printascii("BW=");
> -	printdec(8 << cap_info->bw);
> -	printascii(" Col=");
> -	printdec(cap_info->col);
> -	printascii(" Bk=");
> -	printdec(0x1 << cap_info->bk);
> -	if (base->dramtype == DDR4) {
> -		printascii(" BG=");
> -		printdec(1 << ((cap_info->dbw == 0) ? 2 : 1));
> -	}
> -	printascii(" CS0 Row=");
> -	printdec(cap_info->cs0_row);
> -	if (cap_info->cs0_high16bit_row !=
> -		cap_info->cs0_row) {
> -		printascii("/");
> -		printdec(cap_info->cs0_high16bit_row);
> -	}
> -	if (cap_info->rank > 1) {
> -		printascii(" CS1 Row=");
> -		printdec(cap_info->cs1_row);
> -		if (cap_info->cs1_high16bit_row !=
> -			cap_info->cs1_row) {
> +	if (!IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG_TINY)) {
> +		printascii("BW=");
> +		printdec(8 << cap_info->bw);
> +		printascii(" Col=");
> +		printdec(cap_info->col);
> +		printascii(" Bk=");
> +		printdec(0x1 << cap_info->bk);
> +		if (base->dramtype == DDR4) {
> +			printascii(" BG=");
> +			printdec(1 << ((cap_info->dbw == 0) ? 2 : 1));
> +		}
> +		printascii(" CS0 Row=");
> +		printdec(cap_info->cs0_row);
> +		if (cap_info->cs0_high16bit_row != cap_info->cs0_row) {
>   			printascii("/");
> -			printdec(cap_info->cs1_high16bit_row);
> +			printdec(cap_info->cs0_high16bit_row);
> +		}
> +		if (cap_info->rank > 1) {
> +			printascii(" CS1 Row=");
> +			printdec(cap_info->cs1_row);
> +			if (cap_info->cs1_high16bit_row != cap_info->cs1_row) {
> +				printascii("/");
> +				printdec(cap_info->cs1_high16bit_row);
> +			}
>   		}
> +		printascii(" CS=");
> +		printdec(cap_info->rank);
> +		printascii(" Die BW=");
> +		printdec(8 << cap_info->dbw);
>   	}
> -	printascii(" CS=");
> -	printdec(cap_info->rank);
> -	printascii(" Die BW=");
> -	printdec(8 << cap_info->dbw);
>   
>   	printascii(" Size=");
>   	printdec(cap >> 20);
> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> index 7f51b9c4f8f..2b25a0124ed 100644
> --- a/drivers/ram/rockchip/sdram_px30.c
> +++ b/drivers/ram/rockchip/sdram_px30.c
> @@ -715,7 +715,9 @@ int sdram_init(void)
>   
>   	sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
>   
> -	printascii("out\n");
> +	if (!IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG_TINY))
> +		printascii("out\n");
> +

suggestion: just get rid of it

In a separate patch. Considering sdram_print_ddr_info() always print 
something, there's no need to say when we've exited that function I think?

Cheers,
Quentin
