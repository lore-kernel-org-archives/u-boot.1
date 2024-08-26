Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016D2C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DDF188B1B;
	Mon, 26 Aug 2024 18:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ghjpLoHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E00C88BA0; Mon, 26 Aug 2024 18:50:13 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0D488B37
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-709428a9469so4348156a34.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724691009; x=1725295809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XIRoE7ISDTgiEWj9++9S+R1ri8cnbKyYSD/y3baGJIM=;
 b=ghjpLoHQ/1Ne6rgkfVx+Nxj6qLeJS0ii3S7VumZCSy4sfrmxNbi+QKpww0lEkHZ+Vr
 CtWx/GVE5pekfFVe8604Xrr2C0CC7OQy0WzYQ5+4ozGNRAtpIrGrgNKBvRSQrfq7ZuhX
 TL35mKSYc0RT52UqSrfIDLK67Gnio+J07+PA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724691009; x=1725295809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIRoE7ISDTgiEWj9++9S+R1ri8cnbKyYSD/y3baGJIM=;
 b=YB30xPERCmd/OsH1oM12U7+OvVcrBz5eG03V+Gcm+VF8InsZ7AnM4sB99MizKarP1m
 RUiQyg66WFBWr1/ArY35bMvkif3Mx5mToA42bGktLIdV5l3hKQzx4sugGlc6a6iHDPLX
 m2J5wdphZzf59MUrSl1RatE6ROM7hcCy6Pp0I5n5L2Me7pXaVHUGrpkFPZ7K4ehaRFmY
 MXy2YA20Ml7YBSkBp09qWpo/1qOHku9zvalRpnOybPkm7qmDNY7vqGKJZdrD3+80b9JS
 6v5ajMU8A8TL1fQtA289R/6vipIT5THLM8slo181zIVUyOS6JzbiVpAxX1MccJQPrwQf
 unug==
X-Gm-Message-State: AOJu0YwrrZiDZclnaevDjVhOq9T/6t/gCLnMaycGEo0YYu2Hh5VLvtR/
 inCjXa8uGdZBdbl/MJhGYP2J48SinVVGeKo1qOgvIOvcnjMyoP8DPz0XKyJyluPsyytXEI8UIN8
 A
X-Google-Smtp-Source: AGHT+IFRi8sAgJNGpcucF1uQa6ZSYK/R4IlBU7V0LrJj851QrmQkeXSAxW2HcEAbyduzzOxG7kdjWA==
X-Received: by 2002:a05:6830:3590:b0:709:674:6e4 with SMTP id
 46e09a7af769-70e0eb42c27mr13952133a34.19.1724691008469; 
 Mon, 26 Aug 2024 09:50:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1d242sm48576136d6.16.2024.08.26.09.50.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:50:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 5/6] bootcount: Update to point to current documentation
Date: Mon, 26 Aug 2024 10:49:56 -0600
Message-Id: <20240826164957.2789525-6-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826164957.2789525-1-trini@konsulko.com>
References: <20240826164957.2789525-1-trini@konsulko.com>
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

The current documentation for the bootcount API is on our website and
not the old wiki, update the link in two places.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/device-tree-bindings/bootcount-syscon.txt | 2 +-
 drivers/bootcount/Kconfig                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/device-tree-bindings/bootcount-syscon.txt b/doc/device-tree-bindings/bootcount-syscon.txt
index e124f7b61428..ea27b246c8a4 100644
--- a/doc/device-tree-bindings/bootcount-syscon.txt
+++ b/doc/device-tree-bindings/bootcount-syscon.txt
@@ -1,6 +1,6 @@
 Bootcount Configuration
 This is the implementation of the feature as described in
-https://www.denx.de/wiki/DULG/UBootBootCountLimit.
+https://docs.u-boot.org/en/latest/api/bootcount.html
 
 Required Properties:
 - compatible: must be "u-boot,bootcount-syscon".
diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 2105cea3d45e..d375984bb330 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -6,7 +6,7 @@ menuconfig BOOTCOUNT_LIMIT
 	bool "Enable support for checking boot count limit"
 	help
 	  Enable checking for exceeding the boot count limit.
-	  More information: http://www.denx.de/wiki/DULG/UBootBootCountLimit
+	  More information: https://docs.u-boot.org/en/latest/api/bootcount.html
 
 if BOOTCOUNT_LIMIT
 
-- 
2.34.1

