Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9742ECD98C5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48B9D849F7;
	Thu, 11 Jun 2026 04:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T+8cq+XE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B2B84963; Thu, 11 Jun 2026 00:12:48 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362D484931
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 00:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joaofl@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so32746765e9.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781129565; x=1781734365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIIL8iAhlSyUxVyMKSev0bMGUw2BKb4z9VfhxeewKdM=;
 b=T+8cq+XEpY0VdKqdFoa8l1iIKhGVRAGdQvEYkj4BppsB65ANJOZiyHdTeDVehQHPXX
 aTJYV6lYgx3yPvb3Xosqyb8HgNU0hix3w1OX3WO/OfgeTSYg6AMuz+Cw3/7WSTwaRs4S
 uteObVDqPROdAi/KnedcWtwR1XyX3pncLgC27k1+fMYdoBZBqxO2JKxhPt2hLYBF/kRj
 RS7lbn0gVTh9WRPZqVvEMBUHAiYqr7JfGcRc3z2qGQfhNDTsgs78XBPQq33UzkA8Rodu
 19snSqXJMpsX+j1/L9tVxk0R1MuVov2QbAail5W+E/0f7dEa4LYMQW/udvRB6JgysoJ+
 PEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781129565; x=1781734365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BIIL8iAhlSyUxVyMKSev0bMGUw2BKb4z9VfhxeewKdM=;
 b=E5bp3stfuc9WjoG448q+YEJFL0LgnjhfeCOhucI+pTrqukE1Q78fSkhzXXSwF4UnwP
 IHUqnn4616NZDwl6k5xhStwfYUTym0HFxlARxSxowrJ8Yajy2tZoMQvwwHZSVLHAm1XG
 1idOJAeQQFeX+c/Sj3LIlSEHsZaS1TWsrzROOLOOt59ZSHE53GMbPFgVz8H9eu78wtaf
 iBY17A2smJWK/tlCba7iwfvzx9YOwCk7dcHGtj2LP3wJyWBp3u0oR5XyYcd5FZUiHZDI
 NCKI3IFHjn2bCwUsiqi06JQI3ygS9inVYgiv/OTOHi0GEF1YTOkTuDY4pIyyV6C4PNMZ
 BNKg==
X-Gm-Message-State: AOJu0Yzcl42DGEelrhpnS9EbY3+XRWws6V6FuemSvOhDaOorKyrFxao1
 B/OqgklqqATitfcjY605RFvggdrrvLksHGRQ18RFEZnWEhh6E+9SZsx4Kf3ukQ==
X-Gm-Gg: Acq92OGLYJgDf4/CvLPmzi0V940PY4he6hJ5MrGm6bksZGp/4VAV964VWYGe82+JEjC
 JaBH95md4jVneBSmD5XrwmZixuJz5yRVPDAvd8LzGGg19ncq/RCZGPUJPnuKpNY0JoMCH2lIEVW
 t3zHP8qA4nzF7Yjb+6elZdE20vQxZHTvSkHWqBXp2Rppfu6nF0jPtiH8+perEF1UQPvPII9sO3W
 ggT5kusDQjrU0W6fLQRqipi4WML5YihWIzdLgEtcWfHNxtjKvhXlzhdnENE+1CGlb/yL8PwNhab
 sH1HKilFkAobq05LpEUvhB8pqfHmWtv42AnrS98oX6mDLPSBP+qN8wUNCwvMX4VMvbvaUUPsW6v
 /2L3Nv+4Vd1FDx+r9JeE4Pvc/h/WK5vVsF6T9tGgQNsEZnO8laSFIYsY/dLivsF87Bo5ykM2MsK
 J0hgOkUdmwSVdl5aZizzUffBLiHldSuu+FWZOrbzKHWNVFuvatDybu91v4vQJTYh/PVuwoj9b2b
 CEIbp9Vfb6zyqIMPiv7PL8Z6tBRAw9ogwhn/fnw+iqR
X-Received: by 2002:a05:600c:37c9:b0:490:a296:fdad with SMTP id
 5b1f17b1804b1-490c2600e5amr391059485e9.24.1781129565474; 
 Wed, 10 Jun 2026 15:12:45 -0700 (PDT)
Received: from lap.lan (212-51-142-79.fiber7.init7.net. [212.51.142.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc577sm76673426f8f.3.2026.06.10.15.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 15:12:43 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v3 0/2] spi: Introduce initial EEPROM driver mode support
Date: Thu, 11 Jun 2026 00:11:58 +0200
Message-ID: <20260610221200.167711-1-joaofl@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <AM9P122MB0281B24BE5B8A8E6A3F2D343F2CB2@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
References: <AM9P122MB0281B24BE5B8A8E6A3F2D343F2CB2@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

This series introduces an initial SPI EEPROM driver model uclass,
analogous to the existing I2C EEPROM support, currently providing
read-only access.

v2 was deferred mainly because of the large number of checkpatch
issues. This v3 reworks the driver from scratch to be checkpatch
clean, drops dead code and the misleading no-op write stub, fixes the
read bounds checking, and corrects the AT25160 geometry. It is rebased
on current master.

In addition, and to address the "new uclass needs a sandbox driver and
a test" request, patch 2 adds a sandbox SPI EEPROM emulator and a
test/dm test. To make that possible the sandbox SPI controller now lets
a slave select its emulator through a "sandbox,emul" phandle (mirroring
the sandbox I2C bus), while still defaulting to the SPI flash emulator
so existing behaviour is unchanged.

Note: this work was originally submitted from a Philips address which I
no longer have; it is resent from my personal address.

Tested on sandbox: "ut dm spi_eeprom" passes, and the existing
"ut dm spi*" tests still pass.

João Loureiro (2):
  spi: Introduce initial EEPROM driver mode support
  sandbox: spi: Add SPI EEPROM emulator and DM test

 MAINTAINERS                    |   8 ++
 arch/sandbox/dts/test.dts      |  13 ++-
 configs/sandbox_defconfig      |   1 +
 drivers/misc/Kconfig           |   6 ++
 drivers/misc/Makefile          |   2 +
 drivers/misc/spi_eeprom.c      | 185 +++++++++++++++++++++++++++++++++
 drivers/misc/spi_eeprom_emul.c | 118 +++++++++++++++++++++
 drivers/spi/sandbox_spi.c      |  31 +++++-
 include/dm/uclass-id.h         |   1 +
 include/spi_eeprom.h           |  91 ++++++++++++++++
 test/dm/Makefile               |   1 +
 test/dm/spi_eeprom.c           |  45 ++++++++
 12 files changed, 500 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/spi_eeprom.c
 create mode 100644 drivers/misc/spi_eeprom_emul.c
 create mode 100644 include/spi_eeprom.h
 create mode 100644 test/dm/spi_eeprom.c

-- 
2.54.0

