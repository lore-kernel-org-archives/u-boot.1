Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC81C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA50584B65;
	Tue, 30 Jun 2026 14:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4S8sHi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57CAE84A52; Tue, 30 Jun 2026 14:39:59 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A7C884A3E
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 14:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-39af87c4589so35492301fa.2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782823195; x=1783427995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38gOmVfQ/a4DMRrPPU3qnXQ1b+UxHoO9LOv9S+wuLXI=;
 b=D4S8sHi7KJzlN0vI4kYMZy4P3g3N7/5xFOu3+W/ToalBKniRMpT0wRg2j2DRPJ3ORS
 q9ccSeZQwqRhBf+87gnMhPN3EsYc08tWl1d0zUQhENtUivCyX8ZtzAawGO+Ubvw3SmHc
 599aGdIBq7gqLy1+5M92crRFeKtuKZr/gpoziVW4xKphKE6ahhVsfAU9E4V16nKYSrRB
 yx2SW5HtpDXjIwi0HCLVI1CastmfigQBCJeuOTLQD+xETfa1Xu7oDILNtsdVRJfSjWfR
 pVsVcqali0VkdcDHKJHRAwilqZNvMz1Cwb5vdlaFmXrsbub/Swueb5/18E9mDDoN1q3/
 9y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823195; x=1783427995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=38gOmVfQ/a4DMRrPPU3qnXQ1b+UxHoO9LOv9S+wuLXI=;
 b=TUtA8MPJaNOkrJJ2fBz6Q6CrZ2a6k4khlxSm9Ppvl9+9wJUcOynLq2etjKVqd4ifHH
 jVq76oHUSakfsGg/SuNAD8V6W/mzCIBAScceOUc82uUPSsAW3VA9j5GrOsYXDVI3xQxO
 UvQq8WoIhyIzNEM39tCWB2QqNXUquHndtWu5kQhfZjOxFrup67pUlDMeTNPOm6xFo75a
 WxOYBi/yG3dcfMIWif1WBsY4vIneOCYhjASN4Ro2+MMJCB5bxDAPHN8rekIRweyWFGDY
 DSsV0ZYX6CygjGIiZi98FCWZCl0d147iu8r2Z8cr/WT32qpdXDLgWs9AACrdeChT/OxY
 xD+g==
X-Gm-Message-State: AOJu0YxLDTQwdAf3Myiglji0MoWPd3ADblvKnQt0Q00oFsUokQ9TBImc
 my7122mdD91DlQd64TcXjTC8ojWsKuXQEszSzxPrPC/yLVrQ8/JxjQuCBfRkkuZllDFGTg==
X-Gm-Gg: AfdE7cnFGgz3BaeG03D7vgDZNwXZdnkCtqdqa5AjERZTFcjjYhD1qUq+rOnTwM2sq8D
 K3pzHJbLohE6P2kfFEV5PIv03BQELTdOL7QxToeD8TnWUUnHoIbJ3L443CDweP82EXh+po+RKo5
 EHXCGFE1lApkq0by4JrEEpqmNGynKZpNW7yXRJ58EKPUWKngBdPVC4PC2xhkGhqGOM3J6LPyXc7
 TV456Y6titaaadmjBWv0Kg7r0kBjFpFZGYBunLdMEQjFnZUl8SePyezvPu4GLrr84zYjhX5+ikH
 uz3rd4J83kJZRwRE11Z5iBS73p9Aja6OGYZ2jCnE40revBPDV6X4dvhDaRdNstJ5+dGOiMw3Tj4
 SGtxH5R6gByW4ucx53nfApXw6+VbzFl2+XA/kMSRrzu8yTyM9NCHRr73RmdumTeeeg3h8MJdpZ7
 3C3xc9HcXNrQvFqcHum07hVHxKxCyslkI6jVPAUmYQ+AQYB9ANSN3eWVaA
X-Received: by 2002:a05:651c:992:b0:39b:185b:5401 with SMTP id
 38308e7fff4ca-39b1dffd670mr7690561fa.37.1782823195267; 
 Tue, 30 Jun 2026 05:39:55 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b1da4ca90sm4905721fa.31.2026.06.30.05.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:39:54 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: u-boot@lists.denx.de
Cc: ian.ray@gehealthcare.com, HuanWang@gehealthcare.com,
 brian.ruley@gehealthcare.com, martyn.welch@collabora.com, hs@nabladev.com,
 lukma@denx.de, sbabic@nabladev.com, festevam@gmail.com,
 Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 1/2] clk: imx6q: guard LDB clock init with appropriate
 video config
Date: Tue, 30 Jun 2026 15:39:50 +0300
Message-ID: <20260630123951.13385-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260630123951.13385-1-shofiqtest@gmail.com>
References: <20260630123951.13385-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

Guard calls to select_ldb_di_clock_source() with the correct video
Kconfig symbol rather than the broad !CONFIG_SPL_BUILD guard.

SPL can support VIDEO, PANEL, and SPLASH_SCREEN so !CONFIG_SPL_BUILD
excluded SPL builds that legitimately need to configure the LDB clocks.

- board/ge/b1x5v2: guard with CONFIG_SPL_VIDEO — LDB init is needed
  in SPL only when display support is enabled
- board/aristainetos: guard with CONFIG_VIDEO_IPUV3 — this board does
  not use SPL so CONFIG_SPL_VIDEO is not the right guard here
- drivers/clk/imx/clk-imx6q: update both the definition of
  imx6q_init_ldb_clks() and its call site to use
  (!CONFIG_SPL_BUILD || CONFIG_SPL_VIDEO) — the function is needed
  in SPL when CONFIG_SPL_VIDEO is set, and on all non-SPL builds

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 board/aristainetos/aristainetos.c | 2 ++
 board/ge/b1x5v2/b1x5v2.c          | 3 ++-
 drivers/clk/imx/clk-imx6q.c       | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

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
index a4649a1a9d9..5be303468a9 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -156,6 +156,7 @@ static struct clk_div_table video_div_table[] = {
 
 static unsigned int share_count_mipi_core_cfg;
 
+#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_VIDEO)
 static void of_assigned_ldb_sels(struct udevice *dev, int *ldb_di0_sel,
 				 int *ldb_di1_sel)
 {
@@ -270,6 +271,7 @@ static void imx6q_init_ldb_clks(struct udevice *dev)
 
 	select_ldb_di_clock_source(ldb_di_clk[0], ldb_di_clk[1]);
 }
+#endif /* !CONFIG_SPL_BUILD || CONFIG_SPL_VIDEO */
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -488,7 +490,9 @@ static int imx6q_clk_probe(struct udevice *dev)
 		 * Need to set the clocks now and make them read-only due to a
 		 * hardware bug. Fixed on the i.MX6 QuadPlus
 		 */
+#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_VIDEO)
 		imx6q_init_ldb_clks(dev);
+#endif
 		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
 		       imx_clk_mux_flags(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
 					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
-- 
2.51.1

