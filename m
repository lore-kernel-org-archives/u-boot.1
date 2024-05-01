Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBECC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 11:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF0488AB5;
	Wed,  1 May 2024 13:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="M2kI8O33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF9288AB8; Wed,  1 May 2024 13:59:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFE788AAF
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 13:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714564736;
 bh=lfUBWBag8wog2QUfr/rX8wyHwWzdx1qnYcr+x9sHj+s=;
 b=M2kI8O33dsq0Zwzzvb18BJVOhTLdIiScQG81EaFwtCbL64AKaQ29vEeWFrJRLR4dxGNiJ7kz/
 al+plvIGjSRgz2E3bS4vtJiPLjH/GPzuvs+eZfJsIKNDGzleTWqW4HzU1lvWmwgBqFRkDNupPKL
 kEOa3kreiKw20XoYp/nkof790wSag4T90ZMZecMAIIOoK4kjZBDD70LBli8Q7ddINkgBkjpx77b
 rEmDmeKICUQyipVKHy4IUObq/DZIiPMyX9Lm1h1MO/FFOCYw7AHGl607Dl++aLoIWftBBMZO8ST
 PR5IQtKkIeRCnvhYSjLg/UOh2BlYzwv0LSyasGId2tHA==
Message-ID: <47d6e59e-82e6-42b0-aba2-33d04d7a0dae@kwiboo.se>
Date: Wed, 1 May 2024 13:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/31] clk: rockchip: rk3399: Add dummy support for
 SCLK_PCIEPHY_REF clock
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-14-jonas@kwiboo.se>
 <e8868088-3862-4110-8aad-081babde9855@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e8868088-3862-4110-8aad-081babde9855@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66322e7f8353c369f638c084
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

Hi Quentin,

On 2024-04-02 16:44, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/31/24 22:28, Jonas Karlman wrote:
>> rk3399-nanopi-4.dtsi try to set parent of and set rate to 100 MHz of the
>> SCLK_PCIEPHY_REF clock.
>>
>> The existing enable/disable ops for SCLK_PCIEPHY_REF already handles
>> setting correct parent once the clock gets enabled. And 100 MHz is the
>> default rate used for this clock.
>>
> 
> I'm not sure that's true?
> 
> If I read the TRM correctly, clk_pciephy_ref_sel can come either from 
> clk_pcie_ref24m (the default) or clk_pcie_ref100m.
> 
> enable/disable is actually only ever writing 0 to that bit (bit 10 in 
> CRU_CLKSEL_CON18) and not even enabling the clock.

You are correct, I should have looked closer at the code :-)

> 
> Assuming clk_pcie_ref24m is the 24MHz base clock (which seems to be the 
> case according to the Linux kernel CRU driver), there shouldn't be a way 
> to disable that clock. However, if clk_pcie_ref100m is selected, one 
> needs to enable/disable it via CRU_CLKGATE_CON12 bit 6 (enabled by default).
> 
> set_parent should be properly implemented to handle this parenting and 
> enable/disable fixed to use the proper register.

For v2 I have added improved support for enable/disable, setting parent
and rate of the pciephy refclk, it is not a full implementation but
should support the state of updated device tree files.

I have not been able to runtime test on a nanopi-4 based board yet, but
will include the updated version in v2, it does not seem to affect any
of my other boards not setting parent/rate.

Regards,
Jonas

> 
> Cheers,
> Quentin

