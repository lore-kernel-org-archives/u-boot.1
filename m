Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC14C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE965406E5;
	Wed, 26 Aug 2026 13:09:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xpYMC06qbEEg; Wed, 26 Aug 2026 13:09:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749788;
	bh=iWA9t6PxZAbqPys8tHF52SD8+kBt/+v5K9crykp7xec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o7v5dtYCd7tFdyfs2oHT5sHuDpJjDsCQlCozNaHF7/WzZZ3LpQCWJNxHCzw5/Ij0V
	 hwTNK/zSd2OLJQpeRGFW2ZduW8+4uJOknQujjZ1T5jKkSlLXUm1pkJ4HBW6fz11gOU
	 SPM11pNcybNw7Jd+7jaMO8xOdFGt/EB/nGtJYbwQpSZt7EOgXizQLfSW7EvUNlZ/Dc
	 nsk1equrkUQuCkSMQa0ADBHqg/+puzXAGmgHmsXsDInVXv6x73PXFNl7CMQF5o88Ry
	 XVw9DWaUdJC1bvlFtywa2rdyOuIXGbKxr1MPBwqHctEvurrWFShFJNk89aPvGBQvOT
	 RWBeQCJFLN9ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D1B9406AC;
	Wed, 26 Aug 2026 13:09:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EAB13AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C357406C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9kqFYjWYAvkh for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TmMAFKJw
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78A1140684
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:41 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-482e61a34e5so165213f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749780; x=1788354580;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iWA9t6PxZAbqPys8tHF52SD8+kBt/+v5K9crykp7xec=;
 b=TmMAFKJwUP9YtbHYjf4lVY76V6Ch35vla6j4jeaf7z9Te6PmD8Ol6g6+mNmS6bVTAD
 3AQucgQrvLcK2gft4OJdyF/AOjHpwKAjdHmp5eFxyVmxNzbKPUwtMKqdG5TDsu5viPKr
 Zv1PLMdr5671uF6V4gv9WR3xuX3x/90/1oCHnTRB7Q+53pMb1wcWgldPBXC9IkSnNSya
 79LJJ+DlszLMhGCk36//TpsBrsm0s0iL/YNDc8iBQJxkpvueprjq0oMrD9uWXtVGqESe
 3Kh+OUNWz1ahy2Svhs0gpcvbruniG91YiXPjs9y6C7dxgXVwY7Wv2hyYWbjzqsGvwqtL
 3ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749780; x=1788354580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iWA9t6PxZAbqPys8tHF52SD8+kBt/+v5K9crykp7xec=;
 b=m3gBOpv74wfP+ukC9HSQgNva3DKNZSfGknbnp+4cibnj5GcL2X6T0M8V5T8KHbrYNs
 7+LWNPbSepeNC6Am6ybj0alwEf8e9vUUz36g7HbCmadursJ/BPak8B09H3+MKlZVL870
 +OWCo+D+JzJB/QBW2gvYpD8PXtp1MLgTIJXMN7q8vRiN7btCaD0YWTeGQKlR68jx7Uvn
 arJFrT5gIGX7GA3X6ofL+R5wCrjiF6PbSqfqm7IckG5E9kv3w+gR4WzlnlERFWagMx32
 oTGV1SWGYbi1s9CT7Qje1eyOQkaVudMg/ktDUTIGgQjfgO/h7UyYmMSacfcK1sFEEPHi
 SCIw==
X-Gm-Message-State: AFuF++lDLsFWSLY1XDs//ijnT5V/tL0kY/ykq01jp2hmdhQOHnkV7Fq3
 ierWE365DU1xTR/iNYwWkdWV6N8/D9+gwqFXeu94ojJ2uMVfUngF7HlUEdOHT4FjtvJThYXNRvb
 hG7dQ
X-Gm-Gg: AR+sD10Zx91U++jWZYt6IosrKEqY4ak0Zj/yPV6QfjvWZxVH11DONveNrXmZ/ZIdeF+
 JBpHD2HUlQVNYZYYR8m5HKdH75DV4YDuEEa3cV8PuQcdHPEJpHQ8DrVtPa2UBS13PukBMiofgO9
 99yBwuRFmzamDnzlya51VtWU6X5BudTieSjVw9RuQXRbTOEzyvL1SVXRylXUOce37RZ//7i67nV
 BRVq/5X9CA2IfCPRcNmMUuAFNs2QtElMkSUX5gNVs695PX1Jrhg6n5/iCGp4bw/YdlGHeO/eHx7
 E+NTNLVI8KAGPVA4w3Y+nMoRTVTJYffxBQNl1/zHGLSdOi4UW8NJolEwfKwzBorzOXmnH/lfBME
 FCAHEgRAldVqJexCVuKBPCGIHTa8TVdIGw9m6ayodhDgor3JNTHu8POTOmaCGxcB3huvGHSrSfz
 VwaiBAbDZMWk/CsjtHcYJEBtbCQiMj1+CMQPdCYvy2WO1Y4/pJejJzW9dCXQTd+QJ1CZ+kSnvCz
 XFeEV1AYZmOTEvRCwtmv7prt30S5d4lguHW6uuKDr+IdRLfZW9YjHykqS5LvOxnhZNGd7B+OjBg
 Rk0FT9IgBf/8MDDT6I859xwjjcnnGMCurCTF5xzcDfnW1uwCuAe1+1Mz
X-Received: by 2002:a05:6000:4910:b0:482:daf8:a3d7 with SMTP id
 ffacd0b85a97d-482e2673529mr7548056f8f.3.1787749779987; 
 Wed, 26 Aug 2026 06:09:39 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:37 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:34 +0200
Subject: [PATCH v2 07/14] video: mediatek: add smi larb driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-7-68ebb1bf17df@baylibre.com>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The SMI local arbiters (larbs) gate a subsystem's access to DRAM. On the
MT8188 the display data path feeds through the VDO1 larbs (larb2 and
larb3), whose clocks must be ungated for the HDMI pipeline to reach the
framebuffer.

There is no dedicated SMI larb driver upstream, as Linux handles the
larbs through its SMI/IOMMU framework. Add a minimal U-Boot driver that
binds the "mediatek,mt8188-smi-larb" nodes and ungates their clocks,
reusing the display pipeline component helpers for the register window
and clock bulk.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_smi_larb.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/video/mediatek/mtk_smi_larb.c b/drivers/video/mediatek/mtk_smi_larb.c
new file mode 100644
index 00000000000..f180c022126
--- /dev/null
+++ b/drivers/video/mediatek/mtk_smi_larb.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek SMI local arbiter (larb) driver
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+
+/*
+ * The SMI larbs gate a subsystem's access to DRAM. They have no dedicated
+ * driver upstream (the SMI/IOMMU framework handles them), so bind a minimal
+ * driver that just ungates their clocks, reusing the display component
+ * helpers for the register window and clock bulk.
+ */
+static const struct udevice_id mtk_smi_larb_ids[] = {
+	{ .compatible = "mediatek,mt8188-smi-larb" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_smi_larb) = {
+	.name	   = "mtk_smi_larb",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_smi_larb_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};

-- 
2.54.0

