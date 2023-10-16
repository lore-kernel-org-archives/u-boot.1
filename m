Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6381DCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E124486EDD;
	Mon, 16 Oct 2023 16:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697467465;
	bh=l1ZhPzJwEl700OWC+T3HCWlUjMXgrKJ0d5UArN/MIC0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NiDndh6ezIT5L0fyG2EW+z+uhxmS7ele/n3Hn3YtEsBTtuACoUGpz0S6qFpJ3iMxO
	 HIVJc9uCNhEM+p4ktmqOan9E+HqbosKKYa2kR1sXVxujYIOg6N8ruRkeUssSvW30Az
	 hKh236WfxfqCf6Urnny2nUvG2l6NBbemt//UEoGJI+E/qpCd0aMz5+DdQeNNbjHuTc
	 3yEI+5xnLzZYVJGxvjThyfjieP6aCR09PeSalIVDcsMKMHjA4MySy9ffpJL3VhOqWw
	 AKAeia7nm4pbRCU3sBHhBoZ++pvScT2AHhZ2y+IfHxbzPWeMaqMRV5fSQ+cCFfu6aZ
	 Ntla5dqWvSGUA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF18D86F16; Mon, 16 Oct 2023 16:44:24 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 039C186EFB
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S8Kcy404Cz9sW7;
 Mon, 16 Oct 2023 16:44:18 +0200 (CEST)
Message-ID: <a58f7c4a-1074-4d42-b1e5-9f8e22adda2e@denx.de>
Date: Mon, 16 Oct 2023 16:44:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: Enable bootstd for Thecus N2350 board
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20231007220814.30783-1-mibodhi@gmail.com>
 <1e0e0b8a-eae0-43c9-b150-3ba911971645@denx.de>
In-Reply-To: <1e0e0b8a-eae0-43c9-b150-3ba911971645@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S8Kcy404Cz9sW7
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
> On 10/8/23 00:08, Tony Dinh wrote:
>> Enable bootstd for Thecus N2350 board, and remove distroboot.
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
>>   configs/n2350_defconfig |  3 ++-
>>   include/configs/n2350.h | 12 +-----------
>>   2 files changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/configs/n2350_defconfig b/configs/n2350_defconfig
>> index 109f0e10e9..07135742d3 100644
>> --- a/configs/n2350_defconfig
>> +++ b/configs/n2350_defconfig
>> @@ -29,7 +29,8 @@ CONFIG_ENV_ADDR=0x100000
>>   CONFIG_PCI=y
>>   CONFIG_DEBUG_UART=y
>>   CONFIG_AHCI=y
>> -CONFIG_DISTRO_DEFAULTS=y
>> +CONFIG_BOOTSTD_FULL=y
>> +CONFIG_BOOTSTD_DEFAULTS=y
>>   CONFIG_BOOTDELAY=10
>>   CONFIG_USE_PREBOOT=y
>>   CONFIG_SYS_CONSOLE_INFO_QUIET=y
>> diff --git a/include/configs/n2350.h b/include/configs/n2350.h
>> index 92b2270236..d8a9814d3e 100644
>> --- a/include/configs/n2350.h
>> +++ b/include/configs/n2350.h
>> @@ -20,15 +20,8 @@
>>    */
>>   #include "mv-common.h"
>> -/* Include the common distro boot environment */
>>   #ifndef CONFIG_SPL_BUILD
>> -#define BOOT_TARGET_DEVICES(func) \
>> -    func(SCSI, scsi, 0) \
>> -    func(USB, usb, 0) \
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
