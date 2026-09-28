Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F349CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE662406F4;
	Mon, 28 Sep 2026 15:06:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qYVhRkjGAEKl; Mon, 28 Sep 2026 15:06:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F27C7406F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608010;
	b=jMc0hIzUhvZhvTvksddn7lynYFQt6FJpLTFzrQ+uBaXAWe+z9dXtT3Uiq6YCyuXW3Md7
	 kM0mX8PyFPRWoDdQpozIJQrJGCHWW1AcwsE5dIWamhFKJLnZNr/GCLcjpdmmU7wjXiwp0
	 eKICJ/hAyReqw2/gMm91ZrNJ5I3TytGOWaO/TVVNmjTjjH2vD8v6cREzDfyZ3Zng3SzsK
	 AtNoJZqrQ1IVyEcAk/MibzfvH6JIpsKLJjyklS7WJciV7xiP1EOMsqzQSw5w08GQM/jy6
	 wslql0u+Z1k4jUWGyQs0Qj2nnQhO8eum47Qlv5Q12QY756ZfIqwgNkcZr0JHsl9Colg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608010;
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
	b=PPxB5X7dvh9c/Zdl4GCO24LEZ7U8iXmuja21h/ikunGFben6/cYpgxLn/16yEutIRPWk
	 v3xNrI5ufsjw7m46CaLbZ5jiy305XMlyF62EDAq/og3QKfZqow/m3eEvJsImDL/DwVnoA
	 YYMOnKUAnGLEAeieP9leTb7dR9v1P8p4F7TeSrKWDMqBcB/L/MrABkDPnBU6cM6qOH2xf
	 UzOmhYXe253f6dfWQU3rRqy3NiadAOQriX7hgqeLZmSq6g+2b7qtenab8QVlrA2RJ54hE
	 eGMJDz4E3ltozRprSNDkE8pKu0QPP2OOcN8F4Ueza6KgFBWATMRF/6+Ai7Zsv5+ZC6g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608010;
	bh=AzGf/0o66eLXQCt+rb6oD2vCWIiHZgtRuI9qVbdCabE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=afNGTS17rbRluLz8UZKlc/HduhKFYgOsoGYDDLy9ZwTRFTxYL7r+Wz8l8GqySwO53
	 hodBQi2xneCOvikkR51UrhbsR32cE7y7sRk4icAYtuMRmJ1Px3EpfXr1SHyg+nQMIp
	 xKOTehzG09EB2CUVnkH1eahbiGQ/1S5Nb6uoDEUHYcaghkPSpD/xgipvdlz9wzsysN
	 FGvTXIShzE/01aQEkoMhKZVx7D0K1Njjf202UqWzcRT4WW+JUgpamGZEtbV5HOvTZe
	 fmt1IILdFNNRowabdjAO5OYMIrSPg8NtS2TgvabZOGiIab9n+eV9QhggdJBGaFtfbq
	 7ulb2K4ZM2AZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F27C7406F1;
	Mon, 28 Sep 2026 15:06:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 227EFD1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1413340055
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3j8r--UWA-dz for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:06:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0B6C840048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608006;
 b=PtBQ7ODUbE6OfItNJ6SK9UyQnrFF1Gr4mGJ00HJ+Z1D0cKNbXskQt62QFp4Y7PhxrTQe
 g5UAbEk4GCUddsnyAXK/4CAF/LbnSDKSW74YjNzrtjpMQtS/OoGcG3tkj+YSfkooTC8q7
 EwY/m/VNR06H0kehpOWPU7Hg7VEgc3jps1H7AUrNuvYJ1rEgpnXqNICFfgxgpkz9UaNnc
 H33cJsBk5wthoDxjmG+VhIlITbNEsgpfm9lGX0sHINvpslYCQ2tInbdUwFmugzHNg7vi+
 W+mlbHdvwvAJoMIgJiTXXVX6t7+EjqHesO5hc7oTJqZv4WF772Tso3h59ddpYPcjBYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608006;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=AzGf/0o66eLXQCt+rb6oD2vCWIiHZgtRuI9qVbdCabE=;
 b=kWeM0uPnvNtmQLld48B/VlQDKYDsWdCJVpz7auei769heJ33xl+wg1VQgocwifZih1rP
 fAhLMAqJjHay4dmrcpBeqq//aNLkjKYUifAr7HzwoHKauRFZCI7I04XdoqD2zYR56ZLku
 MpUh4jcf/yd5MPScHeZn5gxYQSzfJ705QwpqE+kL3vEoNkf0CzjHXUNqy4rQkzsKN7eXA
 N8jNMsNKvbHGcQ3E0GODhvilDLhCgOpt8DdpE26uC3XifPYfONsAgR18QvcG9uRkb/NBB
 CT4o5t5qQGfoqQcjfpjwL4um0N7H9/hG62rxSOuMs0w/1Si1q/1Yu6hzKF4yxMCXICQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eCJjKkCx; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eCJjKkCx
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B6C840048
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:45 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so10712055e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608004; x=1791212804;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AzGf/0o66eLXQCt+rb6oD2vCWIiHZgtRuI9qVbdCabE=;
 b=eCJjKkCxh+U7WUnUFDZycTs0pQbdNpr4AMN4bKvMHpbdnMVWkR8ScrJexeHK9uAemR
 k5koFexNpK5e0wot+au67r+yxfGPMleiior8k8kiAT/XZUOl0MDCVjv1i2bkBRqnmMO+
 PzyrXScS3HOc/JBJpUQkaP9BF+Z6WNoi6OCbOq33DRGOHtYcr5wer+baipC61Tm0C/eN
 +Xg8GQxLLs1dZ4tT69ViZBVUXVyKdJq814Y3KCzSvuihwSdRvp64+GSRgcQW3HpXc2ao
 gfYlhf1T86z1f0O2AJTnosd4ph5UUId6XPF6IgzDar+rlTadTPo71fzk5noelrXvBrR1
 rSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608004; x=1791212804;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AzGf/0o66eLXQCt+rb6oD2vCWIiHZgtRuI9qVbdCabE=;
 b=Dhd5gvzyRfJkjnjUB6DBcdvzGoOcOwUDIoKFcIRH9udsjTaoX4xvV4lp/vPC+EoVAo
 ZoLr6Ww9Oz5r1ed9Nq1STkQsAnM4ha+eOE8kWWTVsomFb33pOCqI6Pk/XisgGBdsgnOL
 N05qWKkz7CGwE9S+lEPlW9ae2anG47RcV22YzXB7/9xJls35vIBF3JoK0gX0Zvk/R9rN
 XQl2VYoIcsf33kd78EwYw7azaD7aqgMyNrlXSIVXUcpOSrU99EBD8VQCuCAnZP1uHyCf
 cy+q/A6qa/qjHR1UIlLKY0K4+mFhBUDlDfhyjCVy9HLhRsSyiBLkD2bA+k/kayZlf0g8
 nQJg==
X-Forwarded-Encrypted: i=1;
 AKwUvByBkudcSLJFuuqdhJjwYNZJmNwI0JOjdVMH/nPN8qjt1G/Q1iS7uUm+OLIgl3YPh4qTDfeOc0k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lwHhQVmVYtsPDXN5zGgzRktz1D9eQUyV8jc2bxCrRcNwj05jJx
 0ZPP0vTB9SicCGAxPfztcX1a7UNaUfGPWIt9t23CsloI2UCp6kLnn98I+TXgxOqUfjo=
X-Gm-Gg: AYBFou1MIlmVh5p34jWQEpeG1w697UmduoohB55uMlZwy2083Irwp+DDnq8+TZHMVzs
 uc/AsIrwBur5reFwTe9qb6j9oXGT5JY8wuwOA3+u6GOY1H35/32IZ9Q2c0phaUsd/nZfP9M/YiY
 XEYqvGCPQfqno1a9WRfD2es/nzGRFyn5IomLTYxuhBE621GnmTyLC+HFJ3dGVhGySUZjBOFZCdV
 ANlT9z5IlXhtoA1v+6oiae8fuIdjUITMt5tuDC5KKhGG8dYXVdrxdEEsRqrwn/qtLpLSvbss2+B
 jcK2b6pAEVNAa0tyhE8IletKU9bomSiS9JEfAS3oekbOd98UjQ/udLoBD4dfG+wQmxkx0IJnv4h
 R/J7KSvVHPoHg9g6FcUNeZpVLppaDZDoEiBnu03cjmD9BNcuEShdb0J4+QQQHXXih8xWrsu+Djw
 IqlsHbqyJ3N83fLhsn1uCX4gKAhT//FLUwv83wAljk2Jw0Dh2OSao2U/59Aj+qeW7Ab9JLFtO2p
 eDxG+SJq/7HPZ8oKBLoSJkE5oXIbLB5g8MYfxKaKDCRz0XXogPwo2Dhx/Qe+tLG7Gv0Az//Y9qy
 mbX3W9WLTNe444SJXn3Hhkae7SFQ+gBFcvZnufbz3iKyu8o+qObEgTQ=
X-Received: by 2002:a05:600c:1546:b0:49e:81a7:9fbc with SMTP id
 5b1f17b1804b1-49fe66fa0ddmr241823455e9.24.1790608003597; 
 Mon, 28 Sep 2026 08:06:43 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:06:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:41 +0200
Subject: [PATCH 04/13] video: mediatek: add color component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-4-212f51b1742b@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
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

