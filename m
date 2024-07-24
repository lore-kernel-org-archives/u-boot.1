Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD869C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 09:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 262A3887F6;
	Wed, 24 Jul 2024 11:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y7xvV/wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 147F888800; Wed, 24 Jul 2024 11:08:36 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE4A288549
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cb5e0b020eso4148352a91.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721812110; x=1722416910; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fdhN60BfhOouFUGrvElZxAp7p2y2sLDWHPEa88Nzaew=;
 b=y7xvV/wbrN/zRP3UOX2yMn5ncntlaSxMPoi2il8zJJavO175057JPLzhSla0reGem1
 4btZImNqqdV8M6k8WHIRhZ0TInumZQzHkkI83p+5pgVJ2KdkMN99yRd+htu324r1cfWI
 eZW254tJ3FAGeQPCPSs/8JyGXSjlPkgHmWy1kCGhjgAf/5X2I6trdqWoHSEUhTi5LOWt
 9SZ61wfXf6uCMNRbrlImfRF48oCHEapORy4V40Jd3vkZxQ1QJNyvnQNCvq3/Gl00CBAu
 Lb3GV/prNVzDK4bJzAmg1IV2UB+pJLJmgsQTvVB0YghLmw67VVaRfDCTlzBvYJP957s8
 9cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721812110; x=1722416910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fdhN60BfhOouFUGrvElZxAp7p2y2sLDWHPEa88Nzaew=;
 b=nY9l+0nSnFW81i3E63BJDdB+8FnofpEbC6W6BwoaKiQspxDOxb3xNY7rKJZiddYQS0
 wQkE7Zhomd5i0n0Il5eW9trxh1SudEVZSJRVlrJYCuKcP2a8kAzDJBdr1sWlDDmk6kS0
 STbzh4xfBa71xi6wTV2Xgcx2ZiBvvJQli91yFq2+W9UEfYIwLlwPQP3Tn+fnySMgfeie
 cxKXrkeSNPG2lPGcIfNP0TY77e6gy4L4d9Gx/iMZSJJPI7p7BNWpaov34cKrVx470aKa
 mFR1rvQJtksqPyEsCrbHbUC3Z9w/bbh5OqdrLWdEfqFMqBkbZWcUlL13CRV5ZP/6rAsu
 PKdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNqSxhYaEhHVaHDW3prIbI9+hikw36Vk7NGTWtnzdpp/7U8iW1j8IctehMsEMOBoSBaRp8SMgFBK+Hsz1F1/ohklJBPw==
X-Gm-Message-State: AOJu0YwTnaAJZxThpMWtU+yUkhsOe8SFXUr3rMyu8rfm6OpJnz+TZrw9
 v1uvfkjI/C5VDYeuOr+/cJ1GU7rMGyhhEStzXXZjHJoBUFwoTJP5ku9ovMJgo8HszQT4R4/2r7x
 wHpmXS0iep3o1wNvfayD87/9Hyw8tq8Ph086f3A==
X-Google-Smtp-Source: AGHT+IFB7Xpj9PsW7VC7oDlVlSBYGXFXRFbmqRO7LgqP/mlSji7PvMkmfL9KqmS9tgCBT+C2dSdV9Df23vP07EEr0zk=
X-Received: by 2002:a17:90a:f187:b0:2c8:f3b7:ec45 with SMTP id
 98e67ed59e1d1-2cdaef5ed6emr2532245a91.36.1721812109172; Wed, 24 Jul 2024
 02:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Jul 2024 12:07:53 +0300
Message-ID: <CAC_iWj+bxgRgWNH0jnj-WXRoLKT=LXWGRBdW-5-k-M-r3KHTqw@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] efi: CapsuleUpdate: support for dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Caleb,

checkpatch reports some issues for #4 & #9, check that for v6

Cheers
/Ilias
On Fri, 19 Jul 2024 at 15:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
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
>   array).
> * fw_image name (the string identifying the specific image, especially
>   relevant for board that can update multiple images).
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
> Changes in v5:
> - Clean up mkeficapsule genguid patch
> - Add explicit tests validating the GUID type bits
> - Link to v4: https://lore.kernel.org/r/20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org
>
> Changes in v4:
> - Make UUID v5 support always enabled rather than being optional.
> - Fix endianness issues (thanks Vincent and Ilias)
> - Merge genguid tool into mkeficapsule.
> -       And move mkeficapsule over to using U-Boot's UUID code rather
>         than libuuid.
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
>       efi: define struct efi_guid
>       lib: uuid: add UUID v5 support
>       efi: add a helper to generate dynamic UUIDs
>       doc: uefi: document dynamic UUID generation
>       sandbox: switch to dynamic UUIDs
>       lib: uuid: supporting building as part of host tools
>       include: export uuid.h
>       tools: mkeficapsule: use u-boot UUID library
>       tools: mkeficapsule: support generating dynamic GUIDs
>       test: lib/uuid: add unit tests for dynamic UUIDs
>       test: lib/uuid: add tests for UUID version/variant bits
>
>  arch/arm/mach-rockchip/board.c                     |   2 +-
>  board/cobra5272/flash.c                            |   2 +-
>  board/gardena/smart-gateway-mt7688/board.c         |   2 +-
>  board/sandbox/sandbox.c                            |  16 --
>  board/socrates/socrates.c                          |   2 +-
>  board/xilinx/common/board.c                        |   2 +-
>  cmd/efi.c                                          |   2 +-
>  cmd/efi_common.c                                   |   2 +-
>  cmd/flash.c                                        |   2 +-
>  cmd/gpt.c                                          |   2 +-
>  cmd/nvedit_efi.c                                   |   2 +-
>  cmd/x86/hob.c                                      |   2 +-
>  common/flash.c                                     |   2 +-
>  disk/part_efi.c                                    |   2 +-
>  doc/develop/uefi/uefi.rst                          |  27 +++
>  doc/mkeficapsule.1                                 |  23 +++
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c          |   2 +-
>  env/sf.c                                           |   2 +-
>  fs/btrfs/btrfs.c                                   |   2 +-
>  fs/btrfs/compat.h                                  |   2 +-
>  fs/btrfs/disk-io.c                                 |   2 +-
>  fs/ext4/ext4fs.c                                   |   2 +-
>  include/efi.h                                      |   2 +-
>  include/fwu.h                                      |   2 +-
>  include/part.h                                     |   2 +-
>  include/rkmtd.h                                    |   2 +-
>  include/sandbox_efi_capsule.h                      |   6 +-
>  include/{ => u-boot}/uuid.h                        |  21 ++-
>  lib/Kconfig                                        |   1 +
>  lib/acpi/acpi_dp.c                                 |   2 +-
>  lib/acpi/acpigen.c                                 |   2 +-
>  lib/efi/efi_app.c                                  |   2 +-
>  lib/efi_loader/Kconfig                             |  12 ++
>  lib/efi_loader/efi_capsule.c                       |   1 +
>  lib/efi_loader/efi_device_path.c                   |   2 +-
>  lib/efi_loader/efi_firmware.c                      |  52 +++++
>  lib/efi_loader/efi_variable.c                      |   2 +-
>  lib/fwu_updates/fwu_mtd.c                          |   2 +-
>  lib/uuid.c                                         | 102 +++++++---
>  lib/vsprintf.c                                     |   2 +-
>  net/bootp.c                                        |   2 +-
>  test/dm/acpi_dp.c                                  |   2 +-
>  test/dm/acpigen.c                                  |   2 +-
>  test/lib/uuid.c                                    | 120 +++++++++++-
>  .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
>  .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
>  .../test_capsule_firmware_signed_fit.py            |   2 +-
>  .../test_capsule_firmware_signed_raw.py            |   4 +-
>  test/py/tests/test_efi_capsule/version.dts         |   6 +-
>  tools/Makefile                                     |   8 +-
>  tools/binman/etype/efi_capsule.py                  |   2 +-
>  tools/binman/ftest.py                              |   2 +-
>  tools/eficapsule.h                                 |   2 +-
>  tools/mkeficapsule.c                               | 209 ++++++++++++++++-----
>  54 files changed, 544 insertions(+), 148 deletions(-)
> ---
> change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
> base-commit: c717871c07fb36f13806ef5351d858a72a811d95
>
> // Caleb (they/them)
>
