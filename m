Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34826D37E4E
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792CC80433;
	Wed, 14 Jan 2026 16:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="isnzVayX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F728063E; Wed, 14 Jan 2026 16:38:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8C880325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=eb2b=7U=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768405087;
 bh=7RkUTbzKwe/9sT2dTsjOYtNh/Bhc3y1UCnX53RdtDkg=;
 b=isnzVayXkvQmDOnGEh9f9+PGTvVhQFxmod9G3QMLqhY2Va3+H87lYLHr90ZW8TBhw4mXOJaaD
 dXwXEF+3Pl+TYH4PWJ4ptE5xrvx/OiXUeMXDsiMQVVMnhRsbO3ZfqWo8YzHXghs6hnfq3E2Z2FQ
 EQ9o1YaWIsRqEmSDsxs5eIyPJkcdvR93u2TicGGSfMfmTntFqCGW+FVfrUJY091MqOi2nUL6nMz
 E7IBrRN3FQUeX0zQiWAZgPbrDMry9fNSkxFoyQTtcsZbJL1tusQ/64RpoUS2R2vA6ItAMtdwJdP
 4dY1T2gHOlEyDSrEuxmP/BNd8SlKP7h9nMPxnRNg6vhw==
X-Forward-Email-ID: 6967b859f65b9ac90aaccbbe
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7f9d6ad3-afd2-4364-8d33-8510e183642c@kwiboo.se>
Date: Wed, 14 Jan 2026 16:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: add TFTPSERVERIP Kconfig option
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jerome Forissier <jerome@forissier.org>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260106203433.3133926-1-jonas@kwiboo.se>
 <7d2ac045-d364-4d37-b654-aa704cc07a7b@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7d2ac045-d364-4d37-b654-aa704cc07a7b@cherry.de>
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

Hi Quentin,

On 1/14/2026 4:01 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/6/26 9:34 PM, Jonas Karlman wrote:
>> With the legacy networking stack, it is possible to use USE_SERVERIP,
>> SERVERIP and BOOTP_PREFER_SERVERIP Kconfg options to force use of a
>> specific TFTP server ip.
>>
>> Using the lwIP networking stack use of the 'tftpserverip' environment
>> variable provide the closest equivalent functionality.
>>
> 
> It does read serverip environment variable if it's set, so this should 
> match the behavior with the legacy network stack no?

This is what I first thought, however it seem that the lwip stack differ
slightly from the legacy stack, in that the dhcp lookup always seem to
reset the serverip env var.

> As for BOOTP_PREFER_SERVERIP, this would need to be implemented in lwip 
> and isn't covered by this new variable is it?

For the lwip stack it looks like the BOOTP_PREFER_SERVERIP Kconfig
option possible was replaced with use of a 'tftpserverip' env var.

For legacy stack I had something like following in a .config fragment:

  CONFIG_BOOTP_PREFER_SERVERIP=y
  CONFIG_SERVERIP="192.168.2.50"
  CONFIG_USE_SERVERIP=y

Adding NET_LWIP=y made pxe booting stop working and 'serverip' always
ended up as the dhpc server regardless if it was set to something else.

Since lwip instead prioritize the 'tftpserverip' env over the 'serverip'
env for tftp use, adding a similar env var Kconfig option was easy but
may be wrong path?

> 
> This patch is fine, I'm just challenging the justification in the commit 
> log.
> 
>> Add USE_TFTPSERVERIP and TFTPSERVERIP Kconfig options that can be used
>> to add the 'tftpserverip' environment variable to force use of a
>> specific TFTP server ip.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   include/env_default.h |  3 +++
>>   net/lwip/Kconfig      | 12 ++++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/include/env_default.h b/include/env_default.h
>> index 7f8dc1c35a74..014873e304d8 100644
>> --- a/include/env_default.h
>> +++ b/include/env_default.h
>> @@ -58,6 +58,9 @@ const char default_environment[] = {
>>   #ifdef	CONFIG_USE_SERVERIP
>>   	"serverip="	CONFIG_SERVERIP			"\0"
>>   #endif
>> +#ifdef	CONFIG_USE_TFTPSERVERIP
>> +	"tftpserverip="	CONFIG_TFTPSERVERIP		"\0"
>> +#endif
>>   #ifdef	CONFIG_SYS_DISABLE_AUTOLOAD
>>   	"autoload=0\0"
>>   #endif
>> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
>> index 5789766fe624..0cfd3eb2684f 100644
>> --- a/net/lwip/Kconfig
>> +++ b/net/lwip/Kconfig
>> @@ -72,4 +72,16 @@ config LWIP_TCP_WND
>>   	  but QEMU with "-net user" needs no more than a few KB or the
>>   	  transfer will stall and eventually time out.
>>   
>> +config USE_TFTPSERVERIP
>> +	bool "Set a default 'tftpserverip' value in the environment"
>> +	depends on CMD_TFTPBOOT
>> +	help
>> +	  Defines a default value for the IP address of a TFTP server to
>> +	  contact when using the "tftpboot" command.  (Environment variable
>> +	  "tftpserverip")
>> +
> 
> Does it support IPv4 *and*/or IPv6?

Not sure, I have only tested IPv4, guess IPv6 probably should work, the
'tftpserverip' var should work with same formats that the 'serverip' var
currently support.

This help text is mostly just a c/p from the USE_SERVERIP Kconfig option,
let me know if you think this should be changed.

Regards,
Jonas

> 
> Cheers,
> Quentin

