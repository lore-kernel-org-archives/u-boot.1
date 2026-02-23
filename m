Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01298EEC2AD
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 23:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874B283E21;
	Tue, 24 Feb 2026 00:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pdIoMfCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DC583DAE; Tue, 24 Feb 2026 00:23:04 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 747E283E62
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 00:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d195166b2cso3474933a34.3
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771888977; x=1772493777;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w1h0++JFcW8yiJQ4LSvUOtDdZkNFjiD2sA+ZkO9FcKM=;
 b=pdIoMfCYT8G2048U8jC3tIp2GJSNVaLt+vV1llARg/11sP6Jlck0CogJZT0c+ojbvC
 Mo9kenGGQuYE8c0D+7u4B64fe3nJm5aSKA/F8SlfnNrlDPHP4VkqXdByn0IZ/IWABW1X
 h5WVWNnXgFcmgaiR26qWsYdDg6P8Cpl9WUmA8uwEtXX/ofuJfRjWn2vEjot5X6CYjpTA
 jBLXwgRSdwCMc7t+8JrCOrsOT1Gd97jzClc429JTXc7vUJALB1jse19t7EiI+XA3t/VR
 9lou+pgx2p1wQbAiYRpScm+vL7MylDw8OrjvnUY9oZ6/g/1yozDCHksUKEpUqyIExLom
 1sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771888977; x=1772493777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w1h0++JFcW8yiJQ4LSvUOtDdZkNFjiD2sA+ZkO9FcKM=;
 b=v28Y3+FnJoZEUhZEAar+xJfzzILHNN1t1F3Z493t2NNG6cL9P52zX2Be+XEcjCfZno
 k0pWYwPqmMoJVxJ9qi6zZQD/x8a1K0tCjyoTlcHa9PAMMF+ON6g/8WNfLSmjNNbQK1as
 G1Q+HbrINjhsABit7Sx9xmTQGtn5Rvtt3Reg42g1KHhI5PpN1wft6HwV7vtko+3Nw37+
 6J/6oXSDU+tItX/xwXTYAZ0/QnGZCM+anTKkYnAihinE782tjUhwFV4OcmP5QCTIgLz+
 u/nqTgnOeBbkMys6QcOdKhBYU8Trw2NKTIXN7OJPSP0a3n7voliiX/wzRLeywrBynecp
 5BSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMgGpD0S9Xu86IZH38AiZC/SS9te7a30a05fZ7Vr8lMbToInDr9w7rwiiKmh6mhkQX5VJRkYE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywf1ER6JVStzRfhxpnwWdB2IUTXrbZcYA5yyIJV0/nETWAmC/oY
 E1UO6xPShMpDVA+SJHw0I6kLm3nuF6ssVPA+XE+huD6FhJmlW7kueQ9EV0LCO2ncUOU=
X-Gm-Gg: AZuq6aJQGfp/oYZeXBSrSjT73IXXYvG67Ee0iwSZ3CK/ougtDFbRaeD/mGHp7tkqmqc
 JqoHXL32tb5AanH0e1xPJgi3XZQr8x19/Ri4Ngn2PxYVle/9rA8RmxbFtBCSBSehz78a7VnCQJu
 Tpt67x0R2SOiuh8HcKEehy6xTB6G0q+3hW5KugEMtaBvjd3gUEDpbOtDKDGVWznMbaUYK5m6zue
 GGZwwVWFnIo3lU9bUKC0f7g9a6nULQvg+9DMBnrX03Bbxjk2TnKnOJLWDd270KWIIe8JycLLQUl
 Dt2AWTsQwnRWF4sMC1nSn3QPyHCpDnHlKcrAfbAx7sDNNSWpa4mS+joWKgJnawHNPkwWAjDV9Vy
 ZW4njUTr/ymU3VBl0N7aAeaawZ3RKrFWFzmAKbzoVQ8twsn8ddrCI8kGZmHpJohmhvSpGXx4bMU
 ioPSUnV+YCehfP6A65QahNlfB29H2L
X-Received: by 2002:a05:6830:7190:b0:7d4:96c3:3f96 with SMTP id
 46e09a7af769-7d52bdf43c5mr7569832a34.6.1771888977176; 
 Mon, 23 Feb 2026 15:22:57 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cb87:475c:5c04:ac92])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm8911230a34.5.2026.02.23.15.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:22:56 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Feb 2026 17:21:59 -0600
Subject: [PATCH 7/7] clk: mediatek: remove use of CLK_BYPASS_XTAL flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-7-a7dc97bc2660@baylibre.com>
References: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
In-Reply-To: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5358; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=O5xpHWfHv+L7hdgv/O8p/qkfLsa0cpsg/umF+ixbjCo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpnOFCj78XAsi9byCTLY7JigKvtsfqs19WwUMPF
 wTiyWLhh7aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZzhQhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A73IH/1NnyBCZ23NLXTkFk1AWj5wTj3tHgSDpokbN+TN
 wUXCI6hat1QJ5hcwDCN/Gco/Phm8nK79wjIl5FBl0vzEO/FY7M9B7HSljG2OJWxVt61IQuECEk5
 /HyMoLQ1/xo/yEkcSGymD9ftMP0SgyotntqUacHdhQAgahJv4ET1L789qf9QDw5bggkEkJ776HJ
 KZHvW5pfD4mkPSH8zzhk8fK5WzmS1SFf+ULa6JXWlZniNBu33ZzvHV5MpCTevs/+OeC6V2KX3gv
 hGxr3u353QQJOp+PJRDXGt0Ay5WKvQw7agvEFX8I55ABFH2nyrGFFDqvh/rC/lSK5CQmZadqOK+
 Yzzs=
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

Remove the CLK_BYPASS_XTAL flag completely.

It was a bit of a hack that was meant to handle mux clocks that had
mixed parents (e.g. XTAL and TOPCKGEN). The idea was that if you didn't
have CLK_XTAL as a parent, then you were supposed to add the
CLK_BYPASS_XTAL flag to the clock tree. There are likely a number of
drivers missing this since it is not intuitive.

In the meantime, we have introduced the CLK_PARENT_MIXED flag which
handles this more robustly. All of the affected drivers (the ones
without CLK_BYPASS_XTAL) have been updated to use CLK_PARENT_MIXED, so
the CLK_BYPASS_XTAL flag is no longer needed on other drivers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 2 +-
 drivers/clk/mediatek/clk-mt7986.c | 2 +-
 drivers/clk/mediatek/clk-mt7987.c | 3 +--
 drivers/clk/mediatek/clk-mt7988.c | 3 +--
 drivers/clk/mediatek/clk-mtk.c    | 8 --------
 drivers/clk/mediatek/clk-mtk.h    | 7 -------
 6 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 09ed4d8a97f..87b68559e65 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -528,7 +528,7 @@ static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
-	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
+	.flags = CLK_PARENT_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 79efbf43bc4..3309850aa60 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -535,7 +535,7 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
-	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
+	.flags = CLK_PARENT_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 959b1c9cff6..b4bb02ca736 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -448,7 +448,7 @@ static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
 	.muxes = topckgen_mtk_muxes,
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
-	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
+	.flags = CLK_PARENT_TOPCKGEN,
 	.xtal_rate = MT7987_XTAL_RATE,
 };
 
@@ -773,7 +773,6 @@ static const struct mtk_clk_tree mt7987_infracfg_clk_tree = {
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
-	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = MT7987_XTAL_RATE,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index cd8726852d7..2f0fa9f1ce9 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -790,7 +790,7 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 	.num_fclks = ARRAY_SIZE(topckgen_mtk_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
-	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
+	.flags = CLK_PARENT_TOPCKGEN,
 	.xtal_rate = 40 * MHZ,
 };
 
@@ -801,7 +801,6 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
-	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = 40 * MHZ,
 };
 
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b604bb274c1..fde28943b3f 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -735,10 +735,6 @@ static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 	}
 
-	if (mux->parent[index] == CLK_XTAL &&
-	    !(priv->tree->flags & CLK_BYPASS_XTAL))
-		return priv->tree->xtal_rate;
-
 	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
 }
 
@@ -1005,10 +1001,6 @@ static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
 		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 	}
 
-	if (mux->parent[index] == CLK_XTAL &&
-	    !(priv->tree->flags & CLK_BYPASS_XTAL))
-		return priv->tree->xtal_rate;
-
 	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
 }
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 386f531514f..8374ed5ce78 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -13,13 +13,6 @@
 
 /* flags in struct mtk_clk_tree */
 
-/* clk id == 0 doesn't mean it's xtal clk
- * This doesn't apply when CLK_PARENT_MIXED is defined.
- * With CLK_PARENT_MIXED declare CLK_PARENT_XTAL for the
- * relevant parent.
- */
-#define CLK_BYPASS_XTAL			BIT(0)
-
 #define CLK_PLL_HAVE_RST_BAR		BIT(0)
 
 #define CLK_MUX_DOMAIN_SCPSYS		BIT(0)

-- 
2.43.0

