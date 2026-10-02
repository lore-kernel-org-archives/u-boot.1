Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E49CA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4233C81340;
	Fri,  2 Oct 2026 14:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i_X9F27ax7bF; Fri,  2 Oct 2026 14:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B64F18134C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949699;
	b=R6zktR1K2oYpuTXnXTzwj6eIv9Z364fvjjz0oxH1zSKA0O+sWUN+HF8yWyOKYX/S0LK5
	 ezm9AzijOzG8XSG0v+qmTYsTblRYPrUNQPkMLzDp8oCGtmSQFjCsTZiaGRfLMjFYrd1TM
	 8RftwdBuiAyidxRRqqvEyZXCJefItIHjofShuv/6MJD7EXZzkVe2bDMfR/K55SI2erIoD
	 t9OYFQz1bJB0BqDjrtXe0iK6Bo1NgCZ/gom99t2XZdzoQgvWTqrPztF4zDbN4Fvw4H9iO
	 WIJ76yoCsH9v1DsfcDxxYdimuXSUDpVXKCQztAMdEwAw1/ybQON/tp3M7sCFSTtWxIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hNFCwSTITuuh3zuvbrIfBxYhL4zKihutr2bRwPBSNCE=;
	b=lcYsKNDDDRjkG9Q99JX5fCHYOJDdPeO2M0j1T48E68w/w2pDMC34TuwIB0llZNJQXK8B
	 6sxGQqxyzTbSIdkAo/jMYhyQd2cXKfmtg6AI76pYSatBT5Yb/+c1gUPRnfirR/RprSz9h
	 sgemVg/1xxQEQmcwzUEdEBPdTcauDwQdNnfo2Q5QrymKkEg6Tx86FBewR9RzwGh/pw+p5
	 Goft/Cxw4wKfyrTLnhiwjvJuMVuMwTRzqVAr7HKvmYcI4blNUnXWZOXbjc0yhlyPuAtcr
	 6Dt+7Cc9cMvG23aN+eefkLNgf+F1bmi64lj8WB69uDWfZOeSCgEXJPFzc/ZwlZ7rOJg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949699;
	bh=hNFCwSTITuuh3zuvbrIfBxYhL4zKihutr2bRwPBSNCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1DPPGGH+MTKrqoWKt3omgaBEoTWuewb8/mv1ud9Pc69aSPifq9zGRKP43xrsEHwGN
	 79VTF6qMbbQwkoyuc93ZB14NnwfdtaRVREUaXI7vxOVnhfDadVFBf3yp0n0hLa7qQR
	 4I+nzbUcNi5MX6zTsVwZ7M2wf9pZX/75CPlVmnMsXIvOX6rPwHOj+HcGGOK8sFo5yq
	 58tXlIeOULV6FzBFgp7BxT+Ozmc7iy7lLp8t96UHjx+SB2eOZmOaxO8R5jEAS4RoEp
	 Vxzvc3Ra1ysm4Xl9T3JurnFXjmmCfcHCRDoCMKTT5nxEIarXy/pHBR+a3UgOtzVsGv
	 6wPyMi/D/vH/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B64F18134C;
	Fri,  2 Oct 2026 14:01:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B0FD435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70EB160D70
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K3Q0Ef61B7qu for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 61D2A60C22
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949694;
 b=gA7w7/xv9sHJbKhwlTp+IN2tt6rf7GvSXZNlHMT9/LK/p4Z81qoeFMCjByhT6sru9HXp
 IrP37VwQZDDFd7+bUFSOD6OYCytePCeCQGAWR0LeXMZvnuVd/ZvuwL5JkoBFeGSUOt7il
 h/O8nRl+CjuXu3WyetUB+1Kg+/gjMsifQzPqBDvZi0odau8okHlw/hs4BBKGVzc/t6KLt
 pXym2StzkYsCQvRUCYJA5fb0SSd1Xd9mbX9NLHRL6+u1EDOqZ+S8DM/HoCbljrUO/Ew4m
 2nOK+V9cLBIKyMBxNwCQEzODMzuckM/9MQ3z7QLW5G45/+AcSlazy6bKd5CWyGBa4Sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949694;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=hNFCwSTITuuh3zuvbrIfBxYhL4zKihutr2bRwPBSNCE=;
 b=FTasjNFLAmCJPLG0VUh4SaChkBVm8gaJp2G0XHC6FDoFf/ptkLhsinfj/7dQNk329a59
 J48okpGbAQDLYqdYU0mOL8TsxjtYsd2VICu07TXXL1zGWna1Z52uWtvqQr+Nq/uWNd+Pq
 880I/HBJiDiIMxmieVHdrSItkCsbwHXNvN56htEh9xm3FdWe4p1Iq23zRBJcQVTQv+U94
 M/VdnfrvJM/fzF6rof62nrPfl6PkYk2r5XaBAZerADcPqoGcTWDuws2qROHMsTJLisiAl
 YXYawJGrxsZTDNxHHMcT4QSznwlCShVSZa6vEh2YBdkcDyoERT4v61MssmzfDUA0hnA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gbha3Bzz; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gbha3Bzz
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61D2A60C22
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:34 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48aef5d66c1so2437068f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949692; x=1791554492;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hNFCwSTITuuh3zuvbrIfBxYhL4zKihutr2bRwPBSNCE=;
 b=gbha3BzzwCoJtjEGPV5sdp260TFtRpWz6nE+M5M1+Fd3bzJMyQp9fnrzy7hDU9D0Gy
 RbW1uDuRfqri7P8vDfhxpI1x3OGZXpPgu79lFGUjA4IL5wYtjx3SGwlUV1VWPnl4GOiO
 IPTDY2TOXDMt2UKkcTiJutRXF1B+3na+z3fXR1n1lFFNZGxMJaDXw+xWd/OJEh+nHLKI
 LtXZGtC1yiARu5UnEOqIwVuyM5uCCY5lQ5eOraihTpBB77pnlyy+pH1jor25zLWxUzwu
 U8or8JPTrpbe+oxDAoFbj2pk+Pyxl4UkWVIDpls4GhMvTlwvD5hgjXCde0B236pwZTro
 jCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949692; x=1791554492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hNFCwSTITuuh3zuvbrIfBxYhL4zKihutr2bRwPBSNCE=;
 b=wWpzHY6y+hE4XDtY4JxGejSFTmSLxqiCifxrcyBGSWBGgYNOBdgE9LXPnmCbZuktxW
 6KAXEzOee/qoOgq8PyYXwNWoRsv5X1e8N4gMMCBbzJfzcSeHt6RO8bbz5jzw4+mdeaKM
 6EOUnzbS1AoMHkwHc6UO6FqNEDDzpCZU8L2m3/v2FnMWYgbnFK6PS8wC1HEOj8ICIu3h
 FXbaGUnfxFTHTHzLuRME7ROYspYNdYE9OWk+zEfYFlj3C0kW28tU+cPv+tWh8/6FEJpF
 rmYbJX1P6CFNK63NEpa5C5Qr/5cOPTt7JGYaXEpvScmIpdwtcZG3ue3NDkObVl8C+lML
 /8lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0WJ//LIqvExQWfEKAF6td/3swqzTMvgUhovGDek+2HTFK89DgGkV8QUnM3Htbu5GTKf2+gsY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJCd6DMCBvAlAGJB74o50Aqw28R5CHVxbxeLqAElibpA2GVwfEs
 ph9vRm9wOIcRsdtBecXDosr89n367XhT+ejzG1cmIFtoy6LcxrWqjpWanNGe9Yh+XhU=
X-Gm-Gg: AYBFou1nSJmVNt5WmJgpJ76R/QBg+1RCrIkHNClCUM4vvIf7j2HcRyi1o0MrgUmFUaP
 ujghHU94VaCFvJzl2K3EgRzutCKCe+i8TBW92FH5wRm9tR+Ju2LQRqpd6GIpUXmP8GmYAIeya+M
 xFJt2SPIOKyvldi+mjPXO/O9ECqfDWeuTFSAaRoR+mVPBBI+P0XzoDfTIPUVG1mRu1Sq0PNnpQL
 ymLOaX9zf7lx+2BtvdlNys1D5bpLzktqD1NuGN7s4LHkl5mBFtQJyyl6Ilt4IZ2+O4CHx5IWGWw
 ulNIW+el2DeTmjCdsLF5q1rP8d1OjYKhJF+LtH+GykUyRTGJpYxOpgqCKdPGpJ7RW/xUiCB/pjb
 q56RtRGqWJcTRr7TknLfzLfNeubhiK/xw/SRtiIKqlQjRDbLVOJCJ2cTcRgvobAaGTTymn8BfVH
 kuXjFMFu+H9R4xNJXjNgQoiRMcB7BTtv+A1obvie4Va3ylkgKKXza6hbcaSe4uSz+uY82GdN6YL
 NgduTrpC1oOb9hC7QYBhC1FUf4QqulrtpTVfNfmNadCS9xIm5/xW3f2wvPj6Rcty3DL93XKb7GW
 vLUbVAEZ7ZEw5GUM6BucRAlXiQKfKjtv37ybGHBUyafAsWuB9hKno00=
X-Received: by 2002:a05:6000:385:b0:488:79db:c73b with SMTP id
 ffacd0b85a97d-48b12717923mr5031791f8f.24.1790949692324; 
 Fri, 02 Oct 2026 07:01:32 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:31 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:04:00 +0200
Subject: [PATCH v2 09/13] video: mediatek: add ddp component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-9-9e435457b90c@baylibre.com>
References: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
In-Reply-To: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
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

The display data path (ddp) is the set of muxes of the mmsys register
space routing the components of the video pipeline into each other.

Add the route needed to bring up a splash screen, the overlay to the
DSI, with one function per SoC: mt8365_ddp_ovl_to_dsi() goes through the
colour pipeline, mt8366_ddp_ovl_to_dsi() straight through the crossbar.

The muxes have no device of their own: they live in the mmsys syscon
window, which the DSI driver maps and hands over, so no compatible is
added here. The MT8365 offsets and values are the ones of the Linux
mt8365_mmsys_routing_table; the MT8366 ones come from its downstream
mmsys, that SoC not being upstream yet.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_ddp.c | 122 +++++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_ddp.h |  30 ++++++++++
 2 files changed, 152 insertions(+)

diff --git a/drivers/video/mediatek/mtk_ddp.c b/drivers/video/mediatek/mtk_ddp.c
new file mode 100644
index 00000000000..246e6615fa0
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ddp.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Display Data Path
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+#include "mtk_ddp.h"
+
+/*
+ * mt8365-generation mmsys: the path is built out of direct muxes, one
+ * register per input or output. The offsets and the values are the ones of
+ * the Linux mt8365_mmsys_routing_table.
+ */
+#define MT8365_DISP_MS_IN_OUT_MASK			GENMASK(3, 0)
+
+#define MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0xf3c
+#define MT8365_OVL0_MOUT_PATH0_SEL				BIT(0)
+
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL	0xf4c
+#define MT8365_RDMA0_SOUT_COLOR0				0x1
+
+#define MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN	0xf50
+#define MT8365_DITHER_MOUT_EN_DSI0				BIT(0)
+
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN	0xf54
+#define MT8365_RDMA0_SEL_IN_OVL0				0x0
+
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN	0xf60
+#define MT8365_RDMA0_RSZ0_SEL_IN_RDMA0				0x0
+
+#define MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0xf64
+#define MT8365_DISP_COLOR_SEL_IN_COLOR0				0x0
+
+#define MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN		0xf68
+#define MT8365_DSI0_SEL_IN_DITHER				0x1
+
+/*
+ * mt8366-generation mmsys uses a multi-stage crossbar instead of the simple
+ * direct muxes above.
+ */
+#define MT8366_DISP_OVL0_BGCLR_MOUT_EN			0xe24
+#define MT8366_DISP_OVL_BGCLR_MOUT_MASK				GENMASK(1, 0)
+#define MT8366_MOUT_OVL_TO_BLENDOUT				BIT(0)
+
+#define MT8366_DISP_OVL0_OUT0_MOUT_EN			0xc10
+#define MT8366_DISP_OVL_OUT0_MOUT_MASK				GENMASK(2, 0)
+#define MT8366_MOUT_DISP_OVL0_TO_DISP_RDMA0			BIT(1)
+
+#define MT8366_DISP_RDMA0_SEL_IN			0xe04
+#define MT8366_DISP_RDMA_SEL_IN_MASK				BIT(0)
+#define MT8366_SEL_IN_DISP_RDMA0_FROM_DISP_OVL0_OUT0_MOUT	0x1
+
+#define MT8366_DISP_RDMA0_RSZ0_SOUT_SEL			0xe00
+#define MT8366_SOUT_DISP_RDMA0_RSZ0_TO_OVL_PQ_OUT_CROSSBAR1	0x0
+
+#define MT8366_OVL_PQ_OUT_CROSSBAR1_MOUT_EN		0xc78
+#define MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK			GENMASK(5, 0)
+#define MT8366_MOUT_OVL_PQ_OUT_CROSSBAR1_TO_COMP_OUT_CROSSBAR4	BIT(4)
+
+#define MT8366_COMP_OUT_CROSSBAR4_MOUT_EN		0xd80
+#define MT8366_COMP_OUT_CROSSBAR_MOUT_MASK			GENMASK(5, 0)
+#define MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DSI0		BIT(0)
+
+static void mtk_ddp_mask(void __iomem *base, u32 offset, u32 val, u32 mask)
+{
+	u32 tmp = readl(base + offset) & ~mask;
+
+	writel(tmp | (val & mask), base + offset);
+}
+
+void mt8365_ddp_ovl_to_dsi(void __iomem *mmsys_base)
+{
+	/* OVL0 -> RDMA0 */
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
+		     MT8365_OVL0_MOUT_PATH0_SEL, MT8365_DISP_MS_IN_OUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN,
+		     MT8365_RDMA0_SEL_IN_OVL0, MT8365_DISP_MS_IN_OUT_MASK);
+
+	/* RDMA0 -> COLOR0 */
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN,
+		     MT8365_RDMA0_RSZ0_SEL_IN_RDMA0, MT8365_DISP_MS_IN_OUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL,
+		     MT8365_RDMA0_SOUT_COLOR0, MT8365_DISP_MS_IN_OUT_MASK);
+
+	/* COLOR0 -> CCORR0 -> AAL0 -> GAMMA0 -> DITHER0 -> DSI0 */
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
+		     MT8365_DISP_COLOR_SEL_IN_COLOR0, MT8365_DISP_MS_IN_OUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN,
+		     MT8365_DITHER_MOUT_EN_DSI0, MT8365_DISP_MS_IN_OUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN,
+		     MT8365_DSI0_SEL_IN_DITHER, MT8365_DISP_MS_IN_OUT_MASK);
+}
+
+void mt8366_ddp_ovl_to_dsi(void __iomem *mmsys_base)
+{
+	/* OVL0 -> RDMA0 */
+	mtk_ddp_mask(mmsys_base, MT8366_DISP_OVL0_BGCLR_MOUT_EN,
+		     MT8366_MOUT_OVL_TO_BLENDOUT, MT8366_DISP_OVL_BGCLR_MOUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8366_DISP_OVL0_OUT0_MOUT_EN,
+		     MT8366_MOUT_DISP_OVL0_TO_DISP_RDMA0,
+		     MT8366_DISP_OVL_OUT0_MOUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8366_DISP_RDMA0_SEL_IN,
+		     MT8366_SEL_IN_DISP_RDMA0_FROM_DISP_OVL0_OUT0_MOUT,
+		     MT8366_DISP_RDMA_SEL_IN_MASK);
+
+	/* RDMA0 -> COMP_OUT_CROSSBAR4 -> DSI0 */
+	mtk_ddp_mask(mmsys_base, MT8366_DISP_RDMA0_RSZ0_SOUT_SEL,
+		     MT8366_SOUT_DISP_RDMA0_RSZ0_TO_OVL_PQ_OUT_CROSSBAR1,
+		     MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8366_OVL_PQ_OUT_CROSSBAR1_MOUT_EN,
+		     MT8366_MOUT_OVL_PQ_OUT_CROSSBAR1_TO_COMP_OUT_CROSSBAR4,
+		     MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK);
+	mtk_ddp_mask(mmsys_base, MT8366_COMP_OUT_CROSSBAR4_MOUT_EN,
+		     MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DSI0,
+		     MT8366_COMP_OUT_CROSSBAR_MOUT_MASK);
+}
diff --git a/drivers/video/mediatek/mtk_ddp.h b/drivers/video/mediatek/mtk_ddp.h
new file mode 100644
index 00000000000..f7efbd64cae
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ddp.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DDP_H
+#define _MTK_DDP_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/**
+ * mt8365_ddp_ovl_to_dsi() - route the MT8365 mmsys muxes from the OVL to the DSI
+ * @mmsys_base: mmsys config register window
+ *
+ * Go through the color, ccorr, aal, gamma and dither blocks.
+ */
+void mt8365_ddp_ovl_to_dsi(void __iomem *mmsys_base);
+
+/**
+ * mt8366_ddp_ovl_to_dsi() - route the MT8366 mmsys muxes from the OVL to the DSI
+ * @mmsys_base: mmsys config register window
+ *
+ * Go straight from the rdma to the DSI, through the crossbars.
+ */
+void mt8366_ddp_ovl_to_dsi(void __iomem *mmsys_base);
+
+#endif /* _MTK_DDP_H */

-- 
2.55.0

