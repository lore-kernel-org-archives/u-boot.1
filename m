Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FEDE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870C18060C;
	Tue, 14 Jan 2025 14:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="ZSYy616y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD6880657; Tue, 14 Jan 2025 14:48:01 +0100 (CET)
Received: from mail.per1cycle.org (unknown [IPv6:2a01:4f8:c013:8d4e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 798B2805CD
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 171193F708; Tue, 14 Jan 2025 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1736862476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dWeQ0xvDXstfobWgnb14RQXXMOsOZFTQIQ2/1bpIYwE=;
 b=ZSYy616yKyxkV4FIQWl6uEz2w55MtjDJ8K5qyFoklrvhaJKcaMhgbXUl/rDNQfv76WYbzA
 ShV8U4Xo9brL8VWxohgzgQ1ZoLiJr/f/whhK53Mkw9Sh2Vx3Tiyut8MysXdKgpgjwhTeYx
 l9TpDMq/kb1au6UqxeXJVm8EeyExWDEncXEFnhm43CbbjyTuDra6jiADNvUuF40ZmJ2WR6
 mmMHbGhANrk4zAGZeN7CUt+itvnHBNVtffhEGwckL1WqTlQw0rl4BCeV/zgLaoUUQ48Irw
 SKczi/qcXHBRp1jD1MzCuY9fc64aNVLylCtBj1VJ60Oa6Q4fhzXlDEBoMZu4Qw==
Date: Tue, 14 Jan 2025 21:47:36 +0800
From: Huan Zhou <me@per1cycle.org>
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH v3] riscv: spacemit: k1: probe dram size during boot phase.
Message-ID: <20250114134736.swn65kx4hxz47nss@per1cycle.per1cycle>
References: <20250114-get-dram-size-v3-1-83d5f88154d4@per1cycle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-get-dram-size-v3-1-83d5f88154d4@per1cycle.org>
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, Jan 14, 2025 at 04:01:25PM +0800, Huan Zhou wrote:
> Implement functionality to probe and calculate the DRAM size during the boot phase for the RISC-V spacemit K1 platform.
> The `map_format_size` function extracts the memory density from a given value, while `ddr_get_density` aggregates the sizes of the memory chips.
> The `dram_init` function initializes the global RAM base and size based on the detected DRAM density, ensuring proper memory configuration at boot.
> 
This commit message is a little bit too long, will be fixed in next version :(
> Tested-by: Marcel Ziswiler <marcel@ziswiler.com> # BPI-F3 16G
> Signed-off-by: Huan Zhou <me@per1cycle.org>
> ---
> This patch introduce improvement for get dram size on spacemit k1 platform,
> retrieving the dram size dynamically.
> Have tested on Licheepi LPI3A 8G[1].
> 
> Links:
> [1] https://gist.github.com/per1cycle/e4eab66ebb6f83fe5118e823367fce28 .
> 
> Changes in v3:
> - Remove the inline attr in arch/riscv/cpu/k1/dram.c map_format_size().
> - Add detailed commit message.
> - Link to v2: https://lore.kernel.org/r/20250114-get-dram-size-v2-1-aba5a281ea28@per1cycle.org
> 
> Changes in v2:
> - Fix bracker and return type in map_format_size() function.
> - Add test log in the cover letter..
> - Link to v1: https://lore.kernel.org/r/20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org
> ---
>  arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..54d209ca277db7b304df04f81b12ae4efa400e45 100644
> --- a/arch/riscv/cpu/k1/dram.c
> +++ b/arch/riscv/cpu/k1/dram.c
> @@ -4,17 +4,53 @@
>   */
>  
>  #include <asm/global_data.h>
> +#include <asm/io.h>
>  #include <config.h>
> +#include <bitfield.h>
>  #include <fdt_support.h>
>  #include <linux/sizes.h>
>  
> +#define DDR_BASE 0xC0000000
>  DECLARE_GLOBAL_DATA_PTR;
>  
> +static phys_size_t map_format_size(u32 val)
also this part will be rename more properly.
> +{
> +	u32 tmp;
> +
> +	if (!(val & 0x1))
> +		return 0;
> +
> +	tmp = bitfield_extract(val, 16, 5);
> +	switch (tmp) {
> +	case 0xd:
> +		return 512;
> +	case 0xe:
> +		return 1024;
> +	case 0xf:
> +		return 2048;
> +	case 0x10:
> +		return 4096;
> +	case 0x11:
> +		return 8192;
> +	default:
> +		pr_info("Invalid DRAM density %x\n", val);
> +		return 0;
> +	}
> +}
> +
> +phys_size_t ddr_get_density(void)
> +{
> +	phys_size_t cs0_size = map_format_size(readl((void *)DDR_BASE + 0x200));
> +	phys_size_t cs1_size = map_format_size(readl((void *)DDR_BASE + 0x208));
> +	phys_size_t ddr_size = cs0_size + cs1_size;
> +
> +	return ddr_size;
> +}
> +
>  int dram_init(void)
>  {
>  	gd->ram_base = CFG_SYS_SDRAM_BASE;
> -	/* TODO get ram size from ddr controller */
> -	gd->ram_size = SZ_4G;
> +	gd->ram_size = ddr_get_density() * SZ_1M;
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 19fc0b7f7d907119a13e9c207991899f0817f8fc
> change-id: 20250108-get-dram-size-65cf59a15201
> 
> Best regards,
> -- 
> Huan Zhou <me@per1cycle.org>
> 
