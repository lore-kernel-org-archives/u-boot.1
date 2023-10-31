Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57896C4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6AD987CCF;
	Tue, 31 Oct 2023 14:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n41DkO2Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5441087CBC; Tue, 31 Oct 2023 14:12:24 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B91D87CC0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDCFYG011079;
 Tue, 31 Oct 2023 08:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698757935;
 bh=bQKEexrlk4P8CpipyJZM2MKplx01jHZMxJd3r4z9V84=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=n41DkO2QbVpmJiMQIQVYXLKEuNBvcKwvNdjoUyaeuozSzpygnCeeLvmEWavfKHUJn
 yFnbLYEN9Ubzv+PCAQIVPPO73wG7PV2sgGZXfXXWhi0Feq3NhmoUtc+Y1WLWg1BDT/
 SIOOQsgfpuwoVAVVI+ZGTCxH5P85XykWsNzrCf44=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDCF0A000312
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:12:15 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:12:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:12:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDCES0010537;
 Tue, 31 Oct 2023 08:12:15 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2 4/5] video: Skip framebuffer reservation if already reserved
Date: Tue, 31 Oct 2023 18:42:07 +0530
Message-ID: <20231031131208.435268-5-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031131208.435268-1-devarsht@ti.com>
References: <20231031131208.435268-1-devarsht@ti.com>
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
---
 drivers/video/video-uclass.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index f743ed74c8..335a1a1828 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -123,6 +123,18 @@ int video_reserve(ulong *addrp)
 	struct udevice *dev;
 	ulong size;
 
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
+		/* Skip allocation if already received a bloblist which
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

