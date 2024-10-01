Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D83CE837A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A6E891F1;
	Tue,  1 Oct 2024 15:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RlIVaQcs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1419891B9; Tue,  1 Oct 2024 14:26:02 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08ED891BC
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cae6bb895so49849565e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785560; x=1728390360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yrY02/Cm8d9n38NZza5Im9msXWb18el/IUfYhYeq94Q=;
 b=RlIVaQcsYGyHSVfSAlOt4vyqCzF0yjY+lpkyEFveEDE97t02wQh/TIhL4+BCxLEt3L
 u0st7V8PSOQoxxmKbdi/VjQH0s8o2ieBymv6zvlagkvP3l3v4/vwrf3VIBEmlzO0UawE
 ViENFFuXJ+SOddkwh3TKCLjBDtB2qPKniI5hXOCVCSy//NxK9Iuo7lu+zcyHaBxNrkD1
 vmnYrby/aL8aNHLjdGvuvzz/xn2w6NyFubOZUd7rNl/xLNJRxgkvto11cc675TNvGCCU
 q9NSymuH+RVnEhEpdEo6npR9EJFh279ewUnwJEgVgseJPOIPoeI3VlJJ7Y7s6sFj+UuN
 4OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785560; x=1728390360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrY02/Cm8d9n38NZza5Im9msXWb18el/IUfYhYeq94Q=;
 b=tsGlmY5V3z+NA/rAjYMt9od0ffV9iL7tvAm1EuzamZDea8b89mngNpacCmA1U15r3C
 EH1VDjMnn5lk1l1uK0vs08dXvI11hK4jJyMSspI441tUmzuFQk+fvYGYFmVcdyEJbSYn
 x/D2ZdZ4oQw5Dnr51Dw2CVmhLVMnyVrO6HcVA4CtbYUiU0QQ19SnU0wIjpeSnRAXMmja
 ZCbqMYwDmsTL63LxBjh7sitrZJOLh8HG3L3AhE5oSKMqW0tjGteoyXm8X8lGqNuTl6QG
 ltgmELNXU2M+S+JpBPYQOrEmHo1cqQY+Ipc4+nyCWE/nZPJRUio2hvR5k5D6V0TVouHo
 wk3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBS5IS7qFSMXq5or3Lxwt2OQpxyV/9Ml5wo83qMlBF9/0bd68YL4jMwvznvs1C12ekr9AzUUo=@lists.denx.de
X-Gm-Message-State: AOJu0YzNnAoQsjTAIZDV8i65POUYp6vg/bS5LFH9W2oCHY5oxs0N/ncW
 q/Q0EwxTuuglFu/uvuge1g3GhOJMwNzwIBMSni9lCQku55zw8qyD
X-Google-Smtp-Source: AGHT+IEfmlkk4GdIfmKJMDt1VRVZJEERDHA2DcH3u3y8eVWLp3+0YywcUEOutSk5yOLqS+5rodhsrg==
X-Received: by 2002:adf:efc3:0:b0:37c:d0b5:6c16 with SMTP id
 ffacd0b85a97d-37cd5aec965mr8854036f8f.46.1727785560164; 
 Tue, 01 Oct 2024 05:26:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:25:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v5 08/11] ubi: implement support for LED activity
Date: Tue,  1 Oct 2024 14:24:41 +0200
Message-ID: <20241001122511.8832-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/ubi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0e62e449327..56d7da82629 100644
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
@@ -488,10 +489,18 @@ exit:
 
 int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
 {
+	int ret;
+
+	led_activity_blink();
+
 	if (!offset)
-		return ubi_volume_begin_write(volume, buf, size, size);
+		ret = ubi_volume_begin_write(volume, buf, size, size);
+	else
+		ret = ubi_volume_offset_write(volume, buf, offset, size);
 
-	return ubi_volume_offset_write(volume, buf, offset, size);
+	led_activity_off();
+
+	return ret;
 }
 
 int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
-- 
2.45.2

