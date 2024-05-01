Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720A3C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C96C88AD4;
	Wed,  1 May 2024 04:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PZwwZ7S0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1031288A7E; Wed,  1 May 2024 04:43:48 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC0E88AD4
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-790605809cbso566058885a.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531424; x=1715136224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKTrvpq7oRAr/YeaIQPxmSGxP9TU4B4y23oS3fsc/kg=;
 b=PZwwZ7S0TxIXaaKhePclujYpJbm0erljOueQnsvlxWZmYZqP36sn7/LL9huhgnJBFM
 5bYfY2HlaHS2xNXidef2YKuelL9jKI5QFnle0+7p7qKN6R5J1HxEIwQtrllaGTx5/TTP
 IteTIgz1q4DaZxgRrWr/tK2onH6417VNPkR10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531424; x=1715136224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKTrvpq7oRAr/YeaIQPxmSGxP9TU4B4y23oS3fsc/kg=;
 b=WV6nAHwpCEk7N590tzV7vjtrfkGEjIQFBnLcT/hPYWnWzrtrlllMVbAhA/WtGTlDBC
 VyB69rLIOL+6OzaZ89XX7e+1icnf3/gj0NgYsY8NXPWz/6DElQIyTHnJ6w/hGbroQTZK
 OkoseV5RAusu6X18EP5agUT9fVytux4hnY7rMBW1K05Z7cfSw9DSxRLW+m0a8ecCpiBw
 L/jZSHpCVVbc3+rpprEDrRgIIc5nLc7/5cu4EVvLf9J7UVEjl9GrKHXuH3bRb9RfVDI4
 3w9KmEbEchaEecM8UqqbiZdTC8thc8jj63lY+nCFaIL9F+Y02KjJmtxnm3OZzDYJETf6
 6Ohw==
X-Gm-Message-State: AOJu0Yx4ADCl9DkFX2P21NZcHJohsdrrgM8ZJySd0Mfge1e72Fo8js5U
 quZHgX2pexWn48eUvTi+AkeE8HVSeDU31hQDGcSTuFgLYMrbzUrI1izNL9s+GEviSEO8wysbjlx
 nBabYFA==
X-Google-Smtp-Source: AGHT+IFjWIjKYrg5Ujhu7tKkPGc0CGRIJcgRSbuYgFqDQ9pHeTaoPOE1Emz0geK2TmWF+r77LxSfEw==
X-Received: by 2002:a05:6214:27c9:b0:6a0:cbe9:d73f with SMTP id
 ge9-20020a05621427c900b006a0cbe9d73fmr1491379qvb.19.1714531424567; 
 Tue, 30 Apr 2024 19:43:44 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alban Bedel <alban.bedel@avionic-design.de>
Subject: [PATCH 022/149] board: avionic-design: Remove <common.h> and add
 needed includes
Date: Tue, 30 Apr 2024 20:41:09 -0600
Message-Id: <20240501024316.1767971-22-trini@konsulko.com>
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
Cc: Alban Bedel <alban.bedel@avionic-design.de>
---
 board/avionic-design/common/tamonten-ng.c | 1 -
 board/avionic-design/common/tamonten.c    | 1 -
 board/avionic-design/tec-ng/tec-ng-spl.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/avionic-design/common/tamonten-ng.c b/board/avionic-design/common/tamonten-ng.c
index 29bde60228f9..e35bda814681 100644
--- a/board/avionic-design/common/tamonten-ng.c
+++ b/board/avionic-design/common/tamonten-ng.c
@@ -4,7 +4,6 @@
  * Avionic Design GmbH <www.avionic-design.de>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
diff --git a/board/avionic-design/common/tamonten.c b/board/avionic-design/common/tamonten.c
index 988f057a281c..4d7477237d44 100644
--- a/board/avionic-design/common/tamonten.c
+++ b/board/avionic-design/common/tamonten.c
@@ -6,7 +6,6 @@
  *  Avionic Design GmbH <www.avionic-design.de>
  */
 
-#include <common.h>
 #include <ns16550.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/board/avionic-design/tec-ng/tec-ng-spl.c b/board/avionic-design/tec-ng/tec-ng-spl.c
index 6e544641833e..250494524952 100644
--- a/board/avionic-design/tec-ng/tec-ng-spl.c
+++ b/board/avionic-design/tec-ng/tec-ng-spl.c
@@ -7,7 +7,6 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
-- 
2.34.1

