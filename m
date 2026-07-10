Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87493C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D04584BBE;
	Fri, 10 Jul 2026 20:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GGQ8Hws6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6894584BBE; Fri, 10 Jul 2026 20:59:35 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDA084B51
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-44865cf3010so522646fac.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709972; x=1784314772; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VsAUvQQKeyKmFxs+Xr74SNUbkCN5t8ncyFgPcx3AF4c=;
 b=GGQ8Hws6vukz0F8vMwFRte6rPMe0PRgJ5muBcoRKo4w1hSqgay70RuBmDv0cRVZ2kf
 jz5mf1pYmcmXuIrOU9pJBAHa1+anjiTD1KqApbgPR2hF9XPLyj7wdsAuFYepIYmHoLij
 IayMzlO7G0DGIChwfzmktJHQeSJ8SDA3DMWyydEQ5AbZO82WkUup/DE1+53YAXxLYI7Q
 VTAF5rDmlKWx6rc/H0H2tPG+0teZ6eb3ajsgJZ1atIvryLxBDFN3H1gibt8c3gwKeouM
 kXMCtRK3wt1u59sZo+uT3axrzwpSBcFJ9PcXXylbl48i3Yvf31zKm9kFehQt7yAYiQtR
 8nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709972; x=1784314772;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VsAUvQQKeyKmFxs+Xr74SNUbkCN5t8ncyFgPcx3AF4c=;
 b=LT6ibZWAv/mGeJdJCyM2hiZ0Pd38UB1JsjD8vMm6GmDpNzum/lD5l+4fdtUxrfNCdz
 48KBsFP9fgbC2kWfE1isVfXXe5ARZPSa1CbMZJ2L03+BgD1aTm9zoOALNBNN+oTVqqzh
 G2TB0esXjv4p2wt6umiIAaMcCl+zSxfotICk7MMZX+MFdM62MnNJu+aWm+ZxCdvc1W45
 esFGdNyilrpGH1YILU34H3nPI1uTl2/G/DsIvwAB5QtS6Jf9jQsoFoHWa2NHHhZN/Wv3
 6rLtC7GdvumPKhbk+F9Zc1XUNxWDM9oQjWgoOo8j/NdeF3+QKS7ceV2ovuegLzmv7Hsn
 37qQ==
X-Gm-Message-State: AOJu0YxEF+FgfbwU8CUQXnCyoavNx+iB0DquAEh3mfOIB38grYy2aK6e
 pIdWzJhCFde3pm+5OcbN4F/tI8Um4Lhbuen3SQpyDDxNAnL9N97LpgMsfvPqYpCu/j23SdKPr13
 YsQv2
X-Gm-Gg: AfdE7ckg756pqr+cnugB05aVXLyPGQ4e4afwWNDRqwA0HglV6XqGzaYm6TS2VoT76V2
 5X8m2bJvH/ML4C55ad697HE0V8EJNSv0DQEOCtzVekaRWQvrQY/HiGJxnUbyw5hPBSGgLvSbtSS
 tcz76/nrKExun7ID5hxjmpnTjsycTxeVL6P//qSoWp62IGutOz9TetKwbXw1uxInftKolPZNTYJ
 4wnReZnA3/u0QAT1DWeGpeVaKsDSSM+HHe35Fje0JAngkSzPPfLF9a5MkNHbYLmSJcioliqsvG2
 vWfBBQPp3UHhlsM8cUMcvd+mIAsyXIbQCcWlnx3dn3dNDV1Nc3uv3da3+3/tDxd81Q3yO42HVJ0
 Sz3PlxBpxtSF30Bz1x/3A9eJGfUiR/Ok1HO9V8GzGqhe7+eAn3iuZIEHF+USSgLu2kXjgware+m
 z63iM359MFEJdBJ+52
X-Received: by 2002:a05:6870:8a0a:b0:43c:4d4e:730 with SMTP id
 586e51a60fabf-451f12ae19amr94497fac.25.1783709972016; 
 Fri, 10 Jul 2026 11:59:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:30 -0500
Subject: [PATCH v2 14/24] clk: mediaTek: mt8365: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-14-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1vAvN/914IyUboaSSv17CEhwd5BrgiqoGjO9+PYCFiM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUC0RAZJOp67q5SWaj2jWgxrgITasnUFhWtcU
 u3pd5OGpIaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAtBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AldgIAJKLh/9O/dea/tmZskZmkBfjpWkwL72bL7Xk1dJ
 2q2UOjrYpq8zcumPNBZ8jxw7zacMRT70YskUePaWUArsY1zEvgxL20Ir+btUS/rg6lQ81SLZ/TY
 BVUp1wjMaELPzEaId6zcX8G9xNF/ScCk9NskqRfYM481e1FmO9xpXzST5Cec1mbHLE3VStLqS6U
 9Ayu4jPD/MGjTAjFmD21htZ89j5rj0h9Q588UwwnYbPVDl1TIHTlZkio8vQZWo3A3N/KBZ/u5BK
 heeW5bdyJ1V5I4gGH6PbZ4Y8+HA0jFqLvOnU2hcpPZPzqzqNXDIPbR2bC/J/Ufhkg1jBUtT5B9s
 lttU=
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

Add clock tree type flags to the mt8365 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index eb94b86622c..50208ae2fb8 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -79,6 +79,7 @@ static const struct mtk_clk_tree mt8365_apmixed_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 /* topckgen */
@@ -595,6 +596,7 @@ static const struct mtk_clk_tree mt8365_topckgen_tree = {
 	.num_fdivs = ARRAY_SIZE(top_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.num_gates = ARRAY_SIZE(top_clk_gates),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 /* infracfg */
@@ -792,6 +794,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt8365-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_apmixed_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8365_apmixedsys_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -802,6 +805,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt8365-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8365_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

