Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4811C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEA4982CA6;
	Fri, 13 Jun 2025 14:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bHJezDXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE4282CA8; Fri, 13 Jun 2025 14:30:48 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EE082CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a54836cb7fso1329544f8f.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749817845; x=1750422645; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DJnRSdhjb8Grzrysxi8XD81kK7iKTEYgUEWyyar7jI8=;
 b=bHJezDXVrGDLjpg33Ox38vXk6dLQxB0kaXVH/UvIJ05+RdeIWI0PL3sD811TjHX3M+
 6aBm6T0zGTKLYShHGJvcsrTujIldQ+j5T8hZqn1ajnTu0rogm5awe0BWpn2ghMrIx3lw
 4WQpiu5kYkpBukl/gyZKM6bGSDLEI0VJbtlaxSboIwaLPJw3b0ixl+6ItdlF5hGH+xGX
 H8R6D6qSoeTdCE16lFlJuwtIzYaTAYyB3nDfIioKnzVctgfmbIiGzX/J9cUqiQmiPKNz
 v4eoKXCQWHSxkrDis3fDYYZl2anFDgaLdqd8cKH2vFP/q96RYlnMuooJ7ooX0PKXhxNS
 GJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749817845; x=1750422645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DJnRSdhjb8Grzrysxi8XD81kK7iKTEYgUEWyyar7jI8=;
 b=mIylGIk8aJO1FY3JIUiDEjzCNsSc1wNcGh2BuYpxUBXNvuSyT/oAyMVV9JBaoNU6N+
 3oNyqZkGL3PfgNVnPnVwu/lPgfdGLUdLXRQZVB0qIwWPhYJr/uqyCz+ur2mLfKwxGPwV
 0LLuV4O7TutWs3MYwBH2vMDaPiFTvLIXQg91SLuxSs3uNGzkO5ZI3GlYdf2R/3RLzch8
 IBb63jNRWhViPQ/cU3tAeqxZFoY8OtKx9jpYr7dBy4ZDPZnEncucrXfmpnJ2bVTdejwJ
 xKOqQ+WKjtvJTbcgbZsBTlRtFHZOJqMsNzZAdhyqePT/42lF0CPRwSI0WFSfgd5ZwI14
 JV9w==
X-Gm-Message-State: AOJu0YxDZ0ZMfCRv7Oz3WcHxG6bbUaSCvKXxoRdpYHpxYbvKQBbVQMwJ
 IafQxWHFKTgkT4oKF0LPo/8+jh7rWy3edXpqq0zjAdWJ3Q7tuG+oeCSKucjtQC+O/KQ=
X-Gm-Gg: ASbGncuNEHzxBgq9yzCZRNirX5Hm1ycjH74BluzJv0jbv+P1WzFw/3AqMehYzWiaaMj
 mnxAnVqbtQEgqvw4bnjlrMNiaR3u2BWQSsG3zhIOgw0ckDuqh4WPEiymmApVL5VCZS7WXkp5f7i
 FhhTF9GdjJjHHYY+B906LXLnlWIgoEr2aM5ZFB4F9Su6+93e1XzZPiBO2chOeGWRacRpujhhoiB
 bxzNLSTC/gE6qgw69EoMs+5T0qq4SxHJnmHgV5xz/WRMm8U8fAC4n3hUusjF+5S7mSMB/sSOGut
 bg+GK3Amap6UTxvw+8JVb5JQSyHNSACDAUqAYG1gDwMI9G581pXrXjbY57FB3cWmeEywsQWOOpb
 vBZ5aFb/kLMglM7XcGYherNPoIvleI7T8d35vgW19CQ==
X-Google-Smtp-Source: AGHT+IHpbbL6SkHNFtOsJiVvxREnzgrJEFfN3MSGcQuZmF+S00xN19og4tyir1De3tHwj1LjqwwVBA==
X-Received: by 2002:a05:6000:4284:b0:3a3:7bad:29cb with SMTP id
 ffacd0b85a97d-3a568780aa3mr2743723f8f.52.1749817844873; 
 Fri, 13 Jun 2025 05:30:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:5fcb:93f2:a702:e5b2?
 ([2a01:e0a:3cb:7bb0:5fcb:93f2:a702:e5b2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532056486dsm72267405e9.1.2025.06.13.05.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 05:30:44 -0700 (PDT)
Message-ID: <a63dd90d-8c31-44d0-88da-228df3e36b32@linaro.org>
Date: Fri, 13 Jun 2025 14:30:43 +0200
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
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <eefb84b0-f995-446a-b885-8de9e0b2f295@amd.com>
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

Hi Michal,

On 6/13/25 09:59, Michal Simek wrote:
> 
> 
> On 6/13/25 09:38, Jerome Forissier wrote:
>>
>>
>> On 6/12/25 18:49, Tom Rini wrote:
>>> On Thu, Jun 12, 2025 at 05:32:41PM +0200, Jerome Forissier wrote:
>>>
>>>> Add a script to help build a functional U-Boot binary for the ZynqMP
>>>> Kria KV260. Also add some documentation.
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>
>>>>   doc/board/xilinx/index.rst        |  1 +
>>>>   doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>>>>   tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>>>>   tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>>>>   4 files changed, 167 insertions(+)
>>>>   create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>>>>   create mode 100755 tools/zynqmp_kv260_build.sh
>>>>   create mode 100755 tools/zynqmp_pmufw_elf_convert.py
>>>
>>> Helper build scripts don't belong in the tools directory. If they're
>>> super helpful, I don't object to adding them to
>>> u-boot-extras/contrib/<you>/ directory.
>>
>> OK
>>
>>> But there's a number of
>>> documented examples already on checkout and build TF-A then do ... for
>>> your platform.
>>
>> There is doc/board/xilinx/zynqmp.rst which deals with quite few ZynqMP
>> boards but not the KV260. In addition, it has a number of shortcomings:
>> - It mentions pmu.bin but does not say where to get if from
>> - It doesn't say how to build TF-A (bl31.bin), some very specific build
>> options are needed.
>> - I consider that detailed build instructions belong in things called
>> scripts or Makefiles, that were invented long ago exactly for that
>> purpose :) IMO the documentation should tell the bare minimum and ideally
>> be unnecessary.
>>
>> I am not particularly proud of the fact that I spent more than a whole
>> day trying to get U-Boot master to boot on my KV260, and without the help
>> of Michal, no doubt I would still be trying... So, how about I submit the
>> zynqmp_kv260_build.sh script to the u-boot-extras/contrib/<me>/ directory
>> and just point to it in doc/board/xilinx/zynqmp.rst?
> 
> no issue from my side.

OK so here you go:

From a429f6563fc5f1433a2df8eabe6a42a98864701b Mon Sep 17 00:00:00 2001
From: Jerome Forissier <jerome.forissier@linaro.org>
Date: Fri, 13 Jun 2025 13:39:10 +0200
Subject: [PATCH] contrib/jforissier: add zynqmp_kv260_build.sh

Add a build script for the AMD/Xilinx ZynqMP Kria KV260 board.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 contrib/jforissier/zynqmp_kv260_build.sh | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 contrib/jforissier/zynqmp_kv260_build.sh

diff --git a/contrib/jforissier/zynqmp_kv260_build.sh b/contrib/jforissier/zynqmp_kv260_build.sh
new file mode 100755
index 0000000..967c946
--- /dev/null
+++ b/contrib/jforissier/zynqmp_kv260_build.sh
@@ -0,0 +1,42 @@
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
+[ -e bl31.bin ] || {
+  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2025.1/kv260-kria/bl31.elf
+  aarch64-linux-gnu-objcopy -O binary bl31.elf bl31.bin
+  BL31_LOAD_ADDR=$(aarch64-linux-gnu-readelf -l bl31.elf | awk '/Entry point/ { print $3 }')
+}
+[ -e pmufw.bin ] || {
+  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2025.1/kv260-kria/pmufw.elf
+  llvm-objcopy -O binary pmufw.elf pmufw.bin
+}
+[ -e pmu_obj.bin ] || {
+  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2025.1/kv260-kria/zynqmp_fsbl.elf
+  aarch64-linux-gnu-objcopy --dump-section .sys_cfg_data=pmu_obj.bin zynqmp_fsbl.elf
+}
+[ -e .config ] || {
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

> 
> 
>>>> diff --git a/tools/zynqmp_pmufw_elf_convert.py b/tools/zynqmp_pmufw_elf_convert.py
>>>> new file mode 100755
>>>> index 00000000000..b4eb2695831
>>>> --- /dev/null
>>>> +++ b/tools/zynqmp_pmufw_elf_convert.py
>>>> @@ -0,0 +1,96 @@
>>>> +#!/usr/bin/env python3
>>>> +# SPDX-License-Identifier: GPL-2.0+
>>>> +# Copyright (C) 2025 Linaro Ltd.
>>>> +#
>>>> +# Written by Gemini (Google AI) then reviewed and edited to remove some comments
>>>
>>> I'm glad this calls out where it's from. I'm not comfortable for a
>>> number of ethical reasons on taking LLM-generated code. I'm also a
>>> little surprised we don't already have something like this with binman
>>> today?
>>
>> Nervermind. 'llvm-objcopy -O binary pmufw.elf pmufw.bin' works just
>> fine :) so I'll use that instead. Note that the binutils objcopy
>> cannot be used because it is target-specific and the MicroBlaze
>> version is not so easily available. While LLVM supports many targets
>> natively.
> 
> yes/no. Toolchains are wired via buildman already and available at kernel.org.
> Connection to llvm is adding another dependency.

My main development setup is Ubuntu, and 'sudo apt install llvm' is easy.
buildman is certainly fine for many things (like building a bunch of commits
and platforms), but I quite like being able to simply run 'make' once the
initial setup is done. OK in this case that is 'make BINMAN_ALLOW_MISSING=1',
but close enough.

> 
> I think putting this script to u-boot-extras is fine. To upstream u-boot could be more problematic because as I mentioned there are some issues with the way you use. You should be able to take bl31.elf from soc-prebuilt-firmware repo too.

Good suggestion indeed.

> You can also look what Neal did in buildroot to get it work which is better place for building tfa and putting images together from different locations.

Do you have a link? I am a big fan of buildroot for small developments setups.

Thanks,
-- 
Jerome

> Thanks,
> Michal
> 
> 
> 
> 
