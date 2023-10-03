Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A23E7545C
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 18:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5098720D;
	Tue,  3 Oct 2023 20:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YAXbmpOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCBA8721A; Tue,  3 Oct 2023 20:15:30 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 1865D87206
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 20:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from [10.7.98.35] (unknown [167.220.24.35])
 by linux.microsoft.com (Postfix) with ESMTPSA id CC13020B74C0;
 Tue,  3 Oct 2023 11:15:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC13020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1696356927;
 bh=84ocShFzljwoI2lH1Xuc1OT59valxfuQynbOpmXLTHU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YAXbmpOaZnfd1xzP85kUb6ksPF6hw1AphrPrShR3c4kXJi2ohbd0cHwSLE9/Q1fes
 p8QMtsQw/2Pnz+rTVun5421bBW5V5PD5kFAl2d9GNj40h4SZJD6VrKwb4vqHPAlHUf
 Xg6HXoPtHefkE+QOqiOfjSUJse6O0FFgZPC6bUh8=
Message-ID: <941b2fd4-77d0-109a-53ad-dd51f6250ddb@linux.microsoft.com>
Date: Tue, 3 Oct 2023 11:15:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: bootp: BOOTP/DHCPv4 retransmission improvements
Content-Language: en-GB
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
References: <20230925202935.118652-1-seanedmond@linux.microsoft.com>
 <20230925202935.118652-3-seanedmond@linux.microsoft.com>
 <20230927061125.3f1702a0@karo-electronics.de>
From: Sean Edmond <seanedmond@linux.microsoft.com>
In-Reply-To: <20230927061125.3f1702a0@karo-electronics.de>
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


On 2023-09-26 9:11 p.m., Lothar Waßmann wrote:
> Hi,
>
> On Mon, 25 Sep 2023 13:29:34 -0700 seanedmond@linux.microsoft.com wrote:
>> From: Sean Edmond <seanedmond@microsoft.com>
>>
>> This patch introduces 3 improvements to align with RFC 951:
>> - retransmission backoff interval maximum is configurable
>> - initial retranmission backoff interval is configurable
>> - transaction ID is kept the same for each BOOTP/DHCPv4 request
>>
>> In applications where thousands of nodes are serviced by a single DHCP
>> server, maximizing the retransmission backoff interval at 2 seconds (the
>> current u-boot default) exerts high pressure on the DHCP server and
>> network layer.
>>
>> RFC 951 “7.2. Client Retransmission Strategy” states that the
>> retransmission backoff interval should maximize at 60 seconds.  This
>> patch allows the interval to be configurable using the environment
>> variable "bootpretransmitperiodmax"
>>
>> The initial retranmission backoff period defaults to 250ms, which is
>> also too small for these scenarios with many clients.  This patch makes
>> the initial retransmission interval to be configurable using the
>> environment variable "bootpretransmitperiodinit".
>>
>> Also, on a retransmission it is not expected for the transaction ID to
>> change (only the 'secs' field should be updated). Let's save the
>> transaction ID and use the same transaction ID for each BOOTP/DHCPv4
>> exchange.
>>
>> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
>> ---
>>   net/bootp.c | 63 +++++++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 47 insertions(+), 16 deletions(-)
>>
>> diff --git a/net/bootp.c b/net/bootp.c
>> index 013d54c7ed..7248536cc4 100644
>> --- a/net/bootp.c
>> +++ b/net/bootp.c
>> @@ -42,6 +42,17 @@
>>    */
>>   #define TIMEOUT_MS	((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
>>   
>> +/*
>> + * According to rfc951 : 7.2. Client Retransmission Strategy
>> + * "After the 'average' backoff reaches about 60 seconds, it should be
>> + * increased no further, but still randomized."
>> + *
>> + * U-Boot has saturated this backoff at 2 seconds for a long time.
>> + * To modify, set the environment variable "bootpretransmitperiodmax"
>> + */
>> +#define RETRANSMIT_PERIOD_MAX_MS	2000
>> +#define RETRANSMIT_PERIOD_INIT_MS	250
>> +
>>   #define PORT_BOOTPS	67		/* BOOTP server UDP port */
>>   #define PORT_BOOTPC	68		/* BOOTP client UDP port */
>>   
>> @@ -56,6 +67,7 @@
>>   u32		bootp_ids[CFG_BOOTP_ID_CACHE_SIZE];
>>   unsigned int	bootp_num_ids;
>>   int		bootp_try;
>> +u32		bootp_id;
>>   ulong		bootp_start;
>>   ulong		bootp_timeout;
>>   char net_nis_domain[32] = {0,}; /* Our NIS domain */
>> @@ -63,6 +75,7 @@ char net_hostname[32] = {0,}; /* Our hostname */
>>   char net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN] = {0,}; /* Our bootpath */
>>   
>>   static ulong time_taken_max;
>> +static u32   retransmit_period_max_ms;
>>   
>>   #if defined(CONFIG_CMD_DHCP)
>>   static dhcp_state_t dhcp_state = INIT;
>> @@ -417,8 +430,8 @@ static void bootp_timeout_handler(void)
>>   		}
>>   	} else {
>>   		bootp_timeout *= 2;
>> -		if (bootp_timeout > 2000)
>> -			bootp_timeout = 2000;
>> +		if (bootp_timeout > retransmit_period_max_ms)
>> +			bootp_timeout = retransmit_period_max_ms;
>>   		net_set_timeout_handler(bootp_timeout, bootp_timeout_handler);
>>   		bootp_request();
>>   	}
>> @@ -714,10 +727,18 @@ static int bootp_extended(u8 *e)
>>   
>>   void bootp_reset(void)
>>   {
>> +	char *ep;  /* Environment pointer */
>> +
>>   	bootp_num_ids = 0;
>>   	bootp_try = 0;
>>   	bootp_start = get_timer(0);
>> -	bootp_timeout = 250;
>> +
>> +	ep = env_get("bootpretransmitperiodinit");
>> +	if (ep)
>> +		bootp_timeout = dectoul(ep, NULL);
>> +	else
>> +		bootp_timeout = RETRANSMIT_PERIOD_INIT_MS;
>> +
> bootp_timeout = env_get_ulong("bootpretransmitperiodinit", 0, RETRANSMIT_PERIOD_INIT_MS);
> does the same...
Thanks for the suggestion, will fix in v2.
>>   }
>>   
>>   void bootp_request(void)
>> @@ -729,7 +750,6 @@ void bootp_request(void)
>>   #ifdef CONFIG_BOOTP_RANDOM_DELAY
>>   	ulong rand_ms;
>>   #endif
>> -	u32 bootp_id;
>>   	struct in_addr zero_ip;
>>   	struct in_addr bcast_ip;
>>   	char *ep;  /* Environment pointer */
>> @@ -745,6 +765,12 @@ void bootp_request(void)
>>   	else
>>   		time_taken_max = TIMEOUT_MS;
>>   
>> +	ep = env_get("bootpretransmitperiodmax");
>> +	if (ep)
>> +		retransmit_period_max_ms = dectoul(ep, NULL);
>> +	else
>> +		retransmit_period_max_ms = RETRANSMIT_PERIOD_MAX_MS;
>> +
> see above
>
>
> Lothar Waßmann
