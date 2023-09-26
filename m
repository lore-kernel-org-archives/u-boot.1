Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF66E7D240
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE5586BB9;
	Tue, 26 Sep 2023 08:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PES0xO11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6CC786BB9; Tue, 26 Sep 2023 08:58:07 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A5E986B95
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6c2107685cbso927155a34.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711483; x=1696316283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AQ5PIQBhDcJ2YVHQ6hIjoaQQOPHGCvJGj72bqsMF7Xg=;
 b=PES0xO11YiRx/8GWp3Mf6j3blWXu/CnBQgYgm7SEpYs/Sx5lbnucCkThzQpV218wPZ
 Zwu0O09aJXmp3SnLhtDXnZA5FTfIwaGZPdLCngyXlKNltTDo03P72oO73cOmsb1FPmpv
 shvmKmrKJQklbrx36uVAR329z5NJEOROlK6ZcTgXMMapwwaNP48l6trqhrz5t+H31Lr8
 BoZ+aINcXDVLORfye2djxn6AABfLuqFuYZD51giutfkUrPwgyIW/igh+Dbt1dLKzv+vu
 zTG9rxpGfWi32Kj2cQsW70t8RgvsHp60fVzM/qcEEN+mM9EcKZCsSOsstfdNBUTVG1x4
 AuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711483; x=1696316283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AQ5PIQBhDcJ2YVHQ6hIjoaQQOPHGCvJGj72bqsMF7Xg=;
 b=wzu46hVETgF5FIkUvmFhV6oNb48dC1EIdMoVb+/gigDmzWwhq0lB+xh0TqUWqGRc6f
 2CxqkFHcNK4IUr3b6xGep4clK9wDJoqUqf3yeU3zm/bwiDt11BGFefg4H11FZDCXSJxa
 DHqtfUesuZmsrWd0f7mSyxSeWDlHRsR/R5o6FQyEbX9MNcWylKFX17xQlZ1+ZbOxuyjr
 C68Vh675OnwKeAbhm05uKPIk7ZCGdWFrT4I5+TFietFsmEdlAvpZqmb1oJF+4nGuhJCX
 pOsvhX72KHapm3BfQwSAAO2ak35Zu1jwwzBiQfI5Z5RqNQtmrvinBh5zBY3jrfxyK8rq
 Up2w==
X-Gm-Message-State: AOJu0YzHbdlDhDCQLRHGnGUMRvuqU7SO5t/VsUEkmZW1JV3KiaVWtiiD
 abY5roBfZBwWPFhtETbqgJVkcQ==
X-Google-Smtp-Source: AGHT+IF6Q3i7YUmr45JaT3ih9bIO2Om36pgAtWO2J5VP3nUCIYK4xvgbYGg0uJTQpi5kFDTJVoDYfA==
X-Received: by 2002:a05:6358:140c:b0:145:769c:f56b with SMTP id
 m12-20020a056358140c00b00145769cf56bmr3588745rwi.1.1695711483570; 
 Mon, 25 Sep 2023 23:58:03 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:02 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 00/16] firmware: scmi: add SCMI base protocol support
Date: Tue, 26 Sep 2023 15:57:34 +0900
Message-Id: <20230926065750.734440-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This patch series allows users to access SCMI base protocol provided by
SCMI server (platform). It will also be utilized in separate patches
in the future to add sanity/validity checks for other protocols.
See SCMI specification document v3.2 beta[1] for more details about SCMI
base protocol.

What is currently not implemented is
- SCMI_BASE_NOTIFY_ERRORS command and notification callback mechanism

This feature won't be very useful in the current U-Boot environment.

[1] https://developer.arm.com/documentation/den0056/e/?lang=en


Test
====
The patch series was tested on the following platforms:
* sandbox
* qemu-arm64 with OPTEE as SCMI server


Prerequisite:
=============
* This patch series is based on v2023.10-rc4.


Patches:
========
Patch#1-#4: refactoring & bug fix
Patch#5-#7,#10-#11: Add SCMI base protocol driver
Patch#8-#9,#12-#13: Add SCMI base protocol device unit test
Patch#14-#16: Add scmi command


Change history:
===============
v5 (sep 26, 2023)
* fix a per_child_auto size (patch#1)
* fix an existing bug (not using a protocol's channel) (patch#2-#4)

v4 (Sep 12, 2023)
* shuffle the patch order (patch#5,6 prior to patch#7)
* several improvements/cleanup thanks to Etienne
  (Each commit message has more details.)

v3 (Sep 8, 2023)
* import patch#6 (protocol availability check) from my followup patch
* fix an issue on ST board (reported by Etienne) (patch#1)
* minor code improvements
* fix various typos pointed out by Etienne
* revise function descriptions/comments 
  (Each commit message has more details.)

v2 (Jul, 26, 2023)
* refactor devm_scmi_of_get_channel()/process_msg(), removing uses of ops
  (patch#1)
* use helper functions, removing uses of ops (patch#2,#9,#10)
* add more descriptions in scmi command doc (patch#11)
* remove 'scmi base' sub-command (patch#10,#12)

v1 (Jun, 28, 2023)
* initial release

AKASHI Takahiro (16):
  scmi: refactor the code to hide a channel from devices
  firmware: scmi: use a protocol's own channel if assigned
  firmware: scmi: support dummy channels for sandbox agent
  test: dm: add protocol-specific channel test
  firmware: scmi: implement SCMI base protocol
  firmware: scmi: move scmi_bind_protocols() backward
  firmware: scmi: framework for installing additional protocols
  firmware: scmi: fake base protocol commands on sandbox
  test: dm: simplify SCMI unit test on sandbox
  firmware: scmi: install base protocol to SCMI agent
  firmware: scmi: add a check against availability of protocols
  sandbox: remove SCMI base node definition from test.dts
  test: dm: add SCMI base protocol test
  cmd: add scmi command for SCMI firmware
  doc: cmd: add documentation for scmi
  test: dm: add scmi command test

 arch/sandbox/dts/test.dts                  |   5 +-
 arch/sandbox/include/asm/scmi_test.h       |  19 +-
 cmd/Kconfig                                |   9 +
 cmd/Makefile                               |   1 +
 cmd/scmi.c                                 | 337 +++++++++++
 configs/sandbox_defconfig                  |   1 +
 doc/usage/cmd/scmi.rst                     | 126 ++++
 drivers/clk/clk_scmi.c                     |  27 +-
 drivers/firmware/scmi/Makefile             |   1 +
 drivers/firmware/scmi/base.c               | 657 +++++++++++++++++++++
 drivers/firmware/scmi/mailbox_agent.c      |   5 +-
 drivers/firmware/scmi/optee_agent.c        |   5 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c | 469 ++++++++++++++-
 drivers/firmware/scmi/scmi_agent-uclass.c  | 412 +++++++++++--
 drivers/firmware/scmi/smccc_agent.c        |   5 +-
 drivers/power/regulator/scmi_regulator.c   |  26 +-
 drivers/reset/reset-scmi.c                 |  19 +-
 include/dm/uclass-id.h                     |   1 +
 include/scmi_agent-uclass.h                |  89 ++-
 include/scmi_agent.h                       |  29 +-
 include/scmi_protocols.h                   | 351 +++++++++++
 test/dm/scmi.c                             | 248 ++++++--
 22 files changed, 2638 insertions(+), 204 deletions(-)
 create mode 100644 cmd/scmi.c
 create mode 100644 doc/usage/cmd/scmi.rst
 create mode 100644 drivers/firmware/scmi/base.c

-- 
2.34.1

