Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CE9CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD53084862;
	Wed, 20 May 2026 00:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="jReVQP+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C69584862; Wed, 20 May 2026 00:47:12 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C28A84869
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3660ab73adbso2916681a91.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779230828; x=1779835628;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WWwwVxI+wOS9RPHNfMvTgXJhOpM69kSfgnO0REWSuLs=;
 b=jReVQP+eay01hu4q/4uFf8QqJnaukVeuL3IkTN4no9GL7AtiSn/Dg0CmIUEiKE51mL
 77mgojTdXkj0Imj6D65JdZ+0McO2/UAuH2XnckBPG7hzBs/y6OCyfawJF2QzntPyuLoW
 R6tHMTAl4AHsdxWgmI8yDGPTYDAatXFD6i618t3xqLilwaVpBPKU2VdEtOp7lsK2TcZj
 SLwld3RAP1SuXCW50q1m0d95M+Ec8IAHMLrumbvI+Lx9ixUqOQlL09Q9N32P3Tke9/RT
 s+q2kDy62d9BLxzXYMhbqtkZQ8TmB5mjOGlCNjoM1jZ9v4Sf3oVRWnnBtkKKO7WA7kBu
 XKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779230828; x=1779835628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WWwwVxI+wOS9RPHNfMvTgXJhOpM69kSfgnO0REWSuLs=;
 b=VJ6nXoVDg40RhCNY7Un8H7A9k/BDwpxR818b6DlOzeMj8zbVwST+Y0Gf78h5WFz5G8
 p1wwB6YB74zTC0wo0/55FNOw/vYvGYFPmwP+M6nck6ys/8T4WHi6aBKcgOXs+FfJnn12
 b9YbTYFQNCtWbuHfe/y1Mk7kNabaVyql4toIQhUAwaQmnLnu9LT6Dh2xc85TCN7et6DF
 C668M5wdoXGPJjUThDMCD/RkDPq/6brUpnF+JDTz8CLa43xzw/1g7SPeScYrhAZHjRPu
 gq+C+upQJlidrPFPUFX5RodaY0eUUQYiz6CrQ5ThYf5lMvG9zvlaQBesFEJRh47D/IW3
 ySOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sGVTCTaA6qJ8R8a5gBJjWz916gKKEf65DzrAS9ruLLuZyZ1pSwUOw9fQlCxZHJ1PY/KZ2tVM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9dNBF4AbQ9lyLh51+Pi1e/3LA/sNY7K9xRnPVkdxR1Sm9jja4
 0AP7yhhQFjvxWJgTfjpe4vXBbJWY5T/Uh7YLCd7ImByOsixjjpo8fULo7Q+o7oPG21Q=
X-Gm-Gg: Acq92OEsUXJdnwbyYeBRywg6deNwlfby9IvFzSrt0cgxxK841/V64qITyKcVqe6aWCi
 iLaVeK+w37V8LZtykGOzD3h7E1LzeROJiSjua1BDs7ck7MLnssf3yhjgIapnvtRuePfc8Zmdveq
 Ca7IZujzaWIy0OfRPoPmI3mh4eDAvhtUGED+3yY+TJP+laPyNGmmF335hKl09v9uiaBdN41ptTx
 0+PqhMjLIt+g0kY8VZWHuBUDPy+2eEhQYxxCZJuO67QcBWosjV4zQEuOJtNXjDmlhuSu3n5y1Wr
 UhEgPGNIYxf1U0H9MMQ14+CtooXt3G4FpIA/pO+oZemAPdfu4OhH5A5NTtFu85IvQ/adxX1AOMp
 k2ClqxmuAYWmrn+Veq6qMiqRPVtXZ8GkQlkWBBxyH9lRM4oWd7MgllUZcpAEdLbdOcYVBEclrVc
 WbKfKKaNufvjdtrbWn83ZJuY9ELa5S6HFhwX8wNB0X7TzwGP/XdHNUqw==
X-Received: by 2002:a17:90b:1c90:b0:35f:c6bf:2bba with SMTP id
 98e67ed59e1d1-369235ff7edmr21181760a91.11.1779230828584; 
 Tue, 19 May 2026 15:47:08 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4073])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a0e93e0sm5720707a91.10.2026.05.19.15.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:47:08 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 20 May 2026 06:45:45 -0400
Subject: [PATCH v2 1/9] mtd: spi: select SPL_SPI_FLASH_TINY in SPL stage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-b4-k1-spl-pinctrl-spinor-v2-1-8d25db98ac8e@riscstar.com>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

Fix to select CONFIG_SPL_SPI_FLASH_TINY in SPL_BUILD stage.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v2:
- No change.
---
 drivers/mtd/spi/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/Makefile b/drivers/mtd/spi/Makefile
index 44e67cd913a..9a96be11e6d 100644
--- a/drivers/mtd/spi/Makefile
+++ b/drivers/mtd/spi/Makefile
@@ -8,14 +8,13 @@ spi-nor-y := sf_probe.o spi-nor-ids.o
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_SPI_BOOT)	+= fsl_espi_spl.o
+endif
+
 ifeq ($(CONFIG_$(PHASE_)SPI_FLASH_TINY),y)
 spi-nor-y += spi-nor-tiny.o
 else
 spi-nor-y += spi-nor-core.o
 endif
-else
-spi-nor-y += spi-nor-core.o
-endif
 
 obj-$(CONFIG_SPI_FLASH) += spi-nor.o
 obj-$(CONFIG_SPI_FLASH_DATAFLASH) += sf_dataflash.o

-- 
2.43.0

