Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE5FCAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 14:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E6F48340C;
	Sat, 20 Sep 2025 16:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YDSW87lU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28EE1833C0; Sat, 20 Sep 2025 16:37:10 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F0008317B
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 16:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso1632652f8f.1
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758379027; x=1758983827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZOPjI97S3K4gHfPy2wQRK0zhjUznOO0b5LS5e0jAv1Y=;
 b=YDSW87lUinKPsnd7IppPWwwyZHZYQobRTlOW5R78bVpAfgB+KEX6h+tTgfWsmBWDxq
 0rc0muQipZkLaVoDdar+rbOmbnifyAuSsOH4h7t9QxIgwwsmtj6uDI7ONvFj71Xtr5HJ
 S898Kq3TnjXgZpy6LXeWMwx9BHRQrPaz/mXsslQ1E+dz1qSGtrsC3QO/9SPqZ1NRHmf/
 ExdPCVBhzLDnCuYVJfzVP5/8+719MCBOKvfdJUM05BswiCkoHrA3yG14tdZc3zpysvHW
 umxb8rA1NdyHzILdkSP6oY+obWaYCV0MttfEAVQ7H4njM7QBIl2E5MVd/be28Lr91npV
 5bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758379027; x=1758983827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOPjI97S3K4gHfPy2wQRK0zhjUznOO0b5LS5e0jAv1Y=;
 b=GaifnSbpMAiSIa6ErjrOk3jhoD4w/WXc6OHCibtxGZNdvd9oAqULHVwWOo0AINgGT/
 1TP4v5Vx9ECthJB7FnRvv4NLZISvM0NLZ9K5OZuHPxjhfXeNzH/fAE/o0hfZjiutLv3Z
 SF/WHzalhPDYmXxjB3ZbGG5p4BpcE4mX8aV/pD+BaenZ/sG34COMPcDbZt2/mtJcaiqW
 YgycyNNF7TQ8RK5c9M3okv50GrgwwjhLYVjCIvfM2sI2u+5yz1sygK1En1gLfHqjn6+0
 eY6qRMrQAG7LvYaPjCI1JTvouedh7QbReT8JVMg93PE9onB3eZ+t8Uo59wV5H+9eKNd4
 B6uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6XzGW6eKH6bY3j9bSwbhvOc5C/DMcNsGY3zGDjLbTrWHbcYhZc7VtpHTPwbarWmRTUpn7uYM=@lists.denx.de
X-Gm-Message-State: AOJu0YxOEv9e+jugZX7cJrkLRHR8JpvG8pHekAz7MHhExw5eZxSnNZzd
 9vdwv0Cw519q0mJBs9PHGPJDCyhBkFjbJ9tag/Xn57t6CfRveDEMjM7K
X-Gm-Gg: ASbGncuMRb4AcqHAOG456/JrydPV1Aiswh6FwYXi7zevdtFdoIxph21lJNuLMr/SjOc
 GfCb/kRfN5uEfRFQrTFrkcjmBQyUV5CiieqRuEv1maebiJxYhrO6atKPlLZJLf+uFrD3hCTqKXd
 oBNzqzB1k6cKT4ucoBY2MrvswCg9TXTIXvlSldznZwtQTjhfQc+Vxr/mWx+bnolWZBvjoAsz6aw
 9WNSRKtvaDHml1F4eD+gH03TA8/V3UN+iXqfs6lQue/W08JDrI1vDZn03N/54u+G2nWsQBsEgRd
 blaxybf0s5/IQrVwXEwD1lai9s8QWlUOsYm0AULOOzBpBUhR2ULFzMN4XS3djpJhz0smLX7pTo5
 q6UVJkF7ukHN63yrtkaYh4v+/4DpQF7SAmVrkm1dbk8XigeDdJevYNB528KlF3wQPFWgWTi5Yfd
 cVXnMrtw==
X-Google-Smtp-Source: AGHT+IHpQDrOL7K+fdIjIKWUoYkBboFw4TJ3jrYS4UDiPGflQVlDBl5XD0zNVxNPW/b9aw1dHp1KwA==
X-Received: by 2002:a5d:5846:0:b0:3ec:1b42:1f90 with SMTP id
 ffacd0b85a97d-3ee86d6ce19mr5702754f8f.60.1758379026828; 
 Sat, 20 Sep 2025 07:37:06 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fc00a92sm12353716f8f.63.2025.09.20.07.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:37:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 3/5] net: mediatek: mt7988: free allocated MDIO bus on cleanup
Date: Sat, 20 Sep 2025 16:36:48 +0200
Message-ID: <20250920143656.29770-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920143656.29770-1-ansuelsmth@gmail.com>
References: <20250920143656.29770-1-ansuelsmth@gmail.com>
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

Correctly free the MDIO Bus on calling cleanup function. While at it
also fix a copy-paste error and rename the cleanup function name to the
more specific name.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mtk_eth/mt7988.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mtk_eth/mt7988.c b/drivers/net/mtk_eth/mt7988.c
index 74e16bf49e7..797070add7a 100644
--- a/drivers/net/mtk_eth/mt7988.c
+++ b/drivers/net/mtk_eth/mt7988.c
@@ -146,11 +146,13 @@ static int mt7988_setup(struct mtk_eth_switch_priv *swpriv)
 	return mt7531_mdio_register(priv);
 }
 
-static int mt7531_cleanup(struct mtk_eth_switch_priv *swpriv)
+static int mt7988_cleanup(struct mtk_eth_switch_priv *swpriv)
 {
 	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+	struct mii_dev *mdio_bus = priv->mdio_bus;
 
-	mdio_unregister(priv->mdio_bus);
+	mdio_unregister(mdio_bus);
+	mdio_free(mdio_bus);
 
 	return 0;
 }
@@ -162,6 +164,6 @@ MTK_ETH_SWITCH(mt7988) = {
 	.reset_wait_time = 50,
 
 	.setup = mt7988_setup,
-	.cleanup = mt7531_cleanup,
+	.cleanup = mt7988_cleanup,
 	.mac_control = mt7988_mac_control,
 };
-- 
2.51.0

