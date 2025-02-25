Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFE3C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8C480FF0;
	Tue, 25 Feb 2025 17:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GeX7AS60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE6E80FF2; Tue, 25 Feb 2025 17:35:22 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A3F80F7B
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43aac0390e8so14720365e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501319; x=1741106119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsjgCMtdoqYaj9xbsmREk63vgEQC+6G2vC6Ad1A5Aec=;
 b=GeX7AS60jqowMLihZiqK1C7RBdeT56cFQLjHFJs4KEXoUwYZQrJkdDXXibIFPEWhJx
 zLvDvaXYuIY5QYxUslfN7SCRjb4+KfDV2kxXTxRzJiG6dph8Yq8KSCrKj+XZXM/6GC2I
 BtoiyJWVGTXKUw6vs+TfCi9nKd/yobywI0wgQys+BnUvZdnPNurVfYviRswfC3N1oxgW
 4YoXtAiVabo/dElxYxfaZD1Bb+ncbZzrcziyzhAhZeaKWXBrDfYQKkt9jw+raKPp7Ijg
 TUMetvOIDta2sV7ewbQUfQ919kbbuvpGuRkWsDuh82++XoCRAHkik+cBOWQg+LUwKLBc
 JGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501319; x=1741106119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsjgCMtdoqYaj9xbsmREk63vgEQC+6G2vC6Ad1A5Aec=;
 b=EvrB/zUwFxnY5bwSyI1o8Ty/OsKEJ92JCf5Y1PvoOYG6PusvjX+Y0GZTqZG2D3XX7R
 5gptC78oVSJLDdiDgsMF2y0Hizx2LkhPhBjHWPbx8JjZhXyyxoO65t6s6CRKLqOd/3r2
 IdIzvCJQNUmSEkV0Z/y77IyApiMSAe2iIL/FQXa32stdKRnYdEyCd/IgWVf179qsV4SF
 3TE1pkOWNxHxobDlK4S9QwrnEFcPYrEN/4tSM9U8SL8yQFhXA0rBvqKnKM0xyHLgVeTF
 Gnvx9E91xBAWeRZlEAemhvTRGSnMCZ8v1qiEevZx9Lnhrx4wqt2yo3IjTTwQ3Af/rPy1
 8mXQ==
X-Gm-Message-State: AOJu0YxEevxihKDhAooTpJhh5eyURVrYarQyfumc9T0CMUUTXNw7ZqHX
 Pth9dXIQYw5kgdb/q2H/pRltqlnMKpm4rCJlZ1wdv6hEIzp5l1dnsKIYYIrveyZhG7gBRwKdiV4
 ZF4pvkQ==
X-Gm-Gg: ASbGncsO3tynY1f3I5ZtxUKEwY1ihPV/VqoTsszxrjwRYkIvaM8S/MfuVLPXk2XEmtP
 E/uFMUA6Wbaa1OAF1wMHULnQM7qoBcCyFKIjAKSjvpR69Fw1Lk549HpY5ROu6YCtaEuM7fN1EMp
 wrkBkO9YeLLYd5OwoSrMzx5LEO/+ZWqOTnChPOGMqLbB5qcBMnryiHyC51gIIFquFBfkrroQlkZ
 AXxg3p8WtiWA3ALximCsUvViiclJvZbRxUM0Al3IdVGGrrPTes1+L4q6wuEXtxCju4mpgDzNECs
 /WTi5y3EtpjEE+OiKoDDx42rjS7lhiw5qrU=
X-Google-Smtp-Source: AGHT+IEa8lZmK5yGDDGZA7nEa6Htw/DoMrIBCAN6TSlvWe7XUuZxi5vG+ikx4I2cJAVbet+710ytmw==
X-Received: by 2002:a05:600c:3b08:b0:439:90f5:3942 with SMTP id
 5b1f17b1804b1-439ae221b60mr138981935e9.25.1740501318765; 
 Tue, 25 Feb 2025 08:35:18 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:18 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 07/14] cyclic: invoke uthread_schedule() from schedule()
Date: Tue, 25 Feb 2025 17:34:33 +0100
Message-ID: <f209e0a9ca2dc8687599d9938fc319779cd8e08d.1740499185.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740499185.git.jerome.forissier@linaro.org>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
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

Make the schedule() call from the CYCLIC framework a uthread scheduling
point too. This makes sense since schedule() is called from a lot of
places where uthread_schedule() needs to be called.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/cyclic.c           | 3 +++
 include/u-boot/schedule.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/common/cyclic.c b/common/cyclic.c
index fad071a39c6..b695f092f52 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <asm/global_data.h>
 #include <u-boot/schedule.h>
+#include <uthread.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -100,6 +101,8 @@ void schedule(void)
 	 */
 	if (gd)
 		cyclic_run();
+
+	uthread_schedule();
 }
 
 int cyclic_unregister_all(void)
diff --git a/include/u-boot/schedule.h b/include/u-boot/schedule.h
index 4fd34c41229..4605971fdcb 100644
--- a/include/u-boot/schedule.h
+++ b/include/u-boot/schedule.h
@@ -3,6 +3,8 @@
 #ifndef _U_BOOT_SCHEDULE_H
 #define _U_BOOT_SCHEDULE_H
 
+#include <uthread.h>
+
 #if CONFIG_IS_ENABLED(CYCLIC)
 /**
  * schedule() - Schedule all potentially waiting tasks
@@ -17,6 +19,7 @@ void schedule(void);
 
 static inline void schedule(void)
 {
+	uthread_schedule();
 }
 
 #endif
-- 
2.43.0

