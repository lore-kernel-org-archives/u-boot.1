Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760ADCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED9F84531;
	Fri, 28 Nov 2025 12:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA3C84534; Fri, 28 Nov 2025 12:34:56 +0100 (CET)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 00B3284513
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 28 Nov 2025 20:34:49 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
 by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 75C412069FC4;
 Fri, 28 Nov 2025 20:34:49 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with
 ESMTP; Fri, 28 Nov 2025 20:34:49 +0900
Received: from [10.212.247.49] (unknown [10.212.247.49])
 by iyokan3.css.socionext.com (Postfix) with ESMTP id 48B4A10A013;
 Fri, 28 Nov 2025 20:34:48 +0900 (JST)
Message-ID: <b7e755f4-2925-4400-9efd-7cb8ca781847@socionext.com>
Date: Fri, 28 Nov 2025 20:34:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootm: fix boot failure from compressed image for
 IH_OS_EFI
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 kojima.masahisa@socionext.com, morimoto.masashi@socionext.com
References: <20251120233851.2726487-1-kojima.masahisa@socionext.com>
 <b60d74a5-8085-4c6a-ad90-bf59dc41e37f@gmx.de>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <b60d74a5-8085-4c6a-ad90-bf59dc41e37f@gmx.de>
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

Hi Heinrich,

On 2025/11/21 17:41, Heinrich Schuchardt wrote:
> On 11/21/25 00:38, Masahisa Kojima wrote:
>> The bootm command can handle the compressed image, but current
>> code fails to boot from it.
>>
>>       ## Loading kernel (any) from FIT Image at a8000000 ...
>>       <snip>
>>            Compression:  gzip compressed
>>            Data Start:   0xa80000d4
>>            Data Size:    10114520 Bytes = 9.6 MiB
>>            Architecture: AArch64
>>            OS:           EFI Firmware
>>            Load Address: 0x90000000
>>
>>       <snip>
>>          Uncompressing Kernel Image to 90000000
>>       ## Transferring control to EFI (at address a80000d4) ...
>>       Booting <NULL>
>>       Not a PE-COFF file
>>       Loading image failed
>>
>> To take care of the compressed image, the load address needs
>> to be passed instead of the original compressed image address.
>>
>> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> 
> Hello Masahisa,
> 
> Thank you for diving into this problem.
> 
> In test/py/tests/test_efi_fit.py we are testing on the sandbox with and
> without compression. Why would the problem not show up in the test?
> 
> 539         # Run tests
> 540         # - fdt OFF, initrd OFF, gzip OFF
> 541         launch_efi(False, False, False)
> 542         # - fdt ON, initrd OFF, gzip OFF
> 543         launch_efi(True, False, False)
> 544         # - fdt OFF, initrd ON, gzip OFF
> 545         launch_efi(False, True, False)
> 546
> 547         if is_sandbox:
> 548             # - fdt OFF, initrd OFF, gzip ON
> 549             launch_efi(False, False, True)
> 550             # - fdt ON, initrd OFF, gzip ON
> 551             launch_efi(True, False, True)
> 552             # - fdt OFF, initrd ON, gzip ON
> 553             launch_efi(False, True, True)
> 
> The test should be corrected to show you issue.

Can you show us how to run it with sandbox?

To understand the situation, I tried running the test using v2025.10.

     ./test/py/test.py --bd sandbox   --build  -k efi_fit
     ./test/py/test.py --bd sandbox64 --build  -k efi_fit

The test was skipped as follows:
     test/py/tests/test_efi_fit.py::test_efi_fit_launch SKIPPED (.config feature "generate_acpi_table" enabled)

After disabling ACPI, the test failed with the following error
and could not be reproduced.

     => /u-boot
     Bloblist at 100 not found (err=-2)

There might be differences in the environment or procedure,
so please let us know if you have any tips.

Thank you,

---
Best Regards
Kunihiko Hayashi
