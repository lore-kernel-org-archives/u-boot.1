Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BBBCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46A28846B0;
	Mon, 18 May 2026 23:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K4y4ttLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ABC2846BE; Mon, 18 May 2026 23:55:38 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F638846AA
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 23:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a4113ab355so3429237e87.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779141336; x=1779746136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gqkVHvkcnTU00egED2DbtTVbGYnjLd1xjREq6pzQmI=;
 b=K4y4ttLxaFbHaULM1ju0vQ+GWMp+1WT+h0OPUZqtDa9BDMP0HUpNcCNVyDVjG6X3Cp
 UljIOe3i3T2E/KMbTEWHHQLWlGzXMtAHjyj+G2IleRznB2NvDMWMJ6rkM9Xg29SfA0q3
 okU9bYGO61oTuRM9SFJPmNGLZvO5huuaM90kwc0HAJmJ7UZ8no7YlRg/caTeYN16Y7ty
 Je9pA6G2RhRCxrI0vi+nKc1o4g9NyodCTmwYtYXXVTBAiMT7Lw7ydAvzQ1AtDjEd9qvk
 t9r/O4tCsb585m0fbQeRcic9YkeCXRxWvH4KAKzMD1UIpo845XvxSWbdAc1AYyqjPphH
 eNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779141336; x=1779746136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+gqkVHvkcnTU00egED2DbtTVbGYnjLd1xjREq6pzQmI=;
 b=eZGlyDh3oI+DeNMnAjVYM4tv8ZpgPuBSgo2ZTxSVfAL1LP7oX8cjsJDUBxLXGHzD7R
 jwNHVS+EmfOjkOJ0ZAprF9L/deyM+EzYnJyTYFATUgkg/o39PSXj4vkYo3b8uJzXFr7A
 wSwjWrwnYQJBdpMKdlq9sDMNiHLl4t4e36fjIc9E+RXnFShp8Blek2avuRtXKp+VSB3b
 T/Cckh9b+R97MNvqfvNAp9w0qo6l4osjPK4Fd2LtIGmYaplIVwU+tKHJjEcTyho4iC/3
 CzIVszhwaxYiY7+MZNOwwC1xgGlGjE0Th9+pEL27g/Mdj2fcd8S76lZ3A46iQPOkNYpQ
 EVYw==
X-Gm-Message-State: AOJu0Ywo4FqWqcwgKXo6z7K51PrbC544ESIAgsep1RzriGeGEXSJwVih
 syX6uKBBUFpaXQoLOjbAYbv2X+wkzu24un6y0HK1+2ksjFKxnzfaLTr0Yz7fTA==
X-Gm-Gg: Acq92OFbltG34kcgOi1zoN02l+96/guDs2QkbCk5XKsCNOA+r1qm7VMWeJjfY+VjYCF
 JT0fHH4ZNSCGiIFDNhatBLOlpcfByHcsVGaci+U0xfSEZkJ0bhyKLzTU2jzqO7siLhAO2R5ml2J
 8VL8EHYCpBeWKskvjBMsE58EhZTy+3mLxz7qtDKAbwcnOjE/zUmg4Tpr/dCCCNRqHdeq1KMKlbT
 4IpqyA4xK3CeyWaOcIK1oJxvlVBMQ2lNNGsFuO0e25YknmqY3W5GmMXMDSj3Hu0nMIDT0+6Q4oq
 VGp/nARpIMU1g4SIX453GJdNpt20Ky/pRxOLQBoW/F7umpdWKceRIgJS3s/9ot+P5oBTS0MdFb5
 J8qd9jHr84ByRbAt1yJduAIU5IG+W69pNlCf4IbJkRcumhhlQeARIBVqtixz1jwM/9uveU9a1+G
 hjCaqFNDH8rFxC8X8m70k5QGCdeFEBEeulM6VcItfnvpjZcZE91/vZ+yTbUTUOhWIj1E8=
X-Received: by 2002:a05:6512:1193:b0:5a8:fc93:85c1 with SMTP id
 2adb3069b0e04-5aa0e73c325mr4893610e87.32.1779141335742; 
 Mon, 18 May 2026 14:55:35 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395882c3928sm15158541fa.11.2026.05.18.14.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:55:34 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: brian.ruley@gehealthcare.com
Cc: u-boot@lists.denx.de,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 2/2] imx6: guard LDB clock init with appropriate video config
Date: Tue, 19 May 2026 00:54:45 +0300
Message-ID: <20260518215445.175753-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260518215445.175753-1-shofiqtest@gmail.com>
References: <20260518205734.163815-1-shofiqtest@gmail.com>
 <20260518215445.175753-1-shofiqtest@gmail.com>
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

