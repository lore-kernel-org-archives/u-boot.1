Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36210CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 13:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960E3836AC;
	Wed, 13 May 2026 15:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="otkfyFol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7604A838BB; Wed, 13 May 2026 15:56:53 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F19D8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 15:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso6153546a34.1
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778680607; x=1779285407;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ye3aeRvrjQzXxO6Tt2+slms76y1Ge2VpvySYBSf4bH4=;
 b=otkfyFolO+3y2suvZNEWQzb2uQ57HPxty/EkBN2PSWqUb8u0t+gNXCoz8fGTNtaG2d
 M7w56bViBSgbi3SQziVJiA1cdU5rOwsf1Piso0o0s2iDcotJpWOK7EA1rcp/pXTcWqWm
 P06Z1syzL+Wnt3+xV3S8hGwkxReH73JkYo15FgMvLuq22xGYp+4tbjPKFJnxcU27w8iQ
 1hnSjXknW24u3xMtzcINCQHNbCGW/gNbd7XQJ7QyU9fZtK7KJOERyDXvtIQ4liUXYNFR
 WGlM5MlqvN40cTUtVizbuAFo3nlWT2sHJ7UgfnbU6Y70HPflEZ5rbYclLwOwWQv6ZiNK
 E7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778680607; x=1779285407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ye3aeRvrjQzXxO6Tt2+slms76y1Ge2VpvySYBSf4bH4=;
 b=g8FsxGTF0DtODzmTWACLKKb3u8gLNq0P2AiekJIEKeGeqvi+YtMxbyBhqALelGO29M
 rluHwr8IXIaCyv6MmQ0IOuBnY6/z3DKS3aMzIq1PWFUa4hJClkuDbnWySH7qJu8ADRTC
 1PUP/1bJ5gNz/bHmhpPMOqVGtMgmVzEPnhO4UFTII0d0PI1fxvhT0IZRvoXVstI8Qy9G
 GpX0c7VBT0vDH13W9UDMaws1jvFAAyuhGVbSDhf/LH4FYAToDg824OM0Ofz/YzIqL3Vt
 8VZHBilZk1oGUbBLp1qRLNb6TvtoIfrLRPtO+KLNOEZJOplOfBpMpg0gKC1todsuIYxb
 jaDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gMSSKDEhXDlf79QRDHu6SWA2XezNRxdSCTYlc1ZOdlqFdpsOp36nk7mVl3lek5St/xtjcO7o=@lists.denx.de
X-Gm-Message-State: AOJu0YxTOmMuMFYhp10orBunCkWA+VY0EmbChV9JUotp/qn/EEPiLYe+
 hjoPr6euTBUGmwCHJQMK6ZACelCvoCjHcUxKIGyuf3H/T5cyjpz1UN49iAC3nSCJRh1WokuyckR
 trWAX
X-Gm-Gg: Acq92OEylHcyiwsH9VclmgjAxT9WFr0ahrE5a4zJYlmpEP5DlREICDJdKAwXt5t0cOp
 zGc95GsRI4fnWmepo3acN9nFIq+W7yHWFu52q1bm30QrIk9E5tg419QrV5SUm7pSIsyPEEtonHO
 zgmV8xkfhgqlb8++9kC1TPp3ORQzCcGaczDuSwOqWyAGZSejJSJnHiT5Gpe1K3ytaUHbz8hBDJ7
 nsNo6NQYBFzdX6Am8mYomTPw9omZN5sH67xxRtfDbMRuyUgfSyGodPw+5rxUKhv6sw6MZlKtmYR
 +rC4kpfxlFaags3zbDc13uMaon3sW5IqlFr7Q+ZL2nMYKeza1Br4LVc7BwrIvOvW2ItpdxmS3i4
 /HHQ2p6+lQskAFA9wYkNRkQ4Bo0ab+X9Pc8D5dOfrfJPnOx5uXlNjslK3ufjQFmk0JcUY1ZU1eZ
 ZGxSfcHVn7HyGPjbaMJ9uaM37psPiQlapqkQ0W6i0LYQ4SLeJkG2iCBWfZM9vVCFXzvVDjL0i+q
 XTmiApG+JkS
X-Received: by 2002:a05:6830:1d9b:b0:7db:a297:9e62 with SMTP id
 46e09a7af769-7e3bd12278bmr3554429a34.8.1778680606750; 
 Wed, 13 May 2026 06:56:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:597d:f2e2:6bf1:a5e9?
 ([2600:8803:e7e4:500:597d:f2e2:6bf1:a5e9])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8ffb7sm11138508a34.22.2026.05.13.06.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 06:56:46 -0700 (PDT)
Message-ID: <1c5c5a08-403a-4846-b0fa-96319805f4fa@baylibre.com>
Date: Wed, 13 May 2026 08:56:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net: lwip: introduce net_lwip_eth_stop() function
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, nd@arm.com
References: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
 <20260512-net-lwip-add-stop-function-v2-3-85146da317dd@baylibre.com>
 <3260fdac-8c9f-4eed-a23d-b70865e54381@arm.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3260fdac-8c9f-4eed-a23d-b70865e54381@arm.com>
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

On 5/13/26 2:57 AM, Jerome Forissier wrote:
> 
> 
> On 12/05/2026 23:48, David Lechner wrote:
>> Add a introduce net_lwip_eth_stop() function and use that to stop the
>> network interface after each command that uses the network.
>>
>> This makes the behavior the same as the legacy net code and avoids
>> potential issues with the network interface being left in an active
>> state after a command finishes.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  cmd/lwip/ping.c     | 10 ++++++++--
>>  cmd/lwip/sntp.c     | 10 ++++++++--
>>  include/net-lwip.h  |  1 +
>>  net/lwip/dhcp.c     | 15 +++++++++++----
>>  net/lwip/dns.c      |  7 ++++++-
>>  net/lwip/net-lwip.c |  5 +++++
>>  net/lwip/nfs.c      |  4 ++++
>>  net/lwip/tftp.c     |  4 ++++
>>  net/lwip/wget.c     |  5 ++++-
>>  9 files changed, 51 insertions(+), 10 deletions(-)
>>
>> diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
>> index fc4cf7bde5f..836d1d8287f 100644
>> --- a/cmd/lwip/ping.c
>> +++ b/cmd/lwip/ping.c
>> @@ -163,6 +163,7 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
>>  int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  {
>>  	ip_addr_t addr;
>> +	int ret = CMD_RET_FAILURE;
>>  
>>  	if (argc < 2)
>>  		return CMD_RET_USAGE;
>> @@ -176,8 +177,13 @@ restart:
>>  		if (net_start_again() == 0)
>>  			goto restart;
>>  		else
>> -			return CMD_RET_FAILURE;
>> +			goto out;
>>  	}
>>  
>> -	return CMD_RET_SUCCESS;
>> +	ret = CMD_RET_SUCCESS;
>> +
>> +out:
>> +	net_lwip_eth_stop();
>> +
>> +	return ret;
>>  }
>> diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
>> index 608345c873b..5fa400b104a 100644
>> --- a/cmd/lwip/sntp.c
>> +++ b/cmd/lwip/sntp.c
>> @@ -101,6 +101,7 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  	ip_addr_t *srvip;
>>  	char *server;
>>  	ip_addr_t ipaddr;
>> +	int ret = CMD_RET_FAILURE;
>>  
>>  	switch (argc) {
>>  	case 1:
>> @@ -127,7 +128,12 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  		return CMD_RET_FAILURE;
>>  
>>  	if (sntp_loop(eth_get_dev(), srvip) < 0)
>> -		return CMD_RET_FAILURE;
>> +		goto out;
>> +
>> +	ret = CMD_RET_SUCCESS;
>> +
>> +out:
>> +	net_lwip_eth_stop();
>>  
>> -	return CMD_RET_SUCCESS;
>> +	return ret;
>>  }
>> diff --git a/include/net-lwip.h b/include/net-lwip.h
>> index 20cb0992cce..5d0627eb271 100644
>> --- a/include/net-lwip.h
>> +++ b/include/net-lwip.h
>> @@ -35,6 +35,7 @@ int eth_init_state_only(void); /* Set active state */
>>  
>>  int net_lwip_dns_init(void);
>>  int net_lwip_eth_start(void);
>> +void net_lwip_eth_stop(void);
>>  struct netif *net_lwip_new_netif(struct udevice *udev);
>>  struct netif *net_lwip_new_netif_noip(struct udevice *udev);
>>  void net_lwip_remove_netif(struct netif *netif);
>> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
>> index acdf601d7eb..18dc36ae7ca 100644
>> --- a/net/lwip/dhcp.c
>> +++ b/net/lwip/dhcp.c
>> @@ -138,18 +138,25 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  	dev = eth_get_dev();
>>  	if (!dev) {
>>  		log_err("No network device\n");
>> -		return CMD_RET_FAILURE;
>> +		ret = CMD_RET_FAILURE;
>> +		goto out;
>>  	}
>>  
>>  	ret = dhcp_loop(dev);
>>  	if (ret)
>> -		return ret;
>> +		goto out;
>>  
>>  	if (argc > 1) {
>>  		struct cmd_tbl cmdtp = {};
>>  
>> -		return do_tftpb(&cmdtp, 0, argc, argv);
>> +		ret = do_tftpb(&cmdtp, 0, argc, argv);
>> +		goto out;
> 
> do_tftpb() already takes care of net_lwip_eth_stop() so this should
> probably be:
> 
> +		return do_tftpb(&cmdtp, 0, argc, argv);
> 
> But this also raises the qestion of the double call to
> net_lwip_eth_start():
> 
> do_dhcp()
> 	net_lwip_eth_start()
>  	do_tftpb()
> 		net_lwip_eth_start()
> 
> How about adding a static counter to better deal with the nested case?
> 
> static int net_lwip_eth_started;
> 
> int net_lwip_eth_start(void)
> {
> 	int ret;
> 
> 	if (net_lwip_eth_started++ > 0)
> 		return 0;
> 
> 	ret = eth_init();
> 	if (ret) {
> 		net_lwip_eth_started--;
> 		return ret;
> 	}
> 
> 	return 0;
> }
> 
> void net_lwip_eth_stop(void)
> {
> 	if (!net_lwip_eth_started)
> 		return;
> 
> 	if (--net_lwip_eth_started)
> 		return;
> 
> 	eth_halt();
> }
> 
> Thanks,

Yes, I like this idea. There is also an odd case in do_ping() that
we will need to look at though. It currently would not work with
reference counting since net_lwip_eth_start() can be called multiple
times on retries.



