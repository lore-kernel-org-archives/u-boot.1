Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29397CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83D684825;
	Thu, 11 Jun 2026 16:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LqqoEh3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45E884825; Thu, 11 Jun 2026 16:18:30 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B39584717
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51780bbc560so8762281cf.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187507; x=1781792307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=as587ucr6K1tIAluSsFzUEpNFEh1sDwtqCQH3oLABtE=;
 b=LqqoEh3FECk80xeetuUeES1jynjqRq4+CAGLyY/vWlxiB00HsIGBdspp+3o5mBdKre
 +7rZMxJm5iRg+LaJ8Az6hq+SA0EJaERfPEAlhieC+pp9inpAkyn3m7bbxyKBR9AVO+bv
 oHCts/a7HfhzVauI+WzciIRr/ckPQ+yjvVatMiySzrtlnIMV2qS+t88tkJuXUzNyAzhO
 js1lUE8ozkhWeDQ5ZyarNI9K6GBcIV2wNGQC+OCF9bIcF4fFIdfUXhf59nc8fTum/KPi
 Aux18qLLjXpTI6E1f/w5RNJCqK9gUOmSNUaYvkdQedmpMnYfKnPSIB4Glx28Jql/pVR0
 octQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187507; x=1781792307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=as587ucr6K1tIAluSsFzUEpNFEh1sDwtqCQH3oLABtE=;
 b=VOKmayKjlhXKcBfmRxrfWu9xGRROXpWAsMttOg8PskF1JhpiqHw1WP30Tt2YBTIBwH
 xKcHaFdzstawkUT5ArxxNkn4TqVYVSsuzDTQZI6Nkh4AzkLbgIHVboGkFBfBFlSqECS9
 joBMJabBmKUYouKAHLhTN4sLnpwMIUf9KeieFZ3rU/wg76L52mFzlW49ISe5lBs79XRa
 Fhm9lxNBLxbMTI1vk60vZaBWnuNeTKknmt1ypZDzr3WLIVOJwB1q2AzrWkStb2bvQlTp
 yvR09ch1MTTmN1kwrav4A78o1v8wlG/+VF7pMNzGpx2Q1wF49KWBagaLMD4VsSdsd5gp
 Dz0w==
X-Gm-Message-State: AOJu0Yw4/SziISmj46E1fLgAh3xZQy58qcKxpSNgu6bEZGMo5tpMz+qf
 d3SH4p66uu74OVfS/e8NklHsTtNAj6WiMx4L3YhYlN2ITH32fPhCjc67JG1W/Jy2
X-Gm-Gg: Acq92OFjtiU0y408O9NbnPVjAqcGE5arWVasTC2kvHsKz+F4OC6e20vsDlRMIHSi7CZ
 33m7IDzeX3Bh90pBxlM3EhUcuV489YeRfx8ER4gExQ6Z+M0XEu8cuX8bCrXxeVwSUcOYmEYLzDg
 Ym4nQ0jHqbIMbCOt2j9ui2ShceqvvKGmV9U6oVHWY4sYF46n3C12KUZWSZPa18LC7Qkde2MaCAY
 JRliqwpKb2DhU+FoedcCxLpcPzeczb/4m5sK+BxDeG1DyA+fe5UxrkHuaAnzlt5IDXpiUR9pLt9
 eeHMEtb22r3GDS6jccC4MHb671fPGOXzkFrDow8b79KXVn31HdTXUniGoheqVFgxJqun69cEXhA
 gKQCfHmskxTD1RwYOyJuKt0dnHeO1zTHQmRgEwfD+C6SaVHfZ7Pkh51EQ9dUQ2Tkmnz0GHsFHoS
 C0ikpBPDbNlptDtGuhh+UTBAHou5/QCZPHMq8ZMHQWKlGOg5Np2H5RJj9EMRXj+4mlPSm3drv2h
 gGeVzS8xtGa0OWdVCR9w20tGRf8VQ==
X-Received: by 2002:a05:622a:1452:b0:516:35fe:5524 with SMTP id
 d75a77b69052e-517eefac8e5mr33203641cf.5.1781187507245; 
 Thu, 11 Jun 2026 07:18:27 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:26 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 1/9] mtd: spi: select SPL_SPI_FLASH_TINY in SPL stage
Date: Thu, 11 Jun 2026 10:18:03 -0400
Message-Id: <20260611141811.68904-2-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260611141811.68904-1-raymondmaoca@gmail.com>
References: <20260611141811.68904-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Fix to select CONFIG_SPL_SPI_FLASH_TINY in SPL_BUILD stage.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
Changes in v2:
- None.
Changes in v3:
- None.

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
2.25.1

