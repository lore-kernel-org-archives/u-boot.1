Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927FFC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D00811E0;
	Tue,  4 Mar 2025 16:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uGiBzCl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93981811B3; Tue,  4 Mar 2025 16:32:06 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE4B800C1
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390e6ac844fso5092174f8f.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102296; x=1741707096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMtdutuo61S5rVB0PvO6Ee5x2fRltLLt3zobQ6X/nRg=;
 b=uGiBzCl0+b02XI0hmz0gz8VeXD4SdZll4umAWMK1wx3eiY9hXxHX+Q2LcVObeMtlrW
 x1CaMYQgtJWChieCr8OmVAo9Nx6RI1k0B8MAGdfdCO2uSuyyv5kuWKemOr1oQOxyAJiK
 rA6yUkzQIrYQuVRs1O+I7jTykgUftc66tUmqpPOOsJvvwmcY/NakJ7VEio8SbeyQfJ0M
 nkNr4sjOphQaiBvOXF1qreKd6Yq/d2UvEOhOmIV80OFqXqwaDCQc8xQIWKLOz6rfE2Bz
 IxsqkdBds5To6zLjy+AiGx9LjotfNUc8bgWZ38hcIrVEZEfD3lbfoX091Rd8LRyCBsqY
 /3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102296; x=1741707096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMtdutuo61S5rVB0PvO6Ee5x2fRltLLt3zobQ6X/nRg=;
 b=uXYno71MoakyICiMjyuxah0XcqZZCZqFOMkk76RnQ2+mxiuu5qwu9TwAu91kKRuKn7
 4/bdzvGjyzBHP4KWIxbK6k9FQFQvRJetCJPj4cLiUzgpNZpXYnNU7pnRbWlUkvrIkqPp
 mUeNBdND8IulzkE0walRfhkUlRu0Uo565iAYOL6GX4eCvTY1ocoU2MsumDWP2vCjFY2I
 O06v355DCsMC/y19fScFc1uGpNGdjHSUGF1rfh843pHjnGqzzRpynWKYBchytSvmh7xH
 yIfnXbjLdaFniTAMFaJ4lAYgKB3IPgPBLhygG4PGCKEHsX/S5bczSFy6W1FFDr1EmfmD
 SQrQ==
X-Gm-Message-State: AOJu0Yzgu14JuDgIL5XuzCBFYQcK+VvbfRbgQOPq8nmIyQGw9ESZnh6T
 Tv9IAD1y+CL6z1dZ51oAfcyfnWOn/flcnyAuAe7hCzksN0GEeEmI0pHOHkW6JWjquz7TuL9H1Y2
 9
X-Gm-Gg: ASbGncuIBzWeXzu82HXoeHG3BZCYKjSKqW/qCRTqCGolde9j5UMHhVYCuntzmmCHnt4
 bjoMIU4aHGR5nG+/4sJ4b7VOW7/+dtgdQuJ7CSxy3Z5SIK3DNPtSm7RAw5JfaAcXYSEgxFz83wu
 1bMr7R3SJzPzJFYsoQyoLtYFWqi7S7RTTo5V5gXIbZ3VpL3rZmpEWyKWvqpAm8xaadEyVciI50g
 6Vox5oRaErU5vhsRTGLXQ7DGMg5gXOLrWPt3UbLCyMY7HRthQ/sZluLIQMqf+cCiTBhftxtvPVm
 edpDFmbFyp3hN8WdGQL/mvvan63ROoI0HpYNQFpoMO8BdJQlyIJa3A==
X-Google-Smtp-Source: AGHT+IGiu7nffB+M60Ik/2jBYb6Oo2VklKnvCkQXLjjbpbxq0y8nTJoB5Cann62sB0IIEMV/dkVP7w==
X-Received: by 2002:a05:6000:1ac9:b0:391:13ef:1af8 with SMTP id
 ffacd0b85a97d-39113ef1e1cmr4773008f8f.54.1741102296206; 
 Tue, 04 Mar 2025 07:31:36 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:35 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v3 08/14] lib: time: hook uthread_schedule() into udelay()
Date: Tue,  4 Mar 2025 16:24:56 +0100
Message-ID: <20250304152510.2832340-9-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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
to uthread and be scheduled again later. The granunlarity of the
scheduling loop is defined by CONFIG_UTHREAD_GRANULARITY. The lower the
value, the tighter the loop. The default value of 10 ms was chosen by
testing the concurrent initialization of the two USB busses of an
i.MX93 board (introduced in a later commit). The total time is as
follows:

  UTHREAD_GRANULARITY (us) |  "usb start" time (s)
  -------------------------+----------------------
                         0 |                2.426
                      1000 |                2.448
                     10000 |                2.512
                    100000 |                2.992
                    300000 |                3.407

For reference, if uthread_schedule() is not called at all in udelay()
except once via schedule(), the "usb start" time is 4.377s and without
UTHREAD it is 4.591 s.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/Kconfig |  8 ++++++++
 lib/time.c  | 21 ++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 8321f20e154..40964f5bb4a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1276,6 +1276,14 @@ config UTHREAD_STACK_SIZE
 	  When the stack_sz argument to uthread_create() is zero then this
 	  value is used.
 
+config UTHREAD_GRANULARITY
+	int "Scheduling period for uthreads inside udelay()"
+	depends on UTHREAD
+	default 10000
+	help
+	  The delay in microseconds between calls to uthread_schedule() inside
+	  the udelay() function.
+
 endmenu
 
 source "lib/fwu_updates/Kconfig"
diff --git a/lib/time.c b/lib/time.c
index d88edafb196..7c34424bf64 100644
--- a/lib/time.c
+++ b/lib/time.c
@@ -17,6 +17,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <uthread.h>
 
 #ifndef CFG_WD_PERIOD
 # define CFG_WD_PERIOD	(10 * 1000 * 1000)	/* 10 seconds default */
@@ -190,6 +191,23 @@ void __weak __udelay(unsigned long usec)
 
 /* ------------------------------------------------------------------------- */
 
+static void do_delay(unsigned long kv)
+{
+#if CONFIG_IS_ENABLED(UTHREAD)
+	ulong t0 = timer_get_us();
+	ulong gr = CONFIG_UTHREAD_GRANULARITY;
+
+	if (kv < CONFIG_UTHREAD_GRANULARITY)
+		gr = kv;
+	while (timer_get_us() - t0 < kv) {
+		uthread_schedule();
+		__udelay(gr);
+	}
+#else
+	__udelay(kv);
+#endif
+}
+
 void udelay(unsigned long usec)
 {
 	ulong kv;
@@ -197,7 +215,8 @@ void udelay(unsigned long usec)
 	do {
 		schedule();
 		kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
-		__udelay(kv);
+		do_delay(kv);
 		usec -= kv;
 	} while(usec);
+
 }
-- 
2.43.0

