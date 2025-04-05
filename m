Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FABBC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 22:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 801AC82ACF;
	Sun,  6 Apr 2025 00:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q7Lp+hFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A536982AF1; Sun,  6 Apr 2025 00:13:25 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B03C82ABA
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 00:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22435603572so29662625ad.1
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 15:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743891200; x=1744496000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2cz7z7swAMsehUYzLCEXH0BmMulWUocaKcOyYXatQE0=;
 b=Q7Lp+hFkYnMvH2MKCmlViJhe13juzvGaqJ0agovlx76g7iQaDyCXpRpthKvRxgw016
 6MSWs5D8LG+ap1oGc5Z6jvUPDcMmMiAsV6NCePoldl92ofakzmdwaWWbDafPF7nWAGak
 4VRHtH9yWkMawX1tfW7VOYKSj1nejv8tuHVtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743891200; x=1744496000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2cz7z7swAMsehUYzLCEXH0BmMulWUocaKcOyYXatQE0=;
 b=wPop+3QTVUOdKy8uG5JJ+/kgPkNwz+sWbt+Sdl6bCGAuAACPEEiQnRoXYSLTrO/5E7
 nsfXARNO1k6MDi9LgJVl8eLgcj1QuAXvet+bmItZszGSHw0BeVX1u0sPWzpc29un5A/q
 ePOQFPVgJ3zx1eqewxrPSDFivmqf81K9XR6usCs++Dez8eRwakwOQvrDo504Xz6JrPd2
 ilkR8NQFaB4e+lNxwOarGvViD1WSFJVL4z9O7EuZChKLfup7t48OiuMy+YlwR8zNSvUW
 zPPHYmpHqlI8El4Btw5fnei8ARrqlvEDa3OjZUmUX1eBhQ36+HX3Vg8od8irZ0Z1M1+S
 a2rg==
X-Gm-Message-State: AOJu0YwR7wMCJ0n9I2c9Lfpuw4l8oPipR9r9K4UsIuwqz+lkgzHVLbQw
 ViHcAiaGlkjQHZz9G8PRkfLod8DIjKQDMUD4EFiT8Lfc4vTsNozzLvSwlbx2P5safAAEB+FPFI3
 5Tw==
X-Gm-Gg: ASbGnctq+Ken4B9+XHSKISQ/kpCW7Ny07hSaD5Biy/EHXVA/i12erL2WmnOYlRr7wn0
 eIPle38lj8HE4Jl4exifbFRIor7Aj6QgLnfyXn0O706Aykw4a9Jqm1erikMfx1aJazyBoQcisMH
 nkqky/TErFG2eZt9ZKqPs1o3cVoSb9ZtgPd22Z79iYvLIKG/Wr7jI39qhQ/4uKeO7HTKOKyc1Vq
 WGswipJQ1zYXk34rRWcyjmtNS80K6yP1qL8KHAtEiEmcMUFkSB3NwW56xTKrjtclJUysPLR0ZRm
 27yRJb9tGX7DZlGqf50VH5hRtYfQCi1HoIzHnB8fdXI=
X-Google-Smtp-Source: AGHT+IEvGnykscaxFnS+ZZnVMB/dybDBbLnatqncsuJ5I9ory/UWzWZ51gmIx9+LUoOF3ZJcFjgt0A==
X-Received: by 2002:a17:903:2b0d:b0:220:d439:2485 with SMTP id
 d9443c01a7336-22a8a8745d5mr106438755ad.29.1743891200478; 
 Sat, 05 Apr 2025 15:13:20 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866e612sm54431615ad.200.2025.04.05.15.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 15:13:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, neil.armstrong@linaro.org,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 1/3] net: designware: Disable DMA on removal
Date: Sun,  6 Apr 2025 10:12:45 +1200
Message-ID: <20250405221308.498047-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

At present, removing the device frees struct dw_eth_dev but does not
disable DMA. When DMA is active, packets can be received even if the
driver is not active.

While it is possible that the memory used by the struct may remain
untouched after removal, any other allocation may reuse that memory
and result in DMA writing to random addresses.

In most case U-Boot does this removal in announce_and_cleanup()
immediately before jumping to the OS. No further allocations are done
after that point.

But with EFI_LOADER this function is not called before jumping to the
EFI app. U-Boot continues to run while GRUB starts and finishes, as well
as while Linux is starting up. During this time, devices cannot be
removed, as they are in use. U-Boot completes the removal when
efi_exit_boot_services() is called. It seems that this function does
more allocations after calling dm_remove_devices_active() although I
can't figure out where.

Fix this by disabling DMA when the driver is removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
---

 drivers/net/designware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 07b0f49ef58..eebf14bd51a 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -809,6 +809,7 @@ static int designware_eth_remove(struct udevice *dev)
 {
 	struct dw_eth_dev *priv = dev_get_priv(dev);
 
+	_dw_eth_halt(priv);
 	free(priv->phydev);
 	mdio_unregister(priv->bus);
 	mdio_free(priv->bus);
-- 
2.43.0

base-commit: bcfa94be955ef263d37918ef4b8f898ee8964c61
branch: eth
