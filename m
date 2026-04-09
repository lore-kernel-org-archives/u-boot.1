Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9B0F364B6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05762841B9;
	Thu,  9 Apr 2026 22:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="BBU1YChh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19541841C2; Thu,  9 Apr 2026 22:32:07 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B04841DD
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46fb6d65c89so496820b6e.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775766719; x=1776371519;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l/DVueA87jOth6N8bsKK4iZLfMvnvoXn2Ui+X5phjyg=;
 b=BBU1YChhM2ba7FarCOGMnnMEVluqwpw8MJq1gYRtnH7XH8uqs8hLUsCZdMjCo6Khop
 50MbHIwkM2DmXeuOhXy02JCt/jZlwh3qAp4D9fAO7UOs/PYnj70IsagaHHCitS3jNNh0
 u1cXruaj1iAvlFe1YJ9DMFwwCQHUhqEx12xInZW8VUX02e44j9kZoME1xb7bX+cE4q/k
 eANnXdan7C4whfDVoBt8NQ8yYtFZRT8Unji5KcR2abH3KN/R2GW0mDJLths1hZf7/3e5
 BU1ZUvnXhfpgZ4AcGbraZ/q+XJITc8mF4IvDUPvhR95lTqEEgJv2ToP+NyoZWnyevOlu
 Fs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766719; x=1776371519;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l/DVueA87jOth6N8bsKK4iZLfMvnvoXn2Ui+X5phjyg=;
 b=OSd5ZZ5m7Gq1VDmnXGuh9NtcagqNlhkAjJXhpHBsXX1wRIWsfMUZ7QVXL4U5bT3WXr
 T/n9N3RA/OBX9RF7K5k2wblhKgUVg5KnE3V2bQx+aw9WFxVa8sIHIWxmsOC9WeKo7CmK
 3IVY0Wgjqxx4Gbnh8PU7nMjU/S65ftGamqUxAXJhGRzw2ZdNF3LK+mszBjqpABuWJ7xJ
 prd2lRmQugzpeGVCUafB13kbjbvKUs9OfKO0CErUK1EO+WM3OfKfVw26qycc1ze7TavA
 BP0E5dqHEvVWGkUU2LK9ZbwaFIlPBI33UeBwxaKJFQf4mfJ8/QDJCfaymU/yb9VXX8Ur
 xSrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3IW01WU37bi5CkP8L+Zr23wiKG/gFSLHNFQDGUVl+peuHDFW6mRFjlv4BQGrDCNcBrNN0uTM=@lists.denx.de
X-Gm-Message-State: AOJu0YxOpHIMv2l7Eh0BASfxGHps/ppMYtsQ8EVMaVw+RTxXrMVDZSl9
 TCZYNfhcWe6xFdvK7OXUjggQq/jm5B3WZTndqBJbFWAt5GYWU3qxC6q7k0nKp7+mU/4=
X-Gm-Gg: AeBDieuDipgSUVyfo3GFVqIbRFIF0wgfZbWo+4xVeQTOMDu6tiKSfBsmkNmCMrobIZq
 qp8+ZQfBWZT07H3Rx+KFicQg1ixdLufbK8oj2Rpm9TNPkD6XowFguUnW/0O236hGgPUMEZvm0eZ
 ZOqsLhGu4RDzH8apPI/y/WANbUoKKlRHROkzZqg7n2k6/Y0f2CKlJ5ICxzkFyGuBnU1tHViendv
 kHitL8Wt2sldZr0KCYTU1o9sOqodD1R8TZ86E6BmeL67aWqq/1iqm+QZKuYkA+2OqSXv46ByxPm
 3aYvwdMrtsLa1AAZ8dsORNY4YrGpE6b9zbihmjbQ79cKSt89xnszPEQ8z5vg6CvUO61/0Drw7Py
 61x/x5uzOyCv4lyPhlyr0FUThof14x1uJ68FoAPkf/xl5nJLOVHpOpu9tYQ6SsFlFqxEUwZ6IdU
 Uq5Wt0c2bWDt1XXdh/cnVZFZFtTYZc
X-Received: by 2002:a05:6808:1a20:b0:46c:e542:cc35 with SMTP id
 5614622812f47-4789f00c7fbmr383585b6e.37.1775766719289; 
 Thu, 09 Apr 2026 13:31:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a101b75esm293075b6e.6.2026.04.09.13.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:31:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 09 Apr 2026 15:30:40 -0500
Subject: [PATCH v2 8/8] power: pmic: mtk-pwrap: add MT8195 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mtk-pmic-fixes-v2-8-73e83aa6345b@baylibre.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Z8zGNQACTwVYVmIWQVHSJxhOAblwtBuLECfVG50VeyQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp2Ayt21xWpK+JHado3hYeo1WNVytTd4vhsgKmC
 huS9sy7ctaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadgMrRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AMDEH/0ISztS+wQkmlz3SKbpnwc6XZVm0XrvIV8TbRnS
 NuAl1Ll8zwjTjR+a5rW+rnbao84lxr+T28UBLzi/tY2V/g0Al3iiEv5UfeW26D4vlNseL0N3CZG
 JdjWioGFxGuWuUQXkZgldvenQmwysNEV+QFTZCc10im5Yvh721Fg7ECzfN/iR+ho7zL/EV97g6x
 /tlhUFYVr/g2+KstacH24whZMFpK0mfi6fjpIgchQvxbDBxy2EYj4jdv/W9vKsPKp84O8aHiPJC
 2XWdsPDH3JIndL/+kmLoeOk1TLFB9c7HMnn+Dnl8vYb7U7DHOrWWeQwk6mZyQdWBzDKuORbTjXw
 Upyk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Julien Stephan <jstephan@baylibre.com>

Add mt8195 support.

Support comes directly from commit e88edc977b00 ("soc: mediatek: pwrap:
add pwrap driver for MT8195 SoC") from the Linux Kernel.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index b05c6b88157..88aa3dace29 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -279,6 +279,23 @@ static int mt8189_regs[] = {
 	[PWRAP_WACS2_RDATA] =		0x8A8,
 };
 
+static int mt8195_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_STAUPD_CTRL] =		0x4C,
+	[PWRAP_TIMER_EN] =		0x3E4,
+	[PWRAP_INT_EN] =		0x420,
+	[PWRAP_INT_FLG] =		0x428,
+	[PWRAP_INT_CLR] =		0x42C,
+	[PWRAP_INT1_EN] =		0x450,
+	[PWRAP_INT1_FLG] =		0x458,
+	[PWRAP_INT1_CLR] =		0x45C,
+	[PWRAP_WACS2_CMD] =		0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
+	[PWRAP_WACS2_VLDCLR] =		0x8A4,
+	[PWRAP_WACS2_RDATA] =		0x8A8,
+};
+
 static int mt8365_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -849,6 +866,14 @@ static struct pmic_wrapper_type pwrap_mt8189 = {
 	.caps = PWRAP_CAP_ARB,
 };
 
+static const struct pmic_wrapper_type pwrap_mt8195 = {
+	.regs = mt8195_regs,
+	.arb_en_all = 0x777f, /* NEED CONFIRM */
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB,
+};
+
 static const struct pmic_wrapper_type pwrap_mt8365 = {
 	.regs = mt8365_regs,
 	.arb_en_all = 0x3ffff,
@@ -860,6 +885,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 static const struct udevice_id mtk_pwrap_ids[] = {
 	{ .compatible = "mediatek,mt8188-pwrap", .data = (ulong)&pwrap_mt8188 },
 	{ .compatible = "mediatek,mt8189-pwrap", .data = (ulong)&pwrap_mt8189 },
+	{ .compatible = "mediatek,mt8195-pwrap", .data = (ulong)&pwrap_mt8195 },
 	{ .compatible = "mediatek,mt8365-pwrap", .data = (ulong)&pwrap_mt8365 },
 	{ }
 };

-- 
2.43.0

