Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C144F9EDDB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B4B84359;
	Wed, 22 Apr 2026 16:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7lNswxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 838028431C; Wed, 22 Apr 2026 16:31:58 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21E084348
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6949831a7bcso1078324eaf.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868309; x=1777473109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBjqcJbQmtrI2trtC008GaGaTb/hb6UcohpHtGCVcZw=;
 b=S7lNswxPRiWrMkAa24BhVq5BU9tbGFzvw33IuA6KytXy4p1JtxFFKmtc7ObwO37erT
 Nys51tRn6jl5X9yC8d3GMShDkj7E2OK/tmppvMR0upyxZo3tshCVExSHIaLRlhLnBFqV
 61iIcdyHEuPgRy0/bmDjvS522Vg6PAoLnInnGjfP1X1hl+mntRqDCMSNcoqcnV+8Ojtr
 RXLgMaRrhHEBNhkncY2Z9DhphQ2CSIfohZGJR1SSJ/hMSr+dmw6ldYNrItWoGPL9M1BB
 IrMlXEuGAM0hQ9ppA8nWQiN6FsaI6XHS4ME10LWOlePMrltEMgNurJToUbclC6xGGgDW
 7cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868309; x=1777473109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cBjqcJbQmtrI2trtC008GaGaTb/hb6UcohpHtGCVcZw=;
 b=WYT3aL3trL1gCoJvcKwqzcDxQsOFAvfdIG4dVHwPNzxAbePEvTxuOkKJYklT9l/sto
 juGvS9FUkvU6ds9CCrN1+cmMk3I6MFNN06NKvST0EOgMFS1LBjXY+kQQLrXIB3NcDT4F
 FWTvUA4aO7qJwPKcO+1Bw79AML5pa3fILgpTdxT2lJ9yS2ecWROp8bOj8tfjIQv3Ir8v
 Vv4UafrbXafTYBY5w8b764fx5P3kZynEmCW9DsVPo+1n8k86auQUu3lGgqQgx0rntL7v
 d+MF4hMqec4Uwee0WUtohwoUhIArsk8L5yovSugar5hBlvjbCRFyH+O1lrp5HVO0kbmM
 I0jQ==
X-Gm-Message-State: AOJu0YwRseyB6phgvnVqv4IfaF4iROAP63ESgSnctROO2Q5spqXibWhw
 ffxbsL54UOk6AmOGxT40DWPPH7uCnr28r/xiYNun4/jUYNei8odVnMG7ebRkeim+h/o=
X-Gm-Gg: AeBDietGGE+ZIp8e4ax+gWrj825YexG2hBbnwVfQgNIax5kAjizFw8H8eMZbb1SRJl1
 VW6QVgWKD+4dJWqRDYmeAYizXhgr0bYA7L0KPV0CMIkRap8QXJe0Pdq+q2xmFCt7EgO/ZWNwqzY
 Fj5di90fIZVaWL4Z5c8NA1Du0/0rp9VmFtiuMYWpM+dYnwHKdIMkvCAwqk1AwYePw17uRR+iKkw
 rRNOyhhW006sOECkjBzwU3EednN5xktD7bx2zVP/KrW7iJBpS6LUuXUGhcEMvo8654tRtL27yc/
 e8CqqJka36ik4hd4fQooBstD8qX+CmIZH/+Pk6f+vxm5j4w6LLkOwhWzzD3jAEvBo48VHWmUvY8
 Op3gC9pa934cQLJuza0R72VdW2TlHFQAxwePHKQX+D9iJo2rZtjGxfYhBzxFB9EpXSwYiJmAEdw
 Dt424jWE82ytS4Unq8k/GdfNsh9rmzdd3aoObtNds0A1m+02x/a+uyhQwGfry6L629uwHYFU4Oo
 r4m6Ju4j2YLja84U9JbX62SrHmOPkep
X-Received: by 2002:a05:6820:1907:b0:685:3561:8945 with SMTP id
 006d021491bc7-69462f303c1mr12417462eaf.46.1776868309181; 
 Wed, 22 Apr 2026 07:31:49 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:48 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 07/16] mtd: spi: select SPL_SPI_FLASH_TINY in SPL stage
Date: Wed, 22 Apr 2026 10:31:03 -0400
Message-Id: <20260422143112.1329478-8-raymondmaoca@gmail.com>
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

Fix to select CONFIG_SPL_SPI_FLASH_TINY in SPL_BUILD stage.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
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
2.25.1

