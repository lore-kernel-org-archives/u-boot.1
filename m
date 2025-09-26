Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE96CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF7C883816;
	Fri, 26 Sep 2025 17:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="deTjf1QJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FD4683857; Fri, 26 Sep 2025 17:31:43 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64AA38380F
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-746c06937c3so2472378a34.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900700; x=1759505500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KgLrcGlAYb4ZJt/3Xf8W6DAu/oHOnpidHfYgSAgYsIA=;
 b=deTjf1QJw48AMIHRNowX6l2ClCG4B3nSL//dP0wmxqFTjSQrLK9HJWNxQ3sWmM22hs
 L9ecwX5A6vWJpn88gwp+oYLZs/ywqox23aictHZZcnHrlFd+oEOCVx3UkMf6TWayS/Wx
 ZmfE3/ufMyYAS+aHKMCauAZl0WTSGqQ9cq5S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900700; x=1759505500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgLrcGlAYb4ZJt/3Xf8W6DAu/oHOnpidHfYgSAgYsIA=;
 b=AUU+kiZiiQ0+3JrLUTYThHcX82QD0R/lpU9SPYUhYOQ0Psr5TL2MPxRxNND9jZVIJN
 UVgyzhL3OUXBYxCJWNHEZ9idgrR9njtY1JmYhw/dAXPyp/GrHfq60gQY0GHJLDedCO2R
 W98K+0Xtsa2Hqw0c361P2syFpLYhMVJVLJOzFb9jDh8N/33tFNfxl8TAuZGQv3UVhkj8
 wMdkX/Fno0v1irJXP+ubVzrITcRH/BKQFxVNT2HZA7UufSkp/Mx9cSxcfAtn6OWacdUH
 qnD8PTz3KNKqC9P1M07Ivo7Qzw0MA7NjlqjTgvnIp9h0uSNaleKOvwJ4RukgGkbBPBN/
 BrMg==
X-Gm-Message-State: AOJu0YyCvQGbDBimAnoSZNrkAcpLgzxIv2iDBGsahLD1BAjL8noIwqNI
 gEABGPt4HTfE/g5yA+Nmi6vLJUEihGCCSkCZGnQBjkpi+DpV9MyEgIrA3Gpwn22dRhes3Alzw22
 uk3V+Xe8=
X-Gm-Gg: ASbGncsCj3eSbKQQ8b78qru1+D2vHW3jM89vQYaO8vSDAYAAEKhEgB9mUrNVo9ReWoo
 NJBvycLQYfkwkX8+7tdWjcRiL0JPjSoH/J/alGNjc/0ZYlj4b6qVLr98wvBh8zNxGaOPC04x+cq
 Al8AvSbKbQkDpFXBYJMwqIxCzd0VhX8Cy1C9FaWnRPeTunfckZtlHOGE1UyQ5zFWn6/91uf2GID
 BsFXSsQcp+Jahs86oTXYqbs5oanTcl+fVURYq24Ti5VuT/aAKv5W9Li6tHi0Y4yU4GHjVOK83TS
 AZ9jAJurp0cjWdnoe9pKUsUR/DCoLxuG+UuEEc2u6fXw973KRaKPhN7Yj6eMa2VhXuhEZ+0IfqX
 cipWjCkUSUItNuPsZqGRzqDsvsBQMww3IgXt+sA0YV1xDZGE95LCkphhaV2gT+6qsNaAe+A==
X-Google-Smtp-Source: AGHT+IEyFpcygRIvX9D1tLY4mOCsPUGU4dpb3BSQpkEqMZ4eo8FgeTqX8w1N2EMQl7O85ifTHt2H6w==
X-Received: by 2002:a05:6830:3d84:b0:782:46c7:2c21 with SMTP id
 46e09a7af769-7a1eabd12bdmr2574835a34.11.1758900700111; 
 Fri, 26 Sep 2025 08:31:40 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a69a1b7b2sm1942265173.51.2025.09.26.08.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Harsha Vardhan V M <h-vm@ti.com>
Subject: [PATCH] misc: ti: k3: Tighten K3_FUSE dependencies
Date: Fri, 26 Sep 2025 09:31:38 -0600
Message-ID: <20250926153138.3680886-1-trini@konsulko.com>
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

This driver cannot build without access to some platform specific header
files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Harsha Vardhan V M <h-vm@ti.com>
---
 drivers/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 29b84430ff5f..e3a207866ead 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -440,6 +440,7 @@ config STM32MP_FUSE
 config K3_FUSE
 	bool "Enable TI K3 fuse wrapper providing the fuse API"
 	depends on MISC && CMD_FUSE && CMD_FUSE_WRITEBUFF
+	depends on ARCH_K3
 	help
 	  If you say Y here, you will get support for the fuse API (OTP)
 	  for TI K3 architecture.
-- 
2.43.0

