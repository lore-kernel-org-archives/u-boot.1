Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C88EF4213F
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B176583C2B;
	Wed, 15 Apr 2026 20:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O+bUsWF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD5B8412A; Wed, 15 Apr 2026 20:33:05 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9771E83B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso74887975e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776277982; x=1776882782;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l3dsxgHdTRh48jhXtZr4KYgKydq1Ij5NciYZkY2qac8=;
 b=O+bUsWF08qbgARcCpjWA/rDV3Ye/t8IcI6jhtWZgIKoqwzZ23cHT4NBMInlC4UEggM
 JYl7pIbr4hF+XlCnqvC0Kh98uK8iwu7rB4oXX49YqrPxwwPvv+c8Y2G34enqA3oMSSUf
 MzraWHis35LB+X/HOPUCxSKxig7S+UwiyA/Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277982; x=1776882782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3dsxgHdTRh48jhXtZr4KYgKydq1Ij5NciYZkY2qac8=;
 b=EXque4eataH0d4+T7aJxArPqdHkE+Jex9UC59VK138WHpy7Psw+mqCnvathu1JaI7O
 SbP4SowCS5UV9eGSrvgMHF1NxzlEuWlEKeCT7P2GGTtHz0cZr8L6h+61lzygGjjUvBHA
 FpluuABuhU/smwj+JuL+8UNAVncNcqKRlnBm294pv77Gmx9NqAKvNHNd0MnK1UBxJxDi
 Y+Qa5Qb38QmXuFass3YOJi7kaiPQIfghouByk9VlTubdbyP84TXyaVaCbJwWZw+Ws5ar
 /kWHZeEKi/z8t95j004lMbgwlSKdiafx4LN3SwaTQ9MwVpceoc1GBZ5PYDJVNvrTCOiY
 5kng==
X-Gm-Message-State: AOJu0YwQXlDnUn1w3Vw97sT5Tdn4GUG9BO4FMfwz3bd/90mdjUzrvw/1
 w+eK7wvlx+YGdze0A/lyD5zocUgaEfpvplJTLAQqdCaMn0vQniyf4e496C2KikCxBnhbjdEYbHI
 oZoq4
X-Gm-Gg: AeBDietdVuMpQhY7gtlqHBqn1NtsGPmcCnE4BlKWNWNSvu/SIBuI+GRNKQ9gySe4caB
 GKjk4g4c9gIHITfT5a+wwVtUssye+yi5IGMTBq391HjTVeL2zvZETO3T1qKEK/yvk9s0QQFKSOp
 jKVVn+gO7mk6ebV7FbKlkroPCwplP+A9loOwuF3x03XG1fXV64kyQuiPMEn0EjwibJbuV6WIKqf
 ix4vk3sroCu7pR7Jqw41f0Nm4V+FzW3zKSbtcTfWkyVThu+Q1pOcY8gh5Qtkmr0azADlDZIM11B
 ga3AKNnZFxb2DKoNpnns5sHCUK5r3scl+Ztd9rGElWvYxUiGWdyB1p1YoeYnsAPCHxAabCCTSL7
 cNVFDEMSuZwhJ+hjhlKdl7ErFnh9lQCJdIXvS6VXmPX4ns57jBo2eUxxBD7wY9rseMY5vp5adJh
 fJFkauYgIKUiPP9KDhk0Eft+lK+1SWeqP1bKqWgM2Fjw+qafoCJLZNABgjPbssz2qzP3WSWAuSk
 ViYd7ujYOc7dMBFJurKf9f7PVglAR0OXFiWyP6Uu6UJR0iJAwFxlP9fxA==
X-Received: by 2002:a05:600c:64c9:b0:488:c40b:c8b9 with SMTP id
 5b1f17b1804b1-488d67b8d4emr337238575e9.3.1776277981605; 
 Wed, 15 Apr 2026 11:33:01 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e72980sm34953115e9.5.2026.04.15.11.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:33:00 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 John Toomey <john.toomey@amd.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 0/7] Support metadata-driven A/B boot for STM32MP25
Date: Wed, 15 Apr 2026 20:31:27 +0200
Message-ID: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

This series, the mainline version of [1], provides the necessary changes
in U-Boot to support the metadata-driven A/B update flow for STM32MP25
boards. It implements the logic required to dynamically select the boot
bank based on FWU metadata.

These changes are designed to be backward compatible while providing
the necessary infrastructure for the A/B scheme.

The series has been tested on the STM32MP257F-EV1 board.

Additionally, some patches in the series propose changes with
general-purpose utility:

 1/7 lib: uuid: add partition type GUID for extended bootloader
 4/7 cmd: part: support lookup by UUID in 'part number'
 6/7 fwu: add helper to get image GUID by type and bank index

[1] https://github.com/STMicroelectronics/u-boot/pull/6

Changes in v3:
- Wrap lines exceeding 80 columns in test/cmd/part.c file.
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
- Add kerneldoc comment for fwu_mdata_get_image_guid() above its declaration
  in fwu.h.
- Add log_warning() messages to fwu_platform_hook() to catch inconsistent
  FWU metadata (boot GUID found but root GUID missing or viceversa), as
  suggested by Simon Glass.

Changes in v2:
- Add links to the XBOOTLDR specification in the commit message of patch
   1/7 lib: uuid: add partition type GUID for extended bootloader.
- Update help for 'part start', 'part size' to mention UUID.
- Add kerneldoc comment for fwu_mdata_get_image_guid().
- Pass efi_guid_t by pointer in fwu_mdata_get_image_guid().
- Add patches:
   5/7 test: cmd: part: add UUID lookup tests
   3/7 test: cmd: add unit tests for part command
   2/7 test: dm: part: add test for part_get_info_by_uuid

Dario Binacchi (7):
  lib: uuid: add partition type GUID for extended bootloader
  test: dm: part: add test for part_get_info_by_uuid
  test: cmd: add unit tests for part command
  cmd: part: support lookup by UUID
  test: cmd: part: add UUID lookup tests
  fwu: add helper to get image GUID by type and bank index
  board: st: stm32mp25: support dynamic A/B bank bootup

 board/st/stm32mp2/stm32mp2.c          |  32 ++++
 cmd/part.c                            |  12 +-
 doc/README.gpt                        |   2 +
 include/configs/stm32mp25_st_common.h |  15 ++
 include/fwu.h                         |  11 ++
 include/part_efi.h                    |   3 +
 lib/fwu_updates/fwu.c                 |  33 +++++
 lib/uuid.c                            |   1 +
 test/cmd/Makefile                     |   1 +
 test/cmd/part.c                       | 205 ++++++++++++++++++++++++++
 test/dm/part.c                        |  53 +++++++
 11 files changed, 364 insertions(+), 4 deletions(-)
 create mode 100644 test/cmd/part.c

-- 
2.43.0

base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
branch: fwupdate-ab
