Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4275DF483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7761C842C7;
	Mon, 23 Mar 2026 20:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tC5/2Ov0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B4A84297; Mon, 23 Mar 2026 20:53:15 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8290384248
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40429b1d8baso1496699fac.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295591; x=1774900391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qICxRm95MoMaeY/k/L2ORogGJIWHdMX49O5pkzTPWOs=;
 b=tC5/2Ov0vIGPrDt00mfPpPWNaikHsMb0rMEJ/OqG8kROQz5Ajm07w3cLRyo79CzTOC
 Rv6sc26bFPSJ/HQ56n1B4iZKyeA4Y5k7zDeAt+LhyTdJgJWs64dxtLWd3yxLDKjb8pkH
 /HuuOuZZ+02QLB0DCv2MiLSYxNBqAMOQ2cf9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295591; x=1774900391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qICxRm95MoMaeY/k/L2ORogGJIWHdMX49O5pkzTPWOs=;
 b=JusBEVn7/lwiSoSkuNR0Bra9dZTE74KMwSVRibTxdZr923VkLjQu4ulo6uu7zs9pw+
 ke7L1P+WwrC3NniUNYFQXOTTGi5RVozKaj356YFIbTaOEcd5aQfRI2a4cfyY8mWuFQm6
 85doRxugDkS3ato3imMEG3l5AU9rr3G67mi+sTuts5VdTSLp3t/KJ7hb0cISGHrrBSXO
 0wFEN5V65ieaMuWGZCzCIdYZc3p+OZmmbUh9VBYnribcC1jRyNEXjgTxlZsmdJj/6nEK
 rCc46RU4gb5OZC3o+GHCf/+yEu1LFrzBLxZDP+4SXW1ie3Lv4uk5uSeqv31m2Q1SgReK
 YL7g==
X-Gm-Message-State: AOJu0YyIx+BBaHuAESuwI51bzzo/0W4hPrVsccJkJnwZ8niubqk7AyTm
 KPx7dUJofERi9WihjJcUt+1jNikUltholnWJgKtdwddHLSdOuUVbd+cMWVORTj+CFumGlrBZU4L
 bsSaMd2c=
X-Gm-Gg: ATEYQzzF0oftfix7nxch6gxY9yzDwAxG326kXFqEL7ZcX9vXvsT/XzmWfZdwRbIXbcR
 fvzrW6LzDNbX711p71bWwy04vog2q0IrNWB6hN3SRuFJr9cnQ0qTCgadFSN3YfpPaibRfYbxyKV
 rYJGd+qnjD9VpOsODJq09hbQKTbunB+IWyuNaArp8mmISOmh0coD/pKNkTqr7Q4QTYUvyy3omei
 tugwWq1xC8u0j/uBijqpd/hyn0h7tIyGFDoa8E0zRp7rCoN3B1PdmZBVA2T+paWDqf/6NJIQQ4Q
 S5+gDFVr+g1qikrEk1+oPDj0f++DyAavQ4/xyK7mxjvHF96I+2G5to8qQQVh4RZPijR8fUMzE8o
 qZEcQvs4BPbNNMRlLk2yNqKXFjTylEHfE5qLga/6ol1NR4PoK6jDq0wYBkIj87X89KwGZL1TNZV
 pVtHQWsp1u5ichLytpXsx8PY2ThaG1GoPPoRpePxbrvFs9cOJvYoRBcAhdJR7jmRjTMBcT7UCm3
 XZQPCh6psp7R/nWSZ9ank4fjNUGKQkm4xBSbbnkyPi2Dat9/bs=
X-Received: by 2002:a05:6870:fba8:b0:40e:e931:e7ed with SMTP id
 586e51a60fabf-41c11244fe7mr7463448fac.42.1774295591195; 
 Mon, 23 Mar 2026 12:53:11 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5f99sm11575738fac.2.2026.03.23.12.53.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:53:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] video: Correct dependencies for VIDEO_LCD_RAYDIUM_RM68200
Date: Mon, 23 Mar 2026 13:53:09 -0600
Message-ID: <20260323195309.2363640-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The VIDEO_LCD_RAYDIUM_RM68200 functionality can only work with BACKLIGHT
enabled, so express this dependency in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3b61bb50215a..20753bceb973 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -594,6 +594,7 @@ config VIDEO_LCD_LG_LH400WV3
 
 config VIDEO_LCD_RAYDIUM_RM68200
 	bool "RM68200 DSI LCD panel support"
+	depends on BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
 	Say Y here if you want to enable support for Raydium RM68200
-- 
2.43.0

