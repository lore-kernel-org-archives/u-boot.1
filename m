Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185FFC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 15:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCA18789D;
	Tue,  5 Dec 2023 16:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IN9Tsgch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6613A8775C; Tue,  5 Dec 2023 16:55:35 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C9A87635
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 16:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtQjH126246;
 Tue, 5 Dec 2023 09:55:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701791726;
 bh=9gzi29moKe20D3PKSZ0JX0ZThTA1qoyzLSXPPzWEHLg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IN9Tsgchr0db2kaPCDgxzKL/DsnpsUZS+6Ur9kbclkRiJiW97KdoTqI1E3kluXgqw
 v7t9uYSzjzICeWua/ipjhTrSIFdaF/pp6MCqrAh41p4rUk9T4stczeFxji2rcyZ0Ou
 ZP2bI+ujycGh4QD7vrkfEYKQuYeU70UTWO1vT/CU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5FtQQf077834
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 09:55:26 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 09:55:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 09:55:26 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtP03003641;
 Tue, 5 Dec 2023 09:55:26 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 1/8] spl: Enforce framebuffer reservation from end of RAM
Date: Tue, 5 Dec 2023 21:25:16 +0530
Message-ID: <20231205155523.721784-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205155523.721784-1-devarsht@ti.com>
References: <20231205155523.721784-1-devarsht@ti.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
V2:
No change.

V3:
Change spl_reserve_video to spl_reserve_video_from_ram_top
which enforce framebuffer reservation from end of RAM.

V4:
Split this to an independent patch with more details added
in comments for API in header file.

V5:
Add Reviewed-By
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

