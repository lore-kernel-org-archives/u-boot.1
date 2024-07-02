Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507FFC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71777884FB;
	Tue,  2 Jul 2024 15:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i3tSLiZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648DC884FB; Tue,  2 Jul 2024 15:30:47 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1F7287CF8
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a724958f118so509952766b.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927044; x=1720531844; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ecfFljGl6Zkim9DCUjoRXwO008EQczT8AR+MHY7m1z4=;
 b=i3tSLiZ4VTEr3dUS99ftq7jeWapkvn29PPX6eccijpghzLcq9aIc+DGNI8ABkFKEFN
 IKxRcNdfR0XS7cBv3Ksyy9l2M/F5RSadi8EduwGkgvDLsKfgMToGyGCZTY6bC3WvxKq0
 hYIFiwV4Z8Dw/2X/+ZztH6MOq21hdX++Bq802LsUCRDIAMumHHujssB3yxd2tGCWD4TN
 xzqb9P72qTMIhw1E2Ipr4vW2T6Shwm1GdfaGJnk7iky15bVBiuCknu2CdscjXFhILHbe
 XjdFWuUM0RSTJnWdoEqP4M1Nle60gf2p06b/UTX87GazDOn3Dxc7iderytgF1XcGmBlM
 0j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927044; x=1720531844;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ecfFljGl6Zkim9DCUjoRXwO008EQczT8AR+MHY7m1z4=;
 b=Ey7KswPj5A0C34y+LkDY8wCeqNAP1x3A9IlC+wavCW0pLeTdCXUeVvfoY0xz1cfyP4
 it8Krg12RuoCrgDmArEa6FyRjAnITwHvOQy178+l04oOPKpmCQSJLjeAzUSpPZQylQ4E
 hd/kGpbzdowbWkNq4VU99EC3M1PRaE6WO92h2MmPbY8I/hfYYtUM3e5wzPM14cFmNYVg
 Zn6IDJcDSAPca3s0rCprtohGMLx95SPu2zymrBGVgUp4wLSJfAjG1l5vugFtwO6K9Yek
 /o0KH5ygTwWlPoIVK70VNETzkN9X6VLWBMlM9jaa2Asd5FwsLecssY9P1VuEy/jheU51
 +7BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWkEO+F3Q1s6dj1Y4PYLy5KdyW8SijyeilKD7OFKaCaq6I9hhPrJrzFzP9M9EF+uKuzbE7/EoW1IEf/FVa8oxVbMPajQ==
X-Gm-Message-State: AOJu0YzPG5ztmFGIwk6p/ijHoDA3kyR5AIrw/U1L9EDUfYz0EDCfn7AZ
 T3+ScszZaYde5EulUYASLQqZTPZ1A10weh7zKvFP0l5z3zYCznYA4c2XIG5lhrc=
X-Google-Smtp-Source: AGHT+IFfXL2km/VvQqybFY7TEhfXhcrRG//CvbWiCaIckCLogeLtwKUQFCUgAcR806p9uAwplTRZUA==
X-Received: by 2002:a17:906:f894:b0:a6f:569b:3ff0 with SMTP id
 a640c23a62f3a-a7514454695mr516926266b.26.1719927044264; 
 Tue, 02 Jul 2024 06:30:44 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:43 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 00/10] efi: CapsuleUpdate: support for dynamic UUIDs
Date: Tue, 02 Jul 2024 15:30:40 +0200
Message-Id: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAABhGYC/2XPwQ6CMAyA4VcxOzuzlQ7Qk+9hPGyjQBMFM4RIC
 O/uIDFqOP5N+jWdREeBqROn3SQCDdxx28TA/U742jYVSS5iC1CACgGkQ1mMjb2zl33PhdTWWKc
 xTz1kIm49ApX8WsXLNXbN3bMN43pg0Mv0Y6Uba9BSScq1QVKKPOL5xo0N7aENlViwAb6AgeMWg
 Ah4SMtEK5M5Rxsg+QESvQWSBbBo40OmcEr9AfM8vwEgwvuIMQEAAA==
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7220;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=QzMytdNka6KShFkBj3aJo1rX3WVT83cObsKa3piay38=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAEBK6qYlhVKByUGUxlrb5W3DWWjgO0iawBlp
 eZdLOgOitSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAQAKCRAFgzErGV9k
 tkB8D/0aCRNM2R++ICD3KSIUXRk441cq5fqnIUqtRjBSamINKBxi5PH5RQYHy78pdjWhnMMvKBe
 qXrlUwZ7YZ55fRMWD/JZRP+iPHMqal29PZzUzAYVBlQ4R6YW1psbPTbUMnNPEYoPVl0E/1uAYFf
 szSrpYxw6igworOYSpSj+lji1CZ8OfINOvV71L/B1RJEQ/L6qtWnsBop/CbH4b5V+IUqZTTSbBX
 YxjTZHE1GfjjuQHMkZv58YVQA0aFMUxUerQZRz7ws+q28D1cXb/h+gJ3EE6pu/v4ZB38+6UhNIo
 7nrzZQZh9nCkjP8Wl/rOCHLk9pZZJiDyiVI2vq2M8eSjtvIonyomr36mPTql1EeBWt54JdDnl1y
 Phgy0NG5t0SpEw5x4QevGD6PHgYCgvw1xn/yWriMcYqJB8aGbariQuMKnb8szYufOhzhjJUSMYG
 M+4sH4Z1hz+QmfnPV6e9Nvy6m+BNMugv1TuHQizppthTxikBRgVQS3vcMWlDvVeeOw7RnyX4GFo
 RSs1KsRSbadOu2UdkdaL+C2krajenfLahYvqkupqvPAPYs7L07NqHtt6z0C3c0JkWKuWAMsw/qd
 /QpMOZbjHRB4Z/9NTGlwF3Rg8+OhmbestcNv1Z/+iwpwggzvjnJMAelqmLbJYKydPxE86DlWFZ3
 Jv1v4NQG/e0lPXQ==
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
Caleb Connolly (10):
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
 test/lib/uuid.c                                    |  84 ++++++++-
 .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
 .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
 .../test_capsule_firmware_signed_fit.py            |   2 +-
 .../test_capsule_firmware_signed_raw.py            |   4 +-
 test/py/tests/test_efi_capsule/version.dts         |   6 +-
 tools/Makefile                                     |  11 +-
 tools/binman/etype/efi_capsule.py                  |   2 +-
 tools/binman/ftest.py                              |   2 +-
 tools/eficapsule.h                                 |   2 +-
 tools/mkeficapsule.c                               | 210 ++++++++++++++++-----
 54 files changed, 512 insertions(+), 148 deletions(-)
---
change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
base-commit: a5c0ba7a9f65aa3843f360d09ea986dcade112f5

// Caleb (they/them)

