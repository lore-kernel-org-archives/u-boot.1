Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA4AD39007
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 18:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FBF803F5;
	Wed, 14 Jan 2026 19:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="z4FM4NHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D69808AF; Wed, 14 Jan 2026 19:29:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F5880325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 19:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=eb2b=7U=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768415370;
 bh=lrYObsoKF0iKe4ipFGOSo0XzHo6wZlPRdMig1mOTak4=;
 b=z4FM4NHfEQUEffrYgd7u6tSR7X8hENzDdj8jpIelvZwsTGpFox71xsLEf3OOZeYlYTCDk+gsE
 XypRpfDtDdsGHgxk0YjdlgUcHADl7ebE1Da5B3iwKPbCyuB/9P7LlS2HnhUwd9fmmu3qOISanJM
 +521zhGcg31jVX3g1KPCSSAv0n4Y1/IZp7yCfyBKdPCTEZK57hGqpMdeeCO9k0UFq5AvfmObyMt
 IAe2+6USFSFOljKHtO2OJG1Isf6OFK2IpTH2w6yPj6ABlYNCNM8ZK/C9fsVF+k6Qt3lKJzHaKIP
 C6FQqtVGR95dIDXcTT5rVz3PWxRdvZjieKwRWhS+ju5Q==
X-Forward-Email-ID: 6967e083f197f6797039bdb8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c9664240-002a-418d-9301-e8307e3e0aea@kwiboo.se>
Date: Wed, 14 Jan 2026 19:29:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: add TFTPSERVERIP Kconfig option
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jerome Forissier <jerome@forissier.org>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260106203433.3133926-1-jonas@kwiboo.se>
 <7d2ac045-d364-4d37-b654-aa704cc07a7b@cherry.de>
 <7f9d6ad3-afd2-4364-8d33-8510e183642c@kwiboo.se>
 <a8a8dd8d-dfc2-4274-9203-a88d9bcb8a69@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a8a8dd8d-dfc2-4274-9203-a88d9bcb8a69@cherry.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Quentin,

On 1/14/2026 6:08 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/14/26 4:37 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 1/14/2026 4:01 PM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 1/6/26 9:34 PM, Jonas Karlman wrote:
>>>> With the legacy networking stack, it is possible to use USE_SERVERIP,
>>>> SERVERIP and BOOTP_PREFER_SERVERIP Kconfg options to force use of a
>>>> specific TFTP server ip.
>>>>
>>>> Using the lwIP networking stack use of the 'tftpserverip' environment
>>>> variable provide the closest equivalent functionality.
>>>>
>>>
>>> It does read serverip environment variable if it's set, so this should
>>> match the behavior with the legacy network stack no?
>>
>> This is what I first thought, however it seem that the lwip stack differ
>> slightly from the legacy stack, in that the dhcp lookup always seem to
>> reset the serverip env var.
>>
>>> As for BOOTP_PREFER_SERVERIP, this would need to be implemented in lwip
>>> and isn't covered by this new variable is it?
>>
>> For the lwip stack it looks like the BOOTP_PREFER_SERVERIP Kconfig
>> option possible was replaced with use of a 'tftpserverip' env var.
>>
>> For legacy stack I had something like following in a .config fragment:
>>
>>    CONFIG_BOOTP_PREFER_SERVERIP=y
>>    CONFIG_SERVERIP="192.168.2.50"
>>    CONFIG_USE_SERVERIP=y
>>
> 
> And this meant the serverip would not be overwritten by the dhcp command 
> for example (in the legacy stack)? When doing PXE/TFTP, I always do
> 
> setenv autoload no; dhcp; setenv serverip X.Y.Z.A; pxe get; pxe boot

I tried to keep it as simple as possible, as I have not used network
boot before, and used something like following:

  env set boot_targets pxe; bootflow scan -lbG

and when I need to use a USB Ethernet dongle I use something like:

  env delete -f ethaddr; env set boot_targets usb pxe; bootflow scan -lbG

> When I control the DHCP server, I can actually set the TFTP server 
> directly and can skip setting the serverip as it'll be set by the dhcp 
> command correctly it seems?

For my homelab I use UniFi and should be able to control DHCP options,
however looking at U-Boot it looks like option 66 or 150 is just ignored,
see [1].

  case 66:	/* Ignore TFTP server name */

[1] https://source.denx.de/u-boot/u-boot/-/blob/master/net/bootp.c?ref_type=heads#L952

From my very limited testing it looks like I am forced to set serverip
in env and cannot use a DHCP option to set the TFTP server to use.

And when I then also tried lwIP, and that seem to result in new or
different issues, e.g.:

- lwIP seem to be configured to allow very few packet fragments, trying
  to use a reasonoble tftp blocksize, e.g. TFTP_BLOCKSIZE=4096 or more
  seem to cause drop of packets.

- lwIP is very very slow to timeout compared to legacy when serverip
  point to an invalid TFTP server and pxelinux.cfg files is looked up.

- sometimes got hit with random SError issues when second file was
  loaded from TFTP, this issue was thankfully fixed with [2].
  
[2] https://patchwork.ozlabs.org/project/uboot/patch/20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org/

> 
>  From my notes, for an OpenWRT DHCP server:
> 
> Network → DHCP and DNS → PXE/TFTP tab → Add button
>      Filename: default
> 
>      Server name: fileserver
> 
>      Server address: <TFTP server IP address>
> 
>      Force: checked (may not be necessary)
> 
> Save & Apply button
> 
> I'm assuming you need this for your labgrid farm so hopefully you have a 
> way to control the DHCP server :)

Correct, I have been playing around with network boot in my labgrid farm
and hit a few mines along the way :-)

Should result in a few network related patches in next few days.

> 
>> Adding NET_LWIP=y made pxe booting stop working and 'serverip' always
>> ended up as the dhpc server regardless if it was set to something else.
>>
> 
> Interesting. With tiger-rk3588_defconfig (legacy stack), I get:
> 
> => setenv serverip 192.192.192.192
> => setenv autoload no
> => dhcp
> ethernet@fe1b0000 Waiting for PHY auto negotiation to complete........ done
> BOOTP broadcast 1
> BOOTP broadcast 2
> BOOTP broadcast 3
> DHCP client bound to address 10.2.162.193 (1394 ms)
> => printenv serverip
> serverip=10.2.0.122
> 
>> Since lwip instead prioritize the 'tftpserverip' env over the 'serverip'
>> env for tftp use, adding a similar env var Kconfig option was easy but
>> may be wrong path?
>>
> 
> I don't mind the addition but I'm wondering if it's not a band-aid patch 
> for something else? Maybe lwip missing setting the BOOTP server from a 
> DHCP lease for example?

Possible, setting tftp from dhcp also seem to be missing from legacy
stack, if I am not mistaken. I do think the separation of tftpserverip
and serverip for lwIP stack at least is a step in right direction, I am
new to network booting from U-Boot so what do I know :-)

Regards,
Jonas

> 
>>>
>>> This patch is fine, I'm just challenging the justification in the commit
>>> log.
>>>
>>>> Add USE_TFTPSERVERIP and TFTPSERVERIP Kconfig options that can be used
>>>> to add the 'tftpserverip' environment variable to force use of a
>>>> specific TFTP server ip.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>    include/env_default.h |  3 +++
>>>>    net/lwip/Kconfig      | 12 ++++++++++++
>>>>    2 files changed, 15 insertions(+)
>>>>
>>>> diff --git a/include/env_default.h b/include/env_default.h
>>>> index 7f8dc1c35a74..014873e304d8 100644
>>>> --- a/include/env_default.h
>>>> +++ b/include/env_default.h
>>>> @@ -58,6 +58,9 @@ const char default_environment[] = {
>>>>    #ifdef	CONFIG_USE_SERVERIP
>>>>    	"serverip="	CONFIG_SERVERIP			"\0"
>>>>    #endif
>>>> +#ifdef	CONFIG_USE_TFTPSERVERIP
>>>> +	"tftpserverip="	CONFIG_TFTPSERVERIP		"\0"
>>>> +#endif
>>>>    #ifdef	CONFIG_SYS_DISABLE_AUTOLOAD
>>>>    	"autoload=0\0"
>>>>    #endif
>>>> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
>>>> index 5789766fe624..0cfd3eb2684f 100644
>>>> --- a/net/lwip/Kconfig
>>>> +++ b/net/lwip/Kconfig
>>>> @@ -72,4 +72,16 @@ config LWIP_TCP_WND
>>>>    	  but QEMU with "-net user" needs no more than a few KB or the
>>>>    	  transfer will stall and eventually time out.
>>>>    
>>>> +config USE_TFTPSERVERIP
>>>> +	bool "Set a default 'tftpserverip' value in the environment"
>>>> +	depends on CMD_TFTPBOOT
>>>> +	help
>>>> +	  Defines a default value for the IP address of a TFTP server to
>>>> +	  contact when using the "tftpboot" command.  (Environment variable
>>>> +	  "tftpserverip")
>>>> +
>>>
>>> Does it support IPv4 *and*/or IPv6?
>>
>> Not sure, I have only tested IPv4, guess IPv6 probably should work, the
>> 'tftpserverip' var should work with same formats that the 'serverip' var
>> currently support.
>>
>> This help text is mostly just a c/p from the USE_SERVERIP Kconfig option,
>> let me know if you think this should be changed.
>>
> 
> If it only supports IPv4, I think it should be mentioned. I'm sure 
> Jerome will have some input on that when they have time to review :)
> 
> Cheers,
> Quentin

