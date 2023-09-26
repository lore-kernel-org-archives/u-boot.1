Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86E6E7D26A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4101E86D67;
	Tue, 26 Sep 2023 11:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y/rghUPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 971D486D80; Tue, 26 Sep 2023 11:10:35 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A5886BEE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59c26aa19b7so100975457b3.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695719432; x=1696324232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XxeQGsbw9XCF4saJoHpNf2Yz2cpazJQQtNZAzmK6cxA=;
 b=Y/rghUPNNfGP2NR9RBaHYp929N5tbiG5KbO998N9qzWXadnpFDuH71bcOTRT01Vutj
 dGH2nkkyS8PXWxJ47LynGjfwC9I8F7+p9GkrJyYSF7ayDJlcakA0Xvwh2105+UUtJ7vE
 H1ldUxmGa5pSCO/9AbU6jIeaikYE3h/JHMlF1iicajO76ri5bNmjImFp0v6aWNzI5H8/
 FQzrTyKmAMf9A9yyMlI3MDDGLl8sP0v3PEv3dremkS+LQoYWA7i8YlCrfsLHYptV7f1V
 gacNc/qCWT6Z2/T/C5jp24P73nC74HNx/QIk/tQFoIZAM5BQBkpkBUTjmzSFJhG2164V
 g2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695719432; x=1696324232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XxeQGsbw9XCF4saJoHpNf2Yz2cpazJQQtNZAzmK6cxA=;
 b=rMcRqaqbC/NLl+kd0UWQQRBktiraUqJOBtZKqsO3zL9YP7xJHId4nqi4AxGB7TM5Eo
 zeLfGcNoKirVUZgvus7GrUNc/d9ekA7iexNM+x2yll7MqEUXhflqtio63tmprwuwJDPT
 ztPQMYE9RtcLNQ8mJttj+jyxSrnmxxFjj/8PivsBT1jbXJQZH3LA1qI2VanO2iJR+Zg7
 sekcPprjFRkc50dJYX4NuRpX+kkAJD7iltSkLoec3bFcgMazJhX20LP1P/MglDl0geF4
 kdWseTe8yqQ8oOOGlEqjPhFpM2N19xCyUhmJW3akt46qmvE4mD8v8O8msEPLmQV7tgu5
 NkzQ==
X-Gm-Message-State: AOJu0YzCG5IorMI1uIWLf59nqdVJm4E9IBZWYHsF4EAvGwnmhjC1swaz
 peVBCl/dDGR7l+R2mfFttRU=
X-Google-Smtp-Source: AGHT+IEClbInJv5KBoDywPM6wB2nhom5co0zRgjbnxDXk/0DpPRs7nxRlkN1K8poY1tUUxkTwQ3bzQ==
X-Received: by 2002:a81:6907:0:b0:59b:be67:84cb with SMTP id
 e7-20020a816907000000b0059bbe6784cbmr7921253ywc.26.1695719432141; 
 Tue, 26 Sep 2023 02:10:32 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:c707:b24b:e4c0:3696:f2d7:f673])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a633f02000000b00570668ccd5bsm610181pga.14.2023.09.26.02.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:10:31 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] spi: spi-nor-ids: add flash model w25q01/02 support
Date: Tue, 26 Sep 2023 17:10:24 +0800
Message-Id: <20230926091024.408275-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

add flash w25q01jv, w25q01jvfim and w25q02jv support

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4587215984..fd74efe609 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -512,6 +512,16 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
+	{
+		INFO("w25q01jvfim", 0xef7021, 0, 64 * 1024, 2048,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
+	{
+		INFO("w25q02jv", 0xef7022, 0, 64 * 1024, 4096,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
 	{ INFO("w25q80", 0xef5014, 0, 64 * 1024,  16, SECT_4K) },
 	{ INFO("w25q80bl", 0xef4014, 0, 64 * 1024,  16, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25q16cl", 0xef4015, 0, 64 * 1024,  32, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-- 
2.25.1

