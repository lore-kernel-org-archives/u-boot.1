Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C97C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 06:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0646788A45;
	Thu,  8 Aug 2024 08:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QY50TW2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A249188763; Thu,  8 Aug 2024 08:00:38 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F18EE88A77
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 08:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d5f24d9df8so326859eaf.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 23:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723096834; x=1723701634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HVuJ//SuYNUDj5vA57mzdzx7RZ66yP0j4fJvcRoVJw=;
 b=QY50TW2K1qBrJWduvMBzG0wK+qd20a4s7IB9eRvLo6HSXqJRa1KKO4yBInDprbwMKt
 M4p1Gkxfv22PZvpoSr1/qdO6cyCQsvhfb8I3Dxuzm+L7PN8L5943Oq72j2EbF0aakkpv
 y1VA1cGMlII4dVYPUJkxx+v37v8qTRNCVsVEP+4ATU308U3OmTXB94rLqDAE2zwaTWLR
 I5yOfGej17PKXk7fQVJHPvC456rGmsex3nm64O9F2waPs+3NuhCxuPPlF/8pdtTeJT2E
 L6woi5N1vJ+ZeVU3/zjYdD0ayDMtUY46w/cwVRJF2XwdgEUj1TFmtACvQQZ+iNZuV9Ir
 rz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723096834; x=1723701634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8HVuJ//SuYNUDj5vA57mzdzx7RZ66yP0j4fJvcRoVJw=;
 b=Ip//VCHz+e/+V/uDJkQLaXQIeYk9rw4xnkVeXgMnrVxrEiPmesViJwKxQaYZKRiWI7
 m6B8c1ZXWuGjya5eqPF+L4HsvW8HQ6R2A/ZunqGWaijQFLnyv0NC2jmW6mGkTb+p8K8n
 vJ5VET+PYvCtCN2sZzTN4Awsu1J+vd8x5/nVb5CI6nxacOWsyUC0EOAEnDT5RXh50Od5
 inRntJcPVnAisLQGqxjClXT4a6GLgihzK8rexzyEL1OAu/MXDk7PBsnd4SwXepEC1Ygy
 buWe1bVgu0SIxQ5Mf6Bmq8877eaOO+9c4pVMPEU9ij76J2CsIsVvyMABaPfJHXDNH9Dv
 JIxg==
X-Gm-Message-State: AOJu0YytpWJaFISVtpMQrPt2l3H5sd4dAnqys82SEM0h2zYKAzh0jqaO
 wtsFkSjToMRMz/0bPOSWmfip59KZNhrYruVG4kYHzjv04Bj6tc3cLpQhtg==
X-Google-Smtp-Source: AGHT+IGZkQB28iF6KajLF1Ru7+xL/15c7UGBM2dEqJAK5GRG2clVoSGpX2RPyGZlPFR8e9dF3axltg==
X-Received: by 2002:a05:6871:b29:b0:261:22a4:9235 with SMTP id
 586e51a60fabf-2692b7aa432mr940625fac.32.1723096833606; 
 Wed, 07 Aug 2024 23:00:33 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b7653b4d99sm7819055a12.84.2024.08.07.23.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 23:00:33 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 mwalle@kernel.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 3/4] mtd: spi-nor: Remove SPI_NOR_SKIP_SFDP flag
Date: Thu,  8 Aug 2024 15:00:09 +0900
Message-Id: <b87c372691e30ea19d71858cfc2c06b96337b1e7.1722917617.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
References: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
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

This flag is not used in INFO table so checking info->flags has no
effect.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/sf_internal.h  | 9 ++++-----
 drivers/mtd/spi/spi-nor-core.c | 5 ++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index d3ef69ec74..57608750c9 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -64,11 +64,10 @@ struct flash_info {
 					 * to support memory size above 128Mib.
 					 */
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
-#define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
-#define USE_CLSR		BIT(14)	/* use CLSR command */
-#define SPI_NOR_HAS_SST26LOCK	BIT(15)	/* Flash supports lock/unlock via BPR */
-#define SPI_NOR_OCTAL_READ	BIT(16)	/* Flash supports Octal Read */
-#define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
+#define USE_CLSR		BIT(13)	/* use CLSR command */
+#define SPI_NOR_HAS_SST26LOCK	BIT(14)	/* Flash supports lock/unlock via BPR */
+#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
+#define SPI_NOR_OCTAL_DTR_READ	BIT(16)	/* Flash supports Octal DTR Read */
 };
 
 extern const struct flash_info spi_nor_ids[];
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 54fd2869a2..feafc48a49 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3013,9 +3013,8 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	/* Override the parameters with data read from SFDP tables. */
 	nor->addr_width = 0;
 	nor->mtd.erasesize = 0;
-	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-	     SPI_NOR_OCTAL_DTR_READ)) &&
-	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
+	if (info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+	    SPI_NOR_OCTAL_DTR_READ)) {
 		struct spi_nor_flash_parameter sfdp_params;
 
 		memcpy(&sfdp_params, params, sizeof(sfdp_params));
-- 
2.34.1

