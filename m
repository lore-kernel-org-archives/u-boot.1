Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD42EE57C7
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD75A88E64;
	Thu, 12 Sep 2024 08:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CuqYpnXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9566888E6B; Thu, 12 Sep 2024 08:13:58 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639A588DBC
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2053a0bd0a6so6606895ad.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121635; x=1726726435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wfcg6apB0sGmTAFkcXVaPtP7HTG0dk1naJ+YnitWWnc=;
 b=CuqYpnXdNFnD8E0b8oF/NnJqH4+EY33EbObVOWkC0t317BgpG+6pw8AFdhsvztGVlD
 v8Zz4t9uTMYr5Houx9VJ5PjkpnBvJVezT8ucYhHcQgqJ17y/DVh2JN5X3ndbMtV9EerO
 6dt/20Vg/VqXsAzeg77/apWjODyL+aR0OEKNt4cKmTfwVSblnrg9eRMDE1vRuRBeSBcq
 2aJR678LAek7fBxlIgUFh4zF9pKi8+na/prbkZiIq8YzAn7r+ExVd1qAI5HBh1Al0tVw
 BHpx1UetX4OEpd+4xw/LbUsK0PLuog7AuLj6lx0fJLubWZ3YjLKW5KCrDntZCPuf2m+b
 ym0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121635; x=1726726435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wfcg6apB0sGmTAFkcXVaPtP7HTG0dk1naJ+YnitWWnc=;
 b=iV1zaqsy/e642MOyuPFn4TO3GtbMkq4rtB7p0oWbb5Hp1C2AsEVG9WhUASbZiaNIAK
 7sIBngkOkem/RisqfquwTQUGJnTNyptw3xySsfbFi+itDYRNUSkBe8BjL+pCeJ+Sv7uI
 6/qK60OmRGZ9Z0ed4SHsY4fHV/3Z1z3hJ3TWIFS7y665yXYAjaHS3Aqo9H4zP77QClDu
 Dlm80FUW2W+eoWw6AZ6X6+Muf0GiqleaOSPWl0PBdPbofh41ajeJzfRyE55LWEp/EdaE
 +4z09EIVp8KawV35bXMcVulIUWEF9I4RlgFb0Ci9ruy9owmh+bkdGmfDP3SnTiiDQlrx
 fW7g==
X-Gm-Message-State: AOJu0Yy6REmVx+VwULp11ON3NcPl6LUWY+ZOSaTTxXb6TCKCQLGG/Uri
 d5f/fvc825hM5ul2htsCJK+/zPFvm7TaQMLK3rLDBgw0sRpnhoMp0H5ESQ==
X-Google-Smtp-Source: AGHT+IF7HtgKtjPsAeJHIEUIRP7LETjUfkRPrXZ1av3IMSXRIbhatJ510LtDori/tVIxR9eSFlLxIg==
X-Received: by 2002:a17:902:d503:b0:206:8f21:284e with SMTP id
 d9443c01a7336-2076e3f8533mr19051775ad.42.1726121634715; 
 Wed, 11 Sep 2024 23:13:54 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afdd046sm8214065ad.166.2024.09.11.23.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:13:54 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 2/3] mtd: spi-nor-id: Use INFO6 macro for S25FL-S
Date: Thu, 12 Sep 2024 15:13:00 +0900
Message-Id: <4ef92ea52672620ddd535b8ce9b5236292152573.1726120686.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726120686.git.Takahiro.Kuwano@infineon.com>
References: <cover.1726120686.git.Takahiro.Kuwano@infineon.com>
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

The 6th ID byte is needed to distiguish S25FL-S and S25FS-S families.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 88709a52b3..17e0f84e9e 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -339,8 +339,8 @@ const struct flash_info spi_nor_ids[] = {
 	 */
 	{ INFO("s25sl032p",  0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("s25sl064p",  0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("s25fl256s0", 0x010219, 0x4d00, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-	{ INFO("s25fl256s1", 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fl256s0", 0x010219, 0x4d0080, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fl256s1", 0x010219, 0x4d0180,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO6("s25fl512s",  0x010220, 0x4d0080, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO6("s25fs512s",  0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25fl512s_256k",  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-- 
2.34.1

