Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15CFD0E6F4
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B6788F20;
	Mon, 21 Oct 2024 13:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O2MbTcMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38AB88F31; Mon, 21 Oct 2024 13:38:55 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D5C688F19
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so498067766b.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510732; x=1730115532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFSfBmIxA0qB/rInPVI4iqY30iI4mZqZ/CmiDf12jcU=;
 b=O2MbTcMTdzoXQ0hchPY/KhydpPUODHh6n7DlxqeDJmfAo16XiRNUeodhseEfuMfNbc
 Zdv/Vr2A18uV3Ay3rTckg5QbTN7iiq1ZS88gdtsg5lmVCX9Xdha+QXn9TfQ13HEDIIKW
 PIHnGWr2keCV6+k6+HyFzaWHwUqMtACnQcL3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510732; x=1730115532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFSfBmIxA0qB/rInPVI4iqY30iI4mZqZ/CmiDf12jcU=;
 b=cWRZ0l8Je3hiErMlkKOJcPMn2v+zTjc7gzeKx0dwQn29rnED0GvbxxNRBf+u6VKEvs
 f0RilMbi9UxTpwTEd/1iCK014p4ByuLOr24fu6CnLXYfgBQrgMaH0357TeHayM+DDlxF
 3B16hEN6GnPWwoKaL/YtoXCVkDWMfE/fAGxdLX1Q/87e1OeOUGFRrWUJ098l24m4PgAq
 sLrBgsbovXG5ZQ32XjCVBABdgLOyiJVTwHaK14cmGNoxOwTJLvjhct1COMS1+rfs41Oa
 cJzQOvAS5iy7wd2AL5fXr75Jdl4ZGXaBIaT8Qqp8A09OjWft8sDMtA8/ThKWkJhZzh9j
 8/tQ==
X-Gm-Message-State: AOJu0YzbCyW7bmIDsHtbFY8dMwt9DyNn4BSisFKf9MxwgncCxyNrFNKn
 9IeZQE6X1DHTYYvFqdD5u6FkfcOBkQB4CFBfrOQIvcGDxsPVnIeawE8ftYOXoly25t6eeD20M/+
 GKiiw
X-Google-Smtp-Source: AGHT+IFP+A01NnnlaPGyYg58sju4YizuZDQ/Jw7Noetg/r93krhIuNiaEgYbGi2sEkWJ3BTkZCAFsg==
X-Received: by 2002:a17:907:86ab:b0:a9a:2afc:e4da with SMTP id
 a640c23a62f3a-a9a69cdee30mr1049830266b.63.1729510732174; 
 Mon, 21 Oct 2024 04:38:52 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v2 03/25] mx23_olinuxino: Drop status-LED code
Date: Mon, 21 Oct 2024 13:38:11 +0200
Message-ID: <20241021113839.318572-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/olimex/mx23_olinuxino/mx23_olinuxino.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/olimex/mx23_olinuxino/mx23_olinuxino.c b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
index b2bb6678c23..78136c1620a 100644
--- a/board/olimex/mx23_olinuxino/mx23_olinuxino.c
+++ b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
@@ -13,9 +13,6 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-#ifdef CONFIG_LED_STATUS
-#include <status_led.h>
-#endif
 #include <linux/delay.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -61,9 +58,5 @@ int board_init(void)
 	/* Adress of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM_1 + 0x100;
 
-#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_STATE);
-#endif
-
 	return 0;
 }
-- 
2.43.0

