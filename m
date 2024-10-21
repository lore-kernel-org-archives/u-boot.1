Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D7DD3C927
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 01:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092B98925E;
	Mon, 21 Oct 2024 03:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TNPDHBRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E26892A2; Mon, 21 Oct 2024 03:32:02 +0200 (CEST)
Received: from mail-m118102.qiye.163.com (mail-m118102.qiye.163.com
 [115.236.118.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D393489268
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=TNPDHBRQ8lSeM9MZkZEbkxHMPRoFmGSSdmx5t6F4Yl0ObIJjmdvah5xyYT8hAtyT3NqF4WDUHm87Dx4S7P75idGm7ncpcJuKU2AClTxnsW7whaSg5UbU/FtR/mM98DPtwQchYmGEHi1m6clajzTF8I7dSt2JusAD45W4ii9iZHY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Qj1tYi5E2Dk7bDthhRsHsJfTS+2kdFc0wrCMWyIs8Eg=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id BFF7E520250;
 Mon, 21 Oct 2024 09:31:38 +0800 (CST)
Message-ID: <a5e80bcf-a66e-4572-b101-0482e447682d@rock-chips.com>
Date: Mon, 21 Oct 2024 09:31:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v6] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>, Marek Vasut <marex@denx.de>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Neal Gompa
 <neal@gompa.dev>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
References: <20241016100203.629713-1-alexthreed@gmail.com>
Content-Language: en-US
In-Reply-To: <20241016100203.629713-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5DGVZNTh4YQkoeTh9OTRlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92acb396f603afkunmbff7e520250
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6Iyo*PzIfVigJKUkvTjIC
 TEIwCxVVSlVKTElCT0xPSEtPT05NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMSUNPNwY+
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


On 2024/10/16 18:02, Alex Shumsky wrote:
> Increase rng-seed size to make Linux happy and initialize rng pool instantly.
> Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but u-boot
> currently provides only 8 bytes.
> Linux 5.18 and probably some versions before it used to require 64 bytes.
> Bump min value to 64 bytes to be on a safe side.
>
> Boot with 8 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [   12.089286] random: crng init done
> Boot with 32 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [    0.000000] random: crng init done
>
> Linux source references:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.19#n551
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.18#n236
>
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> Changes in v6:
> - fix wording in docs and debug message
>
> Changes in v5:
> - add docs
>
> Changes in v4:
> - fix typos and code style
>
> Changes in v3:
> - reword warning
> - increase default rng_seed_size to support older linux as well
> - reword commit message
>
> Changes in v2:
> - add env config knob rng_seed_size
> - add warning for small rng_seed_size
> - 12-character commit SHA in Fixes
>
>   arch/arm/mach-rockchip/board.c | 11 ++++++++++-
>   common/Kconfig                 |  3 +++
>   doc/usage/environment.rst      |  5 +++++
>   include/fdt_support.h          |  3 ++-
>   4 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 3fadf7e412..75d6693e28 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -472,9 +472,18 @@ __weak int misc_init_r(void)
>   __weak int board_rng_seed(struct abuf *buf)
>   {
>   	struct udevice *dev;
> -	size_t len = 0x8;
> +	ulong len = env_get_ulong("rng_seed_size", 10, 64);
>   	u64 *data;
>   
> +	if (len < 64) {
> +		/*
> +		 * rng_seed_size should be at least 32 bytes for Linux 5.19+,
> +		 * or 64 for older Linux kernel versions
> +		 */
> +		log_warning("Value for rng_seed_size (%lu) too low, Linux kernel RNG may fail to initialize early\n",
> +			    len);
> +	}
> +
>   	data = malloc(len);
>   	if (!data) {
>   		printf("Out of memory\n");
> diff --git a/common/Kconfig b/common/Kconfig
> index 957de0c5c0..8098f90683 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -927,6 +927,9 @@ config BOARD_RNG_SEED
>   	  new seed for use on subsequent boots, and whether or not the
>   	  kernel should account any entropy from the given seed.
>   
> +	  Default seed size (64 bytes) can be overridden by a decimal
> +	  environment variable rng_seed_size.
> +
>   endmenu
>   
>   menu "Update support"
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index cc33d3ec0f..7bd9ffce8d 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -323,6 +323,11 @@ netretry
>       Useful on scripts which control the retry operation
>       themselves.
>   
> +rng_seed_size
> +    Size of random value added to device-tree node /chosen/rng-seed.
> +    This variable is given as a decimal number.
> +    If unset, 64 bytes is used as the default.
> +
>   silent_linux
>       If set then Linux will be told to boot silently, by
>       adding 'console=' to its command line. If "yes" it will be
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index 741e2360c2..9447a64e06 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -202,7 +202,8 @@ int ft_board_setup(void *blob, struct bd_info *bd);
>    *
>    * This function is called if CONFIG_BOARD_RNG_SEED is set, and must
>    * be provided by the board. It should return, via @buf, some suitable
> - * seed value to pass to the kernel.
> + * seed value to pass to the kernel. Seed size could be set in a decimal
> + * environment variable rng_seed_size and it defaults to 64 bytes.
>    *
>    * @param buf         A struct abuf for returning the seed and its size.
>    * @return            0 if ok, negative on error.
