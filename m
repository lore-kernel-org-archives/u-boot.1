Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075B606A338
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S82bllN9;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=oruo0Q23
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF6FA40EB6;
	Sat, 14 Nov 2026 00:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NmSQG_Pb7Gai; Sat, 14 Nov 2026 00:23:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B56BD40E5B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794615783;
	b=IUjOrxWRA/t94hPx8bC512dvGf4Vzt/mxqnLgZLBR54NZXh/sNMlvgK6gu112VaU6ipw
	 tWZlTDd+QDCFLxZT4xbIiJDo2gjYgaL8ZTSLwf1X6Duz20nIaBag2QgfMiliHxLaPEqFg
	 hVcGZi4DZkuHT7pzGp8KaBj5xNCeJ6It9aNSgeXpL/hQrEn4Tn743uFD6g5yjwtBbtOxM
	 tvumHmHqdvfic6oNun3R/r+NNW84lqNgS8+vVJt4wFp29nV1jn7XhTzN53y5YJrq88Wu2
	 X6eiFIfUqePwSs1cb1PxjIZ8Y1n9GYgIWbV1y5nz92SJ/VzcjFcnj9oK614f7ChjtrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615783;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MRJS8LDfIikaUNG85oOz9PvoNFuzmp3rv8JJr/AhOnM=;
	b=M5tKjHPlXWWg0hMxcfZiwSR1fUbGzBykYnGBelZS+nWWYF/+U699fPass9dB88r8W1aO
	 F70ytJsKKHQ1crhSI/OR+SeOXg6FHQk4dwT0QdcdNZLMOfz8OM9Vy0pBa42IB/Oq1Wu3K
	 hViyS+vLOfdvD7g5OjfLJojof40BBrYbC7xeC95B8MuT0Fdd+v/OyhObRC1TXAA6tgUEo
	 9CjaPwrXtXzIEzz6ZXnXaE6OKGOY7TazloLKXiU0eETacMD0dRMIRkwcOt26Fhar4in30
	 w+QiCWDcfbibJqUucwJCpFMbv4X7AtcfbNlcJpi+pSqV5QZocNjxHdHhHgtcUBO9mnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794615783;
	bh=MRJS8LDfIikaUNG85oOz9PvoNFuzmp3rv8JJr/AhOnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S82bllN9aJ2S7BGjkGmz2KphlIlCxdqIK76HCGSaQZE0biUFbaHkB57iJewI2YGlz
	 4BiPWHuHw36jdB5ShSfET7kTpAeQynKlvuFLDd/MJOLADEYB1dGrc1LPBHQ4FxiMpP
	 oKHtrFKB06cJomahixBsWU975Y/gl0BQ+dV3swOjjd9IzHJM+h1XJLhxy5SY/N6sEi
	 Bd41rirfU0GA6Ghbmd58tY9WlIHGvp749FtvQc7C/2GgbhPySO/Eby268pJIXOvyIS
	 0Rmq1i7+cyG2jhiY7oMeD7J3RTn3kPd5QDrt185JYzp8QvegrIKjf99bj52KmABUxN
	 AHfnyTzy6ajKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B56BD40E5B;
	Sat, 14 Nov 2026 00:23:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E676260
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E89940269
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:23:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nFoPFN0WpuIS for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:23:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2A8714025F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c646=jd=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=oruo0Q23
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A8714025F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID; q=dns/txt; s=fe-e1b5cab7be; t=1794615779;
 bh=MRJS8LDfIikaUNG85oOz9PvoNFuzmp3rv8JJr/AhOnM=;
 b=oruo0Q232NCfJcA89ULfjmcauA++sALxMh7yYN43ASzrrYRcbRCT5gJ67jjZys+803YCCOthf
 TI4ytUmNOs7tdtTjaTlNYKp9WMq1Np8wK/+meMmRoCYt1B3Kv0LD/t4hL0RolTwAPDyAhS+2BHF
 oDb4Z+ZI9GG9dYuWkYyX/EMszWS9F3I8cy/JLw3GB1oJk+sYz9MytLOxnDaQ1s6vhSUBCKYN3iC
 49FKwsFg2w38qANIGan3aoFcpLTHRknl0svGBRjpMbFRj2GOv70KDW9RvGQDkpJlaPqlx9SCgMP
 vta73BGCsC2uR1rGXDhbf2tblfxjZTAWTvEZ55gsmANA==
X-Forward-Email-ID: 6af7a9e2b148dd192a980e5d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.21
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <cb636637-c2cb-4541-abf6-9dfdc6e66207@kwiboo.se>
Date: Sat, 14 Nov 2026 01:22:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] clk: rockchip: rk3588: Rename PPLL register macro
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@nabladev.com>, Kever Yang
 <kever.yang@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 u-boot@lists.u-boot-project.org, Jagan Teki <jagan@edgeble.ai>
References: <20261111231251.160051-1-jonas@kwiboo.se>
 <20261111231251.160051-7-jonas@kwiboo.se>
 <57bd6b96-159c-461e-8d41-34005d538369@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <57bd6b96-159c-461e-8d41-34005d538369@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 11/13/2026 6:25 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 11/12/26 12:12 AM, Jonas Karlman wrote:
>> The PPLL registers belong to the PHP CRU, rather than the PMU CRU.
>> Rename the register macro and update the PPLL entry to reflect this.
>>
>> Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> I had a few other things I would have liked in this series as said in 
> v1[1]. I'll do a follow-up with those.

I should probably have been more precise in the cover letter, this series
was primarily about fixing simple copy/paste issues ahead of a future
refactoring series. And your requests in v1[1] sounded more like refactoring
changes I had already changed in the intended follow-up refactoring series.

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin
> 
> [1] 
> https://lore.kernel.org/u-boot/9a3af141-7a1b-48de-8156-026a09146455@cherry.de/
> 
>> ---
>> Changes in v3:
>> - No change
>> Changes in v2:
>> - Split from "rk3588: Fix trivial clock configuration errors"
>> - Add fixes tag
>> ---
>>   arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 +-
>>   drivers/clk/rockchip/clk_rk3588.c               | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
>> index c83010e518ee..39295adeb38a 100644
>> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
>> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
>> @@ -126,10 +126,10 @@ struct pll_rate_table {
>>   #define RK3588_SDMMC_CON0		0xC30
>>   #define RK3588_SDMMC_CON1		0xC34
>>   
>> +#define RK3588_PHP_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
>>   #define RK3588_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0x800)
>>   #define RK3588_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0xa00)
>>   
>> -#define RK3588_PMU_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
>>   #define RK3588_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x300)
>>   #define RK3588_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x800)
>>   #define RK3588_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0xa00)
>> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
>> index de435f7d0ec0..fb218ff995cd 100644
>> --- a/drivers/clk/rockchip/clk_rk3588.c
>> +++ b/drivers/clk/rockchip/clk_rk3588.c
>> @@ -61,7 +61,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
>>   		     RK3588_MODE_CON0, 2, 15, 0, rk3588_pll_rates),
>>   	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
>>   		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
>> -	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
>> +	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PLL_CON(128),
>>   		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
>>   		     rk3588_pll_rates),
>>   #ifdef CONFIG_XPL_BUILD
> 

