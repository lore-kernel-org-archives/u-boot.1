Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39060C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 07:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6021874F3;
	Fri,  8 Dec 2023 08:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kvoVWCE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64DBA874F6; Fri,  8 Dec 2023 08:53:11 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DF086308
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 08:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c2db2ee28so12850195e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 23:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702021988; x=1702626788;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rvbLHEkY8CkPsdVE9SaVReYC4njaDB//phwKZhoSlMg=;
 b=kvoVWCE5NYo5CH4TzQveOuWzl+Ecb2kORYhEM1eXDT1PX5iookkXQuRHYdNJtmJyEM
 liGJJGmxODk2U5Ee0CsQ9bf/3M8Kiu5o1uQPp5Khl1Hsh1tgnVUJTJdtkIwjm41kKScE
 vZjeFS8s2mdFpWbX9fDWvcQLdtbmyGMWdHcak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702021988; x=1702626788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rvbLHEkY8CkPsdVE9SaVReYC4njaDB//phwKZhoSlMg=;
 b=eSPqA8npmhB7bGlkgnuoM22xGcHnk1FbA/uAsKu3fHZ6Mp12d0bRtIz0Wac9TcFMHq
 5H2ZUMuKMZBm/wXgOKyKcxUrhFWDzw//SADfXXuNECPll1VKrHt0P02N90p+K7CroXHG
 O9J/yiX6UDx10ZfZ/paFHpX9xfp0zXEVUlQrUIYk9H8ln+jv+sK7vdr8grMyR3e4D8XP
 aQFyVD5TGfwuVW0wapTGomHklims9zLg1ve5K0SL8OkYlt0uA93g6Pgs+JMghKfA32RI
 Ez10AKfgr2pss0EqCvBjZlW0NTymTH0sHsQ6xGAo+rulMwRipeJqWKdo0IR1jM72WORT
 ilVw==
X-Gm-Message-State: AOJu0Yxg7bNJklNYPeV8edsbx/ORcd0/pLL9IubCNWWF0yg5E4lCVsnC
 EcYz9bivDdiVIZ3p1qgEUFPUdfv07awgNBTWTgmsyQ==
X-Google-Smtp-Source: AGHT+IED8AunDO8X0YSAcFmj/A8o5bWRLVpiT3eU1KCir2p1eYz1BGJrhEnGZgRbO5ZaRDP7HslOGA==
X-Received: by 2002:a05:600c:1552:b0:40b:5e59:ccc1 with SMTP id
 f18-20020a05600c155200b0040b5e59ccc1mr2571624wmg.162.1702021988289; 
 Thu, 07 Dec 2023 23:53:08 -0800 (PST)
Received: from panicking.amarulasolutions.com ([2.198.79.154])
 by smtp.gmail.com with ESMTPSA id
 he15-20020a05600c540f00b0040b5517ae31sm4320678wmb.6.2023.12.07.23.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 23:53:08 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Nishanth Menon <nm@ti.com>,
	Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de,
	Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] arm: mach-k3: am625: Relax emmc boot condition
Date: Fri,  8 Dec 2023 08:53:05 +0100
Message-Id: <20231208075305.14276-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.40.1
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

spl_mmc_emmc_boot_partition return a number different from 0
if the partition is a boot one. We can have the uboot img
for instance in a raw offset in emmc partition 0 so we would
like to continue to load the next stage. If the user want
to use EMMC as boot device allow him to use any part of the
emmc and not only boot partition

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/mach-k3/am625_init.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 8fa36f7b91..cb4c3a05b5 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -222,11 +222,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 
 	switch (bootmode) {
 	case BOOT_DEVICE_EMMC:
-		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT)) {
-			if (spl_mmc_emmc_boot_partition(mmc))
-				return MMCSD_MODE_EMMCBOOT;
-			return MMCSD_MODE_FS;
-		}
+		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+			return MMCSD_MODE_EMMCBOOT;
 		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
 			return MMCSD_MODE_FS;
 		return MMCSD_MODE_EMMCBOOT;
-- 
2.40.1

