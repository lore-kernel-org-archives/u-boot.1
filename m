Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FF4C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B81988CF5;
	Wed,  1 May 2024 04:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z2Y0ywKk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88EB688CE4; Wed,  1 May 2024 04:46:06 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A8208804F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7906782388aso434003885a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531563; x=1715136363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnPV4fcEVnkYDa7+n/jynQTy6bMrCHul2abw0WcTt5Y=;
 b=Z2Y0ywKkq6kyMCZkIk1/nfcel/SPOvlHAykDC0TVescVHudU31v9AQad0zrng7VllU
 nEQ8EQPlg+696/hdAvTUjT8LKOL+Ir8oWhyKwEPxPS3pvNYGxudONjK4+72YPSFQ6QEO
 nnnGYDXutLfUB6vZfNkbKIkp4E6O1G7fi6cEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531563; x=1715136363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnPV4fcEVnkYDa7+n/jynQTy6bMrCHul2abw0WcTt5Y=;
 b=v6CcbnyqOQ5Q7JPaXOtsyGKgoYyrm9aVx3SC7CsRqSiL4PnOiNrInkx93qBnIvGw6D
 e0LxrY+43MATPwsEFrpI6d2gtQOke+3qk6troZVkEa4PZior5duq1mlGC9jtw+I3dMI/
 ZRO/WDks0Lv+KWWXtQ6nxJplggSSes3KK1zJHr6oRBhig9lpXl955lCkiPbWWeW5J/r5
 NpnSPpLDdBhWFS7FO6BRPeoDsI4FDdpW8ccfyayFetuy7j+p90tE5CFmb0d0ycieBoL1
 vGL0S/VJwRj3/8fBOcFOjEuoH+3wy/7tnqspCuF0E0XwymHEXPzpKma3DZ5WQb+8XvrU
 H05w==
X-Gm-Message-State: AOJu0YyqNLMj1mOmhgEzhTViTPq8UDxnIa1apDoTGLtLmLwNyq4wVUkz
 3PfByb97ev8ky0XpcMZrQn8EBbTEwHNqNBN0SNDGAAqNmBs5L+0ogKOA3MkrzIKLd7lMorc3AEa
 vm2PjGNOS
X-Google-Smtp-Source: AGHT+IHp0rpAMprF1s82rPgPw/x/9EoQOf0Q5nzYIsQybauzaApeMzhqzX4P12l6AQYim8kHoN9NYA==
X-Received: by 2002:a05:6214:2627:b0:6a0:a7c7:4d5d with SMTP id
 gv7-20020a056214262700b006a0a7c74d5dmr1434726qvb.58.1714531562920; 
 Tue, 30 Apr 2024 19:46:02 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:46:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Albert ARIBAUD <albert.aribaud@3adev.fr>
Subject: [PATCH 146/149] board: work-microwave: Remove <common.h> and add
 needed includes
Date: Tue, 30 Apr 2024 20:43:13 -0600
Message-Id: <20240501024316.1767971-146-trini@konsulko.com>
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
Cc: Albert ARIBAUD <albert.aribaud@3adev.fr>
---
 board/work-microwave/work_92105/work_92105.c         | 2 +-
 board/work-microwave/work_92105/work_92105_display.c | 1 -
 board/work-microwave/work_92105/work_92105_spl.c     | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/work-microwave/work_92105/work_92105.c b/board/work-microwave/work_92105/work_92105.c
index c8e791a4da8a..9a236880e3cc 100644
--- a/board/work-microwave/work_92105/work_92105.c
+++ b/board/work-microwave/work_92105/work_92105.c
@@ -6,7 +6,7 @@
  * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/work-microwave/work_92105/work_92105_display.c b/board/work-microwave/work_92105/work_92105_display.c
index 64dd5d4072a6..d4ab2299895d 100644
--- a/board/work-microwave/work_92105/work_92105_display.c
+++ b/board/work-microwave/work_92105/work_92105_display.c
@@ -10,7 +10,6 @@
  * MAX518 I2C DACs and native LPC32xx GPO 15.
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <asm/arch/sys_proto.h>
diff --git a/board/work-microwave/work_92105/work_92105_spl.c b/board/work-microwave/work_92105/work_92105_spl.c
index d9401145f27d..3f91221ce8b1 100644
--- a/board/work-microwave/work_92105/work_92105_spl.c
+++ b/board/work-microwave/work_92105/work_92105_spl.c
@@ -6,7 +6,6 @@
  * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/cpu.h>
-- 
2.34.1

