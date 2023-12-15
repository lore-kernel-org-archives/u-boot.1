Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55104C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 19:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AB287BFA;
	Fri, 15 Dec 2023 20:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="X1TY+kPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3554387C12; Fri, 15 Dec 2023 20:05:02 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C0687BF6
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 20:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 38B973F18C; 
 Fri, 15 Dec 2023 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702667099;
 bh=9pkXQZO8aN4icPOogP5L1ESyKiJ4X65y3xV0W8/NyFs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=X1TY+kPUs8rsT4H2Gc88fYg3t8TYtqKFKqd5TFu61JgnNSRx/SBDVkexm28qKQkWZ
 1Zj8BsBdYpuKszcWofIDU7wbwPfnuZy7c/LahKpRecB3+v7ImrJxdjHXlqaLA8IKX9
 +R+U/Ff8HUoqti2m3eQmc5IFTaqwjB3RK5pikPfd6q4mQM/BXXfvh62V2mz1WEjO73
 P2iKzL29/TcnlQMz2wDFHM19zY8dHK8XZQNZk0H1P5CRjvAKjQfrEPYaUfUVvB/UMs
 8g2EydqtRIPu2GXMYKrOQ9KFoEW6CXZktldj+FSLKqHMHSZgxtAOiaxQShNR2VaQLR
 DnobiCC0dIieg==
Message-ID: <61267605-df72-4f91-b5d3-ad1774226249@canonical.com>
Date: Fri, 15 Dec 2023 20:04:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] acpi: fix FADT table
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
References: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
 <20231215164016.137794-2-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3j3PmV-FEkSP6hPfqpS3XQ_-f4b=5LCRpd3nj4Hi=2zw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3j3PmV-FEkSP6hPfqpS3XQ_-f4b=5LCRpd3nj4Hi=2zw@mail.gmail.com>
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

On 12/15/23 18:48, Simon Glass wrote:
> Hi Heinrich,
> 
> On Fri, 15 Dec 2023 at 09:40, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Fields X_FIRMWAE_CTRL and X_DSDT must be 64bit wide. Convert pointers to
>> to uintptr_t to fill these.
>>
>> If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
>> field X_DSDT is filled, field DSDT must be ignored. We should not fill
>> unused fields.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/x86/cpu/baytrail/acpi.c | 8 ++------
>>   arch/x86/cpu/quark/acpi.c    | 8 ++------
>>   arch/x86/cpu/tangier/acpi.c  | 8 ++------
>>   arch/x86/lib/acpi_table.c    | 9 ++-------
>>   include/acpi/acpi_table.h    | 6 ++----
>>   5 files changed, 10 insertions(+), 29 deletions(-)
>>
> 
> Just as a general comment, the word 'fix' does not really describe
> things very well. There may be many fixes to a piece of code or
> feature. I would suggest something a bit more specific.  Perhaps
> something like ':'
> 
> Also please use the U-Boot standard of ulong for addresses, not uintptr_t

You can have pointers that are shorter or longer than long depending on 
compiler invocation parametes. uintptr_t is the only type guaranteed to 
take a pointer. Using unsigned long here would be a non-portable 
programming style and we should avoid such sin.

> 
> For casts, it is better to use map_sysmem() and map_to_sysmem() so
> that we can use the code in unit tests (although of course we
> currently have no way of running x86-specific code in sandbox).

Please, keep the sandbox buildable on other architectues.

Using map_to_sysmem() makes sense here as we use the same fields as 
virtual sandbox addresses.

Best regards

Heinrich

> 
>> diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.c
>> index 4378846f8b..5c28c4d260 100644
>> --- a/arch/x86/cpu/baytrail/acpi.c
>> +++ b/arch/x86/cpu/baytrail/acpi.c
>> @@ -31,8 +31,6 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
>>          header->length = sizeof(struct acpi_fadt);
>>          header->revision = 4;
>>
>> -       fadt->firmware_ctrl = (u32)ctx->facs;
>> -       fadt->dsdt = (u32)ctx->dsdt;
>>          fadt->preferred_pm_profile = ACPI_PM_MOBILE;
>>          fadt->sci_int = 9;
>>          fadt->smi_cmd = 0;
>> @@ -79,10 +77,8 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
>>          fadt->reset_reg.addrh = 0;
>>          fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
>>
>> -       fadt->x_firmware_ctl_l = (u32)ctx->facs;
>> -       fadt->x_firmware_ctl_h = 0;
>> -       fadt->x_dsdt_l = (u32)ctx->dsdt;
>> -       fadt->x_dsdt_h = 0;
>> +       fadt->x_firmware_ctrl = (uintptr_t)ctx->facs;
>> +       fadt->x_dsdt = (uintptr_t)ctx->dsdt;
>>
>>          fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
>>          fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
>> diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
>> index 9a2d682451..583d4583c0 100644
>> --- a/arch/x86/cpu/quark/acpi.c
>> +++ b/arch/x86/cpu/quark/acpi.c
>> @@ -26,8 +26,6 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
>>          header->length = sizeof(struct acpi_fadt);
>>          header->revision = 4;
>>
>> -       fadt->firmware_ctrl = (u32)ctx->facs;
>> -       fadt->dsdt = (u32)ctx->dsdt;
>>          fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
>>          fadt->sci_int = 9;
>>          fadt->smi_cmd = 0;
>> @@ -74,10 +72,8 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
>>          fadt->reset_reg.addrh = 0;
>>          fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
>>
>> -       fadt->x_firmware_ctl_l = (u32)ctx->facs;
>> -       fadt->x_firmware_ctl_h = 0;
>> -       fadt->x_dsdt_l = (u32)ctx->dsdt;
>> -       fadt->x_dsdt_h = 0;
>> +       fadt->x_firmware_ctrl = (uintptr_t)ctx->facs;
>> +       fadt->x_dsdt = (uintptr_t)ctx->dsdt;
>>
>>          fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
>>          fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
>> diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
>> index 1c667c7d56..19ec6e3390 100644
>> --- a/arch/x86/cpu/tangier/acpi.c
>> +++ b/arch/x86/cpu/tangier/acpi.c
>> @@ -31,8 +31,6 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
>>          header->length = sizeof(struct acpi_fadt);
>>          header->revision = 6;
>>
>> -       fadt->firmware_ctrl = (u32)ctx->facs;
>> -       fadt->dsdt = (u32)ctx->dsdt;
>>          fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
>>
>>          fadt->iapc_boot_arch = ACPI_FADT_VGA_NOT_PRESENT |
>> @@ -45,10 +43,8 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
>>
>>          fadt->minor_revision = 2;
>>
>> -       fadt->x_firmware_ctl_l = (u32)ctx->facs;
>> -       fadt->x_firmware_ctl_h = 0;
>> -       fadt->x_dsdt_l = (u32)ctx->dsdt;
>> -       fadt->x_dsdt_h = 0;
>> +       fadt->x_firmware_ctrl = (uintptr_t)ctx->facs;
>> +       fadt->x_dsdt = (uintptr_t)ctx->dsdt;
>>
>>          header->checksum = table_compute_checksum(fadt, header->length);
>>
>> diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
>> index c5b33dc65d..f49b6933ab 100644
>> --- a/arch/x86/lib/acpi_table.c
>> +++ b/arch/x86/lib/acpi_table.c
>> @@ -572,13 +572,8 @@ void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
>>          memcpy(header->aslc_id, ASLC_ID, 4);
>>          header->aslc_revision = 1;
>>
>> -       fadt->firmware_ctrl = (unsigned long)facs;
>> -       fadt->dsdt = (unsigned long)dsdt;
>> -
>> -       fadt->x_firmware_ctl_l = (unsigned long)facs;
>> -       fadt->x_firmware_ctl_h = 0;
>> -       fadt->x_dsdt_l = (unsigned long)dsdt;
>> -       fadt->x_dsdt_h = 0;
>> +       fadt->x_firmware_ctrl = (uintptr_t)facs;
>> +       fadt->x_dsdt = (uintptr_t)dsdt;
>>
>>          fadt->preferred_pm_profile = ACPI_PM_MOBILE;
>>
>> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
>> index 20ac3b51ba..e67562ef65 100644
>> --- a/include/acpi/acpi_table.h
>> +++ b/include/acpi/acpi_table.h
>> @@ -228,10 +228,8 @@ struct __packed acpi_fadt {
>>          u8 reset_value;
>>          u16 arm_boot_arch;
>>          u8 minor_revision;
>> -       u32 x_firmware_ctl_l;
>> -       u32 x_firmware_ctl_h;
>> -       u32 x_dsdt_l;
>> -       u32 x_dsdt_h;
>> +       u64 x_firmware_ctrl;
>> +       u64 x_dsdt;
>>          struct acpi_gen_regaddr x_pm1a_evt_blk;
>>          struct acpi_gen_regaddr x_pm1b_evt_blk;
>>          struct acpi_gen_regaddr x_pm1a_cnt_blk;
>> --
>> 2.40.1
>>
> 
> Regards,
> Simon
> 
> Regards,
> Simon

