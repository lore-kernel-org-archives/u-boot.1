Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDA5C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93B3180F81;
	Thu, 30 Jul 2026 14:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJ4_l9hKHyXP; Thu, 30 Jul 2026 14:35:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C050680F84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785422158;
	bh=qbrC5kGqbIPfrkyP3bLrGHfZ9uD6ouYZbbOBOfJ37vg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N675stvwu2JkW0LLBf5MPKpEuFJXiS8/a8hs4K6lTuf39579QUFQaxd76quHcUMdG
	 vCqGMcod6skQpgjoxC7Jf+ILPjXNPznBN6cEnTC8re5xgKZKuekZSDeks3RFGpPToA
	 WAa6wkfszZ7olNQA03CRXx6cpw+MwN0wovajHU9d/MBAbwn6w1EkppUi9XGoGSIGKN
	 ClA0KzIYA8jmBQ0mUj7OFs0U+GP0WqNwG5s2PybpePDJXO6qT26Er9Nklbmo+e7vAr
	 rUEaJkG47PthyscJKki+/hSynre9g6fIUKA08GeL1fSFFMDYRK/aVX+Tn/KR/KzG9G
	 R/knKToiC8LqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C050680F84;
	Thu, 30 Jul 2026 14:35:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C4CBB69
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1FA380F81
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:35:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bgOCmuR4bAjY for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:35:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 16AF380F80
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16AF380F80
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16AF380F80
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:35:55 +0000 (UTC)
X-Forward-Email-ID: 6a6b6149f46d9b0cb6e89ba3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <62593683-5bb0-4e14-80eb-08239867ee88@kwiboo.se>
Date: Thu, 30 Jul 2026 16:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3576: Disable force_jtag by default
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260730123001.1211166-1-jonas@kwiboo.se>
 <dd4b848e-6007-4299-8889-56f020c7eb80@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <dd4b848e-6007-4299-8889-56f020c7eb80@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785422155;
 bh=qbrC5kGqbIPfrkyP3bLrGHfZ9uD6ouYZbbOBOfJ37vg=;
 b=AEfq9IF7Hxyy+DXAYifvFQg0N1zXx8+PAXTBDgkhGVxnPqof2tjmO1H74X0NVbLPjqS10UDlw
 9N+OPeN8UT85cmeMJr9OKgDZgqxyrQRmgNQ5UlySiHaI8V6QJuWssufSNxnjC/NzCaALtAmdw3o
 irZ1zhIbBxEIELu6vqoUBRtgUivOzPy6dN7rGswmhNGRBMdh54s+t+s+ImFLE5RJQTYyO5bqPcy
 wS6yu8BVSCN72LdU8+brcd7dXgVEYTFa8P2mct0TGDqyOfNEI3iwvJEnVCnu6uuXlfWCdK5ULef
 55hbzf+5YmVdyA/NYaUsvRv8YbGQs48Bgrf/wtUf1mTw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=AEfq9IF7
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

Hi Quentin,

On 7/30/2026 4:17 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/30/26 2:30 PM, Jonas Karlman wrote:
>> Rockchip SoCs can automatically switch between jtag and sdmmc based on
>> the following rules:
>> - all the SDMMC pins including SDMMC_DET set as SDMMC function in GRF,
>> - force_jtag bit in GRF is 1,
>> - SDMMC_DET is low (no card detected),
>>
>> Note that the BootROM may mux all SDMMC pins in their SDMMC function or
>> not, depending on the boot medium that were tried.
>>
>> Because SDMMC_DET pin is not guaranteed to be used as an SD card card
>> detect pin, it could be low at boot or even switch at runtime, which
>> would enable the jtag function and render the SD card unusable.
>>
>> Or boards using cd-gpios may switch the SDMMC_DET pin to GPIO function,
>> which would enable the jtag function and render the SD card unusable.
>>
>> With commit d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1]
>> into dts/upstream") there are now RK3576 boards that have changed to use
>> cd-gpios for the SDMMC_DET pin, e.g. NanoPi R76S, that may have issues
>> detecting SD card unless force_jtag is disabled.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/rk3576/rk3576.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
>> index e3e93f663959..0f41f210a9a5 100644
>> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
>> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
>> @@ -26,6 +26,9 @@
>>   #define SYS_SGRF_SOC_CON15	0x005C
>>   #define SYS_SGRF_SOC_CON20	0x0070
>>   
>> +#define TOP_IOC_BASE		0x26044000
>> +#define IOC_MISC_CON		0x00F0
>> +
>>   #define FW_PMU1SGRF_BASE	0x26003000
>>   #define PMU1SGRF_SLV_LOOKUP0	0x80
>>   
>> @@ -190,6 +193,10 @@ int arch_cpu_init(void)
>>   	 */
>>   	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
>>   
>> +	/* Disable JTAG exposed on SDMMC pins (GPIO2A2 and GPIO2A3) */
>> +	if (IS_ENABLED(CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG))
>> +		writel(0x00020000, TOP_IOC_BASE + IOC_MISC_CON);
>> +
> 
> Please:
> - use a constant (e.g. #define TOP_IOC_FORCE_JTAG BIT(1))
> - use rk_clrreg(TOP_IOC_BASE + IOC_MISC_CON, TOP_IOC_FORCE_JTAG)
> 
> It'd be nice to be consistent here and do the same for other writel all 
> over arch/arm/mach-rockchip/ but that's a different kind of task :)

I know we are inconsistent across multiple SoCs, however in rk3576 we
are exclusivity using writel() so I decided to continue to use writel()
for this change for consistency with surrounding code, and therefore
disagree with your suggested changes :-)

In my opinion mixed used of both writel() and rk_reg() funcs are worse
than a consistent use of writel() within same file and function.

Regards,
Jonas

> 
> With that:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

