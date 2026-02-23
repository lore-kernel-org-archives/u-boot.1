Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ED7EEC2AD
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 23:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502A383E7A;
	Tue, 24 Feb 2026 00:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VMh+srd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8116483E63; Tue, 24 Feb 2026 00:22:58 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E404083981
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 00:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4c65d772cso4504167a34.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771888974; x=1772493774;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Je8EkzwPo6AV23RfyCfQd9EFXqfyp7/wP+eFgXujTaE=;
 b=VMh+srd1hkeYoMxmp+83oaV/My9LycP/YAlQBPtbo5s8MV9dbbSEqAY9ue/5fe529+
 FkTfNRq+GPEkIveYD74u6+mhL0XM55yq6kicPs7Zv1Kph8nb1zYnlVFSukjjedjXfD3F
 9+fLFv+A58bZoWq+Pq7bnP8T8RsWSpASXJG3LtHuQEGsG22YNgEBddVcjGDwLguciVgg
 viAmV6TnmQSWEp89pamkzcPhlWouaiGBZCDazuOpMnQ0s6Eq6i52biagmQIWhN2BjKEm
 2XWJN6kunMmcmnOAFaMDoPLs+u9Zt8qn34IEB6HAydoJ/90OFFvgJ8leVuRrdK4aEXFW
 b3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771888974; x=1772493774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Je8EkzwPo6AV23RfyCfQd9EFXqfyp7/wP+eFgXujTaE=;
 b=q+1cYPFYchzfB/4KGe2qBx5FYVCbDXx5xYVeeCXnSTwO945hqrRdv411ale2F2ytfr
 lJyd6PEHABIrAipeV4SitppAnEdZ3uz0Amg5Ldl+jkh4RZJHiYfRvrpd1/m8Err46lGS
 WLDGBiS7yIsXZ74FNhJtM7myzLvbY9EkUtIg0gRnW5mgXOdsK/jhMdZKKHY10V3uD5ls
 8+3FSVsafD7Y9O66oUgBjZsnT1GpemSL96Hb4lhuVVpb4h4J9KaA4RLWuKJOr5MzWGAF
 bPmEUlzdbeFY3HTE31dub6/DSWcKrH7naJSzJnT1HDgcFSoLeNYahjbDSP8M2sYB9pT/
 Xgcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMcGIQnfp/RVLsmkrGDjYxcudanNY8X3+xqj9hay96lHdvlImkR96lclmuc61wV9L0pJvgu9U=@lists.denx.de
X-Gm-Message-State: AOJu0YxwIGZ6Hv/giLN+Bf7KCEp5aYYG33UU5FyUajtakiA+W2Co4/BE
 e7XhNqTiNzUEcfcQLMWkfKLRzbXfjRhdyUf3m7M5BxS7ucAvWBbPq4hA5waK1ommFyM=
X-Gm-Gg: AZuq6aI6wOpd+EtLjJ65LGXUFiWLfsooVZZL2ianH56MbNzgOqtBLi5D1f4qKhg+YU6
 we35x0cepZzPX/nXeLIzwWWDF6X42gh0rdmkhpPfJq5pZ1MDxrnQhpTsA2gfH5GUOR6UhUGgBMr
 q91v0JitlykLygzCDi+Lum6PPEW9kyDHaEJZxx3xAvTTMR5y1G+3uPktfL++qaT8sPEm6T8VXj6
 iKsjMgB2oxkZpTJ80VPwz+QPya8CVqabCp/Cm/nKfUtXN6Ky/amF0skSGI4JhgCLh8fHoPdlGWt
 WzTSULB3WNgG0zklgLP6Ckv07N/Wss4K2tjc0dgnLhNum3VtEVBsxXxI8DY3MVsW/SeKkSrSgo8
 8IY4b94+Sz+RkHXOe30C/uD0xL+0r7aG+2H69ZY4idWJyvc20wxeui5dOF2YLSaUcg/Z0LYaf7D
 mnleWD55AO/3ve5R7nCx36xVh9xyc4
X-Received: by 2002:a05:6830:82cd:b0:7cf:d1f0:63e2 with SMTP id
 46e09a7af769-7d52bf9c367mr4872931a34.19.1771888974666; 
 Mon, 23 Feb 2026 15:22:54 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cb87:475c:5c04:ac92])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm8911230a34.5.2026.02.23.15.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:22:54 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Feb 2026 17:21:56 -0600
Subject: [PATCH 4/7] clk: mediatek: mt7622: change to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-4-a7dc97bc2660@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13546;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=73y86bcnBltq/CJHa35nzLPE7h1pKl3eDQ4oWbC1zbY=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpnOEuhl+z9fjUCOed9NoqXvOi7VuuOldIjO2Ez
 Fnl2DzMpG+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZzhLhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AyQEH/3wWtYfYZdf3Cbcl7iqC6LKQ9/R4Y+v9Z0zSypl
 6rAwcd8UmKx8nDFw7UkYCf1fG7RK0BUtFIxPrdfLhVx0OJNBn9fsVTzRBVcnGLStq3zs6QyEWIG
 VdYiJyy0qodH5DLZwtWHNGhW7PVQzkzZ9a8MrPp1BP7JLyZPJYmsj33Gra5KKue6ySuKCSx4lDN
 wk9U6v9tKBoe7xMGFkRPeM9YXh/NJPIg8x2TzAdp01jU3Vl7O/JrTrsi//OojodPv0APLehtaas
 oxhpjJ4I3V8k1T9L+D3XITJrudKXH1zoH7u/A1FkDlMUndjL3haqKrbmxreP2J5zG0gzt18dx+M
 XNYU=
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

Change mux parents to use struct mtk_parent instead of int. Since these
clocks have mixed parents, we should be using struct mtk_parent which
specifically handles this case.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 330 +++++++++++++++++++-------------------
 1 file changed, 167 insertions(+), 163 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 77f3a9fc3d3..e420be5a137 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -159,231 +159,235 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_ETH_500M, CLK_APMIXED_ETH1PLL, 1, 1),
 };
 
-static const int axi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL_D7
+#define XTAL_PARENT(id)	PARENT(id, CLK_PARENT_XTAL)
+#define TOP_PARENT(id)	PARENT(id, CLK_PARENT_TOPCKGEN)
+#define VOID_PARENT	PARENT(-1, 0)
+
+static const struct mtk_parent axi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 };
 
-static const int mem_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_DMPLL
+static const struct mtk_parent mem_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_DMPLL),
 };
 
-static const int ddrphycfg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8
+static const struct mtk_parent ddrphycfg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
-static const int eth_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	-1,
-	CLK_TOP_UNIVPLL_D7
+static const struct mtk_parent eth_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	VOID_PARENT,
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 };
 
-static const int pwm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent pwm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int f10m_ref_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D16
+static const struct mtk_parent f10m_ref_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D16),
 };
 
-static const int nfi_infra_parents[] = {
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D4
+static const struct mtk_parent nfi_infra_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 };
 
-static const int flash_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D80_D4,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent flash_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D80_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int uart_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent uart_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
-static const int spi0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
+static const struct mtk_parent spi0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int spi1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
+static const struct mtk_parent spi1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int msdc30_0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D16,
-	CLK_TOP_UNIV48M
+static const struct mtk_parent msdc30_0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
+	TOP_PARENT(CLK_TOP_UNIV48M),
 };
 
-static const int a1sys_hp_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUD1PLL,
-	CLK_TOP_AUD2PLL,
-	CLK_XTAL
+static const struct mtk_parent a1sys_hp_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUD1PLL),
+	TOP_PARENT(CLK_TOP_AUD2PLL),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int intdir_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL_D2,
-	CLK_TOP_SGMIIPLL
+static const struct mtk_parent intdir_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
+	TOP_PARENT(CLK_TOP_SGMIIPLL),
 };
 
-static const int aud_intbus_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL3_D2
+static const struct mtk_parent aud_intbus_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
 };
 
-static const int pmicspi_parents[] = {
-	CLK_XTAL,
-	-1,
-	-1,
-	-1,
-	-1,
-	CLK_TOP_UNIVPLL2_D16
+static const struct mtk_parent pmicspi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	VOID_PARENT,
+	VOID_PARENT,
+	VOID_PARENT,
+	VOID_PARENT,
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
 };
 
-static const int atb_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5
+static const struct mtk_parent atb_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 };
 
-static const int audio_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_UNIVPLL1_D16
+static const struct mtk_parent audio_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D16),
 };
 
-static const int usb20_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_XTAL
+static const struct mtk_parent usb20_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int aud1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUD1PLL
+static const struct mtk_parent aud1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUD1PLL),
 };
 
-static const int asm_l_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent asm_l_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int apll1_ck_parents[] = {
-	CLK_TOP_AUD1_SEL,
-	CLK_TOP_AUD2_SEL
+static const struct mtk_parent apll1_ck_parents[] = {
+	TOP_PARENT(CLK_TOP_AUD1_SEL),
+	TOP_PARENT(CLK_TOP_AUD2_SEL),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
-	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
-	MUX_GATE(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
 
 	/* CLK_CFG_1 */
-	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE(CLK_TOP_F10M_REF_SEL, f10m_ref_parents, 0x50, 8, 1, 15),
-	MUX_GATE(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
-	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_F10M_REF_SEL, f10m_ref_parents, 0x50, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
 
 	/* CLK_CFG_2 */
-	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
-	MUX_GATE(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
-	MUX_GATE(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
-	MUX_GATE(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
 
 	/* CLK_CFG_3 */
-	MUX_GATE(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_0_parents, 0x70, 8, 3, 15),
-	MUX_GATE(CLK_TOP_A1SYS_HP_SEL, a1sys_hp_parents, 0x70, 16, 3, 23),
-	MUX_GATE(CLK_TOP_A2SYS_HP_SEL, a1sys_hp_parents, 0x70, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_0_parents, 0x70, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_A1SYS_HP_SEL, a1sys_hp_parents, 0x70, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_A2SYS_HP_SEL, a1sys_hp_parents, 0x70, 24, 3, 31),
 
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_INTDIR_SEL, intdir_parents, 0x80, 0, 2, 7),
-	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
-	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
-	MUX_GATE(CLK_TOP_SCP_SEL, ddrphycfg_parents, 0x80, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_INTDIR_SEL, intdir_parents, 0x80, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, ddrphycfg_parents, 0x80, 24, 2, 31),
 
 	/* CLK_CFG_5 */
-	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
-	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15,
-		       CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
-	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15,
+			     CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
 	/* CLK_CFG_6 */
-	MUX_GATE(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
-	MUX_GATE(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
-	MUX_GATE(CLK_TOP_IRRX_SEL, f10m_ref_parents, 0xA0, 16, 1, 23),
-	MUX_GATE(CLK_TOP_IRTX_SEL, f10m_ref_parents, 0xA0, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_IRRX_SEL, f10m_ref_parents, 0xA0, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_IRTX_SEL, f10m_ref_parents, 0xA0, 24, 1, 31),
 
 	/* CLK_CFG_7 */
-	MUX_GATE(CLK_TOP_ASM_L_SEL, asm_l_parents, 0xB0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_ASM_M_SEL, asm_l_parents, 0xB0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_ASM_H_SEL, asm_l_parents, 0xB0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_ASM_L_SEL, asm_l_parents, 0xB0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_ASM_M_SEL, asm_l_parents, 0xB0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_ASM_H_SEL, asm_l_parents, 0xB0, 16, 2, 23),
 
 	/* CLK_AUDDIV_0 */
-	MUX(CLK_TOP_APLL1_SEL, apll1_ck_parents, 0x120, 6, 1),
-	MUX(CLK_TOP_APLL2_SEL, apll1_ck_parents, 0x120, 7, 1),
-	MUX(CLK_TOP_I2S0_MCK_SEL, apll1_ck_parents, 0x120, 8, 1),
-	MUX(CLK_TOP_I2S1_MCK_SEL, apll1_ck_parents, 0x120, 9, 1),
-	MUX(CLK_TOP_I2S2_MCK_SEL, apll1_ck_parents, 0x120, 10, 1),
-	MUX(CLK_TOP_I2S3_MCK_SEL, apll1_ck_parents, 0x120, 161, 1),
+	MUX_MIXED(CLK_TOP_APLL1_SEL, apll1_ck_parents, 0x120, 6, 1),
+	MUX_MIXED(CLK_TOP_APLL2_SEL, apll1_ck_parents, 0x120, 7, 1),
+	MUX_MIXED(CLK_TOP_I2S0_MCK_SEL, apll1_ck_parents, 0x120, 8, 1),
+	MUX_MIXED(CLK_TOP_I2S1_MCK_SEL, apll1_ck_parents, 0x120, 9, 1),
+	MUX_MIXED(CLK_TOP_I2S2_MCK_SEL, apll1_ck_parents, 0x120, 10, 1),
+	MUX_MIXED(CLK_TOP_I2S3_MCK_SEL, apll1_ck_parents, 0x120, 161, 1),
 };
 
 /* infracfg */

-- 
2.43.0

