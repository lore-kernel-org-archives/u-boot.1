Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A21C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A904A81010;
	Wed,  2 Sep 2026 14:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bpinZgpR9mcV; Wed,  2 Sep 2026 14:16:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358594;
	bh=hss58b9cl4NnfeSl8E9355QiZ+V5FZb1XDQvYAo2Vis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JuThQxkoqtffZuch+1a3RO0NSIJi3Vwf7eRLF8A+BfRcbTHT2Hp1FqTkdIwt/a+3O
	 iKHM/SI7eSNa7Wa9K5xBmVP6CxYBrjwVYmDFjj/xqW2uKPtHEuH5R+zel8imQAJ+Sg
	 5YsKCMV4RYHvge3dG9H6HK46eECvs0PrdFH7o6+f+g5FthXd++mNlRTFQhnmZ8PofF
	 37e2mt6z8QzlFQv6J2jKasSxMOGVMA6e2OhCCt51FNGy+bOfYT9EY5D0JmrR+cXboy
	 u7bf8tRGyft7ZFdC/stC4rxGfQWb7WG1unkwzDG55I/IsVXA9mF2rCPPGpwfkb17NS
	 pKczAy63P3jUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6192B80F6E;
	Wed,  2 Sep 2026 14:16:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F9E2230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA5B1606CF
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zLNUyDqURfh9 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=i9/OCOUf
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C41D606B4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:25 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso7756555e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358584; x=1788963384;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hss58b9cl4NnfeSl8E9355QiZ+V5FZb1XDQvYAo2Vis=;
 b=i9/OCOUfKwmWvJyCvLGi30cyBn/idrFa//XIDzdC1CTaCC3s6z7+RPWe/QrZVJ8gvZ
 tQVoC7lJTj+MBSg/AT5RxeuUxlEuvvHVtNbQuUCUu1XYYc+CcxrkE8yBEXaB0QzNEkLU
 JkTq+RMIDnx7EI/QCNuxBwQYUrsmcuXycVUS6VQFmS6a5Ck2DaNKX3qBgAOUPtY7ghp1
 mBPGejTf9qGm39pvDw9KzOFl5EFMDkxK3zYLMJRhy0wMlbHvHRwmoPe93qapXrKJOZcP
 5CMWBBj6olO+C8MCA++KOFk5da25eV0t0ZodQ2khdbWfukFxUWETzquw3xcOptFTt0kt
 6RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358584; x=1788963384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hss58b9cl4NnfeSl8E9355QiZ+V5FZb1XDQvYAo2Vis=;
 b=ZRMpIep/BIXamKa+1bI6ehzTQyQxEeZL/rEUL1C6c0017VwTqZUXF9nCO8W+ID82Pp
 A5KUhRzqO3qfQsun6vQv518U2XyAeh9Z1my5F5+rSfmrP50pyN2MaIqRZo4xjLPDHAj1
 PF5DvoSsjgWm8CKpdKAUBKGnrRke/lT+g6FQ8m3iZjll+N8lXodqyqDZkNsXVeI3kYk5
 BO/wBus2WDE8po2GtIac8dZyPqHR53vdJVkLz8uEU8eC9cYMiNqWK+/Q/OWeKVFrBIBy
 QtjOSWNu75fyvxSEm+LcVtwyN3c1VgdaUsNZj/PQe29AKvB4NYzVTye21sXRiiQgDrjT
 LQPw==
X-Gm-Message-State: AFuF++mmzxW/CZ/bONqHK9GbR2Ulh0EXmPeLo5lIWF0jd7i+Rznykn5/
 7hQaT01jl0gU8KQPyUQ2bUMs8J1rPoJlhvCxWXxDeWDgpdPV9/IXMKJl5FN8By3N0bg=
X-Gm-Gg: AR+sD12ooadBHKbdCId0dXzDwwPhI5SLExr+AkDKEVZRrWUfsjq8DRIaIZNmkpr0qHt
 7eOlBBXSyKPoKwLmErsCreK7JmA24L4KNBLGHwtrynNNmRAOle1CGUXrlNDK4bde72m8zTUavjG
 1Pl4axjkHNVJbF1ZR0ZPFSA99bq1a47Tb7ph4qRmfvV254qV6sPhJuaQPBq2uQsEeabERijaNTk
 CLqHKanIw7FPh90yfEcsyGBqzK9A/UMyngIGwAF/vUwGnJRFYmWNXA1ZIUQM5L6SmW7ppjzsUw/
 vfwhlekB23VihPV+cWuCag+vwuG7kkI3IQRzE06jICGfOjJaazkiR9MWUcCySCr+6c+3KQH72Fm
 2FKoB4XM+8QCp59o6fH51DtjK4MAUeoH0M/MFvbLoQinBfIwON8RdkMUGXluZcG/JWKPgoq5VWO
 255nJWQRcxl3iP5EKx53S9K2mqLW1RQrxOwCO39UC1VPHcwavpaobKAA8dP6iLD8VoN8TBbKmdo
 Xcjto5mfc6VfsZRAuUW0dWks3CRxfKHx9TcFyOzeD7RtjhLapADAPdDToEh4Z6kf0bn/qwvzEEt
 GRTsFa6vgZVC1S/2/tg8aQ5oQXNn8Iavh8wV1Bif6zcG
X-Received: by 2002:a05:600c:1f83:b0:499:dc34:bdc with SMTP id
 5b1f17b1804b1-49ce580a5cbmr95416275e9.1.1788358583661; 
 Wed, 02 Sep 2026 07:16:23 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:23 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:15:55 +0200
Subject: [PATCH v4 05/14] video: mediatek: add padding component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-5-7c3b4f068a56@baylibre.com>
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

The padding block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. It is configured in bypass
mode.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_padding.c | 40 +++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_padding.h | 16 +++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_padding.c b/drivers/video/mediatek/mtk_disp_padding.c
new file mode 100644
index 00000000000..4a69670bff2
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video Disp Padding Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_padding.h"
+
+#define PADDING_CONTROL_REG	0x00
+#define PADDING_BYPASS			BIT(0)
+#define PADDING_ENABLE			BIT(1)
+#define PADDING_PIC_SIZE_REG	0x04
+#define PADDING_H_REG		0x08 /* horizontal */
+#define PADDING_V_REG		0x0c /* vertical */
+#define PADDING_COLOR_REG	0x10
+
+void mtk_disp_padding_config(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, PADDING_CONTROL_REG,
+			    PADDING_ENABLE | PADDING_BYPASS);
+	mtk_disp_comp_write(dev, PADDING_PIC_SIZE_REG, 0x0);
+}
+
+static const struct udevice_id mtk_disp_padding_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-padding" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_disp_padding) = {
+	.name	   = "mtk_disp_padding",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_padding_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_padding.h b/drivers/video/mediatek/mtk_disp_padding.h
new file mode 100644
index 00000000000..f3cdd363b12
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video Disp Padding Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_PADDING_H
+#define _MTK_DISP_PADDING_H
+
+struct udevice;
+
+void mtk_disp_padding_config(struct udevice *dev);
+
+#endif

-- 
2.55.0

