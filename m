Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBC1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 02:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D408715B;
	Tue, 14 Nov 2023 03:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P42f9wqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A5158715B; Tue, 14 Nov 2023 03:14:45 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE128719E
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 03:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6bbfb8f7ac4so1141031b3a.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 18:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699928080; x=1700532880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PrB+iqYTBaZ95KSYK/XlTia4h60tiNlLhCJwoKvy7u8=;
 b=P42f9wqCaLIeZojUxIA+ZaOJFjSW+Pz7F3S9ZMQwl+O2RmM7/+NN5LIWq6pYemYyX2
 3TKQAD6Y98A/Uy4Ckn2g2iK6+9/7H7WecWxvzsdpxV78gM5RNqZw1zCliOJKdQ76G26n
 F0/3s83QKcC/99Ewm6ZhfNzDGHkwNh9RNRaHtQypdYJumQ5RTEOilqGxvs4fRa02QEMp
 3OafOymC0UYJRuqzJAPso5+u/evZ76j92/oL96nsgWU4TDVBBYe4+VpJqUauDHnE0WXz
 zLoTBOvYbjYbRXPQBgSf+W7YoSKkQq9GP+vX7RLEaKWdZpBKa2O6P+k0veI++8QNbGT8
 FlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699928080; x=1700532880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PrB+iqYTBaZ95KSYK/XlTia4h60tiNlLhCJwoKvy7u8=;
 b=gjKUx+ja42Grzc8D9KRTKo+E/qVwmBznletgCuof9r8XFtFB8Wdb9fgRZ3FnYhKPkC
 ClFTWAy5BpVgCdW7OM7QVQA3Fxdkf5rtGei2Qy7R1CZZTkgqN/3jbNyUVWj6Dp12Z5ar
 XHPbi8CBlkl2kC42sNhmYoI6s+ZchwoDmBvb7Gcdpm4miLmaBcVMqmFHXVdEt9j23BSw
 Z7P4CiHlHf6XbW7xbdz2KSmG2I58DoPKMB5ZsyG2wwCe2imUglS3pYm8SV8tYjxYSGBz
 ohzz+FIMBowq9oGaYauIGDqdsPsXmKt+azlAelic3jrxUini2W02P4z2nfwrsUsRoZYa
 5eBw==
X-Gm-Message-State: AOJu0Yx+fTeJ5b/+U0vjNY9JFaekaA5WWQyzM1N7X6oKWFpZBHFkMhY4
 kOWQ5uEJBclUMh2sdndsb6Fp8w==
X-Google-Smtp-Source: AGHT+IH52ufyB0MjRLDd8+Y+yqIcSwBQ+X34Wd5t5BXDanj/9c5rKjaeSxKLg9WPVpy+Vdoj27WAWw==
X-Received: by 2002:a05:6a20:3d0c:b0:15a:2c0b:6c81 with SMTP id
 y12-20020a056a203d0c00b0015a2c0b6c81mr1462181pzi.3.1699928079589; 
 Mon, 13 Nov 2023 18:14:39 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:66f2:cd5c:3d82:6e6f])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a170902c94400b001c61afa7009sm4680475pla.114.2023.11.13.18.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 18:14:39 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 0/5] cmd: add scmi command
Date: Tue, 14 Nov 2023 11:14:23 +0900
Message-Id: <20231114021428.531887-1-takahiro.akashi@linaro.org>
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

Changes:
========
v3(Nov 14, 2023)
* return -EAGAIN if we want to skip a test.
* use CONFIG_IS_ENABLED() rather than IS_ENABLED().
* remove goto by introducing a function in sandbox implementation.
v2(Nov 13, 2023)
* localize global variables to avoid pytest errors.

AKASHI Takahiro (5):
  test: dm: skip scmi tests against disabled protocols
  firmware: scmi: support protocols on sandbox only if enabled
  cmd: add scmi command for SCMI firmware
  doc: cmd: add documentation for scmi
  test: dm: add scmi command test

 cmd/Kconfig                                  |   9 +
 cmd/Makefile                                 |   1 +
 cmd/scmi.c                                   | 384 +++++++++++++++++++
 configs/sandbox_defconfig                    |   1 +
 doc/usage/cmd/scmi.rst                       | 126 ++++++
 doc/usage/index.rst                          |   1 +
 drivers/firmware/scmi/sandbox-scmi_agent.c   |  30 +-
 drivers/firmware/scmi/sandbox-scmi_devices.c |  78 ++--
 test/dm/scmi.c                               |  93 +++++
 9 files changed, 686 insertions(+), 37 deletions(-)
 create mode 100644 cmd/scmi.c
 create mode 100644 doc/usage/cmd/scmi.rst

-- 
2.34.1

