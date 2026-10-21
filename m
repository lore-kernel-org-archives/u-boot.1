Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001B606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=spNcSvG8;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qxz/PcFe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB6FF80F4A;
	Wed, 21 Oct 2026 07:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IMkb7ABUGa-b; Wed, 21 Oct 2026 07:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E7188101D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792566816;
	b=GQRVAn7A0I1tcw3bknBtkZgb8N7iQnqUBcgSEco0rwVaAWr2frnE1pULEm+L2E5MAV29
	 1KQ+byvEnoH5gPd0ixcK/pHVplPblhdPDV6MsFe4VAHyCcIONowBg+rdVLWoaFs5w4nXX
	 sAgJqm61Jslnoimub71GJ7fy0Rxrfd0gV8mH81HabTBQzzjSfkH1h7eu4q7GuBwJto7q4
	 QIeiSp1Ln9IMYGqWuHf2AZ4FzVGSoPxN4/iz260+dVFD6NLAdK+4960W8CnzIIJS+pM1v
	 SdJX/x5eHBvIKWNFHxCQqk8JUlJ7AiDTz+uaanyxf/+vs4PnF9VFIKKkdp8UwX7NnLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792566816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OufbVqGN2OVHq/IizC9RF3GTi6zTk6aS7eNolhqDUP8=;
	b=gcYq9gQAC8/zh5xoQknmuiadOYI20Dyt6uWmQ5z+d7IQhTC+b+2Z3q3AYzE3kSjDP2m9
	 uQ0ZYfk1wAIBY++qKpWJvd8vRgmC9MLYIoJbsn8fxb/Sd0l26g/Y159+TBvA1LMRaEVC2
	 fIVC8bJ8m/7L0rfGor90J6dlI6CkK1HGipOGDVy/evPvg6kW5Qhpu0i/GDoZf5178yZmm
	 DKVQpT88/VNocOAMP8VgDUbILMjO1ytgtxnkxFBLuU1jufTECPOpk9EVuaZp5wY9eWtgw
	 oxcQFiNMS4rVm7ymIDKg+F+sBjWO9tzKyei/wA9jstwI8fTMdMwD0LMXgQONVVUwK3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qxz/PcFe";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792566816;
	bh=OufbVqGN2OVHq/IizC9RF3GTi6zTk6aS7eNolhqDUP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=spNcSvG8k2Ne5fIzNWat66l17pB/v0wdu4v2pTn90p4iJ5p29cP05+Ds8ZVuML/aP
	 M7atmr1GbEzv29MbLmFmqUW6YxisKNbS2x00ySjWX8QpSs3gC/kRmr47cn3l/6CZsi
	 wRuxLLa7TdNw31XLL9j0CoUm9aXamxyTfI0FtGgGxbd++/6TC2CqJRjSvReRe035JQ
	 qtAS+dSmzXtR4bqJp2JhxAP72vnMlfyWdPJUMXk3k7tTy7NA6XK7TUn9dLrvZFXM+y
	 Nl2asJpOdfkqriZ09a/HDON0dB5IctlNYl4wJyv07m9pk1OOz3Mz3e9mFo32BetO0v
	 LHo9iDXAKNpaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E7188101D;
	Wed, 21 Oct 2026 07:13:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1604B3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 079C18101D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVcKNd2mtaLZ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 07:13:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B23580F4A
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792566814;
 b=REiMABCORSyWgxZVldc95FuONlzMPvzpW9yH+IfgqS2uHu4D/utp0ZY3n6eHwx1wQ9Nc
 B35AdEfY/pS4kvqDM5CioRjfEaHFv7u3kD1buAkkfOYBVXBlUw8tLzxbJ86HxaG86uZ9g
 LO1PGLfLt3f7Zmsjox7ke1a0VmmVTy+mBS5SkvHgvErlY219o/8K8weZBGwFtYwcDGDDr
 xc99HArheeelbKr9AfDS05LVcnbvx1siRNExQgCQFSUXt/IvWW7FmJe+6T+z71pxaLKv6
 gS7TS/CpUtKSKH7ReVMpuqmE0sI9cWHiwELAJgw2kRClXHVhJIF5G1bE/X4UcydpUAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792566814;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=OufbVqGN2OVHq/IizC9RF3GTi6zTk6aS7eNolhqDUP8=;
 b=Tda9PCmUFhX+lmw/Ye2k8SueEUxhkH4r8jITHq6NfR5vfzTXxTyOUwu39TbPE551qvk8
 5NtzSYuXgDX+fTmoaLOVXH5Q20I8aC2QRunSPtPtZlO/FOs5ERrq2S5dYD2Idfh5XEd/T
 F0cbo6XmmJGTjmVhJbL2n+HstAjkMxSW8KxRSEEYsXT/pzAh9l2fGkoeP+PHm75zSU1MW
 dnWVuW7SLrtw4GMvM5FdC5ZeeMd9bZ2XqjF5fmiir01loUg38/aw/wx8X0P83eFDAcDXb
 /2R7/fWxG1MFm3kUSj1bGhs3bPuroNZZYpw7rlqsJA5KgDTDDSPBAfO4piRrp1eZ6xA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Qxz/PcFe"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qxz/PcFe
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B23580F4A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:13:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 72D5D41190;
 Wed, 21 Oct 2026 07:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284431F000CA;
 Wed, 21 Oct 2026 07:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792566813;
 bh=OufbVqGN2OVHq/IizC9RF3GTi6zTk6aS7eNolhqDUP8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Qxz/PcFeL1eOVQMt5nrt0BYO4h+VLaDDwO5/jPcaw7AzhGuLpdLI8FjLku40LxQDx
 Om8uKHKh9I5sj+I/kdBCg0ZHQM5mheCbsSwhkqNNukVlYZ/gY1vuL7j0krDGZ9Cg4M
 f+hQqHHyO5pSWKv2VBX/L+LRl7S9rusIK62jmFSwLjjQzXeZNp49HB3gEGW4lKCI8f
 3+/D1qUAqFJkANA9O4OJvz0jeF4e2d3pzuy3UmQDrETT8XslIGes89xECdo2UMoKdG
 MYg1F0huDzqO4uoY0+vs7MjR+xMWcBN5o3EvkVlWwAE4XG+Apc5qxUb6jETHTjuChh
 PSSvaP/GHXCUg==
Date: Wed, 21 Oct 2026 07:13:29 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] configs: spacemit: k3: enable spi nor flash in main
 app
Message-ID: <20261021071329-GKC65567@kernel.org>
References: <20261020195126.1325187-1-e@freeshell.de>
 <20261020195126.1325187-2-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020195126.1325187-2-e@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E Shattow,

Thanks for the patch

On 12:51 Tue 20 Oct     , E Shattow wrote:
> Enable sf command and env storage in SPI NOR flash.
..
> SPL is not yet
> upstream so this is only in the main app, and depends on vendor SPL for
> clocks setup ahead of SPI NOR flash probe.
> 
This could be added as additional info, but I'd rather not put in commit
meassage, maybe just put it under "---" scissors line for reference

For why depend on SPL for clock, reset setup.. I checked fsl_qspi.c,
there is no clock & reset enabling support currently, although SpacemiT
do provide those support, but I think it's another item need to improve,
and we could definitely address it in a separate thread..

> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/cpu/k3/Kconfig     | 1 +
>  configs/spacemit_k3_defconfig | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
> index 5474ac112437..07b490a718dd 100644
> --- a/arch/riscv/cpu/k3/Kconfig
> +++ b/arch/riscv/cpu/k3/Kconfig
> @@ -14,5 +14,6 @@ config SPACEMIT_K3
>  	imply RISCV_TIMER if RISCV_SMODE
>  	imply CMD_CPU
>  	imply OF_UPSTREAM
> +	imply SPI
Any reason to add this dependency?

I'd prefer to put this config in defconfig, As I see K3 has 
no hard requirement for SPI support from architecture perspective

>  
>  endif
> diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
> index 586305c62322..b333e708d01b 100644
> --- a/configs/spacemit_k3_defconfig
> +++ b/configs/spacemit_k3_defconfig
> @@ -4,6 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x80000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x102300000
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0xa0000
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="spacemit/k3-pico-itx"
>  CONFIG_SYS_BOOTM_LEN=0xa000000
> @@ -35,6 +37,8 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
>  CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_NET_LWIP=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SYSCON=y
> @@ -44,6 +48,7 @@ CONFIG_SPACEMIT_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_SPACEMIT_K1=y
>  CONFIG_MISC=y
> +CONFIG_SPI_FLASH_WINBOND=y
>  CONFIG_PHY_GIGE=y
>  CONFIG_DWC_ETH_QOS=y
>  CONFIG_DWC_ETH_QOS_SPACEMIT=y
> @@ -61,4 +66,5 @@ CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_SYS_NS16550=y
>  CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_FSL_QSPI=y
>  CONFIG_TIMER_EARLY=y
> -- 
> 2.53.0
> 

-- 
Yixun Lan (dlan)
