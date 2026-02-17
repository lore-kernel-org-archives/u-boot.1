Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403C1E9A03E
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 23:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D054C83E36;
	Wed, 18 Feb 2026 00:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZUAAqKG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 739D383D17; Wed, 18 Feb 2026 00:31:18 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46ABB83C72
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 00:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c543472fso237883a34.1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 15:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771371075; x=1771975875;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MUSW1DaiGytnTZp2hgkaUf3zlAex+jo8UYLGSV/7MHA=;
 b=ZUAAqKG0zmT0oaRnNPtdwUD1/KUMOU5BwEF57KeWHBsIRF8T3uvS0Tl8SAz4PMi6Zh
 XWO6mxIWAMyvJi8TIo9s1HaWY50BO6IDSY+ePUZ9RXFvlsR/Uh/fACeXdfAV56deszQh
 /vUjSHh/V+Sq+Ia9j/XR37bRo/QSR2UBgbzw8ds/73u77w+yAhkUHX+F96l+b1OPcmo6
 fWJ4l3r3s7vW8KR/ZWyygUD0nUM3UIwjjAeyCIAHKyrtjrI3y7b5nEGmzR49xWINSzX+
 9qsESmIjT24H1UMlWk+g//9bm3vlxe3ZFx0m01MPS9Az3xogFbE773uj2sjZ3MvBdDkn
 8pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771371075; x=1771975875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MUSW1DaiGytnTZp2hgkaUf3zlAex+jo8UYLGSV/7MHA=;
 b=NLMFtLENiBP41cTuEAoxhBXCnuA/C8eFe0KmrTbWGSMeEugRa5w/G6WT5dnIrdsCmy
 B94UKwqn9eqQowQNgpUWYyO4XFFTQibRTYYwd6Inf1jvG3qcPwuPmjUwxZIybnFq/dPn
 hP3kM7dbmN5UGbhniZyxnIiP7sLQuBF+gdLOwd3QKwhDDA+1JQqzI5nLfnK2rCw2DiCA
 70DgmzTlDSxaZie0CKoLNKRZGzfFhH+ITssTgF1xRuN710uEVhcT4eyGU0NEERgYr5aK
 pafmXrFFfXlYqS7GeodnCzTtTkG14hnaRtWOZLyjButoNeNSFZiubpynUGCgUBa/+hVN
 21kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqzdRDgrJBMT2H9C0qSqsrg/RXw7JsA2gUnZAVqZgjqlSJlDjPsyyl4X2ia5Yz+K0tM1XxqrY=@lists.denx.de
X-Gm-Message-State: AOJu0YwGPGCPIz2yzsEe6GLO8iQLuVYlOwuEshJRxC8W1uIYGisNNCOG
 nz5zGigsmq00pobuMV+Cju64e6eae8nZNnvH/p7Aznt/Z+6LRXRysoazSiWmtuFiSmrGpNeVh+s
 A38I3
X-Gm-Gg: AZuq6aJ1fx6z8suXKajkKqZ7JhHTuKxyNlAdDH5HZ7Z8iRlWE0A7uZPjXyjdMJ3QAvp
 DfApKX6+yVzJdFMIP7DkAjqaOzn1VZWj72riJHsPbaMvtRE4wsGcas3tFjTpquzhrAC1B34P5xL
 tP3+0uALi6qmGyaONomTM+rkS5JIPN4GR+402++sobZ6FPr6WZgh3K/VVb081ziZQIRzTsbXg/S
 +K3pxUTBSkhTAWcKUVa8w/SpfK/ejccEfwtSNFgoto5Fm8JdCXPlNOShw5oJ7ykYEogSP3tQ02t
 oRCQdjAhCh8Y0kbDHJ6cXX8YrNX0UehefzUANgPqvq4KD5u8FJ6MoM9+BdZlu0z9Q/eqM9kzxT7
 D7B3+fCFF1NV7ETSx4crSxUehUJaulVcc+oZRTo+pJS/nY9WbzWwZCK1dDNvJkp1sLD6/92dbub
 mmY/qzgsMDOEdLxQzcdOd6TpucKg==
X-Received: by 2002:a05:6830:40ca:b0:7d1:9574:db9a with SMTP id
 46e09a7af769-7d50629f69emr79336a34.12.1771371075040; 
 Tue, 17 Feb 2026 15:31:15 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8c6:5b3:8109:1f08])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c7288d34sm11122198a34.18.2026.02.17.15.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 15:31:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Feb 2026 17:30:11 -0600
Subject: [PATCH v2 4/7] clk: mediatek: add CLK_PARENT_EXT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-mtk-mt8189-clocks-v2-4-cd381cd05251@baylibre.com>
References: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
In-Reply-To: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3908; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=72FAPUqL2IKBdswijnUNc/k57fkdXxHVkljNwK2s+1o=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBplPojYFUP4h+/cIzbvKIl1XzQru16JYMAoGEkJ
 Wu3ivViZNuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZT6IxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6oAIAIF55F2pfFjTPEqxAuJ7dtySBnGdRHFxzS4oOh0
 yy582fI844gA2Q1gTxU1HoiecHWRxAkM7TNTAaOxNVFjAj6gukJq0P5zlgKO5cNwibo8hyO0xEj
 5BWd2eUrJisjfqcR76feaHHl2PSAu2Keto8vznQo8ABCzGe2LM6Rm0VzFvw0O+EY6VH6OlUY1DA
 PUqOy5E9HSxs6E52yg27CcPVoGItAJgU9vZVjd0CB7Aj7ZrCw+wmVGMGFBGHF608fauMjVOgLSb
 zlNOwr9ZL8OVhoL3pYzcZD/fs9umj1eayH/p9DqPcQUnjM/OG0cjJlaUweGbu6LOuHV7GPPyV06
 xglY=
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

Add support for external clock parent type in MediaTek clock driver to
allow multiple external clock sources.

This is intended to eventually replace CLK_PARENT_XTAL which only allows
a single external clock source. Replacing CLK_PARENT_XTAL is not trivial
since it would required touching all chip-specific drivers. So that is
saved for another day.

Before this change, the only way to add additional external clocks was
to use a clock ID mapping and add the external clock in the fixed clocks
portion of the CLK_PARENT_TOPCKGEN clocks. After this change, such hacks
are no longer necessary and external clocks can be added in a cleaner
way.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 17 +++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  8 ++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 3bd9021b9cf..6f7e2144332 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -168,6 +168,14 @@ static int mtk_gate_disable(void __iomem *base, const struct mtk_gate *gate)
 	return 0;
 }
 
+static ulong mtk_ext_clock_get_rate(const struct mtk_clk_tree *tree, int id)
+{
+	if (!tree->ext_clk_rates || id >= tree->num_ext_clks)
+		return -ENOENT;
+
+	return tree->ext_clk_rates[id];
+}
+
 /*
  * In case the rate change propagation to parent clocks is undesirable,
  * this function is recursively called to find the parent to calculate
@@ -235,6 +243,8 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 		break;
 	case CLK_PARENT_XTAL:
 		return priv->tree->xtal_rate;
+	case CLK_PARENT_EXT:
+		return mtk_ext_clock_get_rate(priv->tree, parent);
 	default:
 		parent_dev = NULL;
 		break;
@@ -337,6 +347,9 @@ static void mtk_clk_print_parent(const char *prefix, int parent, u32 flags)
 	case CLK_PARENT_XTAL:
 		parent_type_str = "xtal";
 		break;
+	case CLK_PARENT_EXT:
+		parent_type_str = "ext";
+		break;
 	case CLK_PARENT_MIXED:
 		parent_type_str = "mixed";
 		break;
@@ -1027,6 +1040,8 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 		 */
 		else if (gate->flags & CLK_PARENT_XTAL)
 			return priv->tree->xtal_rate;
+		else if (gate->flags & CLK_PARENT_EXT)
+			return mtk_ext_clock_get_rate(priv->tree, gate->parent);
 
 		rate = mtk_clk_find_parent_rate(clk, gate->parent, parent);
 	}
@@ -1143,6 +1158,8 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
 	 */
 	} else if (gate->flags & CLK_PARENT_XTAL) {
 		return priv->tree->xtal_rate;
+	} else if (gate->flags & CLK_PARENT_EXT) {
+		return mtk_ext_clock_get_rate(priv->tree, gate->parent);
 	}
 
 	return mtk_clk_find_parent_rate(clk, gate->parent, parent);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f3d2377aee4..c6874445dbe 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -34,12 +34,13 @@
 #define CLK_PARENT_TOPCKGEN		BIT(5)
 #define CLK_PARENT_INFRASYS		BIT(6)
 #define CLK_PARENT_XTAL			BIT(7)
+#define CLK_PARENT_EXT			BIT(8)
 /*
  * For CLK_PARENT_MIXED to correctly work, is required to
  * define in clk_tree flags the clk type using the alias.
  */
-#define CLK_PARENT_MIXED		BIT(8)
-#define CLK_PARENT_MASK			GENMASK(8, 4)
+#define CLK_PARENT_MIXED		BIT(9)
+#define CLK_PARENT_MASK			GENMASK(9, 4)
 
 #define ETHSYS_HIFSYS_RST_CTRL_OFS	0x34
 
@@ -255,6 +256,9 @@ struct mtk_gate {
 struct mtk_clk_tree {
 	unsigned long xtal_rate;
 	unsigned long xtal2_rate;
+	/* External fixed clocks - excluded from mapping. */
+	const ulong *ext_clk_rates;
+	const int num_ext_clks;
 	/*
 	 * Clock IDs may be remapped with an auxiliary table. Enable this by
 	 * defining .id_offs_map and .id_offs_map_size. This is needed e.g. when

-- 
2.43.0

