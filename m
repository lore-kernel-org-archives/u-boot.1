Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B365CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C71ED40596;
	Mon, 12 Oct 2026 16:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uz1gnXXSuJwe; Mon, 12 Oct 2026 16:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B172740576
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791822235;
	b=pFLYgpN2tvdpn5auqlP0qQsEqz7xRLibtynlwLB2JdXQLRvDg5+pakHuH9nV7TvnYADf
	 za4d2uGe6grRnCXhsox/fzIhU0FhufBgUTGJ6BvzIcp8of+8u4LRmZjiB4ijF8DgZxvlp
	 hU8pvwkhUKEfbRGXIcFv7D7AL5V2Q4WaPfCAsnSvxWt8AdG/Ft29DqQ1BWzmKfdZPM532
	 gHZLrp2HHeHBekICbMNqWZrA2Y+8DqTcguQ4nmjNETy/DyV57jpj3Obpi6fC38c4u7AhC
	 Z7C0ofkWYk2EL77FJlpcSW3IB+TsPOdJJ1ezSwkVKpNL0GIFldnQK2Gmiy7inj0Fe2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791822235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uP623c34yldOwQvBR4xBBTl5FyDqB/5fi+jcNCIdEZw=;
	b=TfYPGicLS3ZO8PGe8liXMgcKZuDCFYJ/AH12KiWwHeflW62C0ML0FCO07RPi8YkXuEDb
	 rsg5VCKGIiyUiHKDGTLKaXr6SqahTu5aMw3S0I6/fHSqudva4zjDFXTg7c4OGIMuU2hsK
	 Hu+v7lags/FAI7LIZLP0gU+W+optTltBXj7aoi6wFgiwRJBRWgrPe24hJBVQuRBa0s9eu
	 ZIti39Pdrt79s/knhfhe2aU81ud1UYVNb7aQykPoV/FXK5Npp6wSQn0aeVqUrY2Tt6dPr
	 VsK4lZa2CjhwhFJBniwjmzKdFNOjtXpUH9POvUK+RWNM1rZxmWFcFHpBvivjJimDePg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791822235;
	bh=uP623c34yldOwQvBR4xBBTl5FyDqB/5fi+jcNCIdEZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uev21QTWkuTt8cE7bB6SaixyKiaJpA/R6nrA5jp/bUmq9f0k2UcRgCVGjmva3KRfF
	 K3DaHe4YtUi2Vy+0k/K+mKuVVcFRtnZu2PTLnVb5nKqgOSM/vECMW2zFeccXWzjyVJ
	 NIJ92/wiVAieQpRFDoHYOEsdMRpaRYaoMq7h6pSAfJZ6IsKF2cCi5gANUOuf/I8daQ
	 12fUK2uvsvFAWhaSq5CndYvZB9JGNkKgv87D7bV/kcBW5pLKBGw4SgUxhffYUVvvOK
	 ddHK2F3mo7IieXteMz42VIi9cYovkrwaAWaJYN4oO23TauOZgpb86KPJFjpYBgNENL
	 faDa1+6uQCfNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B172740576;
	Mon, 12 Oct 2026 16:23:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 77B29380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E8AC40201
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6_aI9Jdsj_ui for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:23:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BABCA400D7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:b8b8::42ab"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791822233;
 b=MaYps44Kn2AYMq4sCVEpX2900dOHx0Rq4B+klUr1lGtTCYpMBN5NDiCINsRNc1rsSqd7
 wDpUC9PQL6IOsJY/7xjjQuwbnlKfdMl8zpALr/LYhFh/Z2jCbZqZ8CJAQEtr/1EZVBc3N
 GzSZaB+zwSb3Pt2Z4ttQ4OBN+WTRFzVDETWPFAACRaTFeoX9Ibee3EsPMXUKZDdBS3Gka
 zFNZ2kiMXLHaXfUuivGDi+XCLvHGQIcIxL3lli+XB6BPRb1qTMKh8dhuVOH9jp0/jgbJZ
 oe07MCy2/ScX7/xbPRXwPJXh7N9hgPMghMh3vryqRBBZUd6+HpQgN0SfTXxD5olCMlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791822233;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=uP623c34yldOwQvBR4xBBTl5FyDqB/5fi+jcNCIdEZw=;
 b=LTQq8KA9nf9qdnOU300FaRfWVBRF2ZLMzESFSwTvL64nsyfzHHURCbUrFk1vWRj+X0nl
 2lQqAMSXNxfJ6cI3u0vR3M0OfjqNklvF4YWcaSWh1XmL1FsJmHA+5Qo+abgpVIOI3UBLJ
 6xVNBLY/whegYdoDER8YPh86bJGYvyaySV5FgbB2z47+r/cK3AmSevrprY1WFlQ6B5y8H
 IB9f1L2CGDYGBtn/MngV6Z3SvpFNS6P755YAl4xhpPvvHTuE1Zy+ClJy+40uWHSjXXU8N
 S8x/FhzQx8RLcJXlJtoW53VzWsMtwsURT37yNoQBuX6i85wnS/bfz7aQG5lwhsumT5g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Q2if+2EP; 
 arc=none smtp.remote-ip="2001:1600:19:b8b8::42ab"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::42ab; helo=smtp-42ab.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Q2if+2EP
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::42ab])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BABCA400D7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:23:52 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3N7n5hk2zZYn;
 Mon, 12 Oct 2026 18:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791822229;
 bh=uP623c34yldOwQvBR4xBBTl5FyDqB/5fi+jcNCIdEZw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Q2if+2EPtUC0kP6wCu7ojS6B0UI1AVxBw2gOPzqK+8tBWuM6PCuHU7BJVTe9C6APc
 /b4wuFNG6rDGAKMsUPT8YuQgi/VuobqXjqtj60VERTCFTJePQTNhPcbGmnBupKfwWu
 bDeJKvDCQoc3e0f2qXu0CHXxLoDjIIv/m56wN1K9AokbgkIXI8vukZNUxWeYGfXJca
 doUf5ohG5AfEI8Oq812VW2O7BdTlcQDgVGKQtz+vs3M20Bk9QBB3kfG3KBdf7NFmMJ
 iHMEI7cAvp6aA7HiYw4UmG1BSTfbt8GVkaCn7O9fOc0Yntzx+FZ/G/0hVYscopXjSM
 ba6HxzOeWaE1A==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j3N7m5mbHzpZM; Mon, 12 Oct 2026 18:23:48 +0200 (CEST)
Message-ID: <dbfc0f85-c1c5-4085-ad1a-0460cea5617a@0leil.net>
Date: Mon, 12 Oct 2026 18:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] rockchip: rk3568: Use fixed CRU and PMU CRU base
 addresses
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-4-jonas@kwiboo.se>
 <6729005a-3875-4854-b6e6-54d64d5bc454@0leil.net>
 <f9bf319a-946e-422b-96d0-9f0d2fe14615@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <f9bf319a-946e-422b-96d0-9f0d2fe14615@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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



On 10/11/26 12:43 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/9/2026 10:35 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>>> The rockchip_get_cru() helper is used by the sysreset_rockchip to get
>>> the SoC specific CRU base address, and the rockchip_get_pmucru() helper
>>> is only used by the RK3399 specific RAM driver. These helpers may
>>> trigger a full clock driver probe to get the fixed CRU base address from
>>> the clock driver private data, something that can take several ms.
>>>
>>> Change to return the fixed RK3568 specific CRU or PMU CRU base address
>>> directly to simplify and remove the unneeded complexity of using runtime
>>> lookup in SoC specific code.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    .../include/asm/arch-rockchip/cru_rk3568.h    |  5 +--
>>>    arch/arm/mach-rockchip/rk3568/clk_rk3568.c    | 33 ++-----------------
>>>    2 files changed, 5 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
>>> index d72f241d0150..e2dc3cda5577 100644
>>> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
>>> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
>>> @@ -35,7 +35,6 @@ struct rk3568_clk_info {
>>>    	bool is_cru;
>>>    };
>>>    
>>> -/* Private data for the clock driver - used by rockchip_get_cru() */
>>>    struct rk3568_pmuclk_priv {
>>>    	struct rk3568_pmucru *pmucru;
>>>    	ulong ppll_hz;
>>> @@ -120,8 +119,10 @@ struct pll_rate_table {
>>>    	unsigned int frac;
>>>    };
>>>    
>>> -#define RK3568_PMU_MODE			0x80
>>> +#define RK3568_PMU_CRU_BASE		0xfdd00000
>>>    #define RK3568_PMU_PLL_CON(x)		((x) * 0x4)
>>> +#define RK3568_PMU_MODE			0x80
>>> +#define RK3568_CRU_BASE			0xfdd20000
>>>    #define RK3568_PLL_CON(x)		((x) * 0x4)
>>>    #define RK3568_MODE_CON			0xc0
>>>    
>>> diff --git a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
>>> index 1c6b2ece602b..ccd98a91cd16 100644
>>> --- a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
>>> +++ b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
>>> @@ -4,10 +4,7 @@
>>>     */
>>>    
>>>    #include <dm.h>
>>> -#include <syscon.h>
>>> -#include <asm/arch-rockchip/clock.h>
>>>    #include <asm/arch-rockchip/cru_rk3568.h>
>>> -#include <linux/err.h>
>>>    
>>>    int rockchip_get_clk(struct udevice **devp)
>>>    {
>>
>> There's no user of that function anymore after this patch, so just
>> squash the patch removing it later in this series with this patch here.
> 
> This function is technically a public function declared in
> asm/arch-rockchip/clock.h. Removing it in same patch that refactors to
> use a constant seem like it would go against your normal stand on not
> doing two different things in one patch, and a reason why it was split
> to begin with ;-)
> 

Oh well, it was clear in my head this was a case of "it obviously must 
be together" but now that you put it into words, I can see an argument 
for it. I guess you could say the same for the last driver of a 
subsystem, you likely will remove the driver separately from the 
subsystem. Eh, pick for yourself for v2 what you want to do, it's not 
too important :) This reminds me I probably should start using 
Conventional Comments (https://conventionalcomments.org/) to make it 
clear what is required to changed/nice-to-haves (obviously, something 
marked as an issue/blocker can always be discussed and argued against :) ).

Cheers,
Quentin
