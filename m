Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAF6FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5AA84150;
	Sun, 26 Apr 2026 17:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qbLJ16Uq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B6684137; Sun, 26 Apr 2026 17:41:02 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1089C80087
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so55595025e9.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218059; x=1777822859;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=38y71G8u32Iq7qDsma7gZWIJhzWUGr4t+BVMIDD2Oq8=;
 b=qbLJ16Uq5JARnlh+dXTFd5rEPm+ieQju393xHCdaatWInYEctUZ6boOughbbOH/4Q4
 alkonHiR9ZlzBZDoF+nxDtDKUq/TqofD1EU2Ax/kxmbM1rBfsHVW5eioXc491uJyuetx
 9ED0zXhFTtDM++/pMCA9wGWyGYXC09XUoYDkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218059; x=1777822859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38y71G8u32Iq7qDsma7gZWIJhzWUGr4t+BVMIDD2Oq8=;
 b=NEPdocYacL9bAOyK8S7UALaFVT7GjiRYNRM1zcIeqjLdvO85QAXIMhNmVXQhFRaVFY
 HYxphNcIWpOaHI7G+JPQ8vC20IDjW+wc4mn89Ii5U+1PcrLhI76H0UpmXWGs02GCnRdJ
 eAia4GK6wOPhPXeEP/FlfcG5FK51pREFR47wkf18CuS6cut3Sfz6hpKVFQ/ILXdJLhyV
 8StLP/aYJ4zQP6keMBhdsUcpw1XrfPxsNPbD+A8Q7LMsYGLJTgylQRAas7Kc3S+J6Bd2
 JT4bpfcAy3gYmY0FWsbamMK+WhdMXLMJQ+lOrFsTj5gp+6eDVw9VyFkFjX+PGY/hDiid
 wFIg==
X-Gm-Message-State: AOJu0YyWSN4bvgtZ+IdB6oOhZSAyQXmAZ8FFkxDuy60Mjgs2dWHOYNRH
 y4v4NSmPcoL49zF9mSQ/L8HugOGysTZDYDdDazXVpwbdn1u0+uYx5gtjbQtixvkqThcOcuaJYVj
 FQ/fP
X-Gm-Gg: AeBDieuwt4PrUMfBo0lNTCMKiIbl8yzDUyGsHqz8Rgn7feLEnQMPp4p7ZKAtT/Cjxcc
 PQvc7RVWa3wpOHfYcTapxJHHe6F9c1D/NlKAJYkuHOSPg+jcPeMeFHCnjZQAi0nQfUCFXhlgy7/
 l0lcQI233iOJYrTrGrPwA/k2eibHvMi5sdvJdqO1JVv8CWP/tMlpwjzbeVLqOba7gCdIbEIqYp6
 RUX/EFT0+UaBMIl7yjSLxA1UmEEEWWQ/OOKGcqov74v4rCYCQ0rE0JhMQ9VPzfITMPM87H2Fd1O
 vNBuy1ndBCB4cH2kEjhOGnAcFtwz90Bdx9U3YLfrEBjHiNbsVqRVcTNOxAM5MbH+VsVINssCd/z
 DS2VQpWoMXwk28mFb5G141rf9aaLnK4zwsB7OXo/GdMjd5Xu0d2ldgQhvFd6AiJ1fT+BIeRS241
 3VEXJ2kMzmJmQ3iyvZfJdxYQpX21JzMVCu3BHL1rRe4BHyIcDH5t8+CoJ0Mtu8BuPV3/Lda0Jil
 pHyJyb4S79gK2fbqPNfw798MDgYLbzKQ3kNHXzfnePviG36FYWqWiMpkb109TOPcbWfKutGP/CI
 qn1Uk+gk0P4saQrsmNSvid77z6Z5sw==
X-Received: by 2002:a05:600c:3e8f:b0:48a:65a5:751f with SMTP id
 5b1f17b1804b1-48a65a57799mr154552245e9.31.1777218059218; 
 Sun, 26 Apr 2026 08:40:59 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm802593765e9.14.2026.04.26.08.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:40:58 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Bin Meng <bmeng.cn@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 John Toomey <john.toomey@amd.com>, Jonathan GUILLOT <jonathan@joggee.fr>,
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
Subject: [PATCH v6 0/8] Support metadata-driven A/B boot for STM32MP25
Date: Sun, 26 Apr 2026 17:40:32 +0200
Message-ID: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
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

Changes in v6:
- Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
  tests for part command"

Changes in v5:
- Update doc/usage/cmd/part.rst to reflect the changes related to the
  part command.
- Add Acked-by of Ilias Apalodimas to patch 6/8 "fwu: add helper to get
  image GUID by type and bank index"

Changes in v4:
- Place the part command tests in the cmd suite rather than the dm
  suite.
- Order the include files according the U-Boot coding style.
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
 doc/usage/cmd/part.rst                |   6 +-
 include/configs/stm32mp25_st_common.h |  15 ++
 include/fwu.h                         |  11 ++
 include/part_efi.h                    |   3 +
 lib/fwu_updates/fwu.c                 |  33 ++++
 lib/uuid.c                            |   1 +
 test/cmd/Makefile                     |   1 +
 test/cmd/part.c                       | 209 ++++++++++++++++++++++++++
 test/dm/fwu_mdata.c                   |  48 ++++++
 test/dm/part.c                        |  53 +++++++
 13 files changed, 419 insertions(+), 7 deletions(-)
 create mode 100644 test/cmd/part.c

-- 
2.43.0

base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
branch: fwupdate-ab
