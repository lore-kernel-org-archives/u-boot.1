Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0045EC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 16:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB0D286EEE;
	Tue, 24 Oct 2023 18:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kQtogbDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26DA586F09; Tue, 24 Oct 2023 18:42:09 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 8796886F0D
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 18:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from [10.7.98.47] (unknown [167.220.26.47])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6260520B74C0;
 Tue, 24 Oct 2023 09:42:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6260520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1698165725;
 bh=V7rPopswHCJDZQ62zTedtmb2/aidnojwF7ETrUNIRfk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kQtogbDIPOHX8vTfZEhcUzu2Y52nvP0/9rpd0ipXM95Q+VqR+okuhM2UCAV2HAVU0
 Jl429u3lqjKa3f0Dj26SRDuVT8ERXtS4jsFngnc65knJEyLQRWcAbhMmi35ILmXNs3
 zgy++noOY8MgkVEkkQBYjtkTAMEithy5k5Zx1pWA=
Message-ID: <6ad8b33b-6b9b-400c-bb3d-89097ec6aa73@linux.microsoft.com>
Date: Tue, 24 Oct 2023 09:42:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net: bootp: BOOTP/DHCPv4 retransmission
 improvements
Content-Language: en-GB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-3-seanedmond@linux.microsoft.com>
 <5d6aba63-d050-4365-8a4d-9cd2b528e804@gmx.de>
From: Sean Edmond <seanedmond@linux.microsoft.com>
In-Reply-To: <5d6aba63-d050-4365-8a4d-9cd2b528e804@gmx.de>
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


On 2023-10-23 11:06 p.m., Heinrich Schuchardt wrote:
> On 10/24/23 02:21, seanedmond@linux.microsoft.com wrote:
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
>> retransmission backoff interval should maximize at 60 seconds. This
>
> %s/maximize at/be limited to/
>
>> patch allows the interval to be configurable using the environment
>> variable "bootpretransmitperiodmax"
>
> If there is an RFC defining the value, why do we need an environment
> variable?
>
The intention with this patch is to provide the option to satisfy RFC, 
while giving the option to preserve the existing behavior.  The 
retransmission timing parameters in u-boot have been the same for the 
last ~10 years, so I'm guessing some have gotten used to this behavior 
(even though it's not correct).

>>
>> The initial retranmission backoff period defaults to 250ms, which is
>> also too small for these scenarios with many clients.  This patch makes
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
>>   net/bootp.c | 56 ++++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 40 insertions(+), 16 deletions(-)
>>
>> diff --git a/net/bootp.c b/net/bootp.c
>> index 6800290963..bab17a9ceb 100644
>> --- a/net/bootp.c
>> +++ b/net/bootp.c
>> @@ -42,6 +42,17 @@
>>    */
>>   #define TIMEOUT_MS    ((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
>>
>> +/*
>> + * According to rfc951 : 7.2. Client Retransmission Strategy
>> + * "After the 'average' backoff reaches about 60 seconds, it should be
>> + * increased no further, but still randomized."
>> + *
>> + * U-Boot has saturated this backoff at 2 seconds for a long time.
>> + * To modify, set the environment variable "bootpretransmitperiodmax"
>> + */
>> +#define RETRANSMIT_PERIOD_MAX_MS    2000
>
> This does not match RFC 951. Please, why shouldn't we use the standard
> value by default?

You're right, better to use the standard value by default.

>
>> +#define RETRANSMIT_PERIOD_INIT_MS    250
>
> This constant should be described too.

Will add a description.

>
>> +
>>   #ifndef CFG_DHCP_MIN_EXT_LEN        /* minimal length of extension 
>> list */
>>   #define CFG_DHCP_MIN_EXT_LEN 64
>>   #endif
>> @@ -53,6 +64,7 @@
>>   u32        bootp_ids[CFG_BOOTP_ID_CACHE_SIZE];
>>   unsigned int    bootp_num_ids;
>>   int        bootp_try;
>> +u32        bootp_id;
>>   ulong        bootp_start;
>>   ulong        bootp_timeout;
>>   char net_nis_domain[32] = {0,}; /* Our NIS domain */
>> @@ -60,6 +72,7 @@ char net_hostname[32] = {0,}; /* Our hostname */
>>   char net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN] = {0,}; /* Our 
>> bootpath */
>>
>>   static ulong time_taken_max;
>> +static u32   retransmit_period_max_ms;
>>
>>   #if defined(CONFIG_CMD_DHCP)
>>   static dhcp_state_t dhcp_state = INIT;
>> @@ -414,8 +427,8 @@ static void bootp_timeout_handler(void)
>>           }
>>       } else {
>>           bootp_timeout *= 2;
>> -        if (bootp_timeout > 2000)
>> -            bootp_timeout = 2000;
>> +        if (bootp_timeout > retransmit_period_max_ms)
>> +            bootp_timeout = retransmit_period_max_ms;
>
> RFC 951 requires that the backoff time is randomized.
I'll can look into adding randomization to this as well.
>
> Best regards
>
> Heinrich
>
>> net_set_timeout_handler(bootp_timeout, bootp_timeout_handler);
>>           bootp_request();
>>       }
>> @@ -711,10 +724,14 @@ static int bootp_extended(u8 *e)
>>
>>   void bootp_reset(void)
>>   {
>> +    char *ep;  /* Environment pointer */
>> +
>>       bootp_num_ids = 0;
>>       bootp_try = 0;
>>       bootp_start = get_timer(0);
>> -    bootp_timeout = 250;
>> +
>> +    bootp_timeout = env_get_ulong("bootpretransmitperiodinit", 10, 
>> RETRANSMIT_PERIOD_INIT_MS);
>> +
>>   }
>>
>>   void bootp_request(void)
>> @@ -726,7 +743,6 @@ void bootp_request(void)
>>   #ifdef CONFIG_BOOTP_RANDOM_DELAY
>>       ulong rand_ms;
>>   #endif
>> -    u32 bootp_id;
>>       struct in_addr zero_ip;
>>       struct in_addr bcast_ip;
>>       char *ep;  /* Environment pointer */
>> @@ -742,6 +758,9 @@ void bootp_request(void)
>>       else
>>           time_taken_max = TIMEOUT_MS;
>>
>> +    retransmit_period_max_ms = 
>> env_get_ulong("bootpretransmitperiodmax", 10,
>> +                         RETRANSMIT_PERIOD_MAX_MS);
>> +
>>   #ifdef CONFIG_BOOTP_RANDOM_DELAY        /* Random BOOTP delay */
>>       if (bootp_try == 0)
>>           srand_mac();
>> @@ -801,18 +820,23 @@ void bootp_request(void)
>>       extlen = bootp_extended((u8 *)bp->bp_vend);
>>   #endif
>>
>> -    /*
>> -     *    Bootp ID is the lower 4 bytes of our ethernet address
>> -     *    plus the current time in ms.
>> -     */
>> -    bootp_id = ((u32)net_ethaddr[2] << 24)
>> -        | ((u32)net_ethaddr[3] << 16)
>> -        | ((u32)net_ethaddr[4] << 8)
>> -        | (u32)net_ethaddr[5];
>> -    bootp_id += get_timer(0);
>> -    bootp_id = htonl(bootp_id);
>> -    bootp_add_id(bootp_id);
>> -    net_copy_u32(&bp->bp_id, &bootp_id);
>> +    /* Only generate a new transaction ID for each new BOOTP request */
>> +    if (bootp_try == 1) {
>> +        /*
>> +         *    Bootp ID is the lower 4 bytes of our ethernet address
>> +         *    plus the current time in ms.
>> +         */
>> +        bootp_id = ((u32)net_ethaddr[2] << 24)
>> +            | ((u32)net_ethaddr[3] << 16)
>> +            | ((u32)net_ethaddr[4] << 8)
>> +            | (u32)net_ethaddr[5];
>> +        bootp_id += get_timer(0);
>> +        bootp_id = htonl(bootp_id);
>> +        bootp_add_id(bootp_id);
>> +        net_copy_u32(&bp->bp_id, &bootp_id);
>> +    } else {
>> +        net_copy_u32(&bp->bp_id, &bootp_id);
>> +    }
>>
>>       /*
>>        * Calculate proper packet lengths taking into account the
