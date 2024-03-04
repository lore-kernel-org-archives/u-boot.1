Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58673C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA408752B;
	Mon,  4 Mar 2024 18:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qcl8acq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 804FC8752B; Mon,  4 Mar 2024 18:45:06 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCDD786F67
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412bf22b6a4so2458865e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574302; x=1710179102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=acOFmEUnV+QRtxHwUJiU99pAOXyTaQ4NfXNDVXS1ZV0=;
 b=Qcl8acq8NVLDjbBxSrJstBkSRvWSDMwfNeMr7dOol0UqTL4kkPD7ySDiI8KxPUltcQ
 vq5XrWzbP1aLW+wsPN4Ammh/6kZ62Leftu6USVTH5MT77mpFhV/J4j5ZqkkJ9BUSlB4+
 03UFVBlcfFNqlDZ0pQscweIMC2nqUo60Qm3kfDF3ueGRoCjZDhI1fvi94K3VZY4N9I9l
 f062iNQNP+0RBi5lBKoJ+qnd3g/cf2sZeHBYqGIQ3I6DJmdQJlWUUpQDGBykdJSld8qH
 3ZwwjXSaIYJ8j8CCcVEqX2HvxACfoKNDe/2nQwkUEX3DLOhPrubylDuUoJT4TmOzerY3
 5InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574302; x=1710179102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=acOFmEUnV+QRtxHwUJiU99pAOXyTaQ4NfXNDVXS1ZV0=;
 b=As2/dJ3kNh4f9tsJvTJnt4uML68GSwBm6lft8+HXVLUGvsy+GYq2kuf2caNmqJIoPP
 NxErDl6lN93guW1qx/Wl+9MsGtLn8V65No1RfnaBAmNMmERHIcuyyYLuXTro1tRTTS17
 vutLzQ6WD1GvNWc9F5RSJhPySVrvsk3rcWhGayZgCbJAT1kM3sM59EljcUT8YTi9V9Kx
 PLG2Cf3qjj0y6VK6ac/ftmwipKMy8BPQyIdrYuecr+MrlcfF1R/QMmHyEsFgytxmW/7U
 orAP07Yc3hbNyCg6M4LFiKE/G5T+Uas/PNl6aQSKlmq/kZEH5z01Qi7v+9wzb04JOvQq
 9kQQ==
X-Gm-Message-State: AOJu0YwM+/dKmR8NxztAhO3nztp+gPttExkf7XE4GXr6rJ5FW18LYzCs
 3nSJktrZ3IR2KUmWkXsxKCeQZ/NRUqEO2M54Kba2W4crpaJAGw6FCx0tPq6E5AM=
X-Google-Smtp-Source: AGHT+IFlLar7U3Cqxynu2XHdow+TLf3U4mRv6dfV/J6A24Z6yOZZVHeWdnnCy3xR+dal1VsnxqB3hg==
X-Received: by 2002:a05:600c:34c9:b0:412:db0e:238b with SMTP id
 d9-20020a05600c34c900b00412db0e238bmr4465485wmq.0.1709574302143; 
 Mon, 04 Mar 2024 09:45:02 -0800 (PST)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c45d000b00412b67388f0sm17579099wmo.6.2024.03.04.09.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:45:01 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/6] TEE: minor cleanup
Date: Mon,  4 Mar 2024 18:44:48 +0100
Message-Id: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
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

- Address some spelling errors and typos
- Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
- Remove common.h inclusion for drivers/tee
- Add calls for closing tee session after every read/write operation.

CI build:
[1] https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=28&view=results

Changes in v3:
- Added calls for closing tee session after every read/write operation

Changes in v2:
- Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
- Applied R-b and T-b tags

Igor Opaniuk (6):
  tee: optee: fix description in Kconfig
  tee: sandbox: fix spelling errors
  cmd: optee_rpmb: close tee session
  cmd: optee_rpmb: build cmd for sandbox
  test: py: add optee_rpmb tests
  tee: remove common.h inclusion

 cmd/Kconfig                        |  4 +++-
 cmd/optee_rpmb.c                   | 23 +++++++++++++++++------
 drivers/tee/broadcom/chimp_optee.c |  3 ++-
 drivers/tee/optee/Kconfig          |  2 +-
 drivers/tee/optee/core.c           |  1 -
 drivers/tee/optee/i2c.c            |  1 -
 drivers/tee/optee/rpmb.c           |  1 -
 drivers/tee/optee/supplicant.c     |  2 +-
 drivers/tee/sandbox.c              | 10 +++++-----
 drivers/tee/tee-uclass.c           |  1 -
 test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
 11 files changed, 49 insertions(+), 19 deletions(-)
 create mode 100644 test/py/tests/test_optee_rpmb.py

-- 
2.34.1

