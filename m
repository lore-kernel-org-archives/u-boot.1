Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD80CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92068352B;
	Wed,  1 Oct 2025 22:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZirAU3DZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8B5836B8; Wed,  1 Oct 2025 22:30:55 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DFC836AC
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7bc147fd11bso167056a34.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350652; x=1759955452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EHEoLUf80+8DLp+9bkIRAL198mWiVX9d1lQLsz5q6qw=;
 b=ZirAU3DZ9MnrLYPzSzQdnczNvQiu6AQS/HZeJo9JW571Cb+rNk8Km3xcqojkEsep8a
 MT7aLL9S7ecp6sXyxQ7FIk0jcsLh1B1ULkC8IgzNAif7YgzSVORER4lhVEKTJcT1npmX
 ckLpI9rcl0qE5IZDDGjl2qmGUkWHDSX9+LM2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350652; x=1759955452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHEoLUf80+8DLp+9bkIRAL198mWiVX9d1lQLsz5q6qw=;
 b=MBPK77HeDlRs3G0ouyOtoSLUg36w0LT4Hnf6SR8TFwpbuen910L/RrcMqT6vGAlBOE
 mLo8twSEBbJdrW7nVxZZwIi3MIAwlyHGW3uzwZtozeb9E6Vnma+1qo7qW+TbVlP3mDU9
 HXkZjowPp7BbiEkQLMs2vT7awb/YpMNVAJ6yDGkj/udJdeTnpjl/JWz94lqfXXGGbtbA
 ybnQpeMbs5muTsDMiXcnQIQA1YkrFDUWOOXYO2OtxWu8kR85AW6cVtYjWy0lYkGmjPzq
 WSbOlC+z+4pBJZWNDnrozMyuq4o8FTD+KLRRm4aBJM5OQe2UgUYAhDTO+hHc/FM9FNq4
 SAXA==
X-Gm-Message-State: AOJu0Yz8ny659sc18DeMvNgYXeflaarRlBKnMIOt7GU6BsUSFahci0rp
 LCyNqmWty/kAZSTLSLHBDHp7P2WqMloC8ZTrqB+dbrIWVwQHfczmaY5ETdBPFJjdANmPPV/ztrh
 Wj4Dqzcg=
X-Gm-Gg: ASbGncupuC3vIraVLfBtoLqIzFgUSmqp0JPARlMlaVyNyUDevU9cOj1ReljFeeiu57m
 lwN1E+bDo0btcwqYSj0U6GV0/CGGQ15xZasMQklfc2TAUrE9LyiHtwjwrJPlifiwUpADb+lGOEW
 6orPiyFrXr5dCIWiZyCJuxECbcG8b/SE7r7m8PpWcmgkdBZ1soeUPemvKfWOB86EeGZEpRjApWB
 uApbSfBPBvFbMIJuovJZuD580takIZmCtpkovVU+GqBnLFy2EJlk7nUxBlSEeFyTIfFBBwV5eF2
 sm/bmrBkqmNdlcqskhGc509jk3J2mv5o6g+RFsDVlr83WcOnmp0oGu1jBmvlDsUoGbqJMzVTdwN
 Sh1pu44AEYALkdjr70XYKiBfIoUBXIO4tHt8U7Q+yJx4uZihCv/0eOsspwOEzII4r+zw/VOzEfS
 lxBKEXQ+c=
X-Google-Smtp-Source: AGHT+IEBiA2gEuKno1NCa+BjPKaoZC25X2RWA+VEzN8oPvvsEhmWEcB/Lg2Sr4oOGTwxKZN6DmUyfQ==
X-Received: by 2002:a05:6830:631a:b0:7af:353b:95f0 with SMTP id
 46e09a7af769-7bddb6029c0mr3029956a34.26.1759350652162; 
 Wed, 01 Oct 2025 13:30:52 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf43028c25sm115507a34.19.2025.10.01.13.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] uthreads: Make use of CONFIG_IS_ENABLED consistently
Date: Wed,  1 Oct 2025 14:30:50 -0600
Message-ID: <20251001203050.2828452-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

We do not yet support UTHREADS in xPL phases. However, we have the need
to dummy out certain functions so that xPL can build when full U-Boot
has UTHREADS enabled. Update the few places that need to use
CONFIG_IS_ENABLED so that we have the correct dummy in xPL.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/uthread.h | 4 ++--
 lib/Makefile      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uthread.h b/include/uthread.h
index 11a19aa94882..78dab77f196f 100644
--- a/include/uthread.h
+++ b/include/uthread.h
@@ -72,7 +72,7 @@ struct uthread_mutex {
 
 #define UTHREAD_MUTEX_INITIALIZER { .state = UTHREAD_MUTEX_UNLOCKED }
 
-#ifdef CONFIG_UTHREAD
+#if CONFIG_IS_ENABLED(UTHREAD)
 
 /**
  * uthread_create() - Create a uthread object and make it ready for execution
@@ -184,5 +184,5 @@ static inline bool uthread_grp_done(unsigned int grp_id)
 #define uthread_mutex_trylock(_mutex) ({ 0 })
 #define uthread_mutex_unlock(_mutex) ({ 0; })
 
-#endif /* CONFIG_UTHREAD */
+#endif /* CONFIG_IS_ENABLED(UTHREAD) */
 #endif /* _UTHREAD_H_ */
diff --git a/lib/Makefile b/lib/Makefile
index 2643bfc867cb..7a44babffaa7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -159,7 +159,7 @@ obj-$(CONFIG_LIB_ELF) += elf.o
 
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
 
-obj-$(CONFIG_UTHREAD) += uthread.o
+obj-$(CONFIG_$(PHASE_)UTHREAD) += uthread.o
 
 #
 # Build a fast OID lookup registry from include/linux/oid_registry.h
-- 
2.43.0

