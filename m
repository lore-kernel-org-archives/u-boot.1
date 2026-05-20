Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA464CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB4A84859;
	Wed, 20 May 2026 00:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="u737cf55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17FF484852; Wed, 20 May 2026 00:47:38 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91AA2846A5
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36931e4f5e8so3529885a91.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779230854; x=1779835654;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i3CvLAocAUIKMHeAkQNIzHH74BBbAjBOu9vFN3wCn1w=;
 b=u737cf555z9jvmkbBHPewGgPRqmJQ6fJKPFJ/hfmYrH17LYyDH5DFVB7gV3OoCv7xJ
 JLvkPyjyBNI6f8bgMe9fSuPWwADDr9iGWBLW/U48VcPb6P+WxrHclcL1ewChGyYZysdS
 S9S1V/CrjrRXAJa3tbaFi5CBcfGaMfvdSNy/jvs9OnfjIkuwtdT79yIhKTM17pevGADx
 iPAdMziJEedbr3jU2yNPWdB2ugyksJkXsfBnjs8VY73Mw6C65TyyK6uCkAGG3s6Q2JiA
 A6iCSqTr2BECOZHXaxO3KlsZGXsoxxzstp0pImqpMgxX8O60W4IGgwzj3x1bReRi23YE
 gldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779230854; x=1779835654;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i3CvLAocAUIKMHeAkQNIzHH74BBbAjBOu9vFN3wCn1w=;
 b=UihoRovMSS01JNc4E29ST8e8Ui9A7PIzSai6tYMfAP+mbQsZVuzFYyIFIloW4XZ9yz
 fYxhirrQKLpoqH+woMRBFSCBjR55G+X3+32R9naJtfllV+khPswpbPxSzRmzCia7+rnm
 J8nV7OB6fXXUqIY31X4+au7mVBf2VAMLbEzdJkyGmWXfrqJC4WU+jMCf809kbwQGQVeZ
 dC5gUKBiTGsGi/t2AyNWJcZrwaJjF8lxjef0efDsCFEtzUwgIP0YSXwxTOhlgpSdHXWD
 LKAfv/SFfrf8esMwnMIhreMzw189rq9De3WfKganXxKlnaN4BEoC6qJX7gvpl342Xb7U
 Mm2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wBlxU4kyibtpqTgZJ5y/AUlGLZG2qp03DUsjCJ6OfepY2rCA5yA9jxr0n/Vh6uTwQOb0/loI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0WeG8f6gvgoTozMjjidUhBy137QSCDNIEECbNwdZCXvlKLpvl
 ssksASOIsm3tDExk8otCb18pPAeYIgWES8SwNe6m828M8PAE+G7VZaagrFa+KtDIBFQ=
X-Gm-Gg: Acq92OFK9UbQI2w6zU6wB5IyFdNnPDQ0KXpeTZYJX6ZMi3SeaEvN7PerzfDiPuzj9Pw
 Tg7u8spCz4BLaKdsfkpIIuiAYchVSjzBQwdq10ySlECoPHCkckPrjPwrgJUPeWvfg2lJ/ItWVvL
 OnWmGobDXEocBksCIksWnImF23iVwNGb+IsBhhSALvjpKsm9FaxXvRpUdWBO2H28XcrfTMyApFn
 H1l5zlSldsz7Y7q5++pdkMfJo4i4cFYFsxDIz3zwikp+jXFUqyYM501+tpmzH1ZB+4xuxp4cMvP
 Ra+fu+no27pz1F0piQKX3DHYGvTe5xcFcRepp5uTQomwph7gxdTx+hhZrqTVNVZOLXZ9imgCswM
 xxMdrwXdLyHRmZ7eJr4XOEIGC5ufoIOPmqE2q2EZNYke2LU77bdjRYRdtBiY8PzUv2giXNe2iKs
 jHI0pYGfTmycrUTcoSP1mPoJVnAeNb638cyYAbdFYy5bU=
X-Received: by 2002:a17:90b:1b05:b0:369:223a:cb5a with SMTP id
 98e67ed59e1d1-369519af834mr19626948a91.5.1779230854090; 
 Tue, 19 May 2026 15:47:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4073])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a0e93e0sm5720707a91.10.2026.05.19.15.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:47:33 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 20 May 2026 06:45:46 -0400
Subject: [PATCH v2 2/9] mtd: spi: enable spi_nor_remove() in soft reset config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-b4-k1-spl-pinctrl-spinor-v2-2-8d25db98ac8e@riscstar.com>
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

spi_nor_remove() is only implemented in spi-nor-core.o, not spi-nor-tiny.o.

So make spi_nor_remove() only valid for CONFIG_SPI_FLASH_SOFT_RESET.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v2:
- No change.
---
 drivers/mtd/spi/sf_probe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index 7100b64bf22..dee03662d45 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -229,9 +229,11 @@ static int spi_flash_std_remove(struct udevice *dev)
 		spi_mem_dirmap_destroy(flash->dirmap.rdesc);
 	}
 
-	ret = spi_nor_remove(flash);
-	if (ret)
-		return ret;
+	if (CONFIG_IS_ENABLED(SPI_FLASH_SOFT_RESET)) {
+		ret = spi_nor_remove(flash);
+		if (ret)
+			return ret;
+	}
 
 	if (CONFIG_IS_ENABLED(SPI_FLASH_MTD))
 		spi_flash_mtd_unregister(flash);

-- 
2.43.0

