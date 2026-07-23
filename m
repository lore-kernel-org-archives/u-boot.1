Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BFAC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 17:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7110E60AD8;
	Thu, 23 Jul 2026 17:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jShNOTq4uqsV; Thu, 23 Jul 2026 17:37:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A5CF60ABE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784828248;
	bh=CHaI/tqqREe47a7Q47dEK1sWWeF7ypGS8ImD27EHe3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O2f+PqoF1Ui8LSPyc/WCQKYo4jWFeC6HlgOnOtJJG1WNLes0O1LoKPCSo6gaJS9hI
	 3dFVoIC+WdEwfH10OCAUs1O7ZSH6s6rFoGh+y7qlNTAhlsIVm2Q5U9FFUEppXHpaXN
	 CvkPVPGolHGV9TjntZrsvO4y1Is+R/okenLS+w+qqO6kD0H+47X+8Z+shgBsnwMiyI
	 7JyUdU4f0nQ6UYTMY+TjGWB4OQD2402nMjV1qFjjCHYB/I1Xg8vrG/PjC2wScHdU19
	 01e4lXHMd83/+pPgoyFxBd30SqiqLNqYGzTgs1z8g3PWtP+dMv+6t0BvxWKxkshxq5
	 YqIBQ87qngpfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A5CF60ABE;
	Thu, 23 Jul 2026 17:37:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 55D7E96C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BEAA60AA4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rP-ac6iMMYBp for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 17:37:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=andreas.zdziarstek@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5AA0660AA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AA0660AA6
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AA0660AA6
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:16 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-495437bb891so7687445e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828233; x=1785433033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CHaI/tqqREe47a7Q47dEK1sWWeF7ypGS8ImD27EHe3w=;
 b=nOXW3OS1A3JJQdaFN14giOq+9JnNg3jsDwxNc/0eO0U5AhicKWHLNUYm1BorpNkfjN
 gp6SZK2DRzJZBYHF0TjIEi+ZVEw72Tw1WVQ2zCTcKQQbDq6nl83RuevsQ1U3XiQ+D6dQ
 PVqcpCDNnpiPjQ8/7+zr/FAZS1lTPfuD4z9vY6P+m+BT15Ai6+gzcfsET3P58qN+xB7J
 ZPbA1FE2Td/SiEraF3dKnIuvSpa9TLQfSSG+GgTVuBs0J/O4zFpQhhri25ydaUnsj8OJ
 hz+UJtM6KvSZ0obyBs4LgWyekQmyCbMk7V24O43yZZFPukPBLUy8RqOZuYP+1+RW5b1p
 z72w==
X-Gm-Message-State: AOJu0YyNRuEots1Rxq9BsBJRDD7s1sUnPNCIfdJpyrcdLvvK84MX8f/c
 6/oMqdjCi77lGcYBzMjp13gLl4mC1rS5o6eu+5Lob8gghEqbGCVP+PK0lx8Pt2WW
X-Gm-Gg: AR+sD13Pp9XiZbUMwgj8qAbxvzFZODu7ZAEQb9nPUOD3OyYRULKCLIndX0OdkaP20pz
 9+g8XeMhwjS6NbV9aG+ZJjAl96o2fYlNt1i2PvSv2B9CHTaEFAozpIO7VgWxZiS9EYrQgUQzTG0
 Ouf8xvZaICpzAgZ31L4yYw4/ncHm1OdorUV2m6TdJHbuig3lejsoP4EOF7K8Qv94xiWEYVge9sS
 Exll7PZjOB1sBXNlOxB6wpasXwEcfwlFSZvuAU7YU6PBnZjyVEbaCeI2njcz5ttnMbXv+wu/ygU
 kqp5JqVh5eZg4lxIySQNCzqdrqG/mvTCdoy2N0bBUN4kI33fEAi5PXrI34WGuET94aB9/Z3QTEa
 IIEZWIbzjYrTMaN2SKyxxPbDyrrpxJaGR+O8C5G5xF/VQwnI/+fgFuwSO4f5Q1dZvQgfRh7YVok
 JsJ1ZSad3smHjAvoNu+WgftvEi1+/DB/T1diltmLGI4+rQwtQJhB9/ACQfaSj7nXw=
X-Received: by 2002:a05:600c:1c1c:b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-495745ac487mr42173505e9.17.1784828233100; 
 Thu, 23 Jul 2026 10:37:13 -0700 (PDT)
Received: from turbine.fritz.box (p5787a491.dip0.t-ipconnect.de.
 [87.135.164.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af914a9sm8497645e9.15.2026.07.23.10.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:37:12 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v5 2/4] rockchip: rk3568: make the TSADC trigger a first
 global reset
Date: Thu, 23 Jul 2026 19:36:42 +0200
Message-ID: <20260723173644.234688-3-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723173644.234688-1-andreas.zdziarstek@gmail.com>
References: <20260723173644.234688-1-andreas.zdziarstek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828233; x=1785433033;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CHaI/tqqREe47a7Q47dEK1sWWeF7ypGS8ImD27EHe3w=;
 b=jn2shPUnB5++d4oFWsMYB3S7DRgIy3WjJ+BCPdYGn3N80vqO962m6jGeEA0D0bUvmk
 OC4sH/2MNxDMi+hehV6xiGbCf2YoPZb4FdpLRsCsZ5lm39gf0a19eDOG+6dJrhEqVBp2
 6XRTA6Di5LPSaRrsiUw8T/ICX25yb/AfFN//cAgDTWf3jGaVmUjw3l8yCp16amfgThMm
 znv8PtK745KNgkSTg81Kns9BfFiHcByg07in0AzLOuK+3HoRD0k2uwdyhHuqASQVNd3s
 mmqRvZK0DFtCRbD+tzgjS2I1uBqxNvJIirfTwdFus8WXId7Tayu2fQBYLwSUMEn/WHRl
 uStQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jn2shPUn
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Same rationale as the watchdog: the default second global reset leaves
the SoC hung. Set the TSADC to the first global reset as well, so a
thermal shutdown reliably resets the whole SoC.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 8bed529a5c1..5e6f79450db 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -40,6 +40,7 @@
 
 #define CRU_BASE		0xfdd20000
 #define WDT_GLB_SRST_CTRL	BIT(1)
+#define TSADC_GLB_SRST_CTRL	BIT(0)
 
 /* PMU_GRF_GPIO0D_IOMUX_L */
 enum {
@@ -152,8 +153,9 @@ int arch_cpu_init(void)
 	writel((PMU_PD_VO_DWN_ENA << 16),
 	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
 
-	/* Make WDT trigger a first global reset */
-	setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
+	/* Make WDT and TSADC trigger a first global reset */
+	setbits_le32(&cru->glb_rst_con,
+		     WDT_GLB_SRST_CTRL | TSADC_GLB_SRST_CTRL);
 #endif
 	return 0;
 }
-- 
2.53.0

