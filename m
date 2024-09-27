Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273D9CEBF60
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DA088FF8;
	Fri, 27 Sep 2024 03:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5awgVWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B5F88FF8; Fri, 27 Sep 2024 03:11:35 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A211588F92
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e6ba3f93fdso966307a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399491; x=1728004291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXfGHuQ00ot6lpKphfeuAqi/vVJ2TFM+UElOeC4g5h0=;
 b=F5awgVWloXy9lBr81/iQ+rX/00RPZGGPMKg+vsIGQcJNvAWlqRZMUskw7jiStIGb4T
 mukV+qNI3suSZvXOXVKB7yMNsHLmgx9yLFIR9pHPiWI25F7enURF9Jce5VQX+VcA4isV
 EHH9ztvTxVESbNJzalFa7XXLCdPgyQGqQVue1lr9o67Jf46SfbpKwm4nY03OOloouszZ
 QPOLVnOJ5074V2ZQbdQCSW0RN87weBppkKQwxeDhbgNWFMDd5Sobzmx1GoVUT9GTv684
 94kSacp8to4YADC7akop3gpa8HDfLQxige6coWf85V0Q3ZIyhLdCtQpnAYmpY67c/FSa
 zWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399491; x=1728004291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXfGHuQ00ot6lpKphfeuAqi/vVJ2TFM+UElOeC4g5h0=;
 b=WWwv018oWMLxP5CgWr9tU70VOU4knW2nuKP/A2r5AEACGpEnFXqch5LUfCxobjMo+H
 vdPlRLktnYWA3YTvXExnt/IWTjEou+DXbSO+IyKIREyFGsO6qnQljo05YO6YOHERxPKr
 vcjpDXzVSJ1mNt36qM94gFZNJay2LPJ2lupQyBLKCShntjiQdH3PYWR/vdb6+Tpplryr
 kSmOGihT0pdGKMkvNm5CPhlhRnDFIgyOKIuvU4G/gHAXcCeiVE1Wcd/MAHyiiJ0h0mUi
 3O/2Pc6FulmyZt3WjayyZgQjonf7TyIlIsZ2BhqbyLWRKpLTBVQA7H9VWXkn8WIDjTzd
 uctQ==
X-Gm-Message-State: AOJu0YxT5hknAYygemMjutfiJy/neJtewNZS00m91azvrum23M0/x3fO
 5GU11PYH4ubvqGlEtVkhHi8mU/uGI80int4sG2SSl/dQEK9310u2n2D/UQ==
X-Google-Smtp-Source: AGHT+IF/D8AOj5hsZYom+CH8KW8RzS30VzuAJr92yGgNEfyX6G7d4zRSHzmw2YKr9fXBYpMM9dIyAw==
X-Received: by 2002:a05:6a20:c68e:b0:1cf:2d62:8584 with SMTP id
 adf61e73a8af0-1d4fa69ed48mr2177282637.11.1727399491068; 
 Thu, 26 Sep 2024 18:11:31 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b264d86bfsm524068b3a.95.2024.09.26.18.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:11:30 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Dhruva Gole <d-gole@ti.com>
Subject: [2nd RESEND PATCH v2 1/3] mtd: spi-nore-core: Fix 4KB erase opcode
 for s25fs-s
Date: Fri, 27 Sep 2024 10:11:17 +0900
Message-Id: <54042b6a721670b6cae177b2484c37a45cc3b5d4.1727399216.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727399216.git.Takahiro.Kuwano@infineon.com>
References: <cover.1727399216.git.Takahiro.Kuwano@infineon.com>
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

The correct 4KB erase opcode should be selected based on the address width
currently used.

Fixes: 562d166a13 ("mtd: spi-nor-core: Add fixups for s25fs512s")
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index aea611fef52..b633f3092b1 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3349,8 +3349,10 @@ static int s25fs_s_quad_enable(struct spi_nor *nor)
 
 static int s25fs_s_erase_non_uniform(struct spi_nor *nor, loff_t addr)
 {
+	u8 opcode = nor->addr_width == 4 ? SPINOR_OP_BE_4K_4B : SPINOR_OP_BE_4K;
+
 	/* Support 8 x 4KB sectors at bottom */
-	return spansion_erase_non_uniform(nor, addr, SPINOR_OP_BE_4K_4B, 0, SZ_32K);
+	return spansion_erase_non_uniform(nor, addr, opcode, 0, SZ_32K);
 }
 
 static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
-- 
2.34.1

