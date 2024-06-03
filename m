Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF1FC25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35E8882F9;
	Mon,  3 Jun 2024 14:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dp1dgdpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA64882F6; Mon,  3 Jun 2024 14:49:22 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C360987FC1
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-57a4d7ba501so1984444a12.2
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418959; x=1718023759; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xi4KqcKUzHSBeGu8h5eKCPa9zjQDldEDM593qTyD6Ek=;
 b=dp1dgdpNHM/KgvmkdZIL7X6t6wiT42ndjeyZyrfiqyEJWvCBhy/Wh83ZcckwoDx/l5
 SHJ30AZUwf4/baJU+V3PoCxwWpug6wNzQ1MzCW9wzuRVBzbR9LzPIYq5cjkHxZqIkU4i
 ZNxCucMwKHNEfWm0sI30kTMrtAANAC3kztUMD70LCU/JsqE8xq4JQeaMSq8xcju0qhhz
 tnCHTzkQhkAbrotoo4Tpgy+zkbTW/LA7V40w04GR9eSHIPMbOxc16//w8ttyRD1Ovajb
 bk3wLwJLhKOEeDn9z2MAmnKDmd1QAtR9yX0o/vC6Ndpft1zMWaTp85sHztF9SJ35O2hI
 BE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418959; x=1718023759;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xi4KqcKUzHSBeGu8h5eKCPa9zjQDldEDM593qTyD6Ek=;
 b=MM9PSuWn92BEcRNM8T3UGyCW9obkvJCpS5ydh/eBUBnklBJIjLMqXKTyWkfX29upUB
 hPFuAaq8TN8rpqx+ty+DZUjpfOsgWqvf7yrXeqGAz49/zw003JsGZfG0sik8tMnq4EMw
 mztHtV1LZKUrZiYWhWOW0ZqVTJR0fmEROEhptOeLghfeYxQcmvnbvpOH7/MCedRlWV63
 Fn8sgB+9cf6GdP6nvmbOl2N2l7+qjopRBxbTELUQn957bsm/GvHAV2qQKeONKFuERr+k
 h5iLgY71AqWZ1EyoTtJY4wsWDIX8YwJtau2EvY3OcOo0VnzdZgImxVop2jOVvSKOo8w0
 VoLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeBcifBBcCtnYB+2wKaVmi8w89lOfP+dkajwsn7k7KrXfPc7OnAhtp8UPmV3QpTYYOqADgK+qqBv/sNr73TsEG4jzQsg==
X-Gm-Message-State: AOJu0YyufsmiJSDn22SYw0aCeus6l3aTNppjLxQQ/Qu+cG07yQ1Y2vL1
 gQT7Ko6Weh8zahrwzRHY/YzN8MfwVeIOpKg1lcQXCZETnib5GWWBiw/TO/eLSbE=
X-Google-Smtp-Source: AGHT+IE5I3yfdkrBYBoz+Y+BdtXU6cOcI1aoUE14osxgG+WNmGeCxsIxlhX8CQvmkM6bWsgcZAfc3w==
X-Received: by 2002:a17:906:a293:b0:a68:e58b:2c35 with SMTP id
 a640c23a62f3a-a68e58b2c64mr302223266b.31.1717418959211; 
 Mon, 03 Jun 2024 05:49:19 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691cd07c72sm98917066b.170.2024.06.03.05.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:49:18 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/8] qcom: implement capsule updates
Date: Mon, 03 Jun 2024 14:49:15 +0200
Message-Id: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMu7XWYC/3XOQQ7CIBAF0KsY1o6hQEt15T2MC4ShJamlQks0T
 e8urQvjwuWf5L8/M4kYHEZy2s0kYHLR+T4Hvt8R3aq+QXAmZ8IoE7RkHG4CHtrfQashTh3CNBg
 1YgRUDIWtLbWWktweAlr33OTLNefWxdGH1zaUivX6MQU9rqaxE0QdHaQCKHAshChURbmszp3rV
 fAHHxqyQol9yyWTfx9KLENCljU3UhnB6h9oWZY3YgXsxPwAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3206;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dt7NHoCeoL30HWFoQisJqeIe1xYA8I+1N539lyAavh4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmXbvMQE4sBmlW8vxNBJT4kcQ9ny+2qdrFUlMbw
 Vcd0HhvIRKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZl27zAAKCRAFgzErGV9k
 tq0kEACLpT0yXRGcgE0hgPzwPMADzZtzYGW/Dqhh5pru6ZSO4nmhxv9wfM61VPGJP1LgPRl451l
 15ob9QAECHwmvx8DXU5p+hm6p82Zz7/exnTmKC8cgkcSp6whygU/BUiFugzr6OralZVIC6JTSS7
 MCRTAzbSCfHKNzUMQjGGhryM0W8STYqW7TMQ7o5TDXg8hOn9Ui8W/0rNkpeMf/NnnK8yUHHSkno
 +OYly4p89VHdZNXUMBnSmr4rZUC4gw3MjwQK82TJEXtiSKCILfgYE7t/OYRs+PA0kWs1697AVma
 gkjTa8Mgu6vvnTqnI5WF2P3cuN54/XiMcioZ8L8jMXru/vTmyF721WJVDPiLbnK4cH7YkhkXSDq
 afi5WE2K8AF4ax6E0FEoDJPzLE4aiJ07bC8NQHrY1IFZcrU+ipG8+0LlCDj4SmqWdzR0/9CRNcx
 qJv8yhewtTwUo31gsfOp6v35Tw7LIzelLFKDC9bnn0oskow27XxAIeO9CKPEv9MUnRhXsnJ2h8G
 rIFJwHK3/bpVyWtiJWkQtswEfhUl4W3yrem3JQLzN2eL3pa6XkfT6hIgq2ZscBLthJvP9Ur5x2h
 FxRNNctsW7jz7m23FXd0UfH3qn6HPPPLngEW/tJSRzkgmCa5+PXTaePm0+tJX4eCsbNSGvy3wYR
 Jkzrq2xlLm0jH9g==
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

Hook up support for capsule updates loaded from disk on Qualcomm
platforms.

Most Qualcomm devices have an A/B partition layout, with most partitions
duplicated. The metadata on which slot is active is stored in the GPT
headers in the vendor-specific attribute bits of each partition.

Add support for reading this attributes via the disk_partition struct
and using them to determine which boot partition U-Boot is flashed to
and generate the appropriate DFU string.

This logic is gated behind a check to ensure that U-Boot is actually
being chainloaded and not run via some other mechanism.

SCSI support for most Qualcomm platforms is not yet enabled upstream,
but will follow in future patches.

This series enables capsule updates on the RB2, however [1] is required
for it to work properly (as otherwise MMC won't be available).

[1]: https://lore.kernel.org/u-boot/20240527-b4-clk-stub-v2-0-29013855e343@linaro.org/

To: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
To: Lukasz Majewski <lukma@denx.de>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io

Changes in v3:
- Address comments in scsi dfu support
- enable CONFIG_DFU_SCSI for qcom
- Link to v2: https://lore.kernel.org/r/20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org

Changes in v2:
- Add qcom capsule update support patches
- Link to v1: https://lore.kernel.org/r/20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org

---
Caleb Connolly (8):
      dfu: add scsi backend
      disk: expose partition type flags
      mmc: msm_sdhci: work around a bug when writing
      mach-snapdragon: implement capsule update support
      qcom_defconfig: savedefconfig
      mach-snapdragon: use SYSRESET_PSCI
      mach-snapdragon: bump up heap size
      qcom_defconfig: enable capsule update support

 arch/arm/Kconfig                          |   2 +
 arch/arm/mach-snapdragon/Kconfig          |   3 +
 arch/arm/mach-snapdragon/Makefile         |   1 +
 arch/arm/mach-snapdragon/board.c          |   8 +-
 arch/arm/mach-snapdragon/capsule_update.c | 147 ++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h      |   6 +
 configs/qcom_defconfig                    |  19 +-
 disk/part_efi.c                           |   1 +
 doc/usage/dfu.rst                         |  32 +++
 drivers/dfu/Kconfig                       |   7 +
 drivers/dfu/Makefile                      |   1 +
 drivers/dfu/dfu.c                         |   5 +-
 drivers/dfu/dfu_scsi.c                    | 435 ++++++++++++++++++++++++++++++
 drivers/mmc/msm_sdhci.c                   |   7 +
 include/configs/qcom.h                    |   5 +
 include/dfu.h                             |  26 ++
 include/part.h                            |   1 +
 17 files changed, 695 insertions(+), 11 deletions(-)
---
change-id: 20240523-b4-qcom-capsule-updates-ea2e4f8f0ff0
base-commit: 5d8881a0801241d68701e8644d495f1d535506f0

// Caleb (they/them)

