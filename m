Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B057EC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 12:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF44F801FB;
	Wed, 12 Mar 2025 13:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JAajs18H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2EE080756; Wed, 12 Mar 2025 13:39:43 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58EFA801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 13:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso1120381366b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741783181; x=1742387981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oL0OoihLAiwXm0m61hSCWraZ7QJLdnaJqI0+BGv2LA4=;
 b=JAajs18HF6bwI2fpAk32XKRFxBsgK6mF7xQMei72a5PmyShYeFyJzZmgvSXDUHLGZO
 IlEjHorIjM0gsQt3roJgfV4KdsKdOHZ+i92KdnzlzNO/xSvdbAtv39IqRzisRxQb45a4
 fkJnRfCWFX/U5q9kWnrng+E39F48Iek0fkHjiMnlbeiTY8Iu/zYfm2onnzMFrPGfQwO5
 LriDPBxOFz7l5dohXY9lYiXMT6ppa0ICx2/crHXmt0iI7iFyuhvKpkfPuvoNUE+KK6YL
 31DY/fQ01R47dAPxWQOG0fw7pFYqDf/2XnO80/fiy4EgvqZ3QgW3GjRlNk+pnAEXyBL3
 Qe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741783181; x=1742387981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oL0OoihLAiwXm0m61hSCWraZ7QJLdnaJqI0+BGv2LA4=;
 b=ORilqgZuaYNdD0txJeox9gOwrVeKO0zoPdFUsfwh48gNDUJ3fQcc3gnFB62mWVk2R2
 OQmzRGiBpNbI5oUqTQ7tX7PTmFzOd2EAiP5m/ZYN6k/1TEDQrPSKEoCygmWo+YSBya8z
 Y0yE6Ico6mktc5K4uOr6IXry4/ot9VHMJvPtawAMzUTA5sgLDnTZZYdwplGOMkPbf0HM
 xfKHdi8uVExr+j4OJtsX8qS6ySS8M3gd9jAJEMn59Y+EgQBhkDAgmeJ0w22NfWRbmPVy
 d4iAiiwhelue4Vra+NwH+ysqUNaYdhYTUQSKWRw3Pe0lyYGTkp+M1NwQY/PRNW7LUEMP
 ke1g==
X-Gm-Message-State: AOJu0YwKLNhuxyqCmy/oVze0zwG/6ukIltJD8BlUSX1s1+xgBgg5TRvN
 EZJ7EZ9CIdWEtRxG9zCYVCSYU+NHFchzllCKI+ibML16ADb1VgCDynorEA==
X-Gm-Gg: ASbGncvwEsBhOu8YDgSAQNZGPZ0RA5ElphB1AVjCkLJIigzRDDQivNAGnWMvu3HcQ9t
 gcWEZZTFa8TtjryAncbB9VxTxljQDLt0cWVylxrnuvV8z/y2ID/qmPd4IPyWZ7bMBefoHecmYha
 dYbt38tmQMgZU0juI70rK3SVOkJHh21DWTDSLoVMuiMXViExgBaK0NS6rtUPz1cNeBadeXFOE4H
 QI6Hw79ujazYCou4hNq4U5GlLpyW4aEikPnSpW/+U4qHpC1Qp2dVgWjBoIPDdOA9XZJj+39fw+4
 Y8tBE9GBK8Mtq7wWk0CmR5KPO9gh8OFUINeu
X-Google-Smtp-Source: AGHT+IF3MZXCHZ6vc3uuA8DX5NaSe1V02NO5FVpJ801tA7gEJQrBPlUWvCDxADuNezZ+GBiYJgR8wg==
X-Received: by 2002:a17:907:94ce:b0:ac1:e1e1:1f37 with SMTP id
 a640c23a62f3a-ac25273af3dmr2901124766b.10.1741783180388; 
 Wed, 12 Mar 2025 05:39:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac29363d604sm562273966b.76.2025.03.12.05.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 05:39:39 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra graph
Date: Wed, 12 Mar 2025 14:39:18 +0200
Message-ID: <20250312123918.52734-1-clamor95@gmail.com>
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

Dear Tom,

The following changes since commit 0fd7ee0306a88bd99d3820167fa45a7ee6fbc1e1:

  scripts/checkpatch.pl: Upgrade IS_ENABLED_CONFIG to error for U-Boot (2025-03-05 12:14:49 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git graph

for you to fetch changes up to da1eb50ca14b648984fa89c69d5e88649cec474b:

  test: dm: add video bridge tests (2025-03-08 16:35:46 +0200)

----------------------------------------------------------------
Svyatoslav Ryhel (7):
      sandbox: remap memory load addresses
      core: ofnode: add of_graph parsing helpers
      test: dm: add ofnode_graph tests
      video: bridge-uclass: add get_display_timing ops
      video: bridge-uclass: add inline fallbacks of video bridge functions
      video: bridge: add transparent LVDS de/encoder bridge
      test: dm: add video bridge tests

 arch/sandbox/Kconfig                       |   2 +-
 arch/sandbox/dts/test.dts                  | 101 +++++++++++++++++++++++++++++++
 common/Kconfig                             |   2 +-
 configs/sandbox_defconfig                  |   2 +
 doc/arch/sandbox/sandbox.rst               |   6 +-
 drivers/core/Makefile                      |   2 +-
 drivers/core/ofnode_graph.c                | 217 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/bridge/Kconfig               |   7 +++
 drivers/video/bridge/Makefile              |   1 +
 drivers/video/bridge/lvds-codec.c          | 128 +++++++++++++++++++++++++++++++++++++++
 drivers/video/bridge/video-bridge-uclass.c |  11 ++++
 include/configs/sandbox.h                  |   2 +-
 include/dm/ofnode_graph.h                  |  90 ++++++++++++++++++++++++++++
 include/video_bridge.h                     |  54 +++++++++++++++++
 test/dm/Makefile                           |   1 +
 test/dm/ofnode.c                           |  54 +++++++++++++++++
 test/dm/video_bridge.c                     |  67 +++++++++++++++++++++
 test/lib/kconfig.c                         |   8 +--
 18 files changed, 744 insertions(+), 11 deletions(-)
 create mode 100644 drivers/core/ofnode_graph.c
 create mode 100644 drivers/video/bridge/lvds-codec.c
 create mode 100644 include/dm/ofnode_graph.h
 create mode 100644 test/dm/video_bridge.c

Branch contains sandbox memory remap, new get_display_timing video bridge op,
transparent LVDS de/encoder bridge and ofnode version of OF graph parser helpers.

Thanks,
Svyatoslav Ryhel.
