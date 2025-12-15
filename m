Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A445D5B174
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 20:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 709DA801CF;
	Mon, 15 Dec 2025 21:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WhXvDHSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB35805D7; Mon, 15 Dec 2025 21:27:57 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF9580325
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 21:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so17804825ad.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765830473; x=1766435273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ETgPzMlBVaRFl1DOhjKsxNIAbBA0VwNIt1XQjy6Gmeo=;
 b=WhXvDHSx6jXf5x9PjcUBiLfVjwBeEpjX/rCSdhOZva+vYQSiS4vgJlcLznteYtiqP6
 wcqXZuitNtMWruSojySAa+U/MWriHWy7Hljr6zPR1628FiLysaEQm4zc7D3vETl2uT5T
 Q2uXdg2/hWbI3wSimgsL28hmIrWkXEah+B7qZ5fV0Qiv6otJvJQ3gnJYZd1uAZZYbQhb
 GxQDhxKNndbC00YcQQxvBAX09lrIEzft55YzOJWICckEpsemzh11Vesk22WdNPs9NyP6
 nZ3t4jH23Ud4fRaVbns6PC3Be7Z1hlI6XrqkL9Zy1AaDuOX1JXAe2If4GmK6bDS13pbh
 EJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765830473; x=1766435273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ETgPzMlBVaRFl1DOhjKsxNIAbBA0VwNIt1XQjy6Gmeo=;
 b=aPMlp/MRW4VS9DXxhWQSUgjTMNTAZXHT8JiXZ/VkLYGIueDMEXorpyic9NP5UeNQZw
 OinTPf2Xp99sLCLRL0OmEHWSHQ9HyW6/a50AV0aBC+6UOoEiYLIHM/KcxTkUJXOaVSn+
 huI8MZ9rtXJi6dgTpK7a7+4RwKlR7ofxVh6TvZst7Nkuygeg2oLqpMac/JrcCY9L4IZU
 SSy1LZl2j/unTXyiayeQsSQRK4Ub6s365/DStm+T/26Tp+AQQPicEkSsPpQwJykDtkiz
 4TLKYbaxNjHGPYFM1OhxKirMnaQNLX+4f0TDOwavapQNFkvRzpUGZ6FVgCygvBmVUiFL
 i1ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp0YmKdEPXFaUQ/04ZfKyYtIgwCm8yzMP2mks5G9q4G0+g2GuJeSicRuRIqNQPY/ICOY1uk9o=@lists.denx.de
X-Gm-Message-State: AOJu0YzcIYb7YkOvjWeY/lu7nbvaCBMWuZH6QxKn1yqwxSM1iDiinKWS
 G3rJlsv4nGQOFCBvp43rYg88hMBYdUv1rU9hrZEiJbHAyDWfAAniaiSrlD6x5g==
X-Gm-Gg: AY/fxX4J4iGykzsI5DagCDL+1WTHhAj0k9db+GfcnF6XxBA+0CFHF2R+xrL6b06vDu7
 EgmZJ8BbQYChP23OANcyC2MItNXi6p6GbOdIx37hJg63zplUaoEuK4PL9qqtk5cOnWc3FVywtZn
 A6PPFfu2z4P2kjcyzThFV69YsA44h7mlDv18sIi2mspchx8ncopu3JLg1AtbKPrmgE0+fZSJgW9
 4fTlsFCzvpswT6sjnyjgWp6zKO5mjTYgbPUexTZCPf4ShwN2vV1pAW13awy3HJoG/H4Pps2pQ1i
 8i6ifVUIaPc8XQ3MhC7H0ETliL3v+/V8E2QYxmUBYuSSetMJ9gZsiuJiaeOdn0cQSSG8ka7d9tC
 zIRcgGbgyO4bWk012jWxmEVDu24KYFtjonRfJVPjHTKIWLI1NStzUihZ5XuVjczV5mMsOy9nYiz
 wsKbZWMqOnuL8jfntnO9GLyU2YXdsHfu2SK6KjCQ==
X-Google-Smtp-Source: AGHT+IE6cMzcvY5hal2x1g5n99A0UQhzU9D8gogE0eFW/qsHhOdg75QiC+cAzTNTkb2UuY0DcyBzhQ==
X-Received: by 2002:a17:902:ef03:b0:295:8dbb:b3cd with SMTP id
 d9443c01a7336-29f23b7868amr114492495ad.27.1765830472920; 
 Mon, 15 Dec 2025 12:27:52 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29efd74f5e1sm127427705ad.16.2025.12.15.12.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:27:52 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 3/3] sync sdram ecc support to mainstream
Date: Tue, 16 Dec 2025 04:27:12 +0800
Message-ID: <20251215202712.175-3-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <20251215202712.175-1-briansune@gmail.com>
References: <20251215202712.175-1-briansune@gmail.com>
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

It is been a while that the DDR ECC is missing.
Pull from Altera trunk and sync to mainstream.
Modifications are done to check ECC is on and
only add necessary ECC code to SDRAM driver.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 drivers/ddr/altera/sdram_gen5.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 3c79bb11802..07d8087fc7e 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -19,6 +19,7 @@
 #include <dm/device_compat.h>
 
 #include "sequencer.h"
+#include "sdram_soc32.h"
 
 #ifdef CONFIG_XPL_BUILD
 
@@ -562,6 +563,12 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
 	return temp;
 }
 
+static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
+{
+	return !!(readl(&sdr_ctrl->ctrl_cfg) &
+		  SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
+}
+
 static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
 {
 	struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
@@ -610,6 +617,14 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 		goto failed;
 	}
 
+	if (sdram_is_ecc_enabled(sdr_ctrl)) {
+		printf("DDR: ECC is enabled\n");
+		/* Must set USEECCASDATA to 0 if ECC is enabled */
+		clrbits_le32(&sdr_ctrl->static_cfg,
+			     SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
+		sdram_init_ecc_bits(sdram_size);
+	}
+
 	priv->info.base = 0;
 	priv->info.size = sdram_size;
 
-- 
2.34.1

