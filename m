Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C30CD1292
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B2F88352;
	Tue,  2 Apr 2024 10:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gBmg9w95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C698836F; Tue,  2 Apr 2024 10:49:31 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F8288356
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 77586424A1
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712047764;
 bh=k7ApjvI1MJPSMrWbfFkQGXfl/Ld2kUn5dAwESlColWg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gBmg9w95Uh3ULW3ij6+xrE6UT58pDwCBajpxiTh8MppsdD0VMBrkrup/+/IyfX972
 QpCmVjyKbyoS/oB3Kyw99MwC2HAWmkMkUAquGmyY7Q0G8QJY6EBoQaUdmU4lPgE3/t
 JWRb/jvoQGGkz4hF7KKaouE67Rcr0Dfo0pGo7GSyX84A2yO6xwhBP2LFrJF2bdcexO
 XiP8OC4TeJ395S2nKtt8+VUujIPfATDh300OwXFcRH6O3ZieMoGGExSl3TJ6fshGaD
 gDEqv7aPCclvJmY5lIXC72hrszGrRXozcwvOOEEffDCBZxn6fRkjykZ3DrojtsyoR+
 9p/2zMo06MXrQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41407fd718dso26964905e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712047763; x=1712652563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7ApjvI1MJPSMrWbfFkQGXfl/Ld2kUn5dAwESlColWg=;
 b=N007PRjh/1bLjky1HPCEiShc7wUCQ84oN8VKE5M971nnKOKGHQxWAO9CRlW6WlC9n0
 6rWNhKAp0xcOxZCh+8bhd2jSo7hkVMwXxPOqjZ3eMeVZMl+tq1njMj6vhVFedXR0CtRO
 DsJwYiz+SoszTYfn+j+DbRhBumBYGUVlGrlKu1juumJ2ODrd1isEXE39M7CEDbdL3S+5
 Z5EVUplg4Ei4J2JtcNrnNzTjSb1W+s/er5FXmnKmy6AMoqlQL7z1Mc+qQmXpZ/bzXTI6
 8X0hCN2vR79GO/+dfRDx2I0NoTpQmJlovWnfmKV8nYdBni05ChFawH3/5vNU49Jv3duQ
 WpGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVYEVW51NQ4YMhF19t9GhzLitebBJfY97ThV9ngg/pb6qv835EO+LDWfSGWZmj8DHdriolOmBT9e2c1y1fsYsQZKh2Aw==
X-Gm-Message-State: AOJu0YzpWHo4rc5YK7WrO/K29ZRTx0lt1gdVThlSqlJ+Y1hGua9KQZ6g
 aW3DqHmoLpIlb1f5vhxSfgwHY07Njt/kcxNLsXqZVD9IXGBtj+UpXQmHLp05vMxE1iJXIdgc17s
 RZbKTtjZAHAw+Zk7R5w7DTLRZwMrLykzdcmz1ysCI3Ypc0rOm46TVx75Sw/zYYxlEznxqx6EpBc
 L61Q==
X-Received: by 2002:a05:600c:1d18:b0:415:6616:6513 with SMTP id
 l24-20020a05600c1d1800b0041566166513mr3372713wms.12.1712047763640; 
 Tue, 02 Apr 2024 01:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4tkAcVjo7nUhbL8GUxRjd6+UIg/W7hbw3m+5+y1BnfXsFCZejQqHlY4m6+HH61AJqwlEOzQ==
X-Received: by 2002:a05:600c:1d18:b0:415:6616:6513 with SMTP id
 l24-20020a05600c1d1800b0041566166513mr3372708wms.12.1712047763358; 
 Tue, 02 Apr 2024 01:49:23 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004148c3685ffsm17409318wmq.3.2024.04.02.01.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 01:49:23 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 5/6] riscv: starfive: avoid including common.h
Date: Tue,  2 Apr 2024 10:49:11 +0200
Message-ID: <20240402084912.43228-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
References: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
v3:
	no change
v2:
	no change
---
 board/starfive/visionfive2/spl.c                    | 1 -
 board/starfive/visionfive2/starfive_visionfive2.c   | 1 -
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index e8f97d963a0..45848db6d8b 100644
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

