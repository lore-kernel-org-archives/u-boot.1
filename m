Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D13CA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE2A88BD4;
	Fri, 30 Aug 2024 14:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YTrm7dp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18DB88BDE; Fri, 30 Aug 2024 14:34:38 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D0E88B16
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-374ba78f192so26638f8f.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021275; x=1725626075; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p0t/dvg3dd8Z09e3SVPhU47HFBHDcW/+Z3crWCKTKBs=;
 b=YTrm7dp6K7zXXDFd4Dvi+0SoRgLYScIjs49unAW0nQggUFZ1PfXg0VVF/6fbumKy2v
 27GyBQmmlLP3I5HUQbcGeTksmvKGGetO/mUuOPjD+3MSs5m48ly6c0x/vF9joZrlvoVY
 RtvQzPxrpSSJS31F2h9rFnpZmMoa5okwFXQfG1gKISAdRhUBSmjukM1LBJQkoboxO9vR
 bRkRorWqpe5h3ClBE2JvVvwLOjNsIMJnmBHztsTRtu9yiHIH4arbjEM67Xk5llgpCuBG
 YETOCbd8o1okE03tPVSicc76PdOQqlrPNsMVtAL1d3FTEZPRsO+BekfNs/QXo+dvxdFc
 +2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021275; x=1725626075;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p0t/dvg3dd8Z09e3SVPhU47HFBHDcW/+Z3crWCKTKBs=;
 b=U3V32HjzW952WC809sWVf/V3HlXMR88G6cLdNl9vG0424UVC2XBuT42Xq+sXqRWLvE
 O1x/p+KqmTL1SvNRnZOGjQxPXAFuZg0Tndx35ylyggOG+DJH9CP9BZhODDMzTycdChKR
 LJwysBgFGURyZwo350OZM3ZmXNU5vOVWGYs4PuNQ7glD+rzuwwdLNgyoBs0sveW/tzbJ
 IkGnfxxh4l9+k623KR16OVk1flk7XVcuOOocCo3Q+EYXbubhczA21zHI6405tdpj1U+m
 J/iax3y6P3/Yhg/0JT+1I3JWvzkVZy3I2ueLVg2/tNGfcwiuNZl1zyRYeN/KvDAUowuq
 /VWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMBtKpmfzbamgXgIgySMYMIvmivFqmG6QvWFXWdgpo59xcwe95iYOvTv2FcFIilSo8+UHcxnk=@lists.denx.de
X-Gm-Message-State: AOJu0YzLWupKRvM4o6j3TvSHVuf1O6+121ONhpv+AdDw1BY4E5zvbNL0
 h11wjVC0FrrZAbYMzbmA+nVE887jJ2DtFUa2v9pOeznXKW7yAKWnmOnvmLbmMN4=
X-Google-Smtp-Source: AGHT+IHTsqRWicF5siubdAukjhKjai9kT2I2e1K9714rlgszqQfHGep5g+B0mz6AIQ/Ocu+pMx+qxw==
X-Received: by 2002:adf:fd08:0:b0:371:a844:d332 with SMTP id
 ffacd0b85a97d-3749b57eb67mr4185514f8f.46.1725021275272; 
 Fri, 30 Aug 2024 05:34:35 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v8 00/11] efi: CapsuleUpdate: support for dynamic UUIDs
Date: Fri, 30 Aug 2024 13:34:30 +0100
Message-Id: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFe80WYC/23RTWrDMBAF4KsErasyM/pNV71H6UKWxomgtYvcm
 Ibgu1cOFLsoyyfQp3mjm5i4ZJ7Ey+EmCs95yuNQg386iHgOw4llTjULAtKgiWSnZboO4TNHebn
 kJDGY0KH2NpIT9dZX4T7/3MW395rPefoey/X+wIzr6Z9lG2tGCZI9Gs0AHLV+/chDKOPzWE5ix
 WbaAEPHFqAKRLK9QjCu67gB1A5Q2AJqBYIOtZBJHUAD6A1w0K5j1hUIANFTwt5AW8HsAHxQwVT
 AB68Sq55Vig1gN8CDbwFbgaNSxI6UQzw2gNsDDyZw6wR1+/Vfe7DB/AOWZfkFT6OCYTUCAAA=
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8023;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dJMAyXvC315sem8/FlLWChPJSAQtW79K5UI1pMLT0wk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxYU7tVIGQtjrIsv7qhN4yv+IZLXT8fSsr5l
 au03p1CgfWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WAAKCRAFgzErGV9k
 tlQ8D/9VJSjUXDBvJLGHOIFu9AAhgfeTfniDunquIgVxyqeHleHA8w3niLVBE0Ghi9hYRAJHXYj
 h6fusmkRaN9dzKe4PxBk4NkFsfaNdh9SCvhxUrU2ra4Xj6fSwpSZUXumORabgrRCxzkbYOzFga3
 5c8yFTmZ55RNCMK4qYjD0FNvuWCkvvleg4wOZO8D2xxM01rEF1dqVVqafBgu1qpszcRRvFEoEjO
 Ms4+j2hQDQmQCGg/XtsSPNVFqqmfFfaOhQefLX3nx9j626UlWd6ICX88Ni7SFKlAp95WKsUXxZq
 1EUtb389OdSS5zckEGSuKC+FfqRKMOd4IXtwnkUNFmZGhUgOGOXLdVGkMUmgTmhRoZcfMxUSJLb
 ZdCTtlcQK4t1W2YgamseYuG+4IlimNTWfmVbkaurwna6ghAGzwVbyqas4NZmHUFJ1fRoPYaCeM3
 bsC5oDYFc669dcZEvy2+brBeplmPUXXLyBnInDxvaT4FCKhroveZOTT589tGpywm0oovcCUx3D8
 QeVIDZdSUQC38ldNbxHR4CrvCzFs8DNqugGJ3V2rnVyFsc96ufqrQxBF6XZhXKsL27daL5yv73R
 GBCoND8pg8D2JhkAAlc56YCsFb+yGxolNT3sZRd3NRLE6Sis3m2jJUCoTdeZN3CStf9QPMCOzPT
 kkm3f2crKWBFOfg==
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

CI run for this series (only v7):
https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/21944

---
Changes in v8:
- Rebase on next Aug 30
- Address checkpatch warnings
- Link to v7: https://lore.kernel.org/r/20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org

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
 lib/uuid.c                                         | 103 +++++++---
 lib/vsprintf.c                                     |   2 +-
 net/bootp.c                                        |   2 +-
 test/dm/acpi_dp.c                                  |   2 +-
 test/dm/acpigen.c                                  |   2 +-
 test/lib/uuid.c                                    | 125 ++++++++++++-
 .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
 .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
 .../test_capsule_firmware_signed_fit.py            |   2 +-
 .../test_capsule_firmware_signed_raw.py            |   4 +-
 test/py/tests/test_efi_capsule/version.dtso        |   6 +-
 tools/Makefile                                     |   8 +-
 tools/binman/etype/efi_capsule.py                  |   2 +-
 tools/binman/ftest.py                              |   2 +-
 tools/eficapsule.h                                 |   2 +-
 tools/mkeficapsule.c                               | 208 +++++++++++++++------
 54 files changed, 551 insertions(+), 149 deletions(-)
---
change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
base-commit: e83ced1a24095de66e526bd6c10f0f24584baaee

// Caleb (they/them)

