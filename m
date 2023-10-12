Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B06CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E98386D02;
	Thu, 12 Oct 2023 08:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lAPot0Pe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0BA86E5D; Thu, 12 Oct 2023 08:56:22 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D281B86CE8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-578b4997decso519690a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 23:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697093772; x=1697698572; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZV95OXYl3rUPHRAEjOe9AsTLKghDPJ9Dp3RZ7LMh2UE=;
 b=lAPot0PeFT5ar5yvZvnA4sK9UFQMJ8H+fpDfgCXRyEwsfKQYHeOD7nE39mQGFQUQTe
 brmnAI7sWZ9kWk4ugi8r7dmObFw6NmDcDuV0IT6SOEOwhCOsUYNN6VrCIyEoaeIIuGoP
 gMfMCrseiS0llAE1cTfXwR64EC80tNHGik6jQjqBC67nuV1fayLy6kkq0HRt+Cfd7r+Q
 EOEhm4f3GiNX44efDSHgsuregLRFQAMQFEdrJ+vkdosmpK3THuhtFC9E1NrVW79ljYuB
 B2ztflBbsfUGkGqVCvRtw7lhvm5yKmt3G5/IP0sw9w9dpC+xCF3FBOTWg2uAyfQu71Fn
 DmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697093772; x=1697698572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZV95OXYl3rUPHRAEjOe9AsTLKghDPJ9Dp3RZ7LMh2UE=;
 b=vH6KSVvpyM9JeIAdi85MqQbwy7ZxNtPXhhDVC7tmOQgIu+nnKIs05QGPYjPDD7K/tI
 pJxgc+Ve06M9sfkOg0ngLM6ARMRJWP4GxBeY4NSembwv5ELaLl3oJcAhqODLdg9X2Znk
 eCx11fh/jDiyF0xX7/+9fXsQlZ+3QttQXG2z4rJ14CCb3yB5lZO5rWAcXReMw/LIDSX6
 Hvn/oH+WE1bn1Ui/jfCbQpkwIxTIjmItNJl5xHleYvbv33C2dJ0fFLT9m+nfi+vkv6Vt
 DeRW5k8Y5ouTWtlZiOt+zWhecgMcNXRGNwXRJveBiwkNtHxK0mQ0kAd6s/UY2yvaghn5
 nD1g==
X-Gm-Message-State: AOJu0YwGB4R0RQ5tQSvTlfDIp7j/M66l7dGnowx2fhmJonrz0delulrI
 hOpKdrAbrBP3EVNPw2in8gc=
X-Google-Smtp-Source: AGHT+IEAnzN/ehpfcQLEIXdV4Ba2RuKifdJht4RT2WwSn1Dc6AZnSRcVjcwq+QWMS4jVxt208Q5A3A==
X-Received: by 2002:a05:6a20:7fa8:b0:159:c2d0:9fc6 with SMTP id
 d40-20020a056a207fa800b00159c2d09fc6mr29794152pzj.8.1697093772298; 
 Wed, 11 Oct 2023 23:56:12 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170902c65300b001bc68602e54sm1096977pls.142.2023.10.11.23.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 23:56:11 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 1/4] pinctrl: npcm8xx: add name for gpio function
Date: Thu, 12 Oct 2023 14:53:20 +0800
Message-Id: <20231012065323.2709121-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012065323.2709121-1-JJLIU0@nuvoton.com>
References: <20231012065323.2709121-1-JJLIU0@nuvoton.com>
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

gpio function name is needed in the debug log

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - add commit message
Changes for v3:
   - no change
---
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 7976e3b3ed..ff49819b58 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -329,6 +329,7 @@ struct group_info {
 
 static const struct group_info npcm8xx_groups[] = {
 	FUNC_LIST
+	{FN_gpio, "GPIO", NULL, 0, 0, 0}
 };
 
 /* Pin flags */
-- 
2.34.1

