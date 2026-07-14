Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF674C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 22:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB93A84A30;
	Wed, 15 Jul 2026 00:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/e53JCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B7D784A3A; Wed, 15 Jul 2026 00:18:20 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F1B849A1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 00:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a168dc590cso3273391eaf.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784067497; x=1784672297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WaKA6/qnDVQpvUa0Fd40y8wc9D7fJHyjfEfg7vDvMpw=;
 b=T/e53JCrWmBjC5qtA3dtPT0ALOKk+g9ojgcQRpP1u/4L0SbanAKjLlqxhGCn062EPg
 MbmGUgMRfMBMIYtiRHrXZ/pt1DVVuVIZ+vnl+Iv5cl24vvbozBheMv2Wy+N2ua9NJQ6A
 QkFvRz1YlBh514orwOfmGNypmbiww/uloktZxo4p6yoRlM9i9VbYioyDOZLNOuqhTm89
 IrXjRs3cqmaXhaFzlaJ97Q9T65yJUPEkyS7rS5tr2foDW7cCEgGUgpqJ0M4Kj8N5ShvG
 viBRWD8KD6zHDWuegf6YFHW9UzASXR0UR2k6qgGApWRknPbnJWYFs7NYoYvidWJG2FjX
 wzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067497; x=1784672297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WaKA6/qnDVQpvUa0Fd40y8wc9D7fJHyjfEfg7vDvMpw=;
 b=aa3syRnEyLRs0fafh/KdYi12gfrjU9hjKe8IBhhxxSUkpI5kJ4KDYGCLYMbR6DnNeT
 NF2lNWLvMfjt4w1JhQ/mAy5dEDsUMCKQYCkJ/Dc5Qyj4EGfkg31LeRTAswXbNDT0lMdO
 Aytumv/odwakYjKwxLmU+Hf1Q6lCUlSFrMR8zxXP0y78jYhQRAGl91wvKEyGe9asvP4h
 eTJgQ2dY9uLAZtjsM9PxNur7ksfiYJ7G0ZgsGfE3FbfV1fMMED4l7TeikXWEhMj7qTRS
 RGvW4Q0tlUflRr/UUxtA659+U/72RBHG6+pcS52cdA4eOERIMyAgiFRJ1VqRvZVbZvKd
 RXog==
X-Gm-Message-State: AOJu0YwJmFldw7ATHjtfCXAa5J8ZnDKUVejR7G0nt33wELwtdjd+Y06+
 A/gr/fZqTvyt7dzQI4/nculEh+dqDQWULR1Ao3eVLozzTs/E70gkY/IUJ3/83QB/25M=
X-Gm-Gg: AfdE7cn9a9UJ6ImtRgQdr3wTZHazJU1yXXsgB+AYAlIT3Ccx/JNOb5hSGRbNUJkAS02
 8Atp1Q7lVWG/6MmZrFGsDvTJDih6DziX8DrvAh9S6AVsP+DLv/hHbC9az4yLz2LJg/w7Csj/moO
 c+QRtKV3GYMjvffug3I3tXRE5Z+hlJW9sfjLVJ/rtLAW42yGhXqt62EMLZgm4hwHBb+uxkvHNEY
 EX5Cfvz8ovfNjWDAvF1MIrY41ce8tlrB5wKeecxQk8b+QfILWD/FBNa8OVossTeeeERWVsxXxvJ
 63v7m0RK/XzHKDxhVTxYARaim2Ozqd4gGJZpRJnuomX16LU98RkLn+FlKIrKgo499GeLbmdVmQH
 Xa51N7UTY3iRAQERrR7nMcj7cbdkllf0V2UKTVcEjyGNimIc6gPebGlqVXVEZ8Ax9cYXL0NWDS8
 f3PpYtEJdykSaion4N/vIm37P4XjoFV3DHOj2bgB+RbxN13EidMemu+nZ8q2fKOCYxeroLrVfcd
 i+DTT9M/p2gfWBMPAlUYXiBA8FCLCyLfpNdZRkveg+hA2LeqO11b4lVQR3ek3QpkW90BwnHzhDi
 zVdrZniI1g==
X-Received: by 2002:a05:6820:168c:b0:6a3:955b:8474 with SMTP id
 006d021491bc7-6a3c6008410mr3607914eaf.4.1784067496772; 
 Tue, 14 Jul 2026 15:18:16 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-11-8.hlrn.qwest.net.
 [174.29.11.8]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a36a5eee0fsm15090501eaf.5.2026.07.14.15.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:18:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: rawnand: add Toshiba TC58NVG1S3H
Date: Tue, 14 Jul 2026 16:18:07 -0600
Message-ID: <20260714221810.425463-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The TC58NVG1S3H is not ONFI-compliant and shares its first two ID
bytes with the generic 256 MiB NAND entry. Add a full-ID entry with
the geometry, ECC requirement and default SDR mode 4 specified by the
datasheet.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/nand_ids.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 4f46378ffe1..966972beca2 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -32,6 +32,10 @@ struct nand_flash_dev nand_flash_ids[] = {
 		{ .id = {0x98, 0xd1, 0x90, 0x15, 0x76, 0x14, 0x01, 0x00} },
 		  SZ_2K, SZ_128, SZ_128K, 0, 8, 64, NAND_ECC_INFO(1, SZ_512),
 		  2 },
+	{"TC58NVG1S3H 2G 3.3V 8-bit",
+		{ .id = {0x98, 0xda, 0x90, 0x15, 0x76} },
+		  SZ_2K, SZ_256, SZ_128K, 0, 5, 128, NAND_ECC_INFO(8, SZ_512),
+		  4 },
 	{"TC58NVG2S0F 4G 3.3V 8-bit",
 		{ .id = {0x98, 0xdc, 0x90, 0x26, 0x76, 0x15, 0x01, 0x08} },
 		  SZ_4K, SZ_512, SZ_256K, 0, 8, 224, NAND_ECC_INFO(4, SZ_512) },
-- 
2.53.0

