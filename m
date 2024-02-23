Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FDFC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 14:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7853387C56;
	Fri, 23 Feb 2024 15:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="TkSaTN3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74C38644E; Fri, 23 Feb 2024 15:08:34 +0100 (CET)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F3B875FA
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 15:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.orlov@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5n5cwCShIPK1itnX+oxum1sedS44QEzcOItuZTp8orI=; b=TkSaTN3MLYHJ2frHUgS26Q4Nm5
 UgQ7CHaTPY8ZV9yolfh3qQbBy4G/qhDpFRIP9QegpPukBbtbfaRxx3twQZNy8ZEMJNg5kQTFldSwo
 Oi1XmCbBF77YxdfgXTswU1C71dw4iLSvA7dAnLN3LPje2Osds0BA6COkFMlYp0hRCnsulGOthR4pd
 8HYsiO6PKgzIw3GK4Wc494sEI3Pizq3ejnWe8fUWkQ9LdRrk7gesm3ie7xsRTBnHyv/K+oa0RjQ+e
 66YxNbuP574xQdu30YDE2LXPwqAIAwivNZKZ84IMFR1jQAEJkQ3FXnyUKfJgEYmPVaYUVD7/zTUA2
 il740O2A==;
Received: from [167.98.27.226] (helo=[10.35.4.68])
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1rdWDb-005SvN-EW; Fri, 23 Feb 2024 14:08:03 +0000
Message-ID: <1053cf30-cebb-4b1c-a0e8-6abd6e0a6bbe@codethink.co.uk>
Date: Fri, 23 Feb 2024 14:08:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: eeprom: Fix config dependency
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240219181838.85391-1-ivan.orlov@codethink.co.uk>
 <20240222174638.GA2599242@bill-the-cat>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov@codethink.co.uk>
In-Reply-To: <20240222174638.GA2599242@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 22/02/2024 17:46, Tom Rini wrote:
> On Mon, Feb 19, 2024 at 06:18:38PM +0000, Ivan Orlov wrote:
> 
>> We should have CONFIG_DM_I2C or CONFIG_(SPL_)SYS_I2C_LEGACY enabled in
>> order for `cmd/eeprom.c` to compile as it depends on the i2c functions
>> which are not compiled otherwise. Update the Kconfig entry for the
>> 'eeprom' command correspondingly.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
>> ---
>>   cmd/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index a86b570517..6a1a64566c 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -740,6 +740,7 @@ config CRC32_VERIFY
>>   
>>   config CMD_EEPROM
>>   	bool "eeprom - EEPROM subsystem"
>> +	depends on DM_I2C || SYS_I2C_LEGACY || SPL_SYS_I2C_LEGACY
> 
> You cannot enable commands in SPL, so SPL_SYS_I2C_LEGACY doesn't make
> sense here.
> 

Ah, alright, I'll fix it and send the V2. Thank you for the review!
-- 
Kind regards,
Ivan Orlov

