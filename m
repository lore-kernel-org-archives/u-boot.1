Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F79C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 04:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0894188EE8;
	Thu, 25 Apr 2024 06:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5bwkAHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 836CD88EE4; Thu, 25 Apr 2024 06:54:04 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DDF188EF1
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 06:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so4574955ad.0
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 21:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714020840; x=1714625640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQ97uaxXVdtOZji3K4muQjhPTcpA/oeYn3xWzM8n4AM=;
 b=F5bwkAHGIfZg5tiFsdNLHpoLNLTZ3dRk0ZgxeGqj5mQi6PVyYz62XA/imI29gV1EFM
 DpReR+tep3N13zGaA4Il0j7PvQQnuHRjIEQba0j58TbIEuW2jP7pRyJ1r4bZhCr+LPpT
 YILmah+jE87fere4nmf7EeuJ/ueyTkxVDN9B/K5kRs+Hx46Uqnk0d+ftEga2hwl4jRhH
 n/zaa2VjC9bvUyyugYKMNpJbiPZWVtQzFYEboIvZISX8uw6wFtiuiAA8Ldhh/yYvW73o
 49t1XyJOI/SJ+JqnLJyjHQ58Ues6Vgxmz4qSPa6mGRdmDXE9DGgSoNnRcfXIRubhyVng
 FIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714020840; x=1714625640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQ97uaxXVdtOZji3K4muQjhPTcpA/oeYn3xWzM8n4AM=;
 b=HREaXbg21FJC/dMiWxpXmQc0xbLVwuMoKLTm399YSKKTbaW9Z3fQ3V71xcf6rG8iCZ
 eMJZtFnvWVqlD3wo7SoLASh1gIO1GTygdt/K0RxgObePa2f5x1ePrtd5izHKiaP0jkUu
 EoCiAl02uWATc3tYj+g+xwfn4cvx7m0vJ1N8qHN1+kZg/b17a9URDQTbVva+d6HCinY1
 jxjhUAw5XnVVCrNLXm3IGXRJ2ym3T8BnxlIv2zDM+xRQ577BJTx0yWnXRn3u6aaZVnZi
 Dkxo4qLvCJLSoo3SQCSy+NqJs4XgbxK5KOWkBVY+k1hBoU/6PLl5AmzFazVKqHk1S+mA
 pIxQ==
X-Gm-Message-State: AOJu0YyOrbomcSQrFIifVO2yF5IbqK/GiBUWasxw1YRcPiywSQWu52MD
 5wrrJ+3uc1kRTrFQDMpR/mh1VgDmEfHJnJ5+qA//8Oai0HJR0Jk43qydVg==
X-Google-Smtp-Source: AGHT+IFvcAKARrMGDzjyJENhAvWslOAO2fV4Iglmk6eeU+s/RCxxSUDFOL2t3EIjuOvRANPAHUOcvw==
X-Received: by 2002:a17:902:dac3:b0:1e4:61b:98c6 with SMTP id
 q3-20020a170902dac300b001e4061b98c6mr2694742plx.4.1714020840340; 
 Wed, 24 Apr 2024 21:54:00 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 p22-20020a170902b09600b001e7b7a7934bsm12754513plr.107.2024.04.24.21.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 21:54:00 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 d-gole@ti.com, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 6/6] mtd: spi-nor: Set ECC unit size to MTD writesize in
 Infineon SEMPER flashes
Date: Thu, 25 Apr 2024 13:52:16 +0900
Message-Id: <f6de1f875098451edad856ce00288d8221e7bbad.1714020303.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
References: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
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

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ee968c10e4..7985ca70ff 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3456,6 +3456,13 @@ static void s25_late_init(struct spi_nor *nor,
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
@@ -3620,6 +3627,13 @@ static void s28hx_t_late_init(struct spi_nor *nor,
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

