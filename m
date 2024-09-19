Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81028CE8D7D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 12:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CEDA89160;
	Thu, 19 Sep 2024 14:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="J4hx2Ehf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CF589162; Thu, 19 Sep 2024 14:46:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DD68915F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 14:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726749978; x=1727354778; i=xypron.glpk@gmx.de;
 bh=+uH+00qzxivWr2McAwphgk53LhvUPvZh0n0z5ZmiMPs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=J4hx2EhfNMZ3A0g3/DIqKP4QBd+2sTA27bpy+kLny7w54/3soes+ZA2Xf3k9FFLf
 XmhftWhSxSD4r15VdPygVmdCdCVSlc8G0SQ1KQ9f6z8gtHvVPND/qV6tbC0znNu/C
 p6UeMwQC4S/U/YO4mHt6/gfSwWvTXTahjQjvG380erS4+ABCCvIt6WU3aq1KZlGyd
 RfgXh0nMdlDrbiB0Abz4ecta9S/P/QiVBti/wEue4LiGwcCJ/W6U/J9auNb4js+zB
 RP/x9sCaUIdxytOPwQyPZnx2MRhbhPjcW+i6SJ5yVQNjiqzDB7aBl3nFCmC8igRfi
 tHyeVdtWeENmd6bB1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1sgqQa1cVO-000vzs; Thu, 19
 Sep 2024 14:46:18 +0200
Message-ID: <d33b38d1-830e-46f0-939d-c5f662bf4193@gmx.de>
Date: Thu, 19 Sep 2024 14:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
 <CAFLszTiaaP9goTUQiVJ3MQkzegDAmac-AWmtip38eLhMoC15xg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTiaaP9goTUQiVJ3MQkzegDAmac-AWmtip38eLhMoC15xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AOXwYdgiYUDGEPdfJx0+idx/gYXgkTlHvqHD84KzdBFJp4oBFic
 cwNWUOQElx7f1TvE86C5g7gi8P0Hd/mMIwI/TJLBzs6p/NSZdsaEoBQx+prtGqjxTP9/ZO6
 qgwQ5dbRoREvtu4AaeXYAwAXXEZtdZP3CCoQcghxvnRj599N+NHtXbVsosN3Fj4GI+E13cl
 yX37JYR8kgFyKBoNq82Qg==
UI-OutboundReport: notjunk:1;M01:P0:fCcLi5dIqyg=;BVAsgol915IRIRrHH/aBV/c6fYL
 ntxZVGrZHqMAUjgf/1J2HxMS2oGeLlhkeimbyCUTzxTdrv7jHx9jHNoRMyAKx7hGmmACKB3mM
 lYNZb0RQZ/YLBxbI9DJgGICmGrBGXH8EbGBp5pNRT8t48NI/oUf/ajNZvZ1zZ9nIHJcfrwCeM
 KIn2DdhXYM8o0Tq2v4IrRHdO28DiUSQW6CE6agqisiZ8j41hj9Nd1ejlXJ5K5S+PU+QJFHYyM
 /ss64uBEOABne5JmCfgN/o4Ysf9JZU8bYNjwvy4LZy/czoCxiCraXyXghQaFvH+0x3eS9O/qx
 rIiHBuMHwFrr1R4eCsFEk/BOQ3wodYnaUkfUU6qDZ0dVnuILMAcKwXzLr42xjptvzzPLQH0tu
 QTrFCnj+3EDVSoZv24sUtdrO+IzFk/5xdk+RSM/QSWIbtk33M/cB88f6ZOXJdaRkMJ1nsf6Ec
 D7g9HmVP011fDy/+1gzF1i4v1M5JNtHBZORwYg/SCY68YrzzCsfKI5BRnczOknBQPv7q8JhJW
 JtxQJpbT+vMB5K/Nqd+J4ctmf/isbJatzBV9ndxgBdTZV620JhsHUkQQq8EYkWeCUHrAoBAml
 oMALoG3J2IJIMzhXwRwQ/yaFY3LzwQY1DLCTPkhRo8ZrIAH6+1d3OJ6HKDboUkrMhAIKYi3HU
 lz1j8LuRWDN3Gm5h8WqVDlz4Z+YH41orpuBUIWj3a6QO3UYIXyb/1BywB3fmgFiuV22f6+/Mg
 luJbyDl6MrcLPejBo7F3IVFe6Wpsd8Y83wOaWNuqKDjcBGaZ5SHglelZNaAaWGqVYmPqxeGNH
 VuRJYstXYmzoyYokKLvb+MGA==
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

On 12.09.24 02:58, Simon Glass wrote:
> Hi Patrick,
>
> On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
>>
>> Allocate memory for ACPI tables inside the efi_loader and write out
>> the tables similar to SMBIOS tables. When ACPI is enabled and wasn't
>> installed in other places, install the ACPI table in EFI. Since EFI
>> is necessary to pass the ACPI table location when FDT isn't used,
>> there's no need to install it separately.
>>
>> When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
>> bloblist. The tables are still passed to the OS using EFI.
>>
>> This allows non x86 platforms to boot using ACPI only in case the
>> EFI loader is being used.
>>
>> TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>> Changelog v3:
>> - Drop memalign and use efi_allocate_pages
>> - Use log_debug instead of debug
>> - Clarify commit message
>> - Skip writing ACPI tables on sandbox
>> - Rename function
>> - Add function comment
>> ---
>>   lib/efi_loader/efi_acpi.c        | 80 +++++++++++++++++++++++++++++++=
-
>>   test/py/tests/test_event_dump.py |  1 +
>>   2 files changed, 79 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
>> index 67bd7f8ca2..9d38d0060c 100644
>> --- a/lib/efi_loader/efi_acpi.c
>> +++ b/lib/efi_loader/efi_acpi.c
>> @@ -6,15 +6,23 @@
>>    */
>>
>>   #include <efi_loader.h>
>> -#include <log.h>
>> -#include <mapmem.h>
>>   #include <acpi/acpi_table.h>
>>   #include <asm/global_data.h>
>> +#include <asm/io.h>
>> +#include <bloblist.h>
>> +#include <linux/sizes.h>
>> +#include <linux/log2.h>
>> +#include <log.h>
>> +#include <malloc.h>
>> +#include <mapmem.h>
>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>
>>   static const efi_guid_t acpi_guid =3D EFI_ACPI_TABLE_GUID;
>>
>> +enum {
>> +       TABLE_SIZE      =3D SZ_64K,
>> +};
>>   /*
>>    * Install the ACPI table as a configuration table.
>>    *
>> @@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
>>          return efi_install_configuration_table(&acpi_guid,
>>                                                 (void *)(ulong)addr);
>>   }
>> +
>> +/*
>> + * Allocate memory for ACPI tables and write ACPI tables to the
>> + * allocated buffer.
>> + *
>> + * Return:     status code
>> + */
>> +static int alloc_write_acpi_tables(void)
>> +{
>> +       u64 table_addr, table_end;
>> +       u64 new_acpi_addr =3D 0;
>> +       efi_uintn_t pages;
>> +       efi_status_t ret;
>> +       void *addr;
>> +
>> +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
>> +               return 0;
>> +
>> +       if (IS_ENABLED(CONFIG_X86) ||
>> +           IS_ENABLED(CONFIG_QFW_ACPI) ||
>> +           IS_ENABLED(CONFIG_SANDBOX)) {
>> +               log_debug("Skipping writing ACPI tables as already done=
\n");
>> +               return 0;
>> +       }
>> +
>> +       /* Align the table to a 4KB boundary to keep EFI happy */
>> +       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
>> +               addr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE=
,
>> +                                   ilog2(SZ_4K));
>> +
>> +               if (!addr)
>> +                       return log_msg_ret("mem", -ENOMEM);
>> +       } else {
>> +               pages =3D efi_size_in_pages(TABLE_SIZE);
>> +
>> +               ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
>> +                                        EFI_ACPI_RECLAIM_MEMORY,
>> +                                        pages, &new_acpi_addr);
>
> I know we are going to have a problem here since EFI memory-allocation
> is a bit of a mess, and you got conflicting advice on the previous
> version....
>
> But we cannot call efi_allocate_pages() during U-Boot init. EFI may
> not even be enabled. The allocation ends up being in the area between
> the bottom of memory at the bottom of the stack, which is not supposed
> to be used, at least until images are loaded.

Please, have a look at init_sequence_r[].

The memory allocate for the EFI sub-system is initialized in
efi_memory_init directly after initr_lmb.

So for sure we can and should use efi_allocate_pages() here.

We must not use bloblist_add() as the memory allocation would not be
reported as AcpiReclaimMemory.

Best regards

Heinrich

>
> I think in fact we should make this ACPI stuff depend on bloblist and
> just put the tables there. So set up bloblist size to something small,
> like 0x100 and set BLOBLIST_SIZE_RELOC to larger than you need (e.g.
> 68KB). Everything should work OK. I will do a bit of a tidy-up after
> this series goes in.
>
>> +               if (ret !=3D EFI_SUCCESS)
>> +                       return log_msg_ret("mem", -ENOMEM);
>> +
>> +               addr =3D (void *)(uintptr_t)new_acpi_addr;
>> +       }
>> +
>> +       table_addr =3D virt_to_phys(addr);
>> +
>> +       gd->arch.table_start_high =3D table_addr;
>> +
>> +       table_end =3D write_acpi_tables(table_addr);
>> +       if (!table_end) {
>> +               log_err("Can't create ACPI configuration table\n");
>> +               return -EINTR;
>> +       }
>> +
>> +       log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, tab=
le_end);
>> +       if (table_end - table_addr > TABLE_SIZE) {
>> +               log_err("Out of space for configuration tables: need %l=
lx, have %x\n",
>> +                       table_end - table_addr, TABLE_SIZE);
>> +               return log_msg_ret("acpi", -ENOSPC);
>> +       }
>> +       gd->arch.table_end_high =3D table_end;
>> +
>> +       log_debug("- done writing tables\n");
>> +
>> +       return 0;
>> +}
>> +
>> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
>> diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_even=
t_dump.py
>> index e282c67335..459bfa26bb 100644
>> --- a/test/py/tests/test_event_dump.py
>> +++ b/test/py/tests/test_event_dump.py
>> @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
>>   --------------------  ------------------------------  ---------------=
---------------
>>   EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_requ=
est.c:.*
>>   EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simp=
le_os.c:.*
>> +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader=
/efi_acpi.c:.*
>>   EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loade=
r/efi_smbios.c:.*
>>   EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/=
cpu/start.c:.*
>>   EVT_TEST              h_adder_simple                  .*test/common/e=
vent.c:'''
>> --
>> 2.46.0
>>
>
> Regards,
> Simon

