Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD4FC4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 16:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059648749E;
	Sat, 25 Nov 2023 17:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="imTHJF36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514F08712E; Sat, 25 Nov 2023 17:27:18 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6677F87243
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 17:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3APGR8Cv053076;
 Sat, 25 Nov 2023 10:27:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700929628;
 bh=J6o1HF2Yd4mJbybgru8qw1XZi4NTYX7HYS+70rjpVjA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=imTHJF36UXRaNc0CrpNWCaS7KpBJD/dJzChTnwJUasNNmm7r+IO7o0nI2cScDTq+R
 1CAdyu1ghTKW90Z9i6ckYytroaL4ycE5Po+mjaT67aXe4XZU+cLU5xADdaUvBvOHKo
 OV5nARZFJ3ueDCVJ0T+vEtXnPK1bFTaaWV5W6/hM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3APGR8YJ110382
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Nov 2023 10:27:08 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 25
 Nov 2023 10:27:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 25 Nov 2023 10:27:07 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3APGR6hm086017;
 Sat, 25 Nov 2023 10:27:07 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 1/8] spl: Enforce framebuffer reservation from end of RAM
Date: Sat, 25 Nov 2023 21:56:58 +0530
Message-ID: <20231125162705.1383401-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125162705.1383401-1-devarsht@ti.com>
References: <20231125162705.1383401-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add an API which enforces framebuffer reservation from end of RAM.
This is done so that next stage can directly skip this region before
carrying out further reservations.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2:
No change.

V3:
Change spl_reserve_video to spl_reserve_video_from_ram_top
which enforce framebuffer reservation from end of RAM.

V4:
Split this to an independent patch with more details added
in comments for API in header file.
---
 common/spl/spl.c | 19 +++++++++++++++++++
 include/spl.h    | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 3ce5bfeec8..b65c439e7a 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -42,6 +42,7 @@
 #include <fdt_support.h>
 #include <bootcount.h>
 #include <wdt.h>
+#include <video.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 DECLARE_BINMAN_MAGIC_SYM;
@@ -152,6 +153,24 @@ void spl_fixup_fdt(void *fdt_blob)
 #endif
 }
 
+int spl_reserve_video_from_ram_top(void)
+{
+	if (CONFIG_IS_ENABLED(VIDEO)) {
+		ulong addr;
+		int ret;
+
+		addr = gd->ram_top;
+		ret = video_reserve(&addr);
+		if (ret)
+			return ret;
+		debug("Reserving %luk for video at: %08lx\n",
+		      ((unsigned long)gd->relocaddr - addr) >> 10, addr);
+		gd->relocaddr = addr;
+	}
+
+	return 0;
+}
+
 ulong spl_get_image_pos(void)
 {
 	if (!CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS))
diff --git a/include/spl.h b/include/spl.h
index 0952188901..043875f10f 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -889,6 +889,16 @@ int spl_usb_load(struct spl_image_info *spl_image,
 
 int spl_ymodem_load_image(struct spl_image_info *spl_image,
 			  struct spl_boot_device *bootdev);
+/**
+ * spl_reserve_video_from_ram_top() - Reserve framebuffer memory from end of RAM
+ *
+ * This enforces framebuffer reservation at SPL stage from end of RAM so that
+ * next stage can directly skip this pre-reserved area before carrying out
+ * further reservations. The allocation address is stored in struct video_uc_plat.
+ *
+ * Return: 0 on success, otherwise error code
+ */
+int spl_reserve_video_from_ram_top(void);
 
 /**
  * spl_invoke_atf - boot using an ARM trusted firmware image
-- 
2.34.1

