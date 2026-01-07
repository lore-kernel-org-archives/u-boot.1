Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980E1CFD65B
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0330A8405F;
	Wed,  7 Jan 2026 17:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eax2zaIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD6A80433; Wed,  7 Jan 2026 16:51:28 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8918405A
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3fa139e5d90so784820fac.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767801084; x=1768405884;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Spgti8hv21/QuN6FuQBfKrWPRpbBzSWfq7gWHSpujHM=;
 b=eax2zaICeW0dqtHutA7CapsjuTUP+7KJOYGS3Dx70dtREV3BPxq/qb8Vgt5yjCviaX
 xt7M5ZLHU9X3WH0HlncPumo9sTAzCCI/PxNb//2BFAy3Xdt837kdDYZrdzdo3CMs8Ema
 DgwB/Hin0ygWmRhWGl0cpWauVMzH7Ab6x6qUPxB427lycPjAJM1vp1IaPcKYG1uHfPw0
 ZgsmJ7KQlE4qL5UuE/i2XVzoj8lQgGSDt/tmKnepM5PLtcTEZVORuUXl9iND0ymGKZk4
 +vYtWZB0KD0cUxRoOZfENq27oCuHICq0/hUaDa+H5tPCjNAs93jJBVOYiZDf/3TB/Ljp
 AyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801084; x=1768405884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Spgti8hv21/QuN6FuQBfKrWPRpbBzSWfq7gWHSpujHM=;
 b=ZzbvB2oZ3DttZcSvHLvOvRPFH/4I4nMzXZbSXVUecWsODsHJugE3PngcVWdIEcS8F5
 c3dIHdHNOIMKRHM34hdVjRK2eYpAciV3uX+zYRWQGaMgLIko6/mxuU97L1TDlww19kAC
 4g0qZX8f8jZ1CmN9QDO60XJNA4vhWcyVYV7PBCYWpu4A3npFiOZd7lAd+gGny4O/0SSt
 du0WCUasuNUuV7jGxaQWh7N+Kl6GBd4S1qKcLvnsbPiBByp2HCwxALR/8S6LF66dITPb
 ppBm6Cb/7KPWrOim+XvDpUfB5DtJDJsx/ll67xAfEDsB8jRrUr+0lgu4A7qnEv4BjUy3
 84Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU13oXRxKhChjnPGhunZEzSDhAEGKZFp1aI6C6wS1EKh8cbwjt0DCyokvujXdUwMGKnza3j1F4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1I0CfEKCXxMw5ya37PbfYgn9V4E8SSEZegwxnKOuwYsaMJYkn
 QgkkUr8/15XRZlPGYGJqDbBQdBXvO7la7ve7uOxNWGTrSgi8P3LCG1SnOPVgeW/jGkk=
X-Gm-Gg: AY/fxX7M9VHOwbEpYiIRhF+nptxrn+JH+1kNgAcZYAGggEMf/+SxqecYj4teiHri8oa
 PYTd1wRkjzMxcPuTQWa3PbKc4ZIkbVoJy8+HaqVgHWo7wTJntiXIQlbJdU6qxCe3V6hO8N4riB7
 Am8DDvVLDFu+PLuiztZdpJ6pS6mrp+PQ1XxZWpQDSA5lTJFe8CVHfwJOxk9o4sxJuDxI5Zh4btk
 fHpJQCmQkUoXp4K32OI/GEXiaQF0HZ/LJU+/bPyOmwtSUijlctlXtU9FvAplSGYKII/uwLSEabq
 tWGFJqTL/TXgcb+CyV6nqD0jRvJSbiq+NYrmjSUT5lprSMvOoe8TpMNHrsFZfsiHeLvxV67g70A
 uaD4dpPPQ9rrucK9x7Jgg00C551e5ecavENxZiOj+i08rWbI3AcAOC1YAOCnTaEjEL1LuETB0sb
 q6xiLFlVc5JWGW4Fs=
X-Google-Smtp-Source: AGHT+IHrnU1Gk0VIoR5XQkdsCNYuPBEjDdl9dpyL940EQcl+24OEpiWsOROfkJFIMtR+HtP9pXtY2w==
X-Received: by 2002:a05:6870:934b:b0:3f5:aced:c441 with SMTP id
 586e51a60fabf-3ffc0993d08mr1353031fac.4.1767801084584; 
 Wed, 07 Jan 2026 07:51:24 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm3345317fac.11.2026.01.07.07.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:51:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 09:50:13 -0600
Subject: [PATCH v2 3/8] clk: mediatek: add array size field for id_offs_map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-improvements-v2-3-7d4338e520a1@baylibre.com>
References: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
In-Reply-To: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=02z5bJDao/51Kb6ccDgvif8/OVhWV6qpHZr7fovjfaE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXoDMmHJFtGZxxXqWxjq8Zh+92phg7o62K3if7
 oZY7vMroG2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6AzBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ax7YH/3RWsygDcvSDj9UnMFTk4lrP0/0LpehPosZi4aA
 aNJM98tx2lbsyiHAL+h6LbonI4Gct+q3LUANffahFMCPZbUlz2AduncOXA9SFZWaA7xX8ceVPcg
 /Ru/NJz5TamrKSruqv7ZAbAA2ZWhAAvXDaQ1ozk6ZnlBmCKGQKxRVR0GKOirqE79Pobc43ns1aP
 P3cbW14ETEbGdtVVz3lCoI2Rr2Y/lWLG0Ulxg8T0lDHqJTEch1FM9RMftVmo5ecoO/UA11S4Pw0
 ZGdugzpUjkiPuU1hePUzipSFr2w5BZtI8FwS6OiS0MoRJkHiWRUkUiAX6b/m9vW1h37A4hVyiGo
 aafE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:05:54 +0100
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

Add id_offs_map_size field to struct mtk_clk_tree and populate it for
all existing drivers.

Currently, there is no bounds checking when accessing the id_offs_map
array. Adding this field will allow for bounds checking in the future.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 3 +++
 drivers/clk/mediatek/clk-mt8188.c | 1 +
 drivers/clk/mediatek/clk-mtk.h    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 5a60a86233e..eca8352d8e6 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -996,6 +996,7 @@ static const struct mtk_gate hif_cgs[] = {
 static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
 	.xtal2_rate = 26 * MHZ,
 	.id_offs_map = pll_id_offs_map,
+	.id_offs_map_size = ARRAY_SIZE(pll_id_offs_map),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
 };
@@ -1003,6 +1004,7 @@ static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
 static const struct mtk_clk_tree mt7623_topckgen_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.id_offs_map = top_id_offs_map,
+	.id_offs_map_size = ARRAY_SIZE(top_id_offs_map),
 	.fdivs_offs = top_id_offs_map[CLK_TOP_SYSPLL],
 	.muxes_offs = top_id_offs_map[CLK_TOP_AXI_SEL],
 	.fclks = top_fixed_clks,
@@ -1063,6 +1065,7 @@ static int mt7623_infracfg_probe(struct udevice *dev)
 
 static const struct mtk_clk_tree mt7623_clk_peri_tree = {
 	.id_offs_map = peri_id_offs_map,
+	.id_offs_map_size = ARRAY_SIZE(peri_id_offs_map),
 	.muxes_offs = peri_id_offs_map[CLK_PERI_UART0_SEL],
 	.gates_offs = peri_id_offs_map[CLK_PERI_NFI],
 	.muxes = peri_muxes,
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index f7c04047f4d..a4cbb3213e3 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1360,6 +1360,7 @@ static const struct mtk_clk_tree mt8188_topckgen_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
 	.id_offs_map = mt8188_id_offs_map,
+	.id_offs_map_size = ARRAY_SIZE(mt8188_id_offs_map),
 	.fdivs_offs = 8, /* CLK_TOP_MAINPLL_D3 */
 	.muxes_offs = 87, /* CLK_TOP_AXI */
 	.fclks = top_fixed_clks,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 7bd432cb93d..8a1cb0839a0 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -252,6 +252,7 @@ struct mtk_clk_tree {
 	 * ID for factor, mux and gates.
 	 */
 	const int *id_offs_map; /* optional, table clk.h to driver ID */
+	const int id_offs_map_size;
 	const int fdivs_offs;
 	const int muxes_offs;
 	const int gates_offs;

-- 
2.43.0

