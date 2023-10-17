Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D28CCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 18:24:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B6686F34;
	Tue, 17 Oct 2023 20:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LedLaXH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBCFD865A2; Tue, 17 Oct 2023 20:24:27 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFDB86F1C
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2b1af964dso3276660b6e.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697567062; x=1698171862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=893hWjbk+KdBBlRdHAVhS7raASGGpiSzZ6yApKUOMVs=;
 b=LedLaXH6OZAEWRD03vkwkILKJXak0BcHadd2R6AzG46aDudG7nfdofVw831jSQ0g3Z
 MTvAh+pHJ851ySpLF9Z6Nq4ia2pHAyDNOXRwoUpzkMCYaZg7vYFhMzsOvYc6YFvOQL3j
 wkGIAE7y5ATsQR4yBcRMeZ621/CbWUbDEmAzQolb/XNDNChxXgIQipPsPGFJA9xhwhD5
 IfSqzCkDwV4p4LxN1V46rDfGpEVPOecKh9lssXygxE8eNSodA/Wir4KgsQHrXedDiuH5
 3JV8NhXe4qT5uzRXj8vmsNUqVK5meVY6uwPREUsITB9A6a/cyZbdCgT9rHakXHU3nbRL
 /f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697567062; x=1698171862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=893hWjbk+KdBBlRdHAVhS7raASGGpiSzZ6yApKUOMVs=;
 b=gVGtAtMfoRFjzXsa+SQPuOUXP9eYw4hGpS7IcJDeylQrY6m6EzvXsNh6y+hsJD9vDK
 zg4T274tESvlKqxBxzFyBtsOhx5py9VVIr5IbPhZsYBO70hhUBlZTRxaLHPv0yAMgYzM
 qlm1Gawjb46xkYyI8FxNeDh6uRNy2Wsd2vFaOAn7r80H1x1HNfPQIOQyAYX1BYR40UC1
 yX2itT34I84DqEkcW27bV9/Ce12V0XyE2PWCgo0wzZfB2zLzApF+LrL/jlwZYIXYWQzm
 N5G9Icbsdnh5fIntslfZltsaIgcIqlBjaFT6uqcxfNTrHCVy05/tTnnc7dJNwNOLnH1S
 RXpg==
X-Gm-Message-State: AOJu0Yxi4D/BZGOHlzQD4F+XP54sTLwR6zsR4zH7xu7cCXZkCHj6u2dH
 qngT4hb1cuw4yq/YRtttP2DM4ifdUI0=
X-Google-Smtp-Source: AGHT+IG147XMrxfy7lQmJdwrW6IAi3CZtLF7gphuTH9xa/l7F/KjgMpjGtRVFEgW+jhxSWeX1V1X3g==
X-Received: by 2002:a05:6808:3b5:b0:3ae:21d1:8040 with SMTP id
 n21-20020a05680803b500b003ae21d18040mr3074782oie.36.1697567062402; 
 Tue, 17 Oct 2023 11:24:22 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 6-20020aca0b06000000b003a3860b375esm340312oil.34.2023.10.17.11.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 11:24:22 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/3] board: rockchip: Add support for RGB30 and RK2023 to RGxx3
Date: Tue, 17 Oct 2023 13:24:14 -0500
Message-Id: <20231017182414.321411-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017182414.321411-1-macroalpha82@gmail.com>
References: <20231017182414.321411-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Powkiddy RK2023 and RGB30 to the Anbernic RGxx3.
While these devices are manufactured by Powkiddy instead of Anbernic,
the hardware is so similar they can all use the same bootloader.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index a93b11cd47..dae9dc87c2 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -60,6 +60,8 @@ enum rgxx3_device_id {
 	RG353P,
 	RG353V,
 	RG503,
+	RGB30,
+	RK2023,
 	/* Devices with duplicate ADC value */
 	RG353PS,
 	RG353VS,
@@ -95,6 +97,20 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
 		.detect_panel = 0,
 	},
+	[RGB30] = {
+		.adc_value = 383, /* Gathered from second hand information */
+		.board = "rk3566-powkiddy-rgb30",
+		.board_name = "RGB30",
+		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
+		.detect_panel = 0,
+	},
+	[RK2023] = {
+		.adc_value = 635, /* Observed average from device */
+		.board = "rk3566-powkiddy-rk2023",
+		.board_name = "RK2023",
+		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
+		.detect_panel = 0,
+	},
 	/* Devices with duplicate ADC value */
 	[RG353PS] = {
 		.adc_value = 860, /* Observed average from device */
-- 
2.34.1

