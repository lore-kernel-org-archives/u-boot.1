Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92262C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B2083FCD;
	Mon,  4 Aug 2025 23:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hFwhmnuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8758E83B1B; Mon,  4 Aug 2025 23:54:00 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E39983FB2
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3e3d238b3a7so60898085ab.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344437; x=1754949237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IccEb2TkuCQJ0DL7L/vYGSIsALmOsK7ls3Z0pGzmz+o=;
 b=hFwhmnuosbVn62l5mSJYLAk9qUYr70nj5c/FDzfN4EBRe65PORETwuN67tZXgPGiur
 a6nzagIgN28CJ37oEbj3eJD0JzPCg7rO4boicc9F6tqDY7IqYJOp5o5wPwkOvCK+Pifj
 /4bR0/3H2G0dWDetju0iRyOmA9EnNfIGkthC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344437; x=1754949237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IccEb2TkuCQJ0DL7L/vYGSIsALmOsK7ls3Z0pGzmz+o=;
 b=s2ODngjLtIO45v0XEGcMvdhLEZ4PPgml4N9OEI3K5f7sMcTSL2QxPTJ3YljQBHnH06
 qmykcAdW6Opt0B7h9PNlIonWl+glp+UkuYt2yTchBlZf6+64kxnFE7bVMrh4GWlAcSl8
 /FsnQBkRMRMUujcHHZmBmM0D++exKLygFjB/2CtGhamfGssXvUn5CboLI8FUOfjnIQGI
 IjrSitT22JX5k4Wfia7rE2WoRG4AwfcpRKLaa5S7/YOnUHyYEFdQ2IxWOYEiPpi1XTNz
 2Pys4bbyIVfuzdxlSUep6nf9OoUhIevLlYnclTfuGt8bljO3uFXjn63PmQQv5f3UeOpZ
 aZ1g==
X-Gm-Message-State: AOJu0YzA+EZn1mi+z4cVg0SyotPeevOOfGai3qZuHJxcisX9nDU7mLPi
 BoQN2G6MB+NztRVAl4YMdNqn1j2r3rUnNCMSsK+M07RFpscxN/Ec6SSd6ML1+NY2vgqpPo25o2O
 gedR5CAY=
X-Gm-Gg: ASbGncsNHMirBpqFvzvq8f0++w6XiLHhyrrI9hWr/+rHeAxnCawB2U6UzkXEASzygXq
 3gvRYK8DaoDm+ysMccj4MtsHHy82PTjYEd0Z1FXlOImAgvLkkZgZ76wVUhZtH2LinStnEx6AACw
 ThtqoGnRVralg8rqq6aRAN0YugILOjt7fxwYPyY9Frht6bCVVM6vSkB3pnIBTZ/ZD/I2QQvoyNl
 ZazfxEGSeKA0kKF+Eejb5c2VH3Ir1DEF5vdLo5LyaPvvcaWrfClmMuo4SJl6oDKyJONdajMgSSx
 4O9kaiDuQL1ptFJdwWWaoK+CV8X/pwDjd4tcGG2vqypm4hpFRuqTzcLKpXDs0llo9iX9/wFqDhY
 s/xq2ilxOfZDpIt0/GPhuX0+b8eF5PIZS3d4G0VgZqRuiYmQyonDckk9HEmgUVc6wpfZW
X-Google-Smtp-Source: AGHT+IEkCvvClRFV85gyRWucqdZn3GNR1myp8hZVI9oxk7gSWxLkU1lPfeelcNjd3djvOExiLLxTZw==
X-Received: by 2002:a05:6e02:4701:b0:3e3:b45b:2c9 with SMTP id
 e9e14a558f8ab-3e4161d3f99mr188830745ab.19.1754344437081; 
 Mon, 04 Aug 2025 14:53:57 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e40297c3d3sm45998025ab.6.2025.08.04.14.53.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:53:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] pwm: pwm-aspeed: Add missing <linux/log2.h> to
 pwm-aspeed.c
Date: Mon,  4 Aug 2025 15:53:54 -0600
Message-ID: <20250804215354.1412604-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215354.1412604-1-trini@konsulko.com>
References: <20250804215354.1412604-1-trini@konsulko.com>
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

This driver references the logarithmic macros while relying on an
indirection inclusion of <linux/log2.h>. Add the missing include
directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/pwm/pwm-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-aspeed.c b/drivers/pwm/pwm-aspeed.c
index ebc9d9a89752..eefe018448f4 100644
--- a/drivers/pwm/pwm-aspeed.c
+++ b/drivers/pwm/pwm-aspeed.c
@@ -46,6 +46,7 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <dm/device_compat.h>
+#include <linux/log2.h>
 #include <linux/math64.h>
 #include <linux/bitfield.h>
 #include <linux/time.h>
-- 
2.43.0

