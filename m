Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8293AECD9AF
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E03783B8F;
	Thu,  5 Feb 2026 23:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IlAfGKjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D4C483B5E; Thu,  5 Feb 2026 22:13:43 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760738341A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 22:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d1890f5cafso16355a34.1
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 13:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770326019; x=1770930819;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MUSW1DaiGytnTZp2hgkaUf3zlAex+jo8UYLGSV/7MHA=;
 b=IlAfGKjWF6YaZAY8SOS6A1ESvz3+ZkqLgMi1a2JnL+ycpQMLzO6TFIabH05yWFVAaX
 JjuSzY3pkjY+OYF1bx0BC1+XJQ+FUdBeT3yLcOsEeXB/LeG4ONlJjysQ84XFrJ5femfr
 LSulpSUzsSzkMz4ctt8QWUfkCZT5xZJdtwLCvLOxSmROxdaSjzZuKL2POEUE1ELyopju
 RMq7ncKHbfSI3ifr+VkRBWpUZevAJuTwvQc6kfxJ0RqwOU9JH+CX4j9ZiGy6/3+6lGdL
 X+mzrYbS+cBoK+essgvgequ9YrcECHZzmxuNVWaGNzpzA/FgEzXsjjHFKb3Z4uURWtOt
 /e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326019; x=1770930819;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MUSW1DaiGytnTZp2hgkaUf3zlAex+jo8UYLGSV/7MHA=;
 b=H7eM5ziHMcGdpRfhOAXva0G2GKu9G5PYNy6QhpJ/mqsvFuqWWy5p3KIb4wg+ME+2uK
 kLogCNbTAXKDTtLSz92ygqlGiqOwub6MlRpKabOu8Kpx+JivlSc5usEXQ8rHC3R2Bhr5
 BzL+Y5oKpvF/YxZQ1bGLKdH2BEWZ7aQLxtJv6OM5Cuo2VuV9qCeoNDTRbdFTh9zuync0
 lMzVruA4UosF1Si/RZwBLwmtzhOpNH+NUu2FWuaU3jyI6W+dbKeQfBBYaBFXLlgc70G5
 ujThVieQ8ncb2g9j4W/3jG/GAeH68W4iI7iPp+JpQ6rig1JVpCKdLlTL3UySiDgJEznR
 fZcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViN5GGlx6MwkyJr+gxfprPcIZoiNFE1AtddiGKzuL357V6XvjGEMjy4/lVXt+u31BoCyDOcwA=@lists.denx.de
X-Gm-Message-State: AOJu0YwbPcFx50OLQokWrvcitL+ufG8eMOcZhjyov/P7D9wDoggsFLBK
 1gfE7US3HT4L3d9SKMAhULZrxjLSsyZxsFtXr9MP+b/85kZNLhSvkH50gFOsTqqPiTI=
X-Gm-Gg: AZuq6aIb0DjKIVUAe7FIfFo9adkIiORPsRi9LoWKJc7MPjSLJqfJM574BtdbZRuxbsR
 3OHcB3hR/kCazqOyC0hriAz4T+EYr42Mh6fKC/MOIqZcE+26XYpTH7s3ZIQeFiFw9UUhWv9wLO5
 UlSGoegWBw8TQ29eMRaxP9UaWgVqazB8rIeYxBCJdBk0XfngOumzhySnjG88bHHbOF7O06u9Zar
 TAPAQqgspK66lqxezQpmwhUtwCuFT+ul7hZr9QQSXJA/AndBVmUDR4ailkZicOvPxC31RtXUtjc
 KyX7+dIA59/OIEpbv+CPQ93Il+vM6RK90GKlxs1alvEJJzn+aFWfdODZjBu+2x5IvDzN9raCd9E
 zvRDNzLXm/VWZxcxMWUt0+Vzb1aARK0+37eN1uLgHYJFN9SOz4PutSneRjt/d00YMV4J9maSMnu
 ZcqOHE5aJR4xrHbsY=
X-Received: by 2002:a05:6830:3889:b0:7d1:582d:71db with SMTP id
 46e09a7af769-7d4646c772cmr232891a34.38.1770326019253; 
 Thu, 05 Feb 2026 13:13:39 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4647ab1cesm164313a34.31.2026.02.05.13.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:13:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 15:12:39 -0600
Subject: [PATCH 4/7] clk: mediatek: add CLK_PARENT_EXT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mt8189-clocks-v1-4-bbac40932c2a@baylibre.com>
References: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
In-Reply-To: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
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
 b=kA0DAAoBwswgAf8Bj8AByyZiAGmFB+TITDG7cfUgYbZTuUiu2JH+u+9HuFKRwQNza054AXJCq
 IkBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJphQfkFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8BaxQf/cZ+dST8wT/FQP+uQxmdwMrrp4Jj3W/gH9eQkV/cISp+D5OU
 7b/smpskHzG59msQSpxzhHefWTNxLZly0mDt9HsBWRj5BR2265xPJ3J9BenLpyq83egNYQO4kwo
 ohIAOsBoNiQ3d4mPfSt9r/qUfXH0BxE02Z1cXh56+bhmm7Ux4p2rb7O2UX1cuNYIAGh0FlY9s6C
 u2RDQ3U+4w4yD/f/AYV5aWNevGkaibJ3uYcpHlUr3AF633/2OvW7hMgjJAGzsn0mM5oKa2fp3/p
 9njcN9OREJMglqNVhXn6Pxy8C9QMUrFBy6jKLdONcuQ/ZHStJN4ZACAZaLew7QXe5hy98Q==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 05 Feb 2026 23:06:53 +0100
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

