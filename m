Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01991C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D17988BCD;
	Thu,  8 Aug 2024 18:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lWqxD376";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF4888BB6; Thu,  8 Aug 2024 18:21:56 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33AAD874AC
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso1553381a12.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134113; x=1723738913; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bpvhBiXkhjuoVbJExry/UzVuK91Sh7P+ZNALPxg5Eaw=;
 b=lWqxD376lkWRtSlzI7p3jUheOht8tLBYoXk7SVAvQs5xryo1eoOx2kOQg1P59kdGDT
 Yjgy2/U1CRbB210Fxi2AAw0RgXUs1HpU+90MwF5WBoHinwn7/D+3ZJQk5ci9yBodANpE
 HIwjjMhVrrf3wW0oz8G+JRSxsyqpCkI9jCOnm1CowgFVid83LnfDPaw/S6qpzAqEiRPL
 pIIdudy2zjcbM+/bZ0gyY5aAqDH9sJvSuVEVVjvgq5j0yziE5D9s+YgtfgO39tyBjPMc
 NEiytwKK394XkV5ua65vFbIPen4PvSQo9rEsjh83E6ZUPds7/5KkcJ3GXJKRMC+mXa6K
 RF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134113; x=1723738913;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bpvhBiXkhjuoVbJExry/UzVuK91Sh7P+ZNALPxg5Eaw=;
 b=i3hmzmQHkjrK78m7QRy7GpHSPgaKSX5ubXcSdrrBOFUEkYjrnF6rEFcZJPP/wnJ53K
 5FwfhWaD6UOgATTp4A8kV2W5gHazNqP3AUMt/tsHAlX5HoLZYsOlH7lIHC+TkB5lvvMt
 F57v9+Kx02TWLI5Z4ld90rdwgSpXdarBDYy+agRtFv67aNHgMdb7SZUWPnEoZKI5txS9
 huVVi3AYw4nMd4/5imDqRkWVM/RnLwDt36mnlxIFouMbSNtIrcgqfKtj9z11pEEc4Fp6
 glL2uyj95wJJqL/76MsMOpHM4nX84plgeBkzdNlSKP3QxPj748H55CGG4WoWgajk2fIc
 sCig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiOFbJwsMBl8uZxmNW9UlBLlL2c9tyMlzB8zI3dtisC69g7zxefI/GKxMh7E++8v3KdFKsYIwy1J1EbEjHUhgJS+BlpA==
X-Gm-Message-State: AOJu0YxHyHvu8iSajUVhEr0qVQoQ5YQaVZ3pWgFxh6jPB/poqXT6xaAC
 yxgUSRRVpmL0C5R9k9Ek8Fj29Zf+/aONrjItfNbtqPRp2gNkCXP+E99rNvh2btI=
X-Google-Smtp-Source: AGHT+IFfxSt1nkb8MsE/mgbJ/1+tyMBksc5NbKrQSzAd2E9FNPkZ+sanDLzlc6f3oz8iMLm+2T5yAg==
X-Received: by 2002:a05:6402:5255:b0:5a2:6350:75ac with SMTP id
 4fb4d7f45d1cf-5bbb218244emr1928717a12.8.1723134113141; 
 Thu, 08 Aug 2024 09:21:53 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:21:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v6 00/11] efi: CapsuleUpdate: support for dynamic UUIDs
Date: Thu, 08 Aug 2024 18:21:47 +0200
Message-Id: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvwtGYC/23Q3WrDMAwF4Fcpvp6HLMuJt6u+R9mFf5TWsCXDa
 U1LybvPKYy2uJdHoE8cXcXMOfEsPjdXkbmkOU1jDd3bRoSDG/csU6xZICABIUpPMl5G95OCPJ1
 SlMoZ5xXZLmAv6tZv5iGdb+Luq+ZDmo9TvtwOFLVO/62usYqSINkqQwzAgWj7nUaXp/cp78WKF
 bwDBj9aACsQsBu0AtN7zw2gHwCtWkCvgCNXC5noARqA7kAP7TsKVcABBItRDQbaCuYBUC8qmAp
 YZ3VkPbCO4QlYluUPpGXUfrMBAAA=
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7669;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5DfjJkfuOvcOnGvAJ0rYfDxl9tpn8BKVIBk/2ABpPUg=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCeKhVN0K81MA1ZSnUEchr/f5Zghxwr6lura
 F0pTl+bQiqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwngAKCRAFgzErGV9k
 tmZmD/9LfH90dg7b9t3GxrSrvWF3so6JYELHWhbLotG9z6PwYjtiPoHTBrJNhukJssdzFWSRKpz
 JprmY7XCMzR37/VIkXZ/KELHGiyRvfX0dxGtlteHeAb9L6w8veT+sMpaAfaubjlJjJ1AFx3uY+r
 oFXYzZUUVEqxA3QzDHBPPCiSxjMohj2x8nxhcgUX4BKn0/Odpq4AIl+FNB/FbD2s6OAf82xqlTP
 MVZEwr58RgY8HTM6NajJu1Tj89+ocna+JskfJWI9Qb/Nb6xSyUlQzzJS8wVpSspQP07Xy7IetXP
 B9oMHfEaWSRENQZOkbGiD6sCqaQsp88k8NpYjr00RY4kZOC1u3wc22chY58qzDTOhBcBnclIReb
 9U7Uot78LFca233yt9XaO0mZ4HJucnKkJla34d2izMMuFjLv4wpmn03ezwtMoT2/TbDbgqfAX93
 BROTpYF2dCdo5caNi70l2HtTluWgGu8N1tWW9qLJKeGyPUbp4ACLMWDg2s8GhDBbmzVCWu5q0uS
 e/y8cHr7KKczFCPSrRBzLm92TGpdiqpEPfMLJ71B5rgimbXNwG0EcOv75YdAODqZB+cLMR5edSq
 TOcBbNydjkwi//fmGfWxmoMh+PNI63OsI1QpL5EJMKMo5WKGvefapfe/B5z71p96UDNxwKM+GvK
 vt2BQd8eJp4ND0w==
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
 test/lib/uuid.c                                    | 120 +++++++++++-
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
 54 files changed, 546 insertions(+), 149 deletions(-)
---
change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
base-commit: 07e73b0483a844e4581c8c94d01e73ca22c0ab50

// Caleb (they/them)

