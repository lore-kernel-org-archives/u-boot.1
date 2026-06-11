Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8A1CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A54E847B0;
	Thu, 11 Jun 2026 16:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IT6e7rrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A0684874; Thu, 11 Jun 2026 16:18:36 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FAC83FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-5177b1a7441so110432281cf.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187513; x=1781792313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uk9rd9misoSU2hLdft4uoM6u27rVqJfwFULI/ZofLPI=;
 b=IT6e7rrOBglFT/Qy1sMs9242ad/CN4OZC36VPDIy8GRkrXhNJtHD7D5sXzTF6siMwa
 PgbTaTiO2hHva82Lw4qcW/9KwD7Ihhz1yi1QVSyMXb8wl4ZHdvrWftA27Wt08IzgzeoB
 C+GqkDH+ozhFxuKKhg0KxxELly4fM3dtremgp+DHyXQA/+azuvU1yD6inmwYq2AuCiT9
 dAPlASF+y/B0FfKNIJlUwkGtlTzYMRYSyTlyxaNRq+2suNA8UAhzV92Z66PSCo9lbnkq
 RD3SWdyAUQL71XJgkskQazf+MjKsShwBJTvOoKg/uMcICX8B5iyawanVYtw2con9i7uL
 17Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187513; x=1781792313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uk9rd9misoSU2hLdft4uoM6u27rVqJfwFULI/ZofLPI=;
 b=CMS2foFzvpbteRzGR8iCT1FCy1cuAv0sKuPFDDNtAI51IM4ATVnwQItp0jbfLC/8mq
 c8H5uPv07Yd06jfMmTg3rVeKkAlTrIPzOKQIMHGMHnsgTaeIK73jb0kSsf0M3hYQsdva
 zWByv+ELav4Ly0DNgwNX+g9iu/10L4AB2sHNenawYxjEtgCKtvz7SPVB5lXy0GK5YNXn
 rRdvmvP0HC9JdRwOReQJEgpoZk87glRRBzNlK8jF0uGEWg4drUPBP0heE0tX08mpyVXn
 62S2Qib6NY/ujJ5AnqGKEKiKuj+/jtc/x1imTlYy9jgYYwxbG8DBdjz9DxwmX4Z9UVlG
 ruew==
X-Gm-Message-State: AOJu0Ywxd0LmFyWLsj+5srMnhjNwTZ56nr8tSRKh22SBqv3HjBDHu844
 8IUVyImsWpYXOauFYJo8FrDYh5dphuqA2zpXcmakLQkNncIS4JKlOYvooYoo5xle
X-Gm-Gg: Acq92OGw8IWzU2aeB8Oon/ocsjl+VaqIrbJSRk1e7xP34cen1D5qDoouJ1y5hhUxA58
 5WIs7yQQqJuAQxCGHf+HJ2md4jmkRwusSQ/lDP0Amu2JsHVirY1AVeSLte1py0UYr69cAZMSQee
 JsV2u9akVMiS00otgOXeiXa24RiG17WrUPKZJNrCuM93eRZjBvKrDsyTHM6/GpcTM0z4z9cZPM6
 BecomolLfskBLAPuLhvycBWlkoZNZir/toQdPDK4Vqlg2dal/9ciSwQKQ5fRU1caZr9iaikCj3v
 gRS8TNMPPkq9j+FnwAlcum7gPalUjAbhpyhqH/fMFnGfsUWkppoBubNxNZNZI77Tgco4IHoD2fu
 1ToDx5+J9Ogf8/v6gvwyj4zjFpDRQ98Hy4AEN5I2fHivyaIYoW+18GSJ1LQzZXuMy4476k1wIWc
 eOtVoD/5AHzKDEZVf4uXk72A5dvq/7ZCRwvUESAt36AVTn+cug+nFxJrNMeubPX1R7LCdZ/zm5W
 hjmh/Mzssq0OrAcyAc=
X-Received: by 2002:a05:622a:6116:b0:517:5d30:3c3d with SMTP id
 d75a77b69052e-517ee3ca7f5mr50062801cf.50.1781187513277; 
 Thu, 11 Jun 2026 07:18:33 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:33 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 3/9] spi: fsl: add support for Spacemit K1 SoC
Date: Thu, 11 Jun 2026 10:18:05 -0400
Message-Id: <20260611141811.68904-4-raymondmaoca@gmail.com>
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

Make FSL QSPI driver supporting Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
Changes in v2:
- None.
Changes in v3:
- None.

 drivers/spi/fsl_qspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
index 65ab3e306d7..5692510a558 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -267,6 +267,14 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 	.little_endian = true,
 };
 
+static const struct fsl_qspi_devtype_data spacemit_k1_data = {
+	.rxfifo = SZ_128,
+	.txfifo = SZ_256,
+	.ahb_buf_size = SZ_128,
+	.quirks = QUADSPI_QUIRK_TKT253890,
+	.little_endian = true,
+};
+
 struct fsl_qspi {
 	struct udevice *dev;
 	void __iomem *iobase;
@@ -870,6 +878,7 @@ static const struct udevice_id fsl_qspi_ids[] = {
 	{ .compatible = "fsl,ls1021a-qspi", .data = (ulong)&ls1021a_data, },
 	{ .compatible = "fsl,ls1088a-qspi", .data = (ulong)&ls2080a_data, },
 	{ .compatible = "fsl,ls2080a-qspi", .data = (ulong)&ls2080a_data, },
+	{ .compatible = "spacemit,k1-qspi", .data = (ulong)&spacemit_k1_data, },
 	{ }
 };
 
-- 
2.25.1

