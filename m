Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE40C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 20:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A2184074F;
	Tue,  4 Aug 2026 20:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gx26Bf1CmM9U; Tue,  4 Aug 2026 20:04:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47D4640338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785873867;
	bh=3jr3d1rH/4DEZe0TEpoJmtG2qL3heo4jCXGh0YDu27U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z5WNmBKL6q6bXAUkyCVrj4sKh50YJLq+ljy9NrFWwwZ85A5y0QJ6zdfx/83PEzNck
	 npDw8NB3V+QGvOtWptuitITxrESNxN7zgkMQE39muymCUDIBkZJGc94YGn7CNfgmOx
	 LDMyJV6Vph3OjHSqx5hFSKxUoAo7zoYdFIEv6um7xhuE3FWqSmxG+yS5kZf7S4XM07
	 VZDSJRLV9xUSZFzMRi7qWbHY1DplL+qaWe/b+9rlLXy+xwhgNg6LxlgZErye4iEMvO
	 A55T8ppUlaMDt/+qRR2zjbtpiAavKu6qzaxu2j27TZXhXwuzv3uZVQVgvS7/ReKYRl
	 Tqi5VHEUZv7Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47D4640338;
	Tue,  4 Aug 2026 20:04:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 74A2E296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 20:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66738807C9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 20:04:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lnGonG3Brg0J for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 20:04:25 +0000 (UTC)
X-Greylist: delayed 385 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 04 Aug 2026 20:04:24 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 16F42807C5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16F42807C5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16F42807C5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 20:04:23 +0000 (UTC)
X-Forward-Email-ID: 6a724443e0f9701609ecbfa2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
Date: Tue, 4 Aug 2026 21:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785873863;
 bh=3jr3d1rH/4DEZe0TEpoJmtG2qL3heo4jCXGh0YDu27U=;
 b=sEf15BaUHvyyn7jTfJZ4Rvcdv3yq7eX0/dubL4gD5WjcooAPvQ8WgcE4ovt3PPZQsVdq8JYih
 upbHtFrVhZi8cvXeX7/6MhSgeGm4PZ+/UFQWHHYrvuggdm7TWlHrvG/R8mX0yOvNiiW8qutfOOj
 Ww0RIgQ8Lh6fpOEckMq+3vsnm4LCpNzq2HQW/y257iBfudt24wpDq6+iiq5Dy8VDTsg/zRVzVfn
 ETkEsNGLAQlf+PsbGrNTKH7XIVYA/trnEaOUzOAjBTJAeD5Ib2qyHsbAx2QsIP4tQ7s+O8/Aoq5
 zllDjll59yGfkcD5CSFg2H9WrMsYqYZgYhlwH+CrZIng==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=sEf15BaU
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On 8/4/2026 9:19 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On Tue, 4 Aug 2026 at 04:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> This series takes the initial steps required to try and remove use of
>> syscon_get_first_range() or syscon_get_regmap_by_driver_data() to get
>> GRF base addresses at runtime for the Rockchip platform.
>>
>> The GRF base addresses are fixed and known at compile time, yet drivers
>> keep trying to resolve them at runtime delaying some operations by
>> several ms.
> 
> I suppose all addresses are known at compile-time, if you have a
> single device tree. I have always hoped that we might end up with a
> generic U-Boot for rockchip.

I do not understand how removing these unneeded syscon drivers and
helpers would stop such goals or make that any harder. From my point of
view, they are currently making such things harder and only adds extra
code, runtime and energy waste. E.g. around 227 ms was wasted resolving
fixed known base addresses for RK3399 last time I measured it, see [1].

Most drivers or any SoC specific code is already identified using a
compatible that is SoC specific, i.e. the RAM or CLK drivers are matched
using a SoC specific compatible and seeing how all GRF variants are
unique there will always need to be SoC specific code to handle the GRFs
base address and reg offsets.

And for drivers that are more dynamic in nature the DT typically have a
phandle to the GRF syscon node anyway, so getting it from the phandle
will be a better option and closer matches how Linux handles similar
references.

The biggest current blocker for a more generic U-Boot proper on Rockchip
platform is rockchip_get_cru() and how it currently makes it impossible
to support multiple SoCs in one build due to how it is used in the
sysreset driver. Fortunately, I have a pending series that also cleans
up the unneeded rockchip_get_cru/clk() related helpers.

> 
> I wonder if there is another way to do this, perhaps reading the
> address once and caching it?

I really do not see the need for that; it would only make things more
complex than it really needs to be. We should use constants where
appropriate, e.g. soc specific drivers/code and use generic phandle
lookups elsewhere.

At least that is my end goal with this and pending follow-up series.

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/cfb736dea37f834e849e54d39fb086c91697fc24

Regards,
Jonas

> 
>>
>> In this initial part the three current uses of ROCKCHIP_SYSCON_x lookup
>> used on RK35xx SoCs is converted to use a constant value or using
>> phandle lookup, followed by removing the SoC specific syscon driver and
>> finally removing the RK35xx special ROCKCHIP_SYSCON_x enum values.
>>
>> The changes included in this series have no intended behavior change for
>> the affected RK35xx SoCs.
>>
>> Future series will continue to convert uses of ROCKCHIP_SYSCON_x for
>> remaining older RK SoCs if this initial part is accepted.
>>
>> Jonas Karlman (9):
>>   ram: rockchip: rk3568: Simplify get_info() ops
>>   ram: rockchip: rk3588: Simplify get_info() ops
>>   video: rockchip: dw_mipi_dsi: Get GRF base address from phandle
>>   rockchip: rk3568: Remove unneeded syscon driver
>>   rockchip: rk3588: Remove unneeded syscon driver
>>   rockchip: rk3576: Remove unneeded syscon driver
>>   rockchip: rk3528: Remove unneeded syscon driver
>>   rockchip: rk3506: Remove unneeded syscon driver
>>   rockchip: include: Remove unused ROCKCHIP_SYSCON_x enum values
>>
>>  arch/arm/include/asm/arch-rockchip/clock.h    |  8 -----
>>  arch/arm/mach-rockchip/rk3506/Makefile        |  1 -
>>  arch/arm/mach-rockchip/rk3506/syscon_rk3506.c | 19 ------------
>>  arch/arm/mach-rockchip/rk3528/Makefile        |  1 -
>>  arch/arm/mach-rockchip/rk3528/syscon_rk3528.c | 19 ------------
>>  arch/arm/mach-rockchip/rk3568/Makefile        |  1 -
>>  arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 23 --------------
>>  arch/arm/mach-rockchip/rk3576/Makefile        |  1 -
>>  arch/arm/mach-rockchip/rk3576/syscon_rk3576.c | 22 -------------
>>  arch/arm/mach-rockchip/rk3588/Makefile        |  1 -
>>  arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 31 -------------------
>>  drivers/ram/rockchip/sdram_rk3568.c           | 29 +++--------------
>>  drivers/ram/rockchip/sdram_rk3588.c           | 31 ++++---------------
>>  drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 16 ++++++----
>>  14 files changed, 21 insertions(+), 182 deletions(-)
>>  delete mode 100644 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
>>  delete mode 100644 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
>>  delete mode 100644 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
>>  delete mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
>>  delete mode 100644 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
>>
>> --
>> 2.54.0
>>
> 
> Regards,
> Simon

