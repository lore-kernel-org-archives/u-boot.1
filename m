Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA1CC54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0093688B8F;
	Wed, 28 Aug 2024 03:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YTL5IUHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA8688BC1; Wed, 28 Aug 2024 03:45:56 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA3A188AA8
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-829e86cb467so102644139f.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809553; x=1725414353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTmxkwg+waZj4cFSJY9nYqKCzgS/TIO/4gxhzgGL0i8=;
 b=YTL5IUHToIkDQzsbYznl2btTCOunKAOTrIB7PH9l31BFM0Qj7Pd5SRje8BrGX9Vfrd
 VbhynIPqnmlIMsPFkqODzeCmwtVctd/ZCODZqOsyDvw7yI8yOGUQ4y2g26OtUgBxHSha
 smbt8QcxbX8SbuMeKKiGzVd+Di9LuXYDhYCAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809553; x=1725414353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTmxkwg+waZj4cFSJY9nYqKCzgS/TIO/4gxhzgGL0i8=;
 b=UAAlN2/GXj+Lq/fTnS8lfGv3cu6Fe17H2FQ2qabm3pdP7qUFkqGFu9PAy3FnlPSNgB
 j4IYRp6gM9v9ux0bJlMLUV1P6CAbERFsbr6sxIjDncfMspekjccLPLIn6qTL9B6F/549
 yAgoaeKuqqrD73JB5o/U3o9zY8iQdMCSBiPZqxuIAIp0Fk2bkHH8cPyZhhCWDEA7yHug
 peXwqdsDj2P9v7NR38+FgYp8MqS/ZmNFcabVZVcVwAcjH4lMJsRNF+Uq3ydoDLacURFw
 dAxc9hpy4XtFMyC0W5b+Pqy+raKNC1E9+4F4v+jcljesokp2WW8YrQvhwjTpdMn3UaTN
 gyfg==
X-Gm-Message-State: AOJu0YyThjP5Iq0QpWPHy0P+Ds4Xp743W5KXVC+KuhvKBSoOeTLLSNu0
 YvJ2fGjHa37FcwTnAjbOOvWxUTYGdZHa3JYaR6wIZqHUjeDDgkgXLowmsfwl0PmDmaJ4WUZLJXo
 =
X-Google-Smtp-Source: AGHT+IHe/rGV+tWmzZI/wUuUwyeadEJxIkdx30p7njkGsBD026bwY+YngP7pPFoVH9OhIp1r/BWZCg==
X-Received: by 2002:a05:6602:1412:b0:803:f97f:59e0 with SMTP id
 ca18e2360f4ac-82a03cad1damr69060339f.0.1724809553429; 
 Tue, 27 Aug 2024 18:45:53 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Vaishnav Achath <vaishnav.a@ti.com>
Subject: [PATCH 07/18] ram: Support driver model in TPL
Date: Tue, 27 Aug 2024 19:45:26 -0600
Message-Id: <20240828014538.3322013-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

Some boards want to use RAM in TPL so add an option for that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
2.34.1

