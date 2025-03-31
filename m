Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDC7C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4681082072;
	Mon, 31 Mar 2025 14:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AvWVfeJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DD481F7E; Mon, 31 Mar 2025 14:31:48 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B86981ECD
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso3531839f8f.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424305; x=1744029105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5+bxMo/9OI1mpOVDR5OrqZBPXNv4qSx9YKZscWS57E=;
 b=AvWVfeJOYKXtVMjtrk2+XAIV2FWSztnEEG9wbisPoxGjcD3gmAv25lNyuN+e77fc8w
 cbjtBBsx0QPBY3BbYaGG82+NguhdnTaeozPHO2yJRfoAoPLKZh4NtSRjcWYDoTD+8npd
 9RHJQpHb8KAezAB0TAjGTiiCa3pgvFCa4x/UFGqGZ1A5QyP5cBp+DWTMcs/hGYPQt90w
 dC8Y4d9xC9T4y/ALznc3Yeso7LilBvxu4b63DycPyMpRe+aJcGkTARay1OoCWzcJgzcl
 JT9hJHZBYyxj3tIRw9niFtQevNB47QwZKd8bCcBVp3Now48paSukOeIChXR+zfZQLof7
 rSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424305; x=1744029105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5+bxMo/9OI1mpOVDR5OrqZBPXNv4qSx9YKZscWS57E=;
 b=cXNEUlmElcTGvQXgE7WhOEZ7T/TNe5y7bErUMCmL4lYCcqxDClgtFA6KpNkieLMgUL
 /lPaUISrzayumTeBHqJs7+WgxjQgeZu1Imh2m4nVinFKxg8ZtrRDy5Vy6gWzwRoRHb6g
 ueWGP83crbXn3PWgapJ5uJSmgC0WujJD7fJUUIAkNcswhOQ/IziuPZgAsIUA3F6sIduU
 Q11B4XdBJPE56FdWZRTDG61TDJXTHDZW9yRsMZj+Wim5jRu5QxJJsea7k3mIeaZgzaXS
 VLbdKbR76TDVOp4tziVJPmyc9VwI3FdFZM9FLV3nsXFavlfbtkeb30f9ofQNzE2sDDXv
 OLrQ==
X-Gm-Message-State: AOJu0Yx7s+rVU5pE4XxQVhq74GYw9LSQBT3RZ6Ud8cteh4MCke5r1cZl
 +ZLtpo1uNr48MawQHYTeJ4XAoK/5d16wLpW0tXIgVFAfVQpODZr5XeuJeJvJjf/ifdQOvKkorIs
 Lf1O70Q==
X-Gm-Gg: ASbGncswkCKVN89arV2u+yHsEiKRaJO9Mwef1mPZ/DI+CO+qGHqd92O1lYatNTl8gYD
 8s/Y9NemfpI2n1lOdfTlcWVJu9gE6wub+2XaUIjdrQw0a7ov5lKS3ujuHQGKx9e/5beeQJgrLbF
 RzXoRZPUIGbhywl6i2mVUermPKehh5jvnFe35fWZDIujDaVVMaZR2mRlhJONThKKFmR+RAfh7a0
 mpWswuB3maHeOc4tZw3m+ZDQoKGjAaXww1dS6zKowH/MlD+Bi9dT3DEfu0CWXlGbkLBTDoxCRnV
 /MWJ8U13FxZdxUaWQ16u3HwPow04Z8rni1gGp/T7GIISUk1NhH9d
X-Google-Smtp-Source: AGHT+IG7hstCYUaZ3FZRTeTculaTHxLFBAVOwzlD+yCGD2mq7WVZwLozj/bkN9MQcpRZS/ogiVikIw==
X-Received: by 2002:a05:6000:184e:b0:39c:12ce:1054 with SMTP id
 ffacd0b85a97d-39c12ce1106mr6249694f8f.8.1743424305583; 
 Mon, 31 Mar 2025 05:31:45 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:45 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 09/16] lib: time: hook uthread_schedule() into udelay()
Date: Mon, 31 Mar 2025 14:31:03 +0200
Message-ID: <20250331123120.2025062-10-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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

