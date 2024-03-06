Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A69BC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4019879A0;
	Wed,  6 Mar 2024 14:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9CF987E18; Wed,  6 Mar 2024 14:40:05 +0100 (CET)
Received: from esa1.ltts.com (unknown [118.185.121.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B719686BFA
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: /kw/PGdEkW6fTN9/PbnzLMhik9zjESkWxwoIH8APCQ87VH7tafngkhk4p186Q+dHbgGl5XmeSe
 SPsrPu/jyj1g==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa1.ltts.com with ESMTP; 06 Mar 2024 19:10:00 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: jh80.chung@samsung.com, sjg@chromium.org, bhargav.r@ltts.com,
 m.nirmaladevi@ltts.com, trini@konsulko.com, d-gole@ti.com,
 dan.carpenter@linaro.org
Subject: [PATCH v2 0/5] Add support for TI TPS65224 PMIC
Date: Wed,  6 Mar 2024 19:09:42 +0530
Message-Id: <20240306133947.160354-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
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

TPS65224 is a Power Management IC which provides regulators and others
features like GPIOs, RTC, watchdog, ADC, ESMs (Error Signal Monitor),
and PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC
can communicate through the I2C.

Data Sheet for TPS65224: https://www.ti.com/product/TPS65224-Q1

Reusing the TPS65941 PMIC driver to add support for TPS65224 PMIC 
in U-boot. This includes driver for PMIC and regulator.

The driver was tested on Ti's custom AM62P EVM using U-boot's
pmic list, regulator list, regulator status and regulator value commands.
Since, support for Ti's AM62P is absent in u-boot next, the patches
were applied on ti-u-boot ti-u-boot-2023.04-next and tested.

Changelog v1 -> v2:
- use __maybe_unused attrinute istead of commenting variable name in
  function params.
- refactoring tps65224_ldo_val2volt function

Bhargav Raviprakash (5):
  power: tps65941: Add macros of TPS65224 PMIC
  power: pmic: tps65941: Add TI TPS65224 PMIC
  power: regulator: tps65941: Added macros for BUCK ID
  power: regulator: tps65941: use function callbacks for conversion ops
  power: regulator: tps65941: Add TPS65224 PMIC regulator support

 drivers/power/pmic/tps65941.c                |   1 +
 drivers/power/regulator/tps65941_regulator.c | 381 +++++++++++++++++--
 include/power/tps65941.h                     |  30 ++
 3 files changed, 381 insertions(+), 31 deletions(-)


base-commit: 4b151562bb8e54160adedbc6a1c0c749c00a2f84
-- 
2.25.1

