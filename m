Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C62C001DB
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 17:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A938678A;
	Sat,  2 Sep 2023 19:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j+FTyxeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED70866CF; Sat,  2 Sep 2023 19:15:21 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC708679F
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 19:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so1308235e9.0
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693674918; x=1694279718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=eh4HtzuNxc18n3xpzZnm3op/HPcb2OOJKYN3E7ovhLU=;
 b=j+FTyxeSavK1l0HBsII3Euy/BbVqmuSLYisLBSLZwxL5ZU4cHZDyZHjjN7o6AUR0pW
 qkfIG8HdEui4fTgn2n57z0g/PtvSK9LPb3RZ4Jpr9t+IUgdq2fSMUhROu70isb8Wnjl5
 4XcDgNthb4UN+dHRvfGH/1R+Eolq62WsOsEqeEE6im5nSWJ6qf546oE27sxMtr747C6r
 BDqNlKlp0XcoaNJkqYKQ95R/oBvNwp7zD4AP6BhdptB56BrPd0w2PhlRpMAkn4ZE11HG
 JSexPU5dylzCgHTml0BqowKKY84mMqpubs+3gQ+EQRH3erW8y8ZZxj5I8RIItZqqsXV+
 cdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693674918; x=1694279718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eh4HtzuNxc18n3xpzZnm3op/HPcb2OOJKYN3E7ovhLU=;
 b=eFrmWdO8IMF69lI/dXyu/PR0+9j1D+g9a4UGMaM+X09evItSw5QiiQ0OKcgUtadg4a
 Jo7U/9+LqX4ySKnwJdViszpJskkgtHZutwSJsPL7u2Vovbz9c4Ajq+8DM4R3AjVYRhOh
 ILU3fF6hDJgihxN3Y+6EcAd90LVjBrdqsvQXnLyALwhCR2fJhuIwCteNaSsXl+45DbKw
 /Ep2AJ2FvjIgku6XB+OiI2E4PAEm0sJcoyqqKGWRweldP9PZpBGH1VEgbDaCm98hzTMb
 EFzvLy2WR9M0O1PXkgqVoNW/RXMfvRK6wTrPF+L4jTmv3aCRu6wjrZxdJrzeIS0/hJ9R
 1RKw==
X-Gm-Message-State: AOJu0Yy7i5zcD4sQRL9PMBBrB8R/38cq5qlUXbrixxstvkcccKGTcFNx
 QNx7L8cK1hm8yFt9i319fpx/yPQ6Uym+7w==
X-Google-Smtp-Source: AGHT+IEbwQLGGETeNGBdSli9tGI5nhvpK+cBcageGLr865OprI7ybWuDUoZ1oxRIIIvYhPBeZRqTlw==
X-Received: by 2002:adf:de0f:0:b0:317:cdc4:762e with SMTP id
 b15-20020adfde0f000000b00317cdc4762emr3978623wrm.63.1693674918518; 
 Sat, 02 Sep 2023 10:15:18 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.185.187])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a5d4804000000b0031c56218984sm9042994wrq.104.2023.09.02.10.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 10:15:18 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Akash Gajjar <gajjar04akash@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 2/2] configs: rockchip: add DOS_PARTITION to RK3308 boards
 defconfig
Date: Sat,  2 Sep 2023 19:15:07 +0200
Message-Id: <20230902171507.351774-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Without DOS_PARTITION support U-Boot is not able to boot an OS stored
into an SD card with MBR partitions table. This is still a quite common
case, so add DOS_PARTITION (only for U-Boot proper build) to Rockchip
RK3308 EVB and Firefly roc-rk3308-cc board: they are the only RK boards
missing of DOS_PARTITION.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 configs/evb-rk3308_defconfig    | 2 +-
 configs/roc-cc-rk3308_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index a13a809c1e..c6472a2c9c 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
-# CONFIG_DOS_PARTITION is not set
+# CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_ISO_PARTITION is not set
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index 9a789b212f..ca92b8f744 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
-# CONFIG_DOS_PARTITION is not set
+# CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_ISO_PARTITION is not set
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
-- 
2.34.1

