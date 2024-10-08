Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5221ECED276
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF1788E74;
	Tue,  8 Oct 2024 09:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="2ef17edx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4512788D66; Tue,  8 Oct 2024 09:54:48 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C748F88E2B
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42ca6ba750eso33175675e9.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374084; x=1728978884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Rt9h6f0HFmDRQJ2I1qSiXGZZIXSHInStnQJJlL2V1I=;
 b=2ef17edxlfzZjNz1JDFNx/7pnFrm9LY2CS8wsemEaS/6zDyzTaldz1CsRJ5yjIcbWP
 hCakD5p4Dg1unW9b4bdlBICU/KA1zyC+/+m61AcMh57dxrjPcGCTTGQNm78YrNRCXDbX
 O8jtidt5F55gjJo7eYO5fNe/qsm49wSFcU5h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374084; x=1728978884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Rt9h6f0HFmDRQJ2I1qSiXGZZIXSHInStnQJJlL2V1I=;
 b=XyVpQYO2qS+bRoI7MdP8VaOsEOsV03rtn/J1k0dvh7a94T2nBbycZpRqeRWHVrPCAU
 iu7Xz8IDMOBDL7VVS+dohsIeQbIXZu0K6vSEz7fjXEcbpalFiIGXe2f/ZsQS5/AP0XRz
 F7pH1nXs2hlrxr+CGrYpuL3/EDxznhTl6EpiCFU/Q1utcycPxqJjSPHF5Hd1CKpj2hQR
 z99S5qEphzDZVA/0T2VV6wFXh37+fbhGqzsp1T3pXvvQ5aMO1iHzv3MPuRd0u/jaNN/0
 62OZpzMlywBE3oVOtMayyb5mODYR7ZI54eGPXJDY8L9Oghwfe0nvolsYbb4vWsP3Cnnj
 5R5Q==
X-Gm-Message-State: AOJu0Yxdl8XrvwZN28atZDmiSxqfnJsctOB1CKZm+VRWfMDIjI4Z1YT/
 Iu/bObiKW56bPAgRZ5lEtZDFrHnrjJ3fZCZbQXrH0/Tr3oO+NlXDw+QuTxqGRnwVGfqeDmZ+edH
 B
X-Google-Smtp-Source: AGHT+IG2W1CrlUp+f4InMMPkbXORx1hJ1FR7dZx/kYSUad8o606kEh8MRiQlYy7eDvub93sKn6zngw==
X-Received: by 2002:a05:600c:1384:b0:42c:b603:422 with SMTP id
 5b1f17b1804b1-42f94bd946amr12323295e9.8.1728374084154; 
 Tue, 08 Oct 2024 00:54:44 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920195sm7403328f8f.50.2024.10.08.00.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 00:54:43 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 7/9] net: ksz9477: rename ksz_i2c_probe() to ksz_probe()
Date: Tue,  8 Oct 2024 09:54:30 +0200
Message-ID: <20241008075435.1572727-8-romain.naour@smile.fr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008075435.1572727-1-romain.naour@smile.fr>
References: <20241008075435.1572727-1-romain.naour@smile.fr>
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

In order to support management bus other than the I2C, rename
ksz_i2c_probe() to ksz_probe() since this function is no longer
specific to the I2C bus.

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 drivers/net/ksz9477.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index f24bf9943e7..82db533c4ec 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -576,10 +576,7 @@ static bool dsa_ksz_check_ops(struct ksz_phy_ops *phy_ops)
 	return true;
 }
 
-/*
- * I2C driver
- */
-static int ksz_i2c_probe(struct udevice *dev)
+static int ksz_probe(struct udevice *dev)
 {
 	struct dsa_pdata *pdata = dev_get_uclass_plat(dev);
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
@@ -678,7 +675,7 @@ U_BOOT_DRIVER(ksz) = {
 	.name		= "ksz-switch",
 	.id		= UCLASS_DSA,
 	.of_match	= ksz_ids,
-	.probe		= ksz_i2c_probe,
+	.probe		= ksz_probe,
 	.ops		= &ksz_dsa_ops,
 	.priv_auto	= sizeof(struct ksz_dsa_priv),
 };
-- 
2.45.0

