Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D66BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD15488A85;
	Wed,  1 May 2024 04:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="odoXEwB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF97088A85; Wed,  1 May 2024 04:43:25 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B38588A7B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6a0b4622ea0so21037776d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531401; x=1715136201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V8lqXF+UvbQPRASJpQG4rn8egqRPFI9XnB8oim/ZVk4=;
 b=odoXEwB3ev1JCM5nfCKON+u02NYo8jlC+fTlGJ73Jvx2hcjm0y2m8NGZu0WpLyYWGZ
 LlRMN8iKqKnKaoeuJwM/IYZqCGT2xcyxGrpyt8qa5GD8ymZiLCRFruxvf01F1Na4/uVt
 S0k6d1XLhOb/tQ5PL2+YgRFwUO9/9yMGMo/3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531401; x=1715136201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8lqXF+UvbQPRASJpQG4rn8egqRPFI9XnB8oim/ZVk4=;
 b=HKqXgoKyM7MpTNB+knu30I/zgsHHaTzwpHoxfPsHw9fXJTdIRMIl0NEOcju30xjrKL
 eVDGdOmLBYl46onrc879RpRAStJqCzwA3LHcSKq9l320oJjwNB+VN+AaC5/rtRtzqKuu
 8XSxf3Yy004JBBi1F25/WVTfOhOduXH4gGpHq4UzoVjHtTHzYEwxbkw4PUSrDk+KtcSE
 RZ94dfRQp70fvZpSaJ6lhY/h2OG2bwMYvP7Y/P7hScaLYiEQHv4PAtbvnhuHpEsSLl5/
 Q9Hp0yo3LGMS21wodDjKrutdNv68UtGGLzh1YxCUsO5TVt7wFudjriMbneUW3UIRRKAz
 1k9Q==
X-Gm-Message-State: AOJu0Yzt2RsXBRcZ2+NnKs6ZZFL5Py7s4LqMQ+7eTiSfHAbTlk9+ln1S
 cg3TtmM+Nl3yIBw0J0uwtXVbfS0aj4vMwiKahpu798wGAhvp/HNlAvyoxZqTmHCGW+xPKGWYMMK
 Ck5YR9w==
X-Google-Smtp-Source: AGHT+IH4xGt1uftrMbFUDbvJKOoCKwcQe41pLhkEwwFNDf20/TWxOJU0ONd/sB6wqyuChfOy8242kA==
X-Received: by 2002:ad4:5fcd:0:b0:69b:2515:4197 with SMTP id
 jq13-20020ad45fcd000000b0069b25154197mr1588057qvb.13.1714531401133; 
 Tue, 30 Apr 2024 19:43:21 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 003/149] eeprom.h: Add missing <linux/types.h>
Date: Tue, 30 Apr 2024 20:40:50 -0600
Message-Id: <20240501024316.1767971-3-trini@konsulko.com>
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

This file has many "Linux" style types in it, add <linux/types.h>

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/eeprom.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/eeprom.h b/include/eeprom.h
index f9c6542ba762..e223e4c76707 100644
--- a/include/eeprom.h
+++ b/include/eeprom.h
@@ -8,6 +8,8 @@
 #define __EEPROM_LEGACY_H
 
 #if defined(CONFIG_CMD_EEPROM) || defined(CONFIG_ENV_IS_IN_EEPROM)
+#include <linux/types.h>
+
 void eeprom_init(int bus);
 int eeprom_read(uint dev_addr, uint offset, uchar *buffer, uint cnt);
 int eeprom_write(uint dev_addr, uint offset, uchar *buffer, uint cnt);
-- 
2.34.1

