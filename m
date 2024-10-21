Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EBCD0E6F9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EAE89335;
	Mon, 21 Oct 2024 13:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iDT64a++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD68388F2A; Mon, 21 Oct 2024 13:39:16 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A2B788FA9
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso680623966b.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510750; x=1730115550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fG7DQm52zMxSmpbncGSfKzGCEjPWHAYUm6UlhnnTSFo=;
 b=iDT64a++gDPPn/DxacyKqPllXSUtS1w8hmM7+BR/LYOU6qUZtegZFy6dHrykgY0Vtq
 JgPF393h0kbHTFqNSqMIq6P4euurIfj4IcrCwbOKIsZ6QsWTLgQFNRdNhEu7lfGs/zFh
 uopOs+pG+4tV0TWC2ksX9khVJq/V52EZRV+dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510750; x=1730115550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fG7DQm52zMxSmpbncGSfKzGCEjPWHAYUm6UlhnnTSFo=;
 b=AvzQkld0LKO0Nz0rrtBVzXZpZnCQxWTFcH8xpJFcfC8ZD61cKlWFHQJSHe2o4az1va
 TlQTw19p4o/r9rGmCMKvvaezkdHy0bkGgscItBUC2NOigcAegWfFNVQpWlNyvb/3hpFM
 LO8la70zOb8geNFt1/yJBE9PkRgoR8RzyYjOGUXU/BL0+thMAX/wezg33/SNO0Q8jDcD
 mr/UwkGjNPxERbhGrQUEW+9clXxA09gpCZvUkKkr5i+EAC37iUsQRDSFob+L6zj4z6KH
 7puLCOG1rUkEszZc89Hm/aSlW9A6CoeimLP0trMaTRU01E7mjwKrcsCgGo2JogL0T59S
 Vcog==
X-Gm-Message-State: AOJu0YzLtHQCYx16+rZgCL121X9LrYueBO7/X8akldRZawtIkGTUfHUO
 zWTAjQYtm/tuwfrLRGQBC4j/ZRxIIs1Ht36nkiF49+xjahuN+hDJiiYvOq6gbEtObp+ZTLm/peh
 8FVOY
X-Google-Smtp-Source: AGHT+IE+VVXREGJkg6h29Cj45B9bTaZNwXstBLGZbVWhulva/FCrJ8hhT4lx8X8yBzbY+CZErhA0lQ==
X-Received: by 2002:a17:907:6ea2:b0:a9a:e2b:170a with SMTP id
 a640c23a62f3a-a9a695d8acfmr1148927766b.0.1729510750012; 
 Mon, 21 Oct 2024 04:39:10 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v2 21/25] image: Drop unused status_led.h header file
Date: Mon, 21 Oct 2024 13:38:29 +0200
Message-ID: <20241021113839.318572-22-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/image.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index abac254e026..7bed8ba4b1f 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -15,10 +15,6 @@
 #include <malloc.h>
 #include <u-boot/crc.h>
 
-#ifdef CONFIG_SHOW_BOOT_PROGRESS
-#include <status_led.h>
-#endif
-
 #if CONFIG_IS_ENABLED(FIT) || CONFIG_IS_ENABLED(OF_LIBFDT)
 #include <linux/libfdt.h>
 #include <fdt_support.h>
-- 
2.43.0

