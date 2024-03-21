Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9C3C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 18:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F8388137;
	Thu, 21 Mar 2024 19:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kOaPCYHW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228C887F6A; Thu, 21 Mar 2024 19:12:49 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295668813D
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 317BA4247A
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711044751;
 bh=Sby2HXoRhmnkG7zdqwruoK4zFKh1+fQQCXksn060L2k=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kOaPCYHWSBVtb9aN9mlXq+fppVcR1ozDBH5SaBgcukia7HRF8L9uQa+N69FHZO88u
 uzSV5oSRr2d4G4NR2mGDF7Y9YrHZtsmnU+FaPpO/YNpRNa8wlpGp1Qeb/MS/rqrCP1
 vPh1tCdc0tvTyrFma4tjiQbi+gcvuXOWqPisQcUizo1N+MFkzjoMuWLfD/0aBqfvyh
 BaclaVD08H/8SyCmnX6spT53wEhLAtUmA0M57CfgSswnaublceHWZ7Tvjw5zOxgeWV
 rr4siWxBMsOfHqPiv4TVQ9qfxE+PBzaGuurxRapKvGUoxaBsoMY3YhgYNP8YUXSExW
 pCEWgAh7cxFxw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41463916b89so6198765e9.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711044740; x=1711649540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sby2HXoRhmnkG7zdqwruoK4zFKh1+fQQCXksn060L2k=;
 b=Tu+Y7nEn0T5H5raTZ6s6SMzUyY+GAVNxa6D1uChmj+jhqkFUtOQxq7P805EgQASw8k
 1TVu+CPkXr8vYoXPpiJgckm/XHhnlVwPWH3gUCdJa/NK8zqe4mSIYWP/X80bz/tnjgOG
 tfCk6gvQNSta8Iu0IoqRl2CnMB6g5u7wJl6jW/nHbFfJ695KtPbuHMf0wukIw0RT7+Qw
 Hu4fZjT4Ia7zMdqee5Yz0TvnyRa+T6F+XuaGS20RfwmchiQEBsLPu9fAs6W8EN+LDyTM
 RYf0SiKPZMgv21v6FnmCJzC+yYnNC4v0ND8zz2hYgSFqhKOBQ031I+mdP5+TPluP7SZ9
 jsEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMp/y/vrtPdv/XI47Xxz2gHyy4we9kpTDRNUMojHeCqnGd9142SRIXN7MIwkmWFHjYtPUDlcpa1VOlGzNnMQRAZPyYPA==
X-Gm-Message-State: AOJu0Yx7scMW8jHekmt3IllTyQprWbHuOYWkGIkz2QL9SuGZMH+ApNuq
 KLJ33jTbws3rGQn3CqZXTBMg5n0Vggv58biBakmXFGvTkuV3jV/c3o57T5J7T58oFIK7fKgxATA
 N7z7b40emSf7J1+K/JAhh+00Y8K+tRge40LKJM4t2YHLEXUnl76ItBouZkYK8jJAHVkM=
X-Received: by 2002:a05:600c:4694:b0:413:f290:c747 with SMTP id
 p20-20020a05600c469400b00413f290c747mr4765577wmo.33.1711044740611; 
 Thu, 21 Mar 2024 11:12:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGM4yqnf5QmArFJoLES9dY+rWdADjgIGebdafz+d3t/vN9oePtVgMTh9iQSp503Ok37w/dTA==
X-Received: by 2002:a05:600c:4694:b0:413:f290:c747 with SMTP id
 p20-20020a05600c469400b00413f290c747mr4765559wmo.33.1711044740311; 
 Thu, 21 Mar 2024 11:12:20 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 hg10-20020a05600c538a00b004147743bd0dsm1469420wmb.38.2024.03.21.11.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 11:12:19 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 5/6] riscv: starfive: avoid including common.h
Date: Thu, 21 Mar 2024 19:11:48 +0100
Message-ID: <20240321181149.177356-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
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
v2:
	no change
---
 board/starfive/visionfive2/spl.c                    | 1 -
 board/starfive/visionfive2/starfive_visionfive2.c   | 1 -
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index e0e33cb37ba..1683bb99a51 100644
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
index 5ae8b850280..a86bca533b2 100644
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

