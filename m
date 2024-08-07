Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8615C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBAA88D28;
	Wed,  7 Aug 2024 16:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nCfOtN+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5606A88D0E; Wed,  7 Aug 2024 16:17:33 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 747C388CF0
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so2596041a12.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723040251; x=1723645051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyOVCaIb4yKMZjE2guOmJPxXrxJK+OEMt5sPE1zwbYM=;
 b=nCfOtN+taZ/bglYPqwEUd2q2vyXwquKJA0OLMD9BX40gNZ5YaoMvWX5BlPfvBeXvgP
 7VcnskA660cJ+rmwc9Vx4QPMmESKCwwFpugPWQ34lA+Jffv0Z0IVmMfW3XSnP7tnXqOu
 zFwnbePQAQk5eg2sZNp2i5neW5AHwI0lWGF8ZDcVVL2OtSC9APaQhMuJyuvgC2Z6SnWw
 lqP4GarLF1IIT7HCmV/9+nUrzQ6VnSnoZSIwK2FOaASZfGmSzCSnOrdwJzKH5l1k070g
 3e0o62b+yafewTg8EHKvFZQeXy8wKf4jb4+jSh4sCMTJkoCjNP+Uw1uNl2RElCUFGUPv
 Y/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723040251; x=1723645051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyOVCaIb4yKMZjE2guOmJPxXrxJK+OEMt5sPE1zwbYM=;
 b=LDVBqHPVDBDxIG26dNV04eV/vutMQ2Pavo2eHBuGD9hX+Y9AONvQ8Kr+3M6f5znUC4
 WTDHq80j9HWKfX4Bgeq2S+B9gifMy6csDUzT1eJuPReDjVTBqTsEBSOQciBTV8RkQcC0
 4j3T91tn+vjRp7Ng9E7X+KjBR7blWowpBqwP82HnK+SgbV+sqZM3aJTtzg5Kdihuq16o
 ssbeaePY1BCi6wKWvkTRspDFxLsBU/YY9GPYI30u0m7Y3RWjjS49ORRSb+0aOpStTed0
 A63VtYlMEvmac9xN8WriQ9r8vM+uCMAZdU6zTctSS41te27I40AulLZRIMaH0lXIkqda
 3+kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2JxUhE0lIhQsvp+lhCDP4POoeU6FlnICJPitaT9O0yc/mAF9/AlBmwWM4hDwWe5LJsxzrpXqzrVvZwxmXYgNJMPuzKg==
X-Gm-Message-State: AOJu0YyrQytgJEDkC0Bb1lGYHHro3MowZLCR2hsxczR/5NyKboAnaBdP
 ZVfeKXBR998a7elwnNmrIvbMrD6Zm7nPi6EiytGF1iV1NVwoMfFWRtKdLg==
X-Google-Smtp-Source: AGHT+IEpVT7xlOAeXUDj9wuWBq5+QwrP5m9RZbDixBHY2aJghqZfs9SkzRTShaHXG9eLuVvkqx8rUA==
X-Received: by 2002:a17:907:c1e:b0:a7a:9f0f:ab14 with SMTP id
 a640c23a62f3a-a7dc4fa16demr1409814966b.33.1723040250824; 
 Wed, 07 Aug 2024 07:17:30 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8dafsm644945766b.220.2024.08.07.07.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:17:30 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v1 4/4] colibri-imx8x: enable i.MX specific SNVS configuration
Date: Wed,  7 Aug 2024 16:16:20 +0200
Message-ID: <20240807141655.4165667-5-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807141655.4165667-1-max.oss.09@gmail.com>
References: <20240807141655.4165667-1-max.oss.09@gmail.com>
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

commit 242d1cd69b9f ("imx8: Configure SNVS")
implemented IMX_SNVS_SEC_SC. Enable it.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 configs/colibri-imx8x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index 71a05b74dbb0..d7b1b76c21df 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="fsl-imx8qxp-colibri"
 CONFIG_BOOTAUX_RESERVED_MEM_BASE=0x88000000
 CONFIG_BOOTAUX_RESERVED_MEM_SIZE=0x08000000
 CONFIG_TARGET_COLIBRI_IMX8X=y
+CONFIG_IMX_SNVS_SEC_SC=y
 CONFIG_IMX_BOOTAUX=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x95c00000
-- 
2.42.0

