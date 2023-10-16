Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D4CCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 959CD86EDB;
	Mon, 16 Oct 2023 16:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697467443;
	bh=0v80lfBjSiST6WnkoCNiN8dRPNNaCq8M8YfemmoBjCk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G85sYBZsKPV8F96okX0isx6v7z8oQulzAm1H2CNsKkINItnum+WilqCDbFdfDzqf/
	 lFYXZKkTWL44k2DfKtT1zOL90vT9/piZ5yJ2+IEuoHBc1cVm4SiQlr9X4uFZVNKFeV
	 N/9WvRY2QzFRTxtlSxm4uC5OGFENQDV6o2UKsA/sBXYN15gfqgyhHUA+OWWvJNChsd
	 n/e4LKJ5U54FUMWGklE/15Wy1gTcqDzPRaQCRdvitLeap6vn9C9xiKh/fSCHCGCANn
	 ayKk0lGfd5J3pzqJWb8zkl6uDy6gwbh9Fry3zGZgNIh5RRDBRf/J5znNqCBxHRopYB
	 dLTteJtIw4oqQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5637386E64; Mon, 16 Oct 2023 16:44:01 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C44A86B71
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4S8KcY3v7Cz9sZt;
 Mon, 16 Oct 2023 16:43:57 +0200 (CEST)
Message-ID: <8e17601b-61b8-4680-bca4-14c784882f36@denx.de>
Date: Mon, 16 Oct 2023 16:43:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: Enable bootstd for Synology DS116 board
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20231007213548.20276-1-mibodhi@gmail.com>
 <2d6f7df3-481a-4c95-99d0-0337c48675e5@denx.de>
In-Reply-To: <2d6f7df3-481a-4c95-99d0-0337c48675e5@denx.de>
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

On 10/16/23 10:31, Stefan Roese wrote:
> On 10/7/23 23:35, Tony Dinh wrote:
>> Enable bootstd for Synology DS116 board, and remove distroboot.
>>
>> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-marvell/master

Thanks,
Stefan


> Thanks,
> Stefan
> 
>> ---
>>
>>   configs/ds116_defconfig |  3 ++-
>>   include/configs/ds116.h | 12 +-----------
>>   2 files changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
>> index 0cd546c223..2437be73cd 100644
>> --- a/configs/ds116_defconfig
>> +++ b/configs/ds116_defconfig
>> @@ -28,7 +28,8 @@ CONFIG_SYS_LOAD_ADDR=0x800000
>>   CONFIG_PCI=y
>>   CONFIG_DEBUG_UART=y
>>   CONFIG_AHCI=y
>> -CONFIG_DISTRO_DEFAULTS=y
>> +CONFIG_BOOTSTD_FULL=y
>> +CONFIG_BOOTSTD_DEFAULTS=y
>>   CONFIG_BOOTDELAY=10
>>   CONFIG_USE_PREBOOT=y
>>   CONFIG_SYS_CONSOLE_INFO_QUIET=y
>> diff --git a/include/configs/ds116.h b/include/configs/ds116.h
>> index 031f4f6afc..0883ec4d53 100644
>> --- a/include/configs/ds116.h
>> +++ b/include/configs/ds116.h
>> @@ -20,15 +20,8 @@
>>    */
>>   #include "mv-common.h"
>> -/* Include the common distro boot environment */
>>   #ifndef CONFIG_SPL_BUILD
>> -#define BOOT_TARGET_DEVICES(func) \
>> -    func(USB, usb, 0) \
>> -    func(SCSI, scsi, 0) \
>> -    func(PXE, pxe, na) \
>> -    func(DHCP, dhcp, na)
>> -
>>   #define KERNEL_ADDR_R    __stringify(0x1000000)
>>   #define FDT_ADDR_R    __stringify(0x2000000)
>>   #define RAMDISK_ADDR_R    __stringify(0x2200000)
>> @@ -42,14 +35,11 @@
>>       "scriptaddr=" SCRIPT_ADDR_R "\0" \
>>       "pxefile_addr_r=" PXEFILE_ADDR_R "\0"
>> -#include <config_distro_bootcmd.h>
>> -
>>   #define CFG_EXTRA_ENV_SETTINGS \
>>       RELOCATION_LIMITS_ENV_SETTINGS \
>>       LOAD_ADDRESS_ENV_SETTINGS \
>>       "fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
>> -    "console=ttyS0,115200\0" \
>> -    BOOTENV
>> +    "console=ttyS0,115200\0"
>>   #endif /* CONFIG_SPL_BUILD */
> 
> Viele Grüße,
> Stefan Roese
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
