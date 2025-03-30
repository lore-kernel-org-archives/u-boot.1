Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8868C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F35C81E5B;
	Sun, 30 Mar 2025 11:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aTdgHEj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7C781E3E; Sun, 30 Mar 2025 11:25:46 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5276F81DCD
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so519868166b.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743326743; x=1743931543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOiRp/8l3PloHlOJ4usRHY+5YfM0qVGTFJcTbpHdpiI=;
 b=aTdgHEj4bKJJqzgKhLSqzjq2lwVyhvgx6TMSLin7rkam4CR52OJFMiqS+xFhaqDdFL
 XILiacZ/o3LI2RW/8oJE816JcAm2oMroAqx8kUZ5fjKeniqww8m5azK1ecjqoArUtRPI
 7d2VlR1KAvVyDe8SK7TwjJsk+8NbcGD8T2rabyuq9OMiKwsNUcilje6v2x/T36fmmYcF
 QGO7MPNXjHxcUxq8e2XWAFagn7FMdD/U2VH5Q1qNJ0VLFJsmkzc8srxS5t5/2WdGnTZb
 iBhXhHcd0s6UDuaKEcx4Weg/iH3LaQS7O/u9uwqdu5iKcKnSgzAUB+NdAuNA2I81X4s6
 RM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743326743; x=1743931543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOiRp/8l3PloHlOJ4usRHY+5YfM0qVGTFJcTbpHdpiI=;
 b=mkLP7N2zh/JVKp9nT9Hz4ASracqWaoN3pLUw5A6Brfr7Q4roYy1UaQa8WxPwrZC1sO
 IhifHDRvAqFmGfkBIxJu4kx/srtyfy9yqA1XCvccNthwpfuUeuZU+qknVdE/2OukNcfA
 lMwMx3aqYso+PS7ltXYPFQiA7yuDxlZAaD3VMUX2gEH6IN5OnmHSiKue/rGbzu9W89jE
 sgVCLqsmKCtVi+d5X2KKl9vjLk9AjmundHzdC+/V+VR2hQ5Bi+tnwCgPf+AcO8tIXybk
 HZSKYD/C3LotPFig5CJ4dfNOYXk0uZTYZXeKAzefkgnXIx6dgaGdmmeDTKyX7RfX8nNc
 mAbg==
X-Gm-Message-State: AOJu0YzbHzOgLZfo6iOtXzhp88U4Dz9oEAOcajuUYAB3xdcT3/xt9pUJ
 2zcqUgKgvdUoDHboVNPOBd6iPKahh0XeSa7hI+i97LWkm4l2wbU1
X-Gm-Gg: ASbGncuo2iljZ7fW+4Om+hL/Yo5aQILdzAvq7DMuRnnMUvzmGiVJUYHe5rfeuTioDEA
 9Su7OgJvNGjPfoxEL+i4m7C5jC3mJYnM8B+1G3UFg2/uU3lU1r/WROaWOTyj3YgjyflDbsbdHN3
 Nytt++RPSY9wrjm4yQRzrvKNipA2glqyrFJegJTh6MFgFENQc0Lf4JvuMS5orvz6dlyxiFrL5e3
 FoYkWy+1S/CLf8/eMI7JE4ndzqSQYwg+b/xs3fSUZYbwrfjswD6tqr4MEbI0FOZYRyyEu61wVoQ
 9AE3v8fAnvlP1l3Fs1weH5H4ETZWDWok6Z5H
X-Google-Smtp-Source: AGHT+IFORUzgJ8grHQIYDQye4KFc4iJW/DVAaY9Q+csWT+o9J6sSggXIUoh6SQOjDJb/47RaywOTtQ==
X-Received: by 2002:a17:907:7fac:b0:ac4:4d6:ea0a with SMTP id
 a640c23a62f3a-ac738a91226mr441521766b.27.1743326742646; 
 Sun, 30 Mar 2025 02:25:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7196cba8esm452202466b.152.2025.03.30.02.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:25:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/2] ARM: tegra: clock: fix PLLD2 info table entry on
 Tegra124 and Tegra210
Date: Sun, 30 Mar 2025 12:25:32 +0300
Message-ID: <20250330092532.10187-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330092532.10187-1-clamor95@gmail.com>
References: <20250330092532.10187-1-clamor95@gmail.com>
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

Historically, PLLD2 mirrored PLLD's layout on Tegra30 and 114. However,
with the introduction of Tegra124, this changed. This layout alteration was
not considered, and it now requires a corrective action to prevent future
complications.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/tegra124/clock.c | 4 ++--
 arch/arm/mach-tegra/tegra210/clock.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra124/clock.c b/arch/arm/mach-tegra/tegra124/clock.c
index 0ea212f80e2..8a6735d71af 100644
--- a/arch/arm/mach-tegra/tegra124/clock.c
+++ b/arch/arm/mach-tegra/tegra124/clock.c
@@ -598,8 +598,8 @@ struct clk_pll_info tegra_pll_info_table[CLOCK_ID_PLL_COUNT] = {
 	  .lock_ena = 9,  .lock_det = 11, .kcp_shift = 6, .kcp_mask = 3, .kvco_shift = 0, .kvco_mask = 1 },	/* PLLE */
 	{ .m_shift = 0, .m_mask = 0x0F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
 	  .lock_ena = 18, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLS (RESERVED) */
-	{ .m_shift = 0, .m_mask = 0x1F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
-	  .lock_ena = 22, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLD2 */
+	{ .m_shift = 0, .m_mask = 0xFF, .n_shift = 8, .n_mask = 0xFF, .p_shift = 20, .p_mask = 0xF,
+	  .lock_ena = 30, .lock_det = 27, .kcp_shift = 25, .kcp_mask = 3, .kvco_shift = 24, .kvco_mask = 1 },	/* PLLD2 */
 	{ .m_shift = 0, .m_mask = 0xFF, .n_shift = 8, .n_mask = 0xFF,  .p_shift = 20,  .p_mask = 0xF,
 	  .lock_ena = 30, .lock_det = 27, .kcp_shift = 25, .kcp_mask = 3, .kvco_shift = 24, .kvco_mask = 1 },	/* PLLDP */
 };
diff --git a/arch/arm/mach-tegra/tegra210/clock.c b/arch/arm/mach-tegra/tegra210/clock.c
index 04708f97144..d1ede5238dd 100644
--- a/arch/arm/mach-tegra/tegra210/clock.c
+++ b/arch/arm/mach-tegra/tegra210/clock.c
@@ -668,8 +668,8 @@ struct clk_pll_info tegra_pll_info_table[CLOCK_ID_PLL_COUNT] = {
 	  .lock_ena = 9,  .lock_det = 11, .kcp_shift = 6, .kcp_mask = 3, .kvco_shift = 0, .kvco_mask = 1 },	/* PLLE */
 	{ .m_shift = 0, .m_mask = 0, .n_shift = 0, .n_mask = 0, .p_shift = 0, .p_mask = 0,
 	  .lock_ena = 0, .lock_det = 0, .kcp_shift = 0, .kcp_mask = 0, .kvco_shift = 0, .kvco_mask = 0 },	/* PLLS (gone)*/
-	{ .m_shift = 0, .m_mask = 0x1F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
-	  .lock_ena = 22, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLD2 */
+	{ .m_shift = 0, .m_mask = 0xFF, .n_shift = 8, .n_mask = 0xFF, .p_shift = 19, .p_mask = 0x1F,
+	  .lock_ena = 30, .lock_det = 27, .kcp_shift = 25, .kcp_mask = 3, .kvco_shift = 24, .kvco_mask = 1 },	/* PLLD2 */
 	{ .m_shift = 0, .m_mask = 0xFF, .n_shift = 8, .n_mask = 0xFF,  .p_shift = 19,  .p_mask = 0x1F,
 	  .lock_ena = 30, .lock_det = 27, .kcp_shift = 25, .kcp_mask = 3, .kvco_shift = 24, .kvco_mask = 1 },	/* PLLDP */
 };
-- 
2.43.0

