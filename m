Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC1EC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 13:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 859B281E25;
	Tue,  3 Jun 2025 15:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C8xKCgqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE9D81E72; Tue,  3 Jun 2025 15:49:10 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383AB80F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-602c3f113bbso11097247a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748958547; x=1749563347; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l7bsx9JCw8jUFlyx43+wqqOAqw74zHE6vO3BXoMvNRE=;
 b=C8xKCgqBM6NkVuhxLve3oCBriV7xpo2e8GKSYzzea0tUhl1xzWXHRHVo+c+fPf9XPG
 x3lQDDFDI1WL3rkTMg2XCabokgFQTrmTaJpIg0sadEImE6G/e2eA4Mic+4QTNLTd7RVS
 YHChxh3X4hWnTpT2vEKceUsqhloC+q9NTdLInbEqtinN5cjWdxUAXDrHUC3fU4FU8KkQ
 UItRMCje1fDhSW0HmpR7zmtlte1HPEkBnqpL1UOI9xyztMAs0gBtS/6ZrD9uaqIVyfQO
 WTtYutrqUlPcw/iUHIxHY1QKfAaILqs+4V6CjJQIkSYdZUNgFxxLQ7NlkKZdFpO5FinK
 AWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748958547; x=1749563347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l7bsx9JCw8jUFlyx43+wqqOAqw74zHE6vO3BXoMvNRE=;
 b=Cq/BFcaJM5oOcypcCyej5sfuc1tmObPBkvyQC3+YUHW/SmWt9HMl4GhinnAJEhajVg
 jiJ/MLMw1DXEcc31JXik1Qu1I5Sf6YCPSqEoplSxJsAXYvBCrg6GIUwDEv/Loz0i/KWP
 ItANsodKEwL+ER6OWiRNZwbPxn4Kq2co/2sXdNd/d+6AVyoC+XUnTnNzL0tazAVYoA7z
 LTPhEHG5Ydgu1FvsWkwJ7OW+/m86ZMX10gUsaQ5EieHRhtafUYHaSBxDD/UwVjKu585G
 /gPa3sY+x+0fCAgdG6SPuUSgGQw+fqf6FxoCrjxdo4IjI8lbBZiwqJoqAz6+r03dVNDa
 V+xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJBRjsPhcPT8lPwwqVdqyCtJQk28EbiMJhmrnxzOgDsTErzlAYYUiJAXZu/8n3MtAxgpLQvbw=@lists.denx.de
X-Gm-Message-State: AOJu0YyCT776aqLNv0Z9zLB+s3kqHiUAeWdmK3+nqSkG6QCbh6AOtthq
 mZ3y8aH4lBoQ7sUrO3vgKZU4aawx/mj5a8WlSYqvQ0nZ94OVlgLdnPyx8TMkcRUxHSk=
X-Gm-Gg: ASbGncuigNXpafDSpPzAcBqlzGiKmiZxOv5IxTB7twHocFnb04THlQf348IvPTb4Bva
 KT6GCjlgGrMp3nhigTc9fd367DobTfTLlGGt1jV6Toto4bo6nO383OtaXIp7giCT2TcGOVK5K/Q
 0YZ0TPOfwjI1bHVgfpu6clPEiPGY1D/bn7APijeOhzoOZHjdW/7ZZQY0dN7TlN9OeocWaOI22tR
 5ABMjSTnEBPN20XZOBWBbgexQe/WAJNgYnBLl2fF6VEg3Kd1SZZLEr+mmEVSVDiPVsK+uDs9p4z
 oP5P8b10WBOaP0gODSqV02Wt0SGHgfPfkvh3XIIVYti5oZNg318bcLPwygs=
X-Google-Smtp-Source: AGHT+IFn3fHmuFUDx8NzGj4uY5X9qKT4YfQbZfrBlOdNI1n+Y0orwwLiXAEBTd3eCyk1oZwz8xyE5A==
X-Received: by 2002:a05:6402:350c:b0:606:ba76:75f0 with SMTP id
 4fb4d7f45d1cf-606ba7677c1mr2322401a12.0.1748958547445; 
 Tue, 03 Jun 2025 06:49:07 -0700 (PDT)
Received: from [10.5.0.2] ([194.15.111.82]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-606b2f0e369sm961933a12.72.2025.06.03.06.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 06:49:07 -0700 (PDT)
Message-ID: <3f6c6f3c-ac48-4f24-bb64-23e86fbeb5fa@linaro.org>
Date: Tue, 3 Jun 2025 15:49:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: lwip: add sntp command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Adriano Cordova <adrianox@gmail.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <20250521151516.16729-3-jerome.forissier@linaro.org>
 <C092D71D-1A30-44D5-8043-07EE04DA571B@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <C092D71D-1A30-44D5-8043-07EE04DA571B@gmx.de>
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

Hi Heinrich,

On 6/2/25 23:23, Heinrich Schuchardt wrote:
> Am 21. Mai 2025 17:14:42 MESZ schrieb Jerome Forissier <jerome.forissier@linaro.org>:
>> Implement the sntp command when NET_LWIP=y.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>
>> cmd/Kconfig                |  13 ++--
>> cmd/net-lwip.c             |   5 ++
>> include/net-common.h       |  11 ++++
>> lib/lwip/Makefile          |   1 +
>> lib/lwip/u-boot/arch/cc.h  |   4 ++
>> lib/lwip/u-boot/lwipopts.h |   4 ++
>> net/lwip/Makefile          |   1 +
>> net/lwip/sntp.c            | 128 +++++++++++++++++++++++++++++++++++++
>> 8 files changed, 161 insertions(+), 6 deletions(-)
>> create mode 100644 net/lwip/sntp.c
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index f21d27cb27f..58f629e1c34 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -2061,12 +2061,6 @@ config CMD_CDP
>> 	  and to retrieve configuration data including the VLAN id using the
>> 	  proprietary Cisco Discovery Protocol (CDP).
>>
>> -config CMD_SNTP
>> -	bool "sntp"
>> -	select PROT_UDP
>> -	help
>> -	  Synchronize RTC via network
>> -
>> config CMD_LINK_LOCAL
>> 	bool "linklocal"
>> 	depends on (LIB_RAND || LIB_HW_RAND)
>> @@ -2144,6 +2138,13 @@ config CMD_PING
>> 	help
>> 	  Send ICMP ECHO_REQUEST to network host
>>
>> +config CMD_SNTP
> 
> The command should depend on RTC support.
> 
>> +	bool "sntp"
>> +	select PROT_UDP if NET
>> +	select PROT_UDP_LWIP if NET_LWIP
>> +	help
>> +	  Synchronize RTC via network
>> +
>> config CMD_TFTPBOOT
>> 	bool "tftp"
>> 	select PROT_UDP_LWIP if NET_LWIP
>> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
>> index cecf8d02555..2ffee64f97e 100644
>> --- a/cmd/net-lwip.c
>> +++ b/cmd/net-lwip.c
> 
> Please, put every command into a separate file instead of duplicating the #ifdef chaos of the old network stack.

While I agree that cmd/net.c is painful re. #ifdef's, I believe
cmd/net-lwip.c is not bad at all. In fact I took care of having only the
command wrappers in there (U_BOOT_CMD(...)), so it's just 55 lines at
the moment. The implementations are in
net/lwip/{dhcp,dns,ping,sntp,tftp,wget}.c. So I don't think there is
a need to change that. Or I could move the U_BOOT_CMD(...) into
net/lwip/*.c as well, leaving only the non-net commands under cmd/ (apart
from the legacy NET stuff).

Any opinions on that?


> 
>> @@ -21,6 +21,11 @@ U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
>> 	   "[loadAddress] [[hostIPaddr:]bootfilename]");
>> #endif
>>
>> +#if defined(CONFIG_CMD_SNTP)
>> +U_BOOT_CMD(sntp, 2, 1, do_sntp, "synchronize RTC via network",
>> +	   "[NTP server IP]");
>> +#endif
> 
> Why wouldn't we support server names ( e.g.  0.de.pool.ntp.org) here if we have DNS enabled?

Good idea. I will add support for server names to v2.

> 
> Please, add the missing documentation change for the commands.

Sure.

> Best regards
> 
> Heinrich
> 
> 
>> +
>> #if defined(CONFIG_CMD_DNS)
>> U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
>> 	   "hostname [envvar]");
>> diff --git a/include/net-common.h b/include/net-common.h
>> index a021bf503ff..b06cafb497e 100644
>> --- a/include/net-common.h
>> +++ b/include/net-common.h
>> @@ -505,6 +505,17 @@ int dhcp_run(ulong addr, const char *fname, bool autoload);
>>  */
>> int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>
>> +/**
>> + * do_sntp - Run the sntp command
>> + *
>> + * @cmdtp: Unused
>> + * @flag: Command flags (CMD_FLAG_...)
>> + * @argc: Number of arguments
>> + * @argv: List of arguments
>> + * Return: result (see enum command_ret_t)
>> + */
>> +int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>> +
>> /**
>>  * do_tftpb - Run the tftpboot command
>>  *
>> diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
>> index e9e8caee93a..c3f0e916f66 100644
>> --- a/lib/lwip/Makefile
>> +++ b/lib/lwip/Makefile
>> @@ -13,6 +13,7 @@ obj-y += \
>> 	lwip/src/api/sockets.o \
>> 	lwip/src/api/tcpip.o \
>> 	lwip/src/apps/http/http_client.o \
>> +	lwip/src/apps/sntp/sntp.o \
>> 	lwip/src/apps/tftp/tftp.o \
>> 	lwip/src/core/altcp_alloc.o \
>> 	lwip/src/core/altcp.o \
>> diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
>> index 6104c296f6f..f91127ac565 100644
>> --- a/lib/lwip/u-boot/arch/cc.h
>> +++ b/lib/lwip/u-boot/arch/cc.h
>> @@ -43,4 +43,8 @@
>> #define BYTE_ORDER BIG_ENDIAN
>> #endif
>>
>> +#define SNTP_STARTUP_DELAY 0
>> +void sntp_set_system_time(uint32_t sec);
>> +#define SNTP_SET_SYSTEM_TIME(sec) sntp_set_system_time(sec)
>> +
>> #endif /* LWIP_ARCH_CC_H */
>> diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
>> index edac74ff7a2..14ba7bd7ae2 100644
>> --- a/lib/lwip/u-boot/lwipopts.h
>> +++ b/lib/lwip/u-boot/lwipopts.h
>> @@ -162,4 +162,8 @@
>> #define LWIP_ALTCP_TLS_MBEDTLS          1
>> #endif
>>
>> +#if defined(CONFIG_CMD_SNTP)
>> +#define LWIP_DHCP_GET_NTP_SRV 1
>> +#endif
>> +
>> #endif /* LWIP_UBOOT_LWIPOPTS_H */
>> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>> index 5df222589b8..5bb98dc4d98 100644
>> --- a/net/lwip/Makefile
>> +++ b/net/lwip/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
>> obj-$(CONFIG_CMD_DHCP) += dhcp.o
>> obj-$(CONFIG_CMD_DNS) += dns.o
>> obj-$(CONFIG_CMD_PING) += ping.o
>> +obj-$(CONFIG_CMD_SNTP) += sntp.o
>> obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>> obj-$(CONFIG_WGET) += wget.o
>>
>> diff --git a/net/lwip/sntp.c b/net/lwip/sntp.c
>> new file mode 100644
>> index 00000000000..3b2bc3c679d
>> --- /dev/null
>> +++ b/net/lwip/sntp.c
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/* Copyright (C) 2025 Linaro Ltd. */
>> +
>> +#include <command.h>
>> +#include <console.h>
>> +#include <dm/device.h>
>> +#include <lwip/apps/sntp.h>
>> +#include <lwip/timeouts.h>
>> +#include <net.h>
>> +
>> +#define SNTP_TIMEOUT 10000
>> +
>> +static enum done_state {
>> +	NOT_DONE = 0,
>> +	SUCCESS,
>> +	ABORTED,
>> +	TIMED_OUT
>> +} sntp_state;
>> +
>> +static void no_response(void *arg)
>> +{
>> +	sntp_state = TIMED_OUT;
>> +}
>> +
>> +/* Called by lwIP via the SNTP_SET_SYSTEM_TIME() macro */
>> +void sntp_set_system_time(uint32_t seconds)
>> +{
>> +	char *toff;
>> +	int net_ntp_time_offset = 0;
>> +
>> +	toff = env_get("timeoffset");
>> +	if (toff)
>> +		net_ntp_time_offset = simple_strtol(toff, NULL, 10);
>> +
>> +	net_sntp_set_rtc(seconds + net_ntp_time_offset);
>> +	sntp_state = SUCCESS;
>> +}
>> +
>> +static bool ntp_server_known(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < SNTP_MAX_SERVERS; i++) {
>> +		const ip_addr_t *ip = sntp_getserver(i);
>> +
>> +		if (ip && ip->addr)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
>> +{
>> +	struct netif *netif;
>> +
>> +	netif = net_lwip_new_netif(udev);
>> +	if (!netif)
>> +		return -1;
>> +
>> +	sntp_state = NOT_DONE;
>> +
>> +	sntp_setoperatingmode(SNTP_OPMODE_POLL);
>> +	sntp_servermode_dhcp(CONFIG_IS_ENABLED(CMD_DHCP));
>> +	if (srvip) {
>> +		sntp_setserver(0, srvip);
>> +	} else {
>> +		if (!ntp_server_known()) {
>> +			log_err("error: ntpserverip not set\n");
>> +			return -1;
>> +		}
>> +	}
>> +	sntp_init();
>> +
>> +	sys_timeout(SNTP_TIMEOUT, no_response, NULL);
>> +	while (sntp_state == NOT_DONE) {
>> +		net_lwip_rx(udev, netif);
>> +		sys_check_timeouts();
>> +		if (ctrlc()) {
>> +			printf("\nAbort\n");
>> +			sntp_state = ABORTED;
>> +			break;
>> +		}
>> +	}
>> +	sys_untimeout(no_response, NULL);
>> +
>> +	sntp_stop();
>> +	net_lwip_remove_netif(netif);
>> +
>> +	if (sntp_state == SUCCESS)
>> +		return 0;
>> +
>> +	return -1;
>> +}
>> +
>> +int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> +{
>> +	ip_addr_t *srvip = NULL;
>> +	char *server_ip = NULL;
>> +	ip_addr_t ipaddr;
>> +
>> +	switch (argc) {
>> +	case 1:
>> +		server_ip = env_get("ntpserverip");
>> +		break;
>> +	case 2:
>> +		server_ip = argv[1];
>> +		break;
>> +	default:
>> +		return CMD_RET_USAGE;
>> +	}
>> +
>> +	if (server_ip) {
>> +		if (!ipaddr_aton(server_ip, &ipaddr)) {
>> +			log_err("error: ipaddr_aton\n");
>> +			return CMD_RET_FAILURE;
>> +		}
>> +		srvip = &ipaddr;
>> +	}
>> +
>> +	if (net_lwip_eth_start() < 0)
>> +		return CMD_RET_FAILURE;
>> +
>> +	if (sntp_loop(eth_get_dev(), srvip) < 0)
>> +		return CMD_RET_FAILURE;
>> +
>> +	return CMD_RET_SUCCESS;
>> +}
> 
