Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1926AC28B28
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 01:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 254D0810F5;
	Mon, 10 Mar 2025 02:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BvW0Jkzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C98938070C; Mon, 10 Mar 2025 02:45:50 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D03809A4
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 02:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff04f36fd2so6055617a91.1
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 18:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741571142; x=1742175942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2NowRzm+xEc/miqb9dFZgJD0dX3+OBLoj94ZdV/Kpg=;
 b=BvW0Jkzpp1lDBKgOlKu/W0EyXUI06wF5u6dWJX/ZPjzn9HvvQ9S4HoOnEkMNbuOin1
 w2DvXdwzCnPrEtINnmXoDboqOK/DOiTwAkVAGfc0mApM7xIatH7JcClRDs2Y2yogqzg1
 bJBd+q7ndRqjaWFWR9Eo4IYMATBXxHb+xlklI5DAOAiwcAE6jq6yAU5B6WdYYwCfWqsO
 XfAQSMLsYEqst/r44+/cS322kaSs9KQPHjVNigxI2EOPcOGwX9Yk3EdDCVATmazYxpLb
 qwQ+4wXjVbgAtNT4t87fh5An+303tIOtT6BrXQ+OGu1+R7GRCLBChSZSoeAm68meC5m2
 iP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741571142; x=1742175942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2NowRzm+xEc/miqb9dFZgJD0dX3+OBLoj94ZdV/Kpg=;
 b=rReSUZr9Sq1yp9Xn3tWS7fETuULpc/QGM3XnxWshrvqm203p7D+jt7Ey72N1ZTPyqu
 kozZvh0oV5f/ZUzuNKBeBTuG8Q7FBnyzLljcMxwilsnrI6EnrdCbBbo7kD76+VfSvN4c
 czpj70L5cf39UYHFA/0FljZ6ubY95Dy+t8MpM0aXQ6y3XyQyIbKK3UP2aSp3LT9FekjQ
 ++PQszZy41MjPDszgql8arDxZg72uzR3LgNbEqBER/0CyB57248bi5q9T0QZbvWpoBu3
 2ht7cyD9KcTvBuHXn+WPsZXfNsYPX8a77GzS/ENYaXaxeJnuiWMeeqfbVlGL6CdQtoAv
 kFyA==
X-Gm-Message-State: AOJu0Yx5KTohydZ5NIY/tmckGqJCPnGVCyXYarV3jPgI0fpyOdNLSvGN
 8TbGZUjQVzYa+vUgmyayN997FxGLTXsDV/b0w87xod1zXYqjZc/i2E5C+Q==
X-Gm-Gg: ASbGncvJNUf7WnMtlWyKRmG+BHYLNTpKGSj4XI527BcY86b7uMmuHH+EnMspOy+uPlO
 tYn5xKTqTtHOe4IAc270Pe0J5WjZLE2dd3S6w+GcaClp95AYy1dsCa3u+YUPIEbkGMVI6nSASYn
 1JDR2jg5ew1aP7ReiOU/kAC1/4FpH41InJsFbnpArUt6x5qPcGbUBpShRjgJ2GLr+qkKIKzqLgY
 7+AYyOiwYMfQrdr82d01hGSofYkwJVUnVozRavVWcm87no2ftZAZMUrY5QbezYvXzgKRJT5llcs
 1ugidWNTw4Oe+PzX7L1/9zzbDzu/05Lif6YtvVYTzxAB2kjExR/GDQZbga+JU8nep5gPqmEU6il
 CiYDTzSMtxw19LSj+XO2xASIATsPw/sYckrffnGczA5qPghhl
X-Google-Smtp-Source: AGHT+IEDdhWnPCQKt6hECafaDs81l0sjISTiHlm8HADUJSt/7GWbjrnZWml0UWDscOh8/YRGrFaLoQ==
X-Received: by 2002:a17:90b:1d8e:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2ff7ce6fd4amr20843845a91.14.1741571142419; 
 Sun, 09 Mar 2025 18:45:42 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff69181d13sm6696049a91.0.2025.03.09.18.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 18:45:42 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH 1/2] mtd: spi-nor-ids: Add support for S28HL256T
Date: Mon, 10 Mar 2025 10:44:28 +0900
Message-Id: <d7a6b10a3b600204d87d3cec0caec347b892c661.1741570750.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741570750.git.Takahiro.Kuwano@infineon.com>
References: <cover.1741570750.git.Takahiro.Kuwano@infineon.com>
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

Infineon S28HL256T is 3.0V, 256Mb Flash device with Octal interface.
It has the same functionalities with S28HS256T.

Link:https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HL256T_256Mb_SEMPER_Flash_Octal_interface_1_8V_3-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c8fc2dd9c018fc66787aa0657
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 91ae49c9484..a500fff4775 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -414,6 +414,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO6("s25fs256t",  0x342b19, 0x0f0890, 128 * 1024, 256,
 		SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #ifdef CONFIG_SPI_FLASH_S28HX_T
+	{ INFO("s28hl256t",  0x345a19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
-- 
2.34.1

