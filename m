Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391B9C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE4C3819B1;
	Tue, 18 Mar 2025 11:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zkTcUXit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43339800B3; Tue, 18 Mar 2025 11:47:31 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC0C81A0E
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso33329685e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294848; x=1742899648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y421ZCXdbIuk+CO6p9JQkLRemHxOxOFsYoJqtKMt0Rc=;
 b=zkTcUXitod9HvRA2DSxUSlhFPSR+Dwn7REvAa6cvwlSKTDrv4Kf3FtSg3lMpm/iCv/
 8zQN2YIhuLQNPzSo0kYizU8YJXX5OYAsHl4m0E9G9MYM5IpR0H8Tri7U5iufhCRly6L7
 G06QRqHwJbjPouatkeeg8UsnIR8Oho4Uzci1E3mXroGwvXCrrqi1Foz0S9Uno5xpuM/u
 ZcW0u+xzf245b+6BOjHPxVNOmUSgDIm35MFpllqqkXWx4AmfBTX3vZmLUW21HHFj8GNI
 b+7bKS4xFEKT9vwitF0NdLlcXAepTww2dsPkEUeYKIWIK2ogTL8DXxPIwOcprnp2Spex
 I05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294848; x=1742899648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y421ZCXdbIuk+CO6p9JQkLRemHxOxOFsYoJqtKMt0Rc=;
 b=l7MPM4moDm6nydjYqZo7ACYOf3kMEPuLErkGzgJ5uYb77Hs8oXBxGeau1mixSmyNze
 YEqyYr5GpC6yksUZHt84CqLHBV9n5pzpiEXr5CVMOHl3p474FNZWyakXxiVBv3W2xNdw
 fO0zmX4RTLZ0WJ4rQZl+Ch6nuoaBxB2aSxgaBVGKAxZIfRIxvzZWEjLxgbnR1wwKz+ox
 EWbCjiVkgi+J7Hacc44zs+0eONjg5TZKbUU5a+PlST0nP8fLp4xWD8psMLc+00lSXNrn
 QoEZKJf96gNTcpymTsSp+L2hJK1ZV2pAmykm9wt7iPiOplhcAhy0mYLEuzHJA95l5bJG
 AYXw==
X-Gm-Message-State: AOJu0Yy/cZ+lCYPdzHx/uiFubTwERm+jAQ3WIUFf7jCtEjG2lchUk/g8
 vOtGcsvJMW42Mdym0FniReUlLZAQRm0KqWGej6KLbzdaXoHf4XUcSvuG0Y7233CoKCQRWhgO60E
 iCKg=
X-Gm-Gg: ASbGncuOqLZXYUrghu+7ps9r10S5khKvXVIF5DT23gNXBkkQiYvQwLQfc7dx7n+OHQP
 UseNlhpnY3nGOLw0GVVw6oxNSHPaTSxLml29nN7cARcqoHbReSC/KjmXDb4SccQ50AvY9A6WJwF
 Q4/PiRSzRx+s2VSu/zWKUUmmg+CSiimxWnYmSNioyw6eGMO77vtliuFEVQP2RSd8E7yPX2gDKgg
 qDGgB1dmZp/ORhkVZOwr3laA4QDOfNEPuFBeu/Q7dSZaivG064C+cdKhLoxr2z5CifBeeXDjBQQ
 mlYyg4xXECK92NbLJ8x3CyjqLorkWSlf+Lz0kakV1jy2vKZsBhGyuw==
X-Google-Smtp-Source: AGHT+IFFGNAF9bS31CzSJUYznluWs8Jcjs7yiUpCNbQBkHeAt9xqsjJ8tL3KsJ8/7tCGLD96HpfXIg==
X-Received: by 2002:a05:600c:34c1:b0:43d:22d9:4b8e with SMTP id
 5b1f17b1804b1-43d3b98e5d7mr19413185e9.10.1742294848466; 
 Tue, 18 Mar 2025 03:47:28 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:28 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v4 07/14] cyclic: invoke uthread_schedule() from schedule()
Date: Tue, 18 Mar 2025 11:46:43 +0100
Message-ID: <20250318104659.1114340-8-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Stefan Roese <sr@denx.de>
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

