Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9024C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B5E080F06;
	Wed,  2 Sep 2026 14:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P_ZT7XhquLSL; Wed,  2 Sep 2026 14:16:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358583;
	bh=A3CCZhmC6ul9Johiq9Y4kJEC4x78uyGlzeDkVBgJG7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zs6c15w6Tp8vnWWuQzrEROgxvcBZrZTy4ghnTfJAyFeCadlGOg2MfRLNsEH8qVxpf
	 nTrwcxzVOYKPNQfRyZomhgGXb71lBW2Q390QOsDEzLaGPSjiZS47oPkrFouUj87F/y
	 r0e+1XrhMepx9Hk2yLRepDI2lXkKMPru/Mr64W+t2bI4XcnfQy/TzofcMiKi/ZwJ4U
	 Al+ljIZ0hdwbjIct/bM9FTjD3pvx0TPc1k6Bhx+8cMp8OYa3CcjZylf+m3OWtv28At
	 wSGux2pUuWDBwZ5YkxRFnXenZRc9Q9TNHWuRdYJ7zkhRtStDR05ifT0PvNJzIEbtW6
	 BV6pH3bOl3tJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 067FD80EC2;
	Wed,  2 Sep 2026 14:16:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 93641363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78972606CF
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWzDpcFwOEOF for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VXKwdNq4
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A086E606B4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:18 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a6108734d5so1846800a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358577; x=1788963377;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A3CCZhmC6ul9Johiq9Y4kJEC4x78uyGlzeDkVBgJG7w=;
 b=VXKwdNq4YsNbWh28oAqfMamsoVLsiOWw+6jEH4mqxQBXuYPeiTcXFUr7R8uNnKV8Qv
 AiaEcHj6YrEAb+iFnrfi151XI2zgMs6rJXxaZerzLmxKeCh3nypZkdMG5usW3QQ2Mlao
 GDGlKWMn7Rtzt+eSTSS1lZexW9aU6X6JVEe9xHd7iR2ulhFitnGu7cVImnH2OIauRnet
 CNWEhgKd9zKP56SPLHWeKxVTOrYYauoyMygdBtqQ5MpJt/NnYyy1vAQIRT4S0QJLzGoN
 a8GHoM7oWHJS1U9WlW46zEAVjRoChB1UGQjgjeAxW+b79PGfcJjLmhQ/iaN/HqNKjI90
 0BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358577; x=1788963377;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A3CCZhmC6ul9Johiq9Y4kJEC4x78uyGlzeDkVBgJG7w=;
 b=ULjUiJxWZJ6oSHLmm+++2dHEBWtm4qdOGIX1wI+2R9/DSV0/pJsfsy43XAg7xfJVpc
 UoWD+0fAdJhgysqShmY23+5PHKfvMjeYTU2tbdeM3SKj8zLIYde9SM1WDwWERZAO5Zh3
 WVP8D+Y+moYm2Zfj0ouwVcnvcekxU0XDNlyZw4fQ75+gTOtN8aqPHtTbPjHwWw2J571c
 SQ2qdsLulfCUz0t/8kE4iCMWIeHFAl1WqZfie7ctqNMsilLtKBoesdHMH1Rn+RcNvzs5
 09WVMUjxEHwcgS5W0VryljHR9yABrT7VvKmLpqctY51j3X1QohIX46/k6D0WEAQQYROz
 eYhA==
X-Gm-Message-State: AFuF++mvtdDN4r0ooWbRv5Q/daagqDQHivgcqMmJqG7NND8pwZR/vAt2
 BPBV13oUlTe9avsBQHpzPFbISZ5/n7rgMZQW6Zk1gjPISuJRzhie/kbC6S2HWJDlHwA=
X-Gm-Gg: AYBFou0UxgiNW+8Ri0aj8pZqW/9oDVE2SLZPro5sX8gFIaBgBhqVNRVuiGUFDcd1VQG
 QQSADIJY/94R3nCA2pomUM8wd2RhrbjwxFkW4u/LqHbx+8bcbNVT+TMCOoA61rbXiSNxYO96gAd
 fJBQLp0P7Z3EX7A965sXm4UO898RjfeXJP6HIUTPM8W/XvtgMpig7VIEZzo4f3xlx+vX95DX5DP
 xJLVg1Zh761KRs0MTRGNLICilQghaHiE3oA5dvOOJzR27A9/WhhdGPUCow66MpvXKI1E8DP/wqy
 Ik3kItH01k5s16OTnqcTpWtTFBZW2bH8tMyQKTOZ0LJHcU9cVBKFha4kid7AFfXhLArrITQNmHA
 FbyezbbaCaZf9zloq3KgvJ34bq1jyly57jEbfXAl5+DiB4u8jhl2AbJ2Tk1cOBo7apA4qT6hKmk
 1vg/YOdt9eRsIcg+Q+WJq92cFViwIB8s7N1W1KN7u/wAP8wVDFFptLGIuPHg3gv8573NrjH29j7
 88SwSrH4tRToa9dv2KucsJDAJ6gD4CXoFyE+LmT/gYyGSAkvChZcmp4F9sCeRSum9rUkG5AQWzj
 VRuLp/Erdf++de6eZAjJSrFM5djncPYbXQY6z0FhdgN6Tw==
X-Received: by 2002:a05:6402:5417:b0:6a3:95bd:143c with SMTP id
 4fb4d7f45d1cf-6a6825665e4mr3119027a12.5.1788358576642; 
 Wed, 02 Sep 2026 07:16:16 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:12 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:15:51 +0200
Subject: [PATCH v4 01/14] video: mediatek: add display pipeline component
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-1-7c3b4f068a56@baylibre.com>
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

Most of the simple display pipeline components share the same probe and
enable sequence: remap the register window and enable a bulk of clocks.
Add the mtk_disp_comp helpers holding this boilerplate so each component
driver only has to provide its own component-specific programming.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c | 78 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_comp.h | 32 ++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
new file mode 100644
index 00000000000..07ba29e3393
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek display pipeline component helpers
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+
+#include "mtk_disp_comp.h"
+
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+
+	writel(val, priv->base + offset);
+}
+
+int mtk_disp_comp_enable(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* ungate the feeding SMI larb first, if any */
+	if (priv->larb) {
+		ret = mtk_disp_comp_enable(priv->larb);
+		if (ret)
+			return ret;
+	}
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		if (priv->larb)
+			mtk_disp_comp_disable(priv->larb);
+		return ret;
+	}
+
+	return 0;
+}
+
+int mtk_disp_comp_disable(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_disable_bulk(&priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to disable clocks: %d\n", ret);
+
+	if (priv->larb)
+		mtk_disp_comp_disable(priv->larb);
+
+	return ret;
+}
+
+int mtk_disp_comp_probe(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/video/mediatek/mtk_disp_comp.h b/drivers/video/mediatek/mtk_disp_comp.h
new file mode 100644
index 00000000000..9012dda3918
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek display pipeline component helpers
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_COMP_H
+#define _MTK_DISP_COMP_H
+
+#include <clk.h>
+
+struct udevice;
+
+/*
+ * Common state shared by all the simple display pipeline components:
+ * a register window and a bulk of clocks. @larb is an optional SMI larb
+ * enabled and disabled together with the component (used by the RDMAs).
+ */
+struct mtk_disp_comp_priv {
+	void __iomem *base;
+	struct clk_bulk clk_bulk;
+	struct udevice *larb;
+};
+
+int mtk_disp_comp_probe(struct udevice *dev);
+int mtk_disp_comp_enable(struct udevice *dev);
+int mtk_disp_comp_disable(struct udevice *dev);
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val);
+
+#endif /* _MTK_DISP_COMP_H */

-- 
2.55.0

