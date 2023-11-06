Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91809C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 890AF8701D;
	Mon,  6 Nov 2023 18:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7942187060; Mon,  6 Nov 2023 15:07:28 +0100 (CET)
Received: from esa2.ltts.com (unknown [14.140.155.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD0886552
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 15:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: 91YoEMWQeNJoA5yv9R0sYaF4deaFe0B4BsxBjdwtFtzmIXUFdh15T3FyXvvrEv6vfjqiTwWPKe
 hPN0rRBSWSZg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa2.ltts.com with ESMTP; 06 Nov 2023 19:37:22 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: jh80.chung@samsung.com,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v2 0/2] TPS65224 PMIC Driver
Date: Mon,  6 Nov 2023 19:37:10 +0530
Message-Id: <20231106140712.1780114-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Nov 2023 18:11:04 +0100
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

Add support for TPS65224 PMIC in U-boot. This includes driver for
PMIC and regulator.

The driver was tested on Ti's custom AM62A EVM using U-boot's
pmic list, regulator list, regulator enable, regulator disable and
regulator value commands. Regulator output voltages were verified.

Logs from running the above commands,
 => pmic list
 | Name                | Parent name       | Parent uclass @ seq
 | pmic@48             | i2c@4900000       | i2c @ 0 | status: 0
 | watchdog@12         | i2c@20000000      | i2c @ 1 | status: 0
 => reg list
 | Device              | regulator-name    | Parent
 | buck12              | buck12            | pmic@48
 | buck3               | buck3             | pmic@48
 | buck4               | buck4             | pmic@48
 | ldo1                | ldo1              | pmic@48
 | ldo2                | ldo2              | pmic@48
 | ldo3                | ldo3              | pmic@48
 => regulator dev buck12
 dev: buck12 @ buck12
 => regulator enable
 => regulator value 1500000
 => regulator disable

Changes since v1:
 - corrected coyright lines changed to 2023 in all files
 - Added #define macros for some of the magic numbers, constants
   and offsets to improve readability

Bhargav Raviprakash (2):
  driver: power: add support for TPS65224
  driver: power: regulator: add support for TPS65224 regulator

 drivers/power/pmic/Kconfig                   |   6 +
 drivers/power/pmic/Makefile                  |   1 +
 drivers/power/pmic/tps65224.c                | 141 ++++++
 drivers/power/regulator/Kconfig              |  10 +
 drivers/power/regulator/Makefile             |   1 +
 drivers/power/regulator/tps65224_regulator.c | 495 +++++++++++++++++++
 include/power/tps65224.h                     |  59 +++
 7 files changed, 713 insertions(+)
 create mode 100644 drivers/power/pmic/tps65224.c
 create mode 100644 drivers/power/regulator/tps65224_regulator.c
 create mode 100644 include/power/tps65224.h

-- 
2.25.1

