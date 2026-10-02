Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954B7CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C0BD8130F;
	Fri,  2 Oct 2026 14:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6iF9kCUdmEA; Fri,  2 Oct 2026 14:01:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DDB0081328
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949684;
	b=bFFwZ0ddXaKOK1TzlmqaVHEpWUnQDUIMVQ3G67cMKvsq5duzTvQ8tFHu/FI5AZH+aEGv
	 bA/jorIl5DXyney6iRmWN9amT9jriUw7LJ0w3Av/ugqZy1i6RkNH6Aq4DOhOcLuNI1J51
	 2N3IzPGVJ5EggwSmWY0GxMwwJZ2G1EusQ2v2UnU+iJ/vUvCEuUF3QovRhe8YH65+a61Mx
	 YNnJCbHSAzt8wJySwuEykKQFWkYtgXjQn3Yqn4jwfBNOrB6pGzyyROobd80OQDfDQWFlD
	 TlnZm6Ph/ICRmFUI5lBq2FxULHEngpfzJL55DNVUs+Osg5e5PusAzz2pBEXBTIKuW2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949684;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AzGf/0o66eLXQCt+rb6oD2vCWIiHZgtRuI9qVbdCabE=;
	b=mlD+LAQASY8Fjtde84/07TfP3uD4WxCHY98+KpwXXYOdRCIizh85DbC7E+TaueIVicmy
	 V/RL/MKWikIaKGG/y9OgvE8eUhv2GKp9Ik+zi7+n7XY9nEA8KP2bvVcP8fO/6HLiq8CNp
	 /4FPyAjlBG/wh4C4CpRFZipalPyg/I8rWWdMdnI1cF0W43AbWNY8vKqUV5mUjUlKRZycE
	 mSghOWHOY0LaQ8xq29TyplS8vzdr42TxSNOgA3YAuOfQvoc2fkaGRfTtZ1QkKjAo57Pfk
	 qyHUz3z57yClit/ILuR66iGt6XQCWv0pi5TGa+GgvoUkZLdSkU8cTRjwKrM8VWrDv/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949684;
	bh=AzGf/0o66eLXQCt+rb6oD2vCWIiHZgtRuI9qVbdCabE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=abf4zlcjQyISRUjQOPYvLiE5re5d705ft5wtkYPSbD6D/ElhOc7x844svIouqSgYr
	 84RBBbjJHS0bAubEwIXIwfnSI1JjzGcYBc17gw3OpEI8hz95Ahxl9WxRnyVuzFUdRa
	 4icr1ZDLB0NgfppLXj+ktiHwm7e2TKWq1VOrinoWiNFjj/L04pnH3UfDImCaSWBj3/
	 VCTkueeKZiKNMCzyfUF9udMovONfdwhZ2dY8LHId2tJ1KCBTfV0JLQTREDItN5BoVs
	 7pHhxlG5fI8Gd5yMt7cIXH0Sr81hJgEcdyQpAqJXYkRZNSBECZ4KBbX2FsDT6Ujkek
	 wi//VTjoiJcMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDB0081328;
	Fri,  2 Oct 2026 14:01:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 412BE2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26D5740D95
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 42FCKpACOQRK for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 18BB240D87
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949676;
 b=dyvtItGF1VK9iWduTZMcHrHr6W1kA6XQqQNSbmJfdFjEngltBgpXIhsZrcrwPZpZNDoo
 oR4F3MUaGbwlwAe7WpfQaKA1uOroQrSxl4M+YUyHmdcZoQjdAMOFngHKHMKwq0T/lpgEN
 SB2igVaquRP4GXXGqVqxtBBSaoEFB+aPmvsxlhJAUvTjADKn79eXRHQAVZb83l2qoZ/sF
 F+2t5DEGFHVjNGdtbd8E9WpZTU1CMm1y3avd5CUi98b9MCgOrHpSViUl/4gPVqXaE2EHG
 FiqI/JZpxWOAsgdjNox9Y/+qSfLNHwemfgUAjC6BxJWiroVngD0WAIiWgyJhYH3Ia7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949676;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=AzGf/0o66eLXQCt+rb6oD2vCWIiHZgtRuI9qVbdCabE=;
 b=CXgPoD+SWEDNUqTtEyThSb8iWriD37XlxeKD7Y/q2EdOPFgnKiSa6DS7LoawEbzWf9c9
 Enoon/8PVCx6hwFaMtljBokImsS54LViBt0v07bTUVCC/G6+X6xToaMFK3F15rNNRApQi
 rCEaye+KoChAXcaPPz7nz1mxy66LKUy443jtNyzfFfXbjVJJ2gNa4OCkYFG7kuwZoENxJ
 p2ngFohXYPb8dXLoJh4BAZ3gnKYSwFqc5nSurnr+9q5cjh9T4EKB23HiVx0D2gZWgp+XL
 B6v/hMEFje/U1HMyMVxYdF7/UG/eH2a59xjSH5tUnGSn7adF/3P9VQfC6VhkbCcDv0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NcNOeK5v; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NcNOeK5v
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18BB240D87
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:15 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b0503e39fso2044430f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949673; x=1791554473;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AzGf/0o66eLXQCt+rb6oD2vCWIiHZgtRuI9qVbdCabE=;
 b=NcNOeK5vEGRQVPHvQiFYZrtXdlL+6kBIhGIq1rclPOK0Xp7sFkNwQ3RkjB0/H8fOEJ
 Qo9TKnkczFSdufdSSeQhhaiti+cBeYv8bNc3IEonMuYriUvWAzuoa7iYaU3+VTR5ynAA
 0lUL3WNjqlwpib/V7b25MZOc0hdHfEu2aBj3poEQ9NAedZVO9e0ui1NiUo7BqEnpgD6t
 dqzxM/LXy+QgZx1VBmoL91mpvNaMonyyCAdbz55XMIeXugRth/Qz/ax4sVbnEAC62r49
 sc0NF0/LxAm60s2VWbecBChpEl6FTDuMKUTOJTCh9KC0LjJNuPaftml/mclVy3l7gSv2
 Xnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949673; x=1791554473;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AzGf/0o66eLXQCt+rb6oD2vCWIiHZgtRuI9qVbdCabE=;
 b=nTrgIB1Tms6ezcthY+/h8sYwLatSc1giDpsgwFS8n43RZkBqTM5zQ75mB7rAgXXZRu
 0muHiVoBHRn01AYynp819ugVOgHa2tSH6NEF0YSqHqv7h9Ha9p51S2PPFJdUCqtznkVm
 upzJZpgZav3iR2o+RrLRkAi+RLeoSKDOmevUqgiDmAQ9h580hmSwM982B//CwoSEDG8m
 YBkJBYSkUuhVhzneNgCr4e68Vj2vA9COAwMZ5q4PKaXsuEsYLiTPrqQX4urqSeUthKeb
 AmiN0Xex/hCE8wwHziWqW6O+cJmL0RWQmeJKtZiJsskbr8HFy4QMbTG2EqE6YzHff5wq
 +8yA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJZmXV+Um1mhJlx2+0Nuw5FG8thQHbshF4txVWAYhNLNa/QFyin8ohWLuHsRQTqQDWRusN/S0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIVKj/GEiSbYuzGim3VOqat8ZtmwRgWFpIWSsyza5hLKDv38mCs
 vgcV/xbLmfmpJwBUR9H0E+/c64WSnDD24LctGJhasMsYxl0Xk0NQ30DD7iXJjqsuoYI=
X-Gm-Gg: AYBFou0SuJ9mMBX6GhqDfznspxk439ngBQcUe6yJbGXT/6s8SIjFTjoWm70qfsPPazt
 JsYAqr8oXRR2DS5dFWUxBdD87feCayIZ7TxZASI6J3NgffFYT32D2k3TMvU2JZOaJEepmS2VO5Z
 d1+VhGBn5mPDGOCpvdzXJVqhMl2B76rda7txZih+Gamf7CkkmKuwHt/7LNNtiILm5oTCeokMixl
 iXCzIUcAItCanfqr/1KzpIJrIe/Fchv3hhXD/FKzSPgQIhJKJVpXQN4YxETxOawaOCYUpaXFFtp
 RsLqI0ooHH3y9J9dMlam+OkSj/Bc9lpsx6ax7GOGdZYb8heuMWl9z1oLZl1M8ihs5mJpVYfHUaq
 Pnd9hnJAErdMd1alei3aomPZNuyi7SK0DDfo6gzSicD+UCssgg3s8wI1qmuXFmSHI+Kf0+r0YQU
 EeF2e9UpZ3QEgZ1K6gP46C0OhMtt9YvjpS4oM+p4iaI1IKR+KD76roHDmo3usuDtJhO0h3tnzLH
 mcyDKg12WoZ2wqMB4v9McWsQOV5S94sumDaXl8ZQ9IpuXTnZdN78+3J5dIzKzqvEQKbT2HFLBZS
 7VeeR3bC7E8sVGi47ZHeIQ5pNjYBZ6FgXj1IH0B+k+cBMbFa2j0Zavc=
X-Received: by 2002:a05:6000:4553:b0:488:9695:d15e with SMTP id
 ffacd0b85a97d-48b1274c9femr3545643f8f.37.1790949673227; 
 Fri, 02 Oct 2026 07:01:13 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:12 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:03:55 +0200
Subject: [PATCH v2 04/13] video: mediatek: add color component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-4-9e435457b90c@baylibre.com>
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

The color block is one of the components of the video pipeline on some
MediaTek SoCs, such as the MT8365. It provides the picture quality
adjustments of the pipeline, such as contrast, hue and saturation.

None of them is needed to display a splash screen, so the driver
programs the frame size and starts the block with all the adjustments
bypassed.

The driver matches "mediatek,mt8173-disp-color", the generic fallback
the MT8365 color0 node carries behind "mediatek,mt8365-disp-color", so
a single entry covers every SoC reusing that block.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_color.c | 50 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_color.h | 31 ++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_color.c b/drivers/video/mediatek/mtk_disp_color.c
new file mode 100644
index 00000000000..759e7c800b4
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_color.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Color support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm/device.h>
+#include <fdtdec.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_color.h"
+#include "mtk_disp_comp.h"
+
+#define DISP_COLOR_CFG_MAIN	0x400
+#define COLOR_BYPASS_ALL		BIT(7)
+#define COLOR_SEQ_SEL			BIT(13)
+
+#define DISP_COLOR_START	0xc00
+
+#define DISP_COLOR_WIDTH	0xc50
+#define DISP_COLOR_HEIGHT	0xc54
+
+void mtk_color_config(struct udevice *dev, const struct display_timing *timing)
+{
+	mtk_disp_comp_write(dev, DISP_COLOR_WIDTH, timing->hactive.typ);
+	mtk_disp_comp_write(dev, DISP_COLOR_HEIGHT, timing->vactive.typ);
+}
+
+void mtk_color_start(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_COLOR_CFG_MAIN,
+			    COLOR_BYPASS_ALL | COLOR_SEQ_SEL);
+	mtk_disp_comp_write(dev, DISP_COLOR_START, 1);
+}
+
+static const struct udevice_id mtk_disp_color_ids[] = {
+	{ .compatible = "mediatek,mt8173-disp-color" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_color) = {
+	.name	   = "mtk_disp_color",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_color_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_color.h b/drivers/video/mediatek/mtk_disp_color.h
new file mode 100644
index 00000000000..9858ee95d5b
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_color.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_COLOR_H
+#define _MTK_DISP_COLOR_H
+
+struct display_timing;
+struct udevice;
+
+/**
+ * mtk_color_config() - configure the color block
+ * @dev: color device
+ * @timing: display timing, giving the frame size
+ *
+ * Set the frame size of the color block.
+ */
+void mtk_color_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_color_start() - start the color block
+ * @dev: color device
+ *
+ * Start the color block with every color adjustment bypassed.
+ */
+void mtk_color_start(struct udevice *dev);
+
+#endif /* _MTK_DISP_COLOR_H */

-- 
2.55.0

