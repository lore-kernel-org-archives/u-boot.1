Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132AFC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE5758783A;
	Fri, 22 Dec 2023 06:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hU2kvNmZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4FD87842; Fri, 22 Dec 2023 06:47:07 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F7087837
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-58e256505f7so972716eaf.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703224021; x=1703828821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOryQ7w3gidg35P+EfyyA5WPqGiRM/M4EleU65ToE/8=;
 b=hU2kvNmZvW1tNvmFeiQUDzwviNmkDGHVNV6aZyfuOpmuV5j/so1k8UnSVY6Phb9s7N
 ESIMSBIjiGLDNVBbJdbr0fpQdRdUWABk6DqT8d54TFbqdNBVqh/cqS128WUCyMNDn6Xw
 +q8hQ1DitG9dXC+2zCNMVS33hXvxXANxIVaYGnRzGXVLMtqp7ArVHaTi6oneBI1RQ13q
 NkgWU410hNC0+yczTHWupPkQ0WxxydQEPTdhzS2t92j0ASD0L1FcVC4PhRwHXcBBDGl6
 pSobORlAaaPPllWQoueY/oJA7BJbSZ/YRxPbS7LCtX3s5Onvm/XXva9fbYq4ZS9phMHg
 Q25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703224021; x=1703828821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOryQ7w3gidg35P+EfyyA5WPqGiRM/M4EleU65ToE/8=;
 b=OwvDZ70Amtlq/FbBWWrheryoytgyMcteokWUzPLlcZqOOiuJkOjHDI96WxfBhfOWjj
 3qXke1tVBVayPlZNLHoJ56GlpSWm21eTZcc6SH/D67q6F0DwTwjYP7/tIjd79lgMHtpK
 7z1F101SCSKgwh37ZXZyTjjl5S2NdB4UNKibCZ6JPouSRnqrJemKlqp3TILgUtlg6M7A
 C12jZ/EeFqa13LezOSHglVCkCJaa3Rp3/suMwol96kWuWz0U4Q2NBzw6FOMnetnoBTgo
 7qJnWQ7m5K47R+UBhnnefbQyOxrFxifBy9M2XnMhvbcCEb4c+ODOdwCryLL7TfagtSYE
 5wnA==
X-Gm-Message-State: AOJu0YwU/Q/NfRJODC3rsminxDNdQxRN4dqifLYV3RXPHMr4XoXYj7bL
 H5P4FdI6YPcEppZEWkvgQYWyWboiR1k=
X-Google-Smtp-Source: AGHT+IFh6WXOEzX8s36ZjZQGl4Ew1lrJw0XGW/0ndSy4l/yLGR1V9obTmYW4Cw4pmFWRugOeQokNcQ==
X-Received: by 2002:a05:6358:4412:b0:174:b1f1:85bd with SMTP id
 z18-20020a056358441200b00174b1f185bdmr837007rwc.39.1703224021456; 
 Thu, 21 Dec 2023 21:47:01 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:47:01 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 9/9] mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt ID
Date: Fri, 22 Dec 2023 14:46:06 +0900
Message-Id: <1e205ee9275691afdc41129009a18dd715e6d1f2.1703220284.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
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

Infineon(Cypress) S28HS02GT is 1.8V, 2Gb (256MB) NOR Flash memory with
Octal interface. It is a dual-die package parts and has same features
with existing S28 series.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index f86e7ff8e5..949ceee375 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -370,6 +370,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ) },
 #endif
 #endif
 #ifdef CONFIG_SPI_FLASH_SST		/* SST */
-- 
2.34.1

