Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E49C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE26082CA0;
	Fri, 13 Jun 2025 14:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="axpzS+gp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B43282CA6; Fri, 13 Jun 2025 14:25:17 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC8C82C65
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so12689755e9.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749817515; x=1750422315; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dm1cVDXVQdgjBBraQF00lu5Pm3GqSNftXvl5cSwz7ZQ=;
 b=axpzS+gpHGg7XjBKu5bSKq9AYw1YPvwvKgVWyx/XrnBuhwucrKluCkP+Ii5kJpRvBT
 6u39PGi2Szk+/dUEYIDhxHhoxGeyQkhyFJwjyzDjkZsckSvTPccRn50xnlO9T+5uQzu2
 C5Dbidf/PtIqe7q7f/agu6DX/PxQNy7etYFD48zAZEGkTWiehVD1CxkP0b4C02dK0edf
 g9nWSb94Id0in4ZqK2a2EwSgB/xOKITWYgjzQLRN/fIIx+ICwK/R8RCIdGuzm0ZCJREG
 nGBnj5X6BM9lW6z7qR60PjFbqZUhKccDCclc4hURJ7BRwsjKLc8VxZZ81UAA6PExOQLc
 Rvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749817515; x=1750422315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dm1cVDXVQdgjBBraQF00lu5Pm3GqSNftXvl5cSwz7ZQ=;
 b=bczpdzSUqV82N2eQT1DpOh/W6IybmleMr/qoVAssjNsZNVhBTqgtJLItQpE5z8jCqd
 svRXVOGz63V1QK3cu7e80mjJGYXLHN6mPQbKhOyL7VQKPVNq/4eTNu19SWF2h+PNUdB/
 CzfZ+IjugprtavtpFX0GztO3saRucLvq8oqprNPraifAlrmw8TJVTu/6J/5L0xWrzWno
 Yxp3VfwMerF0gqWD7SFYHqPh6o13HEUCC0pDjzHlKi0YlJce4gEjeNJWBY1Cv/uM4qXf
 0hG/3Nt26KuGyx8CWXtYzVxTPgUnDJZxVbKtHXR1tnFm7U08gh4ZTCEneg3XEt4WUB36
 Hzwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9wVU26fkgFzQXrcCcn3T1O83TvuFw4WGh15+WJzy2MyNmnTjHDP/xYnjAvD643+ZdEBWTGXI=@lists.denx.de
X-Gm-Message-State: AOJu0YxY/AtGYDROdX6xdnDDaE3J5yU2oRqQs9AzMbEnEb0Qzd0YWqRQ
 aET5X7qp8MkwY4Vlo+57G7a51I1+KjX//NRzuVqwTaH5rZWBHlWrUIjthLxmXyCDtes=
X-Gm-Gg: ASbGncuNrjPdUtA+uhED5vxG0ScU1hSp9enzODKEkEaYW4sYO6w0p///f8KQ6QUE+GO
 BqbQrhj4YfKWiPCdJ4g2Vu7rKSJ94zUNDziiXR4hXMuJXzUda/Zjws+j9n2CFRU/Px0w45ii0j6
 RScfqajHBwUC34TmsxX6Pb4iVsoVN6dpVh1OAGcKvWNLOjrTvRgRiN1/0WfxEqZ+pOMDuqt4cAO
 E8HabEB9M709npxPcY6cInmvbkhp1svhij7viP5aPLyI/04SKo5kBTRm8HDQFtyP20X7siGsE0z
 r63Yppid9nIuKE0Ipt6ctNC9XEi16mrEX0baaSD/d7ao+fUYfAdLUV9uxnszcgd5bioUxz15JQe
 Js9Um6hyH/ed4C5de14Rsp8Tpe2pRYIvZuCoU5THaRw==
X-Google-Smtp-Source: AGHT+IGXOBti54N95WOeP/mkT0LBbqwCPCVU7izsgSa28XzDo8dQx6TdqDEQnm6L0s8+7LBMsPLihQ==
X-Received: by 2002:a05:600c:c163:b0:448:e8c0:c778 with SMTP id
 5b1f17b1804b1-45334ad8ebdmr27846705e9.22.1749817514704; 
 Fri, 13 Jun 2025 05:25:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:5fcb:93f2:a702:e5b2?
 ([2a01:e0a:3cb:7bb0:5fcb:93f2:a702:e5b2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232b68sm50269395e9.10.2025.06.13.05.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 05:25:14 -0700 (PDT)
Message-ID: <79cac2b5-630b-49b0-a4d3-54e7af2d605d@linaro.org>
Date: Fri, 13 Jun 2025 14:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
To: Michal Simek <michal.simek@amd.com>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
 <7dd048ed-4f8b-4318-88d4-3bdf14f961b2@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <7dd048ed-4f8b-4318-88d4-3bdf14f961b2@amd.com>
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

On 6/13/25 09:55, Michal Simek wrote:
> 
> 
> On 6/12/25 17:32, Jerome Forissier wrote:
>> Add a script to help build a functional U-Boot binary for the ZynqMP
>> Kria KV260. Also add some documentation.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>
>>   doc/board/xilinx/index.rst        |  1 +
>>   doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>>   tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>>   tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>>   4 files changed, 167 insertions(+)
>>   create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>>   create mode 100755 tools/zynqmp_kv260_build.sh
>>   create mode 100755 tools/zynqmp_pmufw_elf_convert.py
>>
>> diff --git a/doc/board/xilinx/index.rst b/doc/board/xilinx/index.rst
>> index 2e31fe3f3a4..3f3a85b709c 100644
>> --- a/doc/board/xilinx/index.rst
>> +++ b/doc/board/xilinx/index.rst
>> @@ -9,4 +9,5 @@ Xilinx
>>      xilinx
>>      zynq
>>      zynqmp
>> +   zynqmp-kv260
>>      zynqmp-r5
>> diff --git a/doc/board/xilinx/zynqmp-kv260.rst b/doc/board/xilinx/zynqmp-kv260.rst
>> new file mode 100644
>> index 00000000000..219bbd602e9
>> --- /dev/null
>> +++ b/doc/board/xilinx/zynqmp-kv260.rst
>> @@ -0,0 +1,27 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +..  (C) Copyright 2025 Linaro Ltd.
>> +
>> +ZYNQMP KV260
>> +============
>> +
>> +Building
>> +--------
>> +
>> +To build for the KV260:
>> +
>> +   $ ./tools/zynqmp_kv260_build.sh
>> +
>> +The first invocation will fetch and build some required binaries (bl31.bin,
>> +pm_cfg_obj.o, pmufw.bin). Subsequently `make` can be invoked directly as
>> +follows:
>> +
>> +   $ export BL31=bl31.bin
>> +   # export CROSS_COMPILE=aarch64-linux-gnu-
>> +   $ make -j$(nproc) BINMAN_ALLOW_MISSING=1
>> +
>> +Flashing
>> +--------
>> +
>> +Press the FWUEN button on the carrier board, the press and release the RESET
>> +button, then release FWUEN. Connect to the embedded HTTP server and upload
>> +`qspi.bin`. Press and release RESET again.
>> diff --git a/tools/zynqmp_kv260_build.sh b/tools/zynqmp_kv260_build.sh
>> new file mode 100755
>> index 00000000000..3cf7147e3a6
>> --- /dev/null
>> +++ b/tools/zynqmp_kv260_build.sh
>> @@ -0,0 +1,43 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +# Copyright (C) 2025 Linaro Ltd.
>> +
>> +set -ex
>> +
>> +if [ "$1" == "-c" ]; then
>> +  rm -f bl31.bin pmufw.elf pmufw.bin pm_cfg_obj.c pm_cfg_obj.o
>> +  exit 0
>> +fi
>> +[ -e bl31.bin ] || {
>> +  ATF_SRC=$(mktemp -d /tmp/arm-trusted-firmware.XXXXXXXXXX)
>> +  git clone https://github.com/ARM-software/arm-trusted-firmware ${ATF_SRC}
>> +  make -C ${ATF_SRC} -j$(nproc) bl31 CROSS_COMPILE=aarch64-linux-gnu- \
>> +      LOG_LEVEL=40 ZYNQMP_CONSOLE=cadence1 CONSOLE_RUNTIME=cadence1 \
>> +      RESET_TO_BL31=1 PLAT=zynqmp ZYNQMP_ATF_MEM_BASE=0x10000 \
>> +      ZYNQMP_ATF_MEM_SIZE=0x2ffff ENABLE_LTO=1
> 
> As I told you this is shortcut. Recommendation is to put TF-A to OCM with FSBL.
> That's why there are some challenges in connection to fit both of them there.
> 
> Another thing is that none is creating reservation for TFA in DT. When you boot Linux than there is big chance that user application will rewrite TF-A and you break your platform because of missing protection.

OK. What if the bl31.elf from soc-prebuilt-firmware is used? It has load address
at 0xfffea000. Is it on-chip memory? Is this area protected from access by the
Linux kernel in the DT?

> 
> 
>> +  cp ${ATF_SRC}/build/zynqmp/release/bl31.bin .
>> +  rm -rf ${ATF_SRC}
>> +}
>> +[ -e pmufw.bin ] || {
>> +  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2023.1/kv260-kria/pmufw.elf
> 
> Better to use 2025.1 version.

Will update.

> 
>> +  ./tools/zynqmp_pmufw_elf_convert.py pmufw.elf pmufw.bin
>> +}
>> +[ -e pm_cfg_obj.o ] || {
>> +  wget https://github.com/Xilinx/embeddedsw/raw/refs/heads/xlnx_rel_v2023.1/lib/sw_apps/zynqmp_fsbl/misc/pm_cfg_obj.c
> 
> This is any generic configuration which is not aligned with standard firmware. It means yes you can use it but it is missing SOM specific configuration. It means for example power off don't need to work. Also this can work on kv260 only but don't need to work on kr260.
> 
> My way is to extract it from released fsbl instead but up2you.

I will do that in the next version. I will reply to your other reply.

Thanks,
-- 
Jerome

> 
> M
