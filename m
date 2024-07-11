Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDC5C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 833C888387;
	Thu, 11 Jul 2024 18:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ErevcOG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4979F88381; Thu, 11 Jul 2024 18:46:45 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A3A87E50
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a77cc73d35fso392922566b.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716402; x=1721321202; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RwOyOx5y9VJgMEoGrmCvZjCxknxGZr27UwgtwLqUUzQ=;
 b=ErevcOG0huNIBqms5rjb4I2uTQIqj+ljIdOsVQpgdfhKSa4L8MXRoYGbTudxfCdTs+
 H6pAp6Citcgep7U1GqruhOS2zfp9dq6QUChkgKAigyzrdRvCw3QbvMMFFJGZ5jJO/72Z
 GjnBnNDxMrVx69clVAQebK5Bmyf9vjpb9tEbIIlxBA81uNfRR9QpD0QuMzAA9MApnf+Q
 HXGcy+s5j35biEiA8/WRsvxRAxnck2cMvG+hzpTNgpCwMlJTpI/bcbmFi2r8gYmtTdTZ
 XnWSKQxcyh7fLp7D4+Dtz9bOGjeErpADWhyC8US1lkiNQ5s5SmUlk5myGX39lIVqvxIz
 8LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716402; x=1721321202;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RwOyOx5y9VJgMEoGrmCvZjCxknxGZr27UwgtwLqUUzQ=;
 b=gcT+t9oVC5JmoEuGqMIdtaZyuTcdosmds+htNV+YAQ3IDEa0XgTaSfCDUFmUW396wB
 BBrCpRCABWkMDBHvrJc342Tasj2+u4etSkOmF8zO8veY2KXFNgZ9GqpzmkXN3kimUeqd
 a39TKN1OqUWKCmeWJz3bIYqZ4RABffgpZOxDzSPjQ/t6Xf4RLmWPLVX0s8yq90qxQRas
 ah8HhXy/ETBUmmafIV5/PteZTXpunuhE2NQ6Gfzmom87dcHmeHDputBHmo0gUVKbYEHs
 nimgGaY/nYUoPN67ZM/w6ZerhDn3n9axBJEk/HRA9Y5tChb2Cs4gAYI+uUQ8hwI7gOHn
 YzuQ==
X-Gm-Message-State: AOJu0YwhF6qQRig2RAcZfzfCG/svhXlytwvZLpNtEhmk5+s3ispYIxcK
 oyrzWIbJkALAIGA3pMrqzl4RkfaEF6mB47OlZ7QOrOpyyZBq6JrWWxrRKmF+834=
X-Google-Smtp-Source: AGHT+IFTEHbotOJciFApDXZYJO99z/s/dHc5+XJKh+8OhKL5LV5/dXVkS8E5Q3Aag8qTNX7RpEgXYw==
X-Received: by 2002:a17:907:846:b0:a77:f5fc:cb61 with SMTP id
 a640c23a62f3a-a799cd67784mr19773066b.0.1720716402142; 
 Thu, 11 Jul 2024 09:46:42 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v5 00/23] qcom: rpmh core and regulator support
Date: Thu, 11 Jul 2024 18:46:32 +0200
Message-Id: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGgMkGYC/33OTQ6CMBCG4auYrq0ZpmUAV97DuChDkSZKsRiiI
 dzdQmL8S1x+kzxvZhS9Dc72YrsaRbCD651v40jXK8GNaY9WuipugYAaKElkqeWF/VmG7tzImut
 KoWEsNIhIumBrd1ty+0PcjeuvPtyX+pDM12co+wwNiQRZVqgUFagsmN3JtSb4jQ9HMZcGfOkM8
 i+NUeclZ5QSkE3pR6t/Ws1aEzNxWmaY/2j9rosvraNmoAoMEmn9+fk0TQ/j/qehYwEAAA==
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5662;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=yLEOhuM2MNMJuJfbaPtIZmIqOuZDPOf9fH85jPZt7+U=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxtUj1Mxfl70vp6Lf2IP9Tqpd0rnq7cjKnoF
 GuNlKRMB9aJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbQAKCRAFgzErGV9k
 thaaD/wN7Xg0CinqgeEkpHf78x5ZBDElG0AKUMSslK1dwcshxCDD1UGGNwwW8/Qf0wE9tq7U1ld
 N6GIJeDrvgx0wL/8J5HHFjYjca3/WSTcU22yBSG6lODNKtQmQzZU8x3SLjW3ooZPOtTARPodb39
 O2WNt2XcXXQIl+yev/yexH6pkUjOl+omyHg84lhwijKrpt4/B2rPZ94lXgw29vVV/LgntgeHg54
 NMlOMhUa95gu/PER8vsLOFQHlwCgPFXP1OYSH8C6cUyeUI57ERni/qxmQsD1w7ReGux4DbCnQAy
 l2FQ9LdDklCXeypZ0PWeWlqcs3LO9LaTgPVY7yvHmvRRKUaGYf75YT0kISP6nCrbEUzPYhRBAsv
 H9j962UIqLKVfCvbUlOYW2ZfA/fqHLecliXgIA+9ZImtXugoxznjfoGdbyshXG0ot7Xiv/RGOLp
 LUvj0HLnCISTcxLbj7Ir6CaNVkJUa57UiPOlokcklZhUYk71P+Fh5lMUOu5OnUx5vwWSvjWwIOM
 JLnv4nZO6ZC5wR8TEu3/t2Cfb7B7DIw+hcCSD6wiwIO8pf5kEocfAmg6TIC1e0A5E58SdkAjKUe
 xuDUH3OrPzK58oxvREHA7h03zydRN2nYCdyOFRgukKKDHkVz4EwpGG/ycmhimh1bNtz+4ivVnL7
 L4fLp6kaZomI/jQ==
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
Changes in v5:
- Add Kconfig / Makefiles after introducing drivers to avoid breaking
  compilation when bisecting (Thanks Neil).
- Link to v4: https://lore.kernel.org/r/20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org

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
Caleb Connolly (23):
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
      soc: qcom: add build infrastructure
      power: regulator: import qcom-rpmh-regulator from Linux
      power: regulator: qcom-rpmh-regulator: adjust headers for U-Boot
      power: regulator: qcom-rpmh-regulator: port over lineage_range helpers
      power: regulator: qcom-rpmh-regulator: adjust structs for U-Boot
      power: regulator: qcom-rpmh-regulator: remove unused regulators
      power: regulator: qcom-rpmh-regulator: port ops to U-Boot
      power: regulator: qcom-rpmh-regulator: adjust probe for U-Boot
      power: regulator: qcom-rpmh-regulator: add build infra
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
base-commit: 834df20b4ef50cda26936fbc435689fa0c5d47b1

// Caleb (they/them)

