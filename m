Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA87C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6756688AD0;
	Wed,  1 May 2024 04:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pws2P0pX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC1F88ACD; Wed,  1 May 2024 04:43:45 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6323488A7E
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-790f91b834cso232575185a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531421; x=1715136221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANjz9MKiNs7c7j57Bo4z9o4rRUiU2SLk/EkyXNZVgiE=;
 b=pws2P0pXDRyn0JN+3/BtASk+ppLC3qodVQmGLogttbadKXN7dR2R1+hw3W90hzlHc2
 dJF13YUjgFG3EWJZOxu+hHFyLn70jZJji8q+swDtTLSY8sB0nCJ9F6poySPxej7a7oJd
 au4obawe+3HWBXT2MwP0Dr2Cp8g7kzAUz5tVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531421; x=1715136221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANjz9MKiNs7c7j57Bo4z9o4rRUiU2SLk/EkyXNZVgiE=;
 b=WWLkoWUYGLpeElz79JXWz8ghy9CtpaC4+R81dN9jgMhxrnqLqzVNnRXBeXaacXK5vO
 ENgeyogygvzLci4cUvQvBVURIJQ0LSyDMQjTsN48j2UTtjLm0U1b8EHoB9Cr4huA298Q
 pwONREvoAZPc2Q1jFYFNKlPrPlNPTkh8KrqL74/xtruM5lPIX9Scp/F6lUtJa4qCQrGJ
 fJF4SUZVVGJuBARFKasRq43HWh1zzwfIeTV3BtjbeE/n0+P7X9KILGSGuWJr9GgCTqjn
 VWDQ+oF6jcQzyq0P/hAnq5A7zy7VIAjTpOAKrK9hPe7vCI4Aqho33t5WAHlkKCHnGgYp
 f4/Q==
X-Gm-Message-State: AOJu0Yxf6EjGXuvSvNWJctlX5Ftv6x98CbvUaot7QCjLGE7zc8S454x/
 ZjNV2KEG7BxLMQtKXDocQ8Q5z+o8vhtFZ2hcFKQeT6aJRW8JzkTk1e1+u3QiosAQzXHkYT5zaT9
 UCg/H5w==
X-Google-Smtp-Source: AGHT+IEaAFhUwwuSkVLa/UCL5hfppj+2c9gQxBd9IqNgPkgeJw2xUzMhXh3Wj9x5W2ZBtAFULye+bQ==
X-Received: by 2002:a05:6214:27c9:b0:6a0:d20e:5478 with SMTP id
 ge9-20020a05621427c900b006a0d20e5478mr1496279qvb.2.1714531421080; 
 Tue, 30 Apr 2024 19:43:41 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Xueliang Zhong <xueliang.zhong@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Usama Arif <usama.arif@arm.com>,
 Kristian Amlie <kristian.amlie@northern.tech>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 David Feng <fenghua@phytium.com.cn>, Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH 019/149] board: armltd: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:06 -0600
Message-Id: <20240501024316.1767971-19-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Xueliang Zhong <xueliang.zhong@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Usama Arif <usama.arif@arm.com>
Cc: Kristian Amlie <kristian.amlie@northern.tech>
Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
Cc: David Feng <fenghua@phytium.com.cn>
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
---
 board/armltd/corstone1000/corstone1000.c   | 1 -
 board/armltd/integrator/integrator.c       | 2 +-
 board/armltd/integrator/timer.c            | 2 +-
 board/armltd/total_compute/total_compute.c | 2 +-
 board/armltd/vexpress/vexpress_common.c    | 2 +-
 board/armltd/vexpress64/pcie.c             | 1 -
 board/armltd/vexpress64/vexpress64.c       | 2 +-
 7 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/board/armltd/corstone1000/corstone1000.c b/board/armltd/corstone1000/corstone1000.c
index 01c80aaf9d77..3ad77f51949f 100644
--- a/board/armltd/corstone1000/corstone1000.c
+++ b/board/armltd/corstone1000/corstone1000.c
@@ -6,7 +6,6 @@
  */
 
 #include <blk.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <env.h>
diff --git a/board/armltd/integrator/integrator.c b/board/armltd/integrator/integrator.c
index ad02cf16da5e..eaf87e3bfe30 100644
--- a/board/armltd/integrator/integrator.c
+++ b/board/armltd/integrator/integrator.c
@@ -16,7 +16,7 @@
  * Philippe Robin, <philippe.robin@arm.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <bootstage.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/board/armltd/integrator/timer.c b/board/armltd/integrator/timer.c
index 9db5135a8ffa..f4101b649e30 100644
--- a/board/armltd/integrator/timer.c
+++ b/board/armltd/integrator/timer.c
@@ -16,7 +16,7 @@
  * Philippe Robin, <philippe.robin@arm.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <div64.h>
 #include <time.h>
 #include <linux/delay.h>
diff --git a/board/armltd/total_compute/total_compute.c b/board/armltd/total_compute/total_compute.c
index 53941b5f5f28..e1b4f49d044b 100644
--- a/board/armltd/total_compute/total_compute.c
+++ b/board/armltd/total_compute/total_compute.c
@@ -4,7 +4,7 @@
  * Usama Arif <usama.arif@arm.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <dm/platform_data/serial_pl01x.h>
 #include <asm/armv8/mmu.h>
diff --git a/board/armltd/vexpress/vexpress_common.c b/board/armltd/vexpress/vexpress_common.c
index 763131c217e5..6c374e25e32c 100644
--- a/board/armltd/vexpress/vexpress_common.c
+++ b/board/armltd/vexpress/vexpress_common.c
@@ -15,7 +15,7 @@
  * ARM Ltd.
  * Philippe Robin, <philippe.robin@arm.com>
  */
-#include <common.h>
+#include <config.h>
 #include <bootstage.h>
 #include <cpu_func.h>
 #include <init.h>
diff --git a/board/armltd/vexpress64/pcie.c b/board/armltd/vexpress64/pcie.c
index e553da86e0e0..1045c905f732 100644
--- a/board/armltd/vexpress64/pcie.c
+++ b/board/armltd/vexpress64/pcie.c
@@ -5,7 +5,6 @@
  * Author: Liviu Dudau <Liviu.Dudau@arm.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64/vexpress64.c
index ee65a596838a..0119f54f0df8 100644
--- a/board/armltd/vexpress64/vexpress64.c
+++ b/board/armltd/vexpress64/vexpress64.c
@@ -4,7 +4,7 @@
  * David Feng <fenghua@phytium.com.cn>
  * Sharma Bhupesh <bhupesh.sharma@freescale.com>
  */
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <init.h>
-- 
2.34.1

