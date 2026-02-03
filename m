Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C495EE8306E
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 09:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9A58405A;
	Tue,  3 Feb 2026 10:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OWoF7bnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE258405B; Tue,  3 Feb 2026 10:21:41 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E6818404D
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 10:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so43248355e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 01:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770110494; x=1770715294;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cZ+5ORdfWmCafySNhXr4cNArS81nqapJ45KtjZE6WjE=;
 b=OWoF7bnn6lX14NoBOOz4W9f9068GmcMLTHtEKdYexJVbMGjKdX2+EpGvjKG/wPWFtp
 VS7+mim9tGlXEHxtM0bHmSR1vY+zG3pDx6vqug1LnpN1e8F5P5kG6auaRpD8xxBQnXQ2
 bIunxunj2aiYTGttaZeFZ32x9dcI6+KuEU8/Pqf7YlJl71cTrO4P74Hcr/MuLMZgchII
 CDpvkKlENByPBU3UMEbrTjiz6s2aSQXc/REnrPgB7NI1Bazuc7o5Ex2DV8YsRf2JPKQI
 Bn0pJSIxPou0FTW2LfEZZZERBOcCd9+rgpW7UGYiREKqeN+5evpNJZ9KLLvLbuRVso0o
 TY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770110494; x=1770715294;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZ+5ORdfWmCafySNhXr4cNArS81nqapJ45KtjZE6WjE=;
 b=BvXJl8zhGLjDW365ix1SE+ww6Bq30BpiqGVNlvENjciLuPgaRyXT5OjiLoqiplvDqU
 0lRAp3nJmEpq5fnYVG1VglFw0X2mnCD31AKa78sH9VmBa8GOu9pZfpo1BtbfFXO+jrfD
 G1bAAeMDkXGSylJ9P5Sht60zf/Unf390Zz2J9KakvlOA9hRA5t5g7IDsDG6+CtpRc5cF
 8/dt5ukLpy0EzKOJi3g22Jv+5R4Eu61KI8PdNZkZ3bk4mFkACILyz6yhNS8pfL0tA3K4
 9WW+c6jwTJbePmjEYu96K6/iHmcThIfgKvj+aCc8zCo74qUY0LfQ6RFMS6kSkLS4vFwE
 eEHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxUGWVqTBL2tsnrE0DKq/qrmqxi0jccNHBOlt3PJJE6M1Ko03L4x370zlHaXOpdEKzDG51Rqw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0jmsjTpStnudBbN9HHGTvCOq6CRMqzokdjWBMLpibuGioEFYW
 ogKrJonGKQZqtWxOpYyvP1XUe5QzwEDW2QjvXmsGYh0oGHDjX6S/IT5JoaZP8dV/8dM=
X-Gm-Gg: AZuq6aKCGG3G87aBMVS43/WbjbRPNKpphQGOcs9ookfS3DGTASmZL8Ec2ooSnJ8N3eq
 xA4XGXCPtB4uvI8uX2aOQIOCk4Q7mALTbS69mSvjZAFZzojsKjG2oRpAfehRagdHuQGaxONYTaX
 YvDiBbZi0kuXBPCKJFXyiURtKQSL4pkd6Fkc1WmB190d/LBObypfV825OhN9Z3AINASvQFzEDwi
 F85rTq+3L3Q5xhrZhTMspTngQOEriDIMkh2YdyW2bSBNrl/hoRvlclTVmtnTsCCGMplQJdzH0F2
 FiCyIN4YBbb3TctYPHnM0MP63VApInId7WjhTtx4u/hTUQqK4UaSZ71BlZAsTJhRCZpa1wqnr6A
 AZ6/GkoilIcDcKeeWSeC1hSk3p3Pka6McPyOTaTI1fRT6RuclBcIvQ5piwojNIkHWAh0doSLjRe
 4nSMEfGoKMn6YgVEiljhA5+OptLtU8ECQ8iRE6Cq3aKXYEFJhxorZM8irqG0gmj4B9Z46AnnZTw
 j3YXZr0Cg==
X-Received: by 2002:a05:600c:34ce:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-482db491e61mr210622415e9.17.1770110493761; 
 Tue, 03 Feb 2026 01:21:33 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305153842sm52432785e9.10.2026.02.03.01.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 01:21:33 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 03 Feb 2026 10:21:26 +0100
Subject: [PATCH] drivers: ufs: remove unused ufs_post_bind() declaration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-cleanup-ufs-header-v1-1-4c10424485f0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBG4avErBtQo4iuEi3EfnMgLJQikO6et
 PwW7xXKSIJMU1Mo4ZYsR6zQbUMu2LiBZa0mo8ygjOrY7bDxOvnymQPsisToxh5Ge+u0oxqeCV6
 efzov7/sBpoyWGmQAAAA=
X-Change-ID: 20260203-cleanup-ufs-header-e385e21fac1c
To: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Commit 067c1b033282 ("ufs: Call ufs_scsi_bind() from uclass .post_bind")
inlined ufs_scsi_bind() into ufs_post_bind() as trivial
device_bind_driver() call.

ufs_scsi_bind() is no longer referenced anywhere in the codebase, so
drop its declaration from include/ufs.h.

Drivers used to include <ufs.h> to include prototype of ufs_scsi_bind()
function, so we can now safely remove such includes.

Fixes: 067c1b033282 ("ufs: Call ufs_scsi_bind() from uclass .post_bind")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/cdns-platform.c         | 1 -
 drivers/ufs/ufs-amd-versal2.c       | 1 -
 drivers/ufs/ufs-pci.c               | 1 -
 drivers/ufs/ufs-qcom.c              | 1 -
 drivers/ufs/ufs-renesas-rcar-gen5.c | 1 -
 drivers/ufs/ufs-renesas.c           | 1 -
 drivers/ufs/ufs-rockchip.c          | 1 -
 drivers/ufs/ufshcd-dwc.c            | 1 -
 include/ufs.h                       | 9 ---------
 9 files changed, 17 deletions(-)

diff --git a/drivers/ufs/cdns-platform.c b/drivers/ufs/cdns-platform.c
index 87d9c5bad79..40883a187b0 100644
--- a/drivers/ufs/cdns-platform.c
+++ b/drivers/ufs/cdns-platform.c
@@ -7,7 +7,6 @@
 
 #include <clk.h>
 #include <dm.h>
-#include <ufs.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index dd62c9819ba..6c949b2ca76 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -5,7 +5,6 @@
 
 #include <clk.h>
 #include <dm.h>
-#include <ufs.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <zynqmp_firmware.h>
diff --git a/drivers/ufs/ufs-pci.c b/drivers/ufs/ufs-pci.c
index 5b9c72a695d..e1e010d027c 100644
--- a/drivers/ufs/ufs-pci.c
+++ b/drivers/ufs/ufs-pci.c
@@ -7,7 +7,6 @@
 #include <dm.h>
 #include <errno.h>
 #include <pci.h>
-#include <ufs.h>
 #include <dm/device_compat.h>
 #include "ufs.h"
 
diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index ee43958d5d8..dc40ee62daf 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -14,7 +14,6 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <generic-phy.h>
-#include <ufs.h>
 #include <asm/gpio.h>
 #include <interconnect.h>
 
diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
index cc53e91449c..a21ae3f390e 100644
--- a/drivers/ufs/ufs-renesas-rcar-gen5.c
+++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
@@ -7,7 +7,6 @@
 
 #include <clk.h>
 #include <dm.h>
-#include <ufs.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/iopoll.h>
diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
index 5652309911e..a206e3c6d58 100644
--- a/drivers/ufs/ufs-renesas.c
+++ b/drivers/ufs/ufs-renesas.c
@@ -7,7 +7,6 @@
 
 #include <clk.h>
 #include <dm.h>
-#include <ufs.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
index 0384244387d..643a6ffb9bc 100644
--- a/drivers/ufs/ufs-rockchip.c
+++ b/drivers/ufs/ufs-rockchip.c
@@ -13,7 +13,6 @@
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <reset.h>
-#include <ufs.h>
 
 #include "ufs.h"
 #include "unipro.h"
diff --git a/drivers/ufs/ufshcd-dwc.c b/drivers/ufs/ufshcd-dwc.c
index 3f62e59a060..98422d742a0 100644
--- a/drivers/ufs/ufshcd-dwc.c
+++ b/drivers/ufs/ufshcd-dwc.c
@@ -7,7 +7,6 @@
  */
 #include <clk.h>
 #include <dm.h>
-#include <ufs.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
diff --git a/include/ufs.h b/include/ufs.h
index 702b8359dbd..f6e27d90e43 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,13 +20,4 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
-/*
- * ufs_scsi_bind() - Create a new scsi device as a child of the UFS device and
- *		     bind it to the ufs_scsi driver
- * @ufs_dev: UFS device
- * @scsi_devp: Pointer to scsi device
- *
- * Return: 0 if Ok, -ve on error
- */
-int ufs_scsi_bind(struct udevice *ufs_dev, struct udevice **scsi_devp);
 #endif

---
base-commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
change-id: 20260203-cleanup-ufs-header-e385e21fac1c

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

