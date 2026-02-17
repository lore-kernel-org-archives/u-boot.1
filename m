Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F415E909A3
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB9C83981;
	Tue, 17 Feb 2026 14:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=siganos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siganos-org.20230601.gappssmtp.com header.i=@siganos-org.20230601.gappssmtp.com header.b="vLJytV0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B85DD83981; Tue, 17 Feb 2026 14:56:37 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5489E80325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=siganos.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=dimitris@siganos.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so25530465e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 05:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siganos-org.20230601.gappssmtp.com; s=20230601; t=1771336594; x=1771941394;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yskncxlLnfOJlLX291110SPgne3nDYnHVokvLCXcWL8=;
 b=vLJytV0FRjJZU9MBrKCq3rPC0BdJYY4bx+veU4pQ8OahX21KnWdo0Bw1p/r7etJi0u
 xfbWlmvbjs6FcekNdfZfe2YmIC3TLEV1GkbZ8FDFaaUTGEJRACTCnWoQAXzdSZYVJI3E
 A5POx54giNkwPzvWaxc1ROKb2pG+a9JlTZRJ42xB485CO2tXFqetPaGZu0dF1RX/XBOO
 RLbvYB+DXGLeoQDi3z2A9uy2l4T583S0BgMZcy3eSZIkZMckG5/G/OuKK43XQLWSgdv5
 bzu4gROL1a+VK1mGKIJjyTQWy/ne5wqQBGxvNS0jDfPnXomZt9DX5DOpM637aQDyuT7A
 WCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771336594; x=1771941394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yskncxlLnfOJlLX291110SPgne3nDYnHVokvLCXcWL8=;
 b=CIP03ebSUrPR2EQgk7v43M+BSTmaM8G5kbXKev6O7emWO0M4j32f40WG7jXRBa40lE
 u9p1wHNYEG3tRcQQE1TuMIG3wV8ZOrwy62S9xGGZkQYpozwoGxfGhOdj9DkB0Webduhk
 RrYFWY3oRNQ5BWKvAzVYs3DO+s2+wRayksS6AHBTUozqPuPdq2ORP8fUaXwhMyOuMRuP
 WDQ/LIoHloiZclM+VpYFim4IsIne3bwr8/Wwjn5W/KgznVtv7YrSRSAsVt+QCGOiMoVF
 KS6NbzPkfDP1WsYvQ/Boxj5+wKnLEcI/bXRKv1EtZxA11rtS7W7Y0JQ9JkwlHOV/VNWh
 CRsg==
X-Gm-Message-State: AOJu0YxYZsk/zD0s3REBHbjaaVFnVyLCBkYYShteeGpheEs45h80mQsh
 TPvvUoyW0HzDkT/dCMfD27phQ+E4xLYaxwLRA/R7QA5Vy3euyf2u5E9Pf3q13j7H/Ku+F3b9+8W
 fbBP5Vqg=
X-Gm-Gg: AZuq6aIeLiVuzrxAkH2q+lWf42cXjvKp7xMn001Ca6AQBy3Bcsf7/cBmp6pnT+4RhcO
 sMwMOz+5u8t+cbRR9q7/lZJGImhRfus7ILhwlTfFxbIstUIIDyRbUA0MHRBof4OhQrI8JwN8ypM
 f0IUWlgItStoGDIMOIU6n4wusiwYYOp+HBVQ2Dt0fnbZ6PbSH6V5a4iPXVtxDVAqHsmG+9c+yig
 b6d5Ij1LOVc9nNA6gRMal2Yihu4I8R8N0eUCtWNpxWLqCyvWMASMMlqCHwaRkG+dW9kLuPA0Hc2
 seVuOENlqDXxSNj/mBaMh+h7n1ArOlYDaS/73K0UaiuANMHXq3coXik6BVDd1UBSpqcdRZm4aKN
 WnQwm1uoV6AnBrtrTcPnvW8OfZ42uUam/DmQIaiENU64xFrGEw6o2nnjxJ4Ib/qjIxKTNeu9Vkf
 /2bJOa97Bs0lHiNMc433KpBb0KX6FL4PwMomxpmvmXUsOAG0DNpYQIn3bf3Q==
X-Received: by 2002:a05:600c:83c6:b0:477:639d:bca2 with SMTP id
 5b1f17b1804b1-48379b93357mr160336165e9.4.1771336594328; 
 Tue, 17 Feb 2026 05:56:34 -0800 (PST)
Received: from tux.powerhub ([2a0a:ef40:1c14:e01:6e29:8a53:b7f1:7300])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm578446645e9.6.2026.02.17.05.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 05:56:33 -0800 (PST)
From: Dimitrios Siganos <dimitris@siganos.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, anshuld@ti.com, festevam@gmail.com,
 Dimitrios Siganos <dimitris@siganos.org>
Subject: [PATCH] spl: spi: fix loss of spl_load() error on soft reset
Date: Tue, 17 Feb 2026 13:56:20 +0000
Message-Id: <20260217135620.2176407-1-dimitris@siganos.org>
X-Mailer: git-send-email 2.34.1
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

When CONFIG_SPI_FLASH_SOFT_RESET is enabled, spi_nor_remove() is called
after spl_load() to switch the flash back to legacy SPI mode. However,
the return value of spi_nor_remove() unconditionally overwrites the
return value of spl_load(), discarding any load error.

Fix this by preserving the spl_load() error and only propagating the
spi_nor_remove() error as a fallback. Also log a message when
spi_nor_remove() fails, since in the case where spl_load() already
failed its error would otherwise be silently discarded.

Signed-off-by: Dimitrios Siganos <dimitris@siganos.org>
---
 common/spl/spl_spi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index e8e62d5f9fb..3d4b70f7c33 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -124,8 +124,16 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 	}
 
 	err = spl_load(spl_image, bootdev, &load, 0, payload_offs);
-	if (IS_ENABLED(CONFIG_SPI_FLASH_SOFT_RESET))
-		err = spi_nor_remove(flash);
+	if (IS_ENABLED(CONFIG_SPI_FLASH_SOFT_RESET)) {
+		int ret = spi_nor_remove(flash);
+
+		if (ret) {
+			printf("%s: Failed to remove SPI NOR flash: %d\n",
+			       __func__, ret);
+			if (!err)
+				err = ret;
+		}
+	}
 	return err;
 }
 /* Use priorty 1 so that boards can override this */
-- 
2.34.1

