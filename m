Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DB7C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9457D8715C;
	Tue, 19 Dec 2023 15:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hRhbNq3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A28A871C3; Tue, 19 Dec 2023 15:51:33 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9133D8700D
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CB18B3F6CB; 
 Tue, 19 Dec 2023 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702997488;
 bh=p0Zf4wzIOlEnHldsl/XfUn1TdD5tGcdaveCmdaH1QR0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=hRhbNq3iJXtJrzAusbcHkESu4mq+Lb4jL4jRrdh5uwwTcAfbGe2E+cbBzgikTGKtg
 vnCXmxIELYG0m5DAfqWJ/drXAdVGobFwFWzWEwDf+bacK9T9YKxIFsrZtkTPDK6F07
 T96lvQmAL4U2LPfU59pYPaVou5CbsfNfSaMchg/FCaKPhDwVCGcMAbiRqX061UG9Nw
 qWxHWpDlx4Z764NgHZ9EK5iwGg2vEWK2BreWQkAn7MmxejJsLXf/p/QugOoKTTp0Th
 OUmF2TjbnfAvE+FIJVX5d6D6ACVlMZYO/3KAe1G0+nt3InBK/4PwD3TTmFwl8qGPRW
 bsr/DXuiq7uYQ==
Message-ID: <fe7f09db-7e1f-47bd-be98-0bc13cec3933@canonical.com>
Date: Tue, 19 Dec 2023 15:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] configs: qemu: add config fragment for ACPI
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
 <20231219122439.31983-9-heinrich.schuchardt@canonical.com>
 <CAEUhbmV9zSOPaB-avSSGXq_uTAJ+JEiZ2P-5mjz04BWv3SN_jg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAEUhbmV9zSOPaB-avSSGXq_uTAJ+JEiZ2P-5mjz04BWv3SN_jg@mail.gmail.com>
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

On 12/19/23 14:41, Bin Meng wrote:
> Hi Heinrich,
> 
> On Tue, Dec 19, 2023 at 8:25 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Provide a configuration fragment to enable ACPI on QEMU.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>> v3:
>>          no change
>> v2:
>>          no change
>> ---
>>   MAINTAINERS                         |  1 +
>>   board/emulation/configs/acpi.config |  3 +++
>>   doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
>>   doc/board/emulation/index.rst       |  1 +
>>   4 files changed, 28 insertions(+)
>>   create mode 100644 board/emulation/configs/acpi.config
>>   create mode 100644 doc/board/emulation/acpi.rst
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 25f2bb80de..bf437b253b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -53,6 +53,7 @@ Maintainers List (try to look for most precise areas first)
>>   ACPI:
>>   M:     Simon Glass <sjg@chromium.org>
>>   S:     Maintained
>> +F:     board/emulation/configs/acpi.config
>>   F:     cmd/acpi.c
>>   F:     lib/acpi/
>>
>> diff --git a/board/emulation/configs/acpi.config b/board/emulation/configs/acpi.config
>> new file mode 100644
>> index 0000000000..b7ed811e33
>> --- /dev/null
>> +++ b/board/emulation/configs/acpi.config
>> @@ -0,0 +1,3 @@
>> +CONFIG_CMD_QFW=y
>> +CONFIG_ACPI=y
>> +CONFIG_GENERATE_ACPI_TABLE=y
>> diff --git a/doc/board/emulation/acpi.rst b/doc/board/emulation/acpi.rst
>> new file mode 100644
>> index 0000000000..e1208ca51e
>> --- /dev/null
>> +++ b/doc/board/emulation/acpi.rst
>> @@ -0,0 +1,23 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +ACPI on QEMU
>> +============
>> +
>> +QEMU can provide ACPI tables on ARM, RISC-V, and x86.
> 
> ACPI support on RISC-V landed on QEMU in a pretty recent version.
> Would you mind documenting its version?

7da2fb240f97 ("hw/riscv/virt: Enable basic ACPI infrastructure") 
appeared first in QEMU v8.0.0.

f5d8c8cd792b ("hw/arm/virt-acpi-build: Basic framework for building ACPI 
tables on ARM")
made it into QEMU v2.4.0

> 
> I haven't checked QEMU yet. Is ACPI default on in QEMU for Arm and
> RISC-V virt? If not, we should document QEMU commands to enable ACPI.

It is enabled by default in the virt machine. You can switch it off with 
'-M virt,acpi=off'. See

[PATCH 1/1] docs/system/riscv: document acpi parameter of virt machine
https://lore.kernel.org/qemu-devel/20231219143829.8961-1-heinrich.schuchardt@canonical.com/T/#u

Best regards

Heinrich

> 
>> +
>> +The following settings are needed::
>> +
>> +    CONFIG_CMD_QFW=y
>> +    CONFIG_ACPI=y
>> +    CONFIG_GENERATE_ACPI_TABLE=y
>> +
>> +On x86 these settings are already included in the defconfig files. ARM and
>> +RISC-V default to use device-trees.
>> +
>> +Instead of updating the configuration manually you can add the configuration
>> +fragment `acpi.config` to the make command for initializing the configuration.
>> +E.g.
>> +
>> +.. code-block:: bash
>> +
>> +    make qemu-riscv64_smode_defconfig acpi.config
>> diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
>> index 932c65adeb..d3d6b8f3d8 100644
>> --- a/doc/board/emulation/index.rst
>> +++ b/doc/board/emulation/index.rst
>> @@ -6,6 +6,7 @@ Emulation
>>   .. toctree::
>>      :maxdepth: 1
>>
>> +   acpi
>>      blkdev
>>      ../../usage/semihosting
>>      qemu-arm
>> --
> 
> Regards,
> Bin

