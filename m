Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BBFCD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 16:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E3A84976;
	Thu,  4 Jun 2026 18:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="exv8XCF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D60B84976; Thu,  4 Jun 2026 18:04:19 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1845A84879
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 18:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-39677234558so8879721fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780589056; x=1781193856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gqkVHvkcnTU00egED2DbtTVbGYnjLd1xjREq6pzQmI=;
 b=exv8XCF7hjDj3LaWwOof3xG3vAAHci8A99Oh4IybN0T6YoPFVHtxCD1idX9lQb/U6D
 5kA4Wduomiz60bwYqPdWgGhybJlUCA+SuMwpvx/TGghZhv+eJdzxxCz8tHxmKfaosRLh
 AbtM2r7OdDcsih3v0/lQ/+PofAaDe+WuoVlXBMS+GzepnmcGbNIY2T8oc4M5wWRRjIpD
 IAVaZcAVQm8G4i+CFg5FbGvZ0aH8pJ8R9Fk7NePTgE/282rL67tmIYjCGmnFZu00hXLM
 y2eqFLBQdunZxc6D2NkrDt5rjk57VP3yGyzKijvt4IvVtIEot7lkRCy30t/naO/bw1Ha
 Dn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780589056; x=1781193856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+gqkVHvkcnTU00egED2DbtTVbGYnjLd1xjREq6pzQmI=;
 b=jiSB7MhsA9WU1mVXMYC3/Qd+Si5hULU+CLISlYoi+F4VdJp1X1lkBBdRmxanWr8wzL
 dyAtj7CVbIZILKmKyjmTESXuacb/ZuHliJmNWTZj+GYoO5ias+ExpvPgGlYzPThx7oRj
 uf1zdB9K1F8BQUXW51uFCZYA3ThJ18q7FP/J3F1K2h/BiuoQlDdJzH49lvDn9NXfz07K
 LPgRaB4SZr6fMDtlBFTFeEWfKXDNE6KJibPvec0QfF4He5wMquLXb5B7tOWIuPcTKEzU
 DStqHomcTmY0rwg5omP3ZhHRv+B4lejb/0ChAUWAbphkPFldiDcEyWJHaqWHFC4t69zV
 cKOw==
X-Gm-Message-State: AOJu0YymkecqcdvkGwBgT0D4HhvvMn2vddYAX8RgKYxhV6TOxtiHsxaO
 AV3+ICXp7eYQR0NFXiY21z2kyrf9hspAi/NEPxR4k7U6FoTtAO12ezzy
X-Gm-Gg: Acq92OHVGhnSCmmsimUElCy7+8+edpldAf7iH7dhqfOcJgEahu60wXrfAo7bmB1E0jy
 hj8XDgBZg/1xERQL7/T8+HIw804RiPST1hq5GG+KYMQ7+bEH+mmdcDGhn3GGf3cFWmFTSTzfzTb
 WXLJvAQTUJwMzbfhkUIBie3pZVA9eGIUNFkO25pbE8ZfiSICsdFmhsa1IvDK+IrRJweaumnvVZb
 8YvqWYqrNgYtrcPoety+3apwG8G57oEc6TT10IL5x0Z89C3TyzRUvqMQiDGGN/7tuSdH338+wim
 HIWHPtp+IniSOgVyJ5Xqq0os9FpZ3avmMjc0zwf1MQldLQfWWPk1yBJgEruJp3eXcQY943vduJE
 XpnMTdfL0gFb27ixAG6K3LHhGgtElIamDoSyNTvz7gxjrV/UQyneaRPegcVUDoaAVCbklGiAzN/
 6CFq63++FFnX9MdNExvXBulXvLhJlUGvtzLPhM9FYxCZAgIdNMPkbiUd+5yikjgcfHxMo=
X-Received: by 2002:a05:651c:2126:b0:38e:a12c:418c with SMTP id
 38308e7fff4ca-396af13c9a0mr27475431fa.11.1780589054623; 
 Thu, 04 Jun 2026 09:04:14 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2be369sm17135821fa.26.2026.06.04.09.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:04:14 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: brian.ruley@gehealthcare.com
Cc: u-boot@lists.denx.de, festevam@gmail.com,
 Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 2/2] imx6: guard LDB clock init with appropriate video config
Date: Thu,  4 Jun 2026 19:04:10 +0300
Message-ID: <20260604160410.7756-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260604160410.7756-1-shofiqtest@gmail.com>
References: <20260604160410.7756-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Brian pointed out that SPL can support VIDEO, PANEL, and SPLASH_SCREEN,
so guarding select_ldb_di_clock_source() with !CONFIG_SPL_BUILD was too
broad — it excluded SPL builds that legitimately need the LDB clocks.

- b1x5v2: guard with CONFIG_SPL_VIDEO as Brian suggested
- aristainetos: guard with CONFIG_VIDEO_IPUV3 (no SPL on this board)
- clk-imx6q: fix guard mismatch — imx6q_init_ldb_clks() was defined
  only for CONFIG_SPL_VIDEO but called for !CONFIG_SPL_BUILD, causing
  a build failure on non-SPL boards using CONFIG_VIDEO_IPUV3; use
  (!CONFIG_SPL_BUILD || CONFIG_SPL_VIDEO) on both definition and call

Fixes: faa4793ad3d ("clk: imx6q: guard LDB clock init with CONFIG_SPL_BUILD")
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 board/aristainetos/aristainetos.c | 2 ++
 board/ge/b1x5v2/b1x5v2.c          | 3 ++-
 drivers/clk/imx/clk-imx6q.c       | 6 +++---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/board/aristainetos/aristainetos.c b/board/aristainetos/aristainetos.c
index 4a2349e165b..c163b49209e 100644
--- a/board/aristainetos/aristainetos.c
+++ b/board/aristainetos/aristainetos.c
@@ -218,7 +218,9 @@ static void set_gpr_register(void)
 
 int board_early_init_f(void)
 {
+#if defined(CONFIG_VIDEO_IPUV3)
 	select_ldb_di_clock_source(MXC_PLL5_CLK, MXC_PLL5_CLK);
+#endif
 	set_gpr_register();
 
 	/*
diff --git a/board/ge/b1x5v2/b1x5v2.c b/board/ge/b1x5v2/b1x5v2.c
index f7751fd6fb1..da7cb880eeb 100644
--- a/board/ge/b1x5v2/b1x5v2.c
+++ b/board/ge/b1x5v2/b1x5v2.c
@@ -320,8 +320,9 @@ int overwrite_console(void)
 
 int board_early_init_f(void)
 {
+#if defined(CONFIG_SPL_VIDEO)
 	select_ldb_di_clock_source(MXC_PLL5_CLK, MXC_PLL5_CLK);
-
+#endif
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 379155096e8..5be303468a9 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -156,7 +156,7 @@ static struct clk_div_table video_div_table[] = {
 
 static unsigned int share_count_mipi_core_cfg;
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_VIDEO)
 static void of_assigned_ldb_sels(struct udevice *dev, int *ldb_di0_sel,
 				 int *ldb_di1_sel)
 {
@@ -271,7 +271,7 @@ static void imx6q_init_ldb_clks(struct udevice *dev)
 
 	select_ldb_di_clock_source(ldb_di_clk[0], ldb_di_clk[1]);
 }
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_SPL_BUILD || CONFIG_SPL_VIDEO */
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -490,7 +490,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 		 * Need to set the clocks now and make them read-only due to a
 		 * hardware bug. Fixed on the i.MX6 QuadPlus
 		 */
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_VIDEO)
 		imx6q_init_ldb_clks(dev);
 #endif
 		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
-- 
2.51.1

