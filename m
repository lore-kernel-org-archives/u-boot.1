Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA6FCD128E
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 11:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB5A87E53;
	Sat, 30 Mar 2024 12:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LcM4EIuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A94487FC1; Sat, 30 Mar 2024 12:01:08 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A29D87DCC
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=52ff=LE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1711796453;
 bh=WJlvChYHVgwg7IhQmyfyg2EPRYJQGGizxi95b3v9Quk=;
 b=LcM4EIuX3faTVrPHEClRWQ8s9tHvFL20VbF4P665pTVQrhZPu1tl124DvD7bIJoyQK/815iS9
 V10oDWUriE0KzNoleUZyJqjWY4EM3/y8IZNslSYbvkkolgZ0fh8QswxKyw44ehykT6GRwqOr+lZ
 /jhNtfOeE1KRyBw2rFrNha+L4LpKJUVctrbp/aRk74JlweqFIY7Vmloo3Q02JMdlVentxb2EVJD
 ixrF4hMeIej2U3zzltdHCDSPT/582a0180gCCwqGZOuJlDu+eOhEoTUIx3Gu30ARP8eXGYByqcM
 jPrWq00JkaqA8/LWKyHrsxZwx3Zzy97rGKqS/BJVP3Ew==
Message-ID: <44dc2249-3ec3-491b-8ce2-dc254a97ddfc@kwiboo.se>
Date: Sat, 30 Mar 2024 12:00:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] rockchip: sdram: Allow board/soc specific RAM bank logic
To: Chris Morgan <macroalpha82@gmail.com>, Chris Morgan
 <macromorgan@hotmail.com>
Cc: eugen.hristev@collabora.com, kever.yang@rock-chips.com,
 xypron.glpk@gmx.de, cym@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20240330050515.470025-1-macroalpha82@gmail.com>
 <20240330050515.470025-2-macroalpha82@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240330050515.470025-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6607f0e4eaa1e9e0a464c4d2
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

Hi Chris,

On 2024-03-30 06:05, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Allow individual boards or SoCs to alter the RAM bank addition logic
> by defining a __weak function that these boards can then override
> if needed. In the event this function fails, fallback to the default
> detection logic.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm/mach-rockchip/sdram.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 0d9a0aef6f..53aa19feca 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -35,11 +35,18 @@ struct tos_parameter_t {
>  	s64 reserve[8];
>  };
>  
> +__weak int rk_get_ram_banks(void)

I would call this rockchip_dram_init_banksize()

> +{
> +	return -EINVAL;

and return 0 in default implementation,

> +}
> +
>  int dram_init_banksize(void)
>  {
>  	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
>  	size_t top = min((unsigned long)ram_top, (unsigned long)(gd->ram_top));
>  
> +	if (!rk_get_ram_banks())
> +		return 0;

and something like:

ret = rockchip_dram_init_banksize();
if (ret)
	return ret;

is probably a better pattern when allowing board specific weak
implementations.

Regards,
Jonas

>  #ifdef CONFIG_ARM64
>  	/* Reserve 0x200000 for ATF bl31 */
>  	gd->bd->bi_dram[0].start = 0x200000;

