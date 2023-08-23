Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F50EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA750864CA;
	Wed, 23 Aug 2023 17:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="iboAuP6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1828645F; Wed, 23 Aug 2023 17:45:54 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F97864C4
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2bb97f2c99cso90082751fa.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692805551; x=1693410351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UR/nCGuinQ2bA1BFgUXLXQ1UdKRDgyKXsdpHw2ZUA+k=;
 b=iboAuP6yDY73WcT18NrD8vy2IO0iCICaeYI9eaoK1RdOxr8EQPeHPNIkAvxNwIlBEQ
 dlnwGf7EJGgGlVp0EVvFnfp8jFKolxqqvIMucooHGtlHqXmodXVwFwCnbKXi+aQALeqw
 jtmY1arjjo1O7giFoKjvnwfCJascHaKXRMUHVnKnHel+JECZUOV91MynDdAc0/GapTFT
 wBgOe6J0IioDE/OOgupUZR9XgC/EKs6Kv8GzZYbx/7ERTkL9kGM38Piow/h142nKVRmS
 6pm8q7d3YGYtkLpUJxyRdppMYMyPZWcThXQJNVMCabE/OL2X/xWqigoYC6e06vnMe+j1
 N0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692805551; x=1693410351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UR/nCGuinQ2bA1BFgUXLXQ1UdKRDgyKXsdpHw2ZUA+k=;
 b=fQzBTsyQxKaPkeO6acQ5HSd5ODFrqwGzRD6bMB3sSRPFNYDdZaNeMsyioUcrQQL/0C
 nfu7pkz0nhgMM/kprDrr+kAggAjPQ4JuPCMSO2DkTtRqpKAe4kRGiJcrszPNYMXIm96K
 PsRxXv+zKfrEQq/tFGKQW0UEeQBAvRJ3khw9rPQ7OpdOmftPqDVVeecJyaS+XzJakN6l
 JSCATnE//r14k+ZVVO86kGjSmTBATv85vPSKtiYROVL/Aj04T8h1tYMepyuUE2bSSE9M
 fpU6SXiI5ZeoWn3FtN/0xfjFplRSHcSi9szpeRoBmcO2DFVt7iFoRM7nJ70x9jR13sKO
 qRYw==
X-Gm-Message-State: AOJu0Yw4C0U+6TLNtq0uwmyBmQCv0ui34echVORRGonCx/lP+wfUNw+D
 mQkA7mLA1jx5bX4CtOwFflJp/t+zoWta0A1d3WE=
X-Google-Smtp-Source: AGHT+IHkNbF09Nsx6GS3HFZ6dFf5Z8eMr8jOa/QUWXso5Sgfl3jwikjK9bhK1GjyJG7IUxb0ELsiaw==
X-Received: by 2002:a2e:a3d7:0:b0:2b9:df53:4c2a with SMTP id
 w23-20020a2ea3d7000000b002b9df534c2amr10172635lje.20.1692805550897; 
 Wed, 23 Aug 2023 08:45:50 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 l12-20020a05651c10cc00b002b9f1214394sm3290758ljn.13.2023.08.23.08.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 08:45:50 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: spl: select SPL_BLK for SPL_DM_MMC
Date: Wed, 23 Aug 2023 18:45:45 +0300
Message-ID: <20230823154547.10711-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

mmc_bind() in mmc-uclass.c calls blk_create_devicef() which is
defined in blk-uclass.c, so SPL_BLK is required by SPL_DM_MMC.
Implicitly select SPL_BLK for SPL_DM_MMC.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 drivers/mmc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index de01b9687ba..d24677de076 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -46,6 +46,7 @@ config SPL_DM_MMC
 	depends on SPL_DM && DM_MMC
 	default n if ARCH_MVEBU && !MVEBU_SPL_BOOT_DEVICE_MMC
 	default y
+	select SPL_BLK
 	help
 	  This enables the MultiMediaCard (MMC) uclass which supports MMC and
 	  Secure Digital I/O (SDIO) cards. Both removable (SD, micro-SD, etc.)
-- 
2.41.0

