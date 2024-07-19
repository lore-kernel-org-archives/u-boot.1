Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67258C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C033F88B95;
	Fri, 19 Jul 2024 14:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ghm0HjlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B23F88BA4; Fri, 19 Jul 2024 14:43:50 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A072E887CE
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52ea79e689eso2509677e87.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393027; x=1721997827; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ve2hQ5pHxvbNy1OSZ2npGOGhPQk8I2RilPEuAWpFDSU=;
 b=Ghm0HjlBxeaHpUZB6w0wOlRiv6lGIv8Mzn+tAQh6VDWcVhVjfYN4EKV2YhEgHx8zmo
 VVn5o39twwEA+CcnA0P94sxCLjgnwjSveT0WZeENpYz/VwNz7nGE/f6ZeBIoIawz+txQ
 +4EMEl9UXC4zzAGAl9sWydbxjPl66tTYSkOgVYEhCIpxCLAUqt5gnGNBTd3Cd7zzi7+w
 wODv4nhYw5GIg50dqQyjBoZEm/EYwEOkTOSn91MFeDvNKbUXzLFeDSbKBHPYiNwEMsws
 LtSMquv5OLh9NCeG51lQ/3ZFvrFZctwEZ19HThBHUjQO+vzL/4SeQDU0aMDplA0Fjhh+
 GRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393027; x=1721997827;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ve2hQ5pHxvbNy1OSZ2npGOGhPQk8I2RilPEuAWpFDSU=;
 b=PheL575gs37oEtTxAENlbRGTt6gH+sYnrHl3kFzdguA81K6FgtNfYIXJZLTkGu3CHt
 dg+7lJOTcRg7tqG7arVWjRW9xdgVsJUb+XwrNIZVrYJSZutu9/JgXNrlEOKTlSK5kfs1
 jDZqoTiKZJURIlnU/ZVS2+hFBDbnOsUhstyMA0kmThl61XWchTXSdAYDRCWBv9kGirCx
 2QfaF1b34SI06CJdPTaFVf04zo0237T9ncuhjq+apu0BtNj8/8u2ozQ9b06M2PKBvxaQ
 a4yZV5HColEEWq6dqr26Oyn3TMgq5BWO5ymfyhoIqVxYpvv+xmzwoQSdnmebFKT7l/ns
 ETjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOB8TUE7X+x45SlAs/zZVd9BdrGo4mmvZxZR9gkZaJgt2r2FwJ8L02I8mV7rA85fFcHwkTfj9cjayjUQecI2n8f+x5EA==
X-Gm-Message-State: AOJu0YzYG+Y4OKLXkVBiOaNNPTg0h7U2GnIkaCPaYpBfJ1E9Euc5fTLi
 UFAUmGdzgKw900i1Y1fatp7TC60EReLadF+A/A28WB9kNgDhEz9LvOh2mwUpJYc=
X-Google-Smtp-Source: AGHT+IFpM2ERS/J+q7XR76boDH/oqkQUrtd4GBgQFf9NtlRrnGvLd+8dX9aFMgwHgHRx++1l/teJPA==
X-Received: by 2002:a05:6512:4016:b0:52c:9877:71b7 with SMTP id
 2adb3069b0e04-52ee545279emr7409833e87.59.1721393026777; 
 Fri, 19 Jul 2024 05:43:46 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v5 00/11] efi: CapsuleUpdate: support for dynamic UUIDs
Date: Fri, 19 Jul 2024 14:43:40 +0200
Message-Id: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHxfmmYC/2XQ3WrDMAwF4Fcpvq6LrMhJ2qu9R9mFf5RWsCXFW
 U1LybvPKZRu+PII9Imjh5o5Cc/qsHmoxFlmmcYS7HajwtmNJ9YSS1YISECI2pOO99F9S9DXq0R
 tnHXeUN8G7FTZuiQe5PYUj58ln2X+mdL9eSCbdfqy2srKRoPm3lhiAA5EH18yujTtpnRSK5bxD
 Vjc1wAWIGA7NAZs5z1XQPMHaEwNNCvgyJVCNnqACqA30EH9jkwFcAChx2gGC/8rLMvyC5deBtR
 yAQAA
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7490;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=2+mBTm3AtxCEQwrQZenO+38nwyl0Ei02ApyHAcyxcR8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+All732VPqMFxUwc2dwcJuXURBBcuzuWyoF
 RDbmQK7ouiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgAAKCRAFgzErGV9k
 tkNgD/wLcQ6iA2wY+lP6LYljazz74BXmjKLxiWTToxBR6TGE0somBEUwabfbiEE1vMc6pzIHOOk
 i7Jvo6zu5EmEvMPwymbivicjv0Dja0PchjACFTSsuwyPCg3vXRqyG3WGekz6dhRPFoYG+fklszs
 o8Ae42q3D0eYeUMw0W1naFItZsIaihXlWYE4LKZdpEy2KKEc6RWx+3zOOQIpxCK4FXdEJGg9JAx
 1qFuojVmxgfgWBVaxMWoICDL2cWFLOn1U7dr7cYQlmranG6Fv7GCymOvCnSimXSFqptrd9VCfXF
 mSklS0BSHf3Dd+2ZxTjI3tMO//GYzq4OlHTAvqoilPlwhb5jJp96Sk1wreh41m5HdVq1HjYeID4
 zWYUEP5UcVlH+IMumUthyPuY+E8LrX62ohJLBfpeMy6ie9Kzbw8W5H3CPvsrMirjplLsJeMdIvZ
 4IZeBL8JHitpFimdBIDrwdBLW/UaWrSoboFko8WxYCLs0t0MccjyACInjf0G7IgFODaRAGSiLB9
 3Y+CxcbBAEA1zoKF87Ovta35VwoH6b46JsNwuZF+O8uT2AUsg1eWwuc4LEdIs12QfCxA+j1HAL0
 /dJYWstKVMJ/yJSJG4dnlbzees7jTy7b4cVh3HrWejW6+6OTDqgta3rNyJi3yvkC1oKo0EHRxoP
 uL9AHdW4EKx6axQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

As more boards adopt support for the EFI CapsuleUpdate mechanism, there
is a growing issue of being able to target updates to them properly. The
current mechanism of hardcoding UUIDs for each board at compile time is
unsustainable, and maintaining lists of GUIDs is similarly cumbersome.

In this series, I propose that we adopt v5 GUIDs, these are generated by
using a well-known salt GUID as well as board specific information the
DT root compatible string, these are hashed together and the result is
truncated to form a new UUID.

The well-known salt GUID can be specific to the architecture (SoC
vendor), or OEM. It is defined in the board defconfig so that vendors
can easily bring their own.

Specifically, the following fields are used to generate a GUID for a
particular fw_image:

* namespace salt
* board compatible (usually the first entry in the dt root compatible
  array).
* fw_image name (the string identifying the specific image, especially
  relevant for board that can update multiple images).

== Usage ==

Boards can enable dynamic UUID support by simply not setting the
efi_fw_image image_type_id property. Vendors may also wish to set a
custom namespace GUID (by setting CONFIG_EFI_CAPSULE_NAMESPACE_GUID).

== Limitations ==

* Changing GUIDs

The primary limitation with this approach is that if any of the source
fields change, so will the GUID for the board. It is therefore pretty
important to ensure that GUID changes are caught during development.

* Supporting multiple boards with a single image

This now requires having an entry with the GUID for every board which
might lead to larger UpdateCapsule images.

== Tooling ==

The mkeficapsule command is updated to add a new guidgen subcommand,
this can generate GUIDs that match those the board would generate at
runtime. It accepts an optional namespace GUID (if the default isn't
used), a path to the board DTB, and a list of firmware image names.

This series follows a related discussion started by Ilias:
https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com/

CI run for this series: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/21419

---
Changes in v5:
- Clean up mkeficapsule genguid patch
- Add explicit tests validating the GUID type bits
- Link to v4: https://lore.kernel.org/r/20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org

Changes in v4:
- Make UUID v5 support always enabled rather than being optional.
- Fix endianness issues (thanks Vincent and Ilias)
- Merge genguid tool into mkeficapsule.
-	And move mkeficapsule over to using U-Boot's UUID code rather
	than libuuid.
- Provide a default namespace UUID for all U-Boot boards.
- Link to v3: https://lore.kernel.org/r/20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org

Changes in v3:
- Add manpage for genguid
- Add dedicated CONFIG_TOOLS_GENGUID option
- Minor code fixes addressing v2 feedback
- Link to v2: https://lore.kernel.org/r/20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org

Changes in v2:
- Move namespace UUID to be defined in defconfig
- Add tests and tooling
- Only use the first board compatible to generate UUID.
- Link to v1: https://lore.kernel.org/r/20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org

---
Caleb Connolly (11):
      efi: define struct efi_guid
      lib: uuid: add UUID v5 support
      efi: add a helper to generate dynamic UUIDs
      doc: uefi: document dynamic UUID generation
      sandbox: switch to dynamic UUIDs
      lib: uuid: supporting building as part of host tools
      include: export uuid.h
      tools: mkeficapsule: use u-boot UUID library
      tools: mkeficapsule: support generating dynamic GUIDs
      test: lib/uuid: add unit tests for dynamic UUIDs
      test: lib/uuid: add tests for UUID version/variant bits

 arch/arm/mach-rockchip/board.c                     |   2 +-
 board/cobra5272/flash.c                            |   2 +-
 board/gardena/smart-gateway-mt7688/board.c         |   2 +-
 board/sandbox/sandbox.c                            |  16 --
 board/socrates/socrates.c                          |   2 +-
 board/xilinx/common/board.c                        |   2 +-
 cmd/efi.c                                          |   2 +-
 cmd/efi_common.c                                   |   2 +-
 cmd/flash.c                                        |   2 +-
 cmd/gpt.c                                          |   2 +-
 cmd/nvedit_efi.c                                   |   2 +-
 cmd/x86/hob.c                                      |   2 +-
 common/flash.c                                     |   2 +-
 disk/part_efi.c                                    |   2 +-
 doc/develop/uefi/uefi.rst                          |  27 +++
 doc/mkeficapsule.1                                 |  23 +++
 drivers/firmware/arm-ffa/arm-ffa-uclass.c          |   2 +-
 env/sf.c                                           |   2 +-
 fs/btrfs/btrfs.c                                   |   2 +-
 fs/btrfs/compat.h                                  |   2 +-
 fs/btrfs/disk-io.c                                 |   2 +-
 fs/ext4/ext4fs.c                                   |   2 +-
 include/efi.h                                      |   2 +-
 include/fwu.h                                      |   2 +-
 include/part.h                                     |   2 +-
 include/rkmtd.h                                    |   2 +-
 include/sandbox_efi_capsule.h                      |   6 +-
 include/{ => u-boot}/uuid.h                        |  21 ++-
 lib/Kconfig                                        |   1 +
 lib/acpi/acpi_dp.c                                 |   2 +-
 lib/acpi/acpigen.c                                 |   2 +-
 lib/efi/efi_app.c                                  |   2 +-
 lib/efi_loader/Kconfig                             |  12 ++
 lib/efi_loader/efi_capsule.c                       |   1 +
 lib/efi_loader/efi_device_path.c                   |   2 +-
 lib/efi_loader/efi_firmware.c                      |  52 +++++
 lib/efi_loader/efi_variable.c                      |   2 +-
 lib/fwu_updates/fwu_mtd.c                          |   2 +-
 lib/uuid.c                                         | 102 +++++++---
 lib/vsprintf.c                                     |   2 +-
 net/bootp.c                                        |   2 +-
 test/dm/acpi_dp.c                                  |   2 +-
 test/dm/acpigen.c                                  |   2 +-
 test/lib/uuid.c                                    | 120 +++++++++++-
 .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
 .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
 .../test_capsule_firmware_signed_fit.py            |   2 +-
 .../test_capsule_firmware_signed_raw.py            |   4 +-
 test/py/tests/test_efi_capsule/version.dts         |   6 +-
 tools/Makefile                                     |   8 +-
 tools/binman/etype/efi_capsule.py                  |   2 +-
 tools/binman/ftest.py                              |   2 +-
 tools/eficapsule.h                                 |   2 +-
 tools/mkeficapsule.c                               | 209 ++++++++++++++++-----
 54 files changed, 544 insertions(+), 148 deletions(-)
---
change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
base-commit: c717871c07fb36f13806ef5351d858a72a811d95

// Caleb (they/them)

