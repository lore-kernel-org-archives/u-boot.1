Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E56AC52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870AD88D0F;
	Wed,  7 Aug 2024 16:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H5VpPLOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D99888BBC; Wed,  7 Aug 2024 16:17:32 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D82E88B9E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f04b3cb33so4312583e87.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723040249; x=1723645049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrs/SHShY6PJxy4YjQPxLeyI1ShWPv9tmX5cyTt5tu4=;
 b=H5VpPLOf5WM+WIs6GCJ+K6T8r3KKj72clwHzaJS8O8IuPvaUKUDVB8hjQ8xaDWAaH2
 xmSlS9nvYJIwImYlxnOo/CqfWdHdiql8txsvLhbpdEhYqaujPzcugy95AJxQJGWtA/+b
 yHPabtkUfcMs40/84wFtQB4r+W790DNHewn6BqxkxhfnKVcl8Bps48L7G/3ja5QQISnC
 +s79lBpEWcG7idsq2l+scKjcrRpTPSk/UZKyHlLzoU0iDxE9j2K78wqCaopVn7izBDmf
 FaP1i5W/m4PdHIKeM2+FtxbvJn/NcX2KUxYdr2K1jcf5xwqHZWDnqk/k6SHvL01Eo/Zh
 E/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723040249; x=1723645049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrs/SHShY6PJxy4YjQPxLeyI1ShWPv9tmX5cyTt5tu4=;
 b=ioItDaJXkSo2Ht8QHqswhuraWaopTtncZ9XO2XT8eb62YdkwavtcWVGgsHKpFbDELf
 iylbbZ3/6XwmgrN5wd9ljAjEQIgT1018ZAZXsOSP/2f8WCQQ7c1VPCsc9aPUCi8W2tkm
 zrGgysasDhIExv45gH7/FntdQ6rwDfyybIealTWFtyagKSf+adIlk4K9AMroNse79QYq
 yLpXKs2QUhhD+t9Cc5xGYmyrDFcR2Sd/nsVDsuLxA+GUtpDpnUGdnIJBvxeEdlh7SRT7
 FSmjzBYt2uR72M15rzycyOOfk/hQGZQhFL4mDaMbQ6hXLswJOJnpN5rCgh9j4opP8/Jj
 Vgww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUntYeyznaFtCbJd1CiapPq1SooDg658NR5lnqYBHSxWQUJuWjkQeTULufQONZo83wZIBSJRvEdNhbuYzjzrOrdWUitw==
X-Gm-Message-State: AOJu0YzCA/7D6v/VY9A/ewU5yOiaU99jhjmj9PqO9lz3RJOzA+g87HSq
 JI/H0TqHtwiX2qYvryJRXmJsqJrMzNvfZPpP/iiHEzk8bfln8rA2
X-Google-Smtp-Source: AGHT+IHfb6GXTrhCNGGatuIiTKglJ+4xbDQbpIWZ9szGVapLrEydkLSQVwnWckH8wOs2bJS+C/IHFg==
X-Received: by 2002:a05:6512:1585:b0:530:abce:1daf with SMTP id
 2adb3069b0e04-530bb373ee0mr15335936e87.6.1723040248975; 
 Wed, 07 Aug 2024 07:17:28 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8dafsm644945766b.220.2024.08.07.07.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:17:28 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v1 2/4] apalis-imx8: enable i.MX specific BOOTAUX
Date: Wed,  7 Aug 2024 16:16:18 +0200
Message-ID: <20240807141655.4165667-3-max.oss.09@gmail.com>
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

commit e8cd1f60d964 ("imx: imx8: bootaux: Add i.MX8 M4 boot support")
implemented IMX_BOOTAUX. Enable it.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 configs/apalis-imx8_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index e9fb4c75988a..466147f3bf2a 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="fsl-imx8qm-apalis"
 CONFIG_BOOTAUX_RESERVED_MEM_BASE=0x88000000
 CONFIG_BOOTAUX_RESERVED_MEM_SIZE=0x08000000
 CONFIG_TARGET_APALIS_IMX8=y
+CONFIG_IMX_BOOTAUX=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x95400000
 CONFIG_SYS_MEMTEST_START=0x88000000
-- 
2.42.0

