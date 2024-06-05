Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C147C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 17:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1ABA8813A;
	Wed,  5 Jun 2024 19:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d15RZ3n7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAF4881A2; Wed,  5 Jun 2024 19:02:25 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A1587BF4
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 19:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso2098480a12.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717606942; x=1718211742; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZYKW/PEJLKor3H9+j2p1rLKnjiLW7zwdtdxeP4NSZqQ=;
 b=d15RZ3n7y1A4CZhANDcW4VTXhmb6tpKXrptSQAI1q7G0PzNej8895FWEYDy0wOdRGx
 RF3TZum+1sOb1jybQwI2uea4zVaiFfhyvA59ysm4At833UXYmWdXJdFNQWzfm5nCNHVw
 EoiUahjNlivcZxFZaC/7yBBLUIZOYNn908goOk+6g4wRYOcZGz0J3cLZWM4+1qzfwc5b
 W1z9LNBxGrBDwu9Pd6IonOlNGBmW0A4WTpMVi/UsUSs+Hqe0JiTA703fU0V6amPtsHmd
 UpDWwKikGv1/GirfZGnEI6zv2Ee9arscKKVTjicPjRZFPAWDiIi1mAic0HpPlgwy2dwm
 eX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717606942; x=1718211742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYKW/PEJLKor3H9+j2p1rLKnjiLW7zwdtdxeP4NSZqQ=;
 b=YtHhHMNA/NfO+BM7sleHhrPd/zWiU9X5nrYqkFDcuUXeHdeEu6FjnD2sVial6+vRGG
 X0jn9H2PfVhoC1thamaqqlKHiR9R58BJ1DDcbJqu9ArEg48pgnJSrH0tYMnK78Tl1ggF
 lk9qbT6Ih8Dscv45zFgjFsbDGzg7lgzWnURYv9qc9kZMoLOqnuvuvhytDwjHyfmxWZHH
 cG09HxljIWS94eXMpx3GcAxgUBzbXH33trKp7m3qZqjfVtYvMOyWGsm6q3sufWEU0Ycl
 hCIfSx9kFK3YQho+YzFcqS8+kS7rskPGjSSwjxvmXDtOo6FMH0MbmZOP2JFlZfQs/aHN
 XY7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdjcyl1rpUvonjkKKKryA5+1n4G6tUBOEIfLXisga2UYK33chMQOoYh+S7RXFEP0DsKhDnt+/88ff0WR2RRGYJ/S4+2A==
X-Gm-Message-State: AOJu0Yytv7h/HT78ry6+Gyh/sdg/yXLcioWh03kbmsg2+UspXqlzkiu6
 neWlc4lyGOAgEFxFHHVQH/zb5xa1IVPS5B25lx0Gx9XOR1VigTcrHhBOBznzzllsK3BGiiFYp6U
 FoM3YU/swr4c=
X-Google-Smtp-Source: AGHT+IFtord1gCwn6CgvNCVU8a90vpL1CbBZ79QmTtQmOO70fWa2KKGO8gDSL2fGTAL0CnBONYuiKA==
X-Received: by 2002:a50:9f2c:0:b0:578:63ec:3e90 with SMTP id
 4fb4d7f45d1cf-57aa55ae1dbmr217366a12.14.1717606942099; 
 Wed, 05 Jun 2024 10:02:22 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a6b2b6606sm4854570a12.89.2024.06.05.10.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 10:02:21 -0700 (PDT)
Message-ID: <37fc77fe-2e89-4810-a752-58bc659cdad8@linaro.org>
Date: Wed, 5 Jun 2024 19:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <effa1116-0ad6-4cdc-a9d4-cf3cb1e309ef@gmx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <effa1116-0ad6-4cdc-a9d4-cf3cb1e309ef@gmx.de>
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



On 05/06/2024 07:59, Heinrich Schuchardt wrote:
> On 5/31/24 15:50, Caleb Connolly wrote:
>> As more boards adopt support for the EFI CapsuleUpdate mechanism, there
>> is a growing issue of being able to target updates to them properly. The
>> current mechanism of hardcoding UUIDs for each board at compile time is
>> unsustainable, and maintaining lists of GUIDs is similarly cumbersome.
>>
>> In this series, I propose that we adopt v5 GUIDs, these are generated
>> by using a well-known salt GUID as well as board specific information
>> (like the model/revision), these are hashed together and the result is
>> truncated to form a new UUID.
>>
>> The well-known salt GUID can be specific to the architecture (SoC
>> vendor), or OEM. It is defined in the board defconfig so that vendors
>> can easily bring their own.
>>
>> Specifically, the following fields are used to generate a GUID for a
>> particular fw_image:
>>
>> * namespace salt
>> * board compatible (usually the first entry in the dt root compatible
>>    array).
>> * fw_image name (the string identifying the specific image, especially
>>    relevant for board that can update multiple images).
>>
>> == Usage ==
>>
>> Boards can integrate dynamic UUID support as follows:
>>
>> 1. Adjust Kconfig to depend on EFI_CAPSULE_DYNAMIC_UUIDS if
>>     EFI_HAVE_CAPSULE_SUPPORT.
>> 2. Skip setting the fw_images image_type_id property.
>> 3. Generate a UUID and set CONFIG_EFI_CAPSULE_NAMESPACE_UUID in your
>>     defconfig.
> 
> Why should we have two alternatives?
> 
> If we have the dynamic UUIDs, please, get rid of static ones.

I don't think this is possible to do without the risk of breaking some 
boards. Can we assume that ALL existing capsule update image GUIDs are 
safe to just scrap?
> 
>>
>> == Limitations ==
>>
>> * Changing GUIDs
>>
>> The primary limitation with this approach is that if any of the source
>> fields change, so will the GUID for the board. It is therefore pretty
>> important to ensure that GUID changes are caught during development.
>>
>> * Supporting multiple boards with a single image
>>
>> This now requires having an entry with the GUID for every board which
>> might lead to larger UpdateCapsule images.
> 
> Do we have a test case were a capsule contains images that shall not be
> installed?
> 
>>
>> == Tooling ==
>>
>> This series introduces a new tool: genguid. This can be used to generate
>> the same GUIDs that the board would at runtime.
> 
>      the GUIDs that the board requires at runtime.
> 
> Best regards
> 
> Heinrich
> 
>>
>> This series follows a related discussion started by Ilias:
>> https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com/
>>
>> ---
>> Changes in v3:
>> - Add manpage for genguid
>> - Add dedicated CONFIG_TOOLS_GENGUID option
>> - Minor code fixes addressing v2 feedback
>> - Link to v2: 
>> https://lore.kernel.org/r/20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org
>>
>> Changes in v2:
>> - Move namespace UUID to be defined in defconfig
>> - Add tests and tooling
>> - Only use the first board compatible to generate UUID.
>> - Link to v1: 
>> https://lore.kernel.org/r/20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org
>>
>> ---
>> Caleb Connolly (7):
>>        lib: uuid: add UUID v5 support
>>        efi: add a helper to generate dynamic UUIDs
>>        doc: uefi: document dynamic UUID generation
>>        sandbox: switch to dynamic UUIDs
>>        lib: uuid: supporting building as part of host tools
>>        tools: add genguid tool
>>        test: lib/uuid: add unit tests for dynamic UUIDs
>>
>>   arch/Kconfig                                       |   1 +
>>   board/sandbox/sandbox.c                            |  16 ---
>>   configs/sandbox_defconfig                          |   1 +
>>   configs/sandbox_flattree_defconfig                 |   1 +
>>   doc/develop/uefi/uefi.rst                          |  31 +++++
>>   doc/genguid.1                                      |  52 +++++++
>>   include/sandbox_efi_capsule.h                      |   6 +-
>>   include/uuid.h                                     |  21 ++-
>>   lib/Kconfig                                        |   8 ++
>>   lib/efi_loader/Kconfig                             |  23 +++
>>   lib/efi_loader/efi_capsule.c                       |   1 +
>>   lib/efi_loader/efi_firmware.c                      |  66 +++++++++
>>   lib/uuid.c                                         |  81 +++++++++--
>>   test/lib/uuid.c                                    |  88 ++++++++++++
>>   .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
>>   .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
>>   .../test_capsule_firmware_signed_fit.py            |   2 +-
>>   .../test_capsule_firmware_signed_raw.py            |   4 +-
>>   test/py/tests/test_efi_capsule/version.dts         |   6 +-
>>   tools/Kconfig                                      |   7 +
>>   tools/Makefile                                     |   3 +
>>   tools/binman/etype/efi_capsule.py                  |   2 +-
>>   tools/binman/ftest.py                              |   2 +-
>>   tools/genguid.c                                    | 154 
>> +++++++++++++++++++++
>>   24 files changed, 538 insertions(+), 48 deletions(-)
>> ---
>> change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
>> base-commit: 2e682a4a406fc81ef32e05c28542cc8067f1e15f
>>
>> // Caleb (they/them)
>>
> 

-- 
// Caleb (they/them)
