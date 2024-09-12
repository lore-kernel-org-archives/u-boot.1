Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C6CEE6457
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2841788EDD;
	Thu, 12 Sep 2024 09:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LT9ZTOGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F69988EEA; Thu, 12 Sep 2024 09:38:21 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B0E68898B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7db233cef22so356588a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726126698; x=1726731498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Gd7QV598tesaHMd3qgHpffU0QyHkrXadl3VbFrZhu8=;
 b=LT9ZTOGSA5ERwru79UoZy/KM/ANpaUDuwfWoT5U5thHFcvtixSpOvdbmoyq+50YQwq
 5CtoL2kipPcTWoHCl2Xs6JTR+c0mvyHM3nFJu1afWWRpq7GT2ASfg1ONTmtMeW9nz+9A
 PNUClAdRYpKdhcWd/KLwlI09+FFA/4FZAwgdMyJjqwtKKN9L6RSec9CE4BmydcqAlrdF
 mofecM86SIrgkR3CnmPSR9D3Q3jWAS98Q7KfMlXpDv7q1WOP04vcI7h0npaYpXH2TOVr
 xKI1WrDFllz0mDm6TflzQ5HP0pVdGZRC91D77sRAE8Ab4Q7oXQTmKLJi6hIq9k+MwdWt
 SoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126698; x=1726731498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Gd7QV598tesaHMd3qgHpffU0QyHkrXadl3VbFrZhu8=;
 b=tzRQ/AoMsyT+o0iT20fh4xq1kAkj63JahgOL1mIhzuBfXAJ6/01tBm0NxhKNFn/9/V
 +4/6zFzy6Y8Pi2cgp03F1JTH/fS4HUBHf4Nyh2aoF90XADe2KTgNeeRsq/l7pMTc/zau
 pWnDuphkf3q5Yy9CleHYSi/rSmFWDhLrvXzeJQdoFwMg2WcnSx9m+a9XFZd1MEyljgeI
 BjTCg7SsOnLzZ8Ham9JuOr5ZNlYtSbfVMcjdUJKFG2MJDtOBOOLkVl9ApWRDQ+BcbB8O
 HejXb6NlycUBMxNUOhF6+AsqM5VisktqxqdOanAlrE9emkSJouL4wXeMoEdEILOmkXUw
 7/AQ==
X-Gm-Message-State: AOJu0YyGNnUoMofR+lhG+z5ZIZTT5a9IlBaOMP62pCarW45o1PiMiWLV
 37F1brP8GPWCwnETs8dDuV01BtpuOPa/vSkogmQXXQp14g2NuVpvLTMd3A==
X-Google-Smtp-Source: AGHT+IF2154f+We8HcpaiLZuuJ8YhuhhnZuV2PgDK7i/Sm2NHnIFfy9HS7Cpgq1OnLXXR/CrJayc2A==
X-Received: by 2002:a17:90a:680d:b0:2d3:d45b:9e31 with SMTP id
 98e67ed59e1d1-2db9ff7b8a4mr2271425a91.2.1726126697702; 
 Thu, 12 Sep 2024 00:38:17 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db043c3b65sm9860822a91.25.2024.09.12.00.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:38:17 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 6/6] mtd: spi-nor: Set ECC unit size to MTD
 writesize in Infineon SEMPER flashes
Date: Thu, 12 Sep 2024 16:37:24 +0900
Message-Id: <13f37d201efd95ff0bb6ec474c0f9e10a6611748.1726126080.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726126079.git.Takahiro.Kuwano@infineon.com>
References: <cover.1726126079.git.Takahiro.Kuwano@infineon.com>
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

The Infineon SEMPER NOR flash family uses 2-bit ECC by default with each
ECC block being 16 bytes. Under this scheme multi-pass programming to an
ECC block is not allowed. Set the writesize to make sure multi-pass
programming is not attempted on the flash.

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index a8f3edc9f6..23e7124392 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3520,6 +3520,13 @@ static void s25_late_init(struct spi_nor *nor,
 			  struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25_s28_setup;
+
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	params->writesize = 16;
 }
 
 static int s25_s28_post_bfpt_fixup(struct spi_nor *nor,
@@ -3684,6 +3691,13 @@ static void s28hx_t_late_init(struct spi_nor *nor,
 {
 	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
 	nor->setup = s25_s28_setup;
+
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	params->writesize = 16;
 }
 
 static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
-- 
2.34.1

