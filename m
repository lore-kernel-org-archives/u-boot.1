Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61B606A50C
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tBowP+rY;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5R29xuk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78A4340C78;
	Fri, 20 Nov 2026 06:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XpTsFMoQWgJa; Fri, 20 Nov 2026 06:20:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B925B40CE8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795155602;
	b=GTaSIj0LZvXg2qvWrcGsNThCscHYFlPj2hJuoPVHChPgzAj9PmGAFKcoj4vwDd1jQwJ2
	 FnEGs/90y5Y21zqnATnebTMquC4N112KZy19Aqg8TSsShzMnN+o4nn8Mn3NSlUXx6Uzcs
	 eaLNcY3/ZCYfC1dn/K6j0zpeTpxCAb9i5S++a+oISXWtOfzF2BHe9+vH2FazpPRDS4hIA
	 7gOKvhG+qkwYgHaj+BHMjugQ2t/4M0cgVhu7sMPeW2FAXGRU0uprI9D733ieOPJF8B9/w
	 yT4d3venndKlYXKz8no5CgiGgHA6bhqrhXLWb70qXjtgxugXoi4VB17fpWQczOSlacg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795155602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x5+G7Xot5fzQOUOEnT8v82RUkWk+z61mNh0wXNiYOwM=;
	b=DMAmfp17ycDw9JYigPPM+5XbxGzMHF6KIncbX7qD9hsZJeyu8eB3gMa7f764i1Ym1fn/
	 hDCFLvBEY27ASjPu2A7sFNP6ZByizmj5olg2/yYSsSyJGAHPMhI3jWb+qE24FTJ/gQLxR
	 MB6ncM36FtUPB9scCjW/V1lgs13OcHujlJ7q8CTa6zEw2zqHcprPvtnaAWUU7w95i4Lz0
	 jHr6J/Siv8YnFcP0hCqzHBsjBF5DQmOzW7BjVXxrrlCPNv1sXKLc92jHghfWXYfB3RFKD
	 i7+6x4IqDOHwkn1QJANo4P2b4/jTzEP4/wlZG+5xwwmfKonG81LDPn+KFfD9XcMAgVA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795155602;
	bh=x5+G7Xot5fzQOUOEnT8v82RUkWk+z61mNh0wXNiYOwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tBowP+rYjyg1sTWU/M/0bjUNu1Jz/GGK7Fj5iXaQXRJW4mSFKY7IjVrYXugEbhXeT
	 05s9mTw5RaB/Qu4NZG4Y8LRh+Nf19XipzSK1ZKNF9vbk4hbGp7IvIu/OSP4VCrUfeE
	 VFfM0nnvbfUMKPOcE9DxwgO7jFAG4EV8shXTwzYeS+UtqT/CQSsYHPbhGj0rpdYzzH
	 IwPBn5phVbq1IYQTcFTCHytQvnb4NvwmmOkyo8uTFz+sV9VwUwZ9m7T3dnjnC918k7
	 QMbp5tA+c2RRMofDUOcAygrE/n1kevUojwDWPmEP2clAvADKSlW+V05oqXAdTN+6ws
	 66LM3/QM5dWzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B925B40CE8;
	Fri, 20 Nov 2026 06:20:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08586169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDFCB8159C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8CAYxVqFAki for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 06:20:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C26581570
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=P5R29xuk
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C26581570
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:20:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A52CB6133D;
 Fri, 20 Nov 2026 06:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA57F1F000C6;
 Fri, 20 Nov 2026 06:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795155598;
 bh=x5+G7Xot5fzQOUOEnT8v82RUkWk+z61mNh0wXNiYOwM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=P5R29xukhnADo1afxKoLHrvLozkX8zPNBCsqHLyjnD6LoTZWUIkWo/PFT4w1z7k97
 y3QcpDKhADZxYtMvXadkXmmDDOOAwpPit/w20RtYykpGvrmWBvmmFVXQnYaxUFiiDM
 x5i8m/2qUpfkewl/7Ict+CCNk7ni8KomGsOZDpwuJANTwXuL3eRFH6pe5Pypr7aWyU
 D/d4WMNQ2WOWSvZDUnM5MEIilr5XNScQUzDJIzBr9l/rZQYaeDXlgONXF1jy5+qcnD
 hDG9WoThwwgMKD6S33eJd4R9D6zu1Ij/2bmme5KFW5Uw3XuG1SDMdaIY9eZ0vqjw9c
 2/evs0w1CPICw==
Date: Fri, 20 Nov 2026 06:19:55 +0000
From: Yixun Lan <dlan@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 E Shattow <e@freeshell.de>, Huan Zhou <pericycle.cc@gmail.com>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v1 6/6] configs: spacemit_k1: Enable SPL GPIO and pinctrl
 support
Message-ID: <20261120061955-GKG156369@kernel.org>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
 <20261029134705.3767-7-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029134705.3767-7-linux.amoon@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anand,

With those two mmc patches 2,3, which should be used for switching
i/o pins to 1.8v, so can you check if it able to work in UHS mode?
try with CONFIG_MMC_UHS_SUPPORT enabled?

On 19:16 Thu 29 Oct     , Anand Moon wrote:
> Enable GPIO and pinctrl support in SPL for SpacemiT K1 boards
> to support early board initialization and SD card boot.
> 
> Enable SPL MMC I/O voltage switching and configure the shared
> K1 U-Boot device tree include for the supported boards.
> 
> Also enable MTD and SPI NOR partition support with the default
> flash partition layout.
> 
> Configure a 2 MiB SPL simple malloc buffer for early allocations.
> Enable regulator commands, SPL GPIO and pinctrl support, and
> SPL MMC I/O voltage switching.
> 
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  configs/spacemit_k1_defconfig | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
> index 8ee9baa13b7..04b5ec4f700 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -3,10 +3,10 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
>  CONFIG_SYS_MALLOC_F_LEN=0x10000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1200000
>  CONFIG_DM_GPIO=y
>  CONFIG_SPL_DM_SPI=y
..
> -CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-musepi-pro"
> +CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
no need to change

>  CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
>  CONFIG_SPL_MMC=y
>  CONFIG_SPL_STACK_R_ADDR=0xc00000
> @@ -63,10 +63,12 @@ CONFIG_CMD_PCI=y
>  CONFIG_CMD_SPI=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_EXT4=y
> +CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_FAT=y
>  CONFIG_EFI_PARTITION=y
>  CONFIG_OF_UPSTREAM=y
> -CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
> +CONFIG_DEVICE_TREE_INCLUDES="spacemit-k1-u-boot.dtsi"
..
> +CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro spacemit/k1-milkv-jupiter"
ditto

>  CONFIG_MULTI_DTB_FIT=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
> @@ -117,3 +119,15 @@ CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_SPL_LIB_RATIONAL=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_DM_GPIO=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_SPL_SPACEMIT_GPIO=y
> +CONFIG_SPL_PINCTRL_SPACEMIT_K1=y
> +CONFIG_SPL_MMC_IO_VOLTAGE=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
> +CONFIG_MTDPARTS_DEFAULT="spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)"
> -- 
> 2.56.0
> 

-- 
Yixun Lan (dlan)
