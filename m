Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2057CED274
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B5988E67;
	Tue,  8 Oct 2024 09:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="UXYta65n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0B288D99; Tue,  8 Oct 2024 09:54:47 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFEDD88E1D
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d2ddb61c8so308285f8f.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374083; x=1728978883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Li9zTYLhvA5ml7Js/3vi6ETS6tmjO00TF7MY5wxO59w=;
 b=UXYta65nt8Kz/UnD9fJVvrdgwK5asVwLkwwzzzT2DcBHlrj1OJAok+LWot+SfSbnn4
 y/rZCruP1PPd873OMYAwEVUYktQA5iBqnb2AHVwSqHYQFEMzP1z3vv9SWRRndMFfGnrI
 bL5eVG0SpVOyumJkKvf8Hh2f/jiK6d37qFq88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374083; x=1728978883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Li9zTYLhvA5ml7Js/3vi6ETS6tmjO00TF7MY5wxO59w=;
 b=bEeCX7lstbJHP1Q7exSmZWOyZX6PC67LTXoKCSRrBrFPA0cDF7Bz/QeDl/WWvEcEtc
 bjxCW41QY9s/iXPQ4HgxtDtunmtFewdzHntgylJ9PxmmKW0G6xjccyPy8mjNJRvCy+of
 b3PfsU87AWTu0a4YOetyBeDrYJQZiA/TS7CFZuSZNcodFl408U+SkzpiGZHe3/VyM+Uv
 wJ374N1EjJlfCb8JYrYKsrOSAaa+fx1n7kdn9fW42nn8L2yJMHI+PkaANlBRXIfCOx2c
 AF1yioGrOQ+OrKUrpW3h5SAKAd2UnLq1h2ZY0H2i4HrGEmQHJTOWdPwCjkxXtVJZ+VKR
 msEQ==
X-Gm-Message-State: AOJu0YwW6tEXssGK6/EqnPahdgiz0KBIS4/TjzwzrbzFuW4pjVBHYYGQ
 6xJhFhsQifp13N2XVbaAczxRlXdxKKlxjYBD11E84/fOdGsjP9pi5CfE7WEe/5tm1Tpzi3pOdBa
 E
X-Google-Smtp-Source: AGHT+IEQ2uKFOKI2czVg3agUZdLiGZlepD34BoxLrSsDrolZPAuXBenFr9dIDg8JQIHAy3kXUBP/IA==
X-Received: by 2002:a5d:5f46:0:b0:374:c6af:1658 with SMTP id
 ffacd0b85a97d-37d0e6eb8afmr15953469f8f.1.1728374083238; 
 Tue, 08 Oct 2024 00:54:43 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920195sm7403328f8f.50.2024.10.08.00.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 00:54:43 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 5/9] net: ksz9477: set i2c bus offset length only when needed
Date: Tue,  8 Oct 2024 09:54:28 +0200
Message-ID: <20241008075435.1572727-6-romain.naour@smile.fr>
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

In order to add ksz9477 SPI bus support, check parent bus
is an I2C bus before calling i2c_set_offset_len().

Doing so, ksz_i2c_probe() will now return an error (-EINVAL) if
the parent bus is not the one expected by the ksz-switch u-boot
driver.

Indeed, the DSA KSZ devicetree binding doesn't specify anything
about the underlying bus between the SoC and the DSA switch, so
the same "compatible" string can be used wathever the management
interface used (SPI or I2C).

The ksz-switch u-boot driver currently only support I2C interface
but will match a compatible "microchip,ksz9xxx" located under
under an SPI bus node.

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 drivers/net/ksz9477.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index 3756f48c9ba..ce9d4b8753f 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -510,14 +510,25 @@ static int ksz_i2c_probe(struct udevice *dev)
 {
 	struct dsa_pdata *pdata = dev_get_uclass_plat(dev);
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
+	enum uclass_id parent_id = UCLASS_INVALID;
 	int i, ret;
 	u8 data8;
 	u32 id;
 
-	ret = i2c_set_chip_offset_len(dev, 2);
-	if (ret) {
-		printf("i2c_set_chip_offset_len failed: %d\n", ret);
-		return ret;
+	parent_id = device_get_uclass_id(dev_get_parent(dev));
+	switch (parent_id) {
+	case UCLASS_I2C: {
+		ret = i2c_set_chip_offset_len(dev, 2);
+		if (ret) {
+			printf("i2c_set_chip_offset_len failed: %d\n", ret);
+			return ret;
+		}
+		break;
+	}
+	default:
+		dev_err(dev, "invalid parent bus (%s)\n",
+			uclass_get_name(parent_id));
+		return -EINVAL;
 	}
 
 	/* default config */
-- 
2.45.0

