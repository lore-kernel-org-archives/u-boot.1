Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1D5C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32B188388;
	Mon, 27 May 2024 19:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ferObjby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4958B87DAB; Mon, 27 May 2024 19:17:55 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EAD287EAC
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-a630ff4ac84so1503666b.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716830272; x=1717435072; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rXgJduAO6B9GRy0eIC0PUY5heOO8mXxOdSeqHTkPBvw=;
 b=ferObjbyD6uq3b1pB7GcqapdXygStxva8HAtD0IG/P6reFyLsy7tu3UB354RDPfcQL
 fC4YGpzvHs6DiBJAb8ui7DhhbGdKiOXssct3W4eDDiPPK2UdMwRR+hbOs5j4AU909toj
 cCAFuD9Tn7Dang2BQpBHzaoSwwkAcAby9ZZhSDdbpv74MDGnCwNBJ+68KhtYtSy8Y4XD
 /AmGKCIyKoK/BfwYHSGFJgQWKBMpMuHrQpM409gRAh9ZD1pxLMDRj5Hyb51qzsnvggti
 RWf16O4JMMgp1qU8QHm96JeuQajWzg+eE7sBz7ckX8Ekc2Gy5XqasHnuFVisFlHX+fr5
 yj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716830272; x=1717435072;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rXgJduAO6B9GRy0eIC0PUY5heOO8mXxOdSeqHTkPBvw=;
 b=dodqJC0tTylY4ZLrAt2GkRKpoTsTTnFRqJF12+AsLPlzAf70ZyeWbC2Jys0tUHD56A
 6TribqIvung2LRmcx7+vAxmga6EntBM7dQaCjti+MNYb631jQb56OPOjDPAP/0p/QiG0
 YHzLxSFU6v2H1h6pIXOUmnfEj4hNMKyu2bUkVQSGQgoUocMatLrU+WQIX57KT/4zIjMR
 IDCFBrIaUQkDH5lXjnJt5T/smwEhSHFHs9yhtEDny2KTv/RgDMvIx2OASg5tZZQqiAoj
 e+S+6GOxx2BSO6NEWAVT082gBD5Me9YVcKjd9qt+dJRO/BXpxVYsWnx5nyYRrYOyfZyu
 7mLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUILwAGc4aD2xfdNvtO+5tSLpOP30M9kfv7DpX3bDj5X+VyD83gietsEMTGjoElvrC1WGxmKEIxMlQ0kKhn3EmuinOoKQ==
X-Gm-Message-State: AOJu0Yz5KqFdgg06mcJds1esjOSy1iodT2Qnx+Uuc+f1/WuYqVg4mTG6
 muI6CVC8yiMCDGcRlTo4gz7yaXmWm/RP+k9fBZCCE42kq8PUAUuloENycYn7xeE=
X-Google-Smtp-Source: AGHT+IHGhTWw60jKulechwIb7k9r7lub1+v84a2MOW6jlNQlFALXCddzMxaZqtdfFcYNiKobwrRgmQ==
X-Received: by 2002:a17:906:7f84:b0:a59:cd46:fe89 with SMTP id
 a640c23a62f3a-a6264f15e40mr661987066b.59.1716830271631; 
 Mon, 27 May 2024 10:17:51 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b874sm509469266b.163.2024.05.27.10.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:17:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/8] qcom: implement capsule updates
Date: Mon, 27 May 2024 19:17:48 +0200
Message-Id: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADzAVGYC/yWNyw6CMBBFf4V07Zi2VHys/A/DopYpTIK0doBoC
 P9uweU5yT13EYyJkMWtWETCmZjCkEEfCuE6O7QI1GQWWmojT7qEp4G3Cy9wNvLUI0yxsSMyoNV
 o/MVL76XI65jQ02cvP+rMHfEY0nc/mtVm/00jr1uz8ROwY4JZgYQSlTHKVrI8V/eeBpvCMaRW1
 Ou6/gDQzaliswAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=15xKCBg4uEA+d8ked3P5AbMAWWXJixm7o8aecyw80wo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVMA9T5d1GX5Kp/v2ea1c1L/gljgP7gkrcIzZx
 tZH9IPN5NCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlTAPQAKCRAFgzErGV9k
 tlKHD/wM4IsgJu4mpHkz+sqf9P0wUs+uh7JFOPd3Ux3cL/+SBADu5QHIh8fJjJu6hrTNqF36rHv
 auMxJ4F/mtwGT4Ryw9tr5EBDVQejKiCp3+JtT6KkhrN92z9yMcRjsQP1MRVMxnVUTKRdfJZZeBb
 QfywzdcwIP1Z4T5k4FJMF+fbPdCdu1LXk6wrU9xLU0vzXKiKcmmsU55YEFlmmgjdMPLYoh6DQXm
 YovNeJO2lf8HrJM+NlnnUiWmbI6Z2fMVjjx4hPJOE0vAD1V9zbLxOKh6ILqxZ5mygkw3rseo72g
 J7lj+ULboInvg/qT5Nj8GRpwfHQEyDugAyq3YzWpOLzqX2+ysouGOCdJ1mrRvRCDZy3Fzs198I9
 I7d0/QDftulKDQsHK7ncrJHw7uUg9OZIZ1iRv29dyco+GD1yRm38Ff3mNHJ61PhaO+mdTE8Jezy
 GnunPUQdlm8XbXz1oHXgORi8PvQ6Jn3LYUXVdUKOBMw8unpmIgGYdnUrxkTEfIG//tGMOGHb4HF
 R+8LGVKkK9TrCB+7ELn23T/JqUtlTkRRVT1dAJXYx0fXNYQWBDeTRmY/er66vG7S1AuJlBXAzmX
 BdIiTf1nNO8ZsA5onN9MMtNX06vgf02H2aum9IuDHhddGF0PdGla79wLlV2LKkxcY4QzexhMaI+
 HN4JO5gfPd3H/XA==
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
 configs/qcom_defconfig                    |  18 +-
 disk/part_efi.c                           |   1 +
 doc/usage/dfu.rst                         |  31 +++
 drivers/dfu/Kconfig                       |   7 +
 drivers/dfu/Makefile                      |   1 +
 drivers/dfu/dfu.c                         |   5 +-
 drivers/dfu/dfu_scsi.c                    | 437 ++++++++++++++++++++++++++++++
 drivers/mmc/msm_sdhci.c                   |   7 +
 include/configs/qcom.h                    |   5 +
 include/dfu.h                             |  26 ++
 include/part.h                            |   1 +
 17 files changed, 695 insertions(+), 11 deletions(-)
---
change-id: 20240523-b4-qcom-capsule-updates-ea2e4f8f0ff0
base-commit: 0b283a047ca00275ec515302b67676ba29f2b954

// Caleb (they/them)

