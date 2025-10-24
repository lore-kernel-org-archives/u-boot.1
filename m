Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C703CCCF9E3
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEAA183678;
	Fri, 24 Oct 2025 16:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WpK1ppBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5883836B2; Fri, 24 Oct 2025 16:17:16 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4EE83631
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 16:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so1461138f8f.0
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761315434; x=1761920234;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cMMWV3atCclCVcOZYFLw0JShMGpBeouOhNZQOrdo/xc=;
 b=WpK1ppBgADOmG4lDL5N4FOLrtqmdyBPsJV5L2AlVIS9kpnFxdxJ4PIUWRzdXt4gDjo
 Rf84pk4JZuwbzHNH3LWz7MR8QbGeReh7uO+mNpJSok6aRNzAs33gxmp79ECsRtFiEHrH
 FFNYQ8FamxTmCmQUIFgUlR6WP5X6gX8s1Q2iEkTqHljBW3gJxkyN0UGBrhcDYem3+zhy
 UjfzTIKHTC1KT/Ba8p6B8kkljTY6IA3HcZBev4ssN0WTRdUQNh+nv7g1PeJG5bDgSp9P
 fquEK7/PM0JwfiWlPyVXixfzplF13EtoAi52HB2sROp+8pO5i6/KjIRspCj6Ms6l/hxB
 0j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761315434; x=1761920234;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMMWV3atCclCVcOZYFLw0JShMGpBeouOhNZQOrdo/xc=;
 b=ShiTPrn0tBy4FcAZfsY3li0lPbHpFgM4eiPoe/zKsaIuzWSwJZZSuL62b6MVbwnpSI
 t72PSzIZ79ePbujaTVun/Q3n12Fx9fV18QVWlMs5alaw3skaA+qXgp7fLQX5ulw0drBC
 b20SfWvj4ZNiKlUhTFO7/PM4BLg0JNX/1q40YWtv645TJ31dov2IEM3crw9QybGYz9u2
 covpcalePAHgAp2BezF5Js7Ygb+1tqqIenOZZyQCPTg7Ypj8AakVptHwffkqtR3JD/Mi
 98Pa1Hi5EDL96GcagTEERA4ipTvS37K31B7R7FUJIGTMEYQvMIr245w1BXNAA2jC2gfY
 9x2A==
X-Gm-Message-State: AOJu0YwORBf/A005dI6Dyu1EmXTapUeYaUT8I1d5w2tIwvDw6hgNCvzC
 EE4GumAQ7gSZrobl1IEtZCCyDdChphoQ1i7GDXeIr2EPBSFIHYO+Cn2BReS3JmRGK9Q=
X-Gm-Gg: ASbGncupYinuaPJstTI+MZtmFkRxYdg5pWTF6vSKhln8xcZGdG9B0kWZNDe5I1Lo8Py
 0Fo2wBfeQ6WmwrzgDwJrX4TdACico2jgd7DqDarKZ8NMgFPZgQBaN3uXBFcxhbW+H723nY2UX7E
 qVefIYv2ByEUNiLvJtPycx7jyuAez6dyZo76JaU0qcy+PmfsiGDzF6Ejupn2Bw1RGJPYGtGh57N
 aCOur+nUZRIUZth+MyXFDvWSi9qkcS23zJm+6FvNmjnaNMakQFUGAZ0A1lkZzq1uZw4nGlsE8he
 4RbkhacfWy3m1Awrc7L6Nr+8ROL3oBXdjYIciB4/vmuHNgEyXJCzO1Pk8Anwz9iIgcpX5Phivmf
 dJyj/Q3uZzYV/r9x68DYdABOXz71wa5weybohdN4Xizd/lsxbM+c88DYjGJTxr+3trRuQu6AjEf
 J4r5g=
X-Google-Smtp-Source: AGHT+IE+eBTjnrYve+0x4brBkRkvhve4zgLwjV2/dLh7pCsoa8VlUoAo7btiMbvaVdCplSc/yC8bAg==
X-Received: by 2002:a5d:5f82:0:b0:3ea:6680:8fb5 with SMTP id
 ffacd0b85a97d-42990701979mr1805051f8f.2.1761315433753; 
 Fri, 24 Oct 2025 07:17:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:a5c0:bdf6:3b95:6cfd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ccc60sm9656065f8f.34.2025.10.24.07.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 07:17:13 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Subject: [PATCH v2 0/4] board: ti: am62x: Add EEPROM support and refactor
 board detection
Date: Fri, 24 Oct 2025 16:17:11 +0200
Message-Id: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGeK+2gC/1XMQQ6CMBCF4auQWVvTGRDBlfcwLFqYyiRCSWsIh
 HB3K4kLl/9L3rdB5CAc4ZZtEHiWKH5MQacM2t6MT1bSpQbSdEGNpTJDSQvzFPygCjRYk7aV7Qj
 SYwrsZDm0R5O6l/j2YT3wGb/rz7n+OTMqVDm6KkcqsKrd3Zr1JTbwufUDNPu+fwCT/L9yqQAAA
 A==
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
 board/ti/am62x/evm.c           | 54 +++++++++++++++++++++++++++++++++++++++++-
 board/ti/am64x/evm.c           | 45 +++--------------------------------
 board/ti/am65x/evm.c           | 17 ++-----------
 board/ti/common/board_detect.c | 43 +++++++++++++++++++++++++++++++++
 board/ti/common/board_detect.h | 22 +++++++++++++++++
 configs/am62x_evm_r5_defconfig |  1 +
 7 files changed, 127 insertions(+), 58 deletions(-)
---
base-commit: 6a56d10fdcf1309d2070b62dc15e80a047da971b
change-id: 20251016-am62xeeprom-41a1920b8bd2

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>

