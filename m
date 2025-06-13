Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712E1C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 13:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B0D282C30;
	Fri, 13 Jun 2025 15:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NPVTTg8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E015C82CA0; Fri, 13 Jun 2025 15:07:15 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8852080C93
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so14314635e9.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749820033; x=1750424833; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jfhHFSgDQgD3M3BFKrwD0oVJ68C9FxysRbQKM8q56zw=;
 b=NPVTTg8wL+lJJKrt7LFRjfpRX5U1ybJRlDVj8GkmMnAmoTwzB6P6qs6gYJ+80MoiC5
 Nlj6fiPKlAOqkTOQOqs9dq+BxfA7305zRtvsjgsEdv2r/R2lk90Mw/wFXas18QYRDTig
 OnHuhZ1IAPHkjTTXHjjuersmnnKWlFPtEs3pqFx0xIo+HUHtE/hlEKKtk73RLjACI3i7
 CJwImljqEAk0wU/yRezG0kpzn0hKoBAOus78WnM9xc4GQJPoCMzWe0M9YXpW5HirgjpS
 8XxpbS5elU+YtQpAnOswghEDJK3jvdkS7ZGfRQ3uuLb+ugqjRbJ6paoRsqXskXcCXYQ0
 gNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820033; x=1750424833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfhHFSgDQgD3M3BFKrwD0oVJ68C9FxysRbQKM8q56zw=;
 b=TJMI7vuu0RcUy6UIsnz29DMddnhRwX+3n4pzuzYTpvf/AeQtO/ALKBxUgoSpCcE4li
 5tSkNHPZjh1soDVOKJdooof604CBZrFXy5dgcX8R+43R29k4dKqgVSqcDXVLVi90Oe80
 t9jVB2mLcABU6foxhZTzdG1LIpPpfFarCK5FfPgwOK38xGkke9+TYUKaCt5dCjTestfV
 bRpN+pItlZ+I8zny0rsTyXbTSnKxcyVQUySkPmrk285QnCywHIW8Bs2ec9VeLVafwgN8
 lTNtFXGbmwlzalQtllzzffLwpB2RT39KhX6Y6xga7+tGKTQIG0Hllk+JZELSIay6vOqa
 blSA==
X-Gm-Message-State: AOJu0Yzo25uon4oUc7EClpVzWGBgD1qxoyiFmd3cwjiXFE1OwLZIqLuZ
 HWtPYNP6NOX82+KOcSlFp6i8hX7jgjbmb6S4SbRmMSXQ8vTWvwJaEtJoz7mqc9kxEOg=
X-Gm-Gg: ASbGncu43m5031f88xkAeH0o8+54/ZS1WwH3FzQgfm8fyTgHrSfBB8Dn1d0zbBVR9ft
 1FKUlXfyTkMmlzEVdOPE7BpUF2srIhdJ+npFBCmhQfJI/hUA160ke7DrfX5l1AsZRf5VjZSTaun
 gLI3seI2lcH/fV55r5xpw+j1jH2jXPClG5RIMYeEnnNbmk4Fu+aFmhtAENwIJpBRkvyDu6gCmrt
 RjjQ+VpAiQuREplYxsmPkSNN85FSvLodw7PN2jqetXukPijmPrwYd9dCU078JnXmh0jPsQ8o3Sp
 g9wtxz0BB1xeymbJ5Dihm0IxLpgU21Kav+Gp9dtOFhPh1/7a8mR6ZyV4ZAYADdSwBv/T514AMSs
 UmLA8mXBEIw+lvku1VdQLgWWp2n//lfjzcEbsvGkbkA==
X-Google-Smtp-Source: AGHT+IH9AS3sHPwcMjYN1O3tCkkkRdRJBosDmAe0Vb2uOVu4ZEdM+v18O7G8cdmIXYagUvTq4/LxIw==
X-Received: by 2002:a05:600c:8b48:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-45334ae77f9mr25182965e9.25.1749820032760; 
 Fri, 13 Jun 2025 06:07:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:5fcb:93f2:a702:e5b2?
 ([2a01:e0a:3cb:7bb0:5fcb:93f2:a702:e5b2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e16b425sm51244685e9.34.2025.06.13.06.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 06:07:12 -0700 (PDT)
Message-ID: <f42bf2a0-5114-45c6-9d7b-02bac8a4dc0d@linaro.org>
Date: Fri, 13 Jun 2025 15:07:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
To: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Neal Frager <neal.frager@amd.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
 <20250612164939.GO1382132@bill-the-cat>
 <b806f55f-da5a-4373-a6c2-15b1cab93da3@linaro.org>
 <eefb84b0-f995-446a-b885-8de9e0b2f295@amd.com>
 <a63dd90d-8c31-44d0-88da-228df3e36b32@linaro.org>
 <6d3e7ea1-9ae4-4f5f-a25f-968e7a15e89f@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <6d3e7ea1-9ae4-4f5f-a25f-968e7a15e89f@amd.com>
Content-Type: text/plain; charset=UTF-8
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



On 6/13/25 14:50, Michal Simek wrote:
> 
> 
> On 6/13/25 14:30, Jerome Forissier wrote:
>> Hi Michal,
>>
>> On 6/13/25 09:59, Michal Simek wrote:
>>>
>>>
>>> On 6/13/25 09:38, Jerome Forissier wrote:
>>>>
>>>>
>>>> On 6/12/25 18:49, Tom Rini wrote:
>>>>> On Thu, Jun 12, 2025 at 05:32:41PM +0200, Jerome Forissier wrote:
>>>>>
>>>>>> Add a script to help build a functional U-Boot binary for the ZynqMP
>>>>>> Kria KV260. Also add some documentation.
>>>>>>
>>>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>>>> ---
>>>>>>
>>>>>>    doc/board/xilinx/index.rst        |  1 +
>>>>>>    doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>>>>>>    tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>>>>>>    tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>>>>>>    4 files changed, 167 insertions(+)
>>>>>>    create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>>>>>>    create mode 100755 tools/zynqmp_kv260_build.sh
>>>>>>    create mode 100755 tools/zynqmp_pmufw_elf_convert.py
>>>>>
>>>>> Helper build scripts don't belong in the tools directory. If they're
>>>>> super helpful, I don't object to adding them to
>>>>> u-boot-extras/contrib/<you>/ directory.
>>>>
>>>> OK
>>>>
>>>>> But there's a number of
>>>>> documented examples already on checkout and build TF-A then do ... for
>>>>> your platform.
>>>>
>>>> There is doc/board/xilinx/zynqmp.rst which deals with quite few ZynqMP
>>>> boards but not the KV260. In addition, it has a number of shortcomings:
>>>> - It mentions pmu.bin but does not say where to get if from
>>>> - It doesn't say how to build TF-A (bl31.bin), some very specific build
>>>> options are needed.
>>>> - I consider that detailed build instructions belong in things called
>>>> scripts or Makefiles, that were invented long ago exactly for that
>>>> purpose :) IMO the documentation should tell the bare minimum and ideally
>>>> be unnecessary.
>>>>
>>>> I am not particularly proud of the fact that I spent more than a whole
>>>> day trying to get U-Boot master to boot on my KV260, and without the help
>>>> of Michal, no doubt I would still be trying... So, how about I submit the
>>>> zynqmp_kv260_build.sh script to the u-boot-extras/contrib/<me>/ directory
>>>> and just point to it in doc/board/xilinx/zynqmp.rst?
>>>
>>> no issue from my side.
>>
>> OK so here you go:
>>
>>  From a429f6563fc5f1433a2df8eabe6a42a98864701b Mon Sep 17 00:00:00 2001
>> From: Jerome Forissier <jerome.forissier@linaro.org>
>> Date: Fri, 13 Jun 2025 13:39:10 +0200
>> Subject: [PATCH] contrib/jforissier: add zynqmp_kv260_build.sh
>>
>> Add a build script for the AMD/Xilinx ZynqMP Kria KV260 board.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   contrib/jforissier/zynqmp_kv260_build.sh | 42 ++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>   create mode 100755 contrib/jforissier/zynqmp_kv260_build.sh
>>
>> diff --git a/contrib/jforissier/zynqmp_kv260_build.sh b/contrib/jforissier/zynqmp_kv260_build.sh
>> new file mode 100755
>> index 0000000..967c946
>> --- /dev/null
>> +++ b/contrib/jforissier/zynqmp_kv260_build.sh
>> @@ -0,0 +1,42 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +# Copyright (C) 2025 Linaro Ltd.
>> +
>> +set -ex
>> +
>> +if [ "$1" == "-c" ]; then
>> +  # Clean: remove downloaded/converted files
>> +  rm -f bl31.elf bl31.bin pmufw.elf pmufw.bin zynqmp_fsbl.elf pmu_obj.bin
>> +  exit 0
>> +fi
>> +[ -e bl31.bin ] || {
>> +  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2025.1/kv260-kria/bl31.elf
> 
> I would create one variable to keep xlnx_rel_v2025.1 string that you can change one location to get new versions.

OK

> 
>> +  aarch64-linux-gnu-objcopy -O binary bl31.elf bl31.bin
>> +  BL31_LOAD_ADDR=$(aarch64-linux-gnu-readelf -l bl31.elf | awk '/Entry point/ { print $3 }')
> 
> here you have bug. Your script works fine on the first run.
> 
> You can try this
> ./zynqmp_kv260_build.sh
> make mrproper
> ./zynqmp_kv260_build.sh
> 
> and look at
> CONFIG_BL31_LOAD_ADDR
> 
> you are all the time getting default Kconfig address which is wrong.

I've moved the BL31_LOAD_ADDR assignment to the block that appends to
the .config. I have also split things out a bit more. Here is the new
version:


From d7b8c46f2b4d60080d33ea481bf23df5a4b510be Mon Sep 17 00:00:00 2001
From: Jerome Forissier <jerome.forissier@linaro.org>
Date: Fri, 13 Jun 2025 13:39:10 +0200
Subject: [PATCH] contrib/jforissier: add zynqmp_kv260_build.sh

Add a build script for the AMD/Xilinx ZynqMP Kria KV260 board.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 contrib/jforissier/zynqmp_kv260_build.sh | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 contrib/jforissier/zynqmp_kv260_build.sh

diff --git a/contrib/jforissier/zynqmp_kv260_build.sh b/contrib/jforissier/zynqmp_kv260_build.sh
new file mode 100755
index 0000000..83daf73
--- /dev/null
+++ b/contrib/jforissier/zynqmp_kv260_build.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Linaro Ltd.
+
+set -ex
+
+if [ "$1" == "-c" ]; then
+  # Clean: remove downloaded/converted files
+  rm -f bl31.elf bl31.bin pmufw.elf pmufw.bin zynqmp_fsbl.elf pmu_obj.bin
+  exit 0
+fi
+XLNX_REL=xlnx_rel_v2025.1
+[ -e bl31.elf ] || wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/${XLNX_REL}/kv260-kria/bl31.elf
+[ -e bl31.bin ] || aarch64-linux-gnu-objcopy -O binary bl31.elf bl31.bin
+[ -e pmufw.elf ] || wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/${XLNX_REL}/kv260-kria/pmufw.elf
+[ -e pmufw.bin ] || llvm-objcopy -O binary pmufw.elf pmufw.bin
+[ -e zynqmp_fsbl.elf ] || wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/${XLNX_REL}/kv260-kria/zynqmp_fsbl.elf
+[ -e pmu_obj.bin ] || aarch64-linux-gnu-objcopy --dump-section .sys_cfg_data=pmu_obj.bin zynqmp_fsbl.elf
+[ -e .config ] || {
+  BL31_LOAD_ADDR=$(aarch64-linux-gnu-readelf -l bl31.elf | awk '/Entry point/ { print $3 }')
+  make xilinx_zynqmp_kria_defconfig
+  cat << EOF >> .config
+CONFIG_PMUFW_INIT_FILE="pmufw.bin"
+CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE="pmu_obj.bin"
+CONFIG_BL31_LOAD_ADDR=${BL31_LOAD_ADDR}
+CONFIG_BL32_LOAD_ADDR=0
+EOF
+}
+export BL31=bl31.bin
+export BL32=
+export TEE=
+export CROSS_COMPILE=aarch64-linux-gnu-
+make -j$(nproc) BINMAN_ALLOW_MISSING=1
+set +x
+echo Build was successful:
+ls -l qspi.bin
-- 
2.43.0


Thanks,
-- 
Jerome
