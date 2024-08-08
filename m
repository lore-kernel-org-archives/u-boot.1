Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23A2C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0150988AF8;
	Thu,  8 Aug 2024 18:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XUn7wRic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C4A88ABD; Thu,  8 Aug 2024 18:56:17 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238FC87A09
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db1eb76702so886195b6e.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723136174; x=1723740974; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JYqkcTUaDkmUjFtaNAj92Dxg27senLpbGbYYg9NkdWE=;
 b=XUn7wRiciKJmhJUXyx2f7O1F4T13zo1bp1PpTZnLocbxpzNIjGVzkH6bEFaNp1jLWS
 gYpH1tebTwG9I/cacU8hXFMOIXKFb2wzV8Jd56Z3yk8wX/K2sA63mSjVqWTxpMgA+HCk
 Ud5nVgmZb3tkFQT+F7Wi+Y0x6/RoUb5waD2L1KOZ4+2bFvvDGKQQx7xBU0A9x6wu+iVj
 1SzYif7Y9T1TXF9PPUBF5K0KoKMlHeh7quSMRl5fv/GZc3iPsd6qDHPe8bNDDLYoWlqR
 1tkvlcowhDz/ajCTITjPKIuTtGTzLdfiC9mH8i0I45VtqcRLR/uMObJ/dT4pZ9pBi+qr
 r+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723136174; x=1723740974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JYqkcTUaDkmUjFtaNAj92Dxg27senLpbGbYYg9NkdWE=;
 b=uLAD3obMD0nOri0uLcHNP8I27Jbdr/XjJgFZdFweLPHeSkvhcEnXhA97lIR9S3TxXA
 LlIWMt+azgug6d5PG9jKUzPCcBfmASGHHluG4Mgpn5a8sGFp7jT+W79kHgsSZYQ5bY+N
 D4VMuEaDgCnZ2D1R5Dcsv1QXTuDTD+latPTywWcoCUCJlAiYgnPWVESJUWGCWPZy4haH
 kXUIp3/wTuKgqgfG0nLmmEhzP8vRSkWKmwVjdhNWtmn9DVth6s5NkgR6hqTz8LINLskp
 iyuznJiGPbxOpjcBxeQEnA3Jludvcu3/zfQWvyDNNNuMIKXvw3F1ggaUl8YmWu7gbYlu
 YXqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1XDuVOZzZ9TD8rQvzahJTrQXAzEaWeCMwNcNDKA/G5G+h19ryJQeNhNRYbrd4piPlAH5y1bg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyzi1D4EpzYpcktIQVqLdA/291eJpY4/JFlDa8dxhxZk3qNchUk
 KSAcuQmqjj7wkux9RTjPElMXvi8AkCut6phcZa7UuvrY7yPsbIvssFhlJTblmRw=
X-Google-Smtp-Source: AGHT+IH1s9ezfSn3Jk423/Q44GMpa95tIEPIy+5TE1Qln+EnWcxrI7l+kIOO2gAB8ohofb8E4TEhHA==
X-Received: by 2002:a05:6808:2129:b0:3d9:de1e:c22f with SMTP id
 5614622812f47-3dc3b426661mr2975893b6e.21.1723136173729; 
 Thu, 08 Aug 2024 09:56:13 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-451c8739580sm14574251cf.53.2024.08.08.09.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 09:56:13 -0700 (PDT)
Message-ID: <55e21d87-d1ec-44c3-931b-a9abde49bc57@linaro.org>
Date: Thu, 8 Aug 2024 18:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] efi: CapsuleUpdate: support for dynamic UUIDs
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
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

Small CI issue, I'll fix it up and resend

https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/jobs/884570

On 08/08/2024 18:21, Caleb Connolly wrote:
> As more boards adopt support for the EFI CapsuleUpdate mechanism, there
> is a growing issue of being able to target updates to them properly. The
> current mechanism of hardcoding UUIDs for each board at compile time is
> unsustainable, and maintaining lists of GUIDs is similarly cumbersome.
> 
> In this series, I propose that we adopt v5 GUIDs, these are generated by
> using a well-known salt GUID as well as board specific information the
> DT root compatible string, these are hashed together and the result is
> truncated to form a new UUID.
> 
> The well-known salt GUID can be specific to the architecture (SoC
> vendor), or OEM. It is defined in the board defconfig so that vendors
> can easily bring their own.
> 
> Specifically, the following fields are used to generate a GUID for a
> particular fw_image:
> 
> * namespace salt
> * board compatible (usually the first entry in the dt root compatible
>    array).
> * fw_image name (the string identifying the specific image, especially
>    relevant for board that can update multiple images).
> 
> == Usage ==
> 
> Boards can enable dynamic UUID support by simply not setting the
> efi_fw_image image_type_id property. Vendors may also wish to set a
> custom namespace GUID (by setting CONFIG_EFI_CAPSULE_NAMESPACE_GUID).
> 
> == Limitations ==
> 
> * Changing GUIDs
> 
> The primary limitation with this approach is that if any of the source
> fields change, so will the GUID for the board. It is therefore pretty
> important to ensure that GUID changes are caught during development.
> 
> * Supporting multiple boards with a single image
> 
> This now requires having an entry with the GUID for every board which
> might lead to larger UpdateCapsule images.
> 
> == Tooling ==
> 
> The mkeficapsule command is updated to add a new guidgen subcommand,
> this can generate GUIDs that match those the board would generate at
> runtime. It accepts an optional namespace GUID (if the default isn't
> used), a path to the board DTB, and a list of firmware image names.
> 
> This series follows a related discussion started by Ilias:
> https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com/
> 
> CI run for this series: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/21419
> 
> ---
> Changes in v6:
> - FWU -> Firmware Update in docs
> - Make v5 GUIDs explicitly LE
> - Link to v5: https://lore.kernel.org/r/20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org
> 
> Changes in v5:
> - Clean up mkeficapsule genguid patch
> - Add explicit tests validating the GUID type bits
> - Link to v4: https://lore.kernel.org/r/20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org
> 
> Changes in v4:
> - Make UUID v5 support always enabled rather than being optional.
> - Fix endianness issues (thanks Vincent and Ilias)
> - Merge genguid tool into mkeficapsule.
> -	And move mkeficapsule over to using U-Boot's UUID code rather
> 	than libuuid.
> - Provide a default namespace UUID for all U-Boot boards.
> - Link to v3: https://lore.kernel.org/r/20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org
> 
> Changes in v3:
> - Add manpage for genguid
> - Add dedicated CONFIG_TOOLS_GENGUID option
> - Minor code fixes addressing v2 feedback
> - Link to v2: https://lore.kernel.org/r/20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org
> 
> Changes in v2:
> - Move namespace UUID to be defined in defconfig
> - Add tests and tooling
> - Only use the first board compatible to generate UUID.
> - Link to v1: https://lore.kernel.org/r/20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org
> 
> ---
> Caleb Connolly (11):
>        efi: define struct efi_guid
>        lib: uuid: add UUID v5 support
>        efi: add a helper to generate dynamic UUIDs
>        doc: uefi: document dynamic UUID generation
>        sandbox: switch to dynamic UUIDs
>        lib: uuid: supporting building as part of host tools
>        include: export uuid.h
>        tools: mkeficapsule: use u-boot UUID library
>        tools: mkeficapsule: support generating dynamic GUIDs
>        test: lib/uuid: add unit tests for dynamic UUIDs
>        test: lib/uuid: add tests for UUID version/variant bits
> 
>   arch/arm/mach-rockchip/board.c                     |   2 +-
>   board/cobra5272/flash.c                            |   2 +-
>   board/gardena/smart-gateway-mt7688/board.c         |   2 +-
>   board/sandbox/sandbox.c                            |  16 --
>   board/socrates/socrates.c                          |   2 +-
>   board/xilinx/common/board.c                        |   2 +-
>   cmd/efi.c                                          |   2 +-
>   cmd/efi_common.c                                   |   2 +-
>   cmd/flash.c                                        |   2 +-
>   cmd/gpt.c                                          |   2 +-
>   cmd/nvedit_efi.c                                   |   2 +-
>   cmd/x86/hob.c                                      |   2 +-
>   common/flash.c                                     |   2 +-
>   disk/part_efi.c                                    |   2 +-
>   doc/develop/uefi/uefi.rst                          |  27 +++
>   doc/mkeficapsule.1                                 |  23 +++
>   drivers/firmware/arm-ffa/arm-ffa-uclass.c          |   2 +-
>   env/sf.c                                           |   2 +-
>   fs/btrfs/btrfs.c                                   |   2 +-
>   fs/btrfs/compat.h                                  |   2 +-
>   fs/btrfs/disk-io.c                                 |   2 +-
>   fs/ext4/ext4fs.c                                   |   2 +-
>   include/efi.h                                      |   2 +-
>   include/fwu.h                                      |   2 +-
>   include/part.h                                     |   2 +-
>   include/rkmtd.h                                    |   2 +-
>   include/sandbox_efi_capsule.h                      |   6 +-
>   include/{ => u-boot}/uuid.h                        |  21 ++-
>   lib/Kconfig                                        |   1 +
>   lib/acpi/acpi_dp.c                                 |   2 +-
>   lib/acpi/acpigen.c                                 |   2 +-
>   lib/efi/efi_app.c                                  |   2 +-
>   lib/efi_loader/Kconfig                             |  12 ++
>   lib/efi_loader/efi_capsule.c                       |   1 +
>   lib/efi_loader/efi_device_path.c                   |   2 +-
>   lib/efi_loader/efi_firmware.c                      |  55 +++++-
>   lib/efi_loader/efi_variable.c                      |   2 +-
>   lib/fwu_updates/fwu_mtd.c                          |   2 +-
>   lib/uuid.c                                         | 102 +++++++---
>   lib/vsprintf.c                                     |   2 +-
>   net/bootp.c                                        |   2 +-
>   test/dm/acpi_dp.c                                  |   2 +-
>   test/dm/acpigen.c                                  |   2 +-
>   test/lib/uuid.c                                    | 120 +++++++++++-
>   .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
>   .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
>   .../test_capsule_firmware_signed_fit.py            |   2 +-
>   .../test_capsule_firmware_signed_raw.py            |   4 +-
>   test/py/tests/test_efi_capsule/version.dtso        |   6 +-
>   tools/Makefile                                     |   8 +-
>   tools/binman/etype/efi_capsule.py                  |   2 +-
>   tools/binman/ftest.py                              |   2 +-
>   tools/eficapsule.h                                 |   2 +-
>   tools/mkeficapsule.c                               | 209 ++++++++++++++++-----
>   54 files changed, 546 insertions(+), 149 deletions(-)
> ---
> change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
> base-commit: 07e73b0483a844e4581c8c94d01e73ca22c0ab50
> 
> // Caleb (they/them)
> 

-- 
// Caleb (they/them)
