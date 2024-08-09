Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D01CC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F0188BC4;
	Fri,  9 Aug 2024 02:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GsdcYeqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBB2988BC1; Fri,  9 Aug 2024 02:56:33 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E31C88498
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso410256966b.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164991; x=1723769791; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FsxncvR7RBnoo61Stzbh+zbiAXHPGWD3d+rUoGh03gg=;
 b=GsdcYeqEPSaPKbE6HDqhpeP3U7VM93tbAX6huikaxCH4o8U79A/V/qHfrIemkuAkfN
 9OuN9JDzuJUq4JXnJ2OhSiLepqW+kLZhqkoBNfbCf7+ThI7vmCNiGbUal8KGrbmAW0nQ
 06hXSMOKbOyyMcShx2mpbTY6b0eb74f1VcktU57b1YqeBbPrTKzidw7CpdDk0433PZ37
 7qN/pK8OoEq0YM0RQzIo/XfTnGJ5B/FXqcJWRatrndZbORzxaABaNr7WEt6WeTx1ZHwE
 846yCZZzxRRXmBMImYH6oPd/y7lE4ypGWVd5bpX3dZEwa5Or9KfInpUT98lG864oFLzD
 oIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164991; x=1723769791;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FsxncvR7RBnoo61Stzbh+zbiAXHPGWD3d+rUoGh03gg=;
 b=FI1dmoN+jApjycWyBKEO/9N0TKXQa1r3LZE1Z0uvDbBD/rIOhle0B7wOVAJAfaXApc
 QWwlwLhLYHFFOy3+6QjSHRPY+RsFh5tPX59DhnJSXgkm0WwGhLQRgQ95msd4FXZKwDjs
 lzu00rmR2mfIMO5qg/vtzz7HpDaAvBtQWkCt9P0A6D3xaWLN7PpPyIpqr/7ButF6vEbe
 3q8z4NOascov+scq4xLNm4cFBmTpFZgoUK/t1+TZ6qNJi2ps37+fs5i5W+kaEFo+V3H7
 ZtdGwGEwu8moo9IiiNQPX/3MpUzaH982TDdBgsEM8I9MdBX3Pl+tx66Z769KdwgzoFB0
 WipQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+NMMp3vSK3n2lHrj3hck+AQaKUCW6l3KVqmbEP70A9Oaw+wpoZnBvYsKOXmJZtnDral4pCHpaHe+UD5KkCj/qgkudKg==
X-Gm-Message-State: AOJu0Yy9HMxy+V62MxG4XPJYDhAJ+sHue/8v4jsb6UPklA666F2kU5wl
 5HQDQp2S7UrpFPpbcGYKDy/72KlfYCzTPoJuqymlEP3Ldn9cXTWzDAepnSWZ3tk=
X-Google-Smtp-Source: AGHT+IGvc5VUjFfMwI7zKksCQj47GzJRIPvXcdV+Aa+cJ7kwLc+4TiaHhCCnpWCggfkOMpXBA7kwcw==
X-Received: by 2002:a17:907:a0c:b0:a72:66d5:892c with SMTP id
 a640c23a62f3a-a8091f5aba8mr332704166b.18.1723164990579; 
 Thu, 08 Aug 2024 17:56:30 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v7 00/11] efi: CapsuleUpdate: support for dynamic UUIDs
Date: Fri, 09 Aug 2024 02:56:19 +0200
Message-Id: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNptWYC/23QwWrDMAwG4FcpPs9Dku3Y2WnvMXZwbKU1bElxV
 rNS8u5zCiMd3vEX6BO/bmLhnHgRL4ebyFzSkuapBvt0EOHkpyPLFGsWBKRBE8lBy3id/GcK8nJ
 JUaI3fkDtukBW1K1z5jF938W395pPafma8/V+oOA2/bW6xiooQbJDoxmAg9avH2nyeX6e81FsW
 KEdMNS3AFUgUDcqBGOHgRtAPQAKW0BtgNe+FjJxAGgAvQMW2ncUXQEPEBxFHA20FcwDgP9UMBV
 w3qnIamQVQwN0O+DAtUBXgV4pYkvKIvZ/gHVdfwAv/PET9AEAAA==
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7842;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=YVQC+6KpIfN2pUvZnkhq2cC6FCxUqv1R4fedBUXWSDs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWk86R90FOch6NHIycICiRZCb+JxTTwk2Vav8
 LLmIMt/nS6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVpPAAKCRAFgzErGV9k
 thLlD/sHgCSFOGeFUyk3aWWIeKzWUL0z7/YQVgAVPp2f/JAywpoB3gYlT3u3JOr9H6bCfe0s5sC
 /6WZIryoCVT9mDBHBnyCTjoZe+n1J9kCZCpHFC/VCptLAoiJ2r5DWY2ZfCIzqXUjeMhJJdCWrtv
 W3lneX7ED7tU+44eASo4ZyWkSrgf43C960/aYi8wf5uFEX+hODTXuIQzqTowD7y8Q1VtvehwGli
 TQiQU7uH3YaLRD+nbo543hXcvoraOSk577p7HMyzcKWa2+rr+PuIaynvUyQBVJL+4IqoWKKXNCg
 pjbZ3PqqKumBF60Su10NnNxvkFkELMhjdZjJAiRjUwSg/5AjLZjOy/cxLTZm5bdyvz45927XwtG
 FEH3tS/Ho4aFh/IlA/yHYysAQq/ALS3zMGMim1+L3OdEebDRN85O2S2494CyDdvWgMniU/G8t1g
 hUyJRijmJqsov8sc/LBj6V/KDyED+AxwRRsCM3CaWdJWdoZ/cquO74+uh6jqWL8ccjN3Gr0LLqd
 zgMnsuvkkLSPiPu4VWK9aEk1Xgc51peox0ymvJyVb7Ps1jhEkHTaz4ziYnakoq4EGVfQXF+1n54
 IkZLtoUQwcbGLicFFZptdFrduY4mRX9CUF2HBs46UtI7tYdUtOT6QAH4DmwHkzY3X17OtoIRFaq
 lrqRig27A1rhIbA==
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

CI run for this series: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/21944

---
Changes in v7:
- Minor adjustments to fix CI on some 32-bit ARM platforms
- Link to v6: https://lore.kernel.org/r/20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org

Changes in v6:
- FWU -> Firmware Update in docs
- Make v5 GUIDs explicitly LE
- Link to v5: https://lore.kernel.org/r/20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org

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
 lib/efi_loader/efi_firmware.c                      |  55 +++++-
 lib/efi_loader/efi_variable.c                      |   2 +-
 lib/fwu_updates/fwu_mtd.c                          |   2 +-
 lib/uuid.c                                         | 102 +++++++---
 lib/vsprintf.c                                     |   2 +-
 net/bootp.c                                        |   2 +-
 test/dm/acpi_dp.c                                  |   2 +-
 test/dm/acpigen.c                                  |   2 +-
 test/lib/uuid.c                                    | 122 +++++++++++-
 .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
 .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
 .../test_capsule_firmware_signed_fit.py            |   2 +-
 .../test_capsule_firmware_signed_raw.py            |   4 +-
 test/py/tests/test_efi_capsule/version.dtso        |   6 +-
 tools/Makefile                                     |   8 +-
 tools/binman/etype/efi_capsule.py                  |   2 +-
 tools/binman/ftest.py                              |   2 +-
 tools/eficapsule.h                                 |   2 +-
 tools/mkeficapsule.c                               | 209 ++++++++++++++++-----
 54 files changed, 548 insertions(+), 149 deletions(-)
---
change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
base-commit: 07e73b0483a844e4581c8c94d01e73ca22c0ab50

// Caleb (they/them)

