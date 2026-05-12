Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CA4CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 07:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1498280398;
	Tue, 12 May 2026 09:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aO9AdEwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1EA80398; Tue, 12 May 2026 09:51:53 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4289801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 09:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3200975f8f.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 00:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1778572311; x=1779177111;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XI/vYViSUNto7CmLaoQaGtwz434ygBH11yR1ypEmoRY=;
 b=aO9AdEwyUsXzw3h1lXyB5+WRss3LGqOnmGp5S7qDwj5DBrab72tomU7zWmZLBA/BpR
 IyFWHKLV1FF1XIylyslmc/jDx0hu17ESQZnplvW6ngm6MMsmbMgkXtqPhSv1TIAp19Dh
 ep7Z0aSQUcOXfNJKLiffRDTp3DxsgUK0OFCGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778572311; x=1779177111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XI/vYViSUNto7CmLaoQaGtwz434ygBH11yR1ypEmoRY=;
 b=jqiJMVLSjAcbt/lQGvoioYgQHeEZqC5ysqKr+zenGYIPpIxIVqGP5U2nS52p0kxci+
 A88TmINWVmc5yQOx1AeW/FEaUogV5z4jNAJ1vwEAVrwLRNI4R9MMFcxjahSDELtVIbQ2
 QBgKj/43oIc7t4HXP1jiyZFAQFhB4kGxyQq+Ofj/5zbIjawG1bSmNCEMJv12ST5EgylX
 GI3ZKxBAhNvPJy3ymj09Gj7XhsV7HtIv3V+6VuLCkbFupwkqq+WPkBwcLyLqNT9kr+Zx
 byYWVPrgXqxI3cRdBhQa7drLtljgjrsCr0Cy2LPIW2qxsCAuZNS3XwfgQyQfww2G/BCY
 yd0g==
X-Gm-Message-State: AOJu0Yxu8VBP0OP8lhQdsMQZvUofJaF+y7atziNFGlQMLyrvgiyxqTTs
 HVi+b3nsZ8lsdobYE+bZDYf+kPxlkOxdr3E7jhwue9n9vQWHc4+a9/bbFlwThpg3NeiZCS5+VYG
 zY0dK
X-Gm-Gg: Acq92OGRKI8+3Z2lzXprCJucLh/jlQbzN+A5J+VLwuB4GV/6hn+s9BwUveqaJ7dv/OH
 +JXy3+54E5+6DtSuHZd8+kVu+uTZFHzHi1NJ9qzSpEtvKQ1PV+MrL4uw7/JUf1D14NrB72DsbQI
 AFK2x79XDBAO/E/+VEDrfil3MsgTLbV+FHYDmiwIEC2dp7L2d2vPO4J6Df0CoFmfsbqi8CsABNX
 cFcNfafvUZpaA0Ngug7d6vFMErLxcC6Xne8VoHEFXvw5kW9w05LGhJx+A73JWyPd6dN/Y3a9h3j
 rA80klG5RXfckIcBYGdWuINzYbLZRRc+FRKL0yik9AHlENm9E5eI/8AYdAb4mo+yTpZRu0jNbkD
 bfYMvKSW7D7/YFeksDKl2VuJLMbLopN3tuUacRdK6sJk/Vs/oNcSXIzmor4nurHPeYuB3QAES09
 nCwH4gGOWjUta3429AOIlpoJ9Q8oYJqayAGqxGRHvkuEaGSLSUCbFmB5WaOAxMXBz1TRxoFYlRj
 3pW/EEE2oodhcm02k0R/pawVE2dKCFK6qX2W1cGQCmJvdU=
X-Received: by 2002:a05:6000:184f:b0:452:f380:5508 with SMTP id
 ffacd0b85a97d-45abdbfdaa1mr4207435f8f.0.1778572311008; 
 Tue, 12 May 2026 00:51:51 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a68ebsm29183642f8f.1.2026.05.12.00.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 00:51:50 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4] video: Kconfig: fix indentation of help text
Date: Tue, 12 May 2026 09:51:40 +0200
Message-ID: <20260512075145.567435-1-dario.binacchi@amarulasolutions.com>
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

Fix the indentation of the help text for VIDEO_LCD_NOVATEK_NT35510 and
VIDEO_LCD_ORISETECH_OTM8009A to align with the standard Kconfig format.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

---

Changes in v4:
- Add Review-by tag of Heinrich Schuchardt

Changes in v3:
- Add Review-by tag of Quentin Schulz and drop the ones of Tom Rini
  and Svyatoslav Ryhel. Sorry for the noise.

Changes in v2:
- Review-by tag of Tom Rini and Svyatoslav Ryhel

 drivers/video/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2acc13139c0..1242f7c87312 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -574,15 +574,15 @@ config VIDEO_LCD_NOVATEK_NT35510
 	bool "Novatek NT35510 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Novatek nt35510
-	dsi panel.
+	  Say Y here if you want to enable support for Novatek nt35510
+	  dsi panel.
 
 config VIDEO_LCD_ORISETECH_OTM8009A
 	bool "OTM8009A DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Orise Technology
-	otm8009a 480x800 dsi 2dl panel.
+	  Say Y here if you want to enable support for Orise Technology
+	  otm8009a 480x800 dsi 2dl panel.
 
 config VIDEO_LCD_LG_LD070WX3
 	bool "LD070WX3 DSI LCD panel support"
-- 
2.43.0

base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
branch: video-kconfig-help-text
