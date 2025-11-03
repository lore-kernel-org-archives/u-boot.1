Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AE2CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 18:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CEC838CE;
	Mon,  3 Nov 2025 19:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vQL1Un4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A447838E7; Mon,  3 Nov 2025 19:40:20 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097B18331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 19:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-429c82bf86bso2237074f8f.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762195217; x=1762800017;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WQUK0f41hgFZGpWCvP6Zgd2cy4AesUI+5NPxWcv//yo=;
 b=vQL1Un4Y0S9Xk35BrbAN5mtiZ2g4+xb4Yi4tU55WlWWdNOaYMqt7Ge7Vd90YK3TYey
 ++1ZoKE9iXM9S1I9YXr5W+mr3j31JRFS4b0f3Ja5odvVoNZoNU//Mcr368JRV2+g8ny5
 uncYcCA4w/IXEErfaa3tambLytl9F8RFbCwE4Iw5e6beCJyDwf8LBzGN+K9iKIPghxkZ
 M1dYLSMznI2MBJr3bMBwvkL3jVFKdbHky9/ScxUYLO3e9g3AcvwirGYHn2ma6hHF2hvf
 HdWJ63S8JI2SclpMv/7QCoz9fBMTO4qBYW4ll75SHFk8Ys+cTXBo0Ksqa/OCeuYwPi6c
 WtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195217; x=1762800017;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQUK0f41hgFZGpWCvP6Zgd2cy4AesUI+5NPxWcv//yo=;
 b=rZ8H93H3ebd8/y5rrvEqW4qsKkMzHd8V0op6Q9mH1hyH92YME9dsiVF69Esnd1P3ct
 +CI7mhWcTqncAKWq+UL2WLfmJLpD+lZauOpVrRDJuEvEF5JkPKgHTjp6/ezRinHDBBla
 VtnuOqYr4hX91HUctknDEf5pBefeeEMwrjGnxqcc3pp3Z59H6CKFfZx4QwYlWH9iZp91
 dJzgFc4/Gwotk65YJGhHkRQjEvrST8QclHoWhLoEfSIksRoOSqDgmuP4PD1Qe6DHoV9Q
 zkmAfzmuj5SjQzILdkWlvd6m6I2U/FqYdfhgIE8sSbzXffKAT8yXudn1nC3ap8Sxvqkj
 GU3A==
X-Gm-Message-State: AOJu0YwH39jiGgtLQRjAYqzyVdaWJj0E5JNO/ucSz0XdZHyubeZV6RSi
 zrWNZTzMIFncuCJ1riyaJxIkwNnZ454WlfctV9bihhUOAqZPk3tUan0CK0IxHci8KjQ=
X-Gm-Gg: ASbGncuSkMHxXltmZ6dVc2xmhbeUgZf2++gogCqx+6IOJaPWZqe2OtzM02gE4pIrMBr
 Bv/EMV35uJ8+X19GEKaJodrskBbpXJ6qGAmFqVxp6q26K4myMy87rN2Q/7WHHHz/WzhWcAessiz
 K0jxXgFWrw959TtUd/ER75KfcWbp7kRLf7RSugrFHaVk0qmKTcJi1S793OI5IPjsKy2hMqTIvXB
 YmLMR5eLNbEmJrk1HK/ukPKgwJBlUg7tV5CcttQ2M1MezOgYt4GSlpXq+QKPn/6xbeWzkmHK93w
 f90KkAxe+/bwqCEP6Uphy2mgo233B+pPCyxyrlbftMOGq6TEcN+p+wjxngagjsbuyPGge+hB/SO
 ZHCcdrfr1yL+X046XsS8l3xhpf06isIf5xhQaV47Z4nBJif004RYydWt4OzPeP+ADdsi76Die+r
 ESHaaDR1JnlF98
X-Google-Smtp-Source: AGHT+IEIZ8HvREaq2giCfSqiqBmuTGSMi9wl4t1v7fC0rvzhgareabH9AsAv5c66LsAhhkvSL3fjEw==
X-Received: by 2002:a05:6000:22c7:b0:429:d742:87cf with SMTP id
 ffacd0b85a97d-429d7428a28mr2325737f8f.47.1762195217232; 
 Mon, 03 Nov 2025 10:40:17 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:23eb:8c68:e19:f7bc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f98d9sm160295f8f.32.2025.11.03.10.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:40:16 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Subject: [PATCH v3 0/4] board: ti: am62x: Add EEPROM support and refactor
 board detection
Date: Mon, 03 Nov 2025 19:40:01 +0100
Message-Id: <20251103-am62xeeprom-v3-0-e390779c0fc5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAH3CGkC/13MQQqDMBCF4atI1k3JTFKjXfUepQujYw1UI0kJi
 nj3RqFQu3wP/m9hgbylwK7ZwjxFG6wb0pCnjNVdNTyJ2yZthgIvICDnVZ/jRDR613MFFZQoTGE
 aZKkYPbV22rX7I+3Ohrfz845H2N6vow9OBA5cQltIQAVF2d5MNb+s8XSuXc82KuJPjuqYIxdck
 NQolSbdqL98XdcPNomTB+gAAAA=
X-Change-ID: 20251016-am62xeeprom-41a1920b8bd2
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Neha Malcom Francis <n-francis@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Prasanth Babu Mantena <p-mantena@ti.com>, 
 Judith Mendez <jm@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dhruva Gole <d-gole@ti.com>, Andrew Davis <afd@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aashvij Shenai <a-shenai@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
X-Mailer: b4 0.14.3
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

This series adds EEPROM board detection support for AM62x and refactors
the board detection code across AM6x family boards to eliminate code
duplication.

The series introduces two new generic functions for AM6x boards:
- do_board_detect_am6(): Reads the on-board EEPROM with fallback logic
  to alternate I2C addresses
- setup_serial_am6(): Sets up the serial number environment variable
  from EEPROM data

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
Changes in v3:
- Remove beagleplay part 
- Link to v2: https://lore.kernel.org/r/20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com

Changes in v2:
- Create Generic function 
- migrate am64 and am65 on it
- Link to v1: https://lore.kernel.org/r/20251017-am62xeeprom-v1-1-31f83124189f@baylibre.com

---
Guillaume La Roque (TI.com) (4):
      board: ti: common: Add generic AM6x board detection functions
      board: am62x: Add support for reading eeprom data
      board: am64x: Use generic AM6x board detection functions
      board: am65x: Use generic AM6x board detection function

 arch/arm/mach-k3/am62x/Kconfig |  3 +++
 board/ti/am62x/evm.c           | 51 +++++++++++++++++++++++++++++++++++++++++-
 board/ti/am64x/evm.c           | 45 +++----------------------------------
 board/ti/am65x/evm.c           | 17 ++------------
 board/ti/common/board_detect.c | 43 +++++++++++++++++++++++++++++++++++
 board/ti/common/board_detect.h | 22 ++++++++++++++++++
 configs/am62x_evm_r5_defconfig |  1 +
 7 files changed, 124 insertions(+), 58 deletions(-)
---
base-commit: 6a56d10fdcf1309d2070b62dc15e80a047da971b
change-id: 20251016-am62xeeprom-41a1920b8bd2

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>

