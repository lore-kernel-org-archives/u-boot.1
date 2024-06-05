Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143CCC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 12:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE2988313;
	Wed,  5 Jun 2024 14:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kvwz8TvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E4688361; Wed,  5 Jun 2024 14:42:15 +0200 (CEST)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D4A88313
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 14:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x241.google.com with SMTP id
 38308e7fff4ca-2eaad2c673fso55152541fa.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717591332; x=1718196132; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fmF10L/mjBlo+h6cUuN44vHWfEcO1g/S9aKOWUdAZ9c=;
 b=kvwz8TvWR9B4w27nmhkw0+en63upSFctqI8XdRMcorobPRmZaH8CESajU2NNkVXk84
 u7ceQqJ1wCKLDSdVKn6FcOEmtwFYDmntr4ovH8qqAl1Wei9U3pRUv7GejvVvlw8BtkGH
 MszL2wbc2hBNcOg4WN2Y3a1325w1D49Gf3rZsRru0390QScNSKNriydjQqVKjTS4IY7a
 sfz7LXaVBM8OxX1lc/OIS6JTk0IGJg/omIUmsFEy26YjYQeTPk0cu1Gut/05U7JsFtJH
 Gkn8Q3Uv0NoVC0tCgjUtiKdjgAzCZz6q6I3uzi3xFl29MdjNCGfKGYetOmeurQK4Nqjp
 FEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717591332; x=1718196132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmF10L/mjBlo+h6cUuN44vHWfEcO1g/S9aKOWUdAZ9c=;
 b=E9cfLA5GXh7KnFSTohII+LIsNYnQz3TWbnFhfHyatsNBjw0HCxWOQtdfwYWZYGJXoX
 AHpa4n0xl5ZKMzUguSsOR70cesHKPHpYHaY7yxmQX/Y8aQF9Q4Imd2xPqs7yFxP5mONV
 Rqe56/WpmXhf/iCKL9NeRGjsxhDhdRz3xuEboMO4b/Pxkw0Jt3r+daN5joERVq3fHGJf
 IqJpCNL9rbx0lMjQLtXsdsEI0obiGHJWChYbyTzcVBm99oloMhFja7e+asWERJcAaitr
 qyWtvN9YS39VpFUQn5s2un31ASQd1VRG/TpcWQxZ95cMlQvmfD77XaT0hN750csjebYf
 GZQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLLSS2d6x5rQW4gT5b291pdldp744CDHZeBQ6esUlJsUi6OLH/SDrO4k0ZyWtHyb8cLrO9xu3MTwzjy5IzwdN+m5qZhw==
X-Gm-Message-State: AOJu0YwhKmorGC20JxUztaP6XXOxRYQYbTff4tUnJGJoHRgusu2XslJZ
 Eydp2fz7aPzwoOj6Y4NwrU+Z6Gf6ezyKI0lt2NJ423Z0rCUgtaqwlRy3pbVYJGM=
X-Google-Smtp-Source: AGHT+IGAzVdQguOK7sbnn3lEXc4AnkSAbX8+vzJMaOm0Dsr1JYBSPqcJAapl2MnQG35yb1fo8kfwxw==
X-Received: by 2002:a2e:9154:0:b0:2e0:da20:2502 with SMTP id
 38308e7fff4ca-2eac7a8029dmr17401831fa.49.1717591331709; 
 Wed, 05 Jun 2024 05:42:11 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ea91cc7d25sm17658591fa.79.2024.06.05.05.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 05:42:11 -0700 (PDT)
Message-ID: <22924b95-5181-4aa8-9014-9a030ee7fea3@linaro.org>
Date: Wed, 5 Jun 2024 14:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] qcom: implement capsule updates
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
 <CAFA6WYP-1tuELgthx=Ky9JYAkgP0mRNEsnHdw2ZmnjHXMAm8Rw@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYP-1tuELgthx=Ky9JYAkgP0mRNEsnHdw2ZmnjHXMAm8Rw@mail.gmail.com>
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

Hi Sumit,

On 05/06/2024 07:31, Sumit Garg wrote:
> Hi Caleb,
> 
> On Mon, 3 Jun 2024 at 18:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hook up support for capsule updates loaded from disk on Qualcomm
>> platforms.
>>
>> Most Qualcomm devices have an A/B partition layout, with most partitions
>> duplicated. The metadata on which slot is active is stored in the GPT
>> headers in the vendor-specific attribute bits of each partition.
> 
> It's good to see capsule updates support coming up for Qualcomm
> platforms. AFAICS, with this series we only update U-Boot on the
> current active partition. IOW, real A/B support is still not
> supported. Do you think it is possible for U-Boot to update metadata
> in GPT headers and for proprietary bootloaders to pick up the U-Boot
> from the updated partition?

Yes this would be possible, I have some WIP patches to let us modify the 
slot attribute bits and write back the header.

The reason I haven't implement A/B is because we don't support it from 
the OS level on any of the boards I work on. We often patch ABL to 
disable or skip the slot logic and flash a partition table without 
slots. It also unlocks a bunch of additional complexity...

This isn't super high on my todo list but I'd be happy to help if 
someone wants to enable this functionality. We'd need:

1. Upstream support for modifying the GPT (see my PoC at [1] and [2]).
2. Logic to configure flashing the active or inactive slot

This logic would have to run after the capsule update, I don't know if 
there is currently a way to add a callback after the update.

If we enable updating other images (like XBL, hyp, tz, etc), we would 
need to either agree that a capsule update would have to update ALL 
partitions, or implement logic to copy over partitions that weren't 
flashed to the other slot.

[1]: 
https://git.codelinaro.org/linaro/qcomlt/u-boot/-/commit/34d3de6f79550527746303e0bf6337fa37e31fe5

[2]: 
https://git.codelinaro.org/linaro/qcomlt/u-boot/-/commit/656d9e816bef85e586460a999cc7874255be9f1d
> 
> -Sumit
> 
>>
>> Add support for reading this attributes via the disk_partition struct
>> and using them to determine which boot partition U-Boot is flashed to
>> and generate the appropriate DFU string.
>>
>> This logic is gated behind a check to ensure that U-Boot is actually
>> being chainloaded and not run via some other mechanism.
>>
>> SCSI support for most Qualcomm platforms is not yet enabled upstream,
>> but will follow in future patches.
>>
>> This series enables capsule updates on the RB2, however [1] is required
>> for it to work properly (as otherwise MMC won't be available).
>>
>> [1]: https://lore.kernel.org/u-boot/20240527-b4-clk-stub-v2-0-29013855e343@linaro.org/
>>
>> To: Tom Rini <trini@konsulko.com>
>> To: Simon Glass <sjg@chromium.org>
>> To: Lukasz Majewski <lukma@denx.de>
>> To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> To: Caleb Connolly <caleb.connolly@linaro.org>
>> To: Neil Armstrong <neil.armstrong@linaro.org>
>> To: Sumit Garg <sumit.garg@linaro.org>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: u-boot@lists.denx.de
>> Cc: u-boot-qcom@groups.io
>>
>> Changes in v3:
>> - Address comments in scsi dfu support
>> - enable CONFIG_DFU_SCSI for qcom
>> - Link to v2: https://lore.kernel.org/r/20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org
>>
>> Changes in v2:
>> - Add qcom capsule update support patches
>> - Link to v1: https://lore.kernel.org/r/20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org
>>
>> ---
>> Caleb Connolly (8):
>>        dfu: add scsi backend
>>        disk: expose partition type flags
>>        mmc: msm_sdhci: work around a bug when writing
>>        mach-snapdragon: implement capsule update support
>>        qcom_defconfig: savedefconfig
>>        mach-snapdragon: use SYSRESET_PSCI
>>        mach-snapdragon: bump up heap size
>>        qcom_defconfig: enable capsule update support
>>
>>   arch/arm/Kconfig                          |   2 +
>>   arch/arm/mach-snapdragon/Kconfig          |   3 +
>>   arch/arm/mach-snapdragon/Makefile         |   1 +
>>   arch/arm/mach-snapdragon/board.c          |   8 +-
>>   arch/arm/mach-snapdragon/capsule_update.c | 147 ++++++++++
>>   arch/arm/mach-snapdragon/qcom-priv.h      |   6 +
>>   configs/qcom_defconfig                    |  19 +-
>>   disk/part_efi.c                           |   1 +
>>   doc/usage/dfu.rst                         |  32 +++
>>   drivers/dfu/Kconfig                       |   7 +
>>   drivers/dfu/Makefile                      |   1 +
>>   drivers/dfu/dfu.c                         |   5 +-
>>   drivers/dfu/dfu_scsi.c                    | 435 ++++++++++++++++++++++++++++++
>>   drivers/mmc/msm_sdhci.c                   |   7 +
>>   include/configs/qcom.h                    |   5 +
>>   include/dfu.h                             |  26 ++
>>   include/part.h                            |   1 +
>>   17 files changed, 695 insertions(+), 11 deletions(-)
>> ---
>> change-id: 20240523-b4-qcom-capsule-updates-ea2e4f8f0ff0
>> base-commit: 5d8881a0801241d68701e8644d495f1d535506f0
>>
>> // Caleb (they/them)
>>

-- 
// Caleb (they/them)
