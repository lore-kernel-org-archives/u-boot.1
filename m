Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1773CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8556183858;
	Fri, 26 Sep 2025 17:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NjrWWG2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B2D8387E; Fri, 26 Sep 2025 17:31:51 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6318385B
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-88432e27c77so98765139f.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900708; x=1759505508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8OTYMuUnBmk63ZWC+sU5NdborgSyWXE+r10eonDH3Ko=;
 b=NjrWWG2ODDpFkDxr+T/WvEjeEP0Oxds4xxWcbsWEowgh7/yA5TVO+BGZneJpaosHYC
 jyev17hHmRIZBWdTiA0q7QjUCbR3w2GDQ78R5S5LMtKdlbfBYEFtveJqqd/niiZm2AzA
 pqcpZQUirtGhwuUoVV+lRwXvUd/8VT/IY+36I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900708; x=1759505508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8OTYMuUnBmk63ZWC+sU5NdborgSyWXE+r10eonDH3Ko=;
 b=Dy3Uy2tHpoJr8+Cu2vUq63nJRGHaG6VfvJVTDJFdO4UF1B0pZHc34LM2fAd9Yo1av+
 39xFO1uzutm20epHHZo1cy24u/fV1EKe+IfADrVolIgDp6jHaxo7SjdGmDTEHZJqkX5N
 fG3W/fJMMuynujiKi5mtvwxm76BVhYfLMGhBTyZRZKSikUpI3nbw0xgYMNhzniRNEbw9
 mWfXrQ8ImywCDy5ZhfHeHQirjR5KWEl8A8YuQi1QPCWn40VQMFJuNOi4b8NwoqNBYQV+
 A1TRdSOv66SCduqNy9IikIn5QufeCsrjZb7EtheWba1pEJrl0StCfdwhGWueGNXN3Z+w
 Yq7A==
X-Gm-Message-State: AOJu0Ywbety7OKSmjs3kgNzNiGN7kZFsxSOdpeNleVqHf9kJDq5io5ei
 9qJHU9xqifryf+OCnfWhSBDdgkR9bMSlYrLXklgRd8oq5BMwU8+z7nWz/GDl0TAF65krDgL6xoA
 BtMSFsmI=
X-Gm-Gg: ASbGncsBDa7eI7Gobm50Ey4+ZxSr/ODdWI1GwfpZyKlDwLcVJaUs1afKiZz09EToH6I
 5emlUH6JneDcs2igB8O7emn2gjXEcpslMeG+vqhNwVZasJA5Oq0QJnA73VnzcKCGq+ynP6EGC5t
 qOQl65nehFR4lKeOGKBScNwaIhVblwt2FdZFq+HCgndDogrecitXPHuJte8qeTDsNM52oLi7mPN
 ZYZ5XWNrW2SlW9samZJ+S09H7QMJA+ch8ENWahvD2T45CmTgn6J4OFI5Fpqt/CjbLmiPTOz1jdZ
 qTreBwMn4NGXZ6GvmFtsl9SxLQBtG4Ahkb2xMgTEA7EYA5VKYxzFYL863Z1by3U+cX80yLV8Hdx
 7JO87pO/gIQpgdAyxHsisLnY0NQ4OkVlbx0PcJw8xPvZzbTBvs9rC8ddT52s=
X-Google-Smtp-Source: AGHT+IEErcTVX7QsUZM1aY4HDrsDK5d4rCKRxf3KMXJRC2l5+tOAXQqUUJv9zzDv07AwxDaBYpdO4A==
X-Received: by 2002:a92:ca09:0:b0:425:8a71:b3eb with SMTP id
 e9e14a558f8ab-425955afa50mr131252025ab.4.1758900708347; 
 Fri, 26 Sep 2025 08:31:48 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a69a1b7b2sm1942384173.51.2025.09.26.08.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH] timer: Tighten CADENCE_TTC_TIMER dependencies
Date: Fri, 26 Sep 2025 09:31:46 -0600
Message-ID: <20250926153146.3680952-1-trini@konsulko.com>
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

This driver implements timer_get_boot_us() which is global namespace and
can conflict with other implementations of the function for example in
"allyesconfig". Start by limiting this driver to platforms which use it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I know that the help says Zynq or ZynqMP but only the ZYNQMP_R5
architecture enables this today. I'm happy to expand this dependency
more however or let someone from AMD v2 this.

Cc: Michal Simek <michal.simek@amd.com>
---
 drivers/timer/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 81c154b378a6..5cac1dcf2be9 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -147,7 +147,7 @@ config SPL_ATMEL_TCB_TIMER
 
 config CADENCE_TTC_TIMER
 	bool "Cadence TTC (Triple Timer Counter)"
-	depends on TIMER
+	depends on TIMER && ARCH_ZYNQMP_R5
 	help
 	  Enables support for the cadence ttc driver. This driver is present
 	  on Xilinx Zynq and ZynqMP SoCs.
-- 
2.43.0

