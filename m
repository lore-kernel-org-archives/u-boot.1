Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E85EEB8FDE
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6776586467;
	Fri,  8 Sep 2023 04:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BEB93LIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0614C8645F; Fri,  8 Sep 2023 04:52:18 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28F78645F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c0a4333e03so3612345ad.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 19:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694141533; x=1694746333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zBf8rSaDqLSjB2tMWzSA11fPFdlVhtXZxRMcM1Gr/Tw=;
 b=BEB93LIVzE2j56YPc1t+56XlW6XXaLq9UGYh/iLMtqh2vpsZj45Y7qhrP5gTspwzsC
 EpmNZ9lDyusBe0eRqrNZz+D3v7PbCEV2+MQwruAGkhjkX6otmXghCE2WCn3jN3isEKjm
 01AsF/OjVdoJKivclyE7npDWMUxsqNNm9p6sa6TBoiexPks3++rm+FBd5MGNKqCcNKWL
 x9fFF3eA4LKQzxJCMUzQuIWcCTIbIZHxwdNhMPo2TWWFdA5slsarflBLZslhWv5BMTeI
 SRIFDN5iQlDMfJqBbz+oHUFhnM5Xs04VkMpTD2tpuveAjfvGBUYYVFewu2uOHzmNQCdf
 gPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694141533; x=1694746333;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zBf8rSaDqLSjB2tMWzSA11fPFdlVhtXZxRMcM1Gr/Tw=;
 b=xCDGCnYJWvbXnr4X68a4sFRDc1cnq6ndmETj6hB4QoZuQubeCYZ6xQuO8BmHJwL+oT
 9i26Fplf7UDn9yLIraSazaCCMT/GETRXYpgexev7Zqa6sEslY7N7veNpfAVfADjXHJGF
 pfxgiA3Vtb/TVyaPgO4aK2o/6RlyfafSztUdaByxXi2nMFjKMrHaOFaH1y46QIYTmZZ7
 9eDL/SBgOLA5S0u0gZ3uc+SMDrOkuwFbQTHjST2B+gmsppKuvlD8BS5LRufmVqBIyoyG
 vMQK0tSlVF6TzthpqnZGjQRoPanpeKwH7cl2mHurXYt8BFkw5nk4Q7jcWDB1KjdckuqU
 jicQ==
X-Gm-Message-State: AOJu0YxdLljj5BxRd/477sIyn2BVEdYar4KeycbhVjvmB5tkYjbGMk/C
 YqhxblgGScI2EkHp/xrpWG+ByQ==
X-Google-Smtp-Source: AGHT+IEx9DjC+iwFq/7al6UfsrKICQPJ+FbJd60jgsVlTOGs1WsVyPO4J3qUEGWlFcKxNoCTtM4npA==
X-Received: by 2002:a05:6a20:8e19:b0:111:a0e5:d2b7 with SMTP id
 y25-20020a056a208e1900b00111a0e5d2b7mr1257040pzj.4.1694141532747; 
 Thu, 07 Sep 2023 19:52:12 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001c0ce518e98sm417286plf.224.2023.09.07.19.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 19:52:12 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 00/13] firmware: scmi: add SCMI base protocol support
Date: Fri,  8 Sep 2023 11:51:25 +0900
Message-Id: <20230908025138.44405-1-takahiro.akashi@linaro.org>
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
* This patch series is based on v2023.10-rc3.


Patches:
========
Patch#1-#6: Add SCMI base protocol driver
Patch#7-#10: Add SCMI base protocol device unit test
Patch#11-#13: Add scmi command


Change history:
===============
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

AKASHI Takahiro (13):
  scmi: refactor the code to hide a channel from devices
  firmware: scmi: implement SCMI base protocol
  firmware: scmi: move scmi_bind_protocols() backward
  firmware: scmi: framework for installing additional protocols
  firmware: scmi: install base protocol to SCMI agent
  firmware: scmi: add a check against availability of protocols
  sandbox: remove SCMI base node definition from test.dts
  firmware: scmi: fake base protocol commands on sandbox
  test: dm: simplify SCMI unit test on sandbox
  test: dm: add SCMI base protocol test
  cmd: add scmi command for SCMI firmware
  doc: cmd: add documentation for scmi
  test: dm: add scmi command test

 arch/sandbox/dts/test.dts                  |   4 -
 arch/sandbox/include/asm/scmi_test.h       |   7 +-
 cmd/Kconfig                                |   9 +
 cmd/Makefile                               |   1 +
 cmd/scmi.c                                 | 337 +++++++++++
 doc/usage/cmd/scmi.rst                     | 126 ++++
 drivers/clk/clk_scmi.c                     |  27 +-
 drivers/firmware/scmi/Makefile             |   1 +
 drivers/firmware/scmi/base.c               | 656 +++++++++++++++++++++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 379 +++++++++++-
 drivers/firmware/scmi/scmi_agent-uclass.c  | 416 +++++++++++--
 drivers/power/regulator/scmi_regulator.c   |  27 +-
 drivers/reset/reset-scmi.c                 |  19 +-
 include/dm/uclass-id.h                     |   1 +
 include/scmi_agent-uclass.h                |  81 ++-
 include/scmi_agent.h                       |  29 +-
 include/scmi_protocols.h                   | 351 +++++++++++
 test/dm/scmi.c                             | 228 +++++--
 18 files changed, 2506 insertions(+), 193 deletions(-)
 create mode 100644 cmd/scmi.c
 create mode 100644 doc/usage/cmd/scmi.rst
 create mode 100644 drivers/firmware/scmi/base.c

-- 
2.34.1

