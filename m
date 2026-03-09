Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC59EA852F
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 01:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C658063E;
	Mon,  9 Mar 2026 02:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6Iz4qM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE98E807C0; Mon,  9 Mar 2026 02:13:20 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B106B80517
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 02:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82976220e97so2507521b3a.3
 for <u-boot@lists.denx.de>; Sun, 08 Mar 2026 18:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773018797; x=1773623597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/nxzwx4okgtdohLyQJzNTczOKIob77tfoZmvLoyVaEg=;
 b=W6Iz4qM8SnUZc1CweouR2t3IYuQBPQxPL9rsaRy+4uYVTFgH9OGSEJh9JVrP2MdsF2
 JUzkRf8LujdD+5VK3rxzO36a8BceggVgKfR8umRFyq99CNRHqG1ztnQGHc2fLwyFk4/x
 AIeJ9bGJlewMYraSL+h8yUS1pTXCQ6pBxKpcjOUpluOGp8h8/vJzootFH/4RGe3gx+Gk
 w/lskxPMijGmi81EYOEJ4/swHLXMj3ezAO9Wg+raKpufSsV7CYIP17dRsfcoDtywW1AQ
 DmdQCy+6elsJnBVMgSjba+EH8OdR/riS5qTpi3PtxPI7MkFXEv4eEbnqh+sc5PalVBUO
 PKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773018797; x=1773623597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nxzwx4okgtdohLyQJzNTczOKIob77tfoZmvLoyVaEg=;
 b=jH+i4jpDKTmbooInaCn2IFTkTeAntpIrlCQTyU38lebXSkGBmWe/2ye7sAozbmmwqo
 1IGMgKZ92jj2Ngpskif8fLtUFzfdVM/O42ofb6WV581GufKvPyBvsPcn5pYKYD0wjOBk
 eEXGWqZdrnS0YS+14kN9G6kYWxgXywByKZdtMCpZA73dfrrc0rICsSLzo17tkuMPAjLb
 h7BJEVHdm7GMdtxuGmMnF1jOtRj/MbjY06NqPJuQpQzOTiCzjga8TFNu266SNoRNy6aj
 J4+SXzbzaCblaY2yhgknI6j/JnHpFRQND9XKJuz9JTqAxekVsvstvUHOJEbEELmHCGkn
 TjJw==
X-Gm-Message-State: AOJu0Yz+T7tycmhcPZemwjVqAg+WQaWlPLyHZ7b3BJtfSf+7N5/P8Gt6
 Uy8m9CknUR7DlnX9l5q5sz0a9keJWepubglhvK9ID8HS3MR8aNEQbuPS/JvMxg==
X-Gm-Gg: ATEYQzw1RjNInrjs2rlOa/YukqTFpKgA6ie8gl2mergeEmyv3GmspKD+gaA9qU1G3jR
 XFjrGTp39wFlLlBkLgiVQlOxAFsbMNu1G23U8TrwIOq/Z5FAwTBBbkFVY9zJuyfG28l5q/VM8+H
 eXmCvAR6AiED8eqX61hwVdmqbuOU+wesAowZ+cJIvaFXqjQ0hNYHwHmrvFUk3Lto8Cod2Z3n8Jx
 OkR3AWMulBImNCcedwMCsUGQNwpQOBYLKMcSU9mQ0CHv7Go02v5IsVvGgjXofIlyVfJfc8MVC0r
 K99h1oAN3QGBHgDbBP2u+MxAj4Rjfqk82/G7BnqGKqOzhegzc0yx58z61Hkpf/ISA0JU7iqKooW
 ofw52SfWwQml15a/GT2ctp7II37hai2O+F3WguWD5PDLMjq8KU7f6sEF8BgElmEo0Gr39cnmt0D
 4jmvf0VzK6zv8dFW21S0bz4SBm7MPZJBY07jdNrPoV5LOnaY9rMmm35h0f9PGgQ3pmMbNoEXfJx
 mnmxEJa0xw/D+3O0cg=
X-Received: by 2002:a05:6a00:2d89:b0:81f:3c34:fa83 with SMTP id
 d2e1a72fcca58-829a2fa6b84mr7775231b3a.57.1773018797063; 
 Sun, 08 Mar 2026 18:13:17 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4866763sm8312064b3a.38.2026.03.08.18.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 18:13:16 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 miquel.raynal@bootlin.com, mwalle@kernel.org, pratyush@kernel.org,
 marek.vasut+renesas@mailbox.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH] MAINTAINERS: update SPI NOR reviewer
Date: Mon,  9 Mar 2026 10:12:51 +0900
Message-ID: <20260309011251.11462-1-Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Tudor Ambarus will step down as SPI NOR reviewer.
I would like to take this role.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 920da147e6c..d2040fee252 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1754,7 +1754,7 @@ F:	drivers/mtd/nand/spi/
 
 SPI-NOR
 M:	Vignesh R <vigneshr@ti.com>
-R:	Tudor Ambarus <tudor.ambarus@linaro.org>
+R:	Takahiro Kuwano <takahiro.kuwano@infineon.com>
 S:	Maintained
 F:	drivers/mtd/spi/
 F:	include/spi_flash.h
-- 
2.43.0

