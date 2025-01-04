Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D72E77198
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E03F8034E;
	Sat,  4 Jan 2025 04:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B9058035E; Sat,  4 Jan 2025 04:05:23 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC00480207
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown
 [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id DC3E2B22FA28;
 Sat,  4 Jan 2025 04:05:19 +0100 (CET)
Message-ID: <e3b4fe98-fce5-45e0-970d-d0398e23838d@freeshell.de>
Date: Fri, 3 Jan 2025 19:05:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LwIP and multiple network interfaces
From: E Shattow <e@freeshell.de>
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <de7bf6b3-fd45-4c8f-a492-bd41db2aa904@freeshell.de>
 <20250102224724.GS3476@bill-the-cat>
 <aa6d5dce-473c-447f-91b9-fe802f0f520d@freeshell.de>
 <20250103014049.GT3476@bill-the-cat>
 <14a9901e-00fd-4a5e-aeb1-ffbe715f8965@freeshell.de>
 <7c20233b-d61a-4114-bbb3-6866bdd5bbf5@linaro.org>
 <69678189-22b5-4372-83a4-0e4637975355@freeshell.de>
Content-Language: en-US
In-Reply-To: <69678189-22b5-4372-83a4-0e4637975355@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/3/25 09:58, E Shattow wrote:
> 
> 
> On 1/3/25 02:03, Jerome Forissier wrote:
>>
>>
>> On 1/3/25 02:52, E Shattow wrote:
>>>
>>>
>>> On 1/2/25 17:40, Tom Rini wrote:
>>>> On Thu, Jan 02, 2025 at 05:34:57PM -0800, E Shattow wrote:
>>>>
>>>>> Tom sorry about sending this reply twice, struggle here is with 
>>>>> Thunderbird
>>>>> mail UI sometimes hiding "Reply All" and it missed the mail list 
>>>>> first time
>>>>> around.
>>>>
>>>> No problem.
>>>>
>>>>> On 1/2/25 14:47, Tom Rini wrote:
>>>>>> On Thu, Jan 02, 2025 at 02:26:06PM -0800, E Shattow wrote:
>>>>>>> Problem: 'dhcp' must be ran twice when the network cable is 
>>>>>>> plugged into a
>>>>>>> port other than the first network port.
>>>>>>>
>>>>>>> Network cable plugged into bottom (first) Ethernet port:
>>>>>>> 1. Power on
>>>>>>> 2. StarFive # dhcp
>>>>>>>
>>>>>>> ethernet@16030000 Waiting for PHY auto negotiation to 
>>>>>>> complete....... done
>>>>>>> DHCP client bound to address 192.168.2.51 (3678 ms)
>>>>>>>
>>>>>>>
>>>>>>> Network cable plugged into top (second) Ethernet port:
>>>>>>> 1. Power on
>>>>>>> 2. StarFive # dhcp
>>>>>>> ethernet@16030000 Waiting for PHY auto negotiation to 
>>>>>>> complete.........
>>>>>>> TIMEOUT !
>>>>>>> phy_startup() failed: -110
>>>>>>> FAILED: -110
>>>>>>> ethernet@16040000 Waiting for PHY auto negotiation to 
>>>>>>> complete...... done
>>>>>>> ethernet@16030000 Waiting for PHY auto negotiation to 
>>>>>>> complete.........
>>>>>>> TIMEOUT !
>>>>>>> phy_startup() failed: -110
>>>>>>> FAILED: -110
>>>>>>> Could not start ethernet@16030000
>>>>>>> 3. StarFive # dhcp
>>>>>>> DHCP client bound to address 192.168.2.77 (31 ms)
>>>>>>
>>>>>> What happens when you set ethact to 1 first?
>>>>>>
>>>>>
>>>>>
>>>>> '1' literal does not seem to do something so I guess it is meant 
>>>>> the id of
>>>>> the first ethernet interface:
>>>>
>>>> Yes, I misspoke sorry.
>>>>
>>>>>   From power-on:
>>>>>
>>>>> ...
>>>>> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
>>>>> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
>>>>> In:    serial@10000000
>>>>> Out:   serial@10000000
>>>>> Err:   serial@10000000
>>>>> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
>>>>> starting USB...
>>>>> No USB controllers found
>>>>> Working FDT set to ff700a10
>>>>> StarFive # env print ethact
>>>>> ## Error: "ethact" not defined
>>>>> StarFive # env set ethact 1
>>>>> StarFive # dhcp
>>>>> ethernet@16030000 Waiting for PHY auto negotiation to 
>>>>> complete.........
>>>>> TIMEOUT !
>>>>> phy_startup() failed: -110
>>>>> FAILED: -110
>>>>> ethernet@16040000 Waiting for PHY auto negotiation to 
>>>>> complete...... done
>>>>> EQOS_DMA_MODE_SWR stuck
>>>>> FAILED: -110
>>>>> Could not start ethernet@16030000
>>>>>
>>>>> Again, from power-on:
>>>>>
>>>>> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
>>>>> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
>>>>> In:    serial@10000000
>>>>> Out:   serial@10000000
>>>>> Err:   serial@10000000
>>>>> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
>>>>> starting USB...
>>>>> No USB controllers found
>>>>> Working FDT set to ff700a10
>>>>> StarFive # env print ethact
>>>>> ## Error: "ethact" not defined
>>>>> StarFive # env set ethact ethernet@16040000
>>>>> StarFive # dhcp
>>>>> ethernet@16040000 Waiting for PHY auto negotiation to 
>>>>> complete...... done
>>>>> DHCP client bound to address 192.168.2.77 (149 ms)
>>>>
>>>> So then yes, the second interface works when ethact is set to use that
>>>> directly. This is the same behavior as the legacy stack I believe.
>>>>
>>>
>>> Legacy stack does actually rotate and complete successfully when 
>>> ethact environment variable does not exist and (eventually) configure 
>>> the second interface though. Here with LwIP the procedure fails.
>>>
>>> Notice that here it starts with ethernet@16030000, then rotates to 
>>> ethernet@16040000 unsuccessfully, and back again to ethernet@16030000 
>>> before (again) failing and giving up. There is a network cable 
>>> plugged into 'ethernet@16040000' port and if we try the command again 
>>> the environment variable ethact retained 'ethact=ethernet@16040000' 
>>> from the failed procedure so you're right it works as it should... 
>>> except that it totally failed to do what was expected the first time.
>>
>> That's unexpected indeed.
>>
>>> Is this exposing a problem with this board network driver and 
>>> behavior or is it something with LwIP ?
>> Hard to tell at this point. One thing I know for sure is that lwIP 
>> expects
>> eth_set_current() (called from do_dhcp()) to actually pick a valid
>> interface if there is one. So it should definitely select 
>> ethernet@16040000
>> in your scenario. Adding debug prints to eth_set_current(),
>> eth_current_changed() etc. should help.
>>
>> Thanks,
> 
> StarFive # dhcp
> !!! eth_set_current(): entered function
> !!! eth_set_current(): conditional 1
> !!! eth_set_current(): conditional 2
> !!! eth_set_current(): conditional 5
> !!! eth_current_changed(): entered function
> !!! eth_current_changed(): conditional 2
> !!! eth_current_changed(): conditional 3
> !!! eth_current_changed(): leaving function
> !!! eth_set_current(): leaving function
> ethernet@16030000 Waiting for PHY auto negotiation to complete......... 
> TIMEOUT !
> phy_startup() failed: -110
> FAILED: -110
> !!! eth_current_changed(): entered function
> !!! eth_current_changed(): conditional 2
> !!! eth_current_changed(): conditional 3
> !!! eth_current_changed(): leaving function
> ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
> ethernet@16030000 Waiting for PHY auto negotiation to complete......... 
> TIMEOUT !
> phy_startup() failed: -110
> FAILED: -110
> Could not start ethernet@16030000
> StarFive #
> 
> For reference the modified functions:
> 
> void eth_current_changed(void)
> {
>          char *act = env_get("ethact");
>          char *ethrotate;
> 
> printf("!!! eth_current_changed(): entered function\n");
>          /*
>           * The call to eth_get_dev() below has a side effect of rotating
>           * ethernet device if uc_priv->current == NULL. This is not what
>           * we want when 'ethrotate' variable is 'no'.
>           */
>          ethrotate = env_get("ethrotate");
>          if ((ethrotate != NULL) && (strcmp(ethrotate, "no") == 0))
>          {
> printf("!!! eth_current_changed(): conditional 1\n");
>                  return;
>          }
> 
>          /* update current ethernet name */
>          if (eth_get_dev()) {
> printf("!!! eth_current_changed(): conditional 2\n");
>                  if (act == NULL || strcmp(act, eth_get_name()) != 0)
>                  {
> printf("!!! eth_current_changed(): conditional 3\n");
>                          env_set("ethact", eth_get_name());
>                  }
>          }
>          /*
>           * remove the variable completely if there is no active
>           * interface
>           */
>          else if (act != NULL)
>          {
> printf("!!! eth_current_changed(): conditional 4\n");
>                  env_set("ethact", NULL);
>          }
> printf("!!! eth_current_changed(): leaving function\n");
> }
> 
> void eth_set_current(void)
> {
>          static char *act;
>          static int  env_changed_id;
>          int     env_id;
> 
> printf("!!! eth_set_current(): entered function\n");
>          env_id = env_get_id();
>          if ((act == NULL) || (env_changed_id != env_id)) {
> printf("!!! eth_set_current(): conditional 1\n");
>                  act = env_get("ethact");
>                  env_changed_id = env_id;
>          }
> 
>          if (act == NULL) {
> printf("!!! eth_set_current(): conditional 2\n");
>                  char *ethprime = env_get("ethprime");
>                  void *dev = NULL;
> 
>                  if (ethprime)
>                  {
> printf("!!! eth_set_current(): conditional 3\n");
>                          dev = eth_get_dev_by_name(ethprime);
>                  }
>                  if (dev)
>                  {
> printf("!!! eth_set_current(): conditional 4\n");
>                          eth_set_dev(dev);
>                  }
>                  else
>                  {
> printf("!!! eth_set_current(): conditional 5\n");
>                          eth_set_dev(NULL);
>                  }
>          } else {
> printf("!!! eth_set_current(): conditional 6\n");
>                  eth_set_dev(eth_get_dev_by_name(act));
>          }
> 
>          eth_current_changed();
> printf("!!! eth_set_current(): leaving function\n");
> }
> 
> Hopefully this is enough to make sense of it? Let me know, thanks!
> 
> -E

Postscript I've narrowed it down a bit to 
net/lwip/net-lwip.c:new_netif() where returning from eth_init() the 
eth_get_dev() is the second interface (with network cable plugged in) 
but variable reference udev is still the first interface (with no 
network cable) when the call to lwip_init() is made. So lwip_init() 
tries and fails on the first interface even though we already know from 
eth_init() which interface is valid and ready.

So that is what is happening but I don't know what you would want to do 
to fix this?

-E
