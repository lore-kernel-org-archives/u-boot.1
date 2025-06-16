Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511ABC71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B23081760;
	Mon, 16 Jun 2025 11:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j9NqdrgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A6582CEA; Mon, 16 Jun 2025 11:45:02 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B9382CEA
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so35607765e9.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067100; x=1750671900; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=liVVlRirbVEUfzBE3KvYt+YqOszKN361X11v+frbT6k=;
 b=j9NqdrgIJNN6nN1YhCmV8lP08uu66sN9Lw9of64itBi3w95TilwT8X6Q+h+PLNd+lo
 S86RXtDA/lc9VBELYHRs3JubuOBrVpLAgXEOsZaPTvWGZORuVtxaQSmBynv5aJBT+oti
 DqOCjC9gB967VqWaGcVVgjZvQ/porSO2nL4k8jUOK+fQIHAw+7OXFPXTSCCX7pKmx8e9
 AayyspLLt/kjWm2l9fMXnVyHstVIPTivW+2CfpOMWvvweEUmattwifrPo4W6IgcYitMz
 WY9M6kIGh20IOy2StKYNViree1dLNb9UfAYxfN8AWQFWbz4gmADw0NIJz7fQ4IHmk2uT
 0SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067100; x=1750671900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=liVVlRirbVEUfzBE3KvYt+YqOszKN361X11v+frbT6k=;
 b=QiZG8lfkuZTImlprkKSPBSA3GbiP+BYLphbwi96io6/f9ibmk8bbmuTjtxX7KYlvzM
 O3m+4A2v6dWNRd1vgMhbE4W6c9HbB9rihhkCiNepc1HssAptJd8XBqRu61Iyd7dfJrST
 xQkWMMD7/YYtL44Nt7ZiA7oxyMafPBtrFlKEhMYhm+rsCjhfSCd8CA5pS3whi/6hswkR
 3J5w+PN5HS0kR9p5avvzPkBureofVSAHod9YaxSjj2BRT9m0pd0ba8tvZ+hVsGHz2E/v
 jVvykJQVAWQDiaBCyyeSWZNkZaw/b/kaUpXhqF59PZoY45EOR10z/exS9LOOeoX0NdHJ
 yE4w==
X-Gm-Message-State: AOJu0Yz4Jfp08mjCRS+uUlRfWIFNFO8yJxdS4zhebl99y/FTmMFGnJmC
 Zm4+vxdoLTnHUlT+Y3cgpKKCXpXoQcpHDBzHXdfsDO6d0DBJiPd2GTMGGxeHmHck1Ms=
X-Gm-Gg: ASbGncsdJ2QU0E/nSHAUP5El1qUnNxU45DX5xuNrWZJpfoaKwfHlL8L5f9v7cbGu/za
 pswPj1MoFIrqYhKoKK3jo7Uafa5XIv25HP8DcvcKNilyqd784DmgB4XGobGL/wQcSrbdtKcsfD6
 Pd3nZadlurzVeVxooT5hcyk/1BPIMeIgHCMCLYLulIrxGFppvGtZ32idcDO7VQDc0avKmP0DAtZ
 SZS45ZIRMbHObSAYDPdMSvkfBNNt1stF4uDPbhovl1kfmvAMtminLRqu1xJaVHgig4iZxWa/QyK
 LinPT4zV5lirEXkblJuJ+2QQmps185eyw84H/6+2PKpfqa+Rm0hA+c6E9G1hSScKCW+AASZJ5Mr
 tD5jM
X-Google-Smtp-Source: AGHT+IF40wDl2PD6PlonVyDcmrvcquSCierzg53Ql7qOa1m4kf1Tay/BjscUNYLNuUq8mZyQ33N2EQ==
X-Received: by 2002:a05:600c:4fc3:b0:453:9bf:6f79 with SMTP id
 5b1f17b1804b1-4533caecdb4mr73056655e9.26.1750067100375; 
 Mon, 16 Jun 2025 02:45:00 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm139308105e9.6.2025.06.16.02.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 02:44:59 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 16 Jun 2025 11:44:50 +0200
Subject: [PATCH v4 8/9] spi: geni: load firmware if required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-geni-load-fw-v4-8-e7df44205505@linaro.org>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
In-Reply-To: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=MbW3IcGv0zH4KKHlCIUROUWm4oaq1SfL5SkWGTZ/UKU=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoT+eOfdBTZgHQI/NadMtnbQ87x7vtNaHaLR2Be
 GNx8QCTdmOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaE/njgAKCRAFgzErGV9k
 to51EACb6TnIcLwstjiehLktasO6Dz0BIVYpHzbINF8dj8w3TYuWq6M9CnF8z9GU/IgCX1JDTyw
 WicMVnauTPQcbG4E08qehKzoUI8d6aDun1jNhMm6XUuk2KeTMySqcf/0MlTNChIdiuvytFHbBcO
 wdSMC2uw7NQA82frkRpZ5Pn+HIB/AEylQpUOaATRUNVDJeGGqqcLVaVcJAMjU0LVIdZB9OkcBWu
 Ae1n0zG3ayivt7sR1AWGPx+ESHTQLowdb5r3zj/dGFaWTKTl68nw43E9qU9KkrQDQPgK2JiGQ4N
 9SXrbm42rbYR7GOtloKWxhImgOc7N4cNY13qoYIC8D3BmVK3JO9pHk8/fZ8ar3B1EqjfdTkWiOc
 dRcUCkn7sZqeXQvJRPeqbIGSk6H79vMuMGEZitMjiOXbHM4APsQ//ip5ojhxlRNFMZeOZpL2uud
 93N+jA6DuZ+0N1t5En2ug6n0Smy8v/HrYnTN1YRYkpezjeXQ09iRycBYqbUwQuI+gUe6006NK7Y
 EjzvUScXnBxzdgzUVUadCX5mQHvNFTKOXiyenr9D4LqNCsxx7Rn39IHryIJQFLBhGWIwERXhPxH
 xv/k2pp/YPhwzKW1gGMgvF8XjwWonU/LxzHmqBUmhudPNhYo0NXySlRQG3K4VY1bTGA8111SzDb
 328lpKTy+Zi9F0g==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Attempt to load GENI peripheral firmware if we don't have a protocol
loaded.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/spi/spi-geni-qcom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 940f88115184992a088626fbb7053274f91cc3dd..48354c335385258bca95f637138ea7f4d6a30fef 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -17,8 +17,9 @@
 #include <linux/err.h>
 #include <linux/bitops.h>
 #include <time.h>
 #include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
 
 /* SPI SE specific registers and respective register fields */
 #define SE_SPI_CPHA		0x224
 #define CPHA			BIT(0)
@@ -535,8 +536,15 @@ static int geni_spi_probe(struct udevice *dev)
 	proto = readl(priv->base + GENI_FW_REVISION_RO);
 	proto &= FW_REV_PROTOCOL_MSK;
 	proto >>= FW_REV_PROTOCOL_SHFT;
 
+	if (proto == GENI_SE_INVALID_PROTO) {
+		qcom_geni_load_firmware(priv->base, dev);
+		proto = readl(priv->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+	}
+
 	if (proto != GENI_SE_SPI) {
 		dev_err(dev, "Invalid proto %d\n", proto);
 		clk_disable(&priv->clk);
 		return -ENXIO;

-- 
2.49.0

