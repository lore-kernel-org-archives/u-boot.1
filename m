Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D09C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 02:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6409887D2F;
	Thu,  8 Feb 2024 03:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FPqT0xgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34B787D3B; Thu,  8 Feb 2024 03:36:58 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77EFB87D26
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 03:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d9bd8fa49eso11019405ad.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 18:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707359805; x=1707964605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxC8Vnhpi8jrCePDG4XFByBYmHErAWxBLOTTaZ7IB78=;
 b=FPqT0xgz3Pk1PF0L/MzM87OFxGcUjpbb5JcSODKcdv3Z4HIzQvLmgOwVKf5SpqaoHK
 JJRxI+7DA7F4AqQ80+FDFdPAIMzW7jITQnV0x2wtUzt2lwNcvhLlhlvcH0Qcnuw+93/o
 vrbJJK8bupI4h4LWjwmxHmF6Z3g7CuhstvWf0VsnkGGXoQ7JwedhIaelkBQIhjAEikRp
 2kN0exhmaMemH8JWXWEZfkya2UaR2pCcNcx1nWsrROjJoYB7aWOwnolCPyT6nJvU6L40
 XdzAsq9fbG8xRzm0EiY2mRQKcNENirKF9/rgeJmgyxs3kJgdajnmH0R/hOABmgc4PgE5
 VQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707359805; x=1707964605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZxC8Vnhpi8jrCePDG4XFByBYmHErAWxBLOTTaZ7IB78=;
 b=ilbSLI0kRb/iIGNNVNKlwtFiNXY3+gUTrIaYplB3EnbPIzoy2OhaCZbBtSChD7cqZz
 Pi8iIh5aJHZzG3jyksg15JK+bGjGRaAUNiIr7uMeyhF9BtkQ84nMJ3APQYv0Jo0fI0qV
 M2z6v+WehX14DKeMyBT2+hPySibQWBfnXcDCDbXUGs7XqnVx3CF4DEnube/iRj0JJuug
 7pjxM8tE12prE045hZXCuRqZU9Sw0cQvb/H2E2t84RgvkF7feWzi2TW8gc+uvbqeCE31
 nkWtrJ26H3eiqyGdHISgIkWAnIxAtKfOuDG/JPYzFqpao65FA7mcmUWdPOo1NTbTm+o1
 qkSw==
X-Gm-Message-State: AOJu0Yw6fouZkqoZNBySuu40svLW3pbMbxi/ZFPfU3ktHX/RWzvRHSfO
 e0hXhZqhpOL0O0VWD8x3xgksH1lrWbgX33/fae3glGL2LSqzBW6gOUdpbi0NEJ1lfHyuav5K96e
 J
X-Google-Smtp-Source: AGHT+IEE9AA712R2/D7m6h/Tq124EtIoZiMOwpKrj5Uh6ZqQB9YubyabQuSEYbanvkTFRMOxNgwA0w==
X-Received: by 2002:a17:902:dad2:b0:1d9:f00c:1dd5 with SMTP id
 q18-20020a170902dad200b001d9f00c1dd5mr3859974plx.63.1707359805459; 
 Wed, 07 Feb 2024 18:36:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWJJLv8eXXUl8YfmM3Bbm0ztJCCRbVGZRdzoHtsQ7qkmSJNLWvn+od7l62bh/HztDOSbP+vNA5JBHy9IezXxiU/m6Of/hquqUt1oMmVcE6/aLHpSDvfZVDOfoCQf4Q94C0UazxtHkoGXq6tOTAyoescqxLvpeWJw9H3TXuFdo2D46IW/g==
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 o15-20020a170902d4cf00b001d8f3f91a23sm2185573plg.258.2024.02.07.18.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 18:36:44 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] FWU: developerbox: read boot index from NOR flash
Date: Thu,  8 Feb 2024 11:33:44 +0900
Message-Id: <20240208023345.1601269-1-masahisa.kojima@linaro.org>
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

The FWU Multi Bank Update feature allows the platform to boot the
firmware images from one of the partitions(banks).
On the Developerbox, SCP-firmware running on the SCB(Cortex-M3)
passes the value of the boot index on the NOR flash.
Add a function to read the boot index value from the NOR flash.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 board/socionext/developerbox/fwu_plat.c | 31 +++++++++++++++++++++++++
 include/configs/synquacer.h             |  1 +
 2 files changed, 32 insertions(+)

diff --git a/board/socionext/developerbox/fwu_plat.c b/board/socionext/developerbox/fwu_plat.c
index e724e702bd..26031795b0 100644
--- a/board/socionext/developerbox/fwu_plat.c
+++ b/board/socionext/developerbox/fwu_plat.c
@@ -35,3 +35,34 @@ void set_dfu_alt_info(char *interface, char *devstr)
 
 	env_set("dfu_alt_info", buf);
 }
+
+/**
+ * fwu_plat_get_bootidx() - Get the value of the boot index
+ * @boot_idx: Boot index value
+ *
+ * Get the value of the bank(partition) from which the platform
+ * has booted. This value is passed to U-Boot from the earlier
+ * stage bootloader which loads and boots all the relevant
+ * firmware images
+ */
+void fwu_plat_get_bootidx(uint *boot_idx)
+{
+	int ret;
+	u32 buf;
+	size_t readlen;
+	struct mtd_info *mtd;
+
+	*boot_idx = 0;
+
+	mtd_probe_devices();
+	mtd = get_mtd_device_nm("nor1");
+	if (IS_ERR_OR_NULL(mtd))
+		return;
+
+	ret = mtd_read(mtd, SCB_PLAT_METADATA_OFFSET, sizeof(buf),
+		       &readlen, (u_char *)&buf);
+	if (ret < 0)
+		return;
+
+	*boot_idx = buf;
+}
diff --git a/include/configs/synquacer.h b/include/configs/synquacer.h
index e36e63e81e..f0867227ac 100644
--- a/include/configs/synquacer.h
+++ b/include/configs/synquacer.h
@@ -21,6 +21,7 @@
 /*
  * Boot info
  */
+#define SCB_PLAT_METADATA_OFFSET	(0x510000)
 
 /*
  * Hardware drivers support
-- 
2.34.1

