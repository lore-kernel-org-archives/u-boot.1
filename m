Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DB5CCF2D2
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A3B83966;
	Mon, 19 Jan 2026 10:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="pxgqN0Zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120788397A; Mon, 19 Jan 2026 10:41:22 +0100 (CET)
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE9A80B98
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768815673; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ezenx/zrrctMpnWGkj7uhLBWh/5CHpxE0AlPBjeTsis5uFrb318ygJuD2Iyg0jXP8p5nKWoHSUFg4780vVrOhqfMR1hu4Nm1JVnY1GDqL/iCnALixAV3iVJeVpjwWxvdJKJ05+ozxx6AUH+pi+jFXXyz6mtEIB1UYzXBHtuqaAs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768815673;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aHN7JD8y9lH5wfHD1bzYx3LfCq6ZxVquSyPe7xegpEo=; 
 b=TQq8skriv1O7Fjl/c5wGDyQ8opyVJuhv2nDEu12de83kVlAA9Lec9G1Q742T2cM11Yxgky5xb26XxnoTy07mJsVuLL3Bb9/Rr9hrNgKU3BVcYX1S5X0oBS4IAxgZM6codMLqbRqmpySCnsTB9dUvQljILU4vdlPGrABAV+gprPA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768815673; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=aHN7JD8y9lH5wfHD1bzYx3LfCq6ZxVquSyPe7xegpEo=;
 b=pxgqN0Zwd/DS9xds+DM5sX+btSL2nTQmBsBKsV5FEQc+giC30A/VcmS0p0gOTHIj
 4XsQeUmkcQTQULBSpQUvmg/fzVn4plfC3fxgm8iGMUKLnsduhOWA3d5+bAbeKXDcwF5
 WvOxjhj9VQlVq0svqThT0wbRsHLEUfgrNmt48Qew=
Received: by mx.zohomail.com with SMTPS id 1768815669721273.01632667549984;
 Mon, 19 Jan 2026 01:41:09 -0800 (PST)
Date: Mon, 19 Jan 2026 09:40:48 +0000
From: Yao Zi <me@ziyao.cc>
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 14/17] spacemit: k1: Add DDR firmware support to SPL
Message-ID: <aWyryi4ZPNgNIejE@pie>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-15-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117190231.977686-15-raymondmaoca@gmail.com>
X-ZohoMailClient: External
X-ZohoMail-Owner: <aWyryi4ZPNgNIejE@pie>+zmo_0_me@ziyao.cc
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

(My mail provider complains about the huge list of recipients, so I
reduced it a little.)

On Sat, Jan 17, 2026 at 02:01:48PM -0500, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
> 
> Include DDR initialization firmware in the SPL image. The firmware
> path can be specified via the DDR_FW_FILE environment variable. If
> the firmware is not found, an empty placeholder file is created to
> allow the build to proceed without DDR initialization support.
> 
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>  arch/riscv/dts/k1-spl.dts      |  34 ++++++++++++++++++++++++++++++++-
>  board/spacemit/k1/Kconfig      |   8 ++++++++
>  board/spacemit/k1/Makefile     |  19 ++++++++++++++++++
>  board/spacemit/k1/spl.c        |  30 +++++++++++++++++++++++++++++
>  include/configs/k1.h           |   3 +++
>  lib/vendor/spacemit/ddr_fw.bin | Bin 0 -> 19416 bytes

It's unusual to ship binary firmware in U-Boot repository. Please place
the firmware somewhere else, and give a clear instruction in the
board/architecture documentation explaining how to obtain/build it.

>  6 files changed, 93 insertions(+), 1 deletion(-)
>  create mode 100644 lib/vendor/spacemit/ddr_fw.bin

...

> diff --git a/board/spacemit/k1/Kconfig b/board/spacemit/k1/Kconfig
> index 9f9c806d00d..a5fa788f660 100644
> --- a/board/spacemit/k1/Kconfig
> +++ b/board/spacemit/k1/Kconfig
> @@ -15,6 +15,14 @@ config SYS_CONFIG_NAME
>  config TEXT_BASE
>  	default 0x00200000
>  
> +config SPL_DDR_FIRMWARE_OFFSET
> +	hex "DDR firmware offset in SPL image"
> +	depends on SPL
> +	default 0x20000
> +	help
> +	  Offset where DDR firmware should be placed in the SPL
> +	  image.
> +
>  config SPL_OPENSBI_LOAD_ADDR
>  	default 0x00000000
>  
> diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
> index 7bce47bac8c..ebe6e55867c 100644
> --- a/board/spacemit/k1/Makefile
> +++ b/board/spacemit/k1/Makefile
> @@ -5,3 +5,22 @@
>  
>  obj-y := board.o
>  obj-$(CONFIG_SPL_BUILD) += spl.o
> +
> +DDR_FW_SRC ?= $(DDR_FW_FILE)
> +FW_TARGET = $(srctree)/lib/vendor/spacemit/ddr_fw.bin
> +
> +DDR_FW_HEADER = $(objtree)/include/generated/ddr_fw_info.h
> +
> +$(obj)/spl.o: $(DDR_FW_HEADER)
> +
> +$(DDR_FW_HEADER): $(FW_TARGET)
> +	@echo "/* DDR firmware info - $$(date) */" > $@
> +	@if [ -f "$(FW_TARGET)" ]; then \
> +		SIZE=$$(stat -c%s "$(FW_TARGET)" 2>/dev/null || echo 0); \
> +	else \
> +		SIZE=0; \
> +	fi; \
> +	echo "#define DDR_FW_FILE_SIZE	$$SIZE" >> $@
> +	@echo "/* Note: Update ADDR if binman layout changes */" >> $@
> +
> +clean-files += $(FW_TARGET) $(DDR_FW_HEADER)

Please make use of existing binman[1] facibilities to avoid the extra
Kconfig and Makefile pieces. binman_sym() could be used for obtaining
both size and offset of a binman entry.

> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index 6fe064bd430..54bad9000fe 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c
> @@ -6,10 +6,12 @@
>  #include <asm/io.h>
>  #include <clk.h>
>  #include <clk-uclass.h>
> +#include <cpu_func.h>
>  #include <configs/k1.h>
>  #include <dm/device.h>
>  #include <dm/uclass.h>
>  #include <dt-bindings/pinctrl/k1-pinctrl.h>
> +#include <generated/ddr_fw_info.h>
>  #include <i2c.h>
>  #include <linux/delay.h>
>  #include <log.h>
> @@ -115,6 +117,33 @@ void serial_early_init(void)
>  		panic("Serial uclass init failed: %d\n", ret);
>  }
>  
> +/* Load DDR training firmware */
> +int init_ddr_firmware(void)
> +{
> +	void __iomem *src, *dst;
> +	unsigned long size;
> +
> +	src = (void __iomem *)(CONFIG_SPL_TEXT_BASE +
> +			       CONFIG_SPL_DDR_FIRMWARE_OFFSET);
> +	dst = (void __iomem *)(DDR_TRAINING_DATA_BASE);
> +	memcpy(dst, src, DDR_FW_FILE_SIZE);
> +	size = round_up(DDR_FW_FILE_SIZE, 64);
> +	flush_dcache_range((u32)(u64)dst, (u32)(u64)dst + size);
> +	return 0;
> +}
> +
> +void ddr_early_init(void)
> +{
> +	void __iomem *addr;
> +
> +	init_ddr_firmware();
> +	addr = (void __iomem *)(CONFIG_SPL_TEXT_BASE +
> +				CONFIG_SPL_DDR_FIRMWARE_OFFSET);
> +	// verify DDR firmware header

However, you don't verify it, but only print some of the information.
The comment seems misleading and extra.

> +	log_info("[0x%x]:0x%x, firmware size:%d\n",
> +		 (uint)(u64)addr, readl(addr), DDR_FW_FILE_SIZE);

Regards,
Yao Zi
