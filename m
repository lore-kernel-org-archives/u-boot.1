Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B49C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 14:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067F482E37;
	Mon, 14 Jul 2025 16:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xhYKLndF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1B682E52; Mon, 14 Jul 2025 16:21:36 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4ED82CFA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45600581226so22937825e9.1
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752502894; x=1753107694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xYZoGB3h1386rWN6BJBzA7GqCd7ey41EsS+Vv8DiVKo=;
 b=xhYKLndFPcJ40KkPEkT0UOazB6YgMCdoKVmWGndR/R7kFtJVx/ePRgJUoFoD9jQVhf
 xc95EEi8lKnwUTio8NVpGw/AvHSPCJhWZZyYxpdATZREhF32+1VbNBOLB8Xi2sQ32pf6
 7SU4ELcdMHT6RYH6qeUcATSmMkpG+kbGsak5rbZSrCtSzg8vknhBxSX79NZ4Nvt7xcmX
 IyOeNCGA2GLVQbtHnF2doLWqqnCUHia+ZRhrii+XQ6NxPR9gT2i6clydcvIWOAPuXXEn
 OWr61A+jfPkce4NRRvMWWVBuIN2kDeVYM8hqDiCy6/TuroEhBSw93x+xgEivZkmzSug4
 w1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752502894; x=1753107694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xYZoGB3h1386rWN6BJBzA7GqCd7ey41EsS+Vv8DiVKo=;
 b=P2+ZMS9IkcivnTuaDkfs8V0M8V0EYSN/R06jIm1cPFCkXMXZUX73CS65oRvQgMFpu0
 FbZilH2U9v/407o+aWURYDx3uOL/XLciz2dl9J6qqTlYkO8MblcYk7pYrupsZ/jHRevv
 3cBQo9TMxyyJd5OpBBf2xMBHZUOPt8JxpeKAdjLA9altBLdvN8HudQOM6MAHxDHHPdct
 N33yxL7eL4QoVL61CkXx/BplhPsAyoyYXXrvtE1736eQKAJYUfn1WRIXkhb2pvyhddDO
 nXf4YvYwV+XcDKhUoCUAVPrvMSVHxusFJ2NEkcRejACdaK3O6s2hwbVKTKWm3recnMQz
 vO+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnsz0oqdN1g/4dWJA0Rf2tQh4tfklccNrfGiSCn3G5axc/JKg4gHuMmdW8nfg19V0yH/xDgRE=@lists.denx.de
X-Gm-Message-State: AOJu0YwC/woR17n69HUEvnZSsAja8e7Z0qimbF8uEg/SxpnHOEx/hxBx
 utpRLIaG5cncofI3FlaYRRyoMOgqjiN+hcacFpKB5vGU6Hlwoc0DBPvfo35gxhQqlDM=
X-Gm-Gg: ASbGncuPq7nXUbbW55jxpfNUAmfdJD/VdgsOXY+cQGCt03O472ywxzVoYLo13NQi9Z1
 ligYn2YWqoTx7tv+X+VELAip8gZ1YY21AjY0I6kPWD70JrgqNl9X78guM978ihBa6vRLsia0vf2
 gSAO1UcNYeGUjQsv4xncU7elQGQPj0IOYGjGwKiY+3Dt7B3KOUZeLogp5aiAnt+XPAUccVwKJbe
 rkmnFS1zKyBFwPI5krl/tmpc23GY2SUrszqJfCg9PSueGFHYMbseq7WlLYEVl0RwI9mma/tsd7F
 yjf1yk3m79sxDAGwTlH769jRN5TFfmzFup0CMmH0kI4ITfv63uVsA/tFXs2IdWLtwKpxK3LMlnv
 bSkhPI97drjc6ikCvSnYcgpX0c7dQUu+U3cuVQUm1H78mx/IgVfqL1GCCX9menZjeaoGn/O/19B
 nGkoQu
X-Google-Smtp-Source: AGHT+IGja65g8LoyZ6m++A697vo2W0tl1VC1lc7WcccZXZiQxyM/Un8GsxPhpJlvYBOMQUywmYP0kA==
X-Received: by 2002:a05:600c:4445:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-454ec28306cmr118483325e9.27.1752502893846; 
 Mon, 14 Jul 2025 07:21:33 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e2710bsm12526472f8f.99.2025.07.14.07.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 07:21:33 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-main-20250714
Date: Mon, 14 Jul 2025 16:18:51 +0200
Message-ID: <20250714142121.3266304-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.50.0
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

Hi Tom,

A few fixes and additions for you:

* Fix unused access in ufetch
* Add missing clock for SM8650
* Port the Linux SPMI GPIO driver and port over SM8550 (other platforms should follow)

CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/27056

Kind regards,
// Casey (she/they)

The following changes since commit 344e1798059ba65769272be3145736685bb25a7e:

  lmb: add missing fallthrough in lmb_alloc_mem() (2025-07-09 10:39:37 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-main-20250714

for you to fetch changes up to 07ddbb89c9cc42a366807813dcb28fbd3e9d198b:

  clk: qcom: sm8650: add usb3 noc clk (2025-07-14 15:35:24 +0200)

----------------------------------------------------------------
Andrew Goodbody (1):
      cmd: ufetch: Initialise size before first use

Balaji Selvanathan (1):
      watchdog: qcom-wdt: Drop read check on write-only WDT_EN register

Casey Connolly (1):
      qcom_defconfig: enable USB mass storage gadget

Neil Armstrong (2):
      gpio: qcom: add new driver for SPMI gpios
      gpio: qcom: move pm8550 gpio to new driver

Rui Miguel Silva (1):
      clk: qcom: sm8650: add usb3 noc clk

 cmd/ufetch.c                    |    2 +-
 configs/qcom_defconfig          |    1 +
 drivers/clk/qcom/clock-sm8650.c |    1 +
 drivers/gpio/Makefile           |    2 +-
 drivers/gpio/qcom_pmic_gpio.c   |   20 +-
 drivers/gpio/qcom_spmi_gpio.c   | 1035 +++++++++++++++++++++++++++++++++++++++
 drivers/watchdog/qcom-wdt.c     |    5 +-
 7 files changed, 1041 insertions(+), 25 deletions(-)
 create mode 100644 drivers/gpio/qcom_spmi_gpio.c
