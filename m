Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71CECCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 11:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C96D82B20;
	Wed, 22 Oct 2025 13:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AF7832BC; Wed, 22 Oct 2025 13:26:36 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 269B280422
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 13:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.240])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0B57BB2208B2;
 Wed, 22 Oct 2025 13:26:31 +0200 (CEST)
Message-ID: <0c3cca71-8af3-46a0-9c7d-957127ea7378@freeshell.de>
Date: Wed, 22 Oct 2025 04:26:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] riscv: dts: starfive: jh7110-common: Move out some
 nodes to the board dts
To: Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-2-hal.feng@starfivetech.com>
 <f8ed3792-70ca-498f-9ce7-65040860db07@canonical.com>
 <01a5ff2b-bc20-4670-93ce-2b66df408b96@freeshell.de>
 <ZQ2PR01MB13075C0C6A214EC48174F248E6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB13075C0C6A214EC48174F248E6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
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



On 10/22/25 02:59, Hal Feng wrote:
>> On 03.09.25 00:18, E Shattow wrote:
>>
>> Hello Hal, and Heinrich,
>>
>> On 8/29/25 00:19, Heinrich Schuchardt wrote:
>>> On 29.08.25 08:09, Hal Feng wrote:
>>>> Some node in this file are not used by the upcoming VisionFive 2 Lite
>>>> board. Move them to the board dts to prepare for adding the new
>>>> VisionFive 2 Lite device tree.
>>>>
>>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>>
>>> LGTM
>>>
>>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>
>>
>> NAK
> 
> Please ignore patch 1 and patch 2.
> 
>>
>> Better to drop jh7110-common-u-boot.dtsi from U-Boot [1]. Also we can drop
>> jh7110-u-boot.dtsi file but that does require some additional work:
>>
>> - upstream dt-binding memory-controllers/starfive,jh7110-dmc.yaml [2]
>> - upstream devicetree changes adding memory controller [3]
>> - upstream bootph-pre-ram hints [4]
>> - implement cpufreq driver
> 
> Why do we need the cpufreq driver in u-boot? You want the u-boot to run at the
> highest frequency?
> I think it is more stable to keep the u-boot running at 1GHz with lower power
> consumption.
> 

The OPP tables are now from upstream Linux so it needs to be done. What
for higher frequency and voltage or lower frequency and voltage, that
should be determined by upstream dts not our override.

>> - refactor drivers/ram/starfive/starfive_ddr.c to use common clock framework
>> and delete 'clock-frequency = <2133>' in dts
> 
> 2133 is the DDR data rate to set. We can not get this frequency using common
> clock framework.
> 
> Best regards,
> Hal
> 

"2133" is a wrong value to have in devicetree for this property, and
this was rejected by Linux Kernel upstream:

https://lore.kernel.org/lkml/2e53fc11-49eb-420c-ab8e-57e9493c42ba@kernel.org/

Krzysztof says there "Drop clock-frequency. I doubt 2133 Hz is even
correct... This is a legacy property, use common clock framework."

>>
>> I am not interested in writing U-Boot drivers. Hal, can you make the needed
>> improvements in U-Boot for cpufreq and memory controller drivers?
>>
>> 1: https://lore.kernel.org/u-boot/20250815050315.62956-1-e@freeshell.de/
>> 2: https://lore.kernel.org/lkml/20250823100159.203925-2-e@freeshell.de/
>> 3: https://lore.kernel.org/lkml/20250823100159.203925-3-e@freeshell.de/
>> 4: https://lore.kernel.org/lkml/20250823100159.203925-4-e@freeshell.de/
> 

Thanks,

-E
