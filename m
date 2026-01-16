Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25EFD4A617
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 09:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD2C83015;
	Fri, 16 Jan 2026 10:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sa+3crE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 948C28367F; Fri, 16 Jan 2026 10:28:34 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A2C82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf5=7V=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768555709;
 bh=s+ssgHlPi8vu3cMAxZeM529HtGh6xUgC25FArTo6Zl0=;
 b=sa+3crE7NAa9WNFaKgAnEPsqJ09Sm3UvfTGUY4kkp5HtbsQFFAbv/OSOmH0SdJoiYxpnA9w3C
 3iDZi0VzQjFQyUdcmYlPbA5rsc382qL9aWT6g7bhsjOvntTt1FA0IjbHzV/Nj3ygYxNua1Ol0Se
 u/EJRxSyjEzQq2TAit8boCwYi+XEoQlw6oUSpSa0IJJwht8+YlGhMNPlEM05NrIEPU5P5vx1gvd
 gIn5c2RqSPnHNu8mZcKtNjXdrqPnBnJVZxNziIUh0XBrzEJyI9vHoy+wEvEEVS+R+FWHhkwkpzB
 vr4asJgzdiJ3+tDMZIUaH3VxV++MLU/+H8CKVkrbgzTw==
X-Forward-Email-ID: 696a04b8b4d26d848ca52535
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <77a9bf3d-6662-43fc-9ada-fedc5e611d23@kwiboo.se>
Date: Fri, 16 Jan 2026 10:28:20 +0100
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
 <c9664240-002a-418d-9301-e8307e3e0aea@kwiboo.se>
 <36c506b5-228d-47ab-ac6f-fb6dd784ff46@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <36c506b5-228d-47ab-ac6f-fb6dd784ff46@cherry.de>
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

On 1/15/2026 3:20 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/14/26 7:29 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 1/14/2026 6:08 PM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 1/14/26 4:37 PM, Jonas Karlman wrote:
>>>> Hi Quentin,
>>>>
>>>> On 1/14/2026 4:01 PM, Quentin Schulz wrote:
>>>>> Hi Jonas,
>>>>>
>>>>> On 1/6/26 9:34 PM, Jonas Karlman wrote:
>>>>>> With the legacy networking stack, it is possible to use USE_SERVERIP,
>>>>>> SERVERIP and BOOTP_PREFER_SERVERIP Kconfg options to force use of a
>>>>>> specific TFTP server ip.
>>>>>>
>>>>>> Using the lwIP networking stack use of the 'tftpserverip' environment
>>>>>> variable provide the closest equivalent functionality.
>>>>>>
>>>>>
>>>>> It does read serverip environment variable if it's set, so this should
>>>>> match the behavior with the legacy network stack no?
>>>>
>>>> This is what I first thought, however it seem that the lwip stack differ
>>>> slightly from the legacy stack, in that the dhcp lookup always seem to
>>>> reset the serverip env var.
>>>>
>>>>> As for BOOTP_PREFER_SERVERIP, this would need to be implemented in lwip
>>>>> and isn't covered by this new variable is it?
>>>>
>>>> For the lwip stack it looks like the BOOTP_PREFER_SERVERIP Kconfig
>>>> option possible was replaced with use of a 'tftpserverip' env var.
>>>>
>>>> For legacy stack I had something like following in a .config fragment:
>>>>
>>>>     CONFIG_BOOTP_PREFER_SERVERIP=y
>>>>     CONFIG_SERVERIP="192.168.2.50"
>>>>     CONFIG_USE_SERVERIP=y
>>>>
>>>
>>> And this meant the serverip would not be overwritten by the dhcp command
>>> for example (in the legacy stack)? When doing PXE/TFTP, I always do
>>>
>>> setenv autoload no; dhcp; setenv serverip X.Y.Z.A; pxe get; pxe boot
>>
>> I tried to keep it as simple as possible, as I have not used network
>> boot before, and used something like following:
>>
>>    env set boot_targets pxe; bootflow scan -lbG
>>
>> and when I need to use a USB Ethernet dongle I use something like:
>>
>>    env delete -f ethaddr; env set boot_targets usb pxe; bootflow scan -lbG
>>
>>> When I control the DHCP server, I can actually set the TFTP server
>>> directly and can skip setting the serverip as it'll be set by the dhcp
>>> command correctly it seems?
>>
>> For my homelab I use UniFi and should be able to control DHCP options,
>> however looking at U-Boot it looks like option 66 or 150 is just ignored,
>> see [1].
>>
>>    case 66:	/* Ignore TFTP server name */
>>
>> [1] https://source.denx.de/u-boot/u-boot/-/blob/master/net/bootp.c?ref_type=heads#L952
>>
>>  From my very limited testing it looks like I am forced to set serverip
>> in env and cannot use a DHCP option to set the TFTP server to use.
>>
> 
> Still on my RK3588 Tiger (on a different network, legacy stack):
> 
> => env set boot_targets pxe; bootflow scan -lbG
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------ 
> ----------------
> pcie_dw_rockchip pcie@fe150000: PCIe-0 Link Fail
> Scanning bootdev 'ethernet@fe1b0000.bootdev':
> ethernet@fe1b0000 Waiting for PHY auto negotiation to complete...... done
> BOOTP broadcast 1
> DHCP client bound to address 192.168.1.144 (5 ms)
> missing environment variable: pxeuuid
> Retrieving file: pxelinux.cfg/01-aa-38-40-51-be-af
> Using ethernet@fe1b0000 device
> TFTP from server 192.168.1.211; our IP address is 192.168.1.144
> 
> My DHCP server is on OpenWRT at 192.168.1.1, and my TFTP server is on 
> 192.168.1.211, with the setup steps explained in my first answer. If I 
> don't boot (remove -b), then I can see serverip is set to 192.168.1.211.
> 
> So *something* is working here.

I took a closer look at how the UniFi dnsmasq config was generated and
noticed that I must configure the "Network Boot" option and not the
"TFTP Server" option to have a generated config that make dnsmasq
replace the DHCP siaddr field with the TFTP server ip :-S

And legacy stack seem to work as expected and correctly uses the
expected siaddr field to configure the internal net_server_ip var.

Following diff seem to make lwIP also pick up the siaddr as the
tftpserverip (in addition to serverip for the DHCP server):

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 731b57de3ba4..a3445a48b15d 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -99,8 +99,11 @@ static int dhcp_loop(struct udevice *udev)
        env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr));
        env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask));
        env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
-       if (dhcp->offered_gw_addr.addr != 0)
+       if (!ip4_addr_isany(&dhcp->offered_gw_addr))
                env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr));
+       if (!ip4_addr_isany(&dhcp->offered_si_addr) &&
+           !ip4_addr_eq(&dhcp->offered_si_addr, &dhcp->server_ip_addr))
+               env_set("tftpserverip", ip4addr_ntoa(&dhcp->offered_si_addr));

 #ifdef CONFIG_PROT_DNS_LWIP
        env_set("dnsip", ip4addr_ntoa(dns_getserver(0)));

With something like that I do not think I will have any further use of
SERVERIP or TFTPSERVERIP Kconfig options for my labgrid farm, so can
probably drop this series and will instead send above diff as a separate
patch.

>> And when I then also tried lwIP, and that seem to result in new or
>> different issues, e.g.:
>>
>> - lwIP seem to be configured to allow very few packet fragments, trying
>>    to use a reasonoble tftp blocksize, e.g. TFTP_BLOCKSIZE=4096 or more
>>    seem to cause drop of packets.
>>
>> - lwIP is very very slow to timeout compared to legacy when serverip
>>    point to an invalid TFTP server and pxelinux.cfg files is looked up.
>>
>> - sometimes got hit with random SError issues when second file was
>>    loaded from TFTP, this issue was thankfully fixed with [2].
>>    
> 
> Rough first experience with lwIP :)

Hehe, and all while trying to figure out why dwc_eth_qos was not working
on my Rockchip RK3506 board (firewall blocked DMA to DRAM) and my
AX88179A/AX88772D USB Ethernet adapters also had driver issues :-D

At least this experience has helped generate a few forthcoming cleanup
patches for dwc_eth_qos and asix88179 drivers.

> Are you planning on new Rockchip board/SoC support to use lwIP?

Not sure, but at some point we probably should fully switch to use lwIP
for the Rockchip platform. The LWIP_DEBUG and LWIP_DEBUG_RXTX Kconfig
options can help a lot when debugging any issue with Ethernet drivers.

Regards,
Jonas

>> [2] https://patchwork.ozlabs.org/project/uboot/patch/20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org/
>>
>>>
>>>   From my notes, for an OpenWRT DHCP server:
>>>
>>> Network → DHCP and DNS → PXE/TFTP tab → Add button
>>>       Filename: default
>>>
>>>       Server name: fileserver
>>>
>>>       Server address: <TFTP server IP address>
>>>
>>>       Force: checked (may not be necessary)
>>>
>>> Save & Apply button
>>>
>>> I'm assuming you need this for your labgrid farm so hopefully you have a
>>> way to control the DHCP server :)
>>
>> Correct, I have been playing around with network boot in my labgrid farm
>> and hit a few mines along the way :-)
>>
>> Should result in a few network related patches in next few days.
>>
>>>
>>>> Adding NET_LWIP=y made pxe booting stop working and 'serverip' always
>>>> ended up as the dhpc server regardless if it was set to something else.
>>>>
>>>
>>> Interesting. With tiger-rk3588_defconfig (legacy stack), I get:
>>>
>>> => setenv serverip 192.192.192.192
>>> => setenv autoload no
>>> => dhcp
>>> ethernet@fe1b0000 Waiting for PHY auto negotiation to complete........ done
>>> BOOTP broadcast 1
>>> BOOTP broadcast 2
>>> BOOTP broadcast 3
>>> DHCP client bound to address 10.2.162.193 (1394 ms)
>>> => printenv serverip
>>> serverip=10.2.0.122
>>>
>>>> Since lwip instead prioritize the 'tftpserverip' env over the 'serverip'
>>>> env for tftp use, adding a similar env var Kconfig option was easy but
>>>> may be wrong path?
>>>>
>>>
>>> I don't mind the addition but I'm wondering if it's not a band-aid patch
>>> for something else? Maybe lwip missing setting the BOOTP server from a
>>> DHCP lease for example?
>>
>> Possible, setting tftp from dhcp also seem to be missing from legacy
>> stack, if I am not mistaken. I do think the separation of tftpserverip
>> and serverip for lwIP stack at least is a step in right direction, I am
>> new to network booting from U-Boot so what do I know :-)
>>
> 
> I'm not sure the point of lwip is to keep all the quirks from the legacy 
> stack, but it doesn't hurt to bring this up :)
> 
> Cheers,
> Quentin

