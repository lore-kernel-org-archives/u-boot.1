Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5312C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2CF810F6;
	Tue, 25 Feb 2025 17:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p/+dm8m+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7BC807EE; Tue, 25 Feb 2025 17:35:23 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F2980FC9
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe84so2214033f8f.1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501319; x=1741106119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EF92eobcYswzOnj0cBEmpbroxKPlBmAfMb0V/T0t6pI=;
 b=p/+dm8m+sJiG7ZMXycbLsSgQeYZfw5boU0LTemW94YWzUbBpiDcDXFROqC5qmz12M/
 WN4LD/Q7ASrPQjWL4/huenOynq1p+kJNWQYMmi4csbeLTfwwsQtFOfO6C542X/pX/bkz
 1ADe2JRkyBvhJkZiVGLNjtNT9cPWZAveFfGfNjtQi/bkF+yVQQLsslhOZRwCJBfRek6k
 KMEnZztmE5/IXl2UNL5rj2tbgMXYkX2+GMHT7+eR3ZX3O+tTZn7Ab0Cj9fhbXU2nWUvM
 itLoRkhML6ZzYvhi/3oe8yQiiqNi+BOD6MTi02ieaAwP4HuDsNN+b5Rn4FNXCRJF0YB6
 /NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501319; x=1741106119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EF92eobcYswzOnj0cBEmpbroxKPlBmAfMb0V/T0t6pI=;
 b=ioOCpl88CdMwKzzz2p7I2ILgqHtjj07dnflLZYk7ruvdxFDl107HipoQPEmqkPEnm6
 1uXsFinFq78Wmiolx7fU9rboIFMG8z0Equ2nX7C2x8uNXs/DCCwvPgVIg/+8jPwouFG0
 8K20UpE+diOouMF87sRvf/BwvWxsLs46MxE6NS09wxkD9pAVipNf5t1IJHkhGNLxzY7q
 Ol/pLiGyaXEIM4x53/7YlZd2DECOKU8P8pIIs3gaB3Ten2aCC3SgNjOF9xSaXN0h1ed3
 tgQSvR1gGeyMPLWXG4sQPi22dMmqoRoA1TeRRcbhwg8E6frlkocmhWvis4ssNwk4gjAx
 d1KQ==
X-Gm-Message-State: AOJu0YyXDCyja51dxMwUtz8w2FnpqZLZHA+T9SdR6JBF0XmTU1m0cbJV
 r7WunQ2vBjUew54pkLthI+GBy/8AQMK94Pdb3N85XJCXXtYiTGmuY0kztxJHsetUI5NzOoZ270d
 nWi9i7A==
X-Gm-Gg: ASbGncvT+CMY4LkRNOL7JfIy7GYGac2cjdjumhezt57vvckTvfFj6XbGCLqlEdR+X/T
 2s7wjcUlEDufjQXfgc/olcd5srT/FOWbnLkXuN9erKGnqmnmpPzfiK3HuhG6asqaupDbsbreASC
 cgl+Zvj9mojGjownYnKpztd1fFI1rPa15CxJ6IftDWJLIZ53jflpG0Igl248wlTIF8Sv+TMtXQ9
 +8kSpMEHTR3gvko0LjBwQzauEudEMHFgkUHJJPkriUP/FUFkS7Ewr5za8KNZmcuDI9YNrkz8kAF
 Jriu+xKrSeoEvkNZ8LFXemqZ1xPJH6jHe3U=
X-Google-Smtp-Source: AGHT+IH1TqB3j+bPpiXBVzJbbUdO493VRECO8I4PIHgp1stYkMONMB6rrgX9dcx7N928jDmHU1ukUg==
X-Received: by 2002:a5d:64ec:0:b0:38f:277a:4eb3 with SMTP id
 ffacd0b85a97d-38f6e74f38amr13406975f8f.8.1740501319496; 
 Tue, 25 Feb 2025 08:35:19 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:19 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/14] lib: time: hook uthread_schedule() into udelay()
Date: Tue, 25 Feb 2025 17:34:34 +0100
Message-ID: <f9568a6c5140b99cbd5b48de21f4d5b12a76d92e.1740499185.git.jerome.forissier@linaro.org>
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

Introduce a uthread scheduling loop into udelay() when CONFIG_UTHREAD
is enabled. This means that any uthread calling into udelay() may yield
to uthread and be scheduled again later.

While not strictly necessary since uthread_schedule() is already called
by schedule(), tests show that it is desirable to call it in a tight
loop instead of calling __usleep(). It gives more opportunities for
other threads to make progress and results in better performances.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/time.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/time.c b/lib/time.c
index d88edafb196..d1a1a66f301 100644
--- a/lib/time.c
+++ b/lib/time.c
@@ -17,6 +17,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <uthread.h>
 
 #ifndef CFG_WD_PERIOD
 # define CFG_WD_PERIOD	(10 * 1000 * 1000)	/* 10 seconds default */
@@ -197,7 +198,14 @@ void udelay(unsigned long usec)
 	do {
 		schedule();
 		kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
-		__udelay(kv);
+		if (CONFIG_IS_ENABLED(UTHREAD)) {
+			ulong t0 = timer_get_us();
+			while (timer_get_us() < t0 + kv)
+				uthread_schedule();
+		} else {
+			__udelay(kv);
+		}
 		usec -= kv;
 	} while(usec);
+
 }
-- 
2.43.0

