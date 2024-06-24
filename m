Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D468AC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A29718854E;
	Mon, 24 Jun 2024 23:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h9rBp0hj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870AB883FA; Mon, 24 Jun 2024 23:46:47 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2F4883DE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57d1679ee83so5041566a12.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265605; x=1719870405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AIU53hSikLVwOMMuoG7NRsRB4FSSbFj6q5GKvhgjA0s=;
 b=h9rBp0hjYCiMHvn7GoVcgGSy9ObPwYZWTVq2BVWU59bT0dg6r8pfF+g9T0IFJZta2A
 uqZg3hh5PAZ/z7f4gvvCkbJ1sXpGgMN0bwFYN3xtIUCuYVWFCI28u1MeEmqR4SIAZsq8
 9VByINH7baXLI6GON0PcW3EPa+/YTIbquERPx8h7d3zxgN55+zSrITEY1t3bxUKJF65J
 TajDSUjkTv5WaPzy6wQKCVAWVGWVdHlMln30U+2J+1tvUjFpOoGS6HEyhXW8H8VgK/S9
 S4q4sFIiwN7g9wFWo9XiuRWD8J2g0jQ2/J6SxuluJUUArMwp+0vV9aF7CqQ9C+msmyvm
 0ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265605; x=1719870405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AIU53hSikLVwOMMuoG7NRsRB4FSSbFj6q5GKvhgjA0s=;
 b=d8zRRv/VextMpq4JUsxFquvL4YPHLhJl5Ja84VZRolAOG9HbNwabdCO6/k9daqSM+W
 tRlRJ6cQfdSkSDgfK3d9YIF1AmDJ6kxm+y1fbN0ZCB9ZcYcU/AR926/Y4qK30aMzg9WA
 9QUAUVwSWaOMUfGc/7b3cZYWpVIavZtwiozUa6AE9aR4mk0xe03bYZAV9kinvR5gCTHO
 adwYZCKxfISr6g6Zkawvf5Eg50kfFU2/lgY81OYF3q2S5bnAfgfcLUGWMmcTP63sUJ38
 XGb/bUcMGJHUIZUuZVKW+0dAmad1uEOtUXRAwyAMRiXN+V0HnM79d0Dvjy52QvjCGZBH
 NP1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIJTZw+KPvQgsVoUh64ss5Wyb3NzLkjCKmfr/VsFDpOaB1n8cKljzpbQCmuKbLwMDTXE4r0A4TZtSK568Q1Q0a88QDTw==
X-Gm-Message-State: AOJu0Yxekh8nI37jgNsjKJLkLvm+PPVf/quZqdF24RK5Z8/z727AvbiE
 r5zeKSEJFn/VIsC6c83WC8Si0oJSuNu70B+vjjkr7DFhYDjWWrQ+
X-Google-Smtp-Source: AGHT+IHqv9oH+a9vkvc+cDxlUsrY7ns3Qi/eaffm/B7Ey5+S3GMOg50Y9EslZswbeDeXmh53srOnxw==
X-Received: by 2002:a50:d50c:0:b0:578:676e:324 with SMTP id
 4fb4d7f45d1cf-57d45791fc4mr4007615a12.17.1719265604953; 
 Mon, 24 Jun 2024 14:46:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 8/9] ubi: implement support for LED activity
Date: Mon, 24 Jun 2024 23:46:18 +0200
Message-ID: <20240624214626.24336-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624214626.24336-1-ansuelsmth@gmail.com>
References: <20240624214626.24336-1-ansuelsmth@gmail.com>
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

Implement support for LED activity. If the feature is enabled,
make the defined ACTIVITY LED to signal ubi write operation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/ubi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 8c1b5df0572..984be3da4af 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -14,6 +14,7 @@
 #include <command.h>
 #include <env.h>
 #include <exports.h>
+#include <led.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <mtd.h>
@@ -416,7 +417,19 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 
 int ubi_volume_write(char *volume, void *buf, size_t size)
 {
-	return ubi_volume_begin_write(volume, buf, size, size);
+	int ret;
+
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_blink();
+#endif
+
+	ret = ubi_volume_begin_write(volume, buf, size, size);
+
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_off();
+#endif
+
+	return ret;
 }
 
 int ubi_volume_read(char *volume, char *buf, size_t size)
-- 
2.45.1

