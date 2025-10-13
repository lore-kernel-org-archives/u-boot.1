Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB440CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 06:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2D98383F;
	Mon, 13 Oct 2025 08:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wvqUwWmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A338384E; Mon, 13 Oct 2025 08:45:07 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B98802C1
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so35465495e9.0
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 23:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760337903; x=1760942703; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6VDpPy/CqEzjot6PeGNhwAN+rnHS+IWDzzIgTkBY+9I=;
 b=wvqUwWmWVJeP7KIJ3Y0pKGTn60ivkOvwvpPri1ZPgmZH4GmrFC6XgnVm1uEvcVs+mu
 VGdKsXDHZhdJ4qgLzPTKtKi7jGQFFVH8i0EzC8boHYf8TG8lG916SdgPtRwTvalkCPgc
 6UiACXX36ELDbYQVuTUcDKhAbCzsjMN35iJn/sUnxJm65xi8VeftiG1SruvBDu2G8N34
 zZPSaU9gHTN5Ux7eofGnMJOZA1pGcS+i5ZRDjoyzMwAJVuRwI5a/ghGfLnwSWgLV2SkM
 1Uq3GLopaBHqTfQcA7u1zxVHnCY9d8S2gz90aB+768BxcoanTc/uR+8quV3BpVpajq8C
 1O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760337903; x=1760942703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6VDpPy/CqEzjot6PeGNhwAN+rnHS+IWDzzIgTkBY+9I=;
 b=j5Q2n8i4fQj3pRfk9P6VEiyri3CUKORgpb2LbK+4bb+zLeRSN6mn+VdE6A3qJ1oY3d
 xTotwfRReTw4hyYw9N8y4TjOrbEn/pVYO3zYelWjqRjJzLf7/4AxSiAEyYJCIMdLtjb9
 jMox63CP/fcv64tTqnTDbKjiWkKqQXudGp4PmfKEIRhs6EBo5piKlr5U0xKytyzQaJ9Z
 kJN6KszP6Cl/48nAEWiyNBwKzk1vOZSdr4uDiWm9t4i3BWCor92EXIZFDBGtRonKgcC3
 8mcWplI07UxuA99MUXElsGrWsE3A4rtTEGB/toSIylQ/mKx26uqoVuyBcvNddJbDSsPq
 SeaA==
X-Gm-Message-State: AOJu0Yxgbe+I3qdsyKyf+X+IyOT5c66whst31XOpewZct1Cy4vI5sVI8
 bv4oEhINrVz96pnCVtYrwBqBW1RVsr6do8ge96Te1pE96qdaUke+/DumRUgymWaX6IY=
X-Gm-Gg: ASbGnctIOwMhFktkEWWwkejLT/COkrKHyHrxN7jffyYWfyEJaDf1pFzYTit6CsAEjox
 pQ9b6M9PaDgOkRLykrZrks+5eB3Tyqc9IRx3s5m1O/7YD0V7VFmyrTTZw+O2cQ7U9i5KuO2AdwY
 cwWXx/WvpNx6KRnytm/tz6kic9kDIGK45yhITuvVleOLsvUXYYHhLT8r/+ZzJKzNy8V4lP9H8bA
 hOkzopxYjr7QcGikf4aryt620OBeN/5DAmPT3wlc14R5Luu0W506Y2FRop6iOQXRZ495VMBWe/v
 YWvpBksiBW/KjDhWrCGzUprxZG72f9yNABcQjqC6NV6UWfkprLMR4CWZlSanonOIpByr5sppOJ3
 S9MJG5x2BhjnhI5fqklp8wE3WltSd2NAYIIVLluQKrXGNs6L2x+9YFWh8+JEG3UCKAnKrAsWb06
 AkX5GYp3oVesgN2VtlMRm3QraafWVRNxmkF/UFhCPEIIrU4Q==
X-Google-Smtp-Source: AGHT+IHBqvP/FV+5EWLm41B5qxa95uk5576BH7lQC8K/d1EH8yCflV5+jNAYl2g0QKn9o+kRJytVeg==
X-Received: by 2002:a05:600c:5028:b0:46e:428a:b4c7 with SMTP id
 5b1f17b1804b1-46fa9af2ff1mr135029575e9.23.1760337903173; 
 Sun, 12 Oct 2025 23:45:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:2a9f:30fd:ab6a:203d?
 ([2a01:e0a:3cb:7bb0:2a9f:30fd:ab6a:203d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf6b4sm16755722f8f.25.2025.10.12.23.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Oct 2025 23:45:02 -0700 (PDT)
Message-ID: <0938299d-5985-45e7-bf47-43bb6154b3bf@linaro.org>
Date: Mon, 13 Oct 2025 08:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] docker: add OP-TEE and TF-A build for testing
 Firmware Handoff
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
 <20251010144517.3573014-2-raymond.mao@linaro.org>
 <91ea6f19-8a58-4890-9421-fdc5cd7f09e0@linaro.org>
 <CAEfUkU+aOmxUnwhq8dS-S-wPiSoregTM6HSRR5exhGTnZBK82A@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAEfUkU+aOmxUnwhq8dS-S-wPiSoregTM6HSRR5exhGTnZBK82A@mail.gmail.com>
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

Hi Raymond,

On 10/10/25 21:06, Raymond Mao wrote:
> Hi Jerome,
> 
> On Fri, 10 Oct 2025 at 11:11, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hi Raymond,
>>
>> On 10/10/25 16:45, Raymond Mao wrote:
>>> Fetch OP-TEE (4.7.0), TF-A (v2.13.0), MbedTLS (v3.6) and build
>>> bl1 and fip with both Firmware Handoff and Measured Boot enabled.
>>>
>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>>> ---
>>> Changes in V2:
>>> - Move OP-TEE dependencies into the common group.
>>> - Fetch MbedTLS/TF-A and build bl1/fip in dockerfile instead of
>>>   post-buildman script.
>>> - Remove Trust Boot related build options.
>>> Changes in V3:
>>> - Clean-up of OP-TEE deps.
>>>
>>>  tools/docker/Dockerfile | 44 +++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 42 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>>> index 5b4c75f8400..51d07b1482c 100644
>>> --- a/tools/docker/Dockerfile
>>> +++ b/tools/docker/Dockerfile
>>> @@ -122,8 +122,10 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
>>>       python-is-python3 \
>>>       python2.7 \
>>>       python3 \
>>> +     python3-cryptography \
>>>       python3-dev \
>>>       python3-pip \
>>> +     python3-pyelftools \
>>>       python3-sphinx \
>>>       python3-tomli \
>>>       python3-venv \
>>> @@ -227,10 +229,30 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
>>>       make -j$(nproc) all install && \
>>>       rm -rf /tmp/qemu
>>>
>>> -# Build fiptool
>>> +# Build OP-TEE for qemu_arm64
>>> +RUN git clone https://github.com/OP-TEE/optee_os.git /tmp/optee_os && \
>>> +     cd /tmp/optee_os/ && \
>>> +     git checkout 4.7.0 && \
>>> +     make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
>>
>> OK
>>
>>> +             CROSS_COMPILE_core=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
>>
>> Not needed (eventually defaults to $(CROSS_COMPILE))
>>
> 
> Removing CROSS_COMPILE_core prompts "aarch64-linux-gnu-gcc: command
> not found", I think we need CROSS_COMPILE64 instead.

Correct.

> 
>>> +             CROSS_COMPILE32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
>>
>> OK
>>
>>> +             CROSS_COMPILE_ta_arm32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
>>> +             CROSS_COMPILE_ta_arm64=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
>>> +             ARCH=arm \
>>> +             CFG_ARM64_core=y \
>>
>> All 4 lines not needed (defaults)
>>
> 
> Dito, removing CROSS_COMPILE_ta_arm64 prompts "aarch64-linux-gnu-gcc:
> command not found".
> I think for v4.7.0:
> CROSS_COMPILE_ta_arm64 defaults to CROSS_COMPILE64;
> CROSS_COMPILE_ta_arm32 defaults to CROSS_COMPILE32;
> CROSS_COMPILE32 defaults to CROSS_COMPILE.
> CROSS_COMPILE_core defaults to CROSS_COMPILE64 when CFG_ARM64_core=y.
> 
> So actually CROSS_COMPILE and CROSS_COMPILE64 are required at least.

Again, this is totally correct. Sorry for mixing things up a bit ;-)
Anyway you got the point, I'd like to minimize the number of variables
set on the command line. I would recommend setting CROSS_COMPILE32 and
CROSS_COMPILE64 (and not CROSS_COMPILE).

Thanks,
-- 
Jerome

> 
> Regards,
> Raymond
> 
> 
>>> +             CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y \
>>> +             PLATFORM=vexpress-qemu_armv8a CFG_RPMB_FS=y \
>>
>> OK
>>
>>> +             CFG_RPMB_FS_DEV_ID=0 CFG_CORE_HEAP_SIZE=524288 CFG_RPMB_WRITE_KEY=y \
>>
>> CFG_RPMB_FS_DEV_ID=0 not needed (default)
>>
>>> +             CFG_CORE_HEAP_SIZE=524288 CFG_CORE_DYN_SHM=y CFG_RPMB_TESTKEY=y \
>>
>> CFG_CORE_DYN_SHM=y not needed (default)
>>
>>> +             CFG_RPMB_WRITE_KEY=1 \
>>
>> Already set above
>>
>>> +             CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
>>
>> OK
>>
>>> +             CFG_TEE_CORE_LOG_LEVEL=4 CFG_TEE_TA_LOG_LEVEL=1 DEBUG=y
>>
>> CFG_TEE_TA_LOG_LEVEL=1 not needed (default).
>> Would the CFG_TEE_CORE_LOG_LEVEL (2 == LOG_LEVEL_ERROR) and DEBUG (disabled) be OK?
>>
>>> +
>>> +# Build fiptool, bl1 and fip for fvp and qemu_arm64
>>> +RUN git clone --branch mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
>>>  RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
>>>       cd /tmp/tf-a/ && \
>>> -     git checkout v2.12.0 && \
>>> +     git checkout v2.13.0 && \
>>>       make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
>>>               PLAT=fvp BL33=/dev/null -j$(nproc) all fip && \
>>>       mkdir -p /usr/local/bin /opt/tf-a/vexpress_fvp && \
>>> @@ -243,6 +265,24 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
>>>       mkdir -p /opt/tf-a/vexpress_fvp_bloblist && \
>>>       cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
>>>               /opt/tf-a/vexpress_fvp_bloblist/ && \
>>> +     make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
>>> +             PLAT=qemu \
>>> +             BL33=/dev/null \
>>> +             BL32=/tmp/optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin \
>>> +             BL32_EXTRA1=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin \
>>> +             BL32_EXTRA2=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin \
>>> +             BL32_RAM_LOCATION=tdram SPD=opteed \
>>> +             TRANSFER_LIST=1 E=0 \
>>> +             MEASURED_BOOT=1 \
>>> +             EVENT_LOG_LEVEL=10 \
>>> +             MBOOT_EL_HASH_ALG=sha256 \
>>> +             MBEDTLS_DIR=/tmp/mbedtls \
>>> +             -j$(nproc) all fip && \
>>> +     mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
>>> +     cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
>>> +             /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
>>> +     rm -rf /tmp/optee_os && \
>>> +     rm -rf /tmp/mbedtls && \
>>>       rm -rf /tmp/tf-a
>>>
>>>  # Download the Arm Architecture FVP platform. This file is double compressed.
>>
>> Thanks,
>> --
>> Jerome
