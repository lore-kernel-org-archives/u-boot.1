Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39531C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 17:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 892AC82FC7;
	Tue, 12 Aug 2025 19:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hdo9eyu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B73882F8F; Tue, 12 Aug 2025 19:46:28 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38FBC82EB8
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 19:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76bdce2ee10so4706061b3a.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755020785; x=1755625585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9pG1Wf9Il8BJFgJEksHbi0mRSc5fMNj2JJjFre3qfM8=;
 b=hdo9eyu9C+yXLZO7YE+3vQgwnDP5pHYxknvUckyZ+MHnNZVsSfq0/hjRxiZuwjcjTa
 vl6bT0nCfQzv0CfwK6gsTpRvVb3pF6YM/i/BhruyYjHT8NdnMv92GGpp7jbEGP5blRHG
 CaA7jvdR3dvo8lxcOEkIw74J+ZPU8ZEK0f8ziQA4wKIfdRwteCKIQXKkW3ykE0s0xACh
 /zZhfDE3AQuKQLUTnxzOieVlnJqB2efG3OglLP/sABGE2iwUF4jTsdIwZ3QO4Vn078fy
 aYlVYzEu6qCslb3K57Ii3Qd4vBJ6TPfu22LO5mkcUREZb2Mvoc0T8L9jbkXlwgIst0Ys
 0Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755020785; x=1755625585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9pG1Wf9Il8BJFgJEksHbi0mRSc5fMNj2JJjFre3qfM8=;
 b=V4MLroHnBEFYMzH+AHgEPXasWDD34+fIbSrGPXoj1rkH6jXmvy3UV+tNOgrsvHCqXO
 nyQUhgu/1a4azIwUop2I867NwuRG+ycR450z2Gdx2Cf+hrUKCbI5y/e/YRcCEmFxjJHt
 KmcDVUnMAvAEeS5rIPvcTP4y7kGnV68Y3sAcocwsiA3TMqemXEhQH9CqqQsz77H0E7gS
 XXJYFX7TozMya6qoCXheao/gzHW2et2LVseFJ2WGkmBfZfGsskM6qZv2Obdn+neEgplk
 jyuenHsqsvay1QtvXjiiRKc/af7Ye9uO2386wWDrFLuTKyQEn8yxGxElo9Xu/SVaj+6L
 vrqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKwBxTQBkf4CvpuYpL3jn6ip5fEnvoD7h5hl8T/lfhafrj2YI7ONohrJenjWe1YpbJiOPftKc=@lists.denx.de
X-Gm-Message-State: AOJu0YxU4nlz+8SRjP6OiNiZ0x76YPfdX1YfnMPNLr7rydGUTEkHzOjK
 Bcl25B67CuVnXNunl41v7BYO5Buj/S+rK7PCNV/CwLCfYZGJVxYlb4ov
X-Gm-Gg: ASbGncvmD0I23wR12RIKXbTc5niz6tjhIQ83rOvrsuiudX4E2FBaAR0mQtOR9plbE9d
 V2eQZ/GKR5/BB7GBRRRjo4JmGSrRjK1Pdko2pVW7wUP081pl0Nuv7oTClS4Mxq6phmKrJ3PLKdt
 WgvNO43npaDkg3gGHnDWKu7XmSVjsFc3Dqnkv3zfK971IazSGbhOV8HtBVwGG2tLYreX+qkMp6x
 o5tZimqRMql7NRAmoOhkzHk/7PFf3/eC5DQBhgujxYcVaj3nQtBtbw1NW6mIF5oSW9f/zwT4q44
 6Fd0Gcl/LEOr58H9dWPRfbg5/GegPDA64/i+xCPk5Tc/iGL2uqDpJymux0GiUGsNoKiuAKFLTkf
 qkgwmjwat9uUY2153OvQLt++sIERBx+BGpxD92M0mfpB2am8=
X-Google-Smtp-Source: AGHT+IGqtaiqgZ69mJs7QUDz5bx2o8+fJtLjqaSY9yGVfnhhY+EKK+mjF6fphF3+flCLT0IlMQ6WHA==
X-Received: by 2002:a17:903:3546:b0:240:41a4:96c0 with SMTP id
 d9443c01a7336-2430d1db941mr849755ad.29.1755020784544; 
 Tue, 12 Aug 2025 10:46:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4c8c:4a84:8608:9a5a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef7c30sm304527205ad.37.2025.08.12.10.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 10:46:23 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: joe.hershberger@ni.com, otavio@ossystems.com.br, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] env: fat: Add support for NVME
Date: Tue, 12 Aug 2025 14:46:10 -0300
Message-Id: <20250812174612.1159634-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add support for retrieving the FAT environment from an NVME device, the
same way it can be retrieved from MMC, SCSI, or VIRTIO.

To use the FAT environment from an NVME device, pass
CONFIG_ENV_FAT_INTERFACE="nvme" in the defconfig.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 env/fat.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/env/fat.c b/env/fat.c
index 65ee1c8e086d..412d95dc3057 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -14,8 +14,10 @@
 #include <memalign.h>
 #include <search.h>
 #include <errno.h>
+#include <init.h>
 #include <fat.h>
 #include <mmc.h>
+#include <nvme.h>
 #include <scsi.h>
 #include <virtio.h>
 #include <asm/cache.h>
@@ -136,6 +138,14 @@ static int env_fat_load(void)
 	if (!strcmp(ifname, "virtio"))
 		virtio_init();
 #endif
+#if defined(CONFIG_NVME)
+	if (!strcmp(ifname, "nvme")) {
+		if (IS_ENABLED(CONFIG_PCI))
+			pci_init();
+
+		nvme_scan_namespace();
+	}
+#endif
 #endif
 	part = blk_get_device_part_str(ifname, dev_and_part,
 				       &dev_desc, &info, 1);
-- 
2.34.1

