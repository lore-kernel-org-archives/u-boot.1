Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405BCC48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 16:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC3387E96;
	Sun,  3 Mar 2024 17:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a32GAP45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137EF87EE6; Sun,  3 Mar 2024 17:22:20 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C2D87EFF
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 17:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinguyen@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9495CCE0D92;
 Sun,  3 Mar 2024 16:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA17C433F1;
 Sun,  3 Mar 2024 16:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709482934;
 bh=M6w2Y5c/dXNfC3/EljWVdGF7dnANNIgSeQpjkxHuBGM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=a32GAP45rOy580qbMRIJd+X5w3qF3+QsiqXdShF/xr5QmfB428IVvSBqy27813WNM
 RcsTYVA1lG2oW/XTa78ymm3GlgsCLiT1iuaucwgh+mZq92JRyNG6r0S1JKP8JFQ+wp
 mb/7Xi5MT/ErPKG3SuwNhl9yOurafwD/1FSj5WlkGG4yDUU5hk9ipJYbKzAgfXKM7z
 OpPE5S0E3w9Hei8sJ+JQWoGLnyWfysQACWvH3mzqmnj8lxZAiqbJpTOEUK9I5bq7HJ
 g/50ReihPLTJRpQkDDGg1VX41FV58Cp2Io5DsCAYyF/d5iEX40epRvxFG7DiTifPZS
 h8wufu1Ob6TrQ==
Message-ID: <6a69588a-7c50-425a-af7f-96caff727113@kernel.org>
Date: Sun, 3 Mar 2024 10:22:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: socfpga: arria10: add option to reprogram the
 FPGA every reboot
Content-Language: en-US
To: =?UTF-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
References: <20240222152102.1677445-1-barnas@google.com>
 <20240222152102.1677445-2-barnas@google.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20240222152102.1677445-2-barnas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 03 Mar 2024 17:30:18 +0100
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



On 2/22/24 09:20, Michał Barnaś wrote:
> Add Kconfig that enables FPGA reprogramming with warm boot on Arria 10.
> This option allows to change the bitstream on the filesystem and apply
> changes with warm reboot without the need for a power cycle.
> 
> Signed-off-by: Michał Barnaś <barnas@google.com>
> ---
> 
>   arch/arm/mach-socfpga/Kconfig   | 8 ++++++++
>   arch/arm/mach-socfpga/spl_a10.c | 8 ++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index 114d243812..89303f1f16 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -80,6 +80,14 @@ config TARGET_SOCFPGA_ARRIA10
>   	imply FPGA_SOCFPGA
>   	imply SPL_USE_TINY_PRINTF
>   
> +config TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
> +	bool "Always reprogram Arria 10 FPGA"
> +	depends on TARGET_SOCFPGA_ARRIA10
> +	help
> +	  Arria 10 FPGA is only programmed during the cold boot.
> +	  This option forces the FPGA to be reprogrammed every reboot,
> +	  allowing to change the bitstream and apply it with warm reboot.
> +
>   config TARGET_SOCFPGA_CYCLONE5
>   	bool
>   	select TARGET_SOCFPGA_GEN5
> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
> index 9edbbf4a29..d5d3327a42 100644
> --- a/arch/arm/mach-socfpga/spl_a10.c
> +++ b/arch/arm/mach-socfpga/spl_a10.c
> @@ -122,7 +122,11 @@ void spl_board_init(void)
>   	arch_early_init_r();
>   
>   	/* If the full FPGA is already loaded, ie.from EPCQ, config fpga pins */
> +#ifdef CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
> +	if (is_regular_boot_valid()) {
> +#else
>   	if (is_fpgamgr_user_mode()) {
> +#endif
>   		ret = config_pins(gd->fdt_blob, "shared");
>   		if (ret)
>   			return;
> @@ -130,7 +134,11 @@ void spl_board_init(void)
>   		ret = config_pins(gd->fdt_blob, "fpga");
>   		if (ret)
>   			return;
> +#ifdef CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
> +	} else {
> +#else
>   	} else if (!is_fpgamgr_early_user_mode()) {
> +#endif
>   		/* Program IOSSM(early IO release) or full FPGA */
>   		fpgamgr_program(buf, FPGA_BUFSIZ, 0);
>   

I got an error while trying to apply this patch:

Checking patch arch/arm/mach-socfpga/Kconfig...
error: while searching for:
	imply FPGA_SOCFPGA
	imply SPL_USE_TINY_PRINTF

config TARGET_SOCFPGA_CYCLONE5
	bool
	select TARGET_SOCFPGA_GEN5

error: patch failed: arch/arm/mach-socfpga/Kconfig:80
Checking patch arch/arm/mach-socfpga/spl_a10.c...

Please rebase to the latest and re-send.

Dinh
