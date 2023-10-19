Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5752BCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 09:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8416F871AA;
	Thu, 19 Oct 2023 11:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XuGEIll2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3611871BB; Thu, 19 Oct 2023 11:46:37 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ECE1871A5
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 11:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8565520016;
 Thu, 19 Oct 2023 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697708795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQLXJzx5TN0ZcaePRWq5/zEVKmi9ESly8v1nV9IsQFE=;
 b=XuGEIll2Gpm73UNIE94ZulHUI48EiqepaQRRRK1fPOrmvnK7I7LmnBPbk1MccsbYTfAzsj
 a9GC+EjBzAyrMDEHE5DanvpM47iGWf4Ar0vbNV9boBimFiDC1E/PFrONZ6fnFDOGPdLUZa
 8kmJGTPB6N+MIVNFKxbblSCG/9CsPJu6/W2vYTIKDbm6eh2tKbhZMWPO858Wh+hyghHSzS
 2Qp0nFbubwu2ru0efjX8JvkdEkMUIU7yUEePfvT/qdupXy8b3BbdU7+K/wMhGmOyx280Oo
 fkNxNkkyce7bwqh9+NH0oLW2wWOTGwIntGOK/kMfXI2CfzOT15kpJ0WdLuvNtg==
Message-ID: <d78bb8f0-fdf1-4321-b467-135d22385718@bootlin.com>
Date: Thu, 19 Oct 2023 11:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] cmd: test_enter_suspend: Add test_enter_suspend
 command
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
 u-kumar1@ti.com, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>,
 u-boot@lists.denx.de
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
 <20231016141135.325698-10-thomas.richard@bootlin.com>
 <c7018872-cd6a-4668-a556-814f1c7d2557@gmx.de>
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <c7018872-cd6a-4668-a556-814f1c7d2557@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
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

On 10/16/23 20:14, Heinrich Schuchardt wrote:
> On 10/16/23 16:11, Thomas Richard wrote:
>> From: Gregory CLEMENT <gregory.clement@bootlin.com>
>>
>> Add test_enter_suspend command using PSCI.
>> This command is only to test suspend sequence from U-Boot.
>> The resume will not work.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>
>> ---
>>
>>   cmd/Kconfig             |  7 +++++++
>>   cmd/boot.c              |  8 ++++++++
>>   drivers/firmware/psci.c | 23 +++++++++++++++++++++++
>>   include/command.h       |  2 ++
>>   4 files changed, 40 insertions(+)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 43ca10f69c..54e7d4b0e6 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -1450,6 +1450,13 @@ config CMD_POWEROFF
>>       help
>>         Poweroff/Shutdown the system
>>
>> +config CMD_TEST_ENTER_SUSPEND
>> +    bool "test enter suspend"
>> +    depends on ARM
>> +    select ARM_SMCCC
>> +    help
>> +      Command to test the suspend sequence (only for test)
>> +
>>   config CMD_READ
>>       bool "read - Read binary data from a partition"
>>       help
>> diff --git a/cmd/boot.c b/cmd/boot.c
>> index 14839c1ced..609c07a5a5 100644
>> --- a/cmd/boot.c
>> +++ b/cmd/boot.c
>> @@ -70,3 +70,11 @@ U_BOOT_CMD(
>>       ""
>>   );
>>   #endif
>> +
>> +#if IS_ENABLED(CONFIG_CMD_TEST_ENTER_SUSPEND)
>> +U_BOOT_CMD(
>> +    test_enter_suspend, 1, 0, do_test_enter_suspend,
>> +    "Test the enter SUSPEND sequence of the device",
>> +    ""
>> +);
>> +#endif
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index c6b9efab41..591ad1869d 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -23,6 +23,9 @@
>>   #include <linux/libfdt.h>
>>   #include <linux/printk.h>
>>   #include <linux/psci.h>
>> +#if IS_ENABLED(CONFIG_CMD_TEST_ENTER_SUSPEND)
>> +#include <cpu_func.h>
>> +#endif
>>
>>   #define DRIVER_NAME "psci"
>>
>> @@ -303,6 +306,26 @@ int do_poweroff(struct cmd_tbl *cmdtp, int flag,
>> int argc, char *const argv[])
>>   }
>>   #endif
>>
>> +#if IS_ENABLED(CONFIG_CMD_TEST_ENTER_SUSPEND)
>> +int do_test_enter_suspend(struct cmd_tbl *cmdtp, int flag, int argc,
>> char *const argv[])
>> +{
>> +    do_psci_probe();
>> +
>> +    puts("suspend ...\n");
>> +    puts("disable dcache\n");
>> +
>> +    dcache_disable();
>> +
>> +    /* ARM_PSCI_1_0_FN64_SYSTEM_SUSPEND */
>> +    invoke_psci_fn(PSCI_0_2_FN64(14), (unsigned
>> long)do_test_enter_suspend, 0, 0);
> 
> Suspend exists on other architectures, too. E.g. OpenSBI provides an
> implementation for RISC-V. It would be preferable to add suspend as a
> value to enum enum sysreset_t. Then that functionality can be
> implemented in sysreset_psci.c sysreset_sbi.c, and others.
> 
> The command should simply be called 'suspend'.

This command is only for development/test purpose.
As-is, the resume will not work.
We wrote this command to help during the development, and test our
suspend sequence without booting a Linux.
We didn't plan to support suspend/resume from U-Boot.
So I will remove this patch.

Best Regards,

Thomas

> 
> Best regards
> 
> Heinrich
> 
