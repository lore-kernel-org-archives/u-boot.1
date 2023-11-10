Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF44AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 15:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF8DC87836;
	Fri, 10 Nov 2023 16:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nuAvTawO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF83787837; Fri, 10 Nov 2023 16:29:58 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18CE87829
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAFTqhS075928;
 Fri, 10 Nov 2023 09:29:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699630192;
 bh=dPiQRW+BaPviG85DBrFywrTTLq1YnTYSetWvms5cDvY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nuAvTawOjHN9cNiYCI0jNbjnlRnja2b1qAVK2N9wktTuFouum+ys595iPXod/zqBq
 b9p1/QYBDH0BUb960dsZ+g214whKUFiWg2c48n50p7xEVSUkz3EilRuYjcLcR/y4jq
 VOZDoYu+w2ZcP2a/sLSH5XMGfwk+o8xu8D5VQzf0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAFTqvD016966
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 Nov 2023 09:29:52 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 09:29:51 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 09:29:51 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAFTpPm011662;
 Fri, 10 Nov 2023 09:29:51 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2 4/6] video: Skip framebuffer reservation if already reserved
Date: Fri, 10 Nov 2023 20:59:42 +0530
Message-ID: <20231110152944.647535-5-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110152944.647535-1-devarsht@ti.com>
References: <20231110152944.647535-1-devarsht@ti.com>
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

Skip framebufer reservation if it was already reserved
from previous stage and whose information was passed
using a bloblist.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
V2:
- Add debug prints
- Fix commenting style
V3:
- Fix commenting style
---
 drivers/video/video-uclass.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index f743ed74c8..f619b5ae56 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -123,6 +123,19 @@ int video_reserve(ulong *addrp)
 	struct udevice *dev;
 	ulong size;
 
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
+		/*
+		 * Skip allocation if already received a bloblist which
+		 * filled below fields
+		 */
+		if (gd->fb_base && gd->video_top && gd->video_bottom) {
+			debug("Found pre-reserved video memory from %lx to %lx\n",
+			      gd->video_bottom, gd->video_top);
+			debug("Skipping video frame buffer allocation\n");
+			return 0;
+		}
+	}
+
 	gd->video_top = *addrp;
 	for (uclass_find_first_device(UCLASS_VIDEO, &dev);
 	     dev;
-- 
2.34.1

