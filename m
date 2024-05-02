Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F377DC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C43C088BEF;
	Thu,  2 May 2024 03:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KoDyxEXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1925788BE5; Thu,  2 May 2024 03:31:49 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF23288B0D
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-43b06b803c4so19617331cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613505; x=1715218305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twc7v37XyxfRt4wS5NGiAWn5CRq80rMcYFQp2nDjqoE=;
 b=KoDyxEXuhYEX+zbTav8PufYNQgJ5VV8ql4BHcK64HFG2WAseIKD6surKTn2YTlwzdF
 EQasY2vKmwgk59k/3FDQh0NgcDiUNW1yJ4JCllmGL16T4WuXn7+VOHld4r0SP4bhbGnb
 Cdptbmt66DPdTn/vrba4i/tvS7TVBqtgouXjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613505; x=1715218305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twc7v37XyxfRt4wS5NGiAWn5CRq80rMcYFQp2nDjqoE=;
 b=lsGgXW5E1dAUtugy46+2bcg5QM53z9OZyacK4mnlbMWwU1jw7Hf3Bg0wTpjBs3FoZs
 lp8DEOWy8BUaISfP6J6MADIDtSVciHnJqoVA+WX32AAInRxvrf++0ke+2CR35JJ3LDNm
 g0NWVKrqV1Uim/aca3l1nDHUeLVrP8TF+DL9tgEYfIv3KsIwXnq3fvrXAOxZZyOD3GfQ
 j6hKX8eV/h504Kiw8bwEmskw7djTPIH4m8Uu0zS7+Ng3zohZT4LgfyKFuwXArRtVqigD
 oUlZbNmlpOwAnm/lY//HqLbVt9sj8abszNdd44H54Ix1a5pgyLiwn58XnOy3T0C495o3
 V0Ng==
X-Gm-Message-State: AOJu0YznRkrYrzoEWQMNKamDrEMNIphNYPbIyJMOUoj7wTBixXAKGpIg
 GXOIuCh+x2Q/QJLSd55NkY10GYaFn4Oh/UaIl7KK/cYJh+TYLmDhsZ9RkdNG6XCEru7FRZ8p1JI
 Wf3Gr9dbw
X-Google-Smtp-Source: AGHT+IFkfc6tCWSuVq/5x0L+3opAhgrGbgUDYSx6c4DDgkHRP2StQV8jIih4Yk6GKMcyT2FYK9eszg==
X-Received: by 2002:a05:622a:1214:b0:43b:1571:e00b with SMTP id
 y20-20020a05622a121400b0043b1571e00bmr5160738qtx.43.1714613505494; 
 Wed, 01 May 2024 18:31:45 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH 04/81] arm: nexell: Add missing <linux/types.h>
Date: Wed,  1 May 2024 19:30:21 -0600
Message-Id: <20240502013138.2383421-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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
Cc: Stefan Bosch <stefan_b@posteo.net>
---
 arch/arm/mach-nexell/include/mach/mipi_display.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-nexell/include/mach/mipi_display.h b/arch/arm/mach-nexell/include/mach/mipi_display.h
index f3fdec64647c..9183ffdd9c3d 100644
--- a/arch/arm/mach-nexell/include/mach/mipi_display.h
+++ b/arch/arm/mach-nexell/include/mach/mipi_display.h
@@ -11,6 +11,8 @@
 #ifndef MIPI_DISPLAY_H
 #define MIPI_DISPLAY_H
 
+#include <linux/types.h>
+
 /* MIPI DSI Processor-to-Peripheral transaction types */
 enum {
 	MIPI_DSI_V_SYNC_START				= 0x01,
-- 
2.34.1

