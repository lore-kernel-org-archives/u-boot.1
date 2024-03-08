Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38039C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 19:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E42687CFC;
	Fri,  8 Mar 2024 20:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709924472;
	bh=GFYlECK+9iDqOulM0R1zngCmcHgR4Xxc2fqfqIFNpW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YtfFcC6X0KlNmGwvF33fpujgbs5fyBtbxadlhm/gDrV68OLF+iqBsMw0zKa6msUdP
	 OR9/8U82Yt9Zoukdnwvzod2CUbC5AFTwNhjdgnPK6BTe6VXMqEEK3ES4WcKCgB1T7Z
	 rgaYyA1S6JVy1KuwnC9NXCr9chQWxDeyafe6F3nlGYlzS34oV7dj4izFj5Ui6LhbxW
	 6GWxAa23VQxgo0P/OKTs5hxdjLsPnvQcwZcEHDMWXpUWNQtlwGes9aR4RZk0cT7eaJ
	 8+LyBE9UFk36sh13Aqt3ghsLBUGFOYREhaZK4vpSNUNmm+eai6iVPxZO7NncfOUTjj
	 cHkrldJ0gG0RQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6027287CED;
 Fri,  8 Mar 2024 20:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709924471;
 bh=GFYlECK+9iDqOulM0R1zngCmcHgR4Xxc2fqfqIFNpW8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DUK+EAhWCgVlIRKSbfQR8E10QteWHqdT2wbSjx7n+Pdm3BkGRt8dEVouKm4mo5VyV
 fEwBjTv9lb5GnqFvLn/tONhHisV5j4wFfDtkp7179M0y6yC/oe6rvuyHVYc7b4WNAR
 fWb4Wic4wxNSkQoLEcuiX0cgjhnrtDTKSDwH98qiC9ZUBaUXCBjdlz0aVRKzuHIF4y
 E21/BKQJSGADtNQ8ZE7L6FPySUflWQYcF6l3vAB54zcDFWj54xV68APEMwq5xhYujY
 QOHGaBWvoZWNQCO1Utf7JKnP/8rRkQbVfiKP7YrUeEUK/FI/v9w7bJ/fwMHImZltKE
 o+PVkHR4Mdh1Q==
Message-ID: <c0cbfa06-9206-4ca6-ad51-ad7b0e54cf1c@denx.de>
Date: Fri, 8 Mar 2024 19:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: socfpga: arria10: add option to reprogram the
 FPGA every reboot
To: =?UTF-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>, u-boot@lists.denx.de
Cc: Dinh Nguyen <dinguyen@kernel.org>, Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
References: <6a69588a-7c50-425a-af7f-96caff727113@kernel.org>
 <20240308171251.106144-1-barnas@google.com>
 <20240308171251.106144-2-barnas@google.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240308171251.106144-2-barnas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/8/24 6:12 PM, Michał Barnaś wrote:
> Add Kconfig that enables FPGA reprogramming with warm boot on Arria 10.
> This option allows to change the bitstream on the filesystem and apply
> changes with warm reboot without the need for a power cycle.
> 
> Signed-off-by: Michał Barnaś <barnas@google.com>
> ---
> 
> Changes in v2:
> - Rebase on current master branch
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

This is not TARGET (as in SoC), but a regular config option, so please 
drop the TARGET_ prefix .

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

Use CONFIG_IS_ENABLED() or IS_ENABLED() macro please .
