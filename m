Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055C0C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 22:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39ACA88B6C;
	Fri,  2 Aug 2024 00:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j8ABcoIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 966B388B77; Fri,  2 Aug 2024 00:57:47 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2378B88B61
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 00:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3db50abf929so1075253b6e.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722553063; x=1723157863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAl13mUpFnzqvLLgNQb/MXjvMvcZsEF5aTBr3EQEmSA=;
 b=j8ABcoIiY5jNQG11+dzR8b7xph4Wdi4yLLpUHf1wl86j9mnMwda0cveJc2u+lXaCl5
 azpNAI648w3iz30NWgWlseMn1Yall1w0EhaQPm4kbhj78oaZ/7F5IeRZOrdGW+C4q9EF
 5xCqiOLlQlI8+QIAoQIGydQhi03u+3IrHgH8nC32c+ibtkCBXQSsUcqnI0JrNzzZNlqT
 Zj06HJfj/lHISNznsuYYSEUKDSwk0Zt1aSEGmiXH9y79Lz7vghLvub3nNz3V5XxxVpit
 lijeMzG4jh02YJCeiZwRcVOx/EVQ8w0UZiNpjbIs9U03gRZbfabqAM1iTvaTpg7wHGm7
 btyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722553063; x=1723157863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAl13mUpFnzqvLLgNQb/MXjvMvcZsEF5aTBr3EQEmSA=;
 b=Nl3/0iix6x2oXZ3GifqjzbtMuatjaI0mFnzseh9a/zm8oO9a/DZhUdX+ejYxXDSeUU
 urncRGN6pPHFAbooBNz8PP/6JpqpmUl/T+C8lpTmmvYo05Mp/J64NvsQs1YnrOoCXEZp
 zlRfyDNMG51X2ErAoQ6sM7vgWFroKrM3sMZij753b2Fd8hIURrwWb8kjVBShpBtERkVH
 IyIztoaclBniHa6zzVv2HV7mES4ZLcZYJ5HkPRtiAuv+Pekm9qY/Ncz899HM0WJHNNBP
 4GDn0SoCgpV2kHKdE+6AHaIQjRk5Ik1EMtz2xGNjAoC92dMAUn2zfhmWpU26YjyFTL6p
 v0bQ==
X-Gm-Message-State: AOJu0YyV86kGKc8HY5vGwboc2UpWDTYaK1qyMCuMu3P38207Dzs3UI7y
 TQHW0TApTFs2wAlhu+Pu8uAX/xyl8Cjvw6mwKvb8j+q5MyG+8qgo2pEgkQ==
X-Google-Smtp-Source: AGHT+IGqNw5+Z0wxAJjOFZZYobHSBMCFCBk2ecKCYkKU9hg/atkkb+2Q6Fbgjh3cer8X+ZS6IyXk4w==
X-Received: by 2002:a05:6870:818b:b0:25d:f0ba:eab7 with SMTP id
 586e51a60fabf-26891b1d08amr2047610fac.18.1722553063689; 
 Thu, 01 Aug 2024 15:57:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67b515sm58039fac.50.2024.08.01.15.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 15:57:43 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/9] sunxi: H616: dram: LPDDR3: adjust settings
Date: Thu,  1 Aug 2024 17:55:12 -0500
Message-Id: <20240801225519.336667-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801225519.336667-1-macroalpha82@gmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

Adjust H616 LPDDR3 DRAM settings to be in line with vendor driver.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c         | 2 +-
 arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 37c139e0ee..a20264d8b4 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -945,7 +945,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 		val = para->tpr6 & 0xff;
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR3:
-		val = para->tpr6 >> 8 & 0xff;
+		val = para->tpr6 >> 16 & 0xff;
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		val = para->tpr6 >> 24 & 0xff;
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
index ce2ffa7a02..82b86084a6 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
@@ -24,8 +24,8 @@ void mctl_set_timing_params(const struct dram_para *para)
 	u8 trrd		= max(ns_to_t(6), 4);
 	u8 trcd		= ns_to_t(24);
 	u8 trc		= ns_to_t(70);
-	u8 txp		= max(ns_to_t(8), 3);
 	u8 trtp		= max(ns_to_t(8), 2);
+	u8 txp		= trtp;
 	u8 trp		= ns_to_t(27);
 	u8 tras		= ns_to_t(41);
 	u16 trefi	= ns_to_t(7800) / 64;
-- 
2.34.1

