Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E6AC9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EB808084F;
	Mon, 28 Sep 2026 09:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2CUm7zuDEiL4; Mon, 28 Sep 2026 09:17:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D626780AF9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587074;
	b=LK2xmVts0HZBS0qcWZitureKOwcySbtyiz7ovMKNW2os6cNAmTBEXxnVcPGrEJMRqHwj
	 zkDqdETyUUL43i/9EbKqp1YGl1bDlEo8QeQTwfNk1FvqHei9ounD2ep5bI/SQWYqP+H4q
	 dPRtCtsvcMTIdhqP53sVU/p//uDBFsxnDNEo9Ll1X4i7txV79b0o3YuY0dvI/oYiEgLpo
	 qLgc41alxF02KjCYOF6d04c6A37htnoWYZwdF/oWKEChH0W608ilTeLiMadBNtT2Ech0z
	 5VkDYzr52rrPtrJ/mnLfqQ7+/GNIBX3zKvE/Y6erjDinKRnf17ygh1rqkQOhEO002Hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587074;
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
	b=NhNjjIFxWEn0n/litEt64cRIkF+U0MUh6RLHpwWWKJLeTE8i5iESlvFH+Ax6yq5WPi+1
	 1HTvOQbn1LTXb7SrI1FWiSWRZyghfVWmJ8lCQaRktLBgkMLnnSgFKF9Nzd0RgkX3hrR3a
	 wMWCdWGrDfs9+zR/LTDBVX3sVPIx/+1iLx7wXBsEpYsHcxCcLDo+HidnDjZgXrTo0k5uB
	 rHEmAHVICo7wNM37lO+ZLXpy081RAHTavOlbtTAXmArUyJvSgEFQ3WLLxJ2B+RaIfs5KN
	 LsulS6iHxAK+/iTWQ+yg6Kht9N2jVR8+lUY/ltrsEF1X5WjbJPqv0rSwYPNwyum+Yww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=izRryUvd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587074;
	bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zjeW7vp2CqOJmxhm1UGWDHGPCRZgzmXOOId2sJjAGElfqRmhvkrty2UX2JNuwovWq
	 V3Xa6pn5I5V0BvgID2ysYvAbNjM5zwifG1hH5YC689QSzmn7ktmUidKZ3097Cn/h3V
	 TD32/MNvF5jFiL2uQVQOHGBf65dijFja7aIf+mSvZFEP+HgberH4xXk9m1T65bH16c
	 f6/nMADT9SBEC03KFTng4uWw/zis2jN5s3EYFunmZV5fgICctQjM2fuQq1c4tvXRq3
	 bjGX/43HoQ/HNBfxibAD2gvjC9tqcO+l4bn/OCQWTU/2fJ4KaOFuL5u+f8pRH6v4pN
	 Ow6ROjAvwFzZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D626780AF9;
	Mon, 28 Sep 2026 09:17:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 02DC53D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCB7D80AF9
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lvFQsAAjIE2p for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DCDA680B9D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587066;
 b=sZZ3puL9YdKyODRZMno5ktUcY/xmZTu5MbmaBYbNkpDKFTObddJMwuqR4g6/OjbocTn9
 zPRCmHr7sxGZyWAfV6sXxqQKkli1XXbpKEGabzUSxw4EuDetsEUxf92ablI3licRvFQSZ
 XuK5hGJ8HJuDJgJhZjMCkab+7VfPEmrjgv5HItkZpN7uWDqwU5dO7Ycc7W5hwCXLiwqiC
 6ch1ccOf4w087di3RdHsZZan/mgEPLa7Br+RUStkHp3jEsf/a6zgH3J3tN7TAyC67uv9m
 2xJlOjGaUHz+gMOa7xFL5uJC7Fs0qeodkhhYYLu6AZamWYlKp5No8dYLfg6MzrUGu8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587066;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
 b=RDeKLz301KyMNfh4nFscSMmfdkQ2lTEd5OKGOi+z7IIQJsL5GI/OrbXMDKv2mE0zW1vW
 IDqleN9DaPGlzRuZwXboDF50hasKlJ8t6Nk4CIhcDLQdgVS4L8gG9U1h165UPNgPptmag
 bATtximsNC2qQpoXJpUFD46XLXdde6zEL2ecrwCjhvk+lsABuz+wbWw2otNitiSwwNYib
 y9O/igkdycGdH6pCjb2NY8tlzNc8uV2jN/SzHCW9UeEO6Jr1vRvkB4s0VSRkAd1Fjp8Ku
 RFi80rs1vTiM/T9nwVWgNqqqe/fjD8hnAFkRGQ66x14M35BFAXmgQk7ksuVBmeBEnGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=izRryUvd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=izRryUvd
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCDA680B9D
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:43 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-488885c3844so1087908f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587061; x=1791191861;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
 b=izRryUvdlVUho72GtxGB0UzMDVa7uc70QfrbtNvhm4Yn98hi0fhuTYM0tQy/C8aUyU
 m4jZzxvqVhq9L0xiDPeTJm8f4bOmnmK2cY9bTnQmT1HcTxLVRV/laDV/JbmPv/zJ0HuC
 KtJPLxrJslu79E20QsWLYZSDC2VYofzBhqhNbX9AjWMK+tSw6R4wiA9ubxU+n40eqE1K
 5WAE+hfeVripix27ik2+p99D8Rp8CcrbO4hWywUec5wPFSSCWrOA9TFo3RWjaolflgZn
 DVMVjvina2rykLsgKHm3l4GwAPD3jBQrBjInZ9I8HSpYFTeZa86wU4n6gpMBYkDxtdJD
 TVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587061; x=1791191861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
 b=B5ErDq0DlgeMTZsZQEc9gIjTWnpf6V1aVgOG1AGdsimABOcTKcd+6s5MEK9ez6dCEJ
 R80jS2nbO6674rPFIR1alWN/l126vk6+Dh2UB5mTmM/OpJeRb38IS07jHigBbE3w47GK
 vP6NVg7aAQ9dZrKhKhdNKwlIf6D41lSEkQYpRjQd+1UaOTL7wW5l8WQVj9x14rK2aJ2L
 4lo9snVXSoeWrFqiOIkW15OFWgKzp+BKIMSSmdSVaTSJ7q/DM9BH2fqtG6uu3wEVsWdp
 4+rnqOhR6f+ZGC2IqfypvsVBhCny7p5x0vLdYoqkApCHIK9WqFmVum45vOmsQN+R5Ng3
 5i6g==
X-Gm-Message-State: AFq9FYItyNYQW2YfApPZcxwc3n2RckvfcD7wg8cq16ccPA/tGPkaQFnQ
 qZJxRhekzqkp7xvFsGnqboqacmnQEp4PQiCk0fyCbYYeHEYBWK66e01bog9zWjN0RhM=
X-Gm-Gg: AYBFou30c02C/0YYSfdLPsqtFGnn7aGPMSd9DWEOWVq4Z+QajatXGxs9y57n8JvgYtB
 UuWe/vhciVnC2z80JUkF8Afx3r9BSbzA/iK7kCefB1ZMMXHdOcl8ZyWXhDmGfaiE8RVxeSfQ6ps
 pCSZooJOIqjvEfo35nV6yknUbPu82n6h5xE0O+y+YlqhhVOYZ+/jJSUK+lDVNvsJfz/v/YhgKTy
 yKiKVPZOHQF5va3ECWHfGkDmdi/uQf2Y5L3kK+8ZNGEvt5J2S6vSDrkLitoatmWge8VC7u+elda
 /kgrZHkKK3K2Nw2w3t2sqkCboGJRqMI5Q0eMAzC29EVFBWb7V8avx1e0OW4nCsF0QExLAv18JYy
 2dEqXyRjrqWK1hwbR4EhlVrvgoRpGlVlAxN51f2PnzbDpJI8QwVM0mmnaiOjOFtvDEyycEjIoJq
 LgqdaEq82WcnXzOoUMyzQUh64z4/+vRK90BlLkvyJZF6Bo6LHjfPW+8jxf12lopaZEDFzF478gw
 VTnn8KGtGGjo6ybV3ZsmqLC1TCN+29EVu8p9X23bG0EUMrs6FxrjzYb6r8R7akINAYxS11wnmXl
 oKnuyJbY191Jhhh4EXNwafQkYOTlljTXNgU5ada4bH1Lr1/umu4K5/k=
X-Received: by 2002:a05:6000:1861:b0:487:e:f4f6 with SMTP id
 ffacd0b85a97d-488716dd323mr28907030f8f.15.1790587061342; 
 Mon, 28 Sep 2026 02:17:41 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:42 +0200
Subject: [PATCH v7 07/12] video: mediatek: add padding component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-7-ee4a61a8ac1d@baylibre.com>
References: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
In-Reply-To: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
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

