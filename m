Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2245CD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 21:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D332483FF5;
	Sun, 24 May 2026 23:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=aurel32.net header.i=@aurel32.net header.b="hJmF4VLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B99F18404D; Sun, 24 May 2026 23:25:49 +0200 (CEST)
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72FAB83EF9
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 23:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aurelien@aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=Fn+D0iBzpNKi6sf/i9rm56H4ttyljc3oETAmQDjv3Xo=; b=hJmF4VLKRBnzvi7S9pmqE/E7Rb
 oXecn/BcT8tSBC3JZwP9GCPJIPF68xY1V3/HS3I9OABJPjZ5tC6pAistpUxsgKZGTqlXwQloQwGPn
 VlOUEZJLLafF2/ncwS3v8yd2+JThllUUx9lTjQwk4nB0u/Vgb0GUCamt8En1KQ5EktVvs9IGXcpFe
 gnfWlsszMv+u7hRxibj9wH7qKTeS2p7K2NAo1QvbP7GE7Z89CNYf315yK0txizGq/lhFW1v4bRFxo
 nz6TIQwARtwtjJsoWJJfVqm5wuPMDFiqg8wA0qmXuuB/aJ+ACa3xxN5NKXtyqu00e0x8jZNaumLFe
 xVAKMwIw==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1wRGKJ-00000000hvc-0Umn;
 Sun, 24 May 2026 23:25:39 +0200
Date: Sun, 24 May 2026 23:25:38 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Guodong Xu <guodong@riscstar.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de,
 u-boot-spacemit@groups.io, Vignesh R <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>,
 Heiko Schocher <hs@nabladev.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Philip Molloy <philip.molloy@analog.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Subject: Re: [PATCH v2 6/9] spacemit: k1: Add multiple device tree support
Message-ID: <ahNs0lme0ya2zolV@aurel32.net>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
 <20260520-b4-k1-spl-pinctrl-spinor-v2-6-8d25db98ac8e@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-6-8d25db98ac8e@riscstar.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
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

Hi,

On 2026-05-20 06:45, Guodong Xu wrote:
> Enable multiple DTB support in the FIT image for the Spacemit K1 SoC,
> allowing a single U-Boot binary to support different board variants.
> 
> The SPL reads the board type from EEPROM and selects the corresponding
> device tree at runtime via board_fit_config_name_match(), ensuring the
> correct hardware description is passed to U-Boot proper.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> 
> ---
> v2:
> - Reworked.  Drop the v1 approach (new local k1-muse-pi-pro.dts,
>   enlarge SYS_MALLOC_F_LEN, MMODE switch).
> - Use binman --fit-multi-config so u-boot.itb packs multiple board
>   DTs from the upstream tree.
> ---
>  board/spacemit/k1/spl.c       | 42 ++++++++++++++++++++++++++++++++++--------
>  configs/spacemit_k1_defconfig |  2 ++
>  2 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index da4169fbc8c..d749e21a2d5 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c
> @@ -13,6 +13,7 @@
>  #include <dm/device.h>
>  #include <dm/uclass.h>
>  #include <i2c.h>
> +#include <linux/ctype.h>
>  #include <linux/delay.h>
>  #include <log.h>
>  #include <power/regulator.h>
> @@ -55,6 +56,8 @@ struct ddr_cfg {
>  binman_sym_declare(ulong, ddr_fw, image_pos);
>  binman_sym_declare(ulong, ddr_fw, size);
>  
> +char product_name[I2C_BUF_SIZE] = "k1";
> +
>  static void i2c_early_init(void)
>  {
>  	struct udevice *bus;
> @@ -322,14 +325,8 @@ void nor_early_init(void)
>  	udelay(10);
>  }
>  
> -void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> -{
> -	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
> -}
> -
>  void board_init_f(ulong dummy)
>  {
> -	u8 i2c_buf[I2C_BUF_SIZE] = { 0 };
>  	int ret;
>  
>  	ret = spl_early_init();
> @@ -344,11 +341,11 @@ void board_init_f(ulong dummy)
>  	preloader_console_init();
>  
>  	i2c_early_init();
> -	ret = read_product_name(i2c_buf, I2C_BUF_SIZE);
> +	ret = read_product_name(product_name, I2C_BUF_SIZE);
>  	if (ret)
>  		log_info("Fail to detect board:%d\n", ret);
>  	else
> -		log_info("Get board name:%s\n", (char *)i2c_buf);
> +		log_info("Get board name:%s\n", product_name);
>  	pmic_init();
>  
>  	ddr_early_init();
> @@ -363,3 +360,32 @@ u32 spl_boot_device(void)
>  void spl_board_init(void)
>  {
>  }
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +	char fdt_name[I2C_BUF_SIZE];
> +	int i;
> +
> +	memset(fdt_name, 0, I2C_BUF_SIZE);
> +	if (!strncmp(product_name, "k1-x_", 5)) {
> +		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
> +			 &product_name[5]);
> +	}

I wonder if any normalisation would be better in board_init_f() as
board_fit_config_name_match() is basically called for each possible 
board. Same for the tolower() loop below.

> +	if (fdt_name[0] == '\0') {
> +		/* set default board name */
> +		sprintf(fdt_name, "k1-musepi-pro");
> +	}

I am not sure k1-musepi-pro is a good default. The experience is that 
the Banana-Pi F3 (known as k1-x_deb1 in the vendor code) doesn't  have a 
product name defined in the TLV EEPROM and thus should probably be the 
default.

> +	for (i = 0; i < I2C_BUF_SIZE; i++) {
> +		if (fdt_name[i] == '\0')
> +			break;
> +		fdt_name[i] = tolower(fdt_name[i]);
> +	}
> +	if (!strcmp(name, fdt_name))
> +		return 0;

I am not sure that all the vendor product names will match the linux dtb 
names, so maybe just using a table to do the mapping would be better.  
Anyway, as long as the musepi-pro is the only one supported that should 
be fine.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
