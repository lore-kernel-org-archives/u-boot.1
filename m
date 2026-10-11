Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52B8CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 10:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ED9580DF9;
	Sun, 11 Oct 2026 10:01:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGPUjr35tRht; Sun, 11 Oct 2026 10:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD27480EAA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791712867;
	b=hjc2MwTP3vbluHontokrlVGIrV4lT9cuh4tnztg8GGLjJ1x8b6zt2hQMbxFo7b7M/ZEH
	 fMtusS++mQTUkclg1NeHgk5OPpY8Ip3C/Rk+dCpqK6j8nHrOt/uiWIwrrmiVLDLVct4rs
	 n/MOnAhkgnKJeteOJoWqSruYyRVni4djgSRh/s2K0PUuYnqHmvep5HlRoiKJqRkEI4BCT
	 Ug0V2KkeqgTHMYSwl6PZtFB2SsDL1TsmdKdkaD4xmBirZlXW00UhhcafuglqasGKzi/pp
	 tG5L271I1VFY8CAnOIbrJCPTyMOeXFsqOrBF/XZta33QzqJn/T2HViVjF8BLpK3CWFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791712867;
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
	bh=bQGz0RqRpCjiqcHvqAsYlNWjkq6Xf98qAJuTPU9uc70=;
	b=bNCNNREKx8HqjL9yFJFI4O+k0b9BIAi6FVJfMWFWcwxozjUqHzTvqploSFNHm5pHq2Kc
	 nAsV2/wO3qYHVQHfAmaQm0eD2eo3/n+9sU3AvUysq2XsS2zQvkZ7m0TuZk5GQ/OO2R45H
	 H/O+9acSIAuFHUEYlRLq01mXwRd3av5GlNtQx/ZSKZkAqLE3Dgzjita7/QiOnWlOnZ3q3
	 foc9ISLt380SqhFK5g5PQYaJw3FCO5RfGz099a10Y031/szH5Vm7xpVzMuXIeux4w12px
	 2v9nvabJqr1Oz0BPlhpHU7h/Jcx5mUH1/YZUk5fsfQqpsGguZ2/El02nvxQ4RGBGHXA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791712866;
	bh=bQGz0RqRpCjiqcHvqAsYlNWjkq6Xf98qAJuTPU9uc70=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rSOdCLEPKHbTSW42ywsdPrA3XK4wbYtCUawYnB/KZ9ljy5jTse4Maz5pEIU5Cc/DK
	 NpM4gLfBv9tGPNsxcZNRCFYIMWFxCIhqYNPUH4+RbK0pC9xOCfD6vBX6mXTHFc0kNQ
	 VDcLXvLTMn5IrsdyBn0yOmROeg0s38bq+S6QmxBjA2+pjZ0XoCTzH0cCvnEghCUh4x
	 GVCYl+hA+cBtUuZIH8QFdtTLBrLKxdxUDeD6pfHoAtlEX6E1CAtcvMnIKykdXvlQms
	 PsnfI1x2fEIjFlVneLeBWcfod1V1Px7IDGY+3AM8oocw7I28Zvrzov9Amem/IPlfMe
	 aW95K2oo6npGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD27480EAA;
	Sun, 11 Oct 2026 10:01:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 898E3317
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B1014067C
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wcv8jeLTGnjr for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 10:01:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C73BB40677
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791712864;
 b=LF/03Vj7QLLtNKAWqu0YDf+yxs9Ig9YKIXbvuiT/7IsYgc2ubCxY9bXoMVFOXjvbmRcr
 KwSBgARMZdtEvhWIxEgm7MUn9qDQhRaSUFbOYAE2B8CJ92A43LRll2cMleMhSfPoPM8eX
 ovD8ayXpoS3VAKd+/jqIOLKUFH3OxgrpyKc0kaPnpXZ7t2kVkAy97pG8GA1WU1ENgmdKf
 ezH7BCwOz2KTQEuGpJAIwbF+qi7cE2EscwmY/yF3RAQX/nIuO4f+oz1ARX/2LKBJVedeg
 xgEPmJaIdj/88UxMAOFhgk8VxX+BsrY17gqzXfrc3kC1Lil+EOalIc5f68RH5VIzcTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791712864;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=bQGz0RqRpCjiqcHvqAsYlNWjkq6Xf98qAJuTPU9uc70=;
 b=S22gkE9vFCvr+j25zO9Dj+oARxXOSYgUpJ6KggK06awckzTe8kQ6JJoAo+Pdx4Elkjm/
 Yo5C8OaDVQ0RiYgCMeXlvjkivtEdsvj33JaZYXQi7qf/m66LOa9wasQb0PVnej5S150QY
 CZ/s38ZHvs73/MzNxNbUvaMqeCWmQ5ottxw6W12xqeTumvSDDetmG9+2249J+KviSDmTj
 GGqZmjiQ9lSqyokh6VZX1PwHvPbbPvCv/gjvuodKFe/JR3X7/x6zGiPEcW9zs6cuiMlYG
 boOmScF8vaHkVLhrmPe5wAPdhPbkSihMEnuR5t7EisdvLBYfUyvhtPHRPUIJD/izBgA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=iFGkREcR; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7247=ib=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=iFGkREcR
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C73BB40677
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791712862;
 bh=bQGz0RqRpCjiqcHvqAsYlNWjkq6Xf98qAJuTPU9uc70=;
 b=iFGkREcROi6lucLQ9SHy4AzKc5mFbMS5jYMLCeHfPvuIBZt626uELSsWBiYivWakeZl2AtW+7
 EAuhUF2ph1cUchwg3GsB2+eyGYQR0jvEYdSBVhGh+IZPmuSfOVlo1l7R5poYP8k2mpMe/kBFlIL
 uMs0SaLMSnPVD2CJkkDhMqydLPBI8IFpxhQhD+Dzu2TjxBxjy+ch6YHt81vPc8WYGese4CdR66h
 xPcpFhCvPtKW2R5zIsXhCwHasWZ0rFHdvmrrRcSPPJTjiAT7zM+n376yZB6zVld4c70tz8LSxEL
 kpYgdlKjV3DvrNfZJL4rmzaZfWvvK9jJRFQ4aqRXNt1g==
X-Forward-Email-ID: 6acb5e5a90d5aa3528e30a64
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9c9adba7-1a83-43f9-8bbf-8473cd8cba06@kwiboo.se>
Date: Sun, 11 Oct 2026 12:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] rockchip: Remove unused rockchip_get_clk() helpers
 for RK35xx
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <a3367c8d-6352-42d0-87d5-e325652fc225@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a3367c8d-6352-42d0-87d5-e325652fc225@0leil.net>
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

On 10/9/2026 10:10 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>> This series takes the initial steps to try and remove use of
>> rockchip_get_clk() to get the clock device or rockchip_get_cru() to get
>> the CRU base address at runtime for the Rockchip platform.
>>
>> This series is similar to the "rockchip: Remove unneeded syscon driver
>> for RK35xx" [1] series, but focuses on CRU instead of GRF.
>>
>> The CRU base addresses are fixed and known at compile time, yet drivers
>> keep trying to resolve them at runtime delaying some operations by
>> several ms.
>>
> 
> I would rather use device tree whenever possible, instead of relying on 
> hardcoded constants. Considering the contexts in which 
> rockchip_get_cru() and rockchip_get_pmucru() are called (that is, in the 
> DRAM driver will eventually be called only in DM-less TPL so cannot rely 
> on DT being present to fetch CRU from it, and in the sysreset driver 
> which doesn't have a description in the device tree), this here is 
> acceptable to me as is. But we should think about documenting the 
> exceptions to the "please get the info from device tree and do not use 
> hardcoded addresses" rule. A problem for later :)

I agree, we should use values from device tree where possible and
appropriate. And as mentioned in the other thread, my acceptable
exceptions are CRU, RAM and arch_cpu_init()+board_debug_uart_init() in
xPL. With main reason being that anything in TPL (dram init) may or may
not have access to DT, DM or otherwise be size constrained. And in SPL
typically because of consistency, e.g. code may be shared with TPL, or
we may need to do some one-off thing for a specific SoC, e.g. disable
JTAG in arch_cpu_init().

Regards,
Jonas

> 
> Cheers,
> Quentin
> 
>> In this initial part the RK3568 and RK3588 specific helpers are updated
>> to use CRU base address constants, similar to the other RK35xx SoCs, and
>> the rockchip_get_clk() helper is removed for all RK35xx SoCs.
>>
>> The changes included in this series have no intended behavior change for
>> the affected RK35xx SoCs.
>>
>> A follow-up series will introduce a rockchip_sysreset_bind() helper that
>> passes the CRU base address to the sysreset_rockchip driver, drops the
>> call to rockchip_get_cru() along with implementing the get_status() ops.
>>
>> [1] https://patchwork.ozlabs.org/cover/2280781/
>>
>> Jonas Karlman (10):
>>    rockchip: rk3588: Rename CRU_BASE to RK3588_CRU_BASE
>>    rockchip: rk3588: Use fixed CRU base address
>>    rockchip: rk3568: Use fixed CRU and PMU CRU base addresses
>>    clk: rockchip: rk3568: Use fixed PMU CRU base address for PLL access
>>    rockchip: rk3568: Remove unused rockchip_get_pmucru() helper
>>    rockchip: rk3568: Remove unused rockchip_get_clk() helper
>>    rockchip: rk3588: Remove unused rockchip_get_clk() helper
>>    rockchip: rk3576: Remove unused rockchip_get_clk() helper
>>    rockchip: rk3528: Remove unused rockchip_get_clk() helper
>>    rockchip: rk3506: Remove unused rockchip_get_clk() helper
>>
>>   .../include/asm/arch-rockchip/cru_rk3568.h    |  5 ++-
>>   .../include/asm/arch-rockchip/cru_rk3588.h    |  2 +-
>>   arch/arm/mach-rockchip/rk3506/clk_rk3506.c    |  8 +---
>>   arch/arm/mach-rockchip/rk3528/clk_rk3528.c    |  8 +---
>>   arch/arm/mach-rockchip/rk3568/clk_rk3568.c    | 44 +------------------
>>   arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |  8 +---
>>   arch/arm/mach-rockchip/rk3588/clk_rk3588.c    | 23 +---------
>>   .../jaguar_rk3588/jaguar_rk3588.c             |  2 +-
>>   .../tiger_rk3588/tiger_rk3588.c               |  2 +-
>>   drivers/clk/rockchip/clk_rk3568.c             | 34 +++-----------
>>   10 files changed, 18 insertions(+), 118 deletions(-)
>>
> 

