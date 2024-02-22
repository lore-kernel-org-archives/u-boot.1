Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAB7C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 13:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56085880B2;
	Thu, 22 Feb 2024 14:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GKW3eSzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B97880A9; Thu, 22 Feb 2024 14:08:31 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA532880A9
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 14:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8FuM046996;
 Thu, 22 Feb 2024 07:08:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708607295;
 bh=oES5kphlxaF6IcGouGd9QgKs/ZXT929fK91P+ApyXyg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GKW3eSzgwfqndLe6Y1g2n/0/ngsXY+La9vo7PEz1jI5FP8y5isNnKRiexgt1+SZlJ
 ecCkmc16dIK8zBRW193Mi/502jZt30RMwPopIoyTFp6BkvYLWyLWRPMxDOGaTso9OP
 u7AiU1ZuW8jrcl/Kb09Mq8N0UcpHJAeMc4wajDiU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MD8F3r020560
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 07:08:15 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:08:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:08:14 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8DhV121382;
 Thu, 22 Feb 2024 07:08:14 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
 <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH 1/4] boot: fdt_simplefb: Enumerate framebuffer info from video
 handoff
Date: Thu, 22 Feb 2024 18:38:08 +0530
Message-ID: <20240222130811.3878567-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222130811.3878567-1-devarsht@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
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

Enable and update simple-framebuffer node using the video handoff
bloblist if video was enabled at SPL stage and corresponding video
bloblist was received at u-boot proper with necessary parameters.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 boot/fdt_simplefb.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 069ced75a7..b0221eaf2a 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -12,6 +12,8 @@
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <video.h>
+#include <spl.h>
+#include <bloblist.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -26,15 +28,29 @@ static int fdt_simplefb_configure_node(void *blob, int off)
 	struct udevice *dev;
 	int ret;
 
-	ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
-	if (ret)
-		return ret;
-	uc_priv = dev_get_uclass_priv(dev);
-	plat = dev_get_uclass_plat(dev);
-	xsize = uc_priv->xsize;
-	ysize = uc_priv->ysize;
-	bpix = uc_priv->bpix;
-	fb_base = plat->base;
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
+		struct video_handoff *ho;
+
+		ho = bloblist_find(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho));
+		if (!ho)
+			return log_msg_ret("Missing video bloblist", -ENOENT);
+
+		xsize = ho->xsize;
+		ysize = ho->ysize;
+		bpix = ho->bpix;
+		fb_base = ho->fb;
+	} else {
+		ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
+		if (ret)
+			return ret;
+		uc_priv = dev_get_uclass_priv(dev);
+		plat = dev_get_uclass_plat(dev);
+		xsize = uc_priv->xsize;
+		ysize = uc_priv->ysize;
+		bpix = uc_priv->bpix;
+		fb_base = plat->base;
+	}
+
 	switch (bpix) {
 	case 4: /* VIDEO_BPP16 */
 		name = "r5g6b5";
-- 
2.34.1

