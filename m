Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055BBC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A894885A5;
	Tue,  9 Jul 2024 11:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EmD++bx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665ED88599; Tue,  9 Jul 2024 11:34:49 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6E187EBD
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77c080b521so542140366b.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517686; x=1721122486; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eAlyGTFWRDqkzIDAjuDOHU+l78bZFQKZP+tZTlJK+C4=;
 b=EmD++bx9bCvfa9ZlNkHr5BuCS8pRydklVxflzkmQXTVBAvx96k3ZyxqUMs1ORLB1o0
 KhEgcKdbTYXIPWu+qI4+DiQYXzyo5KcfYmRKTlYPI+CM4BXlt7VcglcnCFZS47pwP8YS
 3chpaesR4sirP4dAg9s4xOGq0utCaqhexhdYJ/yJgPZ4n4XaDfaIrbg9rFX3QRPNSfCi
 BK+HNLTawST2+4H8zbf6lGwX/vNS2ZC7EHOK995V188KtE31g8KE1Zm9QrgBNySe6MSD
 d96mKMBK3rL4i3Em2CSwA7xiIUQXRy+ET04hpBL5xBVfnFV/YAdGLbWyLIybEv+pCWvw
 y8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517686; x=1721122486;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eAlyGTFWRDqkzIDAjuDOHU+l78bZFQKZP+tZTlJK+C4=;
 b=ljNf6Y0GrlbU2zc65v4fVsO96yswukTQEG4PtlkzjGRoc5olpzAXb76E0VupZGFriI
 kFEDqDtWjTy3P1UkY82XMVHc9S6fA2QWUhFjJ8vZmXGrsQnf/Cne3mVJDayD4K6ZYmCz
 gKCNtjAnzpy4GMvLOf4n9MoY3WXNY8XzQTi4odI1lHBdfRkSVDkZedGXwj9qW20cqmCA
 wgYu6IFxNtpEeALUA08aF/u22uJurwhcKD0QrFQW/1Q1q1K7yrVCS7f1Oxx/ineDqsII
 R06saOnnaT7tIxq/FiPFYkD+LnqpmRh8y1gIqkYu/NWYkHfSueS/RW2rkCYlaK5xRF5d
 W0hQ==
X-Gm-Message-State: AOJu0YwWoG4lRndQX392mg15N4E1XBGF7bfViTZSzw4Lob49PxRRrZCo
 PVSZxg2y2jbBpBVxuvcO+az2Rq537BL/GMhojunUtRtBt7qbjwy10fkRrxg0z0w=
X-Google-Smtp-Source: AGHT+IFV5QE61DqBYP5uN0asHXPzxq85uIR3/eJAbt00gQ3VdCKk1xambJ3GXqwkdymGHHYCRaL3hw==
X-Received: by 2002:a17:906:b319:b0:a72:676a:7d7b with SMTP id
 a640c23a62f3a-a780b688906mr152375766b.9.1720517686306; 
 Tue, 09 Jul 2024 02:34:46 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 00/21] qcom: rpmh core and regulator support
Date: Tue, 09 Jul 2024 11:34:28 +0200
Message-Id: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQEjWYC/33M0QrCIBiG4VsJjzP01+nWUfcRHahzm9Dm0pBi7
 N5zg4gVdPh98LwTijY4G9FxN6Fgk4vOD3nw/Q6ZTg2txa7OGwEBTgSlWHN8M77HYew73JimZqA
 MVJygTMZgG/dYc+dL3p2Ldx+eaz3R5X2H5DaUKCZY18CYqIBZok5XN6jgDz60aCkl+GhJyi8NW
 ZfaSFEIImwhfjT7p9miuTBGmEJLKDd6nucXdAouWiUBAAA=
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5289;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Kpynd7jxHLUZ7TorJzw928y/GJRG3l17oUhZw5WTk7c=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQyikXWxh+uWl7RTaVk0ZS+b9aN6aqFco4p9
 +ncEIoUd0aJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMgAKCRAFgzErGV9k
 tm0rD/9AZIv2io5i8s3CWsU0qsUOPtI2Sc+e1mNsdeNFigUaxc6wcn6Xi66I1d13MNcMcvB8ve9
 QB0jG6knXfoKqt472PerrufPlFunZo5AOGysREcyMdqbsxvfbsSHfsINVPDZCLlclTpbzTnC26k
 g0QbJo8BYEwhWQWiC5UHdOc5FFX0xVxDUw5H5c6eZQhjj0Lht6M9PzaDAqZLv/asHLIdi0/gE+z
 GCUFn388WvGafjcscA1JB+ZO06AJnx+pUL2FE2kCjUO/a8xTe8a7vsSZ55Lq0JATiRhUUty0uG9
 nljHN9xhf+5OKBAfWacYikk3IyMDaJ+Jhx0Bummcjcgsrwm3ewQT7GxirD6ns7OYood6KLeQbaG
 zKU8D9JnxlrofCZn07jET/+mVU2O3G4wwDyBYxtO06DQLErrCbwgkdV7MwgMxZEnlgNgTBdlGH8
 tMPlUVesNv/ht5Uc6AiJ6WoUJgzEcBJLKE6Wn5LQAmhegjc8aaYqGy8sFn4qJueJEGr/m9H15Tk
 kQbLa7DuEuscyZ8AaoEuBEf+J2TMBlFqrL8UXyU0E0sShlWGPLl0cVpf8Av9AwRMNlwTC9CmoUe
 qZ7I4Iauc8BgGwN0svpoEerdbyJg/ayWTDofbuZ+8rXT2DczVNUX1OMpRbET/BCsWvug7uz7jeR
 7Z7iA0TUSGCBhbg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This series introduces support for the RPMh (Resource Power Manager
(hardened)) co-processor and associated regulator driver found on most
modern Qualcomm platforms (since ~2017).

Even though most regulators are controlled via SPMI, the specific
regions on the PMICs for controlling the regulators are restricted and
can't be accessed by the Applications Processor (AP/HLOS). Instead,
these resources are proxied via the RPMh where they can be voted on by
multiple subsystems (Linux, the modem, and the other DSPs). This is done
for security (to protect clocks, power domains, and regulators that are
specifically relevant for the trustzone) as well as to simplify the
management of shared peripherals and to allow for handover of
peripherals like the USB controller.

For U-Boot, our main concern is the regulators. Since all regulators on
the system are controlled via the RPMh, it is necessary to support it to
enable USB VBUS on some platforms, and may be needed for other
peripherals in the future.

Communicating with the RPMh additional requires accessing the cmd-db
shared memory region, this contains key/value maps to determine the
address of specific resources on the RPMh.

Introduce support for the cmd-db, the RPMh framework, and some of the
regulators that are necessary to enable USB VBUS on the RB5 development
board.

These drivers are taken from Linux, then modified and simplified for
U-Boot. The original Linux drivers contain heavy optimisations related
to multithreading and asynchronous probing, as well as support for idle
and suspend states which we don't need to deal with here. This unused
code is removed before finally adjusting the drivers to properly build
for U-Boot and use its device model.

The U-Boot version of the driver supports a single ACTIVE_ONLY TCS and
waits for it to be cleared after use. We don't support programming
low power states.

---
Changes in v4:
- Denote original Linux version in bitmap.h patch
- Rebased on Linux 6.10-rc6 and re-apply U-Boot changes preserving git
  history. Allowing for future changes to the Linux drivers to be ported
  over more easily.
- Add missing check to wait for the TCS to be cleared after use (seems
  we were just racing the RPMh before, oops!).
- Fix missing n_modes in pmic5_pldo regulator.
- Link to v3: https://lore.kernel.org/r/20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org

Changes in v3:
- Don't call dm_scan_fdt_dev(), since DM core will scan.
- Link to v2: https://lore.kernel.org/r/20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org

Changes in v2:
- Implement Neil's suggestions and fixes for SM8[56]50
- Slightly refactor cmd_db_init() for better abstraction.
- Improve logging (printf -> log_err/dev_err)
- Add missing error check in rpmh_regulators_bind()
- Link to v1: https://lore.kernel.org/r/20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org

---
Caleb Connolly (21):
      linux/bitmap.h: add bitmap_empty helper
      soc: qcom: import rpmh and cmd-db drivers from Linux
      soc: qcom: cmd-db: adjust headers for U-Boot
      soc: qcom: cmd-db: drop unused functions
      soc: qcom: cmd-db: replace cmd_db_ready() with cmd_db_init()
      soc: qcom: cmd-db: adjust for U-Boot API
      soc: qcom: rpmh-rsc: drop unused multi-threading and non-active TCS support
      soc: qcom: rpmh-rsc: adjust headers for U-Boot
      soc: qcom: rpmh-rsc: adjust probe for U-Boot
      soc: qcom: rpmh-rsc: remaining U-Boot API changes
      soc: qcom: rpmh: adjust headers for U-Boot
      soc: qcom: rpmh: drop unused functions
      soc: qcom: rpmh: U-Boot API changes
      power: regulator: import qcom-rpmh-regulator from Linux
      power: regulator: adjust headers for U-Boot
      power: regulator: qcom-rpmh-regulator: port over lineage_range helpers
      power: regulator: adjust structs for U-Boot
      power: regulator: qcom-rpmh-regulator: remove unused regulators
      power: regulator: qcom-rpmh-regulator: port ops to U-Boot
      power: regulator: qcom-rpmh-regulator: adjust probe for U-Boot
      qcom_defconfig: enable rpmh regulators

 configs/qcom_defconfig                        |   5 +
 drivers/power/regulator/Kconfig               |   8 +
 drivers/power/regulator/Makefile              |   1 +
 drivers/power/regulator/qcom-rpmh-regulator.c | 544 ++++++++++++++++++++++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/qcom/Kconfig                      |  27 ++
 drivers/soc/qcom/Makefile                     |   4 +
 drivers/soc/qcom/cmd-db.c                     | 213 ++++++++++
 drivers/soc/qcom/rpmh-internal.h              | 138 +++++++
 drivers/soc/qcom/rpmh-rsc.c                   | 518 ++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c                       | 110 ++++++
 include/linux/bitmap.h                        |   8 +
 include/soc/qcom/cmd-db.h                     |  33 ++
 include/soc/qcom/rpmh.h                       |  28 ++
 include/soc/qcom/tcs.h                        |  81 ++++
 16 files changed, 1720 insertions(+)
---
change-id: 20240611-b4-qcom-rpmh-fcfd32ac2940
base-commit: 50adc932e7aa34e6d9c738ec13ed09382a9d109a

// Caleb (they/them)

