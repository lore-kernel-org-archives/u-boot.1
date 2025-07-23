Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA97C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 18:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16328349B;
	Wed, 23 Jul 2025 20:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CqceQVZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB408353A; Wed, 23 Jul 2025 20:00:28 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC99783297
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 20:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74b54af901bso154378b3a.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753293624; x=1753898424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c8sX1tlPLGjbOFk+W9SYzaTV6hldahfgTdoIyv0O/iE=;
 b=CqceQVZY418UP+udX+EHlsqoWSoAwAaY4lIFxL4lkDgm9vqkpEI3D69UJliw1jWMq5
 ZONIY4HPtKh8pIVv+UaLKz0HBNq07YsExUtIKBVlv/A3CseQ4GpEkWMZZIPMxtUleFFb
 0jSu3j7NpmBBDS4Vud2udlKtzhbhG7evvLbC2F6MPDmsx8j75Y/ZIw+fy/VgO0r3/bJh
 qvxbfE9/+qibinw3RFk3E3JzC16xzmsBfdtGIGxzb4Yr3FdtVA8KTbn2qHNCuj3P63wR
 mMtGFH47rjSMdPRCmnAjWcxZThtzZTzlbgoRvz9wFlR4seIqUwYla353bZ+A4OIazQWq
 ndvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753293624; x=1753898424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c8sX1tlPLGjbOFk+W9SYzaTV6hldahfgTdoIyv0O/iE=;
 b=rGnVoagnGPvY7NtYcneSIOqDk5r7R86N7AwcDT6YpMS4rK3H8L91YLlOTInpQJ+RC6
 LG5p64qppWojXH7lwOCg6RieRsOt65sTCbBjPr+qZvFDV6CYcsdmhl8nmV1/4/WnTvlU
 qSBqb7vxoSz8YPI399BKUw5QBVgQMT7IShfcf/WpgfUREZIDtVbeaDVCbirtCZUr4ZF4
 xMuAs2hXc1gg4+QrY6+bJOBolleYbixbYCATYeoK4qQaDumBSIIbQxSyPDfW9r0SOSdl
 L4nWWKQzGFH3w8soDanI9j78VwNiyxeJHwcXaQeW5kNaR/KnDRCH8sf9EwF3I8ODkq+y
 G1CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkXW57WhtA7hz7/PDaq2Y+SCnDyiDUVW6K2q2ekIT5ggw7IUGosJgkdE2iu+T35wH/hg2K8QY=@lists.denx.de
X-Gm-Message-State: AOJu0YwBVv0CO0lqloQPYDASMDFa6JBBCAv8mp0mqr3VurrqjMgNsqvj
 +zQmucejNWVBispSHqpJv9KPhEOtrMGGquKxJz3x55KeFfeBad8Awn3t
X-Gm-Gg: ASbGncsNOEluTqLXBNkWW4vjcaO644IdPbCIrP5jJANOq9Jd1Yt/nVletJjLDJ0i9dJ
 206nQVss67PGHRLZRl6jisPGCP+efglPWQvVdClhE65t6pId501ydI4hlOQiXJQKngM4KNHZfUa
 veGOleKQ67pASY37ZArXYs5s3riqxPGi5L/zuf/tp1sfCD2UmiMGxj0gO9ypMSL/b/f6AeOgPpS
 7XdAj3r2wCfUcamvuElz7qXt3/Kc7YJOYhQ2y6n4OoVEEUw3ds1t2FzazBKU7+kP9LMUI3VTL1g
 QAodnECKw/eMtIGkvFyvb2qUl/DCVO8T1gr1cIKiu3ICz97L4QruD167hTCZIzKtLoOv/rYuk2x
 S33+GnhaK/thYX5xIUg5wYvlPQU18LPM3Ja3RzWhHy9a4CsU=
X-Google-Smtp-Source: AGHT+IFtasAaeoa5XhKp4At4ZBw7D225wf3dtabUKXlAdYu7nOrFCu+9qiAcLnwSIQ9GtsYWWmTguQ==
X-Received: by 2002:a05:6a00:228e:b0:749:122f:5fe5 with SMTP id
 d2e1a72fcca58-76035af83aamr6252433b3a.18.1753293624033; 
 Wed, 23 Jul 2025 11:00:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:db41:d59a:1994:977c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cbc68184sm9869507b3a.136.2025.07.23.11.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 11:00:23 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: uboot-imx@nxp.com
Cc: seanga2@gmail.com, andrew.goodbody@linaro.org, javier.viguera@digi.com,
 trini@konsulko.com, u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] spl: spl_imx_container: Delete uninitialized variable
Date: Wed, 23 Jul 2025 15:00:16 -0300
Message-Id: <20250723180016.2021172-1-festevam@gmail.com>
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

From: Ye Li <ye.li@nxp.com>

The 'overhead' variable is uninitialized and actually shall not be used.
Delete it to fix coverity CID 37041718 - Uninitialized scalar variable.

Fixes: 73c40fcb7367 ("spl: Refactor spl_load_info->read to use units of bytes")
Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 common/spl/spl_imx_container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index b3565efb225a..79d021f81dcd 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -31,7 +31,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  ulong container_offset)
 {
 	struct boot_img_t *images;
-	ulong offset, overhead, size;
+	ulong offset, size;
 	void *buf, *trampoline;
 
 	if (image_index > container->num_images) {
@@ -54,7 +54,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
 	      container, offset, size);
 
-	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
+	buf = map_sysmem(images[image_index].dst, images[image_index].size);
 	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
 	    arch_check_dst_in_secure(buf, size)) {
 		trampoline = arch_get_container_trampoline();
-- 
2.34.1

