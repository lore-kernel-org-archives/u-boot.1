Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215FEF9EDDB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D8784353;
	Wed, 22 Apr 2026 16:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FO4NOOak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AB584314; Wed, 22 Apr 2026 16:31:57 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7889F842EF
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-68470763896so2974100eaf.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868312; x=1777473112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJQrUhf/+NFviOHocvIKyPkp9LpZCdfjoBdkPkubOg0=;
 b=FO4NOOak83wlokWFAH74LhGz0t0OkbtYyWlDygZo0hzuEWmD9fcYAM7LAxRBpgLS8d
 dc3qYG2gLAMsgoR4R5DHfvvTE8So4rS5oFMgQ1VI78gTTDvsjl/yUobesBFL3bWZzsqM
 eFJ0Ij75dVk2yh9iz8I95Z88HclXT5Nh39PJP/fLQgyxJvl42u34lVk7o2oekuq6Dv2z
 rLoYkN+ja+166xMWCBCIkDhc4ngpc64q4W5b8JRcpRchzKqEGcMTzcBtK1dKypTPv6pU
 56jQ7VPYWhVkCnYI4buO+nOwMujYKVMQMLse56RkVnx4nYFezmpxLRtfQtJX9O8qNOIc
 ZRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868312; x=1777473112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YJQrUhf/+NFviOHocvIKyPkp9LpZCdfjoBdkPkubOg0=;
 b=R9wDBG2RgsIgyUuEO+trJliwpjF9XJ5F59dHJqUPx/y61iDLTWQOLvRAhmz0xVdGdJ
 DBVABp6ADkfCrLzZnB6v3DkuqXayMZi8e+5PIlqUVWF31KZr9qOFuf6xzT+TkJ0LVGdE
 fWApnWhxuOiXAfnklc0skbjBMj+sw6Ps+YaCvOJgS21hTVYQFVzXWK1lggCoeSY4+EZR
 TDY/9d3rUxUhPmKVZoOJg+Uf0KvbabMcxFUZKi6i2VdZQ6CvuFUQyH0xbehNn+oQJkZU
 33B3Kz/XaaCWCIFg9y06KywwZwZ77+n6NuOBw5+nXnSd/21UOjIBhHlV1DXakEP3Ojdy
 EEWA==
X-Gm-Message-State: AOJu0YwiZGRuVDWT7lT+1GvNZNNMj3a751MIPthGQ8cA5uYAR6jeZkYq
 h8ApWDEPfCR0oU3L3Xlbmvw1QLcj+9e0R+g067ac2i3GhmQ9noeWzxr0aELkVklu/H0=
X-Gm-Gg: AeBDieu/r1fschwrKTnHdieCNh5SzrVuGXmHbjD811rEkP3Ri4nKZX782UeiyqKVEwG
 M2DgcvVID1WNVHZliigz4Y+BdfgR7U2ehFF9wwTMWpSrL/5XR4tZF6DVBctFiWWXpNaREdlLyUV
 JlcRmsA2vYol3F7UAEps6fjIDZ9c9+H1wGPmclz3U3hZdu3g9ZeHyULHNppzmjColzkpcN/zczv
 rkSLJ6eRU2A3bAICNQlG7MhdcX9Q/3xlbJzpIEHwS3EFCI1ZzMNOv53RYVsUcVpsPIM2BeV1S/9
 X1umqfA6WcVIYsZKGs2IoyQINUg9i6luQq8VjmtxILK355itChEbW7fKnJ+gLqLUCrJyiQ/Jg0Z
 OLlJxpr4lQwi7u2+26hgHyOgTafUJ+vp2uSMoFfGfeCmL5BU1hsmbdeqJUtIiKAhgs9CeErV3P4
 XAUp4KOMa2RZ4mkW+/ljNjrl/v6u2TGKcaoegrifhc1MFfXwSAnWpDRLZhQg67FK4dpAYIk9D2o
 WDjsUK/67s7Zabi2AI9aoLXpXrxZ8Ez
X-Received: by 2002:a05:6820:f015:b0:694:84f3:612d with SMTP id
 006d021491bc7-69484f37b85mr7774319eaf.44.1776868311831; 
 Wed, 22 Apr 2026 07:31:51 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:51 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 08/16] mtd: spi: enable spi_nor_remove() in soft reset config
Date: Wed, 22 Apr 2026 10:31:04 -0400
Message-Id: <20260422143112.1329478-9-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

spi_nor_remove() is only implemented in spi-nor-core.o, not spi-nor-tiny.o.

So make spi_nor_remove() only valid for CONFIG_SPI_FLASH_SOFT_RESET.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
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
2.25.1

