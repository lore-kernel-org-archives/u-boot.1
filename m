Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FF7CF2566
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 13:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE9888CBF;
	Sat, 12 Oct 2024 15:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eIuTAWaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013C188C8F; Sat, 12 Oct 2024 15:57:28 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0EFD889C3
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 15:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so118485266b.0
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728741445; x=1729346245; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uf58j0eprAP2CQfd0MVr7dFdnTn2BCAWjXIqjTKQndc=;
 b=eIuTAWaanfCgOmNSGV6i0lNlv6A2Ho+S9DHP66kAPZvw20TBmVdbTZyqPxLj0budYN
 RJcgL3vBL829qg9X1WNv8jEJ91rU0Dkm96LuOW80Ta9DHPe9+KQWZpYHbEFHKy2ljgEx
 qejOerZC7GItWBSeJHPAafk+zK+RcmW3S6lyxE9RQqnszKxf8Ym8aGEMrCrqOagH4z6B
 mmwSlmXS4JaxMr0pI8HQgnR4o8XM1vvwgPdojdrNvdGCmaDDxZ5gRCuwEjVFOsJCtpi8
 aZLr511EscirN1j3rbcg1gzbTzDPLZopNrGu6U3Xt8dAVeOxs9HzrEqtFuuPQTtbZWJD
 bn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728741445; x=1729346245;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uf58j0eprAP2CQfd0MVr7dFdnTn2BCAWjXIqjTKQndc=;
 b=qV/XYRdwhCUxpXXhkUoeLRCW57wy4AVD9ChEzQdkRbtnHGQJgXD0O05WFINR371DmK
 dp4ym403gQQrj3dDthxRlZOwllyEjnvjT2ssdA61NTlWMpqxvj0OqJjr1Hj932kc4YOs
 oI8pgMMdRgMThDDjHgdXS6OpSQ0qhbk3X1ORfdyMtjekXhfZzH4lgPuow7KccqOc0qYY
 WSKW54K0jD6Xq7BQqDu+qKOv461ho0L+/7YQacehJpWnox3w5YGwZzZaQbnJSTXp7nmM
 BnhrocboKLcQwjdvLFXyFlXe6MbT6a0znl43OA074hbKJu2WQZ8eXjxMl9ZZZEO1jLm6
 n+EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwWWHFSXhMLczRlA/6xWLT0RhgKXhv057cVKYPhNY8/zAczO9MFy0dAz2nsp7iai/KYmv4zXI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzk0PZZ3dKCP/sojYFqJ2ulbHcl9U0IHvM0Axl0A/K9fI3jx34G
 uwqhZ8cHror+x7hMCcNKy6f+dIOWdIlCbLdDieY9y2gWf/Qe+UI3Ha6K7s9Fvic=
X-Google-Smtp-Source: AGHT+IGWr7h3+hybpeKJS/bHJfZOvDcj3hA84ZvP5tD7/cp+pEXJnLO93Yrnpr4WxOubrnwEqZrkyQ==
X-Received: by 2002:a17:907:1c1f:b0:a99:5364:210c with SMTP id
 a640c23a62f3a-a99a13ae748mr987166666b.25.1728741445097; 
 Sat, 12 Oct 2024 06:57:25 -0700 (PDT)
Received: from cymric.local ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2c1f4sm324955966b.87.2024.10.12.06.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Oct 2024 06:57:24 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 0/4] qcom: implement capsule updates
Date: Sat, 12 Oct 2024 15:57:16 +0200
Message-Id: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD2ACmcC/3XOQW7CMBAF0KsgrzvIGU+IYdV7IBauPQZLNE5tY
 oFQ7l4nLKKqYvlH+u/PU2ROgbM4bJ4icQk5xL4G+tgIezH9mSG4mgVKJNmigi+CHxu/wZohj1e
 GcXDmxhnYIJPXXnovRW0PiX24L/LxVPMl5FtMj2WoNPP1ZZLcz6bzI2SbA5QGJChuiBqzk6rbf
 V5Db1LcxnQWM1RwLbfYvX2oYIWoa7VynXGE+h+kVqguvYdUhTwjS61Q79n+gaZp+gUmjTODRQE
 AAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2881;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=MutLEsSk51XHCUObUN9A3MLd8ocgO4N5zvsEXT5Ykp0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBnCoBDaNCQ4G/YIu7RuHZUCqCTDYXc6fWVbc+cV
 hwmwjyHDQGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZwqAQwAKCRAFgzErGV9k
 tiqFEACfIvxEDdCytz3B6G6QoqVr0tBiDbd6LsVnIwgWwCSHQbF/TvFDdpherubUkZ0aKtq6uV6
 tDw+YFayC660IYAEbFrqn7CRTPZ7DUMerqmFAFCPFjQ9HPk/0MabEUngnvgnqXxODSqIeS2zI8S
 0ypsn3sadfn1ubm4u5zPn7KG0AVO/qLULN9m0xPnBqzdKfjk6o98BP9xILD7osMWeEKDSwJa3rL
 N6LHtLuDGCCymvxLMq84NTBiTu3574qsEBwOmTw+8RwbOf0yINpqoUACki7xK0BZILDSmf/gh1l
 uU2q1btcZtTxPx9lcOF+i1rbkGGQPpBc1b0DQlZ5Cf8n4/z6ywsu3R1QhuBtiVdlpMx3nwU85FB
 iSGC3dUyogs0emOsED4ujcFYxBYMEdAybhcMrq/GdQlbo32BAV9woEXPXT1AkeH+cLHwLzoKW3x
 XPlHgsGdTGmp7BMSt5U7tZyg5p7zEYunD+xVJjgihFsewgp1INd6jwQYOvZ6t9WEcjQaZKiy9WZ
 +S6SOdw4kJjJ2z2JbSwhZhCfvD4wzYIYgWLFove6wphZ/AmmLuRRUzD8o8AuiF7ksuI97HylkBn
 DlUA8XzrENK84u7iyP4a6NsPq/ptX1GTeKzIUrD4pwMMu0IRFlnwUQRHNoCZHdIMjIRLpalLAo3
 2caWJ4EvZcHDiMA==
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

Hook up support for capsule updates loaded from disk on Qualcomm
platforms.

Most Qualcomm devices have an A/B partition layout, with most partitions
duplicated. The metadata on which slot is active is stored in the GPT
headers in the vendor-specific attribute bits of each partition.

Add support for reading this attributes via the disk_partition struct
and using them to determine which boot partition U-Boot is flashed to
and generate the appropriate DFU string.

This logic is gated behind a check to ensure that U-Boot is actually
being chainloaded and not run via some other mechanism.

SCSI support for most Qualcomm platforms is not yet enabled upstream,
but will follow in future patches.

This series enables capsule updates on the RB2, however [1] is required
for it to work properly (as otherwise MMC won't be available).

[1]: https://lore.kernel.org/u-boot/20240527-b4-clk-stub-v2-0-29013855e343@linaro.org/

---
Changes in v4:
- Adjust to only support the rb3 gen 2 (since where to flash u-boot is
  still undecided for other boards) and skip the active slot check since
  both may be 0 on this platform.
- Link to v3: https://lore.kernel.org/r/20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org

Changes in v3:
- Address comments in scsi dfu support
- enable CONFIG_DFU_SCSI for qcom
- Link to v2: https://lore.kernel.org/r/20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org

Changes in v2:
- Add qcom capsule update support patches
- Link to v1: https://lore.kernel.org/r/20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org

---
Caleb Connolly (4):
      dfu: add scsi backend
      disk: expose partition type flags
      mach-snapdragon: implement capsule update support
      qcom_defconfig: enable capsule update support

 arch/arm/mach-snapdragon/Kconfig          |   3 +
 arch/arm/mach-snapdragon/Makefile         |   1 +
 arch/arm/mach-snapdragon/board.c          |   3 +
 arch/arm/mach-snapdragon/capsule_update.c | 153 +++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h      |   6 +
 configs/qcm6490_defconfig                 |   6 +
 configs/qcom_defconfig                    |   8 +-
 disk/part_efi.c                           |   1 +
 doc/usage/dfu.rst                         |  32 +++
 drivers/dfu/Kconfig                       |   7 +
 drivers/dfu/Makefile                      |   1 +
 drivers/dfu/dfu.c                         |   5 +-
 drivers/dfu/dfu_scsi.c                    | 435 ++++++++++++++++++++++++++++++
 include/configs/qcom.h                    |   5 +
 include/dfu.h                             |  27 ++
 include/part.h                            |   1 +
 16 files changed, 692 insertions(+), 2 deletions(-)
---
change-id: 20240523-b4-qcom-capsule-updates-ea2e4f8f0ff0
base-commit: 86f6e73c8d09aab77d9fa2f0583bcbe0f2732371

// Caleb (they/them)

