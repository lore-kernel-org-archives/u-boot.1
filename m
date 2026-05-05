Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA70DCD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 145BD848BB;
	Tue,  5 May 2026 14:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JTSGdEGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0334848C2; Tue,  5 May 2026 14:25:07 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83407848B8
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so75590665e9.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777983903; x=1778588703; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kdfrNwicYvmoQdfDa4i9FHSFDTWErg85j9bffTqRHyc=;
 b=JTSGdEGl5gXRCYPsCC/39eKwbvfm3evWV239y5EQB199dWVt6dzWBm9yuO+qFdsuN9
 PwWefe0hjMUB3KvrYZI9NI3X6IuMMDoYjw7YPm0LRr0nzL49H6ipAjJb0019LAmjQJDY
 X21iZ1LkxbWCqa6GNsDv0//siSBqcJ/PJB8Woy0VrtqYu+b8f2JrXhhnpGm66/XAWo5v
 EdCgIIFaaeeGVYAH5yR99HyLurewJJCBHoKUEPPmIOBPiC0lUL16GDLky1HiPWnxGw/w
 hvMkrpjQGR0UjAjXo3NwN8aQokwEeG2eWsoJhnuN1vgQAftO2QthLnUG+qCZHEVpFHJ+
 Jtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777983903; x=1778588703;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdfrNwicYvmoQdfDa4i9FHSFDTWErg85j9bffTqRHyc=;
 b=M6QkxlouW0UjMAnTU3F4aZlktpYqkWrCSnSM5DCDHdpQAfYeXlEtHIGb0wwWQIudLh
 Fgq4rRkVaO1LJ79yULQUwkRDUjCafxhAA8A6a6PtyE9sSiGs0i3bj1madfo7h5BGAS7C
 nM3mFl+RemK3/l+XeD4KmtzpSB8nTAkVe+CBs9Bgdp44r9FdzJdofjapWFk1pVxY+a1j
 R8bqvyvwnAXZjg43PSPWmk97TOnVOal2uXTAX0jaV4KRf5oGX2pr1GK4XXBBE7s8p675
 A6HUAGjml27nUtJo7iXL0IpE93PTV+MPR8xuSLblq9LT4+imlTFgNhwBLm3cM4Vm/rek
 G2uw==
X-Gm-Message-State: AOJu0YyQRUFT3OmBt0ns8jHTg4/UjqdT9Sq7b+NzHJOBBFX0EPsCMil0
 UVzt2/9aFhvHndWyFBUslQfF9qFjq1J5W5Y6PUAo4J53s8f9ikJqd041V/z3sH92bTU=
X-Gm-Gg: AeBDies8yKvZMN5n7qPfvmHXVp1LEiIIN/ffwOiS6aLL4+mmERjLoB61Q/64J9i80d+
 iTfk7vnIoGqowC8o1VAatbJZ9fuH6Nz0Xh/TPsv7PLTagP52jumXb0Q8YI3wipZD6Mr2rxHwMYo
 zGDci67Qn5d96MkF32vvzXf8e2o5U5PbrKYC768bJtdZAVZIm21zSTj4Eg4MIaCFUunUR1iXhRZ
 plQeOZ3S7nj1JQ45EPmZRWurv8wuTm1STN3lKZSdVCyu2uGltJpDmZO2GJ9U7Vl9/znV/4h7AKq
 Vc15Rg28Ifue/33AL1MhJVK1yc/l9mnq2bN+oJHkOqK2nPE7i2tB+faRirt97PAnsM7QtfjAMZh
 XUqbuhamJetb/CkLhpJM/+W5YaeUTdyC7pIhqxWVX/sgME8au6Or+UxiYvWVbqrsF5U3Pzl+TK7
 87KvxytQeFH4ZptS6LucAW8GdMNpR5RnWCC3xhAI3yNamOXt1H7+iqq6mTPhkfPCDALMg+xhBYo
 Rw2
X-Received: by 2002:a05:600c:8b11:b0:48a:53ea:13eb with SMTP id
 5b1f17b1804b1-48d186dc79bmr44967735e9.5.1777983903488; 
 Tue, 05 May 2026 05:25:03 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c865esm387452105e9.5.2026.05.05.05.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 05:25:02 -0700 (PDT)
Message-ID: <21d5d2a1-e904-44b0-92c2-378035e158c0@linaro.org>
Date: Tue, 5 May 2026 14:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] qcom: smem: modernize SMEM in U-Boot
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <afnCVT5JoeIdy-hQ@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <afnCVT5JoeIdy-hQ@sumit-xelite>
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



On 05/05/2026 12:11, Sumit Garg wrote:
> Hi Casey,
> 
> Thanks for the much needed re-spin of the SMEM patch-set.
> 
> On Mon, May 04, 2026 at 08:57:28PM +0200, Casey Connolly wrote:
>> Smem is currently implemented a uclass in U-Boot. This carries with it
>> some implicit limitations about how and when we can actually talk with
>> it, since its modelled as a device.
>>
>> The SMEM uclass is qualcomm specific and has no other users, smem is
>> also largely useful for parsing the memory map and other tasks which we
>> have to do before DM is alive anyway.
>>
>> Let's drop the old smem code and replace it with a straight port from
>> Linux, providing a familiar interface and enabling us to access it much
>> earlier in the boot process than would be possible with a standard
>> udevice.
>>
>> Additionally, this will be easier to maintain going forwards since any
>> patches from Linux can be more easily ported over.
>>
>> With this new smem framework in place, we can now use SMEM to parse the
>> memory map when it's not provided via some other mechanism and to read
>> the serial number of the board.
>>
>> Implement this functionality and split the snapdragon memory parsing off
>> to its own file to try and organise things a bit better.
>>
>> Since the memory map stored in SMEM doesn't already have some carveouts
>> let's also be correct about unmapping reserved memory regions, we
>> should eventually do this on all Qualcomm boards but it's particularly
>> important when we aren't chainloading from ABL.
> 
> This was really needed to unmap reserved regions in U-Boot memory map to
> increase robustness.

agreed, the ~100ms cost sucks but I hope we can bring it down by doing
this after dcache enable if we can figure that out (would probably rely
on starting with an initial minimal map to avoid the prefetcher issues)
but yeah, a problem for the future for sure.

> 
>>
>> This depends on a fix for unmapping memory regions: https://lore.kernel.org/u-boot/20260504175511.585797-1-casey.connolly@linaro.org/
>>
>> ---
>> Changes in v2:
>> - Ensure reserved regions are unmapped appropriately when using SMEM as
>>   the source of truth for the memory map.
>> - Support SMEM ram layout v0/v1 for older platforms using a header from
>>   Qualcomm.
> 
> It would be better if you can provide proper attribution in the commit
> to which this header is being picked up.

Where is the header sourced from? I can't really use another patch
posting as a source.

> 
>> - Set an environment variable (memmap_source) providing info about
>>   where U-Boots memory map is from.
>> - Correctly handle serial_num missing on msm8916
>> - Link to v1: https://lore.kernel.org/r/20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org
>>
> 
> FWIW, I tested this patch-set on RB3Gen2 and lemans-evk after dropping
> the U-Boot DT overrides, so feel free to carry:

Good to know! I assume you removed the hardcoded DT memorymap for testing?

> 
> Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> I will give a proper review to this series soon.

Thanks
> 
> -Sumit
> 
>> To: u-boot@lists.denx.de
>> To: Sumit Garg <sumit.garg@kernel.org>
>> To: u-boot-qcom@groups.io
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Casey Connolly <casey.connolly@linaro.org>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Cc: Alice Guo <alice.guo@nxp.com>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
>> Cc: Raymond Mao <raymond.mao@riscstar.com>
>> Cc: Stefan Roese <stefan.roese@mailbox.org>
>> Cc: Philip Molloy <philip.molloy@analog.com>
>> Cc: Jerome Forissier <jerome.forissier@arm.com>
>> Cc: Marek Vasut <marek.vasut@mailbox.org>
>> Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> Cc: Rasmus Villemoes <ravi@prevas.dk>
>> Cc: Heiko Schocher <hs@nabladev.com>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
>> Cc: Antony Kurniawan Soemardi <linux@smankusors.com>
>> Cc: Luca Weiss <luca.weiss@fairphone.com>
>> Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>
>> ---
>> Casey Connolly (15):
>>       Revert "dm: SMEM (Shared memory) uclass"
>>       smem: drop drivers/smem
>>       Revert "test: smem: add basic smem test"
>>       Revert "drivers: smem: sandbox"
>>       mach-snapdragon: fix reserved memory carveout
>>       soc: qcom: import smem from Linux 6.11-rc2
>>       soc: qcom: smem: adjust headers for U-Boot
>>       soc: qcom: smem: adjust for U-Boot
>>       soc: qcom: smem: get serial number from socinfo
>>       soc: qcom: smem: stub functions
>>       soc: qcom: smem: add build infra
>>       mach-snapdragon: move memory parsing to its own file
>>       mach-snapdragon: support parsing memory map from SMEM
>>       mach-snapdragon: fetch serial# from SMEM
>>       configs: add qcom_sm8650_defconfig and debug fragment
>>
>>  MAINTAINERS                                  |   1 -
>>  arch/arm/Kconfig                             |   3 +-
>>  arch/arm/mach-snapdragon/Makefile            |   2 +-
>>  arch/arm/mach-snapdragon/board.c             | 253 ++++-----
>>  arch/arm/mach-snapdragon/dram.c              | 239 ++++++++
>>  arch/arm/mach-snapdragon/qcom-priv.h         |  17 +
>>  arch/arm/mach-snapdragon/rampart.h           | 194 +++++++
>>  arch/sandbox/dts/test.dts                    |   4 -
>>  board/qualcomm/debug-sm8650.config           |   5 +
>>  configs/qcom_sm8650_defconfig                |  16 +
>>  configs/sandbox64_defconfig                  |   2 -
>>  configs/sandbox_defconfig                    |   2 -
>>  drivers/Kconfig                              |   2 -
>>  drivers/Makefile                             |   1 -
>>  drivers/smem/Kconfig                         |  25 -
>>  drivers/smem/Makefile                        |   7 -
>>  drivers/smem/sandbox_smem.c                  |  44 --
>>  drivers/smem/smem-uclass.c                   |  46 --
>>  drivers/soc/qcom/Kconfig                     |   8 +
>>  drivers/soc/qcom/Makefile                    |   1 +
>>  drivers/{smem/msm_smem.c => soc/qcom/smem.c} | 777 ++++++++++++++++-----------
>>  include/dm/uclass-id.h                       |   1 -
>>  include/smem.h                               |  90 ----
>>  include/soc/qcom/smem.h                      |  36 ++
>>  include/soc/qcom/socinfo.h                   | 111 ++++
>>  test/dm/Makefile                             |   1 -
>>  test/dm/smem.c                               |  26 -
>>  27 files changed, 1186 insertions(+), 728 deletions(-)
>> ---
>> base-commit: 2920b49fb117dd70b6219804bf0d298c96f184f2
>>
>> // Casey (she/they)
>>

-- 
// Casey (she/her)

