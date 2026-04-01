Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711D4D3514F
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 08:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C057180517;
	Wed,  1 Apr 2026 10:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CpmWgw8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B3584056; Wed,  1 Apr 2026 10:04:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7996480077
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 10:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d289=CA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1775030683;
 bh=TNMqW88rRkvtAz3GpHuRg+AU452iAOxznBYfQR9hQoo=;
 b=CpmWgw8OzqYPPbsSeoo579O/3xYenFVe3RFFmEyd6CLNe65GnYH+JDIp7topY4Z5BZz4aKzG2
 17lEu5X/7POhC2O66NeXxDbKm47vrG/e3AyhrL4HXvNDVduiS4ruAbnLwXkCg/sfnoW6aiA6cVA
 4XXgPjsxlz7bY4H92r6LB2IxMN5naqhE/ukiLLIW48ZEsKTdCbMRZMbFq02HgNpFhUtXIwx3Yv1
 wzKzJCu85EnnUHuChl6TjkrEchu3rwFc+QQscwuJOwL8avftjNWElkVCkISYasVrH0zN9+Sv7Mt
 LB+U3IbHZ37tTco7/gHTektqGghyIn4xX/56c+Jrd6rw==
X-Forward-Email-ID: 69ccd1971bef7da1ef83ea5b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.64
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <564fc8c9-90de-43ed-a312-5a92b16078df@kwiboo.se>
Date: Wed, 1 Apr 2026 10:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] common: Allow relocations on the top of the last
 bank
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Ilias,

On 3/31/2026 10:01 AM, Ilias Apalodimas wrote:
> Right now we only relocate u-boot to the top of the first
> memory bank unless the board specific code overwrites it.
> This is problematic when loading big binaries as it
> fragments the contiguous memory space for no apparent reason.
> 
> It's worth noting that there are cases where we must not relocate
> above the 4GiB boundary (64bit hardware with 32bit only capable
> DMA). E.g This will break platforms, if the ethernet
> controller cannot DMA above 4 GiB, and once U-Boot does
> get relocated above 4 GiB, the packet buffer which is built
> into the U-Boot binary is also relocated above 4 GiB.
> 
> Add a Kconfig option and allow the common code to relocate U-Boot
> to the top of the last discovered bank.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  Kconfig          |  7 +++++++
>  common/board_f.c | 15 +++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index ce25ea24a60f..3ebdee1b2794 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -474,6 +474,13 @@ config SKIP_RELOCATE
>  	  Skips relocation of U-Boot allowing for systems that have extremely
>  	  limited RAM to run U-Boot.
>  
> +config RELOCATE_LAST_BANK
> +	bool "Relocate to the topmost memory address"
> +	help
> +	  When U-Boot relocates, it chooses the end of the first memory bank.
> +	  Enable this if you have multiple banks and want U-Boot to relocate
> +	  to the topmost memory address
> +
>  endif # EXPERT
>  
>  config PHYS_64BIT
> diff --git a/common/board_f.c b/common/board_f.c
> index df2b0dc899bf..4270f368e653 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -309,6 +309,8 @@ __weak int mach_cpu_init(void)
>  /* Get the top of usable RAM */
>  __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  {
> +	int ret;
> +
>  #if defined(CFG_SYS_SDRAM_BASE) && CFG_SYS_SDRAM_BASE > 0
>  	/*
>  	 * Detect whether we have so much RAM that it goes past the end of our
> @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  		 */
>  		return 0;
>  #endif
> +	if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> +		phys_addr_t old_top = gd->ram_top;
> +
> +		ret = fdtdec_setup_mem_ram_top();

This seem to make assumption that memory is already fully described in
FDT? Maybe this should instead be based on gd->bd->bi_dram, however that
is possible initialized at a later initcall.

If I got the call chain correct board_get_usable_ram_top() is normally
called from INITCALL(setup_dest_addr), and gd->bd->bi_dram banks are
typically initialized in INITCALL(dram_init_banksize), a later initcall.

On e.g. Rockchip there is no memory bank information in FDT at that
stage and memory banks is populated to gd->bd->bi_dram based on
information from dram init and only later possible added to the FDT for
booting OS.

Rockchip does have a platform board_get_usable_ram_top() so this will
not be an issue, but the new generic Kconfig option added here seem to
have a dependency on FDT containing memory bank information, if I am not
mistaken. Maybe something worth mentioning in help and commit message?

Regards,
Jonas

> +		if (ret)
> +			debug("failed to relocate to ram top");
> +		ret = fdtdec_setup_ram_size();
> +		if (ret) {
> +			debug("failed to calculate RAM size");
> +			gd->ram_top = old_top;
> +		}
> +	}
> +
>  	return gd->ram_top;
>  }
>  

