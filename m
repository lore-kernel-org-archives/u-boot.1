Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EBEC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B4E80E94;
	Fri, 14 Feb 2025 15:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WTXmLkPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03B7B80F30; Fri, 14 Feb 2025 15:01:08 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005ED80C83
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394829ef0fso20028515e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541665; x=1740146465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsZGwPqorEyyIVDUz+JMZwFYfCF74UByryXvgOhuuVY=;
 b=WTXmLkPG42pPEZI1qo+1HFc9MjIzyO+rciND4+SI1Ev4iZZC8vIZaxTBOW2r1oAFhd
 gzWUfzyF2W8eD34qntVOon1uk8piSCQ0Zr2GTBCFuc789MKp3xjt+hkkTDFtNs7dK+h+
 iBUfYIETjx3jv9ywPQuA67km2aZW5KjwEcdP/ShNH6TQ7UmkaLf8JnETuS+ZEsfSGyBh
 wNjEAsZ11sNLhKLUUecs1fomnkukYob+LJloyQScSmstZu/NmJ8Eu8sASoUgkqFeKnr6
 hg4mL5OoDGtkse4t/p3M7SgmL0Ce76WkGKdGZdhS4qsAaEKjcb/OVsw15m+YAe7me3ZG
 tTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541665; x=1740146465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WsZGwPqorEyyIVDUz+JMZwFYfCF74UByryXvgOhuuVY=;
 b=cVRMBbImYNtyizQfx6UxU8xL+14CV7nX+uqGcwrA7tGxamhrv2TakPBHBdUw3bUnqr
 Vs3O/auMabMtBYN238qmf5MnFiISXD+MphOYcQAX5/1ApGSS0LF1yRPInZ4jwA3f7cQU
 i1IeH4HubD/qhBBjEjzwGwYJULJrjCuV0YxnzyIkLcwEo/xcsBHNeTYSY17iztpy3SIa
 GEyov5DqTlceDkDLxMYV+lIgPiLR1632nTb2QdbwNuElsiv6fmmWiCgK3mkYv4Jabk71
 ezbS/WuCpk73Xqj/nr15TstbiPSRggVRvuEyUm+CYywU9I0BDRRjSiY96qpID2NirqCO
 ra5A==
X-Gm-Message-State: AOJu0YyF07pDS39BkA+IiiFH7v64ywb+MygUiG8BZQzvG0pnkEBnppak
 BGkDljeEghDzMMRXJEfJ64owTDOimirdqUqLd1Ek0rozKPw5b8ozBNRBizRt2Hdt3CVmpvyHylF
 UWtC9MA==
X-Gm-Gg: ASbGncsGgeDvCChZyE2QkPvBUSM75t7G4/V2a4He394L9oZNZpY5Y/4IR4lovWG9Y8n
 sspuz/w/9WWxN5//lDEojcqHNOzwjhDs1hGwIN2KHn39kMnFMNUt9oi5Jh4cQ4Nfy1p81MXVLwl
 322j6wfIbFo/pdnt4sgRaFgSSLbCD7cLrjSUITCyc2Jnmj3tKI2I0Nrx6dUSpZnzDhoWUID437R
 pUf5a5Aj9G3VF9yLnKqr5rcsW638oepe3VYwGB2NsK3epGlaniN5qaNCRtNDScGMd/blVDoE9Cc
 rgaWpV4887W4scDEn4082+mQ
X-Google-Smtp-Source: AGHT+IHiRVcWPVz/NaWHKsYGxSL73AbbS3K83S2C45ZvFuI1JeO+4zye8mjmA18vKKXcigiwE6KRfQ==
X-Received: by 2002:a5d:6d09:0:b0:38d:d414:124d with SMTP id
 ffacd0b85a97d-38f24d74196mr9250091f8f.19.1739541665009; 
 Fri, 14 Feb 2025 06:01:05 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:01:04 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH 07/10] lib: time: hook uthread_schedule() into udelay()
Date: Fri, 14 Feb 2025 15:00:22 +0100
Message-ID: <20250214140031.484344-8-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214140031.484344-1-jerome.forissier@linaro.org>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
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

Introduce a uthread scheduling call into udelay() when CONFIG_UTHREAD
is enabled. This means that any uthread calling into udelay() may yield
to uthread and be scheduled again later.

TBD: check if udelay_yield is really necessary.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/time.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/time.c b/lib/time.c
index d88edafb196..55e41c92210 100644
--- a/lib/time.c
+++ b/lib/time.c
@@ -17,6 +17,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <uthread.h>
 
 #ifndef CFG_WD_PERIOD
 # define CFG_WD_PERIOD	(10 * 1000 * 1000)	/* 10 seconds default */
@@ -190,6 +191,10 @@ void __weak __udelay(unsigned long usec)
 
 /* ------------------------------------------------------------------------- */
 
+#if CONFIG_IS_ENABLED(UTHREAD)
+int udelay_yield;
+#endif
+
 void udelay(unsigned long usec)
 {
 	ulong kv;
@@ -197,7 +202,17 @@ void udelay(unsigned long usec)
 	do {
 		schedule();
 		kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
-		__udelay(kv);
+#if CONFIG_IS_ENABLED(UTHREAD)
+		if (udelay_yield == 0xCAFEDECA) {
+			ulong t0 = timer_get_us();
+			while (timer_get_us() < t0 + kv)
+				uthread_schedule();
+		} else {
+#endif
+			__udelay(kv);
+#if CONFIG_IS_ENABLED(UTHREAD)
+		}
+#endif
 		usec -= kv;
 	} while(usec);
 }
-- 
2.43.0

