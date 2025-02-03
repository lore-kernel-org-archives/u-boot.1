Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFFAC0218F
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 01:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 095D38006D;
	Mon,  3 Feb 2025 02:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A6C80077; Mon,  3 Feb 2025 02:58:34 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD548004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 02:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.61.17]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id DF432B2C659B;
 Mon,  3 Feb 2025 02:58:29 +0100 (CET)
Message-ID: <0ef33cab-aaad-44fa-ac14-9e0ca1b88963@freeshell.de>
Date: Sun, 2 Feb 2025 17:58:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: move eth_init() out of new_netif()
To: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
References: <20250130082226.1572302-1-jerome.forissier@linaro.org>
 <20250130145026.GY1233568@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250130145026.GY1233568@bill-the-cat>
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



On 1/30/25 06:50, Tom Rini wrote:
> On Thu, Jan 30, 2025 at 09:22:20AM +0100, Jerome Forissier wrote:
>> Move the initialization of the ethernet devices out of the new_netif()
>> function. Indeed, new_netif() accepts a struct device argument, which
>> is expected to be valid and active. The activation and selection of
>> this device are achieved by eth_init() (on first time the network
>> stack is used) and eth_set_current(). This is what takes care of the
>> ethrotate and ethact environment variables. Therefore, move these calls
>> to a new function: net_lwip_set_current(), and use it whenever a
>> net-lwip command is run.
>>
>> This patch hopefully fixes the incorrect net-lwip behavior observed on
>> boards with multiple ethernet interfaces [1].
>>
>> Tested on an i.MX8MPlus EVK equipped wih two ethernet ports. The dhcp
>> command succeeds whether the cable is plugged into the first or second
>> port.
>>
>> [1] https://lists.denx.de/pipermail/u-boot/2025-January/576326.html
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> CC: E Shattow <e@freeshell.de>
> 
> Reported-by: E Shattow <e@freeshell.de>
> 
>> ---
>>  include/net-lwip.h  |  1 +
>>  net/lwip/dhcp.c     |  2 +-
>>  net/lwip/dns.c      |  2 +-
>>  net/lwip/net-lwip.c | 23 ++++++++++++++---------
>>  net/lwip/ping.c     |  2 +-
>>  net/lwip/tftp.c     |  2 +-
>>  net/lwip/wget.c     |  2 +-
>>  7 files changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/net-lwip.h b/include/net-lwip.h
>> index 4d7f9387d1d..64e5c720560 100644
>> --- a/include/net-lwip.h
>> +++ b/include/net-lwip.h
>> @@ -10,6 +10,7 @@ enum proto_t {
>>  	TFTPGET
>>  };
>>  
>> +void net_lwip_set_current(void);
>>  struct netif *net_lwip_new_netif(struct udevice *udev);
>>  struct netif *net_lwip_new_netif_noip(struct udevice *udev);
>>  void net_lwip_remove_netif(struct netif *netif);
>> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
>> index e7d9147455c..3b7e4700c6e 100644
>> --- a/net/lwip/dhcp.c
>> +++ b/net/lwip/dhcp.c
>> @@ -115,7 +115,7 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  	int ret;
>>  	struct udevice *dev;
>>  
>> -	eth_set_current();
>> +	net_lwip_set_current();
>>  
>>  	dev = eth_get_dev();
>>  	if (!dev) {
>> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
>> index 1de63c9998b..149bdb784dc 100644
>> --- a/net/lwip/dns.c
>> +++ b/net/lwip/dns.c
>> @@ -121,7 +121,7 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  	if (argc == 3)
>>  		var = argv[2];
>>  
>> -	eth_set_current();
>> +	net_lwip_set_current();
>>  
>>  	return dns_loop(eth_get_dev(), name, var);
>>  }
>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>> index b863047f598..cab1dd7d483 100644
>> --- a/net/lwip/net-lwip.c
>> +++ b/net/lwip/net-lwip.c
>> @@ -127,6 +127,20 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>>  	return 0;
>>  }
>>  
>> +/* Initialize the lwIP stack and the ethernet devices and set current device  */
>> +void net_lwip_set_current(void)
>> +{
>> +	static bool init_done;
>> +
>> +	if (!init_done) {
>> +		eth_init_rings();
>> +		eth_init();
>> +		lwip_init();
>> +		init_done = true;
>> +	}
>> +	eth_set_current();
>> +}
>> +
>>  static struct netif *new_netif(struct udevice *udev, bool with_ip)
>>  {
>>  	unsigned char enetaddr[ARP_HLEN];
>> @@ -134,19 +148,10 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
>>  	ip4_addr_t ip, mask, gw;
>>  	struct netif *netif;
>>  	int ret = 0;
>> -	static bool first_call = true;
>>  
>>  	if (!udev)
>>  		return NULL;
>>  
>> -	if (first_call) {
>> -		eth_init_rings();
>> -		/* Pick a valid active device, if any */
>> -		eth_init();
>> -		lwip_init();
>> -		first_call = false;
>> -	}
>> -
>>  	if (eth_start_udev(udev) < 0) {
>>  		log_err("Could not start %s\n", udev->name);
>>  		return NULL;
>> diff --git a/net/lwip/ping.c b/net/lwip/ping.c
>> index aa617530749..200a702bbb5 100644
>> --- a/net/lwip/ping.c
>> +++ b/net/lwip/ping.c
>> @@ -168,7 +168,7 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  	if (!ipaddr_aton(argv[1], &addr))
>>  		return CMD_RET_USAGE;
>>  
>> -	eth_set_current();
>> +	net_lwip_set_current();
>>  
>>  	if (ping_loop(eth_get_dev(), &addr) < 0)
>>  		return CMD_RET_FAILURE;
>> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
>> index fc4aff5f2ba..123d66b5dba 100644
>> --- a/net/lwip/tftp.c
>> +++ b/net/lwip/tftp.c
>> @@ -280,7 +280,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  		goto out;
>>  	}
>>  
>> -	eth_set_current();
>> +	net_lwip_set_current();
>>  
>>  	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
>>  		ret = CMD_RET_FAILURE;
>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>> index b76f6c0f1d9..9aec75f9bed 100644
>> --- a/net/lwip/wget.c
>> +++ b/net/lwip/wget.c
>> @@ -354,7 +354,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>  
>>  int wget_do_request(ulong dst_addr, char *uri)
>>  {
>> -	eth_set_current();
>> +	net_lwip_set_current();
>>  
>>  	if (!wget_info)
>>  		wget_info = &default_wget_info;
>> -- 
>> 2.43.0
>>
> 

I did write in-thread about the problem since that I tested this patch
successfully. With that and my appreciation for the fix:

Tested-by: E Shattow <e@freeshell.de>
