Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CCBCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF55A86B74;
	Sun, 24 Sep 2023 21:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OXcDHcLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6847E86B5E; Sun, 24 Sep 2023 21:26:03 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1788D86B16
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3513885eab4so3092475ab.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583553; x=1696188353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aICVyKvuU5JfSIhsWdF89BOR56H3cGACEkieKv3Acq0=;
 b=OXcDHcLBjZAl2lsfm8OvjWZVYHnfo5fMbH3flrttj+ui8rlnf0ZyILFzoDU9cikn1R
 ezEsq+rrsCtZnScmEccUivnysryL1NP7QepcFtYTqdj88vn2Lkv/VENRDfWxwI8cJxCl
 w3/g+b0pl0IfiorvqhCkwKJHSOxj39RYm56mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583553; x=1696188353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aICVyKvuU5JfSIhsWdF89BOR56H3cGACEkieKv3Acq0=;
 b=LIgdLyOaxbAkyD4CgZpfCJq2dYBHJROgUTHK2rhZmqUTF7tjB9sXCfWUs2dYhA7MA9
 3cbEMeIJghSq/KhIrPbRIn+8Myi+CD4brDrJB0Jr15JsZ/771WT0ivvjxzUuQvt+ESkf
 cf2Eqw3G1WwvhTNe+z5QzCI2dSnBbLvBxtzE8ixat3GJlJsVhIRn8VlN5HU7VsKEdg48
 EXf4IMnSTEWKuAk16L8xPAwCvuY4GsNuXr0vhuUileW1boL7xUj2N8T8W/2ZjXb9/tz8
 wQFHYfAnpo/btWdM2sjmaN0/qfmucW6EaSPHBWVk+oSNpEh11O8UJuBx0uX4pAP0eDFw
 ecfQ==
X-Gm-Message-State: AOJu0YzHtsJ2VxAdwd+cX7M/5kDAO1IzSImADV3028c0iyVJd+CeHZkL
 ZxYyHKXtb6LneLNC0xHQHRSAKJN+L7/jnUeiwYs=
X-Google-Smtp-Source: AGHT+IHHS1AVT4tdVdvUfqzd+kjRdh9NqwSJmB//wt2KIKp1L0obssDvGz0/cil1JbHlamhCTtq03A==
X-Received: by 2002:a05:6e02:152f:b0:34f:d822:baab with SMTP id
 i15-20020a056e02152f00b0034fd822baabmr6743689ilu.12.1695583553724; 
 Sun, 24 Sep 2023 12:25:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 05/38] spl: Drop #ifdefs for BOARD_INIT and watchdog
Date: Sun, 24 Sep 2023 13:24:50 -0600
Message-ID: <20230924192536.1812799-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

(no changes since v1)

 common/spl/spl.c | 10 ++++------
 include/spl.h    |  8 ++++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 4233390d7de2..68e58c930c28 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -782,13 +782,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
index 92bcaa90a4af..d16cea3ea50b 100644
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
2.42.0.515.g380fc7ccd1-goog

