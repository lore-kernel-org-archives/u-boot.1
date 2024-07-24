Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8323BC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1BF889AB;
	Wed, 24 Jul 2024 17:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KWBg6uf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6262388967; Wed, 24 Jul 2024 17:09:45 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163F888976
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3992195d08aso24421915ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833781; x=1722438581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yN5x+SeSlYbnr6ZaYILJ+6G/CB2ex2cdwl3F04tTdtE=;
 b=KWBg6uf7bVhwODMf2OdDJwCnciEr0I4zIfWDdB741oH0IWsLTkEaJpeTrRF881PwKv
 +tfBDjOU3d0lolOX6pN57eb+9qG+3bfVbbSDgVqMrPBGFgD6N5iVv4/eF6XpSRC517uN
 XL48LSubAvjUvmR1d/BRB6koI12aJf5ZSfiqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833781; x=1722438581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yN5x+SeSlYbnr6ZaYILJ+6G/CB2ex2cdwl3F04tTdtE=;
 b=wTDQq3yqGagpNs20V+FmbV+6+Z80O5M66Wv9Dd2G+a1RuTqg/GHL8I2BHH6IaikPJ3
 cwkvk2A9FcF5GilavtvNQ5JTgLD09V5Q+R1QrMpiVpJnTit6nYdV/8K2MxHP1Iy2Eh57
 ddnn7QiIksskfKWk7Yl/hrLy9NqePf4E0TKkZZMMiNikbYQCMcHAm4Gt2tp8WRAIOwUc
 w00cW5rwShioQwDFof+a6/idmnzxSw2LQzIgdNc/6rwOhr2RIBRpB/lvNWLoWqbdcFPW
 LKeDx955xs7oqMbUXLlikmTtWtK/lF4TpTYa8j0MLUjR6+buPS/WTcWhZbYQN2QLz/nH
 aOfQ==
X-Gm-Message-State: AOJu0YwK4c1zIarcrC2nMZIIo0KVPPMjxQOnKxkapZAiuh4IWFrUENQ8
 ovJnedVve5/sD+bNWR1BrcZ6eML1wIsjNtAmV0bxVjh9O+Vku9sJ+vAt1rtaaLLNbry0Ipkjgdg
 =
X-Google-Smtp-Source: AGHT+IHfwUoTPeq3t5Poheamj1qabJ3DpQcAJw0rJMmfMc4Q+54lZtvi1jqPxzz1O7nIOD0zByFkVQ==
X-Received: by 2002:a05:6e02:13ab:b0:397:6dfc:9946 with SMTP id
 e9e14a558f8ab-39a194d5e6bmr24590595ab.27.1721833781708; 
 Wed, 24 Jul 2024 08:09:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH 06/35] arm: friendlyarm: Avoid accessing global_data fb_base
Date: Wed, 24 Jul 2024 09:08:53 -0600
Message-Id: <20240724150922.2343249-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

Use the new video function to get the framebuffer base.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/friendlyarm/nanopi2/board.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index c8cbc5a15fa..b32dfc6b570 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -11,6 +11,7 @@
 #ifdef CONFIG_PWM_NX
 #include <pwm.h>
 #endif
+#include <video.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 
@@ -492,12 +493,8 @@ int splash_screen_prepare(void)
 					 ARRAY_SIZE(splash_locations));
 	}
 
-	if (!err) {
-		char addr[64];
-
-		sprintf(addr, "0x%lx", gd->fb_base);
-		env_set("fb_addr", addr);
-	}
+	if (!err)
+		env_set_hex("fb_addr", video_get_fb());
 
 	return err;
 }
-- 
2.34.1

