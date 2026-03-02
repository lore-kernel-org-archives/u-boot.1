Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9382CEB362A
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4057D83F80;
	Mon,  2 Mar 2026 19:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="02xix/zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3A383F2A; Mon,  2 Mar 2026 19:04:49 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF0183F61
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-463a0e14b4dso1737720b6e.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772474684; x=1773079484;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MUSW1DaiGytnTZp2hgkaUf3zlAex+jo8UYLGSV/7MHA=;
 b=02xix/zrVuZY/vWO1SIHfnpUJVz5HWNlf1TLYU154LFr8jN0/XnvY5dXka2qfTwVvQ
 ckx38eo88cNfdMcs6lZKTBZuNiyEahO4824sHGGf/EqVa1CfynTnfwc8wmRMmPuYJ9nU
 0VaFetxlxAYBEgP9w8bD6HvPB9QcS9gnlxDHy6iC344hsO1o0lnZtIoOsjkFpRJI/cvQ
 WXrzR+wOxLpbemYYCM/r1U8mSUlnQwv7oudkK8ohaVl/lVyLtLPZLFyXo822eIBkVXsf
 sXAVD7suOlCigLTIjeiD8l/lEtdpfDqrROcfcxXBhOzxCbQbPvq/GtJvnViZE8mZHx72
 diVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474684; x=1773079484;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MUSW1DaiGytnTZp2hgkaUf3zlAex+jo8UYLGSV/7MHA=;
 b=tNDfGSnU2ZFgwOivsOr44dimKzKglGR7n6lMWBgYdVMPxPDAkh8nfqL5WDcpzYJRtc
 L4QszhGGpgTF9x2KpYQaULu1sCAdzwFMSV0qLNHBk0KxxxFFLE+tye5ZuSdYxYLPOhlV
 mk+gZYCmUZaXSVzodwErmpcCwmZnxeyJC4Ja6EO4ZO8/NQw8iU8N+p9APqZ/LzMkjIi+
 nRHm1Ydv22a4RKCSw9sXEwyrg1PhG+/i+TChgC7EpYVnvPzKmQdGMEg9zq7u5ECBUOAZ
 OtxzHO4kd9J0qfQ23BDymWc0iTYs7QupOnOlVkGglW0ehVbmL2HpNsdmI4i2Rve3nuLQ
 bqmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+rppiyvtHRv8pYPwCRkgfliWvoXwonxmlaeyZxc6ctofHoaD9n43DTKGeABTmSb0RIldAHJo=@lists.denx.de
X-Gm-Message-State: AOJu0YxwpZC4DmdXb87vQHMlap7nV0+4JcQM5kfNcmp4X7ee/WdbcFYQ
 oUp488E6H6kQy9bYVbTpS3JIn6OPW4SJm5lNvTSAHHmbt9+oBZ01f2HmDhcfRirAsZs=
X-Gm-Gg: ATEYQzyEGwj/J6PbeuJr69ihUSpXl1PKPEQAueVJDg4GOiQoB/E5R4X3RfmhttvOrtl
 +VOehhm0lq813Zq6zfQxGd1PD2yiWywLFlCD+jkEetZH8iEu2QvdXZhQsBUcxmSx5HLZeIACgPQ
 RQc198bSK2fzwrYTZyboSkS3k0pFzQa9x5l/CkoUTiw2Lw/vHWxF/Vbskf0txrpUdes74PhZBDi
 sHuHTrwQQ9ux9fxkWlPoI9VmZOL+kdDWJ81PxSuTC8A6GHAeeCismjoh/JWPuVnEyQTeHVntZlA
 oYhmhHDlD0JL9uRbsRxg2cFa0IIQc5P1jyWuQRmzUF6w/H2dTvEfT7Q35fzS0vdfO3Jb8n0wOfV
 kgKQWk3uQfKt1w+hqgtPBXD0JBFvlyyjwG/FBgnVUH+JfrhGryAq95qkZex8eIIVHDZKT3A1VsY
 K469coLHQ2PgGOm1ztDdUy0fXaTmCX
X-Received: by 2002:a05:6808:1491:b0:45e:e07c:3fd8 with SMTP id
 5614622812f47-464bec61c64mr6295678b6e.43.1772474682930; 
 Mon, 02 Mar 2026 10:04:42 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab302sm7986125b6e.7.2026.03.02.10.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:04:42 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 12:02:11 -0600
Subject: [PATCH v3 4/7] clk: mediatek: add CLK_PARENT_EXT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-mtk-mt8189-clocks-v3-4-c48ec60344fd@baylibre.com>
References: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
In-Reply-To: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppdEaCYuulDHb6rCzrpq0BI/TbRimE1Y4G719u
 iYMZbOpWAGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaXRGhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AT9AH/0+qLivRrCM8Xpdn8b7NhwAgCvDx28fj5xdK2JO
 Cc3qoDhl59AbdiSLBVXLZY8I3LnHsHqUgURLFsj1jlIFzjNSHNMBFUll9IfyYsgasPZbRIa3q7H
 8Bwp1TrS2tgZWjl+2Lu+7KV3WGgv1woALqYxeCklWPcDDD00QFqBYG2FiujHFiEsSxXXjT/ONgI
 gNC+xcQRDFGv34aG15nlyqadEtzAIU03+jlrLJOllxUR+PfrEBWmGOipYopyPC6k+TeSBJ0io6F
 GjFmA8DSbDhBpySpVd4ITAF1Mi0iEE4tFGFcxjFiWMVli2K8PI0hkw/SNX5Q6dgtPRscyCLcXL9
 +Dcc=
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

