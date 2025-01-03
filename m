Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D38DE77198
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 01:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63333802EF;
	Fri,  3 Jan 2025 02:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07BF48031D; Fri,  3 Jan 2025 02:35:02 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52FD80196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 02:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown
 [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8C4A8B4B3C87;
 Fri,  3 Jan 2025 02:34:58 +0100 (CET)
Message-ID: <aa6d5dce-473c-447f-91b9-fe802f0f520d@freeshell.de>
Date: Thu, 2 Jan 2025 17:34:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LwIP and multiple network interfaces
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <de7bf6b3-fd45-4c8f-a492-bd41db2aa904@freeshell.de>
 <20250102224724.GS3476@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250102224724.GS3476@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Tom sorry about sending this reply twice, struggle here is with 
Thunderbird mail UI sometimes hiding "Reply All" and it missed the mail 
list first time around.

On 1/2/25 14:47, Tom Rini wrote:
> On Thu, Jan 02, 2025 at 02:26:06PM -0800, E Shattow wrote:
>> Problem: 'dhcp' must be ran twice when the network cable is plugged into a
>> port other than the first network port.
>>
>> Network cable plugged into bottom (first) Ethernet port:
>> 1. Power on
>> 2. StarFive # dhcp
>>
>> ethernet@16030000 Waiting for PHY auto negotiation to complete....... done
>> DHCP client bound to address 192.168.2.51 (3678 ms)
>>
>>
>> Network cable plugged into top (second) Ethernet port:
>> 1. Power on
>> 2. StarFive # dhcp
>> ethernet@16030000 Waiting for PHY auto negotiation to complete.........
>> TIMEOUT !
>> phy_startup() failed: -110
>> FAILED: -110
>> ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
>> ethernet@16030000 Waiting for PHY auto negotiation to complete.........
>> TIMEOUT !
>> phy_startup() failed: -110
>> FAILED: -110
>> Could not start ethernet@16030000
>> 3. StarFive # dhcp
>> DHCP client bound to address 192.168.2.77 (31 ms)
> 
> What happens when you set ethact to 1 first?
> 


'1' literal does not seem to do something so I guess it is meant the id 
of the first ethernet interface:

 From power-on:

...
starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
starting USB...
No USB controllers found
Working FDT set to ff700a10
StarFive # env print ethact
## Error: "ethact" not defined
StarFive # env set ethact 1
StarFive # dhcp
ethernet@16030000 Waiting for PHY auto negotiation to complete......... 
TIMEOUT !
phy_startup() failed: -110
FAILED: -110
ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
EQOS_DMA_MODE_SWR stuck
FAILED: -110
Could not start ethernet@16030000

Again, from power-on:

starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
starting USB...
No USB controllers found
Working FDT set to ff700a10
StarFive # env print ethact
## Error: "ethact" not defined
StarFive # env set ethact ethernet@16040000
StarFive # dhcp
ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
DHCP client bound to address 192.168.2.77 (149 ms)


-E
