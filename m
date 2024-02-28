Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F83C5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139D588085;
	Wed, 28 Feb 2024 12:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B9187D7E; Wed, 28 Feb 2024 06:53:38 +0100 (CET)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 2AEC587FDC
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 06:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 28 Feb 2024 14:53:30 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
 by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 98AC120584CE;
 Wed, 28 Feb 2024 14:53:30 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Wed, 28 Feb 2024 14:53:30 +0900
Received: from ubuntu-FMVS04001.e01.socionext.com (unknown [10.213.110.223])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id 627C6B62A2;
 Wed, 28 Feb 2024 14:53:30 +0900 (JST)
From: Masahisa Kojima <kojima.masahisa@socionext.com>
To: u-boot@lists.denx.de
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2] FWU: developerbox: read boot index from NOR flash
Date: Wed, 28 Feb 2024 14:53:44 +0900
Message-Id: <20240228055344.2335332-1-kojima.masahisa@socionext.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Feb 2024 12:49:49 +0100
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

Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
---
v1 -> v2
- update my email address

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

