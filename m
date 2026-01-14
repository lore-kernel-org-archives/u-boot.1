Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79D3D38FFF
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 17:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421F7803F5;
	Wed, 14 Jan 2026 18:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wdV5tUwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0997C80433; Wed, 14 Jan 2026 18:27:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9060980325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 18:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=eb2b=7U=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768411656;
 bh=FUQefvee7qfFHbwVfUjbcSsfUXPKImX3LunnLpTNmwU=;
 b=wdV5tUwX2OjEGVHKdGklsottCKiUBBQtuVFPMxpnrPkj/U1cK0SA4ZgW1LAByu2qB+UFiSteh
 HnqEe8vuSPzXT0c0y5nTknV6/1AohfZEmInbVEU5NktyrKCQ7x7OELGjPDRPhyO+NHUbm0q/1aO
 TVStVPk0Q8eEodHxFW5QokfK2q09kzPFdlVP5evCfNsNRCb8ejhGA+JOZpu/3FZFoWMazovdVbD
 THYGwLFE2vUcIny7/LSaDBkniobUPO5e4shheXUzqmf09IqYH71/jcdgJLRTw7ZshukYzTf4BXQ
 az9QwJyt8W9IXeIC4+leStXoYDz08hVS+LU76SZob4yQ==
X-Forward-Email-ID: 6967d1fff65b9ac90aad3e6b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <353ab2a2-f866-4f52-a355-e6641588848b@kwiboo.se>
Date: Wed, 14 Jan 2026 18:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3576: Allow pmu sram access for
 non-secure masters
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de
References: <20260108133234.4001390-1-jonas@kwiboo.se>
 <20260108133234.4001390-2-jonas@kwiboo.se>
 <fcb352fc-5fe1-4443-8c3a-153c182d6774@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <fcb352fc-5fe1-4443-8c3a-153c182d6774@cherry.de>
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

On 1/14/2026 5:27 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/8/26 2:32 PM, Jonas Karlman wrote:
>> The firewall block access to pmu sram for non-secure masters by default
>> after reset (0xffffbfff).
>>
>> Change the pmu lookup configuration to match the default lookup config
>> for ddr and system sram (0xffff3fff) to allow loading TF-A using DMA.
>>
> 
> What is this "default" lookup config and where does it come from? You 
> say it's 0xffffbfff after reset and it's set to something different 
> after a TF-A has configured the firewall... Is it after a cold boot? 
> That somehow is different than a warm reset maybe?

0xffffbfff was the value the PMU_SGRF_SLV_LOOKUP0 reg had out of cold
boot, when read out at top of arch_cpu_init() in SPL using ramboot.

As implied by the cover letter any naming and technical details may be
wrong and has only been deduced from firewall.c/h in TF-A source and
printing out below content of a few FW regs.

  SGRF_MST_DOMAIN_CON0: 00000770
  SGRF_MST_DOMAIN_CON1: 00007007
  SGRF_MST_DOMAIN_CON2: 00000007
  SGRF_MST_DOMAIN_CON3: 00000000
  SGRF_MST_DOMAIN_CON4: 00000000
  SGRF_MST_DOMAIN_CON5: 00000700
  SGRF_MST_DOMAIN_CON6: 00007777
  SGRF_MST_DOMAIN_CON7: 00000007

  SGRF_DDR_RGN0: 84000000
  SGRF_DDR_RGN1: 00000000
  [...]
  SGRF_DDR_RGN15: 00000000
  SGRF_DDR_LOOKUP0: ffff3fff
  SGRF_DDR_LOOKUP1: ffffffff
  [...]
  SGRF_DDR_LOOKUP7: ffffffff
  SGRF_DDR_CON: 00010001

  SGRF_SYSMEM_RGN0: 00007f00
  SGRF_SYSMEM_RGN1: 00000000
  SGRF_SYSMEM_RGN2: 00000000
  SGRF_SYSMEM_RGN3: 00000000
  SGRF_SYSMEM_LOOKUP0: ffff3fff
  SGRF_SYSMEM_LOOKUP1: ffffffff
  SGRF_SYSMEM_CON: 00000001

  PMU_SGRF_SLV_LOOKUP0: ffffbfff
  PMU_SGRF_SLV_LOOKUP1: ffffffff
  PMU_SGRF_SLV_LOOKUP2: ffffffff
  PMU_SGRF_SLV_LOOKUP3: ffffffff
  PMU_SGRF_DOMAIN_CON: 00000000

Looking at the above patterns and with some details from TF-A source I
could deduce that PMU_SGRF_SLV_LOOKUP0 possible have something in common
with SGRF_DDR_LOOKUP0 and SGRF_SYSMEM_LOOKUP0 regs, describing what
domains can access DDR and SYSTEM SRAM regions, and after a quick test I
could confirm that changing 'b' (10) to '3' (00) seemed to allow DMA
write access from sdmmc, sdhci and fspi to PMU SRAM.

  Access rights between domains and groups are as follows:

  00: NS access,     S access
  01: NS access,     S not access
  10: NS not access, S access
  11: NS not access, S not access

My deduced guess is that PMU_SGRF_SLV_LOOKUP0[15:14] describe access to
PMU SRAM for domain 7, similar to SGRF_DDR/SYSMEM_LOOKUP0[15:14], and
changing it from only secure access (10) to both non-secure and secure
access (00) allows us to use DMA from the masters re-assign to domain 7.

> 
>> Mainline TF-A will re-configure the firewall to use an even less
>> restrictive lookup (0xbffe3ff0), so this change is not expected to have
> 
> [1][2]
> 
>> any real security implication.
>>
> 
> [1] 
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/rockchip/rk3576/drivers/secure/firewall.c#L522C36-L522C46
> [2] 
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/rockchip/rk3576/drivers/secure/firewall.c#L611-L613
> 
> For the proof :)
> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
>> index a1e8a7572fa4..c17ba418ced5 100644
>> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
>> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
>> @@ -26,6 +26,9 @@
>>   #define SYS_SGRF_SOC_CON15	0x005C
>>   #define SYS_SGRF_SOC_CON20	0x0070
>>   
>> +#define FW_PMU1SGRF_BASE	0x26003000
>> +#define PMU1SGRF_SLV_LOOKUP0	0x80
>> +
> 
> How about using the same names as in TF-A?
> 
> PMU1SGRF_FW_BASE instead of FW_PMU1SGRF_BASE and
> FW_PMU_SGRF_SLV_LOOKUP(x) instead of PMU1SGRF_SLV_LOOKUP0?

I did this at first but that looked funky when a different naming
pattern was already being used for existing FW related defines:

  #define FW_SYS_SGRF_BASE	0x26005000
  #define SGRF_DOMAIN_CON1	0x4

and in TF-A:

  SYS_SGRF_FW_BASE
  FW_SGRF_MST_DOMAIN_CON(i)

So I chose to adopt similar naming as the ones already defined in U-Boot
for consistency.

Regards,
Jonas

> 
> I cannot test this as I don't have an RK3576 board but it looks ok to me.
> 
> Cheers,
> Quentin

