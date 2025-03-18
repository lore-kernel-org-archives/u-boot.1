Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF6FC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40BD281C64;
	Tue, 18 Mar 2025 11:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ArGiOnOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94D881B5C; Tue, 18 Mar 2025 11:47:32 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E65C81C67
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso33200375e9.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294849; x=1742899649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqA1qiEwfsjB6jI0ugIZhb0BBPHUo15b9Aaz2SzVmLo=;
 b=ArGiOnOZgOyDPCGGYCBmInDVGiFvUxyntun0W7q5bQVXXKcC7Bfv/uZLrh/XPTpxxt
 Waq1wJ4i4K5tIVE5T5HlVfF7tUHY92gR9zECBPjNv0C1+s1VdHkGZBreW1AAv5Vox5hc
 IzQixoOTEgg7ZtUGCQPBK/Q3FthoglRahD86MScpM90hcpH6oLFLY/l6U5NAefqoWuBE
 UvRyjHXO47gFAz7k/Q/Lqzu47A4eO8zUkZ4BA6G7f4AUDcaDUOpavAZcAR96zeknNea2
 FLBboWwSc0PzYH7kc4R8szbh3RbAOyrttlsGsXfuRygnNPqEPXDP6f5w3wCnHo2I5OG+
 F66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294849; x=1742899649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DqA1qiEwfsjB6jI0ugIZhb0BBPHUo15b9Aaz2SzVmLo=;
 b=WjzwBm0kviXGHirrLfoUJb1dywoM0buhqVRP7Mr5f5z8ADpb7ezOl7jyBYw4uWtt1M
 FMV0OmeEcKCNv7usnQ8hqrfGLr5H/XiW2wDw0cKBmSbDRPIj2b6Znf9FmwdcI8Mc1bL8
 ThjrvOpQ68+zaXah+MvSTeRNkvj1Y5E3Ohos7i1HE9m/6V5RkGr+yp/HLQ4hWodfHZ2Z
 SXFXdrjToTNyyALGREJ6wL3cvLjgKAbn2inkgBHZEducZuweTNnxVphzD65Kh/XPApzI
 urVVFeLRQpFJ7Z+9Wq97+O+ERQyPfnJhmB3pooJiLfVtDRVHvYVcJ5NBBWqTRbdI8tKF
 7L7w==
X-Gm-Message-State: AOJu0YxJ00wmqPOVFasC1D2YPkPj6kmrFw/hVCRTGjOSHk7IAQ8zLWxT
 bzA3Um8hgaXE4vsbkzAC0Or9C+zZgKTMnGUAgAYvFKe1dFTzHh4doi2RG8dLDo8/wcXAcl/2A5S
 P7Wo=
X-Gm-Gg: ASbGncuhMLdpjUcdubVxuVdrzJnGJKclMzkgDmhvekfeVRZd4ob+I16gG6wIUrUuiru
 jJ8OhYUJBlJHxREaXnbFW4exs6n79egjl1YxkZoP8dPoQejz7RL295LMFF1Vs7IlNzuLBy2Y5aG
 cdt+XigxRJE7ZvWicxEEzxBJmviq/ZuR4Hh1Az0OFo+XBa1pDWhyNuZn27eHGCDibKoGgv/zizq
 KntGYacM5rPfR0RwDdQTEQW4avMGGFHUeFlF2rXPpok21npPVmOkLRDDgp+0GUxFTSwtLo41+Yo
 ER03vvTWrEyl2qzsErzFLKDOSLFCedS4EEd5QLOh6fJIaCZgZKMLZg==
X-Google-Smtp-Source: AGHT+IGhOYNpEfPPiM6PpJcos7BlWUhm00ix32jc3TkTmdVnSwxJ9pqOU4R9J4y5HLNqpb9diich/Q==
X-Received: by 2002:a05:600c:3492:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43d3b7cc0bemr18722545e9.0.1742294849252; 
 Tue, 18 Mar 2025 03:47:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 08/14] lib: time: hook uthread_schedule() into udelay()
Date: Tue, 18 Mar 2025 11:46:44 +0100
Message-ID: <20250318104659.1114340-9-jerome.forissier@linaro.org>
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

Introduce a uthread scheduling loop into udelay() when CONFIG_UTHREAD
is enabled. This means that any uthread calling into udelay() may yield
to uthread and be scheduled again later. There is no delay in the
scheduling loop because tests have shown that such a delay can have a
detrimental effect on the console (input drops characters).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
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

