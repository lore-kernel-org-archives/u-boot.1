Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E13EDEBE5
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 19:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF1783F98;
	Tue,  3 Mar 2026 20:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZQY7KjvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C060D83F61; Tue,  3 Mar 2026 20:55:55 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7437D83E7F
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 20:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-46413b2c3d8so2527764b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 11:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772567752; x=1773172552;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hCuomlRej1lzmJmzqjVqyet1j/0GnEwWXt9Vvq2LzdI=;
 b=ZQY7KjvRxEJYSb34ioBX/dTxDnQkwsUjZMDTET9iRv+H6bGnnUW0f1aIxVDwOu0BYO
 yJtMKi8j6dXS4ISZhfqeiejDR1MbekjRg/fa++7yMoM2vft0UpBRa1HCn/8IR1aPAByt
 9xKp4QdmMadvfUvGmqsiaOQN9kP7rLy2aWStzbbjP1I2wqjzU6x9oksDUDvWS9Nvjpp+
 0g53peVKs7+DaxEidKXykTWK1zowbkOG6QNoaKlG/rF5XJ0LxLSxt9gYsQaavaIpzakr
 yHltRmWHoxVTzXwkN3xUSo23Zgcm4D6CVrSXVBVmdXEd1BbLg+Pck6KAZmWP4+II+T0c
 z26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567752; x=1773172552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hCuomlRej1lzmJmzqjVqyet1j/0GnEwWXt9Vvq2LzdI=;
 b=pb05KvAfK3c+GrDYbfISZJSDj02UvvG83dGukK/M66a03tpln2BAYJobA3Ko4O5gf4
 XvdAvOIhqEBcpWccHMLfsb2g/vDERDxlkSzJpHyUCBo09bASt/hLlW3xlGCnDuUrfSMU
 c8eqmvDAYXSDEOW6Y/Hwi99Oy1ObOzvTChYMc/m0fMzoWEuvCV35/hEvJx6E735fVklM
 SfcFAvS9nnCtBUU9cgED0Ox2zkTGE3s3emrWTKn9afe7OK1mIoLEz8H9oHkhccP5KHME
 kzFgOr5z34Vrilvn/SMgNYqgDMurYp5Pmwma6xFvVq8amqSe3s7s2UI98KkXIWv4Xi0T
 xxjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1n+9sj1e31w1iXLJpW8ZmeOisjhPHkRz1Fb34GZL/qZ0RoQ5ml1JbrFma4OGwZ1BEofwQlPs=@lists.denx.de
X-Gm-Message-State: AOJu0YxcHXKErpjqUq5te2Cd9g1TPhcWBNVMuPvedso277z75mVyabhA
 MS2NYSH+wGKj25Vku9pyX9Wn5fBW9BrQXuEhiITFBAB2HQik1cBfhGzfP0BabqetyH8=
X-Gm-Gg: ATEYQzwLOpbEMPyCjVZamrucUONrz6onu0mo5gEic9s6mvdJDrKpNguLUr2v7paZHwj
 suJjob4Yos/9bgF2/bv2+Fii7CqYSaz6sKCEWJgO6I/DAKCKkpVzK5mSUq6f8lBtkOJPr6+cnUM
 CpzWkJtWF3ItP2wnfLj2tMCzi8g5NT6Ud3OzlUP9nSRcayMqIcqKxlh1iZ3etowi+PJF4TcDS2R
 ai1o7xsxL1Dcg2ujvH4Civ2CXiMAR2bqvV5ls8G9HMkCYht54EqwrbVnpDNgYcDPEzQyHZ7mKBV
 4AAbMFK3h+jG+WIQCdeIsAKagUoLdzvKXqNmBXA1FhejSaIYsVdZIOf77q9C8tX9Jk1ooYDTHH4
 GnLwfnvPYE5D4uk7BM1dGEc8CYXTDuRc8QYhEJpYeviCZQCs36fab024PwdWYtvoYoBv6dvjf1s
 YhK/x8u9/bBB7UJ3VISqE5P63fskuw
X-Received: by 2002:a05:6808:30a5:b0:455:f0e4:4f89 with SMTP id
 5614622812f47-464bea4145cmr8026379b6e.3.1772567752134; 
 Tue, 03 Mar 2026 11:55:52 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e10b:3ef0:5af1:d180])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb352592sm9995183b6e.1.2026.03.03.11.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:55:51 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Mar 2026 13:54:52 -0600
Subject: [PATCH v4 4/7] clk: mediatek: add CLK_PARENT_EXT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-mtk-mt8189-clocks-v4-4-ee85f8dd2f0d@baylibre.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3567; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=qb0RnqzVggysAO0jcOPzRAgJqtc3Lrpgb48S3SMfkoU=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGmnPKmg3hrHWg/789XFknAYDOwQlX+Phemc5TNCa47+sf4Rf
 IkBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJppzypFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8B1tgf/T9pmC19eiUU5gzbkpK0GeHpsaYCKuX+fvk/YgTgLLDonetq
 SZmru5RUQiXsbNB314Oe5Uy+rWmqNVBIDLdt+CqS33hVHVahO/SvF0WJ5xRxCqmilO699kltGf8
 VOdX3f2IyBhK64KtmfTVEJn+ob/sejCpWCBCipP4yiS4xxDFVyxNsvuIBfYaOYoZDvMc8DYA8pM
 Hpv9ov0FYLN4n6B7fe9OvJk8ZVIbzVd7JNZ1tJoHd6TTztUTCzLH2EsrOh+RE0oAN7s2ghF82HO
 UZdZOYEVQKvMk9NQ2EqJLIWo5ZmPjuk5JEzX8Q/3p8pckUK1/q7F+ICp9VzJagqnvPUQvw==
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
 drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  8 ++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 7fbd10b8666..40eae634e02 100644
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
@@ -1134,6 +1147,8 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
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

