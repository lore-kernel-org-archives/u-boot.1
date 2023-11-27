Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55B4C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF12870F2;
	Mon, 27 Nov 2023 20:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m25N0N0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA087870F2; Mon, 27 Nov 2023 20:52:02 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A44D870B8
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4239fa4f305so24463541cf.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114718; x=1701719518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=73pzxzG0z956j0wPAvNW0/ZGEmu2GTHhNNTf4unrKug=;
 b=m25N0N0tzWQ0CqY8/2WwBdXtcobiXojJXFAWFP5yhkSO7jBMasyv23AGljWGXiNBkP
 Q+Mc1jONkSkkXXqy12WAsHWoAAkR4HjEW7GWU3xuOhA63V7kjmsWLuOBvn3DQ99NP88+
 kv6rHZuh244dBBh6FmGqrUAoLE35ojZjQnZrpxdpZLBk3vk3bT5YR/JtQIvudWY0es++
 UTbW0ulCB8KUZS0YcvSx/ycTmbbCMrSVgCy+eFv8t8qY+UcdGkP+GLCnghUHW8NjQbvL
 1bWQqEPjGVRthWt4b6qXAJf49wwjLEEx61pghzK6yvUv63sx4W6yhwicEm52UvhYfNcg
 kHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114718; x=1701719518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73pzxzG0z956j0wPAvNW0/ZGEmu2GTHhNNTf4unrKug=;
 b=UrtG3tkL1ReEPxq+RW33e7newasbtDb8hcanayTmPL9ihhDO59krGzmX+kJEg8yC53
 NOENdYmkC7/uIKNXbA4dfiOWQB6KIS7aygp+PRPGMt0uOqzjGKqhn++AkkFfKL1oSXXi
 NfgnbnVvvJxSFhcTydfDwNcF59fI6BLgfJ4VPNrPIgMDB2Wcyn8i8ftlNpBtX5wOwykF
 t9gaCj7er9UnSsFPMI602pJmNg2qEnzE9O1S19mnO6knUmGMTl/++iEpj0yM0vbElALO
 BwAqVHiYlIGH8zRXLM3arVSzqsZzJ5fPxUMab7FrP9pQNSRLmuZmTD+YksAaB95wfrOD
 4rcw==
X-Gm-Message-State: AOJu0YwXOdDs6YpBiWHL/bCdFHB4/cLuzDrAL4wPCd3YEHRkxSAPvaAp
 YHL7KGCb17ikBweE1SKIxTfjB15gr5Qq0NJok3oVXQ==
X-Google-Smtp-Source: AGHT+IGlH/QlJkCjtwJXbj6zY/CU17JY5o6BgZZXNW3MmMs1rrF7KD6EyDxsCxsAb3nS/3oA3yHDJQ==
X-Received: by 2002:ac8:5cce:0:b0:423:9f28:5eb4 with SMTP id
 s14-20020ac85cce000000b004239f285eb4mr20212400qta.11.1701114718642; 
 Mon, 27 Nov 2023 11:51:58 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:51:58 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 00/18] Support Firmware Handoff spec via bloblist
Date: Mon, 27 Nov 2023 11:50:11 -0800
Message-Id: <20231127195029.90951-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Major changes:

Update bloblist to align to Firmware Handoff spec v0.9
(https://github.com/FirmwareHandoff/firmware_handoff).

Implement Qemu-Arm platform custom functions to retrieve the bloblist
(aka. Transfer List) from previous loader via boot arguments when
CONFIG_OF_BOARD option is enabled.

If a board provides both custom functions for getting the bloblist and
the address of external FDT, the FDT inside the bloblist will be prioritized
during FDT setup.

The patch set is tested with previous done TF-A/OP-TEE patches through a
complete Firmware Handoff cycle (BL2, BL31, BL32, BL33).
TF-A Patches:
feat(handoff): introduce firmware handoff library
(https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215)
feat(qemu): implement firmware handoff on qemu
(https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22178)
feat(handoff): enhance transfer list library
(https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23776)
feat(optee): enable transfer list in opteed
(https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23777)
feat(qemu): enable transfer list to BL31/32
(https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23778)
OP-TEE Patch:
Firmware handoff
(https://github.com/OP-TEE/optee_os/pull/6308)
fixup of transfer list entry overriding
(https://github.com/OP-TEE/optee_os/pull/6461)

Raymond Mao (3):
  bloblist: Align bloblist used_size and total_size to spec
  qemu-arm: Get bloblist from boot arguments
  bloblist: Load the bloblist from the previous loader

Simon Glass (15):
  bloblist: Update the tag numbering
  bloblist: Adjust API to align in powers of 2
  bloblist: Change the magic value
  bloblist: Set version to 1
  bloblist: Access record hdr_size and tag via a function
  bloblist: Drop the flags value
  bloblist: Drop the spare values
  bloblist: Change the checksum algorithm
  bloblist: Checksum the entire bloblist
  bloblist: Handle alignment with a void entry
  bloblist: Reduce blob-header size
  bloblist: Reduce bloblist header size
  bloblist: Add alignment to bloblist_new()
  bloblist: Update documentation and header comment
  fdt: Allow the devicetree to come from a bloblist

 arch/x86/lib/tables.c                    |   3 +-
 board/emulation/qemu-arm/Makefile        |   1 +
 board/emulation/qemu-arm/lowlevel_init.S |  19 ++
 board/emulation/qemu-arm/qemu-arm.c      |  54 ++++++
 common/bloblist.c                        | 225 +++++++++++++----------
 configs/qemu_arm64_defconfig             |   3 +
 configs/qemu_arm_defconfig               |   3 +
 doc/develop/bloblist.rst                 |   4 +-
 doc/develop/devicetree/control.rst       |   8 +-
 dts/Kconfig                              |   9 +-
 include/bloblist.h                       | 181 ++++++++++--------
 include/fdtdec.h                         |   3 +-
 lib/fdtdec.c                             |  52 ++++--
 test/bloblist.c                          |  86 ++++-----
 14 files changed, 420 insertions(+), 231 deletions(-)
 create mode 100644 board/emulation/qemu-arm/lowlevel_init.S

-- 
2.25.1

