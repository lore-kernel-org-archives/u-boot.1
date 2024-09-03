Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1CECD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 09:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11DC88C3A;
	Tue,  3 Sep 2024 11:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725355826;
	bh=mjBMx7KVbe2oPOE3pMDGx71MILPUcjTaOv8iQIsYuTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KCzDx8TRiSIjXI+PBcByS75mkE5nmtqNEp3ZbU/c/1Hu1jp/xSWTkpio4tFtB7fG4
	 te6jIL+ddEzJNINHXBA6ixBMiOTEj4Wsip/cm1/ULgh85CZcd+0rkBRzVhVV/dv3g/
	 AvbYMZQNBI9kOAXqNI6fQU5HZme+2+e4LFEm0n7nnFHRcYeuI2wz1Xjq77Kc97Ozje
	 DHkLVP4zYAgQsBMdbxuJAjl3WWi08Obj8PD9ZCICRIJvho5Ql0x0q35yJbHlxcWzFO
	 0d7oDKdgVwJwmR69Uk3JXFTI1hh71H6WaYDMOal0ktPPypni0N0pRw6oQpSL+KvxOW
	 tzYJ5MS3zqDmA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C94D288C36; Tue,  3 Sep 2024 11:30:24 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D13BD88B47
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 11:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4WygMc4sS3z9sgx;
 Tue,  3 Sep 2024 11:30:20 +0200 (CEST)
Message-ID: <097a526a-0a8e-4a29-87f9-ce24ee97c400@denx.de>
Date: Tue, 3 Sep 2024 11:30:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-marvell 2/3] arm: mvebu: turris_omnia: Use the
 i2c_eeprom misc driver for EEPROM reading in U-Boot proper
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240829080849.20276-1-kabel@kernel.org>
 <20240829080849.20276-3-kabel@kernel.org>
 <acfd0636-8132-4fa7-91e6-af78a6fdbeec@denx.de>
 <auikzq2r2eprb5u4hh4m6jgqsb3mzz3gznxcp6soldhu474r33@zryqeni47zju>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <auikzq2r2eprb5u4hh4m6jgqsb3mzz3gznxcp6soldhu474r33@zryqeni47zju>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WygMc4sS3z9sgx
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

On 9/3/24 10:04, Marek Behún wrote:
> On Tue, Sep 03, 2024 at 08:57:24AM +0200, Stefan Roese wrote:
>> On 8/29/24 10:08, Marek Behún wrote:
>>> Use the i2c_eeprom miscellaneous driver for reading Turris Omnia EEPROM
>>> in U-Boot proper. Keep using dm_i2c_read() in SPL build, since adding
>>> the i2c_eeprom driver to SPL build increases the image by 1.5 KiB.
>>>
>>> Signed-off-by: Marek Behún <kabel@kernel.org>
>>> ---
>>>    arch/arm/mach-mvebu/Kconfig              | 1 +
>>>    board/CZ.NIC/turris_omnia/turris_omnia.c | 9 +++++++--
>>>    configs/turris_omnia_defconfig           | 1 -
>>>    3 files changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
>>> index 4a8328760eb..c1a1a333e6c 100644
>>> --- a/arch/arm/mach-mvebu/Kconfig
>>> +++ b/arch/arm/mach-mvebu/Kconfig
>>> @@ -149,6 +149,7 @@ config TARGET_TURRIS_OMNIA
>>>    	select SPL_SYS_MALLOC_SIMPLE
>>>    	select SYS_I2C_MVTWSI
>>>    	select ATSHA204A
>>> +	select I2C_EEPROM
>>>    	select ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING
>>>    config TARGET_TURRIS_MOX
>>> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
>>> index 392df53a6d8..46f20f05c05 100644
>>> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
>>> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
>>> @@ -23,6 +23,7 @@
>>>    #include <dt-bindings/gpio/gpio.h>
>>>    #include <fdt_support.h>
>>>    #include <hexdump.h>
>>> +#include <i2c_eeprom.h>
>>>    #include <time.h>
>>>    #include <turris-omnia-mcu-interface.h>
>>>    #include <linux/bitops.h>
>>> @@ -473,9 +474,13 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
>>>    	if (!eeprom)
>>>    		return false;
>>> -	ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
>>> +	if (IS_ENABLED(CONFIG_SPL_BUILD))
>>> +		ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
>>> +	else
>>> +		ret = i2c_eeprom_read(eeprom, 0, (void *)oep, sizeof(*oep));
>>
>> So whats the advantage using i2c_eeprom_read() here in U-Boot proper?
>> The only thing that stands out to me is that the code get more complex
>> because of the SPL/non-SPL distinction.
> 
> The reasons are as follows:
> - it's "more correct" semantically
> 
> - the i2c_eeprom driver was already enabled for U-Boot proper in
>    defconfig (with this commit selected by the board), because of the
>    `eeprom` commmand, so I thought "why not use it?"
>    (looking at the code now, it goes
>       i2c_eeprom_read()
>         dereference of i2c_eeprom_ops->read method
>         i2c_eeprom_std_read()
>           dm_i2c_read()
>     so the complication is trivial, IMO)
> 
> - the following commit adds code that writes the eeprom, and this cannot
>    be done with simple dm_i2c_write(), because each eeprom page has to be
>    written by another transaction, which is what i2c_eeprom_write()
>    does.
> 
>    So I knew that I was going to add i2c_eeprom_write(), and I thought
>    that it would seem weird writing with i2c_eeprom_write() but reading
>    with dm_i2c_read().

That's what I thought after reviewing patch 3/3. Okay, makes sense.
Let's see, if we can pull this into the upcoming release.

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
