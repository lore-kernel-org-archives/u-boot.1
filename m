Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584F2C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BF5D832BE;
	Fri, 18 Apr 2025 16:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ryj+3o/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9510183208; Fri, 18 Apr 2025 16:11:42 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEBD83285
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so13921965e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985500; x=1745590300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWkPJaJUPiBbwy/a8Iueif41WDM+TwEabt66XUA//0g=;
 b=ryj+3o/kf/vkI6mW9xLuGr09lf48Wr6CEDeaoxzmXF9n1vAG0tZNQrZTDt7F12wYmv
 n3EFz48qpoPRu/u8uMY2cZVUHjsgB4mgjP2DH27RLTGbbbQzyfK0DLRmU7U/eLu7E2oM
 eZZfLlZ0v/fwNbzX4+ZpRjjWoAeZD4A7kscp/NBhH8uaztaGnHavaBhPa3Z5tA7dHoHC
 yIIoxgz9M5CoPIu3Wva3RiVNNphpL8LWoaFLJaD3nEu7VsOCn61uksEHCjOJfK4ejcAM
 gjsa8EHp6uA+VEfavN6Avq0r7xDnNnN3hN6XiOd7EQe/WKJEdGjgNTZuxHoWHNgsESkn
 XPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985500; x=1745590300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWkPJaJUPiBbwy/a8Iueif41WDM+TwEabt66XUA//0g=;
 b=hH9gsSfhG6wV0KIzJrzrbzVu1uYDGuBl8PzGUTyNQHCU7OMhEBI1KffhGBSPaTqww+
 u7lF3E8NvODVklIOkDJL0xYnL0QFJlUtKmtAvJh295qlOpDG6EGxCC6Q+MMJnjGmcY07
 LwsKHyRqmglHaY/haSKtWWXRirUB185t+3+Hz/zMXW0GDz5rFDPGxAi/Z3xC2lxryBe4
 2k7Mgz541U7qN1nSLNzlVqLpnIY1Rq6VbJBH2GO20kbL6m1kXxe8Lnd8A2Zxcbj7ln0Y
 iB1CrQktChHW6dunaYKsAa2zB9SiwFKZ/sd+N2g4cQH55zmLGb33HMHqk0yhbmiM/Clx
 TUcg==
X-Gm-Message-State: AOJu0Yxa9qcDBoBC0DJokg6TKCv6OeaHiPM4q6RR2Vcge8mxTh8p/kyL
 24epGqrCB3YdCueRRFun9I6n64/BWuzAb2IR08uTg8muRMl2LyoCoZx68QcQOu7Rw9zpqv8MYhb
 +IRH9zw==
X-Gm-Gg: ASbGnctttR57FsueUteMI7P60mVS7yQWO8QEHQebynsG6fdHsMw9I7dFGqm34fkzb1f
 uLrqBaEj9+z2sgxjEdJI6j0dDde9MebXqOEAFR6q/SPPLDeSq0+HP0R63Hqr1PvqEDBU+kzhJXW
 Cny5r/Ph+P61X3YAB+e70subSmn4it0ps52eiUNlKtH/UUTAwRNR/ooVmxmuXpaaxihw2hVOO/6
 GfzQrqWgrgRiqZH7habX2HZmM/2jG6vcft4EE1eQM177+NZ5dEF9A6/AL9WJsyuE12WxkKFgf+g
 cYNWIi1cX4NlICq8Q+XtzCmty/9hWldrqrRuFUCPnieJJohhgvorXc7MlMKO
X-Google-Smtp-Source: AGHT+IFwT9cdgk+O1NH1xPhjjl0yOCsZCBGO1KQpTrf0qsn9KU0/pSXivN7oGDEXpWPDCUuvE4pIvA==
X-Received: by 2002:a05:600c:8711:b0:43d:934:ea97 with SMTP id
 5b1f17b1804b1-4406ac0f82bmr24883465e9.27.1744985499762; 
 Fri, 18 Apr 2025 07:11:39 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:39 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 09/17] lib: time: hook uthread_schedule() into udelay()
Date: Fri, 18 Apr 2025 16:09:37 +0200
Message-ID: <20250418141114.2056981-10-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

Introduce a uthread scheduling loop into udelay() when CONFIG_UTHREAD
is enabled. This means that any uthread calling into udelay() may yield
to uthread and be scheduled again later. There is no delay in the
scheduling loop because tests have shown that such a delay can have a
detrimental effect on the console (input drops characters).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/time.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/time.c b/lib/time.c
index d88edafb196..0e9b079f9cf 100644
--- a/lib/time.c
+++ b/lib/time.c
@@ -17,6 +17,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <uthread.h>
 
 #ifndef CFG_WD_PERIOD
 # define CFG_WD_PERIOD	(10 * 1000 * 1000)	/* 10 seconds default */
@@ -197,7 +198,13 @@ void udelay(unsigned long usec)
 	do {
 		schedule();
 		kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
-		__udelay(kv);
+		if (CONFIG_IS_ENABLED(UTHREAD)) {
+			ulong t0 = timer_get_us();
+			while (timer_get_us() - t0 < kv)
+				uthread_schedule();
+		} else {
+			__udelay(kv);
+		}
 		usec -= kv;
 	} while(usec);
 }
-- 
2.43.0

