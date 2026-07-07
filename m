Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68908C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A61BA84979;
	Tue,  7 Jul 2026 17:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="bbSS7OvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96EA0849F0; Tue,  7 Jul 2026 17:10:30 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C85F84942
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so2701071fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437027; x=1784041827; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1d92hy7VWdbSxUzLFdX2g1cg0xBIXGAp0iFfx38MSWc=;
 b=bbSS7OvVcy848oLRuq1XgryDZwD1UjaLL1nEmJhSX6Glr74PmDOUKMhO5Tco0nJ22+
 XOvB1vBkkjWDFlwBJZwjh0qSybKg0ackoszBKvMX+QUIW643vdNczCA7ZO/bf67MmIvK
 LVOr4oMSwmioyyeLIAm0OYgPulQ0kkTmMp47UlOO7pR8b7z0ql4POEeUaakuzttHy4LV
 uI0tThrNse0AMsq+ggc4aG4wJ4jibFH5qP+gLWIBNIgqB9RN+OjttaTCPC3XyEQmpw7M
 hQ+4W3HVeH41vToRvMEuxUlQDo9/wfApDKmv79cYThCNxa6gR4KC36v5M+he0scr5XbQ
 UUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437027; x=1784041827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1d92hy7VWdbSxUzLFdX2g1cg0xBIXGAp0iFfx38MSWc=;
 b=O6YA5uP3cGye/cmg0e9vxJF9ul2dlInmmSM1d9UMTVd9n2Cj8uc7BUoAX9n3xj+h9T
 PnJpE7vOXfNzYpZmGsLKSdsMByEMPZdAgG2uK6EL7vMCEjlGMWg5gmIW1eFNRQCZWtND
 0K762qk5pza5oAEgx+2cSjd8ksrXVd2ZtZKaokOaz9KLCxr2D6CIZ34acO/lP7ysQXpc
 lTR0ooGBCNTGpNStCDCNJZeR4SYB4yLZ0FtpBo/j40UotiwSneP/EF3DCqOrerChRjc6
 N3UzxG5HKZpCXxSK7QHv8ovKnNuQ/1GkwuSRfgxagFdV5bszZC05Wsljw/MlTto8d0/T
 1g6g==
X-Gm-Message-State: AOJu0Yy7s2xB+VxxzKidgxwRZ3Z6JTgAU0FWxvdzXmUcClfywvQI54A6
 7DevCHrCkUJPYIuLUPOi3Z8AivBmz2qFWuAfZbS2xVNdLtVzlY9c8U1pIGJMcHJqxSg=
X-Gm-Gg: AfdE7cmRAPBxmTYJTlRLtNatSsdVla4QIKYfYHKWfmsB9GUtei538SNFpfLr75Wyiwj
 tL78j0rWQ2mtUgeigVDvZ8C5jhlPfIoQrQDuzNZsX9MRlhCkv38O8wWOmOKo8eCH9wDdXHjqH6P
 KZVxCDCTg55xYKA30fBcn1btdOhR4pwbn26K/wHPUcFuy2urKy8jXY0zS7heZY4MbX2N06zCEZC
 qGDiBHnR6vnb8pnkex0ke6hVBi5BaYeSkYZf+lMS1ep9HzxkgcEzaitPe24GFD0xZdwP7/yiLkb
 CcO2D9+4g6sSWvl+KYo62k2KooWEIRfu8ImR1vY7S/jD0aPrLVsnh5eAz5lgRmD0el+FGN/t1VZ
 m3PMxt4kHq+wNmOAxT8S/wD8I472f8iE7YHusQ13amj+IPnVv/FmJOJ2QjsupPDASJ2B+SXrn59
 G6WHWZr34nx4X2zjvL0g==
X-Received: by 2002:a05:6870:24d:b0:448:89e3:4c58 with SMTP id
 586e51a60fabf-4510609c00amr3583167fac.18.1783437026749; 
 Tue, 07 Jul 2026 08:10:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:22 -0500
Subject: [PATCH 02/24] clk: mediatek: add registration function for clock
 tree types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-2-65d24cc0d569@baylibre.com>
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2469; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EUkDISqXByLPctu8jeR5gVQ9a3IhCgwu2BgebhmivCE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRY9ZGDqUUrIRfoUERsHEtMDlgrM0D4bdtCkY
 h5FWRrGgpOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WPRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATZsIAJ+J7G72zxKqKaITu3iqvDP0pnCaFE1OldSBW3m
 HcmHnnh+NXW+QgjEj/rx8FnqI/0cezTjGbGS2QcgcjCIp4n8LxbGd/wAYuOtN5UjNvUhNmbrmoX
 AZGHGo/aRcgHtuN4P1Ia+P031hWIUH6GrIXEf0dUUyJE+UBfSjZ1xEKvLJaAnSaTUXfMkp//Wro
 TR04aIJ2hDo6+Cobgd/zCkUs5/RpSC6961XPNeaewgtryrJCZO7okdxsHyujlov5Jks4jblIYdr
 +9fG3VrYnaSzVNyk9Yx8Mnc6faxToA0p361oDOEVUnPRM5AiFXK49rfGTlJO5+7qMj5SUHZRuQQ
 jrwQ=
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

Add a new enum, field and function for registering clock tree types.
These types will be later used when looking up parent clocks. This
will replace fragile code that depends on lookup up devices by driver
names or ops.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 23 ++++++++++++++++++++++-
 drivers/clk/mediatek/clk-mtk.h | 11 +++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9d0a6cd79cf..362e4c1c6a9 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -34,6 +34,27 @@
 #define SCP_AXICK_DCM_DIS_EN		BIT(0)
 #define SCP_AXICK_26M_SEL_EN		BIT(4)
 
+static struct udevice *mtk_clk_providers[MTK_CLK_TREE_NUM_TYPES];
+
+static bool mtk_clk_tree_type_is_provider(enum mtk_clk_tree_type type)
+{
+	return type != MTK_CLK_TREE_NONE && type < MTK_CLK_TREE_NUM_TYPES;
+}
+
+static int mtk_clk_tree_register_provider(struct udevice *dev,
+					  const struct mtk_clk_tree *tree)
+{
+	if (!mtk_clk_tree_type_is_provider(tree->type))
+		return 0;
+
+	if (mtk_clk_providers[tree->type])
+		return -EEXIST;
+
+	mtk_clk_providers[tree->type] = dev;
+
+	return 0;
+}
+
 /* shared functions */
 
 static const int mtk_common_clk_of_xlate(struct clk *clk,
@@ -1204,7 +1225,7 @@ static int mtk_common_clk_init_drv(struct udevice *dev,
 	priv->parent = parent;
 	priv->tree = tree;
 
-	return 0;
+	return mtk_clk_tree_register_provider(dev, tree);
 }
 
 int mtk_common_clk_init(struct udevice *dev,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index b39a62edc43..10df7571c9f 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -32,6 +32,15 @@
 
 #define ETHSYS_HIFSYS_RST_CTRL_OFS	0x34
 
+/* These get matched to CLK_PARENT_* when looking up parent clocks. */
+enum mtk_clk_tree_type {
+	MTK_CLK_TREE_NONE,
+	MTK_CLK_TREE_APMIXED,
+	MTK_CLK_TREE_TOPCKGEN,
+	MTK_CLK_TREE_INFRASYS,
+	MTK_CLK_TREE_NUM_TYPES
+};
+
 /* struct mtk_pll_data - hardware-specific PLLs data */
 struct mtk_pll_data {
 	/* unmapped ID of clock */
@@ -261,6 +270,8 @@ struct mtk_clk_tree {
 	const int num_muxes;
 	const int num_gates;
 	u32 flags;
+	/* Set if this tree provides a specific type for parent lookup */
+	enum mtk_clk_tree_type type;
 };
 
 struct mtk_clk_priv {

-- 
2.43.0

