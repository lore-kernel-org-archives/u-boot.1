Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ADBCED274
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E9988E25;
	Tue,  8 Oct 2024 09:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="WUCLxumI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78F9C88E0A; Tue,  8 Oct 2024 09:54:46 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7512C88E1B
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d2ddb61c8so308283f8f.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374083; x=1728978883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBzxm+aREKgUcFHYLDiFO08abZG8kCT01YAI3AsAR/g=;
 b=WUCLxumINMoNJtfo0tps3ot6ZyagoG0AmmGUsb138fpv2GwOXH2QMdikhudwVZ0fFh
 0a0AM5+SEoBfkai/5e1nYbJ2FytfPsswkm6YZqqbIEN6Q1ob0phjE7z46deev6jup2tI
 IoMRPEjQyycq2jjtdhryaxKd30j5KoQ3IRFPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374083; x=1728978883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBzxm+aREKgUcFHYLDiFO08abZG8kCT01YAI3AsAR/g=;
 b=SLKghmihfIMx0NCc+UGABlIbQFbjKNnON7vObKr2YLDXo3cgCaVTryeRsxTDSNZhCN
 CSSb+ddgRnp66/sXsTiY7zs8k+5ZGNVvlIXUUArZ3NE63P6OsGlRJyRqJN2jDYTn5Wh0
 LtaimqHbQlYSVQwc6X9sceA4FY59+p5eu3d5SgSKQZqNnyV9LDPQ0eGrp/kJD8UHeoI5
 BMhR8xXbarAGH95SpqhVYEvMhM2aSxhLa2ofZwfE8OIbF1QuDTkyjVw8ld67mCHxRiwk
 U/eesEkLyPnA+QfR/z4yRrINCzTVW0gOhDy+bWjEp/Duq517hcHfhEuCeuAtsnr6MY/0
 iEhQ==
X-Gm-Message-State: AOJu0YwaUZrSOcoBeRyjw3xIs3+1IKwxuakFWUk5/ISu1etQVwHV1lF7
 O1W1DUPtr3Go3ezE858cXykM+33KR8DALaXEP7TcCLdWjpnhiTpSYRE9ljpl78LhK0e9J9U+ClB
 i
X-Google-Smtp-Source: AGHT+IFupay00qW+hFrD331wGeN+dE2WSYPK4wH68W+suZhHTok9YBDk3R8ZCJwRCZOaUfbT2bB3sQ==
X-Received: by 2002:a5d:574c:0:b0:378:8b84:4de9 with SMTP id
 ffacd0b85a97d-37d0e6eaae3mr12262251f8f.12.1728374082819; 
 Tue, 08 Oct 2024 00:54:42 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920195sm7403328f8f.50.2024.10.08.00.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 00:54:42 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 4/9] net: ksz9477: rename udevice_id tab to ksz_ids
Date: Tue,  8 Oct 2024 09:54:27 +0200
Message-ID: <20241008075435.1572727-5-romain.naour@smile.fr>
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

The DSA KSZ devicetree binding doesn't specify anything about the
underlying bus between the SoC and the DSA switch, so the same
"compatible" string can be used wathever the management interface
used. The driver must be able to access the underlying bus without
any help from the compatible string (like for TPM2 TIS devices).

So, rename udevice_id tab to ksz_ids since it's not specific to i2c
bus.

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 drivers/net/ksz9477.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index c8c6595d4a2..3756f48c9ba 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -574,7 +574,7 @@ static int ksz_i2c_probe(struct udevice *dev)
 	return 0;
 };
 
-static const struct udevice_id ksz_i2c_ids[] = {
+static const struct udevice_id ksz_ids[] = {
 	{ .compatible = "microchip,ksz9897" },
 	{ .compatible = "microchip,ksz9477" },
 	{ .compatible = "microchip,ksz9567" },
@@ -586,7 +586,7 @@ static const struct udevice_id ksz_i2c_ids[] = {
 U_BOOT_DRIVER(ksz) = {
 	.name		= "ksz-switch",
 	.id		= UCLASS_DSA,
-	.of_match	= ksz_i2c_ids,
+	.of_match	= ksz_ids,
 	.probe		= ksz_i2c_probe,
 	.ops		= &ksz_dsa_ops,
 	.priv_auto	= sizeof(struct ksz_dsa_priv),
-- 
2.45.0

