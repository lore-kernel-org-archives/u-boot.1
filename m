Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152C7C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 11:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C9F87933;
	Thu,  4 Jan 2024 12:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m1ZcfEdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A466C87933; Thu,  4 Jan 2024 12:46:54 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79AB2878AD
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 12:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d4a2526a7eso2507925ad.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 03:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704368811; x=1704973611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TunIVplKsXzKgP8ScGbefWUcOPn2C5WOzyIPRNxX8vE=;
 b=m1ZcfEdrykhN7ZwIbdSuCVgYJEfWgV2soasPus64/QFZlB4QeXgqU/x/qYZYvlxwUk
 G5tpOdBfX5jWMW3ArnfH8BCbdTFST5vV4wHlBVy2EsxeB88KZ1Q+t49QW0q+b+q8vnF6
 ZxmCueC5fSBXny6amOPckZ77sjuYJS0tykq8aYxlc09vvvCJausdwJODiceMM9TrKBCp
 54ECxmEXCQoRpSfq2D6OTeYT//Xo51m4O/BjKUhMrudg65CZj0V03yDR473SjNyRTste
 p9fO+jedJlGvXgofsdJByu8mS4BxaF2Pvm/Tl1NblmL2cCRIMNlf/YiCerpJpO0JBEGl
 dLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704368811; x=1704973611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TunIVplKsXzKgP8ScGbefWUcOPn2C5WOzyIPRNxX8vE=;
 b=UwAI01N95l50omcOfot5J5PLM3z2+gU7T3/efQYPzk/zAeILxEXSwjodc2l9JKrlO7
 xGFZ9kXALJiNT3yXkY2sVBLyc1jyQ97tG3qWKqyfqdJYNtfsj2tjA5p7dodvbqgwdnsJ
 Uk8BwEMYl64dU/QNyDt6YUdgkpvwcEy3WEoi/F3wD2YOZygrfGEntMlMwz3fUyoGJwwk
 mwCGejGyyyr34gG7dB0TSYdijiPspAi9FAQbFiVBP+La6X15aypdkbQwCIyYroxVMr2h
 5c11Ggo8Ilw/HpoehYuo3QNjeshJepEL9S5qGipUmDlChf67jfEmG9AU+UPWVtFRcoSD
 j2Gw==
X-Gm-Message-State: AOJu0YzlA1gSdPiQtttvztXp7OcZCRFloMzjufV6tW9b4UgWrwBf+KXb
 Hq/kIMGNX0Hn7BZ2d6BM3cA=
X-Google-Smtp-Source: AGHT+IEMs4K+Lmgo5CLZvXECrDf5hFFPdRsPgBUKGLyVBudhg7KM1bwexKAPBCb2i0teEpgyYR3+IQ==
X-Received: by 2002:a17:902:d509:b0:1d4:b4b3:c4ab with SMTP id
 b9-20020a170902d50900b001d4b4b3c4abmr417008plg.46.1704368810225; 
 Thu, 04 Jan 2024 03:46:50 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a170902700400b001d4ae8f808fsm8397984plk.63.2024.01.04.03.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 03:46:49 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] cmd: sf: Fix sf probe crash
Date: Thu,  4 Jan 2024 11:46:19 +0000
Message-Id: <20240104114619.280513-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
crashes.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 cmd/sf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index 730996c02b..e3866899f6 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *const argv[])
 	}
 	flash = NULL;
 	if (use_dt) {
-		spi_flash_probe_bus_cs(bus, cs, &new);
-		flash = dev_get_uclass_priv(new);
+		ret = spi_flash_probe_bus_cs(bus, cs, &new);
+		if (!ret)
+			flash = dev_get_uclass_priv(new);
 	} else {
 		flash = spi_flash_probe(bus, cs, speed, mode);
 	}
-- 
2.39.2

