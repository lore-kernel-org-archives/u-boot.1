Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08417C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 19:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40E182B34;
	Sun, 25 May 2025 21:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LnP/c4JM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900E882B37; Sun, 25 May 2025 21:44:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A02E82B33
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 21:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=671e=YK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1748202263;
 bh=TdqKnxj5uItq5XPTibbzLSZOyOFfqRlXIOdXy7hkkYk=;
 b=LnP/c4JMVz5tb/u1uV3S5J5ZtHKY7YDE0FZML65r0MrwCNS3ljqLJSPL2G7FfA0kuCmXpI049
 cYeqEQgRYlQW53l+4frLsNWhUT4SlMfa/64bCn4alQ4W00iwSjMUZda8oBC4Ouo8L9br2IlJgKc
 cbMAyQslY59/4ODxAtF5eCllzv70Ezfx1yCsjUnKK/nQMczKZVgV+jGXtwp0FqwoqyziBFB77Dh
 6uCqjO9WSJC2tAXejZjkDmBCfkzaryiE+GLsX7Qj0h3E5J6iDKDTb4Ggy3Fyvy/dfbPq9TRP9rY
 x9K46ilT0m+rB6dJRYOBNOy8ZAUmx+sUx6rrtamHfbtQ==
X-Forward-Email-ID: 68337311a0e3f2dd0ce240b1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <89610f14-47d8-4896-a1a9-c37b68138b60@kwiboo.se>
Date: Sun, 25 May 2025 21:44:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/25] rockchip: Relocate bloblist at the end of the
 SPL phase
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250525104801.1440260-1-sjg@chromium.org>
 <20250525104801.1440260-25-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250525104801.1440260-25-sjg@chromium.org>
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

Hi Simon,

On 2025-05-25 12:48, Simon Glass wrote:
> Where the bloblist is located in internal memory and TF-A's BL31 blob
> removes access to this memory, the best option seems to be to relocate
> the bloblist just before running TF-A.
> 
> Do this at the end of SPL.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Add the BLOBLIST_RELOC condition as well
> 
> Changes in v2:
> - Move this logic into board-specific code
> 
>  arch/arm/mach-rockchip/spl.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index 305373a161c..a919246c4aa 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -3,6 +3,7 @@
>   * (C) Copyright 2019 Rockchip Electronics Co., Ltd
>   */
>  
> +#include <bloblist.h>
>  #include <cpu_func.h>
>  #include <debug_uart.h>
>  #include <dm.h>
> @@ -133,6 +134,20 @@ void board_init_f(ulong dummy)
>  
>  void spl_board_prepare_for_boot(void)
>  {
> +	/*
> +	 * On RK3399, TF-A is executed after SPL and before U-Boot. It removes
> +	 * our access to the IRAM. So move the bloblist to RAM.

Please rephrase this as TF-A is executed after SPL and before U-Boot
proper for all Rockchip AArch64 not just RK3399. Also please reference
SRAM instead of IRAM, as SRAM is what is referenced in Rockchip docs.

> +	 */
> +	if (xpl_phase() == PHASE_SPL && IS_ENABLED(CONFIG_VPL) &&

It does not make sense to make this VPL only, as relocation of bloblist
could possible be used without VPL?

Regards,
Jonas

> +	    CONFIG_IS_ENABLED(BLOBLIST_RELOC)) {
> +		ulong addr = CONFIG_IF_ENABLED_INT(BLOBLIST_RELOC,
> +						   BLOBLIST_RELOC_ADDR);
> +
> +		log_debug("Relocating bloblist %p to %lx\n", gd_bloblist(),
> +			  addr);
> +		bloblist_reloc(map_sysmem(addr, 0), bloblist_get_total_size());
> +	}
> +
>  	if (!IS_ENABLED(CONFIG_ARM64) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
>  		return;
>  

