Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC02C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398CB83013;
	Tue, 15 Jul 2025 12:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xSl8kf6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9148307F; Tue, 15 Jul 2025 12:22:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC8682FCA
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752574972;
 bh=uV+QFIo1F98sVHSeendF1CYFefssPCgoM02bLcPYWWA=;
 b=xSl8kf6QaIXMqTlUIhhONjPm7jGvjDjiwhyE2FBtiKRZMcuK1UDRwo85Ao99UF3mhvA2m0qPa
 twTnHibHEzmronvstBk38vz34HPDN4S9BhIKxT4n0mJpHNS+4RECe0x3gDfQ9LRKBWfBS0WOe7s
 fpsfCw8TTZRjA0CIyBBGI1raHiNScePcWmu8DG/jFxY++LEd14LMZmUkFggy3u88UPyvzqYHA4X
 YLTRsc+5g267Z3GW9gBLMH77D61N/KA/gUpQy3i/p8cag51er7R7QAOinaWfsVpJGrSYLWdnm2M
 eDYNF/IEUb/TzIRuhOkrE7GkpSXuPL0q5DK5XQbYYurA==
X-Forward-Email-ID: 68762bf602da433925ac7ea1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <17927728-3ac7-40b9-b085-1fb8a6f15beb@kwiboo.se>
Date: Tue, 15 Jul 2025 12:22:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] rockchip: odroid-go2: Remove cru assigned-clocks
 override
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-3-jonas@kwiboo.se>
 <7f502029-21de-45e3-a9da-4c681af0affc@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7f502029-21de-45e3-a9da-4c681af0affc@cherry.de>
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

Hi Quentin,

On 7/15/2025 11:19 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/14/25 1:33 AM, Jonas Karlman wrote:
>> Remove the cru assigned-clocks override now that SCLK_GPU is supported
>> by the clock driver.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> And this seems like we can remove
> 
> /delete-property/ assigned-clocks;
> /delete-property/ assigned-clock-rates;
> 
> from cru and pmucru from arch/arm/dts/px30-u-boot.dtsi?

Yes, I think so too, but I do not have any PX30 device only a single
RK3326 device, so I try to be very cautious when it comes to PX30.

> 
> And... maybe we can eventually make 
> arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi include 
> arch/arm/dts/px30-u-boot.dtsi to avoid duplication and match what the 
> upstream DT does (including rk3326.dtsi which includes px30.dtsi and 
> deletes VOPL)?

Yes, I think so too, in a future series, in this series I tried to be
very cautious to ensure that only odroid-go2 was affected.

This series mostly started out with me wanting to test your checkboard()
patch and then it evolved into something more :-).

Regards,
Jonas

> 
> Cheers,
> Quentin

