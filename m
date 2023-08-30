Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60741C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3292E8657D;
	Wed, 30 Aug 2023 20:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XB119XTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B5686516; Wed, 30 Aug 2023 20:05:50 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9BF8654D
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34bae82b2ffso112245ab.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418742; x=1694023542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foCLb2JA7BBrI3C9eBfc1JtYi3sHxPao0/SpZ3BV4nU=;
 b=XB119XTXN5S2DmPdyoH+LDuMtxQuN0ox5j50BrORMroEze03BehRv3PgFybp71ybnj
 eURJZdkRnKmQGQXUB2q7xjK7VZaZw5i0iFPmG34NtZs/zTeCNhRAd/PfuD+SiyWpQkCF
 jsSC/r6nZV9Os2mncQk3zN7tMWteaPyU7WJUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418742; x=1694023542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=foCLb2JA7BBrI3C9eBfc1JtYi3sHxPao0/SpZ3BV4nU=;
 b=h6oAww791HL9lU519hi2HRcmwKbJHLG0+WgT4RcaanqsRas5OC5tassJRgxHXUShRN
 TIQSvvl4tWpFeuxOG20FFMSwPsOH3MJLx86pO+mumDq+Str0f1M73R1PhlM2V9c/G3tX
 47AMloGk/bHX9uQ5omYNp43Ce7qQjItp4F8NZJ8A2iSBK4iGTSpyQIQ7Ln5w23+rms3M
 jvb1j2M3biy8hiDJ47ERtpH8yEKPoCvIXrkACBrdStUdaW7urK5ZahTTE5zU/BD+jJC7
 4uy+AfqYuNWbNRbe0Jmr/oNo9mW3c6Z30cG+TJXGt4Qy3KFgtw7iXJmv6plBYazyeCT2
 qxLw==
X-Gm-Message-State: AOJu0Yyt3qz9jIvCWoSI/EVANnHN03+pCvz5mirz3u18f64LYok7HG3T
 ZSlNudbRSbJP1c24E3gJ51Y9OnIkqRfn/6Qhjk0=
X-Google-Smtp-Source: AGHT+IGXVeprbp8igobM7oVZZcj9ZxYrKu3raN46Drt31OgII8qXPTO2QKpIvc/f9SHJEtuBlUsIeQ==
X-Received: by 2002:a92:d9c8:0:b0:34c:bc10:2566 with SMTP id
 n8-20020a92d9c8000000b0034cbc102566mr3310678ilq.8.1693418742145; 
 Wed, 30 Aug 2023 11:05:42 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Ovidiu Panait <ovpanait@gmail.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 06/32] spl: Drop #ifdefs for BOARD_INIT and watchdog
Date: Wed, 30 Aug 2023 12:04:37 -0600
Message-ID: <20230830180524.315916-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

Avoid using the preprocessor for these checks.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 10 ++++------
 include/spl.h    |  8 ++++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 3f513b0563a..77fe4cdb053 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -786,13 +786,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		}
 	}
 
-#if CONFIG_IS_ENABLED(BOARD_INIT)
-	spl_board_init();
-#endif
+	if (CONFIG_IS_ENABLED(BOARD_INIT))
+		spl_board_init();
 
-#if defined(CONFIG_SPL_WATCHDOG) && CONFIG_IS_ENABLED(WDT)
-	initr_watchdog();
-#endif
+	if (IS_ENABLED(CONFIG_SPL_WATCHDOG) && CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
 
 	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) ||
 	    IS_ENABLED(CONFIG_SPL_ATF))
diff --git a/include/spl.h b/include/spl.h
index 92bcaa90a4a..d16cea3ea50 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -707,9 +707,13 @@ int spl_early_init(void);
  */
 int spl_init(void);
 
-#ifdef CONFIG_SPL_BOARD_INIT
+/*
+ * spl_board_init() - Do board-specific init in SPL
+ *
+ * If xPL_BOARD_INIT is enabled, this is called from board_init_r() before
+ * jumping to the next phase.
+ */
 void spl_board_init(void);
-#endif
 
 /**
  * spl_was_boot_source() - check if U-Boot booted from SPL
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

