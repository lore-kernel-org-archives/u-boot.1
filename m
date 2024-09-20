Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DF2CF58E2
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69FEA893C8;
	Fri, 20 Sep 2024 09:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mK8Es3x0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F989893C8; Fri, 20 Sep 2024 09:25:12 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D5A893D5
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso15798835e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817107; x=1727421907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UY+wRxRfvVmR2T6YEMz0afy8CnUDEOnhWpYjiXZ1CCs=;
 b=mK8Es3x0Or6tDhdELEPaf7uNFRYOOzF1MME5BtrVfJAwYA2BA6+iP4uUfye/jgu7TI
 DEVnv58Se/L21/6qiGfkF/A9VH27Q5cfbBDi+yWJNKxyJ8Zlvh6hZRCd6x/CxcmebhXq
 ltRsHSDR5BdUt0pVgRKZzATL8ruhlOswWkX+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817107; x=1727421907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UY+wRxRfvVmR2T6YEMz0afy8CnUDEOnhWpYjiXZ1CCs=;
 b=Yvmi3HouVqe/rPPKDwzvn2TFy4YGmO5FuhsyqWxKKmpmothaGortJoIxg4oOnq3LNm
 /3fdjdCGuAUuOSZ1Kglo8Z6XEcBfT7L5jxit5QqswOD41WtjCyetxqH1J7kleVzPjBhl
 GTjRswF8XNkZBz550IG4/R/Jqu7lITHIXaVTAwsaZyRdCvAgHqo9VIclnmZRlSuHjNi1
 E4sV9iEUI46P5BXrGOYFDDfpbdJV1tJs8cR9iwYSkXZ3jG0XIzmMJA4b3ibh+uxRZnL/
 8GQwxMvw5iDbAgMOBy0xCgoDsOQdgH89TZyl0sZ10LhOYKKTZoP7nUqHv96CWzH+zwMo
 XVxg==
X-Gm-Message-State: AOJu0YyKQbkCNnTGZnDOjduNJnmlZVOAZZJKxvvlIEv+Hl0a33MgWXIf
 PYI51QHSOsSxcsiasjbcyN9tC1mwvxhXGtBInmwZKNWqffdwMcY3GXar9RXMWlgmJeO3ykPzo1Y
 /v0Kb
X-Google-Smtp-Source: AGHT+IFBt0sEPodkAJXUV6yCE+tt8X8PmBeInvrsXB0d6J8KtPzXfL5Kjw9fXQ5J5lQ2+74fn1i87g==
X-Received: by 2002:a05:600c:1c87:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-42e7c19bb93mr10571395e9.26.1726817107070; 
 Fri, 20 Sep 2024 00:25:07 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/18] ram: Support driver model in VPL
Date: Fri, 20 Sep 2024 09:24:31 +0200
Message-ID: <20240920072444.134997-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

Some boards want to use RAM in VPL so add an option for that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update this to say VPL instead of TPL

 drivers/ram/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index a64d2dff68d..f7e357f24da 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -26,6 +26,15 @@ config TPL_RAM
 	  TPL, enable this option. It might provide a cleaner interface to
 	  setting up RAM (e.g. SDRAM / DDR) within TPL.
 
+config VPL_RAM
+	bool "Enable RAM support in VPL"
+	depends on RAM && VPL
+	help
+	  The RAM subsystem adds a small amount of overhead to the image.
+	  If this is acceptable and you have a need to use RAM drivers in
+	  VPL, enable this option. It might provide a cleaner interface to
+	  setting up RAM (e.g. SDRAM / DDR) within VPL.
+
 config STM32_SDRAM
 	bool "Enable STM32 SDRAM support"
 	depends on RAM
-- 
2.43.0

