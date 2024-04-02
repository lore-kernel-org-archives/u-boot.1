Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045B3CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 759ED87F50;
	Tue,  2 Apr 2024 15:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UAn/yCZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9C787FAC; Tue,  2 Apr 2024 15:00:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E559787EB4
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d8ab=LI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712062821;
 bh=x/8EQH4NGowAutMFO746teNGWTB4nCfENeGI6cYfpuw=;
 b=UAn/yCZCpJD5jrUC/2OnMOkJkr9Juj8kaPyxXwEjjqWNrDUQI7JF5p6u7NBLwQMZH05lszgwB
 PImCMV9ZNb8KECEFucfPnQESz6+YpDkcOvY7p/0+X7AqaTPdeEFsFCTAVsLgB9I6NFdnsHlW5p7
 vW89X1bq5MRp+iVcMTqcd9KbB+xKIO0zHjmqbiG339Lz4AI/ENmNbLGkLdMNmqG+UAeSRl2LZOd
 afA/QfPMUR3yiicN3bHETQ3/CaLcnjTGE8CiXL58VUBrRw/bGi/hf64AU/doEqcLqwPh1ml5Sc5
 K52p55oJfS6HVez6MK3vPKBPIFhPmjlWnlD1XhF/hsGw==
Message-ID: <2113e684-09db-4145-afb8-c1166366a30f@kwiboo.se>
Date: Tue, 2 Apr 2024 14:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/19] rockchip: rk35xx: Imply support for GbE PHY
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-9-jonas@kwiboo.se>
 <d210412c-ec9d-480b-ac0a-da7976490f78@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d210412c-ec9d-480b-ac0a-da7976490f78@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 660bfffd2c47d571a6f1271b
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

On 2024-04-02 13:11, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/29/24 20:01, Jonas Karlman wrote:
>> Imply support for GbE PHY status parsing and configuration when support
>> for onboard ethernet is enabled.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/Kconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>> index d518913f8a37..d85b59a92da2 100644
>> --- a/arch/arm/mach-rockchip/Kconfig
>> +++ b/arch/arm/mach-rockchip/Kconfig
>> @@ -316,6 +316,7 @@ config ROCKCHIP_RK3568
>>   	imply MISC_INIT_R
>>   	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>>   	imply OF_LIBFDT_OVERLAY
>> +	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
> 
> Is this really something we expect most devices to use?
> 
> We have two products based on RK3588, none use it. If I'm not mistaken, 
> Rock5B doesn't as well as Orange Pi 5 Plus, RK3588 EVB, Rock5A, (likely 
> not the Edgeble as well since they have 2.5Gbps connectors), NanoPC T6, 
> IndieDroid Nova, Cool Pi 4B, Cool Pi CM5 EVB, NanoPi R6S, Rockchip 
> Toybrick TB-RK3588X.
> 
> So, I'm not sure it's worth it making it the default? (Even though we 
> could remove it from the defconfig manually). Wouldn't this make more 
> sense in your generic defconfigs?

The PHY_GIGE option is only used to control if miiphy_speed() and
miiphy_duplex() should use MII_STAT1000 reg to determine speed/duplex.

This patch only imply this option if a board use on-board gmac and have
DWC_ETH_QOS_ROCKCHIP enabled.

Mostly this only help the "mii info" command to show 1000baseT instead
of max 100baseT.

I can drop this if you think it will cause an issue for any board?

Regards,
Jonas

> 
> Cheers,
> Quentin

