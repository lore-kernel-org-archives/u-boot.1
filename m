Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A23C98321
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 531A860BD5;
	Thu, 24 Sep 2026 19:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IeoFLci5hEXU; Thu, 24 Sep 2026 19:44:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8FFBA60BB0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279047;
	b=h/aEIkXOoC1SkCe55rsTX7HBdmBl5Xq81VFO2Die0awAlPKIdf8MqnAhLd6kfbHpKhNr
	 bsNWyedqy6fieyUt9mMa+DOWGFkGRwe8BtHStrsqYwTATm6ITMLp9+dgUHCHpRDHPsJBt
	 XTw8XtwYSIHj7A1pdDeD5aTXxgYphc58ys4JfQpat/Hn7qznsam89uqKo+cDZ4YJt8/Vs
	 nq9IIRLHjGHwwo2cK/0eqEMPw3t0HJDcvOMFc9Ab6PBzC4ch3oxft5D+QOU4BG4pRZuWD
	 TdiP5z9AvFOpxV9ovPaM3ZCJ5i3D13SGvYQoN0ebebM3kafLu50qcT4q5sUY39BkKUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3w2LAhLnLEDGvT0J8GTobKwqFWo2anRYqajp56ChSYc=;
	b=LHi0jLE6v73543Soy++s+HRErrW5USjceYcVImJRbudpA/CJedtJbAGzoe/VCXdIpjKj
	 x/geo5se+54nhxhxZQE33Uh8K6tDMKusV3uPD/Nv8QJNq/lixX02Pq1nop4Szgx9hEzZs
	 JCx+usFgspW68mM/+TvLtVCu21t8guwEEPfl+pBq9guA+jrTfOD+qNrHeLabdMrEe0z2z
	 63G7RzTocd8Y0YAv4thT/tfmmGqEAqYlPZ7ecJfBb/V4ipye1C6UlcJ0FH2/8sxJVOt4+
	 WVxP8MtHzLh5ze3ANQZibLMWMDLO6P4X1G8oiMw3QppWXK65aBmXJw6dyUWi1rx6nWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279047;
	bh=3w2LAhLnLEDGvT0J8GTobKwqFWo2anRYqajp56ChSYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Igvi8QlRE8J7TXOOJwaLshGfMmT9gxJmIqAMaHpFAgqrZW795YRAt4UtmWv6HX5Cy
	 0sutQ9de4B7pouGQRPd3tjNIbwEBUNEEup6LUPwTEWX/nPmD5L7sXAK15yLSkZIDEy
	 +oWTKCk80dGpbZEZDzdV9eidc9+sRZ6hw/G8Mliv+c3WkcGrMklAulSHA1v9j7UIJS
	 uvWEkJdnA4VjykruF6lgR3rdh1VJOwAanuClxBK21yut9/Wy4LiJQFRfYpEYgZ8oCq
	 MRduWWPFTV7lP5naPQnn2K04H68GJCHvWjOtI8yGofdA5zguUtcBLB2gjdh8ERBgL6
	 FzNgWtJsDSawg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FFBA60BB0;
	Thu, 24 Sep 2026 19:44:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ACDB328
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C63840E3B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uIFnTFbwzXeX for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 32FE040BD3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279039;
 b=oeYdMU2ySuyquHxCjsBg14Fr0O14TSVE9B4cT2NPUyXPYr4LXIcteQR61RZk1MlcLlUA
 gBiCybY2Vc4wnfyXnmsY0kyG71ypzr7n6B76xFUUWyT7onTlkzP16wPM1jioDsx2s++7m
 gd0XtnqoSmqW+3uA3FBH4C2cDGGdQGzPvodc0DSYqjP8yud79i3uHdSUGfj7mxKs2P7Wl
 mVFWuucubHlH9Keq7ZbhsEZvYiWZ2pDzXN/L+Q4DU/48cbL8sEj3LDXtKdvtsxxZL0Ose
 PFm3UBAkeLg+y8qwjhZHy50ndqJkuP9ScekVkGmuCmxCD8+BorNnzM96/maDrLunZlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279039;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=3w2LAhLnLEDGvT0J8GTobKwqFWo2anRYqajp56ChSYc=;
 b=UxNuwrE5/HoqL84uaU9V3Sjmfkra+rbiY3QtCgx6sQ6ygBU7D+C5tX6ytUSZptRHWWbU
 HdNP49dQOKZZSYx5EJ56iC78FrbEk9npnk7FbL8jCwlxb89tlbmDthm04Va4Pj0zneRHr
 DseMpB3QJnMwCsh0zRufLQNMgju6VX7sLuTmAY9BWMKQKaNfTn59VAUq7iUrLlo6hp3uC
 IV4CXEXLq+G0yjOqhSGuWwNyHWim32Vx9l+FUBmcCRycYyQ2E/P8Jvd88dj3n2TToGhkM
 5Qita8t0c2rnRVJa/5H4ds6VjuolMfKvo4w2pwo+Nclnsr9zG9nfYtMlzRfwVaX9Svw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=M3gtm593; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=M3gtm593
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32FE040BD3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:58 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-805cc8b4231so92346a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279038; x=1790883838;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3w2LAhLnLEDGvT0J8GTobKwqFWo2anRYqajp56ChSYc=;
 b=M3gtm593h3ltnMl6NL9eP1qM/r+bZ5yNNTEERvRmiKv0RoM8Z6f2ohJMDF5PtHIDdn
 uJn0G2rxeBgVyNlUwOm4Gfn+JhItvKtkzmBhrKINOekvMhygKfN6hvMTEpAccroPZmy9
 nMSAkXgoe3oHHly0bls2RiCtqVbVCMbEmRq6lcXSy6D+6BUnniLATDMERPDFqMt7G+DM
 h2Oj8i/LcrtPPeWz0TnMerN7+wN6qPTX0f3VPZgOiXsWEEJLDl+4EX2zSzm5i1CKDNub
 Ov9f7NMl/37kKWB3IfbFN6XnuXEU+KXqcYoL4wM/l93R+NjKFOKoQL+HE764ZYCLwWUx
 /zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279038; x=1790883838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3w2LAhLnLEDGvT0J8GTobKwqFWo2anRYqajp56ChSYc=;
 b=m06dwUxECdd68h7O++sW7GZoKxIKVrFWKaf42Dr6vsqh+NswHyZrocHvhwWVH5X1W0
 n/br3rqtrmr4oMNOT70sSEld7gMPLqFdxPywh8wyNRoXldQhGklz8++kqdDPdYORIxDx
 l53TxKD4oNSHjGIrUtQnKIzP2viPhh3E5VRUx0TjRDQebySNNv6ZGYF/il3XFalscv4u
 jEGDi2bX+kW4kQ+sIdUYzImcjdHuN8Z6/1sCXY3Jou/2GfPLCBEa0g4XihRLoaQrlEoW
 1N5uhnjfkAcXGmnFqLaEkUzMizK39nnEo0Bi/PZ53wrCZcrjZLB+75oE3xizK510FAog
 aPtA==
X-Gm-Message-State: AFuF++nDwcJC17iGXnwjmlAzjWObPYNLOse6aXVQl001LE2qmecaKVq/
 LJiwwFtw1gMLVI7erJSqd+P/hkndnVoJ/TYA51elVauoPJdESl8agt1+Kcaaragb2w0=
X-Gm-Gg: AYBFou3XHOvGTvVrRzYYVBc03SWu8PVNI8kLM+pstwF8bGcGNQfZlGSgrGzJw+j4Yef
 tMjhrZjVm6UejoSvftn/xbO+MfnqcMr53VkcgWu/fLvAQbKkg8LSst1J/CiViEqVOtYwvpNsh0u
 fB7YHxKTdvicI/R10NYDGTW1+i8Sbv3gTsNwe7IxHiMsYQmErP3vBjqp6YQMfYxvpG292FxkFN1
 30g5ptM9W/431PbbyfTabEsNGOB4QCR0Ctn37d+o5vxQi5KQAFKQOMWqQbCzMmyw+lAe6DUulOg
 2OkqPffWkc/ddhJ25Os9s/a/QtmirVe2sdT+Ag6/hgT6bfAviM9HQxO5fOqZtujhyLvMv8C27mW
 pEkPpL9XYJqyLgwN6pn863aAmI5IGsMgp3tCPN+A8/esSQmOkb8bzd3i+XvhZT5lITHfp4SatFg
 1birYZZG1m2WlehYmt0xJUbY3x3BEE1fvU9N2So567K6aFD/eccL3+rdAChVm1TUQYU/eeHhg+8
 vA=
X-Received: by 2002:a05:6830:6734:b0:7dc:4a43:fb5c with SMTP id
 46e09a7af769-81781294540mr3709597a34.11.1790279037882; 
 Thu, 24 Sep 2026 12:43:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:48 -0500
Subject: [PATCH 10/15] clk: mediatek: mt8195: merge the apmixedsys driver
 into mt8195-clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-10-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=7zel3kPA8f/j8QGC/6Hv942r60Sdf+E/m9QL7SZzV9w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX0+xNszMwnzpymDc+tmWjWaYu+1jI2RrhIjn
 DxR4D8yW/yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9PhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATNMIAIreq8TLuOrepaJ7JtmLBCJNJz8dlZaAFNSKFGQ
 xs1iikIsNhwmuFksmqD0fOYYlGS5Xz0q+2E1ACwNvLFB8W4rbQSXDKuQOzWzjDH0EJDxDAgTemX
 pF2h49h6EHRpoJ0YPeBcW2Ef5BCe4FlHatlDy3zDqUgvwEj4sl+qQfcp2hYqnW5rROYTb/jFJ8O
 UbIO3EkajjN0M6R8Of/P5ErQF0fV3rjLxO1NtfAuM/VwkQQp0L6JurdZKDOVXoGlI2b8qBjwmzi
 wDj/3xkYKrTwsxv73yZAdwM2ZP9KZbh+CLeLNyu+mxlZ2FFO0RlqMcOFLGflJLx1MaNDVDo4DHj
 BcZo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Move the apmixedsys compatible into the mt8195-clk of_match table and drop
its separate U_BOOT_DRIVER entry.

It was only kept apart because it used different clk_ops. Now that all
MediaTek clock drivers share mtk_clk_ops, its entry is identical to
mt8195-clk apart from the of_match table.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index aa46d1b451c..eb3aa917dae 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1598,15 +1598,11 @@ static const struct mtk_gate infra_ao_clks[] = {
 
 MTK_GATE_CLK_TREE(mt8195_infracfg_ao_clk_tree, infra_ao_clks, ext_clock_rates);
 
-static const struct udevice_id mt8195_apmixed[] = {
+static const struct udevice_id mt8195_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8195-apmixedsys",
 		.data = (ulong)&mt8195_apmixedsys_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8195_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8195-topckgen",
 		.data = (ulong)&mt8195_topckgen_clk_tree,
@@ -1618,16 +1614,6 @@ static const struct udevice_id mt8195_clk_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mt8195_clk_apmixedsys) = {
-	.name = "mt8195-apmixedsys",
-	.id = UCLASS_CLK,
-	.of_match = mt8195_apmixed,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8195_clk) = {
 	.name = "mt8195-clk",
 	.id = UCLASS_CLK,

-- 
2.43.0

