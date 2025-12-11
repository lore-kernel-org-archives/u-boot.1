Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3092D41D74
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 00:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56EAF83869;
	Fri, 12 Dec 2025 01:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g38Rf/R6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C6F83655; Thu, 11 Dec 2025 23:32:28 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5CA830E4
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 23:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-44ffaeda17fso296225b6e.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 14:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765492339; x=1766097139;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WEfb+YSAn2LTkLdYH2UNzc6BfEaH8hnCPopvMuUcDfM=;
 b=g38Rf/R6ouqmJZDXOpfg72CQ3gNMcFwQ7NTUFIPLe4CtVQZXvsnlzgevZcayWDtYo8
 IlxuTNWiAQj6fCZn3JhKXtVclh7eLBdVV7exBI3ClB60ZTA+RpWCIAG2Zm7lpPmgqB/T
 swE61IDPQO+CZq5YshEqqKP4Jjpe5PrgCeAYLYf1swuPC6P7MtPH/PDy4O/ehd+6JNTQ
 se8XS3E0vXblgbaAGNIcHBfmqX5yNosjgQBo2ho+yGlTb0RPCKYFMDAmilJ7uCiflVCJ
 WW0XA4QNymWx1KH/kVdn1kLzq/iJBgB3MNT0byQWIH+tufOPhP7hqzpJ3iIM+gPpHa2+
 bDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765492339; x=1766097139;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEfb+YSAn2LTkLdYH2UNzc6BfEaH8hnCPopvMuUcDfM=;
 b=m8DVGPYmb0HhhTK/RoCZSi0Ki4Y0LpJ7XK69aB0N2WtukRXwawZ1GpIK5MM0dRI3kB
 kYyOmcoEXdsodMEyMzg3jBzeSodejdoJh0xWkZeieqwYUAaL4w7yW+jCKuKfZYmr4fWk
 f+56ZrXGwiLeutfiuOcC908NWZWaZ34k32lt+p6Rk+Odkvw01DeLlOupWpBbESWVakhK
 yXKWyUTXVIOgS0amhDrkJ9HmOXuH/9/blPrDcCSokQfFMWUGcOI1o/HsN/ndeCtQXZeV
 VpPVIr3grasiv7F7OhcMpoWPwIantVsk6mOgEFoI5G/WncfwLhinQWiZcmfNyW8e5+bM
 UwQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHHBdwqvdUCN03u7mYjXQ3jQw5ffGxyw0nZYZ+C6j8ERz8Mb8Bnzt79PnnJNQApniq5U/nRSk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxyka9K6KNGi70ZCmNYcVTC5wQM+J0Gc6tj/OCTGfK31Se2XQmJ
 /MYbYWOhIVU/j4e7tu/FhpDklS7BvJo/y8lffQumOdaADKKhsQfTx6UmbgIghI4dtfw=
X-Gm-Gg: AY/fxX7Bai0hJgqCyMlZD0Up/SHrMwduDNd+QTiTeq58MqVQY8MeIvFty1bbUgl49vu
 rJackfcCmQ3F3TkjRiItaiCRUsWC+cEzeE7gVFmZdmfwk5NqLP0ReD29B2p5MtlmCZc/fwe2mH0
 /GtWAQUvuUv0Uv00LYv4HjvKMQoTkREOtj603GVrfAZVcT+bsvx4l/V10cNsnyHBBNIKeQBMHbF
 lNnUdyWC7J1VP0OMYiqatYUY3wH3rACOZ3fo+5i64Ezvk6O5Qa2HPa9iMzEl55CX4q1ZUddvNqo
 0INxJxtdlQlxMz8KIJjXEjq5vw35h8dLLIWWJLw+JPxJqoJKv284Fyhz7ZbKz+KMG5ecuGtynHC
 h0JUOg9KY2rkmJf2J28lCJg8nRDfnAAUHaxhtDq1NWFBUGIzDAnl+Kth8ltIVCgn1ouz9ZZksJD
 ZRKsUkaiuCQMMEz4gyN5nojy2Auw==
X-Google-Smtp-Source: AGHT+IFkOyVwulF7HhMU5Q6WvAXwfW1D7ZklRiiJGwdFesd24WFkbm/eJtiLY7CnglHGfpMQqqQANQ==
X-Received: by 2002:a05:6808:1441:b0:450:42c9:4cd0 with SMTP id
 5614622812f47-4558691e14fmr4403067b6e.49.1765492339278; 
 Thu, 11 Dec 2025 14:32:19 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598d6cbb2sm1747393b6e.21.2025.12.11.14.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 14:32:17 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Dec 2025 16:32:10 -0600
Subject: [PATCH] clk: mediatek: remove CLOCK_PARENT_* aliases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-clk-mtk-remove-aliases-v1-1-6a7212269fc4@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MywqDQAxG4VeRrA10gnbRVyldjPHXBq9MZBDEd
 +/Q5bc45yJHMji9qosSsrlta0GoK9JvXEew9cUkD2mDhMA6T7wcEycsWwbH2aLDWZ6CrlFtGyi
 VeE8Y7PyP35/7/gGlhzPOaAAAAA==
X-Change-ID: 20251211-clk-mtk-remove-aliases-262eb4cc54ec
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5622; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=jclnG2mqAeMTpqAGChaDIpbTQNlYuAHVV0YCiRhw0Ds=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpO0Zr0TlGSKlJayBlzXFpuoxvnI5iGA4GB3cuj
 37CjlEREqGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaTtGaxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3AMH/2ylEiH8PaPm0BtbUgpJ7j9UYFQUncHTtmWsROk
 iT1I1ig4TFu2kn7I0jINgMP2+iC41kEX9NJyt/JyJtat0UiBL8yZuaJZABfRkPHm3o86zYscNcB
 ++jBVYJZ5uJhETVo/OWQE8UAnu9M0Y7HHrcZpcqogC6vFIVxZT4nGZ0Sscx+s2eHlYd9qqCLW7l
 H7I9674ODJJ1kMeaO4c2k75oFhknHzZHUYTE/MAik/M0zli25NCbHqwJNKqOFzmWbZTtogU2zBA
 hymBaYM4s0CTWnXMo94tiVM2ydxKQnu92MifFlNpPXvnYTcqyJTCrjrApwiTUmc1126ZpizhyU/
 ydOI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 12 Dec 2025 01:26:18 +0100
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

Remove the CLOCK_* aliases of the CLOCK_PARENT_* macros. One name for
each flag is sufficient.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
The patch that introduced these aliases gave the reason:

    Also alias for the CLK_PARENT macro are provided to better clear
    their usage. CLK_PARENT_MIXED require these alias that describe the
    clk type to be defined in the clk_tree flags to prevent clk ID
    clash from different subsystem that may have equal clk ID.

However, I found that having two names caused confusion rather than
clarity. The only place that tree->flags is accessed in the code is:

    parent_type = parent_priv->tree->flags & CLK_PARENT_MASK;

in mtk_common_clk_set_parent() and this is also using the CLK_PARENT_*
prefix. Logical reasoning can easily see a potential connection between
CLK_PARENT_MASK and CLK_PARENT_TOPCKGEN, but not CLK_PARENT_MASK and
CLK_TOPCKGEN.
---
 drivers/clk/mediatek/clk-mt7981.c | 4 ++--
 drivers/clk/mediatek/clk-mt7986.c | 6 +++---
 drivers/clk/mediatek/clk-mt7987.c | 4 ++--
 drivers/clk/mediatek/clk-mt7988.c | 4 ++--
 drivers/clk/mediatek/clk-mtk.h    | 5 -----
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 6130c93d5e6..2fdb1845e9f 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -521,7 +521,7 @@ static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
-	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
+	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
@@ -531,7 +531,7 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
 	.gates = infracfg_gates,
-	.flags = CLK_INFRASYS,
+	.flags = CLK_PARENT_INFRASYS,
 };
 
 static const struct udevice_id mt7981_fixed_pll_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index cf298af644c..16db5877056 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -519,7 +519,7 @@ static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.xtal_rate = 40 * MHZ,
 	.fclks = fixed_pll_clks,
-	.flags = CLK_APMIXED,
+	.flags = CLK_PARENT_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
@@ -528,7 +528,7 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
-	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
+	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
@@ -538,7 +538,7 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
 	.gates = infracfg_gates,
-	.flags = CLK_INFRASYS,
+	.flags = CLK_PARENT_INFRASYS,
 };
 
 static const struct udevice_id mt7986_fixed_pll_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index b662d680b15..caee8bf43e4 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -46,7 +46,7 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
-	.flags = CLK_APMIXED,
+	.flags = CLK_PARENT_APMIXED,
 	.xtal_rate = 40 * MHZ,
 };
 
@@ -442,7 +442,7 @@ static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
 	.muxes_offs = CLK_TOP_NETSYS_SEL,
 	.fdivs = topckgen_mtk_fixed_factors,
 	.muxes = topckgen_mtk_muxes,
-	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
+	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
 	.xtal_rate = MT7987_XTAL_RATE,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index c6da42f970b..bfbf401eb12 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -773,7 +773,7 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
 	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
-	.flags = CLK_APMIXED,
+	.flags = CLK_PARENT_APMIXED,
 	.xtal_rate = 40 * MHZ,
 };
 
@@ -783,7 +783,7 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 	.fclks = topckgen_mtk_fixed_clks,
 	.fdivs = topckgen_mtk_fixed_factors,
 	.muxes = topckgen_mtk_muxes,
-	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
+	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
 	.xtal_rate = 40 * MHZ,
 };
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 4ef1341aea6..481cc3de22a 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -41,11 +41,6 @@
 #define CLK_PARENT_MIXED		BIT(8)
 #define CLK_PARENT_MASK			GENMASK(8, 4)
 
-/* alias to reference clk type */
-#define CLK_APMIXED			CLK_PARENT_APMIXED
-#define CLK_TOPCKGEN			CLK_PARENT_TOPCKGEN
-#define CLK_INFRASYS			CLK_PARENT_INFRASYS
-
 #define ETHSYS_HIFSYS_RST_CTRL_OFS	0x34
 
 /* struct mtk_pll_data - hardware-specific PLLs data */

---
base-commit: ff80e95fed188ec3d4001129445e414c9c811beb
change-id: 20251211-clk-mtk-remove-aliases-262eb4cc54ec

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

