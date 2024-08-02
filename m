Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A84C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23EAD88C6D;
	Fri,  2 Aug 2024 21:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gyDVa32y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86AA488C19; Fri,  2 Aug 2024 21:56:38 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B3A088C5F
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42819654737so51660415e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628595; x=1723233395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IimY4Kn/j943kf0c7nLQKNaoSrHF5wWXyxU22DJHe+k=;
 b=gyDVa32yOw4ESf4ABtj6T1zmUpg6sQGIELj7v0o526LWnXuc7TfQx218+2QsPFei+1
 kT+OLrIPKu4Qpb3hICMnuXgC+Dja+J7U3PcSKu0dVG9fxkf90svrna0Kmq/XZMDhnRyg
 R4aOlZJuUNTjcRuq6l/5qIkKTbT8ZmqzdvZGsEHU3Lo3kl5TMIy0gGM/x1Wp+Uvzzkdo
 sgBuyqZgOzyuvgkTu7fbI9UwCa/dL5Ly7cvTdkMeZpf2G97IhYFmfA9nDaVC7qi3uBXd
 sC40DqholDgZT6XmJB5AnaIvQoOLGWgVGi4xykA1a+plZ8YslXKu63NcB/gORTzmwJmh
 t9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628595; x=1723233395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IimY4Kn/j943kf0c7nLQKNaoSrHF5wWXyxU22DJHe+k=;
 b=w6Ag9jXdyW2wLoR+eHl53D0k7VE4M0Pl5Q/T7cXyvBnGhziV6/+ZrRkUgpGpUtND5W
 sWHQt0Nm5kc2UBFTm+LZ8k8HPTu7Jx8a4V/BOWHuGCCQbOrSBuQCy9B3fbtUfm2+vQyW
 IvSujhqC8vXdizBIn/59QHc+1Ij6zC6OWqWD9SHrwoxD9Mcf9cNvjSC9alqqc9Xsax5K
 dFf+5C4BDb2J8aXCl9xdZ1ylM1Rk8mR2zmWA/gdOds7WqXKnQN/HKp20ctADc7pLsey4
 K9EibgpPT//oefoFN91dcrliIh2XKclpCM3Suw/8IR8W6A4lambtQO0TXmluUE9RQQPB
 zckg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3a/iMJ6wWpDyv3oBONl1h+ONox4DH9E6bjncEbRZbX0/AO8GbpSNd9x9RfJeR27tnrCfRwwZTanGLpdBEL97psQ8B2Q==
X-Gm-Message-State: AOJu0YzY+DSig/ETcvaQ/3QCiimShgkrBckkyXv5HtNcU7T2WdGLCHAI
 uPhtkKojsOu1vvB2RH6znYKu9OA1XXLQEljENZ0qcjl5V1LoKGwN
X-Google-Smtp-Source: AGHT+IHK8STvacJ2QEYYfrpYi1vK1LcbbDp6VqgpQyB6J1SOWLi6Y9imyGzRo8vD4ZPKY7YlGIhBmg==
X-Received: by 2002:a05:600c:358e:b0:426:6876:83bb with SMTP id
 5b1f17b1804b1-428e6b31fbamr29626585e9.17.1722628594918; 
 Fri, 02 Aug 2024 12:56:34 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 03/14] clk: mediatek: mt7981: fix wrong mux width for pwm2 and
 pwm1 clock
Date: Fri,  2 Aug 2024 15:53:04 +0200
Message-ID: <20240802135326.25303-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Fix wrong mux width for pwm2 and pwm1. Upstream have width 1 but U-Boot
have width set to 2. Change the value to follow upstream implementation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 69d018b817a..6e770de99cf 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -404,9 +404,9 @@ static const struct mtk_composite infra_muxes[] = {
 	INFRA_MUX(CK_INFRA_SPI2_SEL, "infra_spi2_sel", infra_spi0_parents, 0x10,
 		  6, 1),
 	INFRA_MUX(CK_INFRA_PWM1_SEL, "infra_pwm1_sel", infra_pwm1_parents, 0x10,
-		  9, 2),
+		  9, 1),
 	INFRA_MUX(CK_INFRA_PWM2_SEL, "infra_pwm2_sel", infra_pwm1_parents, 0x10,
-		  11, 2),
+		  11, 1),
 	INFRA_MUX(CK_INFRA_PWM_BSEL, "infra_pwm_bsel", infra_pwm_bsel_parents,
 		  0x10, 13, 2),
 	INFRA_MUX(CK_INFRA_PCIE_SEL, "infra_pcie_sel", infra_pcie_parents, 0x20,
-- 
2.45.2

