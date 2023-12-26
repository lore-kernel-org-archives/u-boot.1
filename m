Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ED3C3DA6E
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 02:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1880B8783F;
	Tue, 26 Dec 2023 03:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UsRQKbho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DACF87841; Tue, 26 Dec 2023 03:00:22 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B0587835
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 03:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28c075ad8e7so2373469a91.2
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 18:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703556016; x=1704160816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f4ltcSGErZFka+/OGiz4sB4DHWUFHZNXHo6e2VXQ8Oc=;
 b=UsRQKbhozsEPV9lsKfqHu5XSx7nCM4AbZtsJoWapYPmA/tb8rDPNoo02blUp55jIjN
 XMWOkkyK2stSKxtV/g0YtR4jMBLwwJw3dgbG0fn13nmaPW4pYxGOLAr2Xtn5eLKElHRh
 LixTB1qu/razkuxv2jROSvuxqwvJrtO6KF/0XJP0XOoC9ASosYxV8ssAYy5EMo4qDhCb
 wrbrd0aflBH9bM1jyk5i8JREUl3FVjfAI0JxGq9psznVgK6zKgem+pMfdyeaCapdxdrd
 RgWO3sIr+w9Si2XzgYvq8Cnd5aFGiJ18IqL1g9/RyxLiR14aQREUiJJFEQiuFp6DUuIC
 v2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703556016; x=1704160816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f4ltcSGErZFka+/OGiz4sB4DHWUFHZNXHo6e2VXQ8Oc=;
 b=qsQP/zU1Cfq724VjvuFTDXLvgmpQaXM6MlY9HhyeWxUBor5/HjcmMNI1YbPPvQW3Km
 E7lw02HGOjaNbRXrA+nZrXBcPENnstn38+jLRiChAvOPSgVUuh0mMsoJJu00jENjWSJc
 nF0Af0Y0Qt4RUr0Dv06WbJCnRCXRk73Sh4Ir4A9RjZgXZUAdRZIF0Tf3GjnIgbpHgTpk
 3jdlMcHAGSZoIEdTqKlr/qCbeKC8tXLej1hVZbW+zUzxY1cM9rmPsVK1NYz5ABOniNqm
 mLfHXymmz3bduf5ZvGErl2qDF9boToiSZ/w5+To62/J22iVeoreUXsDPjGKohRShA+q6
 RawQ==
X-Gm-Message-State: AOJu0Yx8S91u+vlDEMqxxjshNe1UFeY8kdEWMpd+CohBFRl2ao15NX6U
 KSbe38pTna1DQne9+B1zQe8=
X-Google-Smtp-Source: AGHT+IHW7pqr6eQ5IfdTqs6klcxfWIBCBmuPt3G8Il1xn3Gu2H0M46G0L9jsvjZGD3XvdrC10PdE8Q==
X-Received: by 2002:a17:902:ea91:b0:1d4:1199:1cbb with SMTP id
 x17-20020a170902ea9100b001d411991cbbmr5597598plb.98.1703556015506; 
 Mon, 25 Dec 2023 18:00:15 -0800 (PST)
Received: from localhost.localdomain ([1.200.140.173])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a170902ec8500b001d3ec9c727asm8819325plg.115.2023.12.25.18.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 18:00:15 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, jagan@amarulasolutions.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] spi: npcm_pspi: Fix the wrong clock divider calculation
Date: Tue, 26 Dec 2023 10:00:06 +0800
Message-Id: <20231226020006.1052698-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

Fix the wrong clock divider calculation.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/spi/npcm_pspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/npcm_pspi.c b/drivers/spi/npcm_pspi.c
index 37bab70967..eb14185273 100644
--- a/drivers/spi/npcm_pspi.c
+++ b/drivers/spi/npcm_pspi.c
@@ -144,7 +144,7 @@ static int npcm_pspi_set_speed(struct udevice *bus, uint speed)
 	if (speed > priv->max_hz)
 		speed = priv->max_hz;
 
-	divisor = DIV_ROUND_CLOSEST(apb_clock, (2 * speed) - 1);
+	divisor = DIV_ROUND_CLOSEST(apb_clock, (2 * speed)) - 1;
 	if (divisor > MAX_DIV)
 		divisor = MAX_DIV;
 
-- 
2.25.1

