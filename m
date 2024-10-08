Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E792CED274
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7BA88E3E;
	Tue,  8 Oct 2024 09:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="udJUJ6PI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EAC588E2B; Tue,  8 Oct 2024 09:54:44 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7519288D66
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37ccfba5df5so3464638f8f.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374082; x=1728978882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBjBXUshHQEoK9qQDj7Rw7IluyTzrLKyCNX5fHBYiEQ=;
 b=udJUJ6PICjbxc2h0NTLy/+ub98NvBEW1kKrJrmpOAKKX/YNlYb7Cnu8X3rR6fkWYKU
 OcvF/gZbd0mMcVHF8Zpklp1EzGefKj1yCcfSbCzL6mnna1++bF9iiCxj4RxkIljGM+aB
 wGIyTxJjyfeE1gte0JB9kC9SHt98nwWsBpGLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374082; x=1728978882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBjBXUshHQEoK9qQDj7Rw7IluyTzrLKyCNX5fHBYiEQ=;
 b=ivSpoXQ5Qq7LBNzc+A28rkc84UmyZu6+SDehR+hREM1VPWnMLwgi2zQ9g6qpjtIe1f
 3gJ4LGBrODG/lQEgKcLJ4ifTtFKSHH3lPv5vMT9i9brss+kqW8vqZJS5LIJJcmZCd3fC
 y4U8wQ7WQ6t7hU6FqWSB0dZCLwi7vo5yiNJtSrQrn2QWHFUE/8kKfnIhx+nFL27Bsz+n
 z3vgrw/rGEh2JyOwrH/+s2hGM1yjdIGacE9IPr5TkQ5ecnfK46CpQao09DBvZ7W6OwQH
 ioCPMvqhxQqFCwsMwpQidnlSM4fygdya34p2ueDFir6tY5QcXrIhFG9hIpKF4AwnccP1
 UQVA==
X-Gm-Message-State: AOJu0YzCrt47kRQs8v1gv4uPxIsW13T++VldjC+5Vj2O8O1N1gX8PbZw
 44FZz0hYcvZHWEJ966tsuGRLc7DdhXIvW3TKXfrlOEaYcONO5KyKVpZHXVUjQnZDLBq+IiMlLIZ
 I
X-Google-Smtp-Source: AGHT+IE+8R2Zxawch/7BAOh+fa9xiN9xX2dZj3m7HUt+/Zrb7V0oGywojo6sGk7iDssZ077yFpUw2A==
X-Received: by 2002:a05:6000:a82:b0:37c:ca21:bc50 with SMTP id
 ffacd0b85a97d-37d0e6f0561mr8201311f8f.23.1728374081815; 
 Tue, 08 Oct 2024 00:54:41 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920195sm7403328f8f.50.2024.10.08.00.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 00:54:41 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 2/9] net: ksz9477: remove dev_set_parent_priv() call
Date: Tue,  8 Oct 2024 09:54:25 +0200
Message-ID: <20241008075435.1572727-3-romain.naour@smile.fr>
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

The ksz9477 is currently the only driver using dev_set_parent_priv()
outside of the driver model. Also, there was no explanation in the
commit adding ksz9477 driver and why dev_set_parent_priv() is
required.

Actually there is a typo in ksz_mdio_probe() while retrieving
the parent (switch@0) private data:

-	priv->ksz = dev_get_parent_priv(dev->parent);
+	priv->ksz = dev_get_priv(dev->parent);

Printing the address of struct ksz_dsa_priv *priv allows
to notice the slight difference:

ksz_i2c_probe: ksz_dsa_priv *priv 0xfdf45768 // address of the saved priv
ksz_mdio_bind: ksz_dsa_priv *priv 0xfdf45798 // address returned by dev_get_parent_priv(dev->parent)
ksz_mdio_bind: ksz_dsa_priv *priv 0xfdf45768 // address returned by dev_get_priv(dev->parent)

The ksz_mdio driver get the wrong data and without
dev_set_parent_priv() the mdio driver fail to access the underlying
bus.

While it doesn't cause any issue with I2C bus, it override the
per-child data used by the SPI bus (struct spi_slave) and prevent
further bus access (even with sspi command).

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
Tested using the upcoming ksz9477 driver with spi support added later in
this patch series.
---
 drivers/net/ksz9477.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index 091e9689487..e67012a071a 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -276,7 +276,7 @@ static int ksz_mdio_probe(struct udevice *dev)
 	struct ksz_mdio_priv *priv = dev_get_priv(dev);
 
 	dev_dbg(dev, "%s\n", __func__);
-	priv->ksz = dev_get_parent_priv(dev->parent);
+	priv->ksz = dev_get_priv(dev->parent);
 
 	return 0;
 }
@@ -514,8 +514,6 @@ static int ksz_i2c_probe(struct udevice *dev)
 	u8 data8;
 	u32 id;
 
-	dev_set_parent_priv(dev, priv);
-
 	ret = i2c_set_chip_offset_len(dev, 2);
 	if (ret) {
 		printf("i2c_set_chip_offset_len failed: %d\n", ret);
-- 
2.45.0

