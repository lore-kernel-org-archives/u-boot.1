Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D9AC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 12:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 595C388148;
	Thu, 28 Mar 2024 13:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711630439;
	bh=VJTvvrW+VHKij7LLgLKJCB1FQQfDFy7GqOpmBFrFXp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZyqNNpimc4IKNm8nZcc6D6Uy39InV0NfcqmQDQe9Z1DO8p8Uyflpzzmj/j34qVSuV
	 OWN8FApTJ9jmU2X9JAQblPkgv/lIwb06m6tcxWckSLgCWBYgrb6l6jhwxlUdZ06FsP
	 iOYkcX+0cpDn9cA1V2EYwxhtHREZJI1cE4PSKdyYXsvdMqpmqwQQ96dG/IXgxm966m
	 NppBRVsJ1/00mYfaKqJ8XnbEtGIrtcWnWwa+xWlDYF0e0dHF1M6iFcezEEDWWb6LuX
	 JVFsUkQVcT4F6xImBuxmvPXl0e5rtDT0Mm56019z+XtryN/hEOf8ZtpbQIdwLTtn3m
	 viOLXwnFn97VQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE3688158; Thu, 28 Mar 2024 13:53:57 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64AD087ED7
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V53Pr0xWXz9ssM;
 Thu, 28 Mar 2024 13:53:52 +0100 (CET)
Message-ID: <28b604bc-3dca-4742-9220-724d6613dd16@denx.de>
Date: Thu, 28 Mar 2024 13:53:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 05/18] arm: mvebu: turris_omnia: Implement
 getting board information from MCU
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-6-kabel@kernel.org>
 <aa285a06-7fcd-42b9-9a85-29608162e2c3@denx.de>
 <20240328121726.2a2f360f@dellmb>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240328121726.2a2f360f@dellmb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V53Pr0xWXz9ssM
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

On 3/28/24 12:17, Marek Behún wrote:
> On Thu, 28 Mar 2024 10:56:01 +0100
> Stefan Roese <sr@denx.de> wrote:
> 
>> On 3/27/24 17:23, Marek Behún wrote:
>>> Implement reading board serial number, first MAC address and board
>>> version from MCU. MCU supports board information if the FEAT_BOARD_INFO
>>> feature bit is set in MCU features.
>>>
>>> Prefer getting board information from MCU if supported, fallback to
>>> Atmel SHA chip.
>>>
>>> Signed-off-by: Marek Behún <kabel@kernel.org>
>>
>> Minor comment below. Other than this:
>>
>> Reviewed-by: Stefan Roese <sr@denx.de>
>>
>> Thanks,
>> Stefan
>>
>>> ---
>>>    board/CZ.NIC/turris_atsha_otp.c          | 27 +------
>>>    board/CZ.NIC/turris_omnia/Makefile       |  2 +-
>>>    board/CZ.NIC/turris_omnia/turris_omnia.c | 94 +++++++++++++++++++++++-
>>>    3 files changed, 93 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/board/CZ.NIC/turris_atsha_otp.c b/board/CZ.NIC/turris_atsha_otp.c
>>> index a29fe36231..85eebcdf18 100644
>>> --- a/board/CZ.NIC/turris_atsha_otp.c
>>> +++ b/board/CZ.NIC/turris_atsha_otp.c
>>> @@ -11,6 +11,7 @@
>>>    #include <atsha204a-i2c.h>
>>>    
>>>    #include "turris_atsha_otp.h"
>>> +#include "turris_common.h"
>>>    
>>>    #define TURRIS_ATSHA_OTP_VERSION	0
>>>    #define TURRIS_ATSHA_OTP_SERIAL		1
>>> @@ -32,26 +33,6 @@ static struct udevice *get_atsha204a_dev(void)
>>>    	return dev;
>>>    }
>>>    
>>> -static void increment_mac(u8 *mac)
>>> -{
>>> -	int i;
>>> -
>>> -	for (i = 5; i >= 3; i--) {
>>> -		mac[i] += 1;
>>> -		if (mac[i])
>>> -			break;
>>> -	}
>>> -}
>>> -
>>> -static void set_mac_if_invalid(int i, u8 *mac)
>>> -{
>>> -	u8 oldmac[6];
>>> -
>>> -	if (is_valid_ethaddr(mac) &&
>>> -	    !eth_env_get_enetaddr_by_index("eth", i, oldmac))
>>> -		eth_env_set_enetaddr_by_index("eth", i, mac);
>>> -}
>>> -
>>>    int turris_atsha_otp_init_mac_addresses(int first_idx)
>>>    {
>>>    	struct udevice *dev = get_atsha204a_dev();
>>> @@ -84,11 +65,7 @@ int turris_atsha_otp_init_mac_addresses(int first_idx)
>>>    	mac[4] = mac1[2];
>>>    	mac[5] = mac1[3];
>>>    
>>> -	set_mac_if_invalid((first_idx + 0) % 3, mac);
>>> -	increment_mac(mac);
>>> -	set_mac_if_invalid((first_idx + 1) % 3, mac);
>>> -	increment_mac(mac);
>>> -	set_mac_if_invalid((first_idx + 2) % 3, mac);
>>> +	turris_init_mac_addresses(first_idx, mac);
>>>    
>>>    	return 0;
>>>    }
>>> diff --git a/board/CZ.NIC/turris_omnia/Makefile b/board/CZ.NIC/turris_omnia/Makefile
>>> index dc39b44ae1..341378b4e5 100644
>>> --- a/board/CZ.NIC/turris_omnia/Makefile
>>> +++ b/board/CZ.NIC/turris_omnia/Makefile
>>> @@ -2,4 +2,4 @@
>>>    #
>>>    # Copyright (C) 2017 Marek Behún <kabel@kernel.org>
>>>    
>>> -obj-y	:= turris_omnia.o ../turris_atsha_otp.o
>>> +obj-y	:= turris_omnia.o ../turris_atsha_otp.o ../turris_common.o
>>> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
>>> index 6dfde5ee7a..f63640ad64 100644
>>> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
>>> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
>>> @@ -18,6 +18,7 @@
>>>    #include <asm/io.h>
>>>    #include <asm/arch/cpu.h>
>>>    #include <asm/arch/soc.h>
>>> +#include <asm/unaligned.h>
>>>    #include <dm/uclass.h>
>>>    #include <dt-bindings/gpio/gpio.h>
>>>    #include <fdt_support.h>
>>> @@ -25,12 +26,14 @@
>>>    #include <time.h>
>>>    #include <turris-omnia-mcu-interface.h>
>>>    #include <linux/bitops.h>
>>> +#include <linux/bitrev.h>
>>>    #include <linux/delay.h>
>>>    #include <u-boot/crc.h>
>>>    
>>>    #include "../drivers/ddr/marvell/a38x/ddr3_init.h"
>>>    #include <../serdes/a38x/high_speed_env_spec.h>
>>>    #include "../turris_atsha_otp.h"
>>> +#include "../turris_common.h"
>>>    
>>>    DECLARE_GLOBAL_DATA_PTR;
>>>    
>>> @@ -186,6 +189,70 @@ static bool omnia_mcu_has_feature(u32 feature)
>>>    	return feature & features;
>>>    }
>>>    
>>> +static u32 omnia_mcu_crc32(const void *p, size_t len)
>>> +{
>>> +	u32 val, crc = 0;
>>> +
>>> +	compiletime_assert(!(len % 4), "length has to be a multiple of 4");
>>> +
>>> +	while (len) {
>>> +		val = bitrev32(get_unaligned_le32(p));
>>> +		crc = crc32(crc, (void *)&val, 4);
>>> +		p += 4;
>>> +		len -= 4;
>>> +	}
>>> +
>>> +	return ~bitrev32(crc);
>>> +}
>>> +
>>> +/* Can only be called after relocation, since it needs cleared BSS */
>>> +static int omnia_mcu_board_info(char *serial, u8 *mac, char *version)
>>> +{
>>> +	static u8 reply[17];
>>> +	static bool cached;
>>> +
>>> +	if (!cached) {
>>> +		u8 csum;
>>> +		int ret;
>>> +
>>> +		ret = omnia_mcu_read(CMD_BOARD_INFO_GET, reply, sizeof(reply));
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		if (reply[0] != 16)
>>> +			return -EBADMSG;
>>> +
>>> +		csum = reply[16];
>>> +		reply[16] = 0;
>>> +
>>> +		if ((omnia_mcu_crc32(&reply[1], 16) & 0xff) != csum)
>>> +			return -EBADMSG;
>>> +
>>> +		cached = true;
>>> +	}
>>> +
>>> +	if (serial) {
>>> +		const char *serial_env;
>>> +
>>> +		serial_env = env_get("serial#");
>>> +		if (serial_env && strlen(serial_env) == 16) {
>>> +			strcpy(serial, serial_env);
>>
>> Usage of strcpy() is discouraged AFAIK.
> 
> Yeah, it would make sense to use strncpy, but the potential leak is
> prevented by strlen() check.

strncpy is also not optimal. Please see here if you are interested:

https://www.geeksforgeeks.org/why-strcpy-and-strncpy-are-not-safe-to-use/

AFAIU, there is no pressing need to change this implementation here
though right now. I just wanted to make this comment.

Thanks,
Stefan
