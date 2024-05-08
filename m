Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86B1C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 05:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16F088393;
	Wed,  8 May 2024 07:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mJK/5Ekf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C6888438; Wed,  8 May 2024 07:17:03 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 4C9AC8830D
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 07:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from [192.168.4.78] (c-24-56-243-154.customer.broadstripe.net
 [24.56.243.154])
 by linux.microsoft.com (Postfix) with ESMTPSA id 415562083C9B;
 Tue,  7 May 2024 22:17:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 415562083C9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1715145420;
 bh=z1VlMhXrLINVXrY8iHQZZiQAmszv0FN729qsL1kIlgU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mJK/5Ekf6twRbQx2P3wxlb/6wxxVF4dE2yfVf7lDJ4E8iHfImnY1RLA+tq//O/V6H
 nOl5C89gIiSguFTM4OCNUR2EeEJpQN61/E4bG6L2G+zr4oYzQnA5gha2Pg+VpCXp5w
 GtmST+KQ9t3Qb8DxcWAvTWej3LXPZanWw+39vyC8=
Message-ID: <9f6ea33b-9bdb-49a3-b8a6-51072d3b1a34@linux.microsoft.com>
Date: Tue, 7 May 2024 22:16:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix neighbor discovery ethernet address saving
To: "Vyacheslav V. Mitrofanov" <v.v.mitrofanov@yadro.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "saproj@gmail.com" <saproj@gmail.com>,
 "seanedmond@microsoft.com" <seanedmond@microsoft.com>
References: <20240429185116.2287092-1-seanedmond@linux.microsoft.com>
 <2c8ff0fe4c082799118bbf13de7b2f6558493334.camel@yadro.com>
Content-Language: en-CA
From: Sean Edmond <seanedmond@linux.microsoft.com>
In-Reply-To: <2c8ff0fe4c082799118bbf13de7b2f6558493334.camel@yadro.com>
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

Hi Vyachesla,

Let's start by saying neighbour discovery protocol is definitely working 
properly.  I'm only suggesting that it isn't properly caching the MAC 
address.  During IPv6 TFTP I observe that neighbour discovery is 
performed before every packet sent from client(u-boot)->server.

Here's a snapshot of what the packets from client(u-boot)<->server look 
like during IPv6 TFTP:
-> neighbour solicitation
<- neighbour advertisement
-> read request
<- Block 0
-> neighbour solicitation
<- neighbour advertisement
-> ACK block 0
<- Block 1
-> neighbour solicitation
<- neighbour advertisement
-> ACK block 1
- ... (continues for entire file transfer)

The neighbour discovery on every TX TFTP packet isn't required and 
results in degraded performance.  Note, when performing the test with 
IPv4, ARP is not performed before every TX packet.

Here's a description of the code flow (including my proposal):
- net.c defines "u8 net_server_ethaddr[6];"
- tftp_send()-> net_send_udp_packet6(net_server_ethaddr, ...)
- in net_send_udp_packet6(), "net_nd_packet_mac = ether;"  (now, 
net_nd_packet_mac is pointing to net_server_ethaddr)
- in ndisc_receive(), when NA is received the mac becomes available in 
neigh_eth_addr
- My proposal is, "if pointer net_nd_packet_mac isn't NULL, copy this 
contents of neigh_eth_addr into net_nd_packet_mac"
- For TFTP, my fix allows the server's MAC to get copied into 
net_server_ethaddr
- on the next tftp_send(), in net_send_udp_packet6() neighbour discovery 
is skipped because "ether" isn't all zeros

The memcpy isn't dangerous, because it's copying the discovered mac 
address into the already allocated net_server_ethaddr (and it's checking 
to make sure that net_nd_packet_mac isn't NULL before copying).

Also, the current code serves no purpose.  The current code is, "if 
net_nd_packet_mac is NULL, set it to stack variable neigh_eth_addr, then 
set net_nd_packet_mac to NULL when there is no ND pending (the mac 
address doesn't get saved in net_server_ethaddr).

Sean










On 2024-05-05 2:40 a.m., Vyacheslav V. Mitrofanov wrote:
> On Mon, 2024-04-29 at 11:51 -0700, seanedmond@linux.microsoft.com
> wrote:
>> soc@yadro.com<mailto:soc@yadro.com>
>>
>> From: Sean Edmond <seanedmond@microsoft.com>
>>
>> When a successful neighbor advertisement is received, the ethernet
>> address should be saved for later use to avoid having to redo the
>> neighbor discovery process.
>>
>> For example, with TFTP the address should get saved into
>> "net_server_ethaddr".  This is being done correctly with ARP for
>> IPv4,
>> but not for neighbor discovery with IPv6.
>>
>> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
>> ---
>>   net/ndisc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ndisc.c b/net/ndisc.c
>> index d1cec0601c8..505515f2d95 100644
>> --- a/net/ndisc.c
>> +++ b/net/ndisc.c
>> @@ -461,8 +461,8 @@ int ndisc_receive(struct ethernet_hdr *et, struct
>> ip6_hdr *ip6, int len)
>>                          ndisc_extract_enetaddr(ndisc,
>> neigh_eth_addr);
>>
>>                          /* save address for later use */
>> -                       if (!net_nd_packet_mac)
>> -                               net_nd_packet_mac = neigh_eth_addr;
>> +                       if (net_nd_packet_mac)
>> +                               memcpy(net_nd_packet_mac,
>> neigh_eth_addr, 6);
>>
>>                          /* modify header, and transmit it */
>>                          memcpy(((struct ethernet_hdr
>> *)net_nd_tx_packet)->et_dest,
>> --
>> 2.42.0
>>
> Hello, Sean. Thanks for your notice. I see that net_nd_packet_mac is
> just a uchar pointer without memory allocation. It is dangerous to do
> memcpy and not necessary. All works as it has to be.
