Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D71C98328
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D75C88130C;
	Fri, 25 Sep 2026 13:40:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z2tL458zOcxN; Fri, 25 Sep 2026 13:40:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8F53181339
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343651;
	b=o7Knn7ALHC3f0Xe3UTutAyWiXH2nZaZPeWyakKFRj5tw2HJ0ltTpHGd6s/COrhP1supv
	 cbMYrVCES4cZl7rMJhZNGOhJYA+uvqSVBuysU4Z5oDVQeT0Wb0izO1e7XBYW2kxPAfbsL
	 KWcwV9r+b1MwBsSKSPOavbt0bVjGmkhHsdTtU8vqAbfhllQbt0IE5IpbgtUMuSTUcofAB
	 hoHUeOXpf1OIhRZineAgsT8XxtIFu9VptTm8L/yTyExAJd23yDf/9wzlFdFt9AZqV3h+W
	 i1XzajUZ6Ea8k3tP0XnCwPYSgm1Z8Ikh76Tb+AVZ8fDuMQTU2K6oUo94IoOIuRdQ9NQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
	b=oLTQox/E8kLB4LoR1E0o6FSTTLAtJvusiYEZzd1utQkJKIylTh0w9wquqKWjQ+sfOvxc
	 xKXLl0cqFWlUx9KkRzYG0IjgholaYfPBPdU5tbXFdshgQMDzmhhFd6ZsPFlgBQOa66Jb6
	 kZ/h1gjHPhhRvLcrlHAWXYsp8gqRzlNxUAlzpEH0Z6yJPkrskAlvIi2D28R3MDR/d4ViB
	 Kh9VwnHIbVxfGQ+iI8nj3NdlKHSWKfcoFIsXgIhz7bMaWPhVycc45vZDoQta9omcRwqYR
	 JnH1M8UowFFqBX0EQAdmfHjh2WO61aEqUBPU/nFHTVnCetLSXALaw3E0rVNZdSaVJJQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343650;
	bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ES83DWcCjuR1g49z8OwzyK2t0CGswgRe90Kn7As0qkQsOHvKKjCDmDoP+gx9WiETx
	 mBlRfdqnhUwenXBMcuWZDJ+xpf0yOVT2AOF+Pjz3ECxwBa3EyHU0SkdFnnPVtIfMTx
	 9NZG4OL0dtJq0BNFW9Y4olTTTyzGyTPbi06fRdNqGkeHnr0ac2W3UMFBCOn/mfXXz6
	 4g+co7yL3B4qlyX2/8aP287tLJDwhjNyH3uaoFolnH3mA6zFjMLOe/Xreu74H7+Ibz
	 cVhELVmqHx+ARYRLRGhMG6JTc3YJ5ONYtZDRNSsKKUb+Zmj4TvOF/zD8ctMeqrdxLA
	 1pW7KO2C6tbhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F53181339;
	Fri, 25 Sep 2026 13:40:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1348332F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED69E60D5E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EReqKzn5p4Gr for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D79FB60B65
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343638;
 b=S3G9zryUFQwyB39yRRdRqedoZBLW6gCQtBs7F53zpTtSyNLvHvdYVsNPRtjwDVoor9vd
 P4zen6XfCaWTyUopqZRdp/tUZGcsTXkXXFiuuTZE9vFptwV4nGm63ExylNYbuKk47Uhut
 ytnlEhZcZpA0/GMM75D+lwxqpnG4UbdeiC5RI1w1TML3uHUDAHqVL9oqF7uHSpRLrjndv
 yDLhnumHwiDQcaN1Elx7KEIcU0DKQ7F6CNbffIacCZbpAhYjkJTHCi9Lvrso+y4wZZl3Q
 I2M+N8cvmnVM0Z9QTf9fXPy4fJOU/teL5FS1ibG0z+58vZcBv2lCD/ahw2+nKNhEFNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343638;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
 b=COtKZzDuaS01F87Ss/3DGNGwKLegvgNnYU4NdwBEPW5fBLypiYS8fh/4RZILVbOpvnSL
 EDAxdNxnz8CgshaiYVqeypdml5MyaPHgfgAIAY6ffjcbLV6YupvjvIUbL7+erljf1OEla
 Ws2iJBEv+O0tMETvOBwhM8fgdV1KeB+UeHC9BT92/bNSV/Cy+b7cPCDeGK87Cal8DabGh
 6frhKQjj+oexQNNnO1DQOA0rz1/v4fXyhBr1RPmN9BKnMgdK8uNAnpCydpf7GuO+e7HC1
 9O5qpnhP/ozNPCYVSI6zF8Blx4/mOo6NOYU5e5e71ypIOmwEB7f32TFxedu92psh5/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VslHwcvd; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VslHwcvd
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D79FB60B65
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:37 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887f690df6so486862f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343635; x=1790948435;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
 b=VslHwcvdpjNBm+FSyWmPrQVa8SV4/JUCfF6W2JAeSPszFgt1OvZQwFJHkFEJ0fve+m
 QKUhv5IuRYWxKnsja5TDYXX+1Pzpj2EyHYGQnwUVwft3OpsJoJpQZfd61p1F/fyZaV6H
 t7J+GJQEgrZUURpB3CVqqkgL+gI+N5KsfYh8sm5DBfgF/USLeKzO2Qj47/DZJPQyXQ9w
 3MHluMIOqPb1U94eGTFU2cEMA6dAtAdLNXkzLStglVlUID6SMIWEFfCHmSAoqrl5gZhF
 FeGJ8Gh9pL36eu1571JnNbEyT8KCmwxrGl+b0FuR5Snn7wkUAtq1c63EA4IJ7+74ugHD
 e1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343635; x=1790948435;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
 b=iiOYxyYLu+e8Grk0yHkfZOd3t29KJxB9QlXxRY7ZydgtUn5BL5YNWbpEwp7YOa1GYj
 4y9lZf6A+Qgz2HDaVHssjOD/ZBIzT9sW1qIjZh5EVAJbiilaNY/q7nH0zg6ANEfZn+m4
 3gMuyiqJiRicW/g0OT19TMhaxLzX4tCtYEBh19FWKNjhJ+S3jHY2ZdWUd9/Z1QgFuh28
 yeeksSqGZH8ZlxLa01N4DFC8dx4TchxrhMwfPJJyJKCRcervycJZH6IV9ATXNW6O0I0I
 ctHQdSxulOiQ7KmAGwxWhOCkqQSVCNtUQzsWq+nzp/B3q2OShvb//NcKR+v/oy60vnI3
 Bkhg==
X-Gm-Message-State: AFuF++mtX/hE+TNLNd6Z48xcElRsdF7XdR0Ty4I99N7OwB5emoTPzldQ
 idbjTCrf8iFd4I232y4cQO2hR4CVQ4h8Mlak/HIwlNm9Zk6kCAdcanL20gCJO18Vxa0=
X-Gm-Gg: AYBFou2OohPkE9PyQd+Ou7lBXlYZX2fGDnf6sa6JgvQEP3jtGPNnp/OatDcsUtEJ5Hj
 phWvqqVEC/co/F/ZEl2f97UQnr7391Ej2PvdLtP3FsYA1t/mkqxGMWKnYlgCj/k5VfmmfzpmzhL
 cLD8M/YMxNxgPsJsH+d27zO1gMDPeo2HHBeJql3OKfccQJKE7HCvv8NjZcag9vxUumVyqtQH1KR
 gFrHnWIqMwLvAnyUQNPug47XI6KA49lXs4I0cIctJe4r/ddZto+cJmuvyeAKqBx/UF2bMszmXTO
 x1h2uhQjs9V7AT57S2rm0CFPLr1r6C/kF41uVUAvVrEB9CbDAZ5F6ZHwpViXzZA3a3IUTaw395G
 P9XfHuipLXX6Bn6Ep07t7L2TgeVd0aM2TMecJ+cNcz3A/Vj20mBaK1oN40lQAsJqlFAg/JT06Ry
 Zkd7Q3Ci5Ph9lOIwg2E0xQ+Wm2+avU1H5fxysxlwDI45DyDoiz1gFycsi5y8L55MF6PKXBWm8TB
 ngSBEy35jZA0o9PQaa8dnfW80YbWmjUe83s8DR/azkJEZB8DPcphTRNItB8lkRvGo0NOykPKAqP
 9F+SKzkP0udY3Y2KDPxxxret+QrHGYPWXr8wOIN4bZePFyVEuefhbU/6ELASbullsA==
X-Received: by 2002:a5d:5d10:0:b0:486:f301:11df with SMTP id
 ffacd0b85a97d-4887166d9cfmr12138470f8f.6.1790343635307; 
 Fri, 25 Sep 2026 06:40:35 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:05 +0200
Subject: [PATCH v6 07/12] video: mediatek: add padding component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-7-29e626b213e9@baylibre.com>
References: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
In-Reply-To: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
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
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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
 drivers/video/mediatek/mtk_disp_padding.c | 49 +++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_padding.h | 20 +++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_padding.c b/drivers/video/mediatek/mtk_disp_padding.c
new file mode 100644
index 00000000000..621dab2d245
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Disp Padding Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <linux/bitops.h>
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
+
+	/*
+	 * Even in bypass mode all the settings must be cleared to 0 or
+	 * undefined behaviours could happen.
+	 */
+	mtk_disp_comp_write(dev, PADDING_PIC_SIZE_REG, 0x0);
+	mtk_disp_comp_write(dev, PADDING_H_REG, 0x0);
+	mtk_disp_comp_write(dev, PADDING_V_REG, 0x0);
+	mtk_disp_comp_write(dev, PADDING_COLOR_REG, 0x0);
+}
+
+static const struct udevice_id mtk_disp_padding_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-padding" },
+	{ }
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
index 00000000000..ea97918a570
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video Disp Padding Support
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
+/**
+ * mtk_disp_padding_config() - put a padding component in bypass
+ * @dev: padding device
+ */
+void mtk_disp_padding_config(struct udevice *dev);
+
+#endif /* _MTK_DISP_PADDING_H */

-- 
2.55.0

