Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55248C9832A
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 057EC81304;
	Fri, 25 Sep 2026 13:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8SKipKRjTiIn; Fri, 25 Sep 2026 13:40:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 05D4081314
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343642;
	b=ddb11zqCLZLclNGd5U72o5dYRmZqOrWUo7M2lqiiBjkO8jTgQbbNWSLINaNuWvapPb+c
	 jd5CoVAxuHxg5sIIGDw0GJTDJQp8pJ7wVajYR0nFd+BI/fMhs2dFkEvUu27DpayPoLGRA
	 fVRiASWiyNLJxBZkA9Ez5Ylb5cc0TrLAx7B8HHEr842ncxPVYpU2LghLzm/SB6EGVapGv
	 5RzCvh9sw2keLvVeM8G+mV256gmZIvIT9szjkMT8E3o99ufsWawsQx3/zpXlFSoR/y/ji
	 zSCvYZUWDV86M8czhrNqHeulle0hq44+rSN61Ra4iAU8Ak6bEsirzoi/wHu2hxV+gog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
	b=A1gNnReF4rjdBm7tErjIPF4kmsOfxJFnFsZEgMyhgsagXO4pA6oQuaqg3sukWaA+ppkX
	 KhQ6a2U1+HlLxq/Wf7XOXrJS4b7gTciZ488zJpiGfYA+fd/OF/ifds3S7euR/9WWoE9bs
	 df/mvvP8/mS+mdmJ8DlX5Dr86QUi5F8fBRPZC/k5f78kdIygM0KrEpAjqNQdTk3zWedwT
	 nFrqboIUlJYGY6XIjqCkmDA02in1BwlRz4BmdCU4JQvWTW7UAnc1GayZSmr6h03JrTIrt
	 SxaL9S5J0DOVpxh2oVbRY9u+V0qXrl1LJ8PRZ0puHg3OLzmFbO5xGPr/1cwlV0qA5QQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343642;
	bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iA00g0eVk2Xz6XahyFzLYvF3RfBjXe9CLnzU0xcHXQc8JugwQWIamERNex5A8ydXh
	 ZRZn4f5gyGQeNgRn/OnVXasJ1gFAXgCamB/Q0orHedyfaImbYgIogaeLFt9HAUzqng
	 OcocVTl4gDpfkzfOyJwNPnZPGv5N4n3g1H/Xet7cKBcF2DDiImP7Zr0rVCoUYKC23m
	 oxSPMrVzkuufTtROQcmt2SC05h/uDB+B/PxuzGhb70knAb8aE/Xnkhgp6/2JEzGnNL
	 R/pZJgpkLd3DKhRIvseULy5v/SNg4h+PhQSybyz0ptVbFu88A2jtRFGqjkPnfhKH6r
	 lCkf7SW7k4wUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05D4081314;
	Fri, 25 Sep 2026 13:40:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A43E332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B87440042
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cOb11_0fckYP for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org ED0EF40180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343634;
 b=pU+1GIK/xXMKvHtujSns9CjothX/fdAGG7L1mETS27M08PBDZjpqgxn+LoI1J/IjkTid
 LbdiT9hxz2sb29wSuigESNm0O83tIzMbEWwZGnTxBbqmGIQxQ27u3BrxD9uaQbkV9GUyL
 w6hl51NW9jQTn+Lah2MZWhU8nV4q+WbLURmRkpIQ8RwGZIR6bFjbP9+nD7INMBcwCOMf6
 rgV9FRw8UwnB18NAiqGRwqgKaWg1ghyItqNmfd7a2RVfX9TWjuv5wQiiU3RrW6O8IEtGr
 1GwWXSniEXCaeBRkRWNDfBY9jsbNM53wugJDgSZqjAuyTYDmeEYrGZVQdnEhXDeYayg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343634;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
 b=kntCeKNnsMLDqASPti96wSvKprlXSPW2sDZtVNp85ovWY+Y1Q15hFac5eUWdQ3IehPQZ
 7cjBEjHFIPuZ4DfqvDCIPUh20Nwcw58rd7mgXnXYUUQttZ0ohlajfB8FHIK/r0hkuIXSx
 Xc5ZPg9ji3GRsopxlVSwZGJMRLU7gPecIdgonDbJ80JTLzgDK3tv+4xzfumWNVX1qujbp
 BCdj0BV5LXuxekQ1wVezOsfoE03NWm2gsCDEs9RYGBhSqtt737AxX6g3zrTptmQQS7sxq
 3dtu+2hOg3MoY3bApjeb5Ej2dXZX3Ev58SPH1Myxrd48CwpjhpDkp1oQOJY0ihGKGHQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hj1APq3X; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hj1APq3X
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED0EF40180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:33 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so526132f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343631; x=1790948431;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
 b=hj1APq3XpuWoOFHGq/YOWH0EmiiXNinZtitRdVWw6Zt1qC94E1UiVUSMvmQHAYR0sD
 WHWKamyhfA7f+SkwDxEadOfThZRj5BUlr21wj8mZi5WZ7YDzuNn2Hxdwsp9iYq+goeYu
 TMatFuU/B6WqyKmSWTgn/iSNsydJYA7SO/Tp7TRMB6igfDeFYrHwyCfoSPl3Lsz9GiLO
 QBPZKmWveWALsjmwIiZJv4YPs5gvVbLOVKvl3vttkQfVlqKdpb5NUGXjQUjYd7hla6qj
 bnBjl8CnthOo2FqY7z+G/IU4up5GrmJxxts4b4Fy9/CkBAsj2x1k1J6hRjmDpV6Pzgtb
 TW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343631; x=1790948431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
 b=jJB/tXPGZHg1kCnCwoQv+y0FQneNvGzUeueJyAvzspHcDcdXobwGM/gZN7kJBoG0F8
 L+TpJJC2JdCdgoeF2lqvnJEVTMvyqdxVqJdVeDgosuJidjxWihCdHgyy1kTl8PDs+4tF
 ADI4FkfuBNZ3hhMtPVOFf8oh5kEHMZyQ2DS7Zops2zLlMvL49/vIWaZHdCkqH2x0YMQc
 Tn/MM0en6Uenz/c/qW6yJVoFhtc1HWhWgjCPITp5kDl++rVD4IwDS3fvALCoTJp6IlBI
 6Wk727KM2Kv/O4cEgJxtW+XiAsRhyr9bw9bZbqjFLxqg5dPtmscOI+U4I2n4vJVQDcmR
 BEYg==
X-Gm-Message-State: AFuF++m+gXrjZlGb8qgF+9kA8fA8rDidANHpw8DbsSd9xs+OdBYqrq1E
 WOkOXbP0DER8EKXn+p7WzFY2Tr7VWhxtzY5R/xzvsVrRHqqFiYaO9k5/nmJUS0uanyo=
X-Gm-Gg: AYBFou1M0RLdI4A0x96Q/dwymiS0u3UE7Zpl2w94HznnCqQN6iOS4JaMBdqWI6/ccQi
 eEmUMCh8l2gBLk9qeKa3caFgMkkAjvgcVgBu4rAwUvAJJ1q74hP7cHB8MpgcC621FNJ2GW3rhNS
 iIWUiYZslCS3vqMAVoO3vajTGok3/5QTL+1ykHjkB6vxc0960rfsvH4KyDfDZxMQsXgpiDnv0NQ
 qwb209g5yXmS+7MMGEuqZZ6x8xgYIPcF+SbaGXKbnBYuBSgepS3cfCAHmXLqdYLvcibj1EzFhN/
 1SPTpL4U27LUx/uECtxjDc2knVDdKACaYPP3gMzrEq0SnqJemiYrgS8ZCNev0QE/sbyX59JhPlI
 jQ72Kp4XgaR4RtTvZ5kZECaTQfFlmXVHkbvQr/Ln0FtMgH7rztwmQQZ1+r4xOfk6l6ACEsXIyjc
 3C/0CCj7aKZsooQkZK0Mq4J4xeN3fEPlTRu5PQHoRuDQOknlC3uOzVDkL0Rg/0GJdPx82uWsknr
 43/zaAYfdOzsPM4+0ilqQPUtfTSfrkTghq1HYBzOAAkQx2WArJVHcwXHrX7JNzfzAktf8phE5+m
 FAjs0+Q6vkDgmgmCv4IFfwq8h5/1E48D4V4jL6PkXK7Sz1PUnBqlgxn0A/N+1kdwTA==
X-Received: by 2002:a05:6000:71d:b0:487:21a4:f617 with SMTP id
 ffacd0b85a97d-48871681179mr9677151f8f.19.1790343631202; 
 Fri, 25 Sep 2026 06:40:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:30 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:01 +0200
Subject: [PATCH v6 03/12] video: mediatek: add display pipeline component
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-3-29e626b213e9@baylibre.com>
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

Most of the simple display pipeline components share the same probe and
enable sequence: remap the register window and enable a bulk of clocks.
Add the mtk_disp_comp helpers holding this boilerplate so each component
driver only has to provide its own component-specific programming.

The components which are DMA masters also need the SMI larb feeding them
ungated, so add the lookup resolving that larb from their "iommus"
property; the enable and disable helpers take care of it from there.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c | 123 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_comp.h |  95 +++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
new file mode 100644
index 00000000000..f9eb9e00de6
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -0,0 +1,123 @@
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
+#include <dm/ofnode.h>
+#include <dt-bindings/memory/mtk-memory-port.h>
+#include <errno.h>
+#include <mtk_smi.h>
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
+void mtk_disp_comp_update(struct udevice *dev, u32 offset, u32 val, u32 mask)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	void __iomem *reg = priv->base + offset;
+	u32 tmp;
+
+	tmp = readl(reg);
+	tmp = (tmp & ~mask) | (val & mask);
+	writel(tmp, reg);
+}
+
+int mtk_disp_comp_enable(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* ungate the feeding SMI larb first, if any */
+	if (priv->larb) {
+		ret = mtk_smi_larb_enable(priv->larb);
+		if (ret)
+			return ret;
+	}
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		if (priv->larb)
+			mtk_smi_larb_disable(priv->larb);
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
+		mtk_smi_larb_disable(priv->larb);
+
+	return ret;
+}
+
+int mtk_disp_comp_get_larb(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	ofnode iommu, node;
+	u32 larb_id, id;
+	int i, ret;
+
+	ret = dev_read_phandle_with_args(dev, "iommus", "#iommu-cells", 0, 0,
+					 &args);
+	if (ret) {
+		dev_err(dev, "cannot parse iommus: %d\n", ret);
+		return ret;
+	}
+	iommu = args.node;
+	larb_id = MTK_M4U_TO_LARB(args.args[0]);
+
+	for (i = 0; ; i++) {
+		node = ofnode_parse_phandle(iommu, "mediatek,larbs", i);
+		if (!ofnode_valid(node)) {
+			dev_err(dev, "no larb %u in iommu\n", larb_id);
+			return -ENODEV;
+		}
+		if (!ofnode_read_u32(node, "mediatek,larb-id", &id) &&
+		    id == larb_id)
+			break;
+	}
+
+	return uclass_get_device_by_ofnode(UCLASS_MEMORY, node, &priv->larb);
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
index 00000000000..8214af38b27
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -0,0 +1,95 @@
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
+/**
+ * struct mtk_disp_comp_priv - common state of a display pipeline component
+ * @base: register window of the component
+ * @clk_bulk: clocks of the component
+ * @larb: optional SMI larb device (UCLASS_MEMORY), enabled and disabled
+ *	  together with the component. Only the RDMAs, which are the DMA
+ *	  masters of this pipeline, have one.
+ */
+struct mtk_disp_comp_priv {
+	void __iomem *base;
+	struct clk_bulk clk_bulk;
+	struct udevice *larb;
+};
+
+/**
+ * mtk_disp_comp_probe() - probe a display pipeline component
+ * @dev: component device, whose private data starts with a
+ *	 struct mtk_disp_comp_priv
+ *
+ * Map the first register window of the component and get its clocks.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_probe(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_get_larb() - resolve the SMI larb behind a DMA master
+ * @dev: component device
+ *
+ * A DMA master component reaches DRAM through an SMI larb, which must be
+ * ungated for its accesses. The component points at its IOMMU (M4U) port
+ * through "iommus", and MTK_M4U_TO_LARB() extracts the larb id from that
+ * port. Resolve the matching larb in the IOMMU's "mediatek,larbs" list by
+ * its "mediatek,larb-id", so that mtk_disp_comp_enable() and
+ * mtk_disp_comp_disable() then enable and disable it together with the
+ * component.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_get_larb(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_enable() - enable a display pipeline component
+ * @dev: component device
+ *
+ * Ungate the SMI larb of the component, if any, then enable its clocks.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_enable(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_disable() - disable a display pipeline component
+ * @dev: component device
+ *
+ * Undo mtk_disp_comp_enable(): disable the clocks of the component, then
+ * gate its SMI larb, if any.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_disable(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_write() - write a component register
+ * @dev: component device
+ * @offset: register offset in the component register window
+ * @val: value to write
+ */
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val);
+
+/**
+ * mtk_disp_comp_update() - update some bits of a component register
+ * @dev: component device
+ * @offset: register offset in the component register window
+ * @val: new value of the bits in @mask
+ * @mask: bits to update
+ */
+void mtk_disp_comp_update(struct udevice *dev, u32 offset, u32 val, u32 mask);
+
+#endif /* _MTK_DISP_COMP_H */

-- 
2.55.0

