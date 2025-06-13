Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79384C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 07:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B245B82C30;
	Fri, 13 Jun 2025 09:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WVVOCtrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADED782C44; Fri, 13 Jun 2025 09:38:52 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D4382C2F
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 09:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so954235e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749800327; x=1750405127; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2gb+L5G/bYi/sWgaig/InuQo3g+o69mDaUJ8nYBx9og=;
 b=WVVOCtrjnmS0uX2i9rl0Q3nNYz4UIp9OdF01Do86Mctel9v7qETbNN8qlbgKbIxKjz
 EM3r0V1vAG8i/tpGouEIGHMQ7XOhtaepOlZCCsKtaircz13eq6coDVXqkEkuEb8o8x9B
 9+lWEO8v9S6+9dGKNnzhSUu7PhMqLJ8ZyRCItoGuzUx3tWHcw/3yxU52AJzs71J4zN4A
 i3pA0vZoucLJWUrEX4d834HrkfVACJrNUYp28Hv5JxhmC9MxRF4z2cf3QZAm7q6mGloe
 cvXqfgwegi/csjkdwA5kSFkv0ShPP2nhLWEA9XIE2ZfmPwZkRgoClqZSdwQZNV42AuFv
 FZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749800327; x=1750405127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2gb+L5G/bYi/sWgaig/InuQo3g+o69mDaUJ8nYBx9og=;
 b=nREEzUjepYeCOxbauyz4Gp1dYk1ImChEU1Hu9cpIY1dPgVx92UrioiJkyZZN6WCTf7
 4kKUu6XrhlTi+STUrMtWsX3lM1d612P7oRbSHUBaUmyRGWseG8yCqunfGZttHbkBtd7t
 7tcqDliaS11mm7vi3Ib0P866WCSfr1avm4UCU1BpaAbYH5X7uzP81bYoCTc0wYm85lPi
 EH6++8FuJyFKUTdcO8QxfFv6KJSg5vbZ20a0DJcb7ryFGdO1Sp/RmHgAvQ+1ssQ9sjjH
 kGMxKC1RZLIUoQEav4zkN+WAfODYa2QfS3UN+cpkVEymOZ4vT793QLxTWp3AVk+qpvbb
 CRxA==
X-Gm-Message-State: AOJu0Yz/xvFrYfjKUtiW4iouBlWnKSFSsyoJM1fvm741ObbsGkB83r4H
 btvu+0s/ghFTzKzlKlQ2QTgRh3mH/jplB+Kn9T6FCODONI3gvnP/qYpXhqebGiBPPbTW4M/Z8/d
 wt11x
X-Gm-Gg: ASbGnctvQn0HZswn0qtn1Rj1WAbdb07hmfilu4mTISTmb9HMpl7Fe60QBD/jZGp+0CL
 HVqacRJD+lbTfBHtj6bEXah6+1wB3xjytSicxD3NxA7hye+c6guRv10pMSqPCxn5nFKWmhfTRWu
 QhV+Hx9EOvSTvp9rWVWxEkZ3f6EWQN8obtTsmid/Kq9uif85Vd2AlzvE+3BPwA+OJZmIc78O92M
 NsxNVFQt9KAKNvz8vQCgJ3yaoGrcg2GTzKZ7xU804JRSC/3Ovl65sY2NjdNzpAiJur0HVlptPVi
 cQ0c+IQLsXiAgvTie1V3QGIwyW+DWeVpgj1uBVGC8p6UdFBmObQx2FCY+4bZHa+DXqt8lsStjlE
 upBA37lrEsslCikXPPRuNssHb7O+tbr4QtGS1FEb4FA==
X-Google-Smtp-Source: AGHT+IGf0qZtUGe3I378IojmziFKq4XoEut/b3057+B30snVDtdTpMpqweRFExvn17IuIqZZMJJM8A==
X-Received: by 2002:a05:600c:6095:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-45334b0fc1emr18805845e9.14.1749800326812; 
 Fri, 13 Jun 2025 00:38:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:5fcb:93f2:a702:e5b2?
 ([2a01:e0a:3cb:7bb0:5fcb:93f2:a702:e5b2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e261a72sm42898425e9.38.2025.06.13.00.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 00:38:45 -0700 (PDT)
Message-ID: <b806f55f-da5a-4373-a6c2-15b1cab93da3@linaro.org>
Date: Fri, 13 Jun 2025 09:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
 <20250612164939.GO1382132@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250612164939.GO1382132@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 6/12/25 18:49, Tom Rini wrote:
> On Thu, Jun 12, 2025 at 05:32:41PM +0200, Jerome Forissier wrote:
> 
>> Add a script to help build a functional U-Boot binary for the ZynqMP
>> Kria KV260. Also add some documentation.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>
>>  doc/board/xilinx/index.rst        |  1 +
>>  doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>>  tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>>  tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>>  4 files changed, 167 insertions(+)
>>  create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>>  create mode 100755 tools/zynqmp_kv260_build.sh
>>  create mode 100755 tools/zynqmp_pmufw_elf_convert.py
> 
> Helper build scripts don't belong in the tools directory. If they're
> super helpful, I don't object to adding them to
> u-boot-extras/contrib/<you>/ directory.

OK

> But there's a number of
> documented examples already on checkout and build TF-A then do ... for
> your platform.

There is doc/board/xilinx/zynqmp.rst which deals with quite few ZynqMP
boards but not the KV260. In addition, it has a number of shortcomings:
- It mentions pmu.bin but does not say where to get if from
- It doesn't say how to build TF-A (bl31.bin), some very specific build
options are needed.
- I consider that detailed build instructions belong in things called
scripts or Makefiles, that were invented long ago exactly for that
purpose :) IMO the documentation should tell the bare minimum and ideally
be unnecessary.

I am not particularly proud of the fact that I spent more than a whole
day trying to get U-Boot master to boot on my KV260, and without the help
of Michal, no doubt I would still be trying... So, how about I submit the
zynqmp_kv260_build.sh script to the u-boot-extras/contrib/<me>/ directory
and just point to it in doc/board/xilinx/zynqmp.rst?

>> diff --git a/tools/zynqmp_pmufw_elf_convert.py b/tools/zynqmp_pmufw_elf_convert.py
>> new file mode 100755
>> index 00000000000..b4eb2695831
>> --- /dev/null
>> +++ b/tools/zynqmp_pmufw_elf_convert.py
>> @@ -0,0 +1,96 @@
>> +#!/usr/bin/env python3
>> +# SPDX-License-Identifier: GPL-2.0+
>> +# Copyright (C) 2025 Linaro Ltd.
>> +#
>> +# Written by Gemini (Google AI) then reviewed and edited to remove some comments
> 
> I'm glad this calls out where it's from. I'm not comfortable for a
> number of ethical reasons on taking LLM-generated code. I'm also a
> little surprised we don't already have something like this with binman
> today?

Nervermind. 'llvm-objcopy -O binary pmufw.elf pmufw.bin' works just
fine :) so I'll use that instead. Note that the binutils objcopy
cannot be used because it is target-specific and the MicroBlaze
version is not so easily available. While LLVM supports many targets
natively.

Thanks,
-- 
Jerome
