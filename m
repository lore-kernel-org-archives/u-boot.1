Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979D1C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 07:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD148334A;
	Thu, 31 Jul 2025 09:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="mvrDs0Z7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC09833E1; Thu, 31 Jul 2025 09:26:06 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E80D8318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-af0dc229478so95185066b.1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1753946762; x=1754551562;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=i0tXoGUUcnUStcYrzhVn51Kg4NJukyLHpTXfgSiQGko=;
 b=mvrDs0Z78r34//ncm0MaGgCoXGEd+aASVaQ8AoKgeX56Ze6TyGdszOJvtQpD6tT9+i
 DTyFDCRMDHGASzA0bJPcxin1MXXTLSNDjTES6ZFKxZEFMaZrP9CjJ2Fpb9LJoYuhR1nj
 sAGgERFwlbzXWVlmSBydmrLDQQsV1ujc2twLB+aUH1Sa8pfwOQBgBRdlLQFUCULOmOyM
 Yub5Fs+I9C8dPsNRZq8ZlrnMCCkV4im8CarP9b/jDbJA7X5XTU+BKojsALo4Q0/Ox9hW
 mF/y8S0vgXZgLCGe3E6smEnb8RJeVxNEw5eO64tLvh8OKnhcq2yyxAVS5t7HDy4eYK4f
 nPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753946762; x=1754551562;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0tXoGUUcnUStcYrzhVn51Kg4NJukyLHpTXfgSiQGko=;
 b=wsXOLoLZDHxc/PDeOtksPTFYWESCnj8PiqAe0bzzJ96FN/6yAQVt8uwxqtvzcKe2r8
 BYWLO64NZJdyFpdVMnDnPHAXFIUeIydp3KFTumawtAtfq7RHMwuLp8W43SS3CFMfwF17
 9iRgEJihS13yM3+6rbg3fGrwt75NHprLy+5MZKftF15rdptTiEM3B7yDhi5MPLGl0vW7
 +12rpNoKAPnMGtIl8Lhkm2WogkomSeFeZdQXvrLRzIfMd7iAfnwBCXjjy1r53smieYMg
 vO7XFXKgjWAreVfOJcYetjcx2isMfoK+qbYKa5PIV8rQ4Y5annyziFwsTcmkqTl5p7I4
 2JUg==
X-Gm-Message-State: AOJu0YwUm1WgreoAPmqWXQmI4i00BiKhbFfhlJmM0814dBwhtPfdNqAE
 kln14rvPG0CJOC5CzQXfDBvmWVfldMEUbTWnIp7bc9BFCp70pdtgV04HQ5VJF+6tRQ==
X-Gm-Gg: ASbGncsAnFHnvvt80F9PSt7kH2GJGg4yIo9PNfm13dnddfY8ioqgB0zicmWj2nC5mUK
 0Ty2wu+6TYXOX31s/qH4QBaNtAHCqf2uE+R8We9Gqr/YBYJChfljW05jSfywYMgsl5WXa/ckvvo
 mKwSFNnjhVjPss4yfbt8VEZRhWCx8LX1NiOjbQMpPcq7pSD8GE6gm4JzHjWi3cMwpjeG+RP6DVw
 bSw/vf7EvlmuQa8EC4SONXe9McEU36pjnjd6yO403BF4t6sqq47bFvFag8WTYP6Q6eY8bEWeQQi
 DC4wfCZgMJw/f4qh2v4txKXCTMg7XcCqH7B6sQ5nLU4ibdUrhTtFCAgrI7+DNFUMgIl5/btBQB+
 yub6Qz0QAyK+YoCSa7ilWuJGODup1MX0Jfn0=
X-Google-Smtp-Source: AGHT+IFYTYs0mTGOa2WNxbz1Gj38/wXLQmToqRUbQwo25YJ1n0i+noC6bkp6UEqsO6gWHgihZcXQOA==
X-Received: by 2002:a17:907:971e:b0:ae0:a116:b9d3 with SMTP id
 a640c23a62f3a-af8fda92edfmr701958766b.60.1753946762173; 
 Thu, 31 Jul 2025 00:26:02 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a21c0afsm64046766b.117.2025.07.31.00.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 00:26:01 -0700 (PDT)
Message-ID: <f4febb56-8a92-4798-9b21-728e65afbe32@monstr.eu>
Date: Thu, 31 Jul 2025 09:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] CI: Wire mbv32 combinations
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Adriano Cordova
 <adrianox@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>
References: <dc52619a474c6374d43e7fb232480cab3392b00a.1753874707.git.michal.simek@amd.com>
 <20250730172330.GT1807455@bill-the-cat>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250730172330.GT1807455@bill-the-cat>
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



On 7/30/25 19:23, Tom Rini wrote:
> On Wed, Jul 30, 2025 at 01:25:09PM +0200, Michal Simek wrote:
> 
>> After upgrading to QEMU 10 by commit 1d782a3f229c ("Docker, CI: Update to
>> latest Ubuntu and Dockerfile") let's wire mbv32 which is the part of QEMU
>> to have it under regression.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> gitlab I have tested.
>> azure I didn't test it but did blindly all changes as they are in github
>> one.
>>
>> This patch has be applied on the top of this series
>> https://lore.kernel.org/r/cover.1753182218.git.michal.simek@amd.com
> 
> For v2, take this via your tree.
> 
> [snip]
>> ---
>>   .azure-pipelines.yml | 20 ++++++++++++++++++--
>>   .gitlab-ci.yml       | 32 ++++++++++++++++++++++++++++++--
>>   2 files changed, 48 insertions(+), 4 deletions(-)
>>
>> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
>> index 8209d2b329cb..76a0ba097f93 100644
>> --- a/.azure-pipelines.yml
>> +++ b/.azure-pipelines.yml
>> @@ -258,11 +258,11 @@ stages:
>>             ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
>>             ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
>>             ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
>> -          if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
>> +          if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]] || [[ "${TEST_PY_BD}" == "xilinx_mbv32_smode" ]]; then
> 
> You missed an escape here and it should be:
> "\${TEST_PY_BD}" == "xilinx_mbv32_smode"
> 
>>                 wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>>                 export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
>>             fi
>> -          if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
>> +          if [[ "\${TEST_PY_BD}" == "qemu-riscv64_spl" ]] || [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]] || [[ "${TEST_PY_BD}" == "xilinx_mbv64_smode" ]]; then
> 
> Same here.
> 
> The rest of the Azure side looks right.
> 

Sent v2 with this fixed and yes will take it via my tree.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

