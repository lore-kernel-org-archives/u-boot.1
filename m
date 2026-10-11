Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C17CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 10:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B238580EDB;
	Sun, 11 Oct 2026 10:34:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJFWIkXqFSHO; Sun, 11 Oct 2026 10:34:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B09E980CBF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791714863;
	b=H5btBTJECQUbys1Y8PBwbPho+AgTLhJ70iFcu3RRz4X/tXLV1NIeH6lrn1oMj0khsx2L
	 hrCNlFPetpyn2pRIWS6PmpPPTe9wRvW36unoCMCEWURLIpKaMByIiySYWMjDU2ft52nYS
	 8Y/YXYiFJcu6XLKOvwq8x9krh15cslS6TVXzUjVFO7QsTUXeTko5hNC++WwVrnbGDMe48
	 9BzvTqmvd/nPvaO9h7ng5XYBpZrkkr8TkAwFrLJ4tOYh8PPXryegf7H2Kl8AdeMmYCUqa
	 TpD0/cH20eqIS5r4JZjpgCdPe1r/3mQ3c8Enhcjg+1JR4ZnUN8mh+hV4q64AbkZgLAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791714863;
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
	bh=5Ll2dqPwejJUyFEKekss4O/55Oy7TaSlkR2O/EdkIio=;
	b=iLrFGs/sNwBC1XYp7bRagmc29UVLY7mh06o49mM4siNfZEU1ySaxpjUebtSRGge9WnAN
	 r9A10rJ1a9vh/76mChLJIKZtNc3d1OPYh7wXd01Qv6hmU2C82znnKzoJ9QdB1QGMiI2cV
	 Cd6y0Tju4VoYySPXG8j4pjJ6n93S8nii2fhRJhjpH8DTZ97b0TRZr+H7J4VIZfYvarWQK
	 J4vgbGeALo2hIU3ERciKtI8zGFLyVk/JO+aXAAtDSAw+z0Y5crultmg5Q/AOvKzZ27vwU
	 jMoiIMLChptlPsy+pBkouQGiKNZ454rWNeYEmvBqkFsC77vUHS2YRm4j3p2Jj/soHyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791714863;
	bh=5Ll2dqPwejJUyFEKekss4O/55Oy7TaSlkR2O/EdkIio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o1nceFJ4aUZ3MLrfXn4oXehK51Dy1gzIP/OedlEenvwNYubYlK4PTQR3BH8SqnZ3M
	 xaRr9FuQmVk2P+jObdQvC2UpZ372PN0t/ZnynBz9y10PwG7NlJ+PtKlvYPAL2GRhoz
	 dskZMtARk/O1ZyGbpGfuupDflwIz1H/mYRdu8QP5mj2HbZQM64/2FKA9lVjAkDoY/3
	 nBkDHDl2gxc4nAoyIKFvTDHutBuRhYJ1QWbMj32LjbGT4sYpYN7M/P0XQM4LZ3hVxq
	 Mh4dDpR97fgoAm4hvgJSlAbs/3XxsS6SP9UzGTTKULU3gXl4qBv3Ted7gHFsMYCT3X
	 YFt6aARQy7WyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B09E980CBF;
	Sun, 11 Oct 2026 10:34:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2762235
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B47F44068C
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWwSYKzUtoZT for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 10:34:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C329A4068A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791714861;
 b=s8dNIdF0CBmNTtZEU+7T2g5oxCI5PhYlIwGy5WzYmbDIuEFz4Xlt6r6mbq0rlfkmOZp+
 u3VkA8z55gWiYCcmhERa5KyOZMXOjl3IKcxcWaT0JcbK+4I22VMcddFJEA9q4wd5a5YMs
 NIZ8+QQW5w70v8LlN5K+BrKei5JD9oBm2kafi9hL8Cr4hJWTkWO4bHw6DISw79NQVGAOo
 vCfiPzZfRW6d+/87Hi8FgL96mdX2v8IPEJ3tPNugPaVnEJe/BxIGSpRS2YjBNRQ4HEWWj
 TB6sc8zotYITe0quyXgMT63H+OawxkSOBElvZNwgkG1weiqBgTKSmfLwixAHlZIgtKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791714861;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=5Ll2dqPwejJUyFEKekss4O/55Oy7TaSlkR2O/EdkIio=;
 b=R/tUqwzhy9JfbBAqts0PId5xAvAMkseVlipnaROF3U0GEIvW3oPG9Sw5gCP9d5OuTX4G
 4q8yj82gHPECGRjNcMs30HAPP05Fku44EgsYdUvBGj4xO2oDP9TpcXWzEOSoWQrwP7pEO
 iufU5ix1l4rZhF2OwJOcueqMxN1Uz8dIPj5KJinuGY0D1TFADxJxKVkSWUftiGYAIO791
 B4TBEmhtTqSPt/mP6w1YUhVnJePGWKJ3qjZfILZi8zTWooolOrekPEF0yO5G0bEQEj0i/
 JJe0n7YtGaxTRXm+AwbqaQaeEi9aZp4GALuMS74xCTUJfp9CA9CoWrPmb798nWjlHXA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=ycq7Dwd1; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7247=ib=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ycq7Dwd1
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C329A4068A
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791714859;
 bh=5Ll2dqPwejJUyFEKekss4O/55Oy7TaSlkR2O/EdkIio=;
 b=ycq7Dwd1zSIGbM0iHf3/UUxkhDKiY2WryBV7W8myVrUdP459HrTEp8PLIM+zPbG1CdOOgvr1E
 wuWSxhSEaaC/zO+InlASuUYrBEbOfZhFhuQPV3k+5rRu0e87LPXXU+t0GIMQ9Mlv8kkTGowmA/q
 s3N8gRgN7iUVjwZ9Y8PhNJrtpMBvjLwUmQi9ekEO9zfFrIwllZY7uXsb/Jsho4Lz+5j7SB/QPZj
 oy4Ahv+ftEcquTr2bfxxRb1pde4VRieDljeBDyqbw3opdQn/GG6l9xkSjIJ9MXqlb5HooFaw9bo
 nDi90jjzaxMV53ZeBVygdqGrjEIF2QZpxypFHe5HolNg==
X-Forward-Email-ID: 6acb6628396456127f73c8fa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <26e91c39-9766-4d59-a03f-9e09989ffabd@kwiboo.se>
Date: Sun, 11 Oct 2026 12:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] rockchip: rk3588: Use fixed CRU base address
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-3-jonas@kwiboo.se>
 <95949879-ea0f-4edd-9689-8aa27dbd721e@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <95949879-ea0f-4edd-9689-8aa27dbd721e@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On 10/9/2026 10:34 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>> The rockchip_get_cru() helper is used by the sysreset_rockchip to get
>> the SoC specific CRU base address. The helper may trigger a full clock
>> driver probe to get the fixed CRU base address from the clock driver
>> private data, something that can take several ms.
>>
> 
> OK, but isn't probing the clock driver actually making sure the 
> assigned-clocks, assigned-clock-parents and assigned-clock-rates 
> properties are respected? There's *some* side effect. Considering the 
> current user of that function, they aren't doing anything with clocks so 
> I guess this is fine on that side. But I'm getting a bit worried, is 
> there anything actually probing the clock controller driver if we don't 
> have this anymore? I guess it's fine right now because we only have an 
> SPL for RK35xx and thus have a Device Tree, but what happens when we 
> have an open TPL?

Currently probing of clock driver is very nondeterministic, hence the
series "rockchip: Always init clocks in SPL build for RK35xx" to help
ensure clock driver is probed in a deterministic way/stage.

For TPL the clock driver may or may not be required, the DRAM clocks are
typically not handled by the clock driver so the DRAM init code may not
even need to probe the clock driver.

For DEBUG_UART in bare minimum TPL for RK35xx I have been playing with,
I use the macros defined in cru_<soc>.h directly in debug_uart_init().
Something like that could be possible in size constrained TPL, or the
clock driver could be extended to handle clocks needed for DRAM init.

Snip of board_debug_uart_init() for RK3572 that ensure that the UART
clock use correct parent and divider, full at [1]:

	/* sclk_uart0_sel=osc sclk_uart0_div=0 */
	writel(FIELD_PREP_WM16(CLK_UART_SEL_MASK, CLK_UART_SEL_24M) |
	       FIELD_PREP_WM16(CLK_UART_DIV_MASK, 0),
	       RK3572_CLKSEL_CON(71));

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/blob/rk3562/arch/arm/mach-rockchip/rk3572/rk3572.c#L105

When it comes to CRU assigned-clocks, they are typically stripped from
xPL DT and will instead be applied at U-Boot proper phase. Currently
they are even applied 2-3 times due to clk_set_defaults() being called
multiple times for clock driver and also for the reset driver. Something
I will be addressing in a separate series.

> 
>> Change to return the fixed RK3588 specific CRU base address directly to
>> simplify and remove the unneeded complexity of using runtime lookup in
>> SoC specific code.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 15 +--------------
>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>> index 250ec423bd24..9b112e45f1de 100644
>> --- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>> +++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>> @@ -4,10 +4,7 @@
>>    */
>>   
>>   #include <dm.h>
>> -#include <syscon.h>
>> -#include <asm/arch-rockchip/clock.h>
>>   #include <asm/arch-rockchip/cru_rk3588.h>
>> -#include <linux/err.h>
>>   
>>   int rockchip_get_clk(struct udevice **devp)
>>   {
> 
> There's no user of that function anymore after this patch, so just 
> squash the patch removing it later in this series with this patch here.

This is a public function declared in asm/arch-rockchip/clock.h, so
dropping it in a separate commit seem more appropriate, to avoid doing
two separate things in same commit ;-)

Will send a v2 addressing your other review comments.

Regards,
Jonas

> 
> Thanks!
> Quentin

