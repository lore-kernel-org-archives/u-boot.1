Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B63DC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71B9781393;
	Tue, 28 Jul 2026 12:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6WgAk8mLCqw; Tue, 28 Jul 2026 12:29:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0B438134E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241785;
	bh=u0NTcZyg70EQo9dCPYc06okLTpa3NKw2E5HVva5uAxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VItQeL6KJs3VdtOUMItk50kXtyCkSeNKGvY8dxUCGm2mnponGnH1CWy7WRB/s2406
	 Sgbido7hG2RtSVfi+6xQ5g2hAWGDisGbnOZAFoh95VlqmNuUzJmN+ChYpVyB6iUmzw
	 rcpob4gTdw6+Qb6k+5axqR/X08Y4Y+TpEeEEHsEVXk7E4RFwzGyeUEzanc2Zxaoj7w
	 gg953PabYYvtEWDZ2qh6qlFDBwmnXNxhxM6QuurFOmqExKzOXu16Fm4R9VHQm7yCl8
	 3P2wd+bzt7PI7fMhCfqyXaIUR+VOIpEczc/AlZpPT8SztGQ05My1gsu6KyLLYsX8Kd
	 Wtkjx2bBUj9OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0B438134E;
	Tue, 28 Jul 2026 12:29:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B58D14BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A81A260856
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gnM7kkGwKYDf for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B2BF4607ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2BF4607ED
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2BF4607ED
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:36 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso2157773f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241775; x=1785846575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u0NTcZyg70EQo9dCPYc06okLTpa3NKw2E5HVva5uAxI=;
 b=nyCRmXZddX+9q1WpG1r8shKT833Z4anUgTVcXtOnlyodbM+qHMGajU31ZDkG1bOu5E
 xokQ4/JnQ/yAeL5pEfTJe6nsj23+lpFjB5OegFfLZG1WLhy+bTFg9tZBmKuY6fwTx/vi
 uBLwrZIQVKI4/olTlbqpHqj/wVA7qzj5XCN2iFMU35ypxr2PN/yn4MJ43SpuJPAEpGBX
 BivLGSNV/K6L+M/4dyIUHd2v6TjcuIPJ0cyzXiWV3vpVEiUMgqpBIsyHNTWma7zrxwki
 A44WuDzge0kumTbCaci6RYPkOobQ43GYJNvYItS2mwgfoQP62UWaAehmZ2ej9BHij5R7
 IIMw==
X-Gm-Message-State: AOJu0Yyb88/ZGm1O2+kQLuNk3QTJGOuVkNqGyknWF58sGEqU2ECN5OD/
 GXYDAU+vYbh3qNzYGUTBvQaShO70SqM2YmAmenyqf77aatULagEjwpRJ1pe7aJOlfGY=
X-Gm-Gg: AR+sD11Cz4kRD72kctNi1Q0W5DOd/dguJcwkOWGW0rOEat9eQWLrvjISOEYDj1e/8fm
 Z4RHd2llWyQkhZIU5BqDsgqXKcLpzucSkGF+B1PlcWi/gB/13JJAj5Jo4wFMc76MnZIJOouc+qm
 LvvuKU/mSDxB/3wMvfXQeNDP6wHIGBUdggNkdMsRvthfCwZYyFWlkgo33lU/Mgzi5jpr53aVmoz
 IVg7x/0+O1Me4f2RZ04OhP6DQqcvbmnqGHpFsjumbpekvj490YEKKhB4aiKMrLn3fAqIAX+/6K8
 ZaoV8SKyvLCAK49AaYiVHgxyhB/marVX0zo36Z0qwjY4JCeyXk9xkQqeDSeRtlqd7fLBKXNmhC/
 FwPVynfqm7DUcUYP3y+PfEw25PVjzrikKeiKzQmQ3UvE8SVr+thFiGel98je8l9FHSdqMIREcyb
 IXATogy5of1T+YniKl7qDLBbdg+zx8s/xuvumcWj97b5VNiZFYullsdxGFgeAQkgLWU0XCxSG3B
 gYBfe9G8xECmnaDxVflRhZ7FEFM98lW1fd7Ku4ihFo7Lsl0C0SH/oDoso8rQpg=
X-Received: by 2002:a05:6000:40c8:b0:475:f0f0:9ef7 with SMTP id
 ffacd0b85a97d-47fb1f2aab2mr2621697f8f.60.1785241774609; 
 Tue, 28 Jul 2026 05:29:34 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:34 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:37 +0200
Subject: [PATCH 05/13] video: mediatek: add padding component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-5-ac54bd75f960@baylibre.com>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
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
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785241775; x=1785846575;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u0NTcZyg70EQo9dCPYc06okLTpa3NKw2E5HVva5uAxI=;
 b=d+8eb5arXIvjWcyjQ73cE7EJp3XnuWHSj2zfCNaln3HC1XIft/RsTNhEyKZ0guKT6H
 TlCWoq7nWSM0JNs8gTMduoOG1B2CVoWal2tePsAD11ZEkKmKrsleSoApwuiXqAiG4Q7d
 VK/mdw0RBao8/8PMHIKfiYsW1qaof+TBDF+tL4/1pHEhECpI40o9r6dqk71llzKWyAY7
 ohijIjnXibUdKVCrUXb/OtGB8IMgroZntCA9vqGEouV50a4aqxlZOinUwJQWHKXsVrfm
 C6rHXOuM5muRBTkDxs7myc/TlIpgkfzWoTZJl0Nhfa5yxTEyn6kxDH+CXYvY59a9UBRv
 fZFg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=d+8eb5ar
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The padding block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. It is configured in bypass
mode.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_padding_mt8188.c | 37 ++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_padding_mt8188.h | 16 ++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_padding_mt8188.c b/drivers/video/mediatek/mtk_disp_padding_mt8188.c
new file mode 100644
index 00000000000..85c0f8887f4
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding_mt8188.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek Video Disp Padding Support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_padding_mt8188.h"
+
+#define PADDING_CON		0x0
+#define PADDING_EN		BIT(1)
+#define PADDING_BYPASS		BIT(0)
+
+#define PADDING_PIC_SIZE	0x4
+
+void mtk_disp_padding_config(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, PADDING_CON, PADDING_EN | PADDING_BYPASS);
+	mtk_disp_comp_write(dev, PADDING_PIC_SIZE, 0x0);
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
diff --git a/drivers/video/mediatek/mtk_disp_padding_mt8188.h b/drivers/video/mediatek/mtk_disp_padding_mt8188.h
new file mode 100644
index 00000000000..e2da589ec4a
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding_mt8188.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mediatek Video Disp Padding Support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_PADDING_MT8188_H
+#define _MTK_DISP_PADDING_MT8188_H
+
+struct udevice;
+
+void mtk_disp_padding_config(struct udevice *dev);
+
+#endif

-- 
2.54.0

