Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F63C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070C68652B;
	Thu, 31 Aug 2023 01:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NScKHJsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB9D7864D4; Thu, 31 Aug 2023 01:29:08 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9397E8652C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34df9c800adso1122045ab.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693438142; x=1694042942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZP1rVZA70Cnf3UMGcCPrIoXLTA+pV2S0FwYeFViSqfA=;
 b=NScKHJscBE1PiCGt+X7vL57AGdAvKZx2yx4l7Iv3wrGumRXBf3ixEdUyuqMn11TC2O
 Ry4gjfMtMgpzv9qxhD6UejeI1tP4VX+pepoWdlp4OBSaYtfQIpBae9fNtkc7ez2mREDP
 rAKsOUHglgpCpYV2uTq8JTglUK6HpOsKatMmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438142; x=1694042942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZP1rVZA70Cnf3UMGcCPrIoXLTA+pV2S0FwYeFViSqfA=;
 b=IukjMEacVR/htAfeq/RC4cMKG/S+/U51zbqvFVd6DqMLRndUnoHWfncILxGw+poQhk
 C1v2lp7vKsN+67WxhJWG2R8Tjd5N8CnamzZpO3u3HMsTgx3R4JfeUuegn9NH5WBQseeq
 0jlrB5T3KDnR24LLLWAMOXVjFkBex4UVI2DEwo0+pg5nHp9BFBKs6h5t+v6Vne2HCZv4
 Wb1FDjKW8H2LajkrMSXQm54+sr/wmA54hYyYEl+JSrZygCwP+CrooLG57jlxQD0X5erL
 ioaPjrifWGjvSAoJoysIZJrSanQuCtAj0ZSoV/BeXdlCQLTA6Sw/uaTw33PcePPnrYWW
 TMhQ==
X-Gm-Message-State: AOJu0YyalqhXtZr+QQ5O6kT0fR2VDHynK7+NWJ+2EDoEVlZTUCwELbrC
 t8Do+DRgI34cB/1QfCp2dAHv4kb1gNYok7IeSm4=
X-Google-Smtp-Source: AGHT+IE1C/zjjjEBB6a4XskCR0qWY5JXAaYqxGMbu/IGG3HEWZrG/S0LwLttMOwUYJMcr7KimUn1iQ==
X-Received: by 2002:a05:6e02:f13:b0:34c:e4c6:c51c with SMTP id
 x19-20020a056e020f1300b0034ce4c6c51cmr3639568ilj.9.1693438142193; 
 Wed, 30 Aug 2023 16:29:02 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 fy6-20020a0566381e8600b0042b2d9fbbecsm53630jab.119.2023.08.30.16.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:29:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Roger Knecht <rknecht@pm.me>, Roger Quadros <rogerq@kernel.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [RFX PATCH 0/9] Universal Payload initial series
Date: Wed, 30 Aug 2023 17:28:37 -0600
Message-ID: <20230830232856.2589218-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
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

Universal Payload (UPL) is an upcoming Industry Standard for firmware
components. UPL is designed to improve interoperability within the
firmware industry, allowing mixing and matching of projects with less
friction and fewer project-specific implementations. UPL is
cross-platform, supporting ARM, x86 and RISC-V initially.

This series provides some initial support for this, for comment only.


Simon Glass (9):
  upl: Add support for reading a upl handoff
  upl: Add support for writing a upl handoff
  upl: Add basic tests
  upl: Add a command
  upl: Add support for Universal Payload in SPL
  spl: Plumb in the Universal Payload handoff
  Plumb in universal payload to the init process
  sandbox_vpl: Enable Universal Payload
  upl: Add initial documentation

 boot/Kconfig                      |  72 +++-
 boot/Makefile                     |   4 +
 boot/upl_common.c                 |  51 +++
 boot/upl_common.h                 |  24 ++
 boot/upl_read.c                   | 607 +++++++++++++++++++++++++++++
 boot/upl_write.c                  | 623 ++++++++++++++++++++++++++++++
 cmd/Kconfig                       |   7 +
 cmd/Makefile                      |   1 +
 cmd/upl.c                         |  99 +++++
 common/board_f.c                  |  22 ++
 common/board_r.c                  |   2 +
 common/spl/Makefile               |   2 +
 common/spl/spl.c                  |   6 +
 common/spl/spl_fit.c              |  22 ++
 common/spl/spl_upl.c              | 153 ++++++++
 configs/sandbox_defconfig         |   6 +-
 configs/sandbox_vpl_defconfig     |   4 +
 doc/usage/cmd/upl.rst             | 149 +++++++
 doc/usage/index.rst               |   2 +
 doc/usage/upl.rst                 |  27 ++
 include/asm-generic/global_data.h |  15 +
 include/spl.h                     |  11 +
 include/upl.h                     | 361 +++++++++++++++++
 test/boot/Makefile                |   2 +
 test/boot/upl.c                   | 457 ++++++++++++++++++++++
 test/py/tests/test_upl.py         |  25 ++
 26 files changed, 2750 insertions(+), 4 deletions(-)
 create mode 100644 boot/upl_common.c
 create mode 100644 boot/upl_common.h
 create mode 100644 boot/upl_read.c
 create mode 100644 boot/upl_write.c
 create mode 100644 cmd/upl.c
 create mode 100644 common/spl/spl_upl.c
 create mode 100644 doc/usage/cmd/upl.rst
 create mode 100644 doc/usage/upl.rst
 create mode 100644 include/upl.h
 create mode 100644 test/boot/upl.c
 create mode 100644 test/py/tests/test_upl.py

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

