Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9B9CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 13:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DABA83938;
	Thu, 14 Aug 2025 15:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LP/HjRhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E08283948; Thu, 14 Aug 2025 15:13:23 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDBE2838C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 15:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-244580523a0so8122415ad.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755177199; x=1755781999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nv35lMOhoAariR0X8Fdjht90eqjVk/lH3Qtpep9d5lc=;
 b=LP/HjRhZA2kBm5DsLqelhPV8+sR35BHO454R5SUIKtWofJrTELGhCS0+8hESmnarSS
 eCy7sHx2yga42fEeIuAB0gm3H2zaSrIKYPhhvh38+B+lyZ0XefUzfoBH/6ClO5yAvopb
 Ud/RRBUs5DbKHhtHXYUT/x8ZBdySpWnzdi4U3R1pZWhRhtTkVdXEzlco4cjg5E1GhpA9
 tOPbmGWDN/6JuXAfSRuLZphfNzG8ZHXdJin/FtuWDctsY304eWqguakSrJ6p+C2aHlDA
 P4bSzlmYkPoF2EzHnsSgzEZ15eW/t90qOWYvAVfiNYRgWoANTsuEbDIlY43dQ8GcJxWz
 UUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755177199; x=1755781999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nv35lMOhoAariR0X8Fdjht90eqjVk/lH3Qtpep9d5lc=;
 b=htjdWB1/0p6hYXpVOGDT1G2OXgcciMhV5wAzaQH4YLCKa3Z8+lZQPt1QMWMWEpda+h
 qvOm5yaqSQcnDX2QwOmfql/NnEfrQYLTIW/HctrAE3HGN1ek8ozQkghLnXTMk92IpgTB
 Ox1DVXzoVEaTFcWIFd78vcTWYpE0h5AzL/3qqCwLoSWkbnkSYvqRJQiK7pewltoa+MYm
 2DmjM9qPaYFIpuHEJN9B8ty8o1q8HP4ClOHaQvYk58uhYjNy8igxYx8uwGAcxbqM6zzz
 Q9JnwiEL/CtdBY9F+/vE1jphQqyPzKlLigSO7NFzUuSyFLVENgI8QJk4p+/5Zt4s4xOH
 sT5w==
X-Gm-Message-State: AOJu0YyaTwl2aO6MQBKsAFv5QDxSSrLBYcjjqYa9vOq1p8iF0VABwKOm
 IBtDJPsszCnnafmzAfHbIjUD2zCrjT9kCh2E1t+R2HCOD8PkWmO60Qo8Z4etOP7iNQvSbrXk
X-Gm-Gg: ASbGncuUDQBFkKUh7WQ7NRe7+NyVRpF7zFSofcKD4W4jyan5x0ujbu9H0Grk42w6g+y
 zx3E+51lqm0xXmpmMd4YRSLAyMkag8WpbE+2vgovizYp1pHBpcnfwtDaY2W/aS9x/fcqArRT3k/
 7s+QciS3TMdbjOU9DjtzKb+SqIGMfGxiZm/L79h+gCq6xKIdaMAsuGc4DPRNY73fpW/l5+H0J4C
 PM6q5KF0KPLEKEesKzqIt1VuWvD6lyRlBCf71BA/i5j4U5cdToNuKp4VA0L5yoh5yJeG+2Lpzoh
 Um1O7j6Grxm2GGjANkOCrsBtE8q30cs2Tvt2lxqTr3vKf5MZ1Xaqbe8r43xHhZoqRrasufE5xjQ
 pC9k9FeJr0UESJkz2RFPNuMgzXSVrd8EEN8L9rQ==
X-Google-Smtp-Source: AGHT+IGbxEZZU/lvOURGyJ+SG741VmO16OOKPU2yeIcyjSPOzIv4C0MNPdArTDHkD8c7SBQKzmVLjg==
X-Received: by 2002:a17:903:32d2:b0:234:8ef1:aa7b with SMTP id
 d9443c01a7336-24458a4c885mr42704635ad.20.1755177198972; 
 Thu, 14 Aug 2025 06:13:18 -0700 (PDT)
Received: from localhost.localdomain ([104.28.159.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24300f8c9d1sm67902195ad.129.2025.08.14.06.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:13:18 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 ag.dev.uboot@gmail.com, muratdemirtaseu@outlook.com,
 WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH 2/5] clk: rockchip: rk3368: add SCLK for mmc clock get/set
Date: Thu, 14 Aug 2025 21:12:34 +0800
Message-Id: <20250814131237.8135-3-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814131237.8135-1-cn.liweihao@gmail.com>
References: <20250814131237.8135-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
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

Because of dwmmc driver get clk form a fixed index 1, so must add
SCLK_SDMMC and SCLK_EMMC support to make emmc work.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 drivers/clk/rockchip/clk_rk3368.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 994330162..f9936fb40 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -165,9 +165,11 @@ static ulong rk3368_mmc_get_clk(struct rk3368_cru *cru, uint clk_id)
 
 	switch (clk_id) {
 	case HCLK_SDMMC:
+	case SCLK_SDMMC:
 		con_id = 50;
 		break;
 	case HCLK_EMMC:
+	case SCLK_EMMC:
 		con_id = 51;
 		break;
 	case SCLK_SDIO0:
@@ -262,9 +264,11 @@ static ulong rk3368_mmc_set_clk(struct clk *clk, ulong rate)
 
 	switch (clk_id) {
 	case HCLK_SDMMC:
+	case SCLK_SDMMC:
 		con_id = 50;
 		break;
 	case HCLK_EMMC:
+	case SCLK_EMMC:
 		con_id = 51;
 		break;
 	case SCLK_SDIO0:
@@ -559,6 +563,8 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 #if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 	case HCLK_SDMMC:
 	case HCLK_EMMC:
+	case SCLK_SDMMC:
+	case SCLK_EMMC:
 		rate = rk3368_mmc_get_clk(priv->cru, clk->id);
 		break;
 #endif
@@ -597,6 +603,8 @@ static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
 #if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 	case HCLK_SDMMC:
 	case HCLK_EMMC:
+	case SCLK_SDMMC:
+	case SCLK_EMMC:
 		ret = rk3368_mmc_set_clk(clk, rate);
 		break;
 #endif
-- 
2.39.5

