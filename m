Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B4BCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 13:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AAB5881D4;
	Thu,  4 Apr 2024 15:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hwc8fwyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C62C88277; Thu,  4 Apr 2024 15:20:03 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59864880D6
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 15:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-516ced2f94cso126122e87.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712236800; x=1712841600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dADwiM3ic/3Z4cAx9H6t0hvdo3CAj4ywQvbPV6f4hvk=;
 b=Hwc8fwyV+TrEUbVI0U+7gu82r+aRaEfsndq7Xap6nGb21EhzspQKQz/8FcB4qYwG5S
 /LR/658S+vN42UR88j9UB1ksKtO6Pvvta09ZnjNvIoj9HCOlYCLUwrQxBRy4FmTprSZ1
 +dipRM41FCoMMCj953HPxjBOfkN8wZzFzjvQXG52Gy3irPo4GrMKA6qKr03FI8YjRcGT
 +CiwQgnuEx70jpNevrcgawPZ0OfUKjCcTbGFdQn3SaY6Na8DUrjhZvtVpyBEy24WKB5m
 hch+wLUsYL0HyQ6IqkE9GVRcdguYYZKNvOUiH+GvfX04cnQ/qiXvyyg5Q2yh7NkontGj
 X3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712236800; x=1712841600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dADwiM3ic/3Z4cAx9H6t0hvdo3CAj4ywQvbPV6f4hvk=;
 b=Ll9kG+LZoHMDmd4b7TLdD6pPHUNnY+AsCALtzhYzK7ZdvRI1AUlLC6tubZbfnr8EL/
 Jfgw2q2TGqcXlSDvHjKJWOe10xm1ihn/c7XVwGGpYNLWFh6tjEvA/xl0lJOMtrnJVbyM
 lY+ysg0yOwshx8EXQe3EeTHVMFt1/cdUTD/Zl4nvy1egk0v/jOxD4ki7qnIK1MxfIdWb
 holE+p/XxPICpm9lI8szLeiqtY24ZpUgQgs8evPN5g2eCTQgcOGeVMmz0/3CWJk0k9Fa
 WFqHztVuZj5TSkaD4UWGRul8oxIXZKRlrx1rgSwwkscNc7mCLkCNiE7P1tuNaUVmadiD
 zCrA==
X-Gm-Message-State: AOJu0Yz4juM9oMKjQNi405bhBI8g8zG2Vy+2DWUi6hd40J5WPSai6uUU
 e0r2kZVsVpk6A8X2lUyYtQsCkxOOWZ5Yajd+ahKgEz+WQfxbqngjPdTEi0F1oF1kGQ==
X-Google-Smtp-Source: AGHT+IHln4yyR4D5opxLAR/J+/Mjsg4ywmdVwyQIWHqa/aLMvAmrpiq6IKiKbnxLtbisvnDISGPvOg==
X-Received: by 2002:a05:6512:3499:b0:516:ce29:f373 with SMTP id
 v25-20020a056512349900b00516ce29f373mr1029993lfr.3.1712236799303; 
 Thu, 04 Apr 2024 06:19:59 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 d1-20020ac24c81000000b00514b449963bsm598578lfl.287.2024.04.04.06.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 06:19:57 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, jens.wiklander@linaro.org,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 0/5] TEE: minor cleanup
Date: Thu,  4 Apr 2024 15:19:46 +0200
Message-Id: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
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
[1] https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=33&view=results

Changes in v5:
- Extended commit message for "cmd: optee_rpmb: close tee session"
- Added R-b tag

Changes in v4:
- Rebased on the latest master and excluded "tee: sandbox: fix spelling errors",
  as it was merged already by Heinrich Schuchardt

Changes in v3:
- Added calls for closing tee session after every read/write operation

Changes in v2:
- Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
- Applied R-b and T-b tags

Igor Opaniuk (5):
  tee: optee: fix description in Kconfig
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
 drivers/tee/sandbox.c              |  2 +-
 drivers/tee/tee-uclass.c           |  1 -
 test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
 11 files changed, 45 insertions(+), 15 deletions(-)
 create mode 100644 test/py/tests/test_optee_rpmb.py

-- 
2.34.1

