Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B45109C058
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E3D84082;
	Wed, 25 Mar 2026 20:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="imaumnYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2AE8409B; Wed, 25 Mar 2026 20:00:39 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C505C83FD9
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so99146fac.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465236; x=1775070036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ngy9pGLHtJDmvkCQ3+Tzm+RJV4I2wMRe/dxTtHL9v50=;
 b=imaumnYuOlc5QRQJC+hBpLmmd8+NQDPgnKL8/OEsvoIpKHKwyJWyUQCjT5acIgH/gI
 6Z6Al+diEet5zmC8GMaxAw+snHpf0tnEm0TFdOOId7oUOhYg7W3XQJb0ColsdLTaU0w3
 GMveiLHQG54sIs5007gCjsKWshpTUpZAb7Qj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465236; x=1775070036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngy9pGLHtJDmvkCQ3+Tzm+RJV4I2wMRe/dxTtHL9v50=;
 b=UYsIyU9LwN+MsllOHFSm8Vymd8QlDNkX55jC0G+5nketAJTDXRF1Sx8mwuZM2HU/XU
 JIvbmzqTdIwpfPRPQ/Z0XVunIBsAKRQHtaNAg8zV2XUrONaKv3GtwxT37I6AoFJJtezU
 CM6IuLkbjnKK2swpxIax8qtdTxgRlFWYt4uVZ3Jhy5G1EaAAnYKqW1PkNpjcCk7bGCDc
 fNmnv3jFuTwDKcuHTFIEFC9awWRE/Kw3M8FFYcR+3IhCT09NN+4O/e1GKzO8dZtBWiQr
 WJ3UEXyIglO6tbVEJFNupA2EOEYi+XZGGoPmdZeTuAUKEfP6yMj8K83ZIjbES954MlFW
 SxCg==
X-Gm-Message-State: AOJu0YwBt8m3weoAdWPUrSvrE8OI6WG5hnT2HnkJ4hb/FIeRfGZYVwv1
 Hz01DAg/12irLTpMm+xQEvL209IP/5x/JBB9C/eHtqUwbKrhCAqmUwW3ghV6dk6GXqL3HWN7PjL
 A3dUH
X-Gm-Gg: ATEYQzz69PuPSPdRZJ9/naxh4hG0uJVvUMbNexDP/WB+q+9j2TbF+YKxpI2c30VkmKX
 k3h9O7IEFB/jIZfo1gCBGEcLaAa7Oyy2xOZEiFWomcsRMtu9EhHJ9FJ5VSbYs/Rglg3F0nti8Fw
 Mq5gbewy0/1J6rJBMuiEkXG20c2ZCwfENM39/i1eFbK87xSGz3neKaVpaOUciqOpdqAIWmW7ekJ
 UJCKYX98ODxdrnpNUgfV+QnMgunbkjN5ihjwoGXqG4VSkSEzFmgoD9lYIRa7LO7z/RjAumqgGZb
 b6YRGMFS22lJX+XPEu7RShyYfWLLzjD2S7zCj9VmvXrLcCBqsVzMnSV0xXIo15/HAYBoJcxZky/
 fyzvvq9Uykbzp0e5fgzS4dFyTsf6FXCLNEKg2SiQi7Dq1pHMd4Dj0PQJsqMMCh+pWfOTJlUxvId
 RwyY/u9yMvrXDOR+1hrXwQilCPTxXaqDB6PKrdOuHsu4vIxM7Q80Deo1/L/wLQoMgEQKC/23X4u
 GXuiTkaOVycGTCGHff3L5TYi8ex8BTWsVDPy3Rt/wKuWOTML68=
X-Received: by 2002:a05:6820:138b:b0:67d:f40d:14b6 with SMTP id
 006d021491bc7-67dff531ff3mr2608307eaf.41.1774465236309; 
 Wed, 25 Mar 2026 12:00:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67e0a9095c9sm462388eaf.0.2026.03.25.12.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH] osm-s-mx93: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:34 -0600
Message-ID: <20260325190034.3428684-1-trini@konsulko.com>
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

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/osm-s-mx93/osm-s-mx93.c | 5 -----
 board/kontron/osm-s-mx93/spl.c        | 2 --
 2 files changed, 7 deletions(-)

diff --git a/board/kontron/osm-s-mx93/osm-s-mx93.c b/board/kontron/osm-s-mx93/osm-s-mx93.c
index b6feef549d16..02bee34ac663 100644
--- a/board/kontron/osm-s-mx93/osm-s-mx93.c
+++ b/board/kontron/osm-s-mx93/osm-s-mx93.c
@@ -22,11 +22,6 @@
 
 #include "../common/hw-uid.h"
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_KONTRON_HW_UID)
 struct uid_otp_loc uid_otp_locations[] = {
 	{
diff --git a/board/kontron/osm-s-mx93/spl.c b/board/kontron/osm-s-mx93/spl.c
index 23a90e351fe9..a47fc43c6aa9 100644
--- a/board/kontron/osm-s-mx93/spl.c
+++ b/board/kontron/osm-s-mx93/spl.c
@@ -132,8 +132,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	board_early_init_f();
-
 	spl_early_init();
 
 	preloader_console_init();
-- 
2.43.0

