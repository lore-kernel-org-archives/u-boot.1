Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC464C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 12:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5071988005;
	Mon, 22 Jul 2024 14:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="VpncJbWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDAD887FCD; Sun, 21 Jul 2024 23:49:37 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE93587EDC
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 23:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266f344091so26454265e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721598575; x=1722203375;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I2aykQofgNL3clYxvruvd/kAtBM18B7X0AR+45K8/mY=;
 b=VpncJbWeKht8/spqp/BSqBcczJrraGSuR4TBu1RreiSUEFDPIwWL2aPedwCLiR9kWJ
 NcvRXeHVvbRIcCApdg+q8yTvLJVqQwD3GywBkbCmVrzvl5dDCoItI+1+Z/PuCK6j16H9
 qxSWvzCAWt+4b0RNykshNdGMBqDNqj7qYdkXGrDsQWXvOmjl0tLrJc0jdZ8VSV+mMDRG
 nA5WJtvCympzXi75yB1MfKQoydz6CqehlkTQlO8h69fdbl5y5z+Xcgww1ofV6gkI1x0X
 BtN9imP/idZkL426cHtSHSoVa9MgFPD6GPh87m+yCB7Tg+cGcPo7Fd5AdmhO02/UojCf
 j0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721598575; x=1722203375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2aykQofgNL3clYxvruvd/kAtBM18B7X0AR+45K8/mY=;
 b=pN9GtEsVTPt7L+Cb5LZ0zYowKqYAaZtB9Rh4gkI1wkyopOhT5YTj2qgjELyGjzHSoj
 D8Rd+ps1woOphebYoZoJtZGtpd+lPAd0ZOT19AuEs1UBQ7FClv5pif1dRDX+A/zoTyTM
 qS+XzCjgumOwget4vxD5kD43HCjSfKuUsBZ+tvfjB9su9zmDfytFhdWQWu5HCRT5NoqO
 T+6Qehxj/PBIXsZ3Ruv+1ZS4wSARiHmQlg3N9zX6kkGCZDYmUVJ2nD2W4n3eU6Z5orv4
 i9q4jYiRqeowE2pYhmAhJ0qMkJFD3t8U8o0J6gI5hY7Xyc5e3ohMz2fFRbLNBnT9pLyM
 4ARw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU5xzTwqcBruZl2fReux8aMZAKleQOCPaM5mb9tYvdkU7mlGhbp3q0suo2GI61zejVR4CwgL0q0jiXfPYDS5qfQM/vNA==
X-Gm-Message-State: AOJu0YxSVfLu+inmrPrkYFP8gG97qAQjyJwxVH8QccYRoe/7OVb5O0CS
 KjnKa5fmo3jLWrqlYWyN0D5YXb4sNz1zWp2lCUQ3DHxBoyd6wkBtKwJusPCDpJc=
X-Google-Smtp-Source: AGHT+IEsS7JkNi3swrPA9HO38ixhcU6hPndvCawFe91uZ4jcqZPygr0ZTH83HnLytF64KHs5RTnDIw==
X-Received: by 2002:a05:600c:35d3:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-427dc520cbemr30617165e9.13.1721598574989; 
 Sun, 21 Jul 2024 14:49:34 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878811bedsm6818556f8f.117.2024.07.21.14.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 14:49:34 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Alexander Dahl <ada@thorsis.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v2] mtd: nand: raw: atmel: Use ONFI ECC params if available
Date: Sun, 21 Jul 2024 23:45:52 +0200
Message-ID: <20240721214552.63965-2-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Jul 2024 14:19:31 +0200
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

When ECC parameters are not specified in DT, first try ONFI ECC parameters
before fallback to maximum strength.

It's the Linux driver behavior since the driver rewriting in f88fc12.

From then 2 nand system refactors have been done in 6a1b66d6 and 53576c7b,
chip->ecc_strength_ds and chip->ecc_step_ds became
nanddev_get_ecc_requirements(). U-Boot didn't follow the refactor and
always use these 2 fields.

v2: Fix formatting, add upstream commit hash.

Signed-off-by: Zixun LI <zli@ogga.fr>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index ee4ec6da58..817fab4ca3 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1029,11 +1029,15 @@ static int atmel_nand_pmecc_init(struct nand_chip *chip)
 		req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
 	else if (chip->ecc.strength)
 		req.ecc.strength = chip->ecc.strength;
+	else if (chip->ecc_strength_ds)
+		req.ecc.strength = chip->ecc_strength_ds;
 	else
 		req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
 
 	if (chip->ecc.size)
 		req.ecc.sectorsize = chip->ecc.size;
+	else if (chip->ecc_step_ds)
+		req.ecc.sectorsize = chip->ecc_step_ds;
 	else
 		req.ecc.sectorsize = ATMEL_PMECC_SECTOR_SIZE_AUTO;
 
-- 
2.45.2

