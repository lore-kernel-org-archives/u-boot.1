Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C152C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E64F18319C;
	Wed, 16 Jul 2025 09:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m1o1Jqru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA96831BE; Wed, 16 Jul 2025 09:37:43 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD2C8319A
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso3584240f8f.3
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 00:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752651460; x=1753256260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qYAvQnGL6nafO1LlhuhqPOSmp6zCR+kKnLXljAit1nU=;
 b=m1o1JqruX5Fy1z47UN7mL9HbPV1Zp9a+/Bf1xZVRhFo2CtBeOiMuzftZGG5blJlUPP
 KFv+Kv6twALvzgqblDkEunG6dXP+eHgMKhZR0tVE97RpyJhnUaE1c8gRHXIkp50wNCeu
 vapCZQsvcWFgXzn2kfPQt9nWNB+1ZbjG2yovV3rBE/wnmrNkW8Ll7xPVfQLEiv4frU//
 vChHCkHmqJY3C63bfOQWea707UOCYpSbMBl2rjmEero+4i2NUp+cLRgYNw3Cq9gRIfjQ
 yFe827d9C3VcFVxeMh6Ls8RwY0Sl2YmHj3frhUH4fUXfQWa5sFxJwN8vpLHDvxN2+R+w
 aS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752651460; x=1753256260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qYAvQnGL6nafO1LlhuhqPOSmp6zCR+kKnLXljAit1nU=;
 b=lTFwguEjuk28UV/q4A+23Oyw97ymJk7a5tuQWK3EEAdA+PVszi+GPFCUHH//HJgIYb
 AhxW2p4yI5PCAdppsSrzzQn6MaH6HhznfOlMx8RucPm2tLmVo9d2F1AqfbE9P14msqlg
 QXBSin9pbv6hcFvmbTECHuotQAVo9CF9hlrdsEvWdyn+y873ijckmp6cZY4zLvy5/PJ7
 QlDKbRWmflmzFDWfktcPH9FevVqL+/7lVbjP1FXP570JbwVQiv44y4bG59ei4xf0sP1J
 /hIbCRhE0wXICUsN2D/U/zY9xq/S8RMsuVUjHQQbcL5V7XltDBj1M3B2aigfVfBj1h2k
 84Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAEySdlbanVwaQhHmC/+jMUPijZxz5/KI/NZsjXoq2VxGNk3W9ShdKsBcKTx3YY8YH+W3GaM0=@lists.denx.de
X-Gm-Message-State: AOJu0YypvBvEaosJwltHxm5h5sxHRBGY5wO94+oTCYCTkktaFWewq7d2
 0SXyZ+o8pDmmnVYetBmewyp6km1uKWP/LfJrkZqRrycTX5sFCTTAa3JyBtucXg==
X-Gm-Gg: ASbGncu8tvw5yOqrBGyZW/RUYJqMe02jt7MvQt5On9Eni0nYAQyJarEfg93IXrNunP5
 /qlj0UHsoUgiFdRgllkR792fB4nb25NYL74nBFv/OmxGmp2CkpmBPMFV3rJZdMxw5y/2HGkcf+p
 17FROiNjOr3uWRAlRLGkWe6xvoRHLAFBHqN8apV1CCNxermMA1IulHgt3LHS8Gxa8SWdnOW7556
 zLChrfUPtjP6GcuFD9KpBPeHWiAWjHkpE0XXBrKgD9U/LRmp4ubJFUYtheif9gR77AOtvms241G
 kxgj3vHo+UfGoiB1Qv3x1oMF/X9MjBwp/JB8SSkDW/ztl7wHSPemMhvFkqTJjJM+Ul7r2Eugj6c
 XZhTTJH601r39gGtmXw4aX2HjhGa29TAjseVnnnS1Qsw1LSV3gh43R2k3Dral3pXgTOttRvbU1h
 HLpJthb6109TbJ
X-Google-Smtp-Source: AGHT+IHinysMZkNb4m5EXtHHbM+ndjjZkiLQC0xU8If0B7BM4YZ1S65qdL44/OdL1PrK1qxzAeueLw==
X-Received: by 2002:a5d:560a:0:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3b60dd8e738mr1319327f8f.56.1752651460221; 
 Wed, 16 Jul 2025 00:37:40 -0700 (PDT)
Received: from localhost.localdomain
 (host-212-171-170-230.retail.telecomitalia.it. [212.171.170.230])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4562e8339d8sm12485495e9.30.2025.07.16.00.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 00:37:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] linux/sizes.h: add SZ_8G for 1GB RAM size
Date: Wed, 16 Jul 2025 09:37:07 +0200
Message-ID: <20250716073716.11698-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Add additional macro to handle a 1GB RAM size in 8Gb.

Drop the redundant entry from the Mediatek arch.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/mach-mediatek/mt7988/init.c | 2 --
 include/linux/sizes.h                | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
index 2efc8c6a88f..2b6f38983af 100644
--- a/arch/arm/mach-mediatek/mt7988/init.c
+++ b/arch/arm/mach-mediatek/mt7988/init.c
@@ -12,8 +12,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define SZ_8G				_AC(0x200000000, ULL)
-
 int dram_init(void)
 {
 	int ret;
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index fbde0bc7e88..35a23d714b7 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -47,5 +47,6 @@
 #define SZ_2G				0x80000000
 
 #define SZ_4G				_AC(0x100000000, ULL)
+#define SZ_8G				_AC(0x200000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */
-- 
2.48.1

