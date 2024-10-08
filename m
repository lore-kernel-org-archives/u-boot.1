Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F9ECED276
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CE888CA8;
	Tue,  8 Oct 2024 09:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="pon0w2+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C9288E49; Tue,  8 Oct 2024 09:54:46 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AB188CA8
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37cc84c12c2so2820765f8f.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374081; x=1728978881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGlcBd2MQn1f1A4jorBeBBZMjIj9IWg8g2X2MdSlJ/g=;
 b=pon0w2+JfzQkVkBR8QNNPs4Hi/JiSWfIHCb5mizSQG0Dc+5LVx8pYUhYtQ25jfEJx4
 qqsDbkgTBYE7hFMWNjOd5Oug/lYfxgiBlNhu6wIF1CG+qv2sO0bKBKhsqdP8uVU+VRac
 N3Epf13/CSeuc53AIdAxErQsUbb7KnqhNsH04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374081; x=1728978881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGlcBd2MQn1f1A4jorBeBBZMjIj9IWg8g2X2MdSlJ/g=;
 b=s2nn9oq7O/1/+5VMpA23UEgaoZhRkegoC26Bqi0JVyeXQ9a3cV6CvAPzWcyOVoTGDV
 TzdIgtSIHHmxtT4IdgUwGToJRLHHptVA6Sp4fCew9Okg0bXSRADx/O7VkN8QHehby1FK
 xC3mi6+9x9OdwuXHbRkxuDkqObRXib0pD+g7ctjVTXFvnbTCsZszpRgxDN6hK5hZsLcv
 vOIUA2Kr4H4cGEOaw3srsq25n/nq8EM246JyZ3q/FdyylG3dF5o2XHosBfg+bRr1H2vZ
 78DWxJeVnuFFK0kMwgTow1aBt1e5hXAaJI1SdXyF0T0IHd/YYvd04UulWNUkyPznM7R8
 to+Q==
X-Gm-Message-State: AOJu0YxhjRrHEKNKYz1Xi28vKJdGZD4aDzozsCq+EBN9ZgEQ2ESEU5VR
 MaPN7Leu5LJhLzw8bs5jdSjhhM3JWat1t7oATMul7FpcZy2oqbEHvHZepD2rZ/FXOawktFBRrK2
 G
X-Google-Smtp-Source: AGHT+IFq/3YEw+8u1hJleD01dNWUlIJKJk2C8zi+0rmeKjbrhiDsoco6sQ0hdtP/ifV9/43pmGjYVA==
X-Received: by 2002:a5d:44ce:0:b0:37c:cfe4:6997 with SMTP id
 ffacd0b85a97d-37d0e8edfd1mr7462915f8f.47.1728374081416; 
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
Subject: [PATCH 1/9] net: ksz9477: move struct ksz_dsa_priv *priv declaration
Date: Tue,  8 Oct 2024 09:54:24 +0200
Message-ID: <20241008075435.1572727-2-romain.naour@smile.fr>
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

struct ksz_dsa_priv *priv should be declared before dev_dbg()

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 drivers/net/ksz9477.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index 43baa699619..091e9689487 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -355,12 +355,12 @@ static int ksz_port_setup(struct udevice *dev, int port,
 			  phy_interface_t interface)
 {
 	struct dsa_pdata *pdata = dev_get_uclass_plat(dev);
+	struct ksz_dsa_priv *priv = dev_get_priv(dev);
 	u8 data8;
 
 	dev_dbg(dev, "%s P%d %s\n", __func__, port + 1,
 		(port == pdata->cpu_port) ? "cpu" : "");
 
-	struct ksz_dsa_priv *priv = dev_get_priv(dev);
 	if (port != pdata->cpu_port) {
 		if (priv->features & NEW_XMII)
 			/* phy port: config errata and leds */
-- 
2.45.0

