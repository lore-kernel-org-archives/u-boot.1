Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D523CC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A7388BE7;
	Wed,  1 May 2024 04:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mmqq4RkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26EB088BB8; Wed,  1 May 2024 04:45:02 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE36888BB8
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-69b24162dd6so39903126d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531498; x=1715136298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGVKcZx9+tQnslxl6AWp/m+23N/UG7O3qKtCFwohEIM=;
 b=mmqq4RkOlcy/Q+Yv6Tp/YCNDYRxyTgDsDHEXfwFF4xjcoQOak/z+AsOT7F7ABujjQL
 Nv1Key0eFaq0pErqi4cxq79Hcr9r9Ob64d7vKahEoS5xk7OYKjoC5D521MlIYwIeahyr
 0SNWAfzmD3p7F1bWpCwGXrvyz0DmnOYkhd+zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531498; x=1715136298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGVKcZx9+tQnslxl6AWp/m+23N/UG7O3qKtCFwohEIM=;
 b=fNwN7W5KNACRHrvh+pYQ6FOtyT1iEx35oK7E59fKKKUVNxpk8wQPbpMmP/w4h+Yn7/
 oGN5jv00qPDGepoX8pltpSDRnxNcsKzgkP5vfEa/hgTrLLlWctxo8d5l+bSs6zAlTBZN
 Bb1ktOPbg3RVzkqZONlFzgHLWw1NtPUAxJJJh2jspwJqkFpRcueVx49JXB6VdLhn3JDa
 g118z4MYUHFqTPNRqdYoaCxZ2PAenlu9F08PsLWgBqho32MUcemohenD6CyoOkE+XmbG
 zCI/sP0yXrA5lsgN+SdMfWEcEyOeCXlFNRCr+QEBY9DCOJs5+XFJDSyrWvc8akJYY+Lj
 QKrw==
X-Gm-Message-State: AOJu0Yw3JS9FvKCNQR7XJs3uRpcEbwCBp7xsRe2vVlyKKC6hlbx1fBR+
 W16TPuINA8Nk8KPQ2rMESzIRFSng6Ld3kljvIaMTcFr7nOZSQT2sjT81rH6HVcrRlBWgURZsbvA
 J1gmniA==
X-Google-Smtp-Source: AGHT+IFRcr+LBbT+9oWMe2pWoRDHnGX8r1TpnVZDlc4rLLLogRSYwEhTqrQCKlHMIt5pkXDnZbU0Ow==
X-Received: by 2002:a05:6214:21e4:b0:6a0:c784:69ac with SMTP id
 p4-20020a05621421e400b006a0c78469acmr1464008qvj.13.1714531498534; 
 Tue, 30 Apr 2024 19:44:58 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>
Subject: [PATCH 086/149] board: logicpd: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:13 -0600
Message-Id: <20240501024316.1767971-86-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Adam Ford <aford173@gmail.com>
---
 board/logicpd/am3517evm/am3517evm.c | 1 -
 board/logicpd/imx6/imx6logic.c      | 1 -
 board/logicpd/omap3som/omap3logic.c | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/logicpd/am3517evm/am3517evm.c b/board/logicpd/am3517evm/am3517evm.c
index e69a73f2af6f..e6ca31016b7c 100644
--- a/board/logicpd/am3517evm/am3517evm.c
+++ b/board/logicpd/am3517evm/am3517evm.c
@@ -10,7 +10,6 @@
  * Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/logicpd/imx6/imx6logic.c b/board/logicpd/imx6/imx6logic.c
index 0d53548dcb4b..589136fd64aa 100644
--- a/board/logicpd/imx6/imx6logic.c
+++ b/board/logicpd/imx6/imx6logic.c
@@ -8,7 +8,6 @@
  * and updates by Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <miiphy.h>
diff --git a/board/logicpd/omap3som/omap3logic.c b/board/logicpd/omap3som/omap3logic.c
index 86992829caf4..a9fe61918b6a 100644
--- a/board/logicpd/omap3som/omap3logic.c
+++ b/board/logicpd/omap3som/omap3logic.c
@@ -10,7 +10,7 @@
  *	Richard Woodruff <r-woodruff2@ti.com>
  *	Syed Mohammed Khasim <khasim@ti.com>
  */
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <init.h>
 #include <net.h>
-- 
2.34.1

