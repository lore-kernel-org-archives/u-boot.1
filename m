Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83931D68BCD
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 16:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064E288D4A;
	Fri, 15 Nov 2024 17:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dwHcPEOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E30988FA0; Fri, 15 Nov 2024 17:54:06 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D5188C4D
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 17:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4609c96b2e5so13496271cf.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731689643; x=1732294443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pPNJIaOeCy33fkPRN3OjuVLpZ69SRK8qNS2Qv0KFMi0=;
 b=dwHcPEOCPiE5xYbO5kn3e7lvAQII/tmQbEAnr2NaDNUL9utZvc9h7qCkH335fm6/vH
 o6dxJTUmXYQQDrzmRSuZmexp69qBKyYAetK6CYHLCjcEL8uOKKrtkuXRgE22vlwVXAqS
 8/4kFLB9Xzj/rKoXGarXUbjfJHUJljztTIDCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689643; x=1732294443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPNJIaOeCy33fkPRN3OjuVLpZ69SRK8qNS2Qv0KFMi0=;
 b=vRsQmFAP9HKrlDCTTywZ0aczf1HpB9AA+ruBIWlJh9p4bPa/+gfpso6qYjSc6LVYGA
 IKNzmsWjl01B05NsEwsaC7VzhYn9Pj8u6FPV0YNj/kIojaOQDNqIZDY3ZjRiLbHNwE6T
 CRsPvD3POwgnykWcKdM8U6hRCsp+LPkeWMYOTStQiVpnGRrj1b76MDn8WibLUGMIaj95
 54WkH+e+ubtR3/IQ2tNmH+nJsao6VL/LMMkFoOkBo/earxh8+kLgPUOKcLW9gWfJdwDQ
 Ncph3IUdZ+vuhGZOyoVpdvtx+29w0np5WteYTdA+mK7cyxTqTPcj8xSaYkE6Um1i6dvy
 0SOA==
X-Gm-Message-State: AOJu0YwUUcmLB0PPkBUs9LD27Gycjw+LSNT+Z2VohavCvgVLNfu0hnMO
 AsQWvP5QD5qbFnp4FlJfKobKsR8mbmN8+lv/dBnN4BqbWvEYLaroZOtdn6vylyC7Z5np9jSdUcy
 UcKE=
X-Google-Smtp-Source: AGHT+IE4t5NpEQcqevLWtlhrUPe2Z7oFQpaKoIcdCN4UQBi5r2qZEyuhdbhCrXYJkXTvVX61QoPPTw==
X-Received: by 2002:a05:622a:1e85:b0:463:157e:46a7 with SMTP id
 d75a77b69052e-46363e35669mr42802521cf.33.1731689642823; 
 Fri, 15 Nov 2024 08:54:02 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9f20c7sm20784831cf.23.2024.11.15.08.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:54:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Maxim Sloyko <maxims@google.com>
Subject: [PATCH 1/3] aspeed: Fix Kconfig logic on "DM_REGULATOR" and
 ASPEED_AST2500
Date: Fri, 15 Nov 2024 10:53:57 -0600
Message-ID: <20241115165400.2486914-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

It is not the case that we can only pick ASPEED_AST2500 if DM_REGULATOR
is enabled, but rather choosing ASPEED_AST2500 means we must select
DM_REGULATOR.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Maxim Sloyko <maxims@google.com>
---
 arch/arm/mach-aspeed/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index 1e7dc10e170f..9cf60378c118 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -16,8 +16,8 @@ choice
 
 config ASPEED_AST2500
 	bool "Support Aspeed AST2500 SoC"
-	depends on DM_RESET
 	select CPU_ARM1176
+	select DM_RESET
 	help
 	  The Aspeed AST2500 is a ARM-based SoC with arm1176 CPU.
 	  It is used as Board Management Controller on many server boards,
-- 
2.43.0

