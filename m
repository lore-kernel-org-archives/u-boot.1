Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACECDC5475B
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 13:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 547EB87F22;
	Sun,  3 Mar 2024 14:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MrKs5G8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271E387F06; Sun,  3 Mar 2024 14:01:31 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48AB687CDB
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 14:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 82EBA41BEA; 
 Sun,  3 Mar 2024 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709470888;
 bh=1ZnqQNSsV4IL3vqoeQQGZqWysr4OnDmhkrRWcJTTGYQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MrKs5G8bEW0dgIX6XZ96wuWIU3k03B3jsE581HqcFpAyRhepDtuxHRaeE3/sygJmc
 1XhSla59AHUsVp0GA7FZN2eqryYY7vcGxfIbImzxLuqTQdiNwplnXdn6a7TUZYojC/
 C7ctWhraqFGJCRbjK/FUIgX4kGFgqWKTD7xlJ4Ig371KqGUGvsnzrY2QE8TVxuLv5u
 5m7iG2tqt/IXcL8c5bMl9buFb+x/AGRcc+FLIZlZYFM4tzv1+QWOj95J3Iuv8Um/6r
 ZD3hpA+S8ID43ec9XkYwgQSAjInr3tp9DAHwikAm1BxFkhLGLvKi0VTj3acOdZi4tt
 ykRJn2Q0hOQOw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 4/5] riscv: starfive: avoid including common.h
Date: Sun,  3 Mar 2024 14:01:21 +0100
Message-ID: <20240303130122.29983-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
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

The usage of common.h is deprecated. Remove it from board files.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/spl.c                    | 1 -
 board/starfive/visionfive2/starfive_visionfive2.c   | 1 -
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index c62624a2eb5..1699ed20acf 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -4,7 +4,6 @@
  * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
  */
 
-#include <common.h>
 #include <asm/arch/eeprom.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/regs.h>
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 9970e309690..e299769e50e 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -4,7 +4,6 @@
  * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <fdt_support.h>
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index a9f4376c8e1..ddef7d61235 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -4,7 +4,6 @@
  * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <i2c.h>
-- 
2.43.0

