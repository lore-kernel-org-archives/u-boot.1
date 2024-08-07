Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0F3C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0DDE88D23;
	Wed,  7 Aug 2024 16:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cvlOsVhw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0025488D0E; Wed,  7 Aug 2024 16:17:32 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6C188D14
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7aac70e30dso209273066b.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723040250; x=1723645050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/R2x3VNLf00kdfF4PQIR7opHggbH5h23yZVSdA11rA=;
 b=cvlOsVhwIfOp3kM1wc3y921EkLPHfgBsJE0uJ5drhfOe3zkCsCc6apfswDmt21HgA2
 dYqRZJ1oluzooyagbDl96MRYLvmPLZ3CHFadaSQ89YCdm2Tc9WL4/cSy9CIGHRnch5VN
 jL/ZO5vE5APc1IRTYthpqsC7n11Bj6LhKXWE8kB0qC/v0P5uFsuP//bOcygs1CtpLpGB
 TCAth1etEUj6AFIPwQDq2qtQq/6cL/2OjTHRcLHjxve1slvscynM+ANs8Yjryb+Qk915
 R9GpnSNW467kmDJXiE4kO5Z5WlqvMM+44RxxFo16DaZUsw0tyE5bdqZYS3Vjo1RuSuUz
 Hv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723040250; x=1723645050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/R2x3VNLf00kdfF4PQIR7opHggbH5h23yZVSdA11rA=;
 b=heyibbbriA36tvAI0Z2HDPIhjOp7hf4h8TFMu3/cBemw5hZKPU7jXOpQpNHatUXoxP
 yPVJFh/V9C+De5eRBO1c5gF3+kvkpzJZPeg2wG4/cugOLXGg/cghQvm33Xq8DRTbRKuo
 HlnI3rieGQjXP04sVfaG75hlY+k1dUhLviov7BIU6EMy3p50yo2t6o1qPm8HpRH1iZO7
 mdEXIoNUI7D0EaTqalqZUmOsdKisEUre/ZJ5MsG/XWAuqa+20lItp8e2WDLW/L/CF2xO
 FyyKlx1cjkPOvCsH1m9qC+iRFW0/i+XVdhS84fN/Bn0AfUn/G1Ymj50KU/KZ5XNvJsEx
 kddg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURvhM2moEPsu5JF1++nfo9C+yomCVn1oiTFRuAz6DEV5xouJxjYQnWEafGDL7SR0lgEBYTCo/WqdyyY/j5NTzH1EbIvA==
X-Gm-Message-State: AOJu0YxZh1NhJGkmF8Ngy3G7LfNWRH87ggEL0v0NfG6MiiRCVKGNqsgF
 kst5Pj2CNBAOQP+g2VLX/MRezRkjQJX4b6bjbsgKjowbfRaHP0R1E/2rsQ==
X-Google-Smtp-Source: AGHT+IEB85jmrDD3oNt9FKkj1MvHrw7s+28GGKSHNkEAZwokic9NS2yjiqggqE0KuTWG9y7jALasoA==
X-Received: by 2002:a17:907:968b:b0:a7d:c9c6:a692 with SMTP id
 a640c23a62f3a-a7dc9c6a8a1mr1549964466b.51.1723040249797; 
 Wed, 07 Aug 2024 07:17:29 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8dafsm644945766b.220.2024.08.07.07.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:17:29 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v1 3/4] colibri-imx8x: enable i.MX specific BOOTAUX
Date: Wed,  7 Aug 2024 16:16:19 +0200
Message-ID: <20240807141655.4165667-4-max.oss.09@gmail.com>
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

 configs/colibri-imx8x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index e76373e499ad..71a05b74dbb0 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="fsl-imx8qxp-colibri"
 CONFIG_BOOTAUX_RESERVED_MEM_BASE=0x88000000
 CONFIG_BOOTAUX_RESERVED_MEM_SIZE=0x08000000
 CONFIG_TARGET_COLIBRI_IMX8X=y
+CONFIG_IMX_BOOTAUX=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x95c00000
 CONFIG_SYS_MEMTEST_START=0x88000000
-- 
2.42.0

