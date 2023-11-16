Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21B3C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 09:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631C087497;
	Thu, 16 Nov 2023 10:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mi8uqTSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B7387489; Thu, 16 Nov 2023 10:00:05 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2168748B
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 09:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-991c786369cso79352766b.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 00:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700125193; x=1700729993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypbknmmx/VjCSk7w07M9xoIZVj0pQUz5fdsMVY9RlNE=;
 b=Mi8uqTSBUOm2vbH6Sm06JFSfwHiy5l3GYZK8mK0HbMp/CRfOfmMrYau21Mz1XS9jSx
 MjJ89AG4s3LYMmwKnN1hq+344XvoCSB/ummDJ9BxZ55XrJePLFa25VaroUcnjt9JkyD4
 EbJsnos/CG9oPKN/LcMGVAhtV6dHQ3cUDZA+DZqUtbPzSPXRIxAfA8NyzefRWCSOiugt
 PRib1/LEV8BFf6ERdhV9BL7E2REXJfdPFU+TONyXo8jc5Ifm6pLgWRztXt18tPGyV5Qs
 /mQdTe2XPISOTmEINBLI14J7gfPXbEskwF9vJkzGz5SAMNDardkkLiyCRRtZR0k4DpKf
 pk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700125193; x=1700729993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypbknmmx/VjCSk7w07M9xoIZVj0pQUz5fdsMVY9RlNE=;
 b=dmSh3UKRVz0q7BAl+pcRYFjN4mmp8nZFg81OgTpyRGKU7WeLdMbgXmLWOiJVdgdKTa
 N539C6mrTs7DhTzux1RuUx5H58v/SxTfLFSXYXlSHdAiWiwg8U2+ggiTeRSzyr/lxhJ4
 BFw/F8VTNm2Ye6b/j2QuUXc6Y8i4gSovNZfhaiEcaq2mCFy4QDoLAuI+z6xl1WfocEQs
 84mCOWk3I/S7zl4FW/sxzExeLM4yFYoVrq/GJJ137wnRCnIMRELv+YVUFVf9Xlxk7QGY
 PVAdM081VEfIcqs+DgrtdMBAN+Tl38SSbWbQqfguBZ5/V51qFgYek3ConeRjM0IrkrSa
 s1qA==
X-Gm-Message-State: AOJu0YzbIPD91CQ+bKwawe+D4RCn9NBFDtz62W5qK1E1MdX/8HerIpht
 XBkwzzYiXFQ0OJ/zq2af/Ny0UaLAIsA=
X-Google-Smtp-Source: AGHT+IFoFKacuf7fqcq6bmLF2Yv5EKAPzyga0QVN3AhK19le5KWir74RU5rTivGfay3L5VPHtQeOXw==
X-Received: by 2002:a17:906:d8dc:b0:9c5:7f8b:bafc with SMTP id
 re28-20020a170906d8dc00b009c57f8bbafcmr1112932ejb.22.1700125192525; 
 Thu, 16 Nov 2023 00:59:52 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906601500b009e655c77a53sm8093259ejj.132.2023.11.16.00.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 00:59:51 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] ARM: tegra114: clock: implement PLLD2 support
Date: Thu, 16 Nov 2023 10:59:31 +0200
Message-Id: <20231116085931.411707-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116085931.411707-1-clamor95@gmail.com>
References: <20231116085931.411707-1-clamor95@gmail.com>
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

PLLD2 is a simple clock (controlled by 2 registers) and appears starting
from T30. Primary use of PLLD2 is as main HDMI clock parent.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra114/clock-tables.h | 2 +-
 arch/arm/mach-tegra/tegra114/clock.c              | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-tegra114/clock-tables.h b/arch/arm/include/asm/arch-tegra114/clock-tables.h
index 9b95b339e2..95fadd0c59 100644
--- a/arch/arm/include/asm/arch-tegra114/clock-tables.h
+++ b/arch/arm/include/asm/arch-tegra114/clock-tables.h
@@ -23,6 +23,7 @@ enum clock_id {
 	CLOCK_ID_XCPU = CLOCK_ID_FIRST_SIMPLE,
 	CLOCK_ID_EPCI,
 	CLOCK_ID_SFROM32KHZ,
+	CLOCK_ID_DISPLAY2,
 
 	/* These are the base clocks (inputs to the Tegra SOC) */
 	CLOCK_ID_32KHZ,
@@ -30,7 +31,6 @@ enum clock_id {
 	CLOCK_ID_CLK_M,
 
 	CLOCK_ID_COUNT,	/* number of PLLs */
-	CLOCK_ID_DISPLAY2,	/* placeholder */
 	CLOCK_ID_NONE = -1,
 };
 
diff --git a/arch/arm/mach-tegra/tegra114/clock.c b/arch/arm/mach-tegra/tegra114/clock.c
index 9a8c10e3d6..418ad48ddc 100644
--- a/arch/arm/mach-tegra/tegra114/clock.c
+++ b/arch/arm/mach-tegra/tegra114/clock.c
@@ -457,6 +457,8 @@ struct clk_pll_info tegra_pll_info_table[CLOCK_ID_PLL_COUNT] = {
 	  .lock_ena = 9,  .lock_det = 11, .kcp_shift = 6, .kcp_mask = 3, .kvco_shift = 0, .kvco_mask = 1 },	/* PLLE */
 	{ .m_shift = 0, .m_mask = 0x0F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
 	  .lock_ena = 18, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLS (RESERVED) */
+	{ .m_shift = 0, .m_mask = 0x1F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
+	  .lock_ena = 22, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLD2 */
 };
 
 /*
@@ -671,6 +673,9 @@ enum clock_id clk_id_to_pll_id(int clk_id)
 	case TEGRA114_CLK_PLL_D:
 	case TEGRA114_CLK_PLL_D_OUT0:
 		return CLOCK_ID_DISPLAY;
+	case TEGRA114_CLK_PLL_D2:
+	case TEGRA114_CLK_PLL_D2_OUT0:
+		return CLOCK_ID_DISPLAY2;
 	case TEGRA114_CLK_PLL_X:
 		return CLOCK_ID_XCPU;
 	case TEGRA114_CLK_PLL_E_OUT0:
@@ -778,6 +783,8 @@ struct clk_pll_simple *clock_get_simple_pll(enum clock_id clkid)
 	case CLOCK_ID_EPCI:
 	case CLOCK_ID_SFROM32KHZ:
 		return &clkrst->crc_pll_simple[clkid - CLOCK_ID_FIRST_SIMPLE];
+	case CLOCK_ID_DISPLAY2:
+		return &clkrst->plld2;
 	default:
 		return NULL;
 	}
-- 
2.40.1

