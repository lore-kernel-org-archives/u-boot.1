Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8C8CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C4F86CEC;
	Tue, 12 Sep 2023 08:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PnkkQXEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1175286DA7; Tue, 12 Sep 2023 08:21:18 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC3DD86CD9
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-573e931433aso630881a12.1
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499673; x=1695104473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ow31Zbnq14pJEpkX1n+ISMOBd4veK+oojCyXMPlYIxA=;
 b=PnkkQXEpg0JZKVChk4fUIy4bfSUS5XeZzEpWdxmJaGVSQ0cDsp+InTSpvVQ1EVMLbV
 d1mT5IXr0sN8gJ7HadQsPNfZVA9OU4gXFtyhR/U6reUfIUbxURAujL5AjxZyDKt7zppP
 votilHC42FxA3TFwldzATUyBIxcNMUqEBceuXlHXIxePUdgDCzQiQqVVPv/p1UDz2K0R
 ewZlbppASec11o3vYl2Fe9t9Sw5ygiBCouNcb1LEfAQY5dKuGPUxAX0WKhreyQiXm0cc
 ArZhKgsijxlpQ05C9zxaJkG+824SYCHqsJywGxVPfVNwynUuDKa+inU4pcawU9mmFPf2
 Av5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499673; x=1695104473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ow31Zbnq14pJEpkX1n+ISMOBd4veK+oojCyXMPlYIxA=;
 b=ShElgUohKCZO6AxDwu+t7fsL0EPrNWspz80Uzyn86brSBH1bSvGKzd58MnqOQN4wSJ
 S0ELg7w7cOGFyrWKXQ4DfX1OPmpPQICMdVy6NQciq5TTj07pWkVfCs2LMQn47Cn519ZM
 J5A5xL2JGMrIbzEXKf+S0drgVpfdvOBsDGTFY7wfX/OGi+JMKlfi9FBMOHMOWDl8IjTD
 DeNqYQ+8fdSATxZBBWnUskj7ryZHPEGPbguI/G//vQauCDvFueTeyUBwfhQis2ipVGLQ
 mN4ZAVTofyT3dseWct6wj71E722WwVjb5Yo655nsi1RNko1+n+2q3F+irYFdbIDvf0an
 MdrA==
X-Gm-Message-State: AOJu0Yz5BkyCjbbD3G8TYP1Z/We9JRAa3ZzaBU1Hxa0VuQfsZOgdU7gB
 x2L63vbXLbvOYvYXCcnsFTkQMQ==
X-Google-Smtp-Source: AGHT+IFPnz6fo4MbazYUK3QriJlRzTXmeJFVguEmT6zw/NSUnikXR9cNmjd2L/ioIORcxnMi/0/VMQ==
X-Received: by 2002:a05:6a20:5483:b0:140:cb66:73aa with SMTP id
 i3-20020a056a20548300b00140cb6673aamr15836009pzk.3.1694499672989; 
 Mon, 11 Sep 2023 23:21:12 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:12 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 00/13] firmware: scmi: add SCMI base protocol support
Date: Tue, 12 Sep 2023 15:19:49 +0900
Message-Id: <20230912062002.57361-1-takahiro.akashi@linaro.org>
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
Patch#1-#4,#7-#8: Add SCMI base protocol driver
Patch#5-#6,#9-#10: Add SCMI base protocol device unit test
Patch#11-#13: Add scmi command


Change history:
===============
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

AKASHI Takahiro (13):
  scmi: refactor the code to hide a channel from devices
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

 arch/sandbox/dts/test.dts                  |   4 -
 arch/sandbox/include/asm/scmi_test.h       |   7 +-
 cmd/Kconfig                                |   9 +
 cmd/Makefile                               |   1 +
 cmd/scmi.c                                 | 337 +++++++++++
 configs/sandbox_defconfig                  |   1 +
 doc/usage/cmd/scmi.rst                     | 126 ++++
 drivers/clk/clk_scmi.c                     |  27 +-
 drivers/firmware/scmi/Makefile             |   1 +
 drivers/firmware/scmi/base.c               | 656 +++++++++++++++++++++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 379 +++++++++++-
 drivers/firmware/scmi/scmi_agent-uclass.c  | 411 +++++++++++--
 drivers/power/regulator/scmi_regulator.c   |  26 +-
 drivers/reset/reset-scmi.c                 |  19 +-
 include/dm/uclass-id.h                     |   1 +
 include/scmi_agent-uclass.h                |  81 ++-
 include/scmi_agent.h                       |  29 +-
 include/scmi_protocols.h                   | 351 +++++++++++
 test/dm/scmi.c                             | 228 +++++--
 19 files changed, 2500 insertions(+), 194 deletions(-)
 create mode 100644 cmd/scmi.c
 create mode 100644 doc/usage/cmd/scmi.rst
 create mode 100644 drivers/firmware/scmi/base.c

-- 
2.34.1

