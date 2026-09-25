Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F713C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB3C581339;
	Fri, 25 Sep 2026 13:40:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tptdy-ZQr9ct; Fri, 25 Sep 2026 13:40:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6BFA781340
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343654;
	b=ppTzHetea34SE6S0qUg93Fogzsr9+sROxjTAkh4bdULdHLFzBMPpa9DrFVNhiLTl91O+
	 YT8WklhgGpnBqOId4S/ij5Pvd4aWFAfbfVX10WBq35qXsnTXrPtoFdd5f+IOn27PQVxId
	 sAsG4T939JvD6tS7JHdLHUf8ILuhgAH8wGtWCL9ConWkGdGncehEVPPf3ol2JibkJ+496
	 dXcZfXtjjYOx412nBpYQbHD5LBq4XHuwzNN1Ag8rbCNv7vkZ41OvxnKtZwviO0ZPRJDox
	 91P0mpXdVuuMCpS1v3bl7vM03hUEA88ukssdBeJe94LrML1sPv/HLuMsfHv3bl/V3QQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XyD2FunruOnomFPev1nwBcWZ4UNYrLyNa1IGPysT8rU=;
	b=ipfFBPjcoSiH7Fvq/HDVVr0dWgH99guIL4p5E+mD73a7qbB/7vBFeSH7IYWYANlv1w0v
	 ZiSCfwj13ECwuWIwAqI1vzBDMt8a9/OXn3ErnA8XfQgtEmeEORGUwm+gFONVS9UdWtObC
	 /+N61+l63VYbubFrV7q0v8wSu3Vcje3FUllYgTEH/ZXqK6qVQc2B72fI3pbVlN7DCE3vC
	 pIMLRcwb4J/lHgza4nohy/groWlW9viwvpjZ3n4ZRCRszy5L8IyuM/AC6+KUdecmtJ+pX
	 rb8KGYs+cDXfth8x9tNFq8NlcqxGLEtDfnA8sI3Cmo4FgQcBa/0XePZFb1g61V6VfHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343654;
	bh=XyD2FunruOnomFPev1nwBcWZ4UNYrLyNa1IGPysT8rU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGMXHu8e30Nn91BiNOMgM2QhCqh8C7kN32zojn/t+NO22UzsnCtUNBYt5EYRcoYMv
	 eQ6rahNpmFyi25JZJSQApMEPhRdvXF4tB71eCMWsfJNlP/ruchAUybTKmQmz0EocxR
	 6lx3o3PcF42DIxGDjwHdG/fcpS5pxJDrvnACWDNGink0humopwjWZ0SkJXXOF5zbPS
	 V/N6SdEGWiTDgiZZd7de7zembigq9W6Z3k2LICJkk4TC/NM1fQmSMfeHnjaC58Bk6V
	 217VIU/TvWCPAnb9Aieg1TY3fCsVpTzWkJwLbyz0A5C0heXkWhzQC2hva2B9Art/Gf
	 knHPqi8cC0jIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BFA781340;
	Fri, 25 Sep 2026 13:40:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2278E32F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2031740AF1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1rg2oG1oGEBQ for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 489FB40AC8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343640;
 b=oD/NDa4JDUq8ykONWK+klAhCQEAMoOq71Vwcid1q+Ng7w8N3FFcUSni1SzcvPf/7VQwK
 UAVAggDIB7g9lwHSLSjR2K8Gxp7hAteylOgE/rysg8DCcNAACKDVn9US4IQJa72PFJaLu
 nWiCfmxVZRdsdRfT/3ghJ4KjdpAvSGcTK43/qUdQVkVQ0qfCLy3EnJD1dWLWnU7qv1r1L
 wcLtNkRD2TsLyKzITMLzbgnn/sQg/rdO2Sjl6pg0tJhzP+hk4lZEATvB2zL+SJqplWeTr
 35c6TMNtn1jK1JTnIBPfBD5kmgBG5b1K6Qwz9t/AxMmAs/nzsCpf5K2dIYoqGPQX/oQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343640;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=XyD2FunruOnomFPev1nwBcWZ4UNYrLyNa1IGPysT8rU=;
 b=iPnxr7TAeCCpvsfQFISlaKdzQQ+Na1GBwDhi5XogWrC0VSGmGD8zxdTzrfd07dmGwHxK
 UItE6Feg/6XX3lFfoYQVUA1O9yfYcBqqTl+hOUKK4qIUh3KHZYIZo+4Vpbu2NxnXgrrFC
 vW9Yub9xVUT43MRoXY/TUl5Scj07wbFEmuyLXST7BrDxdO+eSokSv5fMoNj4rW4rq+hSI
 p5jTi1Dp8T49dhSGKDA3CscXzoK5TpQ/wXXfbMZxvsZT+x5wAkd/L1haBdrqWu57dTstg
 e4Y9cFIoV+eSmT6UHSEkemPIw0twUjRwVsxG3EwKthHzrfPtsMaAVze6HnHBc4EFVlQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="BZu/KvD7"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BZu/KvD7
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 489FB40AC8
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:39 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843378fb37so540110f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343638; x=1790948438;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XyD2FunruOnomFPev1nwBcWZ4UNYrLyNa1IGPysT8rU=;
 b=BZu/KvD74saUYbkQ8R6WLWPyyL5UuKZPrXeIhK9kNQTYcUWKEvvx/Kq780gC++vzaE
 40flhLVUrzT1gSHxCZJniY1cXzwVrjUlT2OSnc9P+LnIgT35q0WBCDA42eFrLiSmXd7g
 buT5UMimYXK6TwxG9ocYWas8e1jEjH8uQu8pAUE9aePxoCONQds8r1DXAxx1+oF4PLkL
 RzAYd7x+1hnLcxDUQVaS7XEgrjkqEOBZ2kAUkflUzEDVB+DM6BkJU6UezdKQG0o4tDgq
 RfqIpkjLQXTF94tY/WH9zdPQRLCgzvMkNesxQnupg4xnYRRXctsHYsjLxDOr/61kuieq
 1p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343638; x=1790948438;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XyD2FunruOnomFPev1nwBcWZ4UNYrLyNa1IGPysT8rU=;
 b=QVlwkuJx4BK6w2paVBGR3S3Ml8CVC+8ilx31ofGzBZAmmJCl71L6y0RxYHlHciAVFF
 JqGK/Bq6rQY41T8LJwtPVDfnOaJdtsG2q6mmcgikOz1FhXLncWn1RlW3KiNhNTyDVsz3
 U9Ia/4dabCv/a13jcvesCBfkvAsHlY4XLYMkLAArsACx+VhEmaPNvFEEYfjkn+5WFaCw
 NuTHQC+MuPKAbkvunfDYNECUv9XKeABJ+n0DME3sxCeCpNn+4B+aDDIcOIh3sGmUt2xN
 cjROFILS08nevk+IRrn0InqK3ZCg3Ii0ltJH5DioovZDfqfhJep74m+p+J3Gm8yNyajp
 M5MQ==
X-Gm-Message-State: AFuF++lyFrI2uSWuhVAL3lTUI6gVsony3mAe94xV3inVHgJDRImrZT9D
 KMuM5UEHxHncEGg38EyhO8ReWjZuOy9h+/x45zgwjaprFIdNHFmJMAOQzx3IiFU+v+w=
X-Gm-Gg: AYBFou3xjSgxFZbg6Z9x+aMLIBx1dTTdMqdT2u+QqTwN7mBZS4opQ0sqzVAU9E0wuaP
 FwI/kFYrD4onxwSPu9tjbJhi3ddGaE971gV5vhMpTjJEwtf1MuFqRCbNc21eWePAyJ8WZQajKT9
 cY2r03k1Vw5W8hCjqZiy5MWZsRwrRprwKuBLmKz4o5p6DgvbFjr4FHCRePhPFSFcNbVkVlDHIj6
 ht4PMK1kHosPfAspbrNwOhgrYJGwSOy65URuJDxk7FlBpUmbGp3wpwM8Kiu9FiDefntXqu8LzwZ
 l3C0zDc1JkhbB0gn0vL7CP2ZIEJvxPenIAbyhd/ANZJdT9YA8jnd1g1Sv+P/p4m8acjniW2RqpM
 qkWQ7NtGuOOXg7AYQ8yHmoDkoyMN/Oh+MhyvRfT1eKzfcInjQdizysvfT8Wje1WRSrq+osLIm1U
 SKctQxdWt6pH7H9AOZvJx8Wz7B8OKTg/EnlvjSrmT83pEPyX+4xqUp0SLPLdMMrgUCQUh74C7DD
 LVympQgLuKj80iNFu/yQ9rx/JlwXuekSnGcCSPhFEX4vEsoJcwyHZN0RaUxq/vJ/ZAkGG+Jiqg5
 rOiNxeAP10BY9ntNDh9GoLs21uHOcFDda+qov8hiYAY2kMaFiBW9K18=
X-Received: by 2002:a5d:6f03:0:b0:487:fa8:46cc with SMTP id
 ffacd0b85a97d-4887165ea11mr10029763f8f.1.1790343637643; 
 Fri, 25 Sep 2026 06:40:37 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:37 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:07 +0200
Subject: [PATCH v6 09/12] video: mediatek: add dpi1 component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-9-29e626b213e9@baylibre.com>
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

DPI is one of the components of the video pipeline on some MediaTek
SoCs, such as the MT8188: it is the timing generator interface
feeding the HDMI TX. Sync polarities, porches and the interlace mode
are taken from the struct display_timing selected from the EDID.

mtk_dpi_regs.h is a verbatim copy of Linux'
drivers/gpu/drm/mediatek/mtk_dpi_regs.h, kept as its own header so that
it can be re-synced with a plain diff.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_dpi.c      | 372 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_dpi.h      |  34 ++++
 drivers/video/mediatek/mtk_dpi_regs.h | 247 ++++++++++++++++++++++
 3 files changed, 653 insertions(+)

diff --git a/drivers/video/mediatek/mtk_dpi.c b/drivers/video/mediatek/mtk_dpi.c
new file mode 100644
index 00000000000..40890572ae6
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dpi.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek DPI support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <fdtdec.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_dpi.h"
+#include "mtk_dpi_regs.h"
+
+enum mtk_dpi_out_bit_num {
+	MTK_DPI_OUT_BIT_NUM_8BITS,
+	MTK_DPI_OUT_BIT_NUM_10BITS,
+	MTK_DPI_OUT_BIT_NUM_12BITS,
+	MTK_DPI_OUT_BIT_NUM_16BITS
+};
+
+enum mtk_dpi_out_yc_map {
+	MTK_DPI_OUT_YC_MAP_RGB,
+	MTK_DPI_OUT_YC_MAP_CYCY,
+	MTK_DPI_OUT_YC_MAP_YCYC,
+	MTK_DPI_OUT_YC_MAP_CY,
+	MTK_DPI_OUT_YC_MAP_YC
+};
+
+enum mtk_dpi_out_channel_swap {
+	MTK_DPI_OUT_CHANNEL_SWAP_RGB,
+	MTK_DPI_OUT_CHANNEL_SWAP_GBR,
+	MTK_DPI_OUT_CHANNEL_SWAP_BRG,
+	MTK_DPI_OUT_CHANNEL_SWAP_RBG,
+	MTK_DPI_OUT_CHANNEL_SWAP_GRB,
+	MTK_DPI_OUT_CHANNEL_SWAP_BGR
+};
+
+enum mtk_dpi_polarity {
+	MTK_DPI_POLARITY_RISING,
+	MTK_DPI_POLARITY_FALLING,
+};
+
+struct mtk_dpi_polarities {
+	enum mtk_dpi_polarity de_pol;
+	enum mtk_dpi_polarity ck_pol;
+	enum mtk_dpi_polarity hsync_pol;
+	enum mtk_dpi_polarity vsync_pol;
+};
+
+struct mtk_dpi_sync_param {
+	u32 sync_width;
+	u32 front_porch;
+	u32 back_porch;
+	bool shift_half_line;
+};
+
+struct mtk_dpi_yc_limit {
+	u16 y_top;
+	u16 y_bottom;
+	u16 c_top;
+	u16 c_bottom;
+};
+
+static void mtk_dpi_sw_reset(struct udevice *dev, bool reset)
+{
+	mtk_disp_comp_update(dev, DPI_RET, reset ? RST : 0, RST);
+}
+
+static void mtk_dpi_config_hsync(struct udevice *dev,
+				 const struct mtk_dpi_sync_param *sync)
+{
+	mtk_disp_comp_update(dev, DPI_TGEN_HWIDTH, sync->sync_width << HPW,
+			     HPW_MASK);
+	mtk_disp_comp_update(dev, DPI_TGEN_HPORCH, sync->back_porch << HBP,
+			     HBP_MASK);
+	mtk_disp_comp_update(dev, DPI_TGEN_HPORCH, sync->front_porch << HFP,
+			     HFP_MASK);
+}
+
+static void mtk_dpi_config_vsync(struct udevice *dev,
+				 const struct mtk_dpi_sync_param *sync,
+				 u32 width_addr, u32 porch_addr)
+{
+	mtk_disp_comp_update(dev, width_addr,
+			     sync->sync_width << VSYNC_WIDTH_SHIFT,
+			     VSYNC_WIDTH_MASK);
+	mtk_disp_comp_update(dev, width_addr,
+			     sync->shift_half_line << VSYNC_HALF_LINE_SHIFT,
+			     VSYNC_HALF_LINE_MASK);
+	mtk_disp_comp_update(dev, porch_addr,
+			     sync->back_porch << VSYNC_BACK_PORCH_SHIFT,
+			     VSYNC_BACK_PORCH_MASK);
+	mtk_disp_comp_update(dev, porch_addr,
+			     sync->front_porch << VSYNC_FRONT_PORCH_SHIFT,
+			     VSYNC_FRONT_PORCH_MASK);
+}
+
+static void mtk_dpi_config_vsync_lodd(struct udevice *dev,
+				      const struct mtk_dpi_sync_param *sync)
+{
+	mtk_dpi_config_vsync(dev, sync, DPI_TGEN_VWIDTH, DPI_TGEN_VPORCH);
+}
+
+static void mtk_dpi_config_vsync_leven(struct udevice *dev,
+				       const struct mtk_dpi_sync_param *sync)
+{
+	mtk_dpi_config_vsync(dev, sync, DPI_TGEN_VWIDTH_LEVEN,
+			     DPI_TGEN_VPORCH_LEVEN);
+}
+
+static void mtk_dpi_config_vsync_rodd(struct udevice *dev,
+				      const struct mtk_dpi_sync_param *sync)
+{
+	mtk_dpi_config_vsync(dev, sync, DPI_TGEN_VWIDTH_RODD,
+			     DPI_TGEN_VPORCH_RODD);
+}
+
+static void mtk_dpi_config_vsync_reven(struct udevice *dev,
+				       const struct mtk_dpi_sync_param *sync)
+{
+	mtk_dpi_config_vsync(dev, sync, DPI_TGEN_VWIDTH_REVEN,
+			     DPI_TGEN_VPORCH_REVEN);
+}
+
+static void mtk_dpi_config_pol(struct udevice *dev,
+			       const struct mtk_dpi_polarities *dpi_pol)
+{
+	unsigned int pol;
+
+	pol = (dpi_pol->ck_pol == MTK_DPI_POLARITY_RISING ? 0 : CK_POL) |
+	      (dpi_pol->de_pol == MTK_DPI_POLARITY_RISING ? 0 : DE_POL) |
+	      (dpi_pol->hsync_pol == MTK_DPI_POLARITY_RISING ? 0 : HSYNC_POL) |
+	      (dpi_pol->vsync_pol == MTK_DPI_POLARITY_RISING ? 0 : VSYNC_POL);
+	mtk_disp_comp_update(dev, DPI_OUTPUT_SETTING, pol,
+			     CK_POL | DE_POL | HSYNC_POL | VSYNC_POL);
+}
+
+static void mtk_dpi_config_interface(struct udevice *dev, bool inter)
+{
+	mtk_disp_comp_update(dev, DPI_CON, inter ? INTL_EN : 0, INTL_EN);
+}
+
+static void mtk_dpi_config_input_2p(struct udevice *dev, bool input_2p)
+{
+	mtk_disp_comp_update(dev, DPI_CON, input_2p ? DPI_INPUT_2P_EN : 0,
+			     DPI_INPUT_2P_EN);
+}
+
+static void mtk_dpi_config_output_1t1p(struct udevice *dev, bool output_1t1p)
+{
+	mtk_disp_comp_update(dev, DPI_CON, output_1t1p ? DPI_OUTPUT_1T1P_EN : 0,
+			     DPI_OUTPUT_1T1P_EN);
+}
+
+static void mtk_dpi_config_fb_size(struct udevice *dev, u32 width, u32 height)
+{
+	mtk_disp_comp_update(dev, DPI_SIZE, width << HSIZE, HSIZE_MASK);
+	mtk_disp_comp_update(dev, DPI_SIZE, height << VSIZE, VSIZE_MASK);
+}
+
+static void mtk_dpi_config_channel_limit(struct udevice *dev,
+					 const struct mtk_dpi_yc_limit *limit)
+{
+	mtk_disp_comp_update(dev, DPI_Y_LIMIT, limit->y_bottom << Y_LIMINT_BOT,
+			     Y_LIMINT_BOT_MASK);
+	mtk_disp_comp_update(dev, DPI_Y_LIMIT, limit->y_top << Y_LIMINT_TOP,
+			     Y_LIMINT_TOP_MASK);
+	mtk_disp_comp_update(dev, DPI_C_LIMIT, limit->c_bottom << C_LIMIT_BOT,
+			     C_LIMIT_BOT_MASK);
+	mtk_disp_comp_update(dev, DPI_C_LIMIT, limit->c_top << C_LIMIT_TOP,
+			     C_LIMIT_TOP_MASK);
+}
+
+static void mtk_dpi_config_bit_num(struct udevice *dev,
+				   enum mtk_dpi_out_bit_num num)
+{
+	u32 val;
+
+	switch (num) {
+	case MTK_DPI_OUT_BIT_NUM_8BITS:
+		val = OUT_BIT_8;
+		break;
+	case MTK_DPI_OUT_BIT_NUM_10BITS:
+		val = OUT_BIT_10;
+		break;
+	case MTK_DPI_OUT_BIT_NUM_12BITS:
+		val = OUT_BIT_12;
+		break;
+	case MTK_DPI_OUT_BIT_NUM_16BITS:
+		val = OUT_BIT_16;
+		break;
+	default:
+		val = OUT_BIT_8;
+		break;
+	}
+
+	mtk_disp_comp_update(dev, DPI_OUTPUT_SETTING, val << OUT_BIT,
+			     OUT_BIT_MASK);
+}
+
+static void mtk_dpi_config_yc_map(struct udevice *dev,
+				  enum mtk_dpi_out_yc_map map)
+{
+	u32 val;
+
+	switch (map) {
+	case MTK_DPI_OUT_YC_MAP_RGB:
+		val = YC_MAP_RGB;
+		break;
+	case MTK_DPI_OUT_YC_MAP_CYCY:
+		val = YC_MAP_CYCY;
+		break;
+	case MTK_DPI_OUT_YC_MAP_YCYC:
+		val = YC_MAP_YCYC;
+		break;
+	case MTK_DPI_OUT_YC_MAP_CY:
+		val = YC_MAP_CY;
+		break;
+	case MTK_DPI_OUT_YC_MAP_YC:
+		val = YC_MAP_YC;
+		break;
+	default:
+		val = YC_MAP_RGB;
+		break;
+	}
+
+	mtk_disp_comp_update(dev, DPI_OUTPUT_SETTING, val << YC_MAP,
+			     YC_MAP_MASK);
+}
+
+static void mtk_dpi_config_channel_swap(struct udevice *dev,
+					enum mtk_dpi_out_channel_swap swap)
+{
+	u32 val;
+
+	switch (swap) {
+	case MTK_DPI_OUT_CHANNEL_SWAP_RGB:
+		val = SWAP_RGB;
+		break;
+	case MTK_DPI_OUT_CHANNEL_SWAP_GBR:
+		val = SWAP_GBR;
+		break;
+	case MTK_DPI_OUT_CHANNEL_SWAP_BRG:
+		val = SWAP_BRG;
+		break;
+	case MTK_DPI_OUT_CHANNEL_SWAP_RBG:
+		val = SWAP_RBG;
+		break;
+	case MTK_DPI_OUT_CHANNEL_SWAP_GRB:
+		val = SWAP_GRB;
+		break;
+	case MTK_DPI_OUT_CHANNEL_SWAP_BGR:
+		val = SWAP_BGR;
+		break;
+	default:
+		val = SWAP_RGB;
+		break;
+	}
+
+	mtk_disp_comp_update(dev, DPI_OUTPUT_SETTING, val << CH_SWAP,
+			     CH_SWAP_MASK);
+}
+
+static void mtk_dpi_config_swap_input(struct udevice *dev, bool enable)
+{
+	mtk_disp_comp_update(dev, DPI_CON, enable ? IN_RB_SWAP : 0, IN_RB_SWAP);
+}
+
+static void mtk_dpi_config_yuv422_enable(struct udevice *dev, bool enable)
+{
+	mtk_disp_comp_update(dev, DPI_CON, enable ? YUV422_EN : 0, YUV422_EN);
+}
+
+static void mtk_dpi_config_csc_enable(struct udevice *dev, bool enable)
+{
+	mtk_disp_comp_update(dev, DPI_CON, enable ? CSC_ENABLE : 0, CSC_ENABLE);
+}
+
+void mtk_dpi_hw_enable(struct udevice *dev)
+{
+	mtk_disp_comp_update(dev, DPI_EN, EN, EN);
+}
+
+void mtk_dpi_hw_disable(struct udevice *dev)
+{
+	mtk_disp_comp_update(dev, DPI_EN, 0, EN);
+}
+
+void mtk_dpi_config(struct udevice *dev, const struct display_timing *timing)
+{
+	struct mtk_dpi_yc_limit limit;
+	struct mtk_dpi_polarities dpi_pol;
+	struct mtk_dpi_sync_param hsync;
+	struct mtk_dpi_sync_param vsync_lodd = { };
+	struct mtk_dpi_sync_param vsync_leven = { };
+	struct mtk_dpi_sync_param vsync_rodd = { };
+	struct mtk_dpi_sync_param vsync_reven = { };
+	bool interlaced = timing->flags & DISPLAY_FLAGS_INTERLACED;
+
+	limit.c_bottom = 0x0010;
+	limit.c_top = 0x0FE0;
+	limit.y_bottom = 0x0010;
+	limit.y_top = 0x0FE0;
+
+	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
+	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
+	dpi_pol.hsync_pol = timing->flags & DISPLAY_FLAGS_HSYNC_HIGH ?
+			    MTK_DPI_POLARITY_FALLING :
+			    MTK_DPI_POLARITY_RISING;
+	dpi_pol.vsync_pol = timing->flags & DISPLAY_FLAGS_VSYNC_HIGH ?
+			    MTK_DPI_POLARITY_FALLING :
+			    MTK_DPI_POLARITY_RISING;
+
+	hsync.sync_width = timing->hsync_len.typ;
+	hsync.back_porch = timing->hback_porch.typ;
+	hsync.front_porch = timing->hfront_porch.typ;
+	hsync.shift_half_line = false;
+
+	vsync_lodd.sync_width = timing->vsync_len.typ;
+	vsync_lodd.back_porch = timing->vback_porch.typ;
+	vsync_lodd.front_porch = timing->vfront_porch.typ;
+	vsync_lodd.shift_half_line = false;
+
+	if (interlaced) {
+		vsync_leven = vsync_lodd;
+		vsync_leven.shift_half_line = true;
+	}
+
+	mtk_dpi_sw_reset(dev, true);
+	mtk_dpi_config_pol(dev, &dpi_pol);
+
+	mtk_dpi_config_hsync(dev, &hsync);
+	mtk_dpi_config_vsync_lodd(dev, &vsync_lodd);
+	mtk_dpi_config_vsync_rodd(dev, &vsync_rodd);
+	mtk_dpi_config_vsync_leven(dev, &vsync_leven);
+	mtk_dpi_config_vsync_reven(dev, &vsync_reven);
+
+	mtk_dpi_config_interface(dev, interlaced);
+	if (interlaced)
+		mtk_dpi_config_fb_size(dev, timing->hactive.typ,
+				       timing->vactive.typ / 2);
+	else
+		mtk_dpi_config_fb_size(dev, timing->hactive.typ,
+				       timing->vactive.typ);
+
+	mtk_dpi_config_input_2p(dev, true);
+	mtk_dpi_config_output_1t1p(dev, true);
+	mtk_dpi_config_channel_limit(dev, &limit);
+	mtk_dpi_config_bit_num(dev, MTK_DPI_OUT_BIT_NUM_8BITS);
+	mtk_dpi_config_channel_swap(dev, MTK_DPI_OUT_CHANNEL_SWAP_RGB);
+	mtk_dpi_config_yc_map(dev, MTK_DPI_OUT_YC_MAP_RGB);
+	mtk_dpi_config_yuv422_enable(dev, false);
+	mtk_dpi_config_csc_enable(dev, false);
+	mtk_dpi_config_swap_input(dev, false);
+	mtk_dpi_sw_reset(dev, false);
+}
+
+static const struct udevice_id mtk_dpi_ids[] = {
+	{ .compatible = "mediatek,mt8195-dpi" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_dpi) = {
+	.name	   = "mtk_dpi",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_dpi_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_dpi.h b/drivers/video/mediatek/mtk_dpi.h
new file mode 100644
index 00000000000..13ba252cd81
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dpi.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek MT8188 DPI Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DPI_H
+#define _MTK_DPI_H
+
+struct display_timing;
+struct udevice;
+
+/**
+ * mtk_dpi_hw_enable() - start the DPI output
+ * @dev: DPI device
+ */
+void mtk_dpi_hw_enable(struct udevice *dev);
+
+/**
+ * mtk_dpi_hw_disable() - stop the DPI output
+ * @dev: DPI device
+ */
+void mtk_dpi_hw_disable(struct udevice *dev);
+
+/**
+ * mtk_dpi_config() - configure the DPI for a display timing
+ * @dev: DPI device
+ * @timing: display timing to output, as 8-bit RGB
+ */
+void mtk_dpi_config(struct udevice *dev, const struct display_timing *timing);
+
+#endif /* _MTK_DPI_H */
diff --git a/drivers/video/mediatek/mtk_dpi_regs.h b/drivers/video/mediatek/mtk_dpi_regs.h
new file mode 100644
index 00000000000..23eeefce8fd
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dpi_regs.h
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Jie Qiu <jie.qiu@mediatek.com>
+ */
+#ifndef __MTK_DPI_REGS_H
+#define __MTK_DPI_REGS_H
+
+#define DPI_EN			0x00
+#define EN				BIT(0)
+
+#define DPI_RET			0x04
+#define RST				BIT(0)
+
+#define DPI_INTEN		0x08
+#define INT_VSYNC_EN			BIT(0)
+#define INT_VDE_EN			BIT(1)
+#define INT_UNDERFLOW_EN		BIT(2)
+
+#define DPI_INTSTA		0x0C
+#define INT_VSYNC_STA			BIT(0)
+#define INT_VDE_STA			BIT(1)
+#define INT_UNDERFLOW_STA		BIT(2)
+
+#define DPI_CON			0x10
+#define BG_ENABLE			BIT(0)
+#define IN_RB_SWAP			BIT(1)
+#define INTL_EN				BIT(2)
+#define TDFP_EN				BIT(3)
+#define CLPF_EN				BIT(4)
+#define YUV422_EN			BIT(5)
+#define CSC_ENABLE			BIT(6)
+#define R601_SEL			BIT(7)
+#define EMBSYNC_EN			BIT(8)
+#define VS_LODD_EN			BIT(16)
+#define VS_LEVEN_EN			BIT(17)
+#define VS_RODD_EN			BIT(18)
+#define VS_REVEN			BIT(19)
+#define FAKE_DE_LODD			BIT(20)
+#define FAKE_DE_LEVEN			BIT(21)
+#define FAKE_DE_RODD			BIT(22)
+#define FAKE_DE_REVEN			BIT(23)
+
+/* DPI_CON: DPI instances */
+#define DPI_OUTPUT_1T1P_EN		BIT(24)
+#define DPI_INPUT_2P_EN			BIT(25)
+/* DPI_CON: DPINTF instances */
+#define DPINTF_YUV422_EN		BIT(24)
+#define DPINTF_CSC_ENABLE		BIT(26)
+#define DPINTF_INPUT_2P_EN		BIT(29)
+
+#define DPI_OUTPUT_SETTING	0x14
+#define CH_SWAP				0
+#define DPINTF_CH_SWAP			1
+#define CH_SWAP_MASK			(0x7 << 0)
+#define SWAP_RGB			0x00
+#define SWAP_GBR			0x01
+#define SWAP_BRG			0x02
+#define SWAP_RBG			0x03
+#define SWAP_GRB			0x04
+#define SWAP_BGR			0x05
+#define BIT_SWAP			BIT(3)
+#define B_MASK				BIT(4)
+#define G_MASK				BIT(5)
+#define R_MASK				BIT(6)
+#define DE_MASK				BIT(8)
+#define HS_MASK				BIT(9)
+#define VS_MASK				BIT(10)
+#define DE_POL				BIT(12)
+#define HSYNC_POL			BIT(13)
+#define VSYNC_POL			BIT(14)
+#define CK_POL				BIT(15)
+#define OEN_OFF				BIT(16)
+#define EDGE_SEL			BIT(17)
+#define OUT_BIT				18
+#define OUT_BIT_MASK			(0x3 << 18)
+#define OUT_BIT_8			0x00
+#define OUT_BIT_10			0x01
+#define OUT_BIT_12			0x02
+#define OUT_BIT_16			0x03
+#define YC_MAP				20
+#define YC_MAP_MASK			(0x7 << 20)
+#define YC_MAP_RGB			0x00
+#define YC_MAP_CYCY			0x04
+#define YC_MAP_YCYC			0x05
+#define YC_MAP_CY			0x06
+#define YC_MAP_YC			0x07
+
+#define DPI_SIZE		0x18
+#define HSIZE				0
+#define HSIZE_MASK			(0x1FFF << 0)
+#define DPINTF_HSIZE_MASK		(0xFFFF << 0)
+#define VSIZE				16
+#define VSIZE_MASK			(0x1FFF << 16)
+#define DPINTF_VSIZE_MASK		(0xFFFF << 16)
+
+#define DPI_DDR_SETTING		0x1C
+#define DDR_EN				BIT(0)
+#define DDDR_SEL			BIT(1)
+#define DDR_4PHASE			BIT(2)
+#define DDR_WIDTH			(0x3 << 4)
+#define DDR_PAD_MODE			(0x1 << 8)
+
+#define DPI_TGEN_HWIDTH		0x20
+#define HPW				0
+#define HPW_MASK			(0xFFF << 0)
+#define DPINTF_HPW_MASK			(0xFFFF << 0)
+
+#define DPI_TGEN_HPORCH		0x24
+#define HBP				0
+#define HBP_MASK			(0xFFF << 0)
+#define DPINTF_HBP_MASK			(0xFFFF << 0)
+#define HFP				16
+#define HFP_MASK			(0xFFF << 16)
+#define DPINTF_HFP_MASK			(0xFFFF << 16)
+
+#define DPI_TGEN_VWIDTH		0x28
+#define DPI_TGEN_VPORCH		0x2C
+
+#define VSYNC_WIDTH_SHIFT		0
+#define VSYNC_WIDTH_MASK		(0xFFF << 0)
+#define DPINTF_VSYNC_WIDTH_MASK		(0xFFFF << 0)
+#define VSYNC_HALF_LINE_SHIFT		16
+#define VSYNC_HALF_LINE_MASK		BIT(16)
+#define VSYNC_BACK_PORCH_SHIFT		0
+#define VSYNC_BACK_PORCH_MASK		(0xFFF << 0)
+#define DPINTF_VSYNC_BACK_PORCH_MASK	(0xFFFF << 0)
+#define VSYNC_FRONT_PORCH_SHIFT		16
+#define VSYNC_FRONT_PORCH_MASK		(0xFFF << 16)
+#define DPINTF_VSYNC_FRONT_PORCH_MASK	(0xFFFF << 16)
+
+#define DPI_BG_HCNTL		0x30
+#define BG_RIGHT			(0x1FFF << 0)
+#define BG_LEFT				(0x1FFF << 16)
+
+#define DPI_BG_VCNTL		0x34
+#define BG_BOT				(0x1FFF << 0)
+#define BG_TOP				(0x1FFF << 16)
+
+#define DPI_BG_COLOR		0x38
+#define BG_B				(0xF << 0)
+#define BG_G				(0xF << 8)
+#define BG_R				(0xF << 16)
+
+#define DPI_FIFO_CTL		0x3C
+#define FIFO_VALID_SET			(0x1F << 0)
+#define FIFO_RST_SEL			(0x1 << 8)
+
+#define DPI_STATUS		0x40
+#define VCOUNTER			(0x1FFF << 0)
+#define DPI_BUSY			BIT(16)
+#define OUTEN				BIT(17)
+#define FIELD				BIT(20)
+#define TDLR				BIT(21)
+
+#define DPI_TMODE		0x44
+#define DPI_OEN_ON			BIT(0)
+
+#define DPI_CHECKSUM		0x48
+#define DPI_CHECKSUM_MASK		(0xFFFFFF << 0)
+#define DPI_CHECKSUM_READY		BIT(30)
+#define DPI_CHECKSUM_EN			BIT(31)
+
+#define DPI_DUMMY		0x50
+#define DPI_DUMMY_MASK			(0xFFFFFFFF << 0)
+
+#define DPI_TGEN_VWIDTH_LEVEN	0x68
+#define DPI_TGEN_VPORCH_LEVEN	0x6C
+#define DPI_TGEN_VWIDTH_RODD	0x70
+#define DPI_TGEN_VPORCH_RODD	0x74
+#define DPI_TGEN_VWIDTH_REVEN	0x78
+#define DPI_TGEN_VPORCH_REVEN	0x7C
+
+#define DPI_ESAV_VTIMING_LODD	0x80
+#define ESAV_VOFST_LODD			(0xFFF << 0)
+#define ESAV_VWID_LODD			(0xFFF << 16)
+
+#define DPI_ESAV_VTIMING_LEVEN	0x84
+#define ESAV_VOFST_LEVEN		(0xFFF << 0)
+#define ESAV_VWID_LEVEN			(0xFFF << 16)
+
+#define DPI_ESAV_VTIMING_RODD	0x88
+#define ESAV_VOFST_RODD			(0xFFF << 0)
+#define ESAV_VWID_RODD			(0xFFF << 16)
+
+#define DPI_ESAV_VTIMING_REVEN	0x8C
+#define ESAV_VOFST_REVEN		(0xFFF << 0)
+#define ESAV_VWID_REVEN			(0xFFF << 16)
+
+#define DPI_ESAV_FTIMING	0x90
+#define ESAV_FOFST_ODD			(0xFFF << 0)
+#define ESAV_FOFST_EVEN			(0xFFF << 16)
+
+#define DPI_CLPF_SETTING	0x94
+#define CLPF_TYPE			(0x3 << 0)
+#define ROUND_EN			BIT(4)
+
+#define DPI_Y_LIMIT		0x98
+#define Y_LIMINT_BOT			0
+#define Y_LIMINT_BOT_MASK		(0xFFF << 0)
+#define Y_LIMINT_TOP			16
+#define Y_LIMINT_TOP_MASK		(0xFFF << 16)
+
+#define DPI_C_LIMIT		0x9C
+#define C_LIMIT_BOT			0
+#define C_LIMIT_BOT_MASK		(0xFFF << 0)
+#define C_LIMIT_TOP			16
+#define C_LIMIT_TOP_MASK		(0xFFF << 16)
+
+#define DPI_YUV422_SETTING	0xA0
+#define UV_SWAP				BIT(0)
+#define CR_DELSEL			BIT(4)
+#define CB_DELSEL			BIT(5)
+#define Y_DELSEL			BIT(6)
+#define DE_DELSEL			BIT(7)
+
+#define DPI_EMBSYNC_SETTING	0xA4
+#define EMBSYNC_R_CR_EN			BIT(0)
+#define EMPSYNC_G_Y_EN			BIT(1)
+#define EMPSYNC_B_CB_EN			BIT(2)
+#define ESAV_F_INV			BIT(4)
+#define ESAV_V_INV			BIT(5)
+#define ESAV_H_INV			BIT(6)
+#define ESAV_CODE_MAN			BIT(8)
+#define VS_OUT_SEL			(0x7 << 12)
+
+#define DPI_ESAV_CODE_SET0	0xA8
+#define ESAV_CODE0			(0xFFF << 0)
+#define ESAV_CODE1			(0xFFF << 16)
+
+#define DPI_ESAV_CODE_SET1	0xAC
+#define ESAV_CODE2			(0xFFF << 0)
+#define ESAV_CODE3_MSB			BIT(16)
+
+#define EDGE_SEL_EN			BIT(5)
+#define H_FRE_2N			BIT(25)
+
+#define DPI_MATRIX_SET		0xB4
+#define INT_MATRIX_SEL_MASK		GENMASK(4, 0)
+#define MATRIX_SEL_RGB_TO_JPEG		0
+#define MATRIX_SEL_RGB_TO_BT601		2
+
+#define DPI_PATTERN0		0xf00
+#define DPI_PAT_EN			BIT(0)
+#define DPI_PAT_SEL			GENMASK(6, 4)
+
+#endif /* __MTK_DPI_REGS_H */

-- 
2.55.0

