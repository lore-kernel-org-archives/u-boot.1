Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90421CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77AFC86DDE;
	Mon, 16 Oct 2023 18:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HCxnEULd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BE086D75; Mon, 16 Oct 2023 18:06:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9BF86D2D
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6Ire079862;
 Mon, 16 Oct 2023 11:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697472378;
 bh=a1WmukxhpzZnuzDlWKgPyWsTVScSo5NZSKSyX1d3WQA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HCxnEULdEoPnrrQ3SPjO5vBtFWG91sY0Dj1hyIPjav5k+OL7HDhtd85HoUryD4TF5
 0lFYdg9A+b3iOQ7SmWidjpIVefLFhJ+TtLZSBc+TqDX/RteULFF1S1Hy1QktoBUitB
 MsFgg5lmM0vZKAIgwFiH7ZcIC1JI1oGXBgQV2m9A=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GG6I2I079309
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 11:06:18 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 11:06:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 11:06:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6HHB099019;
 Mon, 16 Oct 2023 11:06:18 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <devarsht@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
Subject: [RFC PATCH 4/5] video: Skip framebuffer reservation if already
 reserved
Date: Mon, 16 Oct 2023 21:36:10 +0530
Message-ID: <20231016160611.1353458-5-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016160611.1353458-1-devarsht@ti.com>
References: <20231016160611.1353458-1-devarsht@ti.com>
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
---
 drivers/video/video-uclass.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index f743ed74c8..bac30187e7 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -123,6 +123,14 @@ int video_reserve(ulong *addrp)
 	struct udevice *dev;
 	ulong size;
 
+
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
+		/* Skip allocation if already received a bloblist which
+		 * filled below fields */
+		if (gd->fb_base && gd->video_top && gd->video_bottom)
+			return 0;
+	}
+
 	gd->video_top = *addrp;
 	for (uclass_find_first_device(UCLASS_VIDEO, &dev);
 	     dev;
-- 
2.34.1

