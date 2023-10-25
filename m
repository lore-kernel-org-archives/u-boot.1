Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C320C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 05:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FEA5879D3;
	Wed, 25 Oct 2023 07:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FrPC6zaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DFAE879D5; Wed, 25 Oct 2023 07:14:54 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05CF6879D3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9ba72f6a1so10082005ad.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698210890; x=1698815690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kmEOcf58OK3s5Wr8hMn40X4qsvgpKjrft/7rxTAcwP0=;
 b=FrPC6zaJmz04IfPmRLduGFD5K/JIO4Xx8Yycqa62g+ZnDbU7X1CwnZZDZNQzLD3SiO
 oF+3mkwjbDJzFbD4SGEpcWPoadYqYG9K4A7NmF3k1eQudnxpi1j2wVnSEDD1kZvWMUlh
 nkLDeO70n3dx2ICELZrWgr2p9h5rY3x5Pa9m3eGxdt1OHU8U9qWd1JPPA09JQQI+50Z3
 IgzCo7Hj/qbnB0zbKUzNresUC66UqoZCBbkzS2BO6q2CmQKG077D5ZaXvfNLJpFLgDeu
 0AZBFtv6RvU0YszgqzYyyiFiuxuEHBg126jSu8DfF/NeQj0o4lGOtbWDdH2JM7QWeKBD
 4bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698210890; x=1698815690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kmEOcf58OK3s5Wr8hMn40X4qsvgpKjrft/7rxTAcwP0=;
 b=EAs2sQ1q+hqmblErZrPE614AaDhY5uKhtkqXDiTslQnj4BcC2+C27S4PMwIU9pm0XK
 4raJROjCYmkGfnzmlLOyb7aSSD1HBWizr9tQTPsLvf6DgNxHYFj/ohcuU3xewJhsy0CW
 4Ma7enT7R95mRDMUosCii1IiBzjXI3Ie0qFeDa+mA38cCm/FFz6yE0L6UeLICEBPxQXs
 PWXGalHLlV11WDC1hQuNxM0m+Qyj/O0L/K2mRHm42KIIcmdmDcQwKPrQvRuNrDy6yd2U
 tuGBJqRf/hw5GI9BBnepI3JoXCpVjdO6Zy5AZCpVu6FtzcQL4/I7UaXFX+gSLPj4O6y3
 w4Mw==
X-Gm-Message-State: AOJu0Yw/NN1PzRBFvj/fX2++KXMULeyRMEZ4KVkc/7EBQU4TkNFT4Zk/
 lnK8KS/Cbgjcc1dTbAluCRca5w==
X-Google-Smtp-Source: AGHT+IEXKoTP7fw+vv9KyTfinqcFrs5ZCXiJseYW59OWSlJt8HkPnGmPzOaBIq6XS2TgM1P3voN+bQ==
X-Received: by 2002:a17:90b:1812:b0:27d:2762:2728 with SMTP id
 lw18-20020a17090b181200b0027d27622728mr16489446pjb.0.1698210890185; 
 Tue, 24 Oct 2023 22:14:50 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:65fc:df7c:6edb:619f])
 by smtp.gmail.com with ESMTPSA id
 fz3-20020a17090b024300b002609cadc56esm7715815pjb.11.2023.10.24.22.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 22:14:49 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/5] cmd: add scmi command
Date: Wed, 25 Oct 2023 14:14:22 +0900
Message-Id: <20231025051427.509602-1-takahiro.akashi@linaro.org>
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

"Scmi" command will be re-introduced per Michal's request.
The functionality is the same as I put it in my patch set of adding
SCMI base protocol support, but made some tweak to make UT, "ut dm
scmi_cmd," more flexible and tolerable when enabling/disabling a specific
SCMI protocol for test purpose.

Each commit may have some change history inherited from the preceding
patch series.

Test
====
The patch series was tested on the following platforms:
* sandbox


Prerequisite:
=============
* This patch series is based on the latest master.

AKASHI Takahiro (5):
  test: dm: skip scmi tests against disabled protocols
  firmware: scmi: support protocols on sandbox only if enabled
  cmd: add scmi command for SCMI firmware
  doc: cmd: add documentation for scmi
  test: dm: add scmi command test

 cmd/Kconfig                                  |   9 +
 cmd/Makefile                                 |   1 +
 cmd/scmi.c                                   | 335 +++++++++++++++++++
 configs/sandbox_defconfig                    |   1 +
 doc/usage/cmd/scmi.rst                       | 126 +++++++
 doc/usage/index.rst                          |   1 +
 drivers/firmware/scmi/sandbox-scmi_agent.c   |  27 +-
 drivers/firmware/scmi/sandbox-scmi_devices.c |  78 +++--
 test/dm/scmi.c                               |  93 +++++
 9 files changed, 638 insertions(+), 33 deletions(-)
 create mode 100644 cmd/scmi.c
 create mode 100644 doc/usage/cmd/scmi.rst

-- 
2.34.1

