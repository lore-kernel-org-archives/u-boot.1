Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBD5C624D7
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 149BD80ED6;
	Wed,  2 Sep 2026 14:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xAmMVM_2-Pha; Wed,  2 Sep 2026 14:16:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358585;
	bh=1I1vuQxV/Z8i2qDECVlVnDlM3x/aUj5wxWYD6+XB4d8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NEnFaV6av6lo9Hdsm7OtC0wRNfUCbacwlggCeZeu5bQwEP4XuBQJ+yW4G4CYze232
	 eTtA8g+v/ENWmuXBPOXz9Xkejb0g1rJx4rrRxpN+LjB33un2Q7nufIiQUQYKyk7SKL
	 cAWznWV//v1Hw6l34GAeRl1iRPpAE8y33bRGc04TRvBhT1Y3z6cI/tfj4ZToJritvq
	 PyoOsxKDzVV52IR7yRyCKs/L9oVr4F5RAym/jT6xsfeHkeM1bIjzp+0Dv/KytObwCu
	 +VSVB3Mc5AxkyY/ha2kxXFTZUefCcgY1lMCdzWuTLsOBn6NBufI+ecFACNFNXr94LU
	 dGn+G8S3ceiKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E2E480EFB;
	Wed,  2 Sep 2026 14:16:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 698FB230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B2B7606B4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Id7Cz2w2DP5 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QoQVVT91
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FE1F606C4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:20 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48436251906so1214294f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358579; x=1788963379;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1I1vuQxV/Z8i2qDECVlVnDlM3x/aUj5wxWYD6+XB4d8=;
 b=QoQVVT91yFxN95hOIBLV4PrxbBNNDMvfKVdFJj32Zk/uVxQ5pXR12p8+PJJNhvJYzw
 bA/KUZt8RDBm5mmNavYLQsrY2HY+0Mm33mrP7hq5AC9cKdgmIChnktzrPLpsLpLc3B9r
 lBwJr2EGbHzIkWquL6qB38cuxtQ91P+q3T/59B6DBBTtMXCrZa4bN7qNGF2saIDZSOP4
 0jDCJFDa1L/x+IfApy7oIS4dwwCLXC4RtdWBZFuFs8ncyusun0K0RA+89qEMM3fZbGHx
 3CwEwu9HxybwB2JEYcyMGzDw0vIkZDwEcujvcfOHUyMwT83e2ejVzP7ttt1SqzBIG9aV
 08GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358579; x=1788963379;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1I1vuQxV/Z8i2qDECVlVnDlM3x/aUj5wxWYD6+XB4d8=;
 b=cRH+QKz+UIiaetV9lekGLQBuXaRMFlPQ1r+pQeEwHLwuMj0abc1cTWrm2mNyrvq5yW
 VD/v7AUEm5h7RTQDBA4rbVG17Pwea8bXM5FobrtzNEI96oDee2pHXvkp4uSiPMbD8nzV
 gQTg863gQHZgaOb36r31DJZO1zmdO3yZsRJ528VDvqHYrM3EoLGDvT7U+wfKEZ1emIke
 HVzELRHaR28NW5657D7X82WJlsS1zTEH/fwQLnorM46OJIkNypBbntW5cnG7H66KYvR3
 FLvuNsmwGve2HyimH1Pea2MmS84QDZOA7qEVB2OmBIS8hY+BW5/jSE4q61z7+e9YGoLY
 UzAQ==
X-Gm-Message-State: AFuF++kBnOaLGUQNRw5oiT0sVPj1QxciabAEILUCo39yW7XJo6IPIKbT
 rVxy1Kt5eJtI9VrWY4P7fe/ne5m8TYn9Ud7925UyHMf9jZCIkiF/cZHMRXNErHJ5JjE=
X-Gm-Gg: AYBFou3Eckm2bwTBmVpwIZ4e/Uvy3bbBrprh1NAllbyelEVchjRRd1gQdZsdfoNvdZ+
 ZTLRtoy/27IveLd2NQGMawid8HF/FqpHJcK2QSEewkcF6EaIZnIlhf9X8VoCH2kmIY0aCIJ4Xkj
 YE37KTncvjO7Qmkox6BcoFBlh66ydQgZODgojHOizrsZacWFTBLUHUTeo6CsdH+omBWpsJyudal
 0fzpYyR1tSu68Wpi6VJgy5WtYG/oCBF9CHnAyUQ7TOeNxxeaeOWhEqY2B3Bt880eRBXuJz6A/U2
 ZpZ15U4IOgmhwRzFaLWD2KzjsNYUTooMUC+XZ++UM8V9w1XESRj/nbyFidpuayicfL9AthVjVZ6
 nW7o+aovXBE3LXP9IJtWnoNXdh2Tnifrt/6asxZU8kV+BiDfbALwwnUJ29IBUJ/6Z6gUnbpsYn4
 kNNn4N3o5eQxp4eFQEsu602C64+qWrg0WqKu8GP4IpEDDGqfbqxADg8KAtc5zXFY/xwpfEQsiyD
 HiyXeZ5hI6Mu4qrOmDX4FksTnbnxhE5FYmDiC3VGytdYyVwQq6qD9l6mdpRQ1TVPjp97S+d3wEG
 qm2nWQvNnM6TikePpSK5iE1hFIIYjPSQ7Z7gqiRa7fX1
X-Received: by 2002:a05:6000:2209:b0:47f:6f9e:1e82 with SMTP id
 ffacd0b85a97d-48488e045bdmr9108845f8f.9.1788358578773; 
 Wed, 02 Sep 2026 07:16:18 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:15:52 +0200
Subject: [PATCH v4 02/14] video: mediatek: add ethdr component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-2-7c3b4f068a56@baylibre.com>
References: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
In-Reply-To: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
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

The ETHDR is one of the components of the video pipeline on some
MediaTek SoCs, such as the MT8188. Only its mixer sub-block is used,
which is the block's first register window.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_ethdr.c | 72 ++++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_ethdr.h | 16 +++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/video/mediatek/mtk_ethdr.c b/drivers/video/mediatek/mtk_ethdr.c
new file mode 100644
index 00000000000..7584fd565f5
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_ethdr.h"
+
+#define MIX_EN				0xc
+#define MIX_ROI_SIZE			0x18
+#define MIX_DATAPATH_CON		0x1c
+#define OUTPUT_NO_RND				BIT(3)
+#define SOURCE_RGB_SEL				BIT(7)
+#define BACKGROUND_RELAY			(4 << 9)
+#define MIX_ROI_BGCLR			0x20
+#define BGCLR_BLACK				0xff000000
+#define MIX_SRC_CON			0x24
+#define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
+#define NON_PREMULTI_SOURCE			(2 << 12)
+#define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
+#define MIX_FUNC_DCM0			0x120
+#define MIX_FUNC_DCM1			0x124
+#define MIX_FUNC_DCM_ENABLE			0xffffffff
+
+/* Fields used by this driver but not present in the upstream driver */
+#define MIX_SRC_L2_EN				BIT(2)
+#define L2_SRC_SEL				(2 << 20)
+#define L2_OUT_SEL				(2 << 22)
+
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height)
+{
+	/* enable internal clocks */
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM0, MIX_FUNC_DCM_ENABLE);
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM1, MIX_FUNC_DCM_ENABLE);
+
+	/* enable mixer */
+	mtk_disp_comp_write(dev, MIX_EN, 0x1);
+
+	mtk_disp_comp_write(dev, MIX_ROI_SIZE, (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_DATAPATH_CON,
+			    OUTPUT_NO_RND | SOURCE_RGB_SEL | BACKGROUND_RELAY);
+	mtk_disp_comp_write(dev, MIX_L_SRC_SIZE(2), (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_ROI_BGCLR, BGCLR_BLACK);
+
+	/* only configure L2 since only rdma4 and rdma5 are used */
+	mtk_disp_comp_write(dev, MIX_L_SRC_CON(2), NON_PREMULTI_SOURCE);
+	mtk_disp_comp_write(dev, MIX_SRC_CON,
+			    MIX_SRC_L2_EN | L2_SRC_SEL | L2_OUT_SEL);
+}
+
+static const struct udevice_id mtk_ethdr_ids[] = {
+	{ .compatible = "mediatek,mt8195-disp-ethdr" },
+	{ }
+};
+
+/*
+ * The mixer is the first register window ("mixer" in reg-names) of the
+ * ethdr block, so binding the ethdr node with default register index 0
+ * gives the mixer registers.
+ */
+U_BOOT_DRIVER(mtk_ethdr) = {
+	.name	   = "mtk_ethdr",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_ethdr_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_ethdr.h b/drivers/video/mediatek/mtk_ethdr.h
new file mode 100644
index 00000000000..5242b362268
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_ETHDR_H
+#define _MTK_ETHDR_H
+
+struct udevice;
+
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height);
+
+#endif

-- 
2.55.0

