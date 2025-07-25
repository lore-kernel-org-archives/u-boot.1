Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE33C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 06:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87DAF83909;
	Fri, 25 Jul 2025 08:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A2C83918; Fri, 25 Jul 2025 08:56:03 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30867838FA
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 08:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.28]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 51F38B4D0148;
 Fri, 25 Jul 2025 08:55:57 +0200 (CEST)
Message-ID: <d77f193b-0b0a-44cd-b0e0-7da83a6a8f4b@freeshell.de>
Date: Thu, 24 Jul 2025 23:55:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: introduce CONFIG_DNS
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20250718104852.724720-1-jerome.forissier@linaro.org>
 <4254d83f-ea60-4723-88a7-679135f996a1@freeshell.de>
 <20c8169b-a5de-4f53-ac3f-647bcb5d67ae@linaro.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20c8169b-a5de-4f53-ac3f-647bcb5d67ae@linaro.org>
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

Hi Jerome,

On 7/21/25 06:46, Jerome Forissier wrote:
> Hi E,
> 
> On 7/19/25 06:20, E Shattow wrote:
>> There is a crash with ping command: I apply the patch and enable
>> CONFIG_DNS for a build of starfive_visionfive2_defconfig on Pine64
>> Star64 board.
>>
>> # ping invalid
>>
>> ethernet@16030000 Waiting for PHY auto negotiation to complete....... done
>> No valid name server (dnsip/dnsip2)
>> ping - send ICMP ECHO_REQUEST to network host
>>
>> Usage:
>> ping pingAddressOrHostName
>>
>> # dhcp
>> DHCP client bound to address N.N.N.N (31 ms)
>>
>> # ping invalid
>>
>> Unhandled exception: Load access fault
>> EPC: 00000000fffa365a RA: 00000000fffafa92 TVAL: 0000000000000000
>> EPC: 000000004026e65a RA: 000000004027aa92 reloc adjusted
>>
>> SP:  00000000ff717b90 GP:  00000000ff724e40 TP:  0000000000000003
>> T0:  00000000ff717ce4 T1:  fffffffffe02a8c0 T2:  0000000000000007
>> S0:  00000000ff717e38 S1:  0000000000000000 A0:  0000000000000000
>> A1:  00000000ffffd648 A2:  0000000000000010 A3:  0000000000000000
>> A4:  00000000fffafa80 A5:  0000000000000000 A6:  0000000000000001
>> A7:  0000000000000001 S2:  0000000000000000 S3:  0000000000000019
>> S4:  0000000000010000 S5:  00000000fffb0f48 S6:  00000000000000c0
>> S7:  00000000ffffd428 S8:  0000000000000000 S9:  0000000000000000
>> S10: 00000000ff737db0 S11: 0000000000000001 T3:  00000000ff737e10
>> T4:  0000000000000035 T5:  ffffffffffffffff T6:  00000000ff717ce0
>>
>> Code: 171b 0187 969b 0106 8f55 bfe9 4501 b749 (411c)
> 
> Not reproducible here, neither on arm64 QEMU nor ZynqMP KV260.
> 
> ----------------------------------
> $ grep -E -e NET_LWIP -e _DNS .config
> # CONFIG_CMD_DNS is not set
> CONFIG_NET_LWIP=y
> CONFIG_PROT_DNS_LWIP=y
> CONFIG_DNS=y
> ----------------------------------
> ZynqMP> ping invalid
> No valid name server (dnsip/dnsip2)
> ping - send ICMP ECHO_REQUEST to network host
> 
> Usage:
> ping pingAddressOrHostName
> ZynqMP> dhcp
> DHCP client bound to address 192.168.0.12 (2047 ms)
> ZynqMP> ping invalid
> DNS: host not found
> ping - send ICMP ECHO_REQUEST to network host
> 
> Usage:
> ping pingAddressOrHostName
> ----------------------------------
> 
> Could you please debug further on you platform and point me to what's
> going wrong?
> 

No, unfortunately. It was consistent to trigger the crash until I reboot
my home router (gateway on network which caches DNS) and now, no crash
from U-Boot. This confirms there is a bug related to the DNS server
interaction over network and maybe it is a serious problem but for the
moment now I lose my way to reproduce it. Something for the future, then.

>>
>> On 7/18/25 03:48, Jerome Forissier wrote:
>>> Introduce the DNS Kconfig symbol so that various network commands may
>>> use host names without the dns command (CMD_DNS) being selected.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> CC: E Shattow <e@freeshell.de>
>>> ---
>>>
>>>  cmd/Kconfig            |   2 +-
>>>  cmd/lwip/dns.c         | 108 ---------------------------------------
>>>  doc/usage/cmd/sntp.rst |   8 +--
>>>  doc/usage/cmd/wget.rst |   2 +-
>>>  include/net-legacy.h   |   2 +-
>>>  net/Kconfig            |   8 ++-
>>>  net/Makefile           |   2 +-
>>>  net/lwip/Makefile      |   1 +
>>>  net/lwip/dns.c         | 113 +++++++++++++++++++++++++++++++++++++++++
>>>  net/lwip/net-lwip.c    |   6 +--
>>>  net/net.c              |  10 ++--
>>>  net/wget.c             |   2 +-
>>>  12 files changed, 138 insertions(+), 126 deletions(-)
>>>  create mode 100644 net/lwip/dns.c
>>>
>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>> index b3b5be1ea79..7a9c4ddb215 100644
>>> --- a/cmd/Kconfig
>>> +++ b/cmd/Kconfig
>>> @@ -2110,7 +2110,7 @@ config CMD_DHCP
>>>  
>>>  config CMD_DNS
>>>  	bool "dns"
>>> -	select PROT_DNS_LWIP if NET_LWIP
>>> +	select DNS
>>>  	help
>>>  	  Lookup the IP of a hostname
>>>  
>>> diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
>>> index b5fccc7433e..3eb698b3f82 100644
>>> --- a/cmd/lwip/dns.c
>>> +++ b/cmd/lwip/dns.c
>>> @@ -2,115 +2,7 @@
>>>  /* Copyright (C) 2024 Linaro Ltd. */
>>>  
>>>  #include <command.h>
>>> -#include <console.h>
>>> -#include <env.h>
>>> -#include <lwip/dns.h>
>>> -#include <lwip/timeouts.h>
>>>  #include <net.h>
>>> -#include <time.h>
>>>  
>>>  U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
>>>  	   "hostname [envvar]");
>>> -
>>> -#define DNS_RESEND_MS 1000
>>> -#define DNS_TIMEOUT_MS 10000
>>> -
>>> -struct dns_cb_arg {
>>> -	ip_addr_t host_ipaddr;
>>> -	const char *var;
>>> -	bool done;
>>> -};
>>> -
>>> -static void do_dns_tmr(void *arg)
>>> -{
>>> -	dns_tmr();
>>> -}
>>> -
>>> -static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>>> -{
>>> -	struct dns_cb_arg *dns_cb_arg = arg;
>>> -	char *ipstr = ip4addr_ntoa(ipaddr);
>>> -
>>> -	dns_cb_arg->done = true;
>>> -
>>> -	if (!ipaddr) {
>>> -		printf("DNS: host not found\n");
>>> -		dns_cb_arg->host_ipaddr.addr = 0;
>>> -		return;
>>> -	}
>>> -
>>> -	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
>>> -
>>> -	if (dns_cb_arg->var)
>>> -		env_set(dns_cb_arg->var, ipstr);
>>> -}
>>> -
>>> -static int dns_loop(struct udevice *udev, const char *name, const char *var)
>>> -{
>>> -	struct dns_cb_arg dns_cb_arg = { };
>>> -	struct netif *netif;
>>> -	ip_addr_t ipaddr;
>>> -	ulong start;
>>> -	int ret;
>>> -
>>> -	dns_cb_arg.var = var;
>>> -
>>> -	netif = net_lwip_new_netif(udev);
>>> -	if (!netif)
>>> -		return CMD_RET_FAILURE;
>>> -
>>> -	if (net_lwip_dns_init()) {
>>> -		net_lwip_remove_netif(netif);
>>> -		return CMD_RET_FAILURE;
>>> -	}
>>> -
>>> -	dns_cb_arg.done = false;
>>> -
>>> -	ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
>>> -
>>> -	if (ret == ERR_OK) {
>>> -		dns_cb(name, &ipaddr, &dns_cb_arg);
>>> -	} else if (ret == ERR_INPROGRESS) {
>>> -		start = get_timer(0);
>>> -		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
>>> -		do {
>>> -			net_lwip_rx(udev, netif);
>>> -			if (dns_cb_arg.done)
>>> -				break;
>>> -			if (ctrlc()) {
>>> -				printf("\nAbort\n");
>>> -				break;
>>> -			}
>>> -		} while (get_timer(start) < DNS_TIMEOUT_MS);
>>> -		sys_untimeout(do_dns_tmr, NULL);
>>> -	}
>>> -
>>> -	net_lwip_remove_netif(netif);
>>> -
>>> -	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
>>> -		if (!var)
>>> -			printf("%s\n", ipaddr_ntoa(&ipaddr));
>>> -		return CMD_RET_SUCCESS;
>>> -	}
>>> -
>>> -	return CMD_RET_FAILURE;
>>> -}
>>> -
>>> -int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>> -{
>>> -	char *name;
>>> -	char *var = NULL;
>>> -
>>> -	if (argc == 1 || argc > 3)
>>> -		return CMD_RET_USAGE;
>>> -
>>> -	name = argv[1];
>>> -
>>> -	if (argc == 3)
>>> -		var = argv[2];
>>> -
>>> -	if (net_lwip_eth_start() < 0)
>>> -		return CMD_RET_FAILURE;
>>> -
>>> -	return dns_loop(eth_get_dev(), name, var);
>>> -}
>>> diff --git a/doc/usage/cmd/sntp.rst b/doc/usage/cmd/sntp.rst
>>> index d97f83053f7..2046828130d 100644
>>> --- a/doc/usage/cmd/sntp.rst
>>> +++ b/doc/usage/cmd/sntp.rst
>>> @@ -12,7 +12,7 @@ Synopsis
>>>  ::
>>>  
>>>      sntp [serverip]
>>> -    sntp [servername]  # NET_LWIP=y && CMD_DNS=y only
>>> +    sntp [servername]  # NET_LWIP=y && DNS=y only
>>>  
>>>  
>>>  Description
>>> @@ -27,8 +27,8 @@ The address of the NTP server does not need to be given if the DHCP server
>>>  provides one. The legacy network stack (`CONFIG_NET=y`) can only use the
>>>  first NTP server provided in the `ntp-servers` DHCP option.
>>>  
>>> -When the network stack is lwIP (`CONFIG_NET_LWIP=y`) and the dns command
>>> -is enabled (`CONFIG_CMD_DNS=y`), then the sntp command accepts a server
>>> +When the network stack is lwIP (`CONFIG_NET_LWIP=y`) and DNS resolution
>>> +is enabled (`CONFIG_DNS=y`), then the sntp command accepts a server
>>>  name as an argument.
>>>  
>>>  The network time is sent as UTC. So, if you want to set the RTC to any local
>>> @@ -61,7 +61,7 @@ Examples
>>>      => date
>>>      Date: 2025-06-16 (Monday)    Time: 17:19:57
>>>  
>>> -With `CONFIG_NET_LWIP=y` and `CONFIG_CMD_DNS=y`:
>>> +With `CONFIG_NET_LWIP=y` and `CONFIG_DNS=y`:
>>>  
>>>  ::
>>>  
>>> diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
>>> index 06df2842549..8feda0248b2 100644
>>> --- a/doc/usage/cmd/wget.rst
>>> +++ b/doc/usage/cmd/wget.rst
>>> @@ -38,7 +38,7 @@ address
>>>      memory address for the data downloaded
>>>  
>>>  host
>>> -    IP address (or host name if `CONFIG_CMD_DNS` is enabled) of the HTTP
>>> +    IP address (or host name if `CONFIG_DNS` is enabled) of the HTTP
>>>      server, defaults to the value of environment variable *serverip*.
>>>  
>>>  path
>>> diff --git a/include/net-legacy.h b/include/net-legacy.h
>>> index a7dbcec1506..7ba5148a75a 100644
>>> --- a/include/net-legacy.h
>>> +++ b/include/net-legacy.h
>>> @@ -316,7 +316,7 @@ extern u32	net_boot_file_size;
>>>  /* Boot file size in blocks as reported by the DHCP server */
>>>  extern u32	net_boot_file_expected_size_in_blocks;
>>>  
>>> -#if defined(CONFIG_CMD_DNS)
>>> +#if defined(CONFIG_DNS)
>>>  extern char *net_dns_resolve;		/* The host to resolve  */
>>>  extern char *net_dns_env_var;		/* the env var to put the ip into */
>>>  #endif
>>> diff --git a/net/Kconfig b/net/Kconfig
>>> index 24508026200..40ec6bbce76 100644
>>> --- a/net/Kconfig
>>> +++ b/net/Kconfig
>>> @@ -244,11 +244,17 @@ config NET_RANDOM_ETHADDR
>>>  	  generated. It will be saved to the appropriate environment variable,
>>>  	  too.
>>>  
>>> +config DNS
>>> +	bool "Enable DNS resolutions"
>>> +	select PROT_DNS_LWIP if NET_LWIP
>>> +	help
>>> +	  Selecting this will allow the network stack to use server names
>>> +	  in addition to IP addresses.
>>> +
>>
>> Perhaps instead of CONFIG_DNS then the CONFIG_NET_DNS_LWIP symbol? or
>> CONFIG_NET_DNS if it will coexist with both legacy network stack and
>> LwIP.
> 
> CONFIG_DNS is indeed targeted at NET_LWIP and legacy NET as well. That is,
> regardless of NET vs NET_LWIP, one should be able to disable CMD_DNS and
> still have DNS support in the other commands.
> 
> I do not think CONFIG_NET_DNS is better than CONFIG_DNS. The shorter the
> Kconfig symbols the better (to some extent of course). It is quite obvious
> that DNS is a network thing.

I agree with you it is shorter, less work now to implement.
Instinctively though I would search for "_NET|_PROTOCOL" which does not
show CONFIG_DNS.

Consider that's a real situation where I've wanted to know what was in a
config file and when each feature is CONFIG_FEATURE without context it's
a lot of extra time to just understand what I'm looking for and how to
search for it... at that moment I'm not happy about the short symbol names.

What you've got with CONFIG_DNS is okay now but I want everything to be
easier to read and maintain, and that starts with people new to the code
base trying to grep config options (or so I think, anyways). Group alike
things with a common prefix (or suffix) and so they're easy to find
without already knowing where to find them or what they are i.e.
CONFIG_NET_DNS_PROTOCOL (see comparable CONFIG_EFI_*_PROTOCOL);  but
that does go the wrong way around if you wanted short symbol names:

 CONFIG_PROT_DNS CONFIG_PROT_DNS_LWIP
 CONFIG_PROT_DHCP CONFIG_PROT_DHCP_LWIP CONFIG_PROT_DHCP_NET
 -or-
 CONFIG_PROT_DHCP CONFIG_PROT_DHCP_LWIP CONFIG_PROT_DHCP_LNET
...

"PROT" makes not much sense to me, it would be protect or p(?) rotate or
pro(?)-"T" but "PROTO" does intuitively mean protocol or prototype. I
would search for PROTO|PROTOCOL but not usually think to search for PROT.

Maybe we are not concerned now what users and people have to learn in
future... it can be changed later, I could even do that :)  But it would
be easier to change and maintain if it is possible to search for.

> 
>> That is unless you foresee a build of U-Boot without any
>> networking support but having CONFIG_DNS symbol as a requisite for tools
>> that do DNS certificate processing i.e.
> 
> No, no, if this kind of need arises we will find a suitable Kconfig symbol
> I'm sure.
> 
>> If DHCP is likewise separated out you might not need the 'dhcp' command
>> as in for EFI but still using the protocol.
> 
> Makes sense.
> 
>> I'm not sure why you want to
>> add a CONFIG_DNS instead of just exposing the protocol symbols,
> 
> Because lwIP does have a protocol symbol (CONFIG_PROT_DNS_LWIP) but the
> legacy NET does not. CONFIG_PROT_DNS_LWIP is just a clean way to set
> a couple of defines for lwIP internal use (LWIP_DNS and DNS_TABLE_SIZE).
> 
>> unless,
>> there are topical things or situations where portions of supporting code
>> are needed without the presence of networking.
>>
>>>  config WGET
>>>  	bool "Enable wget"
>>>  	select PROT_TCP if NET
>>>  	select PROT_TCP_LWIP if NET_LWIP
>>> -	select PROT_DNS_LWIP if NET_LWIP
>>>  	help
>>>  	  Selecting this will enable wget, an interface to send HTTP requests
>>>  	  via the network stack.
>>> diff --git a/net/Makefile b/net/Makefile
>>> index d63f62b7c8a..468820186cf 100644
>>> --- a/net/Makefile
>>> +++ b/net/Makefile
>>> @@ -10,7 +10,7 @@ ifeq ($(CONFIG_NET),y)
>>>  obj-$(CONFIG_NET)      += arp.o
>>>  obj-$(CONFIG_CMD_BOOTP) += bootp.o
>>>  obj-$(CONFIG_CMD_CDP)  += cdp.o
>>> -obj-$(CONFIG_CMD_DNS)  += dns.o
>>> +obj-$(CONFIG_DNS)  += dns.o
>>>  obj-$(CONFIG_CMD_LINK_LOCAL) += link_local.o
>>>  obj-$(CONFIG_IPV6)     += ndisc.o
>>>  obj-$(CONFIG_$(PHASE_)DM_ETH) += net.o
>>> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>>> index 97299d9b542..90d3300bd12 100644
>>> --- a/net/lwip/Makefile
>>> +++ b/net/lwip/Makefile
>>> @@ -2,6 +2,7 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
>>>  
>>>  obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
>>>  obj-$(CONFIG_CMD_DHCP) += dhcp.o
>>> +obj-$(CONFIG_DNS) += dns.o
>>>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>>>  obj-$(CONFIG_WGET) += wget.o
>>>  
>>> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
>>> new file mode 100644
>>> index 00000000000..9964003195f
>>> --- /dev/null
>>> +++ b/net/lwip/dns.c
>>> @@ -0,0 +1,113 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/* Copyright (C) 2024 Linaro Ltd. */
>>> +
>>> +#include <command.h>
>>> +#include <console.h>
>>> +#include <env.h>
>>> +#include <lwip/dns.h>
>>> +#include <lwip/timeouts.h>
>>> +#include <net.h>
>>> +#include <time.h>
>>> +
>>> +#define DNS_RESEND_MS 1000
>>> +#define DNS_TIMEOUT_MS 10000
>>> +
>>> +struct dns_cb_arg {
>>> +	ip_addr_t host_ipaddr;
>>> +	const char *var;
>>> +	bool done;
>>> +};
>>> +
>>> +static void do_dns_tmr(void *arg)
>>> +{
>>> +	dns_tmr();
>>> +}
>>> +
>>> +static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>>> +{
>>> +	struct dns_cb_arg *dns_cb_arg = arg;
>>> +	char *ipstr = ip4addr_ntoa(ipaddr);
>>> +
>>> +	dns_cb_arg->done = true;
>>> +
>>> +	if (!ipaddr) {
>>> +		printf("DNS: host not found\n");
>>> +		dns_cb_arg->host_ipaddr.addr = 0;
>>> +		return;
>>> +	}
>>> +
>>> +	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
>>> +
>>> +	if (dns_cb_arg->var)
>>> +		env_set(dns_cb_arg->var, ipstr);
>>> +}
>>> +
>>> +static int dns_loop(struct udevice *udev, const char *name, const char *var)
>>> +{
>>> +	struct dns_cb_arg dns_cb_arg = { };
>>> +	struct netif *netif;
>>> +	ip_addr_t ipaddr;
>>> +	ulong start;
>>> +	int ret;
>>> +
>>> +	dns_cb_arg.var = var;
>>> +
>>> +	netif = net_lwip_new_netif(udev);
>>> +	if (!netif)
>>> +		return CMD_RET_FAILURE;
>>> +
>>> +	if (net_lwip_dns_init()) {
>>> +		net_lwip_remove_netif(netif);
>>> +		return CMD_RET_FAILURE;
>>> +	}
>>> +
>>> +	dns_cb_arg.done = false;
>>> +
>>> +	ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
>>> +
>>> +	if (ret == ERR_OK) {
>>> +		dns_cb(name, &ipaddr, &dns_cb_arg);
>>> +	} else if (ret == ERR_INPROGRESS) {
>>> +		start = get_timer(0);
>>> +		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
>>> +		do {
>>> +			net_lwip_rx(udev, netif);
>>> +			if (dns_cb_arg.done)
>>> +				break;
>>> +			if (ctrlc()) {
>>> +				printf("\nAbort\n");
>>> +				break;
>>> +			}
>>> +		} while (get_timer(start) < DNS_TIMEOUT_MS);
>>> +		sys_untimeout(do_dns_tmr, NULL);
>>> +	}
>>> +
>>> +	net_lwip_remove_netif(netif);
>>> +
>>> +	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
>>> +		if (!var)
>>> +			printf("%s\n", ipaddr_ntoa(&ipaddr));
>>> +		return CMD_RET_SUCCESS;
>>> +	}
>>> +
>>> +	return CMD_RET_FAILURE;
>>> +}
>>> +
>>> +int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>> +{
>>> +	char *name;
>>> +	char *var = NULL;
>>> +
>>> +	if (argc == 1 || argc > 3)
>>> +		return CMD_RET_USAGE;
>>> +
>>> +	name = argv[1];
>>> +
>>> +	if (argc == 3)
>>> +		var = argv[2];
>>> +
>>> +	if (net_lwip_eth_start() < 0)
>>> +		return CMD_RET_FAILURE;
>>> +
>>> +	return dns_loop(eth_get_dev(), name, var);
>>> +}
>>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>>> index 3918d57d7e5..7069e56065f 100644
>>> --- a/net/lwip/net-lwip.c
>>> +++ b/net/lwip/net-lwip.c
>>> @@ -147,7 +147,7 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>>>   */
>>>  int net_lwip_dns_init(void)
>>>  {
>>> -#if CONFIG_IS_ENABLED(CMD_DNS)
>>> +#if CONFIG_IS_ENABLED(DNS)
>>>  	bool has_server = false;
>>>  	ip_addr_t ns;
>>>  	char *nsenv;
>>> @@ -369,7 +369,7 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>>>   */
>>>  int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip)
>>>  {
>>> -#if defined(CONFIG_CMD_DNS)
>>> +#if defined(CONFIG_DNS)
>>>  	char *var = "_dnsres";
>>>  	char *argv[] = { "dns", name_or_ip, var, NULL };
>>>  	int argc = ARRAY_SIZE(argv) - 1;
>>> @@ -378,7 +378,7 @@ int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip)
>>>  	if (ipaddr_aton(name_or_ip, ip))
>>>  		return 0;
>>>  
>>> -#if defined(CONFIG_CMD_DNS)
>>> +#if defined(CONFIG_DNS)
>>>  	if (do_dns(NULL, 0, argc, argv) != CMD_RET_SUCCESS)
>>>  		return -1;
>>>  
>>> diff --git a/net/net.c b/net/net.c
>>> index 5219367e391..382a27e0a77 100644
>>> --- a/net/net.c
>>> +++ b/net/net.c
>>> @@ -115,7 +115,7 @@
>>>  #include "bootp.h"
>>>  #include "cdp.h"
>>>  #include "dhcpv6.h"
>>> -#if defined(CONFIG_CMD_DNS)
>>> +#if defined(CONFIG_DNS)
>>>  #include "dns.h"
>>>  #endif
>>>  #include "link_local.h"
>>> @@ -288,7 +288,7 @@ static int on_vlan(const char *name, const char *value, enum env_op op,
>>>  }
>>>  U_BOOT_ENV_CALLBACK(vlan, on_vlan);
>>>  
>>> -#if defined(CONFIG_CMD_DNS)
>>> +#if defined(CONFIG_DNS)
>>>  static int on_dnsip(const char *name, const char *value, enum env_op op,
>>>  	int flags)
>>>  {
>>> @@ -582,7 +582,7 @@ restart:
>>>  			nc_start();
>>>  			break;
>>>  #endif
>>> -#if defined(CONFIG_CMD_DNS)
>>> +#if defined(CONFIG_DNS)
>>>  		case DNS:
>>>  			dns_start();
>>>  			break;
>>> @@ -1507,7 +1507,7 @@ static int net_check_prereq(enum proto_t protocol)
>>>  		}
>>>  		goto common;
>>>  #endif
>>> -#if defined(CONFIG_CMD_DNS)
>>> +#if defined(CONFIG_DNS)
>>>  	case DNS:
>>>  		if (net_dns_server.s_addr == 0) {
>>>  			puts("*** ERROR: DNS server address not given\n");
>>> @@ -1540,7 +1540,7 @@ static int net_check_prereq(enum proto_t protocol)
>>>  			return 1;
>>>  		}
>>>  #if	defined(CONFIG_CMD_PING) || \
>>> -	defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
>>> +	defined(CONFIG_DNS) || defined(CONFIG_PROT_UDP)
>>>  common:
>>>  #endif
>>>  		/* Fall through */
>>> diff --git a/net/wget.c b/net/wget.c
>>> index 3c0fff488eb..e65ce15ccb3 100644
>>> --- a/net/wget.c
>>> +++ b/net/wget.c
>>> @@ -393,7 +393,7 @@ int wget_do_request(ulong dst_addr, char *uri)
>>>  	if (string_to_ip(host_name).s_addr) {
>>>  		s = host_name;
>>>  	} else {
>>> -#if IS_ENABLED(CONFIG_CMD_DNS)
>>> +#if IS_ENABLED(CONFIG_DNS)
>>>  		net_dns_resolve = host_name;
>>>  		net_dns_env_var = "httpserverip";
>>>  		if (net_loop(DNS) < 0) {
>>
>> If hostnames are valid then it does appear to be working for commands
>> ping and wget. I do not think there was a crash for wget.
> 
> OK. Thanks for testing.
> 
>>
>> best regards,
>>
>> -E Shattow
> 
> Regards,

Thanks much,

-E Shattow
