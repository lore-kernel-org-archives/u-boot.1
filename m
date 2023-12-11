Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE80C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31198778C;
	Mon, 11 Dec 2023 19:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WDyG8oFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F81D877A1; Mon, 11 Dec 2023 19:41:54 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D9F8777D
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c41df5577so17656175e9.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320111; x=1702924911; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pNnyvx4eNGEhHDkQIlC1OzHTU8GWB8vYITplA3RNTlk=;
 b=WDyG8oFv4F0l4mXDGtzuO1mIsfoTh10pU2tyNM1vCS64uY0SXYL5uYrIBf2BJwihD1
 ijghf+KFzQnlvYq6kvIB1iiA/Aps/omF+h5T5JAeszog6pbkQ1ShiA1N3Q1sQz4Ok9QY
 1LVEnd9mFgwiDAlXpQTJAZAHkCFKSDJHT/rTemkdkOFqr64WHaW9HASIhLiSvjWXqVqC
 8FIzLXujY7c4jAz58XbzBOioSH3oFDmRjKonTLf8VvenrSfPG+jB1gqXuvSnhOMryTLH
 0myIxQCJHb68eFqq7V42W96buNz11JT6vF9FLjROwadnM6NuLNe72GOZaf8z04DXD8Ts
 FmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320111; x=1702924911;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNnyvx4eNGEhHDkQIlC1OzHTU8GWB8vYITplA3RNTlk=;
 b=EjegFisD2UK0Da2YQser+mmrfBhBVLlY/uTDXgo+HxCweWzc/LLX4RcIi5Wh2xWyG3
 JgxRAFuqA+rRiv5siVYU5Z5c+Bdm0L2Fc4n8gF5iLWvBNMCLVhIlJ4fb0KI2TGxDn42z
 DHKSONJzwzrZK/xh8Rc78fOUNzMUq/7vCpsExKbT/M33SGgDqOlYuKlNF4ttBZO1NdwY
 +iLXZZyzU6+NOWSNGKcxb9GEU4H9aHkq3pBvDAg5VtzaM9GMGS6n42fjZriwWsrxZH2L
 sKiz9Z4OBWSaUYkDnbyYw6AzP7p/BcPBUVc0tRzdO2KoDmCs/REzZxg5OTcNSFAlTBto
 IOHg==
X-Gm-Message-State: AOJu0YynMOxbnny1/FThKreCCzX5A2LaONBrUD7rV6i2MOwiEv8pdiOp
 ih/bfRd3RnKyrH3JKlkDSHxysw==
X-Google-Smtp-Source: AGHT+IGohTtViP+mmntHRzMo1NeuN6fiX1kJxrplHgSdxqwi0DyUuowklmz5R5A/junUzDA4dk2uMA==
X-Received: by 2002:a7b:c3d7:0:b0:40c:3464:c93c with SMTP id
 t23-20020a7bc3d7000000b0040c3464c93cmr1267213wmj.184.1702320111654; 
 Mon, 11 Dec 2023 10:41:51 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a05600c4e0100b00405959469afsm13910422wmq.3.2023.12.11.10.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 10:41:50 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 11 Dec 2023 18:41:40 +0000
Subject: [PATCH 1/3] iommu: fix compilation when CONFIG_PCI disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-b4-dwc3-qcom-v1-1-46275113b4f2@linaro.org>
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
In-Reply-To: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dKEAc72f38pzTCgBApsbxdbuV1VDKhYyareG94mbQsM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTy8Lfy9iFx/AGFMns/5Kinif7wKBH+Z2bLwyHx0/t69
 eIlzTM6SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwETENzIybN5TLDvl8oM9RleX
 6U3Y8SLd3nnLzm1Mbbd3PWPy383HsI3hF9OpRdtu/2TyWDtD6uj23M++K1ljP+v4HYt5anpyetp
 0HkUA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The dev_pci_iommu_enable() function is only available when CONFIG_PCI is
enabled, replace the runtime check with a preprocessor one to fix
compilation with pci disabled.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/iommu-uclass.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
index 72f123df55a5..98731d5e2c44 100644
--- a/drivers/iommu/iommu-uclass.c
+++ b/drivers/iommu/iommu-uclass.c
@@ -100,9 +100,10 @@ int dev_iommu_enable(struct udevice *dev)
 		dev->iommu = dev_iommu;
 	}
 
-	if (CONFIG_IS_ENABLED(PCI) && count < 0 &&
-	    device_is_on_pci_bus(dev))
+#if CONFIG_IS_ENABLED(PCI)
+	if (count < 0 && device_is_on_pci_bus(dev))
 		return dev_pci_iommu_enable(dev);
+#endif
 
 	return 0;
 }

-- 
2.42.1

