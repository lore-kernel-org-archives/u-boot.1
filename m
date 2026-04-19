Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B595AEA7190
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 14:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F60B8421A;
	Sun, 19 Apr 2026 16:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kp+Ekx1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570FD84214; Sun, 19 Apr 2026 16:32:58 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04DFB83B99
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 16:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so32736035e9.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776609175; x=1777213975;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SkM7z/RI8tzs7t4yVAlnuLnFIB/0Nbr6u3YHDWU9clc=;
 b=kp+Ekx1+N+xm3D+uahttb8MDRLtp23JojSM8DSrmAy8dVYqNYvY4D3mFVaUMJmEmZf
 b7uRkVEneN5eU7Drg3s/RXJb1H/t1ibW0IbuEIugVEGMH/c5LRfD3nsVaN+xMM5zx+LE
 b0lbx0k/hpGRyObNe511ulkuA+Cc1im6QiLhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776609175; x=1777213975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkM7z/RI8tzs7t4yVAlnuLnFIB/0Nbr6u3YHDWU9clc=;
 b=WYbqG+CqudcqiYHF8cXdquH5xilj4cNkevrUDjuyQWhUIrhMca2C4epDD7DG0/GMUt
 XaVdqrY3g4fHTbXvmnhX8xqzZx7QbTNdSWxdp7VypyDYfAtMp55p+2F9Uz5QvWQv1rM1
 Z6Z381NGcYvFex41+282FXhlSmNfqKw3FQp7VoZ2Z6kFLNHbNEiC1+1+YM5WInLrFLp0
 mqytuKoQfDZJa8sbcAiY35/tGcN5nU4jxl0ZgDSdc/Xk2eqt+ALni2mSVXpgWO5hdWec
 oXIh1g04hlr4pY35yg8kVfTkvCtyYCRfn7DgNiV8Uqk3sqcE4FhJUENLPlGnJbHtgbHb
 s98g==
X-Gm-Message-State: AOJu0YyHK8J4SVGS8g0MVU3l6wwM39bsDYDpVyLVHHWqjRms3thf77EL
 IOl8r+yPscEwBeo4qLXVBVDWwgg1B9KICNRLCgmxdD+/dNbz0lN6uvk3OVX2dGTwaeAF4ZQLoz2
 pgK5B
X-Gm-Gg: AeBDieuCHOS5n923odt6chIybUmFBMs6bYDSB48NxDDf1sFmYCaWu1R9oanOW4kNawY
 hA4DuxiabuV/wwOPfK5afbw/uK5B0FUZT3NHCY39HuW1M10xdnbGzYBNz0dnct/aNd+XTqdk+1/
 IP0iurSlFItxqWCU0rjabQKxYixO+D/kPMRWopoFDFOjG/AD3WvJl8wl+NS7CV76zX+FpzXzjrG
 DDVk/RDfeHKaWNselJgIk7T61nR1gWs7hq39b6LNgzHVDI8Icf+/aK4ZLeAuTujKibMKW174HEL
 KeLKgnwmSaqS6iHYOOfgpjWI9MiFVp1plj5gvwCJ9p3Jd2dz7p21gZBMbrVU9olmJNiY/PFaINn
 WtSNRHcYEI46uPxmOFOlp1kl2snFfrjvbuIiMduoCX1vXxMlZRlPxM6WO2nsTw63j7S9NJCOFEn
 GS0679IxmRwHM4y5lMPkUPnjXiRHVIk+JLx9vnCvHaSuzgDB4ogfk8knBRZQqpQ3QvNreuijE/Y
 noLLdtMpyCGQxvhWbRQXbO7fhBUJZezy3Pt6Cvk4UjmpR95738B0sS9fqFv86/tVQ24fTrfLAqS
 vLw7FUPKITyWxbj0ig9F8aMUCc2Ed0al
X-Received: by 2002:a05:600c:8183:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-488fb765ab5mr158660815e9.14.1776609175076; 
 Sun, 19 Apr 2026 07:32:55 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-20-97-39.retail.telecomitalia.it. [79.20.97.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb755938sm86864245e9.3.2026.04.19.07.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 07:32:54 -0700 (PDT)
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
Subject: [PATCH v4 0/8] Support metadata-driven A/B boot for STM32MP25
Date: Sun, 19 Apr 2026 16:31:40 +0200
Message-ID: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
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

Changes in v4:
- Place the part command tests in the cmd suite rather than the dm
  suite.
- Add patch 7/8 test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid

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

Dario Binacchi (8):
  lib: uuid: add partition type GUID for extended bootloader
  test: dm: part: add test for part_get_info_by_uuid
  test: cmd: add unit tests for part command
  cmd: part: support lookup by UUID
  test: cmd: part: add UUID lookup tests
  fwu: add helper to get image GUID by type and bank index
  test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
  board: st: stm32mp25: support dynamic A/B bank bootup

 board/st/stm32mp2/stm32mp2.c          |  32 ++++
 cmd/part.c                            |  12 +-
 doc/README.gpt                        |   2 +
 include/configs/stm32mp25_st_common.h |  15 ++
 include/fwu.h                         |  11 ++
 include/part_efi.h                    |   3 +
 lib/fwu_updates/fwu.c                 |  33 ++++
 lib/uuid.c                            |   1 +
 test/cmd/Makefile                     |   1 +
 test/cmd/part.c                       | 209 ++++++++++++++++++++++++++
 test/dm/fwu_mdata.c                   |  48 ++++++
 test/dm/part.c                        |  53 +++++++
 12 files changed, 416 insertions(+), 4 deletions(-)
 create mode 100644 test/cmd/part.c

-- 
2.43.0

base-commit: e3405917a1806971d9e72a94186b299f05581e1a
branch: fwupdate-ab
