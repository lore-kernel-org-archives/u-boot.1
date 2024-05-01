Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D700C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C59288A81;
	Wed,  1 May 2024 04:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MPS6UDRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7A488A7F; Wed,  1 May 2024 04:43:24 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D812E88A78
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6a077a861e7so40169936d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531400; x=1715136200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vkjfTXk8bu++cmB8v4cZMWml75eLP7w5BNJxJFqscyo=;
 b=MPS6UDRllPp/pyL92ISUx7rU/RZvPzYws3w+nDsbB9Fp3zxyCEYy4btWzOxJ4IOUZC
 Y1+G2+bk+wPzCNZOXxBdEjJZSld0iyJxgRSrsoWxK1I+SRh8BN27yE1A2aliix/CyO+E
 dTtZOiK47APffCGng6bIvQgvB5a43NNImtoYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531400; x=1715136200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkjfTXk8bu++cmB8v4cZMWml75eLP7w5BNJxJFqscyo=;
 b=eEHkkZxsQDKzvAzHsp0sS/mFbZ7xeoVqe3NmoTlddOD6JFYxVh4FjKdRNfYHhB4TSf
 vKpz9tr3UOfrHkPA67p9+Y6Po5X39cF6HqDScnnB7g3uemhkejvqAk+iyWfmMFBawaWP
 4M09pTcGkFo7gK03C2CYLNRnaJCD2TAek/PbK1fYHXhzZUqQKo6lnxeraR5/+JXV+isR
 iirM9sE/lguxa/Ky2f8vG2M/3NlM9o0665PvPxZoeXK65ejFhue6vTfEnQkr8tWkzzcQ
 2CYvdWwvjq7aA/oyWotbQzrygWnhAk8ASdhEyPv1laTXcR8QlmJHLjsb8HMkteDMkrgA
 a2lw==
X-Gm-Message-State: AOJu0YwBLwibVwpQfT72fnky6UD+qWZshQOPtgF0PWYc8y6JSkz6Q9QA
 5T0TiryolJy/TsmJfumZG6BcM5kyj4FoYc5VjGHFTLOF1VqlWPPIV2Y3G4u009f3q5bkI7GEG/9
 0QuCGUQ==
X-Google-Smtp-Source: AGHT+IGy5Qp6Itx/Y9otSGY1cB3VQ6SCwaRUs6EhN/Z/JfvbutWz1y+uNLHybF9sw2bAJI3zc+nERw==
X-Received: by 2002:a05:6214:482:b0:6a0:cd66:ffb0 with SMTP id
 pt2-20020a056214048200b006a0cd66ffb0mr1130648qvb.38.1714531400213; 
 Tue, 30 Apr 2024 19:43:20 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.19
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 002/149] global: Audit usage of <eeprom.h>
Date: Tue, 30 Apr 2024 20:40:49 -0600
Message-Id: <20240501024316.1767971-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

The file include/eeprom.h is used only in some legacy non-DM I2C EEPROM
access cases. Remove most inclusions of this file as they are not
needed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/atmel/common/mac_eeprom.c              | 1 -
 board/compulab/common/eeprom.c               | 1 -
 board/cssi/cmpcpro/cmpcpro.c                 | 1 -
 board/dhelectronics/dh_imx6/dh_imx6.c        | 1 -
 board/phytec/phycore_rk3288/phycore-rk3288.c | 1 -
 board/rockchip/tinker_rk3288/tinker-rk3288.c | 1 -
 board/ti/am43xx/board.c                      | 1 -
 board/ti/common/board_detect.c               | 1 -
 board/ti/ks2_evm/board_k2g.c                 | 1 -
 drivers/misc/i2c_eeprom.c                    | 1 -
 drivers/rtc/rv3029.c                         | 1 -
 11 files changed, 11 deletions(-)

diff --git a/board/atmel/common/mac_eeprom.c b/board/atmel/common/mac_eeprom.c
index 4606008c697f..e3ab78fb895b 100644
--- a/board/atmel/common/mac_eeprom.c
+++ b/board/atmel/common/mac_eeprom.c
@@ -6,7 +6,6 @@
 
 #include <common.h>
 #include <dm.h>
-#include <eeprom.h>
 #include <env.h>
 #include <i2c_eeprom.h>
 #include <net.h>
diff --git a/board/compulab/common/eeprom.c b/board/compulab/common/eeprom.c
index c4b257f851d6..4c752821d6cd 100644
--- a/board/compulab/common/eeprom.c
+++ b/board/compulab/common/eeprom.c
@@ -7,7 +7,6 @@
  */
 
 #include <common.h>
-#include <eeprom.h>
 #include <i2c.h>
 #include <eeprom_layout.h>
 #include <eeprom_field.h>
diff --git a/board/cssi/cmpcpro/cmpcpro.c b/board/cssi/cmpcpro/cmpcpro.c
index ef3041245649..ec13d9a7ed7d 100644
--- a/board/cssi/cmpcpro/cmpcpro.c
+++ b/board/cssi/cmpcpro/cmpcpro.c
@@ -7,7 +7,6 @@
 #include <dm.h>
 #include <env.h>
 #include <env_internal.h>
-#include <eeprom.h>
 #include <fdt_support.h>
 #include <hang.h>
 #include <ioports.h>
diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c b/board/dhelectronics/dh_imx6/dh_imx6.c
index 0676587c38a1..9dcfcec9e9e6 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6.c
@@ -7,7 +7,6 @@
 
 #include <common.h>
 #include <dm.h>
-#include <eeprom.h>
 #include <image.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/phytec/phycore_rk3288/phycore-rk3288.c b/board/phytec/phycore_rk3288/phycore-rk3288.c
index 3f49f39e3d5d..1ddb4a4f8085 100644
--- a/board/phytec/phycore_rk3288/phycore-rk3288.c
+++ b/board/phytec/phycore_rk3288/phycore-rk3288.c
@@ -4,7 +4,6 @@
  * Author: Wadim Egorov <w.egorov@phytec.de>
  */
 
-#include <eeprom.h>
 #include <init.h>
 #include <log.h>
 #include <net.h>
diff --git a/board/rockchip/tinker_rk3288/tinker-rk3288.c b/board/rockchip/tinker_rk3288/tinker-rk3288.c
index eff3a00c30a8..e6e75981c2d1 100644
--- a/board/rockchip/tinker_rk3288/tinker-rk3288.c
+++ b/board/rockchip/tinker_rk3288/tinker-rk3288.c
@@ -5,7 +5,6 @@
 
 #include <common.h>
 #include <dm.h>
-#include <eeprom.h>
 #include <env.h>
 #include <i2c_eeprom.h>
 #include <init.h>
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index a4679a2e2948..fdeb63d47900 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -8,7 +8,6 @@
  */
 
 #include <common.h>
-#include <eeprom.h>
 #include <asm/global_data.h>
 #include <dm/uclass.h>
 #include <env.h>
diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index 38e23ccbb67c..644df3b0b6ab 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -8,7 +8,6 @@
  */
 
 #include <common.h>
-#include <eeprom.h>
 #include <log.h>
 #include <net.h>
 #include <asm/arch/hardware.h>
diff --git a/board/ti/ks2_evm/board_k2g.c b/board/ti/ks2_evm/board_k2g.c
index 5229afad63b0..4fed42ec1244 100644
--- a/board/ti/ks2_evm/board_k2g.c
+++ b/board/ti/ks2_evm/board_k2g.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 #include <common.h>
-#include <eeprom.h>
 #include <env.h>
 #include <hang.h>
 #include <image.h>
diff --git a/drivers/misc/i2c_eeprom.c b/drivers/misc/i2c_eeprom.c
index 9111bd724cbb..9cb375a99ab8 100644
--- a/drivers/misc/i2c_eeprom.c
+++ b/drivers/misc/i2c_eeprom.c
@@ -6,7 +6,6 @@
 #define LOG_CATEGORY UCLASS_I2C_EEPROM
 
 #include <common.h>
-#include <eeprom.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
diff --git a/drivers/rtc/rv3029.c b/drivers/rtc/rv3029.c
index 3afe5b2fdd67..9c53c7f7dbc7 100644
--- a/drivers/rtc/rv3029.c
+++ b/drivers/rtc/rv3029.c
@@ -10,7 +10,6 @@
 #include <common.h>
 #include <command.h>
 #include <dm.h>
-#include <eeprom.h>
 #include <i2c.h>
 #include <log.h>
 #include <rtc.h>
-- 
2.34.1

