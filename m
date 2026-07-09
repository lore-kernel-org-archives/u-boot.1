Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F33C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 07:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A3384AA3;
	Thu,  9 Jul 2026 09:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LEflRT+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E93D84AC5; Thu,  9 Jul 2026 09:27:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EE384A51
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 09:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783582031;
 bh=N9RzBaIBVnJOBTvgFtJ9wSMh2jVF44Uiq4PJxKClYg4=;
 b=LEflRT+PeAbito5WLt/leu1EJhagmTUSCgZ+hbm/iHxWeadvO2jxdN3aJcMd9XPCtH7i5xdfF
 FIwlMwkLBvvhs75a1cqo8j2vtlpRtq88UNao/j5v82kLOzc9wdoWPFtTQkX7cLd8XnbspWaHMcR
 ZHIf+vYvQ9a25u62oT9yu8eMTzTj0WJXjNR+Zren3357K6psoxFXPJJ1fqZZ8CsAkLaX6phJpQa
 6w7TTeABijpDJ9WgH6uxEeGEVSXvnKSb3bshN3fZqx9+RdpZDieojT1y4yNDLA+hbApgrIPtA/x
 ITpq2rYrMVPrCSO6afQ+Zpx/6nbs1m4x42+TziSzehEA==
X-Forward-Email-ID: 6a4f4d4c40f9cb1df244a275
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c43c2a98-b6aa-46da-a74d-0601287534c2@kwiboo.se>
Date: Thu, 9 Jul 2026 09:27:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] Kconfig: serial: Depend on correct xPL symbol
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-10-jonas@kwiboo.se>
 <20260709015300.GT749385@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260709015300.GT749385@bill-the-cat>
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

Hi Tom,

On 7/9/2026 3:53 AM, Tom Rini wrote:
> On Wed, Jul 08, 2026 at 10:05:35PM +0000, Jonas Karlman wrote:
> 
>> Change xPL_SERIAL_PRESENT symbols to depend on the xPL_DM_SERIAL symbol
>> intended for the related xPL phase instead of the DM_SERIAL symbol
>> used for U-Boot proper to make CONFIG_IS_ENABLED(SERIAL_PRESENT) guards
>> work as intended.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/serial/Kconfig | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index e221800d5d06..f125061fe184 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -71,7 +71,7 @@ config SERIAL_PRESENT
>>  
>>  config SPL_SERIAL_PRESENT
>>  	bool "Provide a serial driver in SPL"
>> -	depends on DM_SERIAL && SPL
>> +	depends on SPL_DM_SERIAL
>>  	default y
>>  	help
>>  	  In very space-constrained devices even the full UART driver is too
> 
> Using the database option to qconfig.py, this is not equivalent. There's
> 901 platforms today that enable SPL_SERIAL_PRESENT, and 344 that enable
> SPL_SERIAL_PRESENT but not SPL_DM_SERIAL. Now it's possible that there's
> no functional change here. Something like "pinetab" would be a single
> platform to check the size changes on as it's SPL_SERIAL_PRESENT=y and
> SPL_DM_SERIAL=n.
> 

This discrepancy is likely due to the 'default y' and the strange
'depend on', based on my observation xPL_SERIAL_PRESENT is mostly used
to guard U_BOOT_DRIVER() and other DM related functions, so I do not
expect any functional change after these changes.

Also did quick build tests of pinetab_defconfig and there was no binary
change to spl/ before or after this series.

Regards,
Jonas
