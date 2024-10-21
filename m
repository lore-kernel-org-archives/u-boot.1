Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32F5D0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1753C88F99;
	Mon, 21 Oct 2024 13:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bpWOQyvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C480C88EBB; Mon, 21 Oct 2024 13:38:57 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E6788F24
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a156513a1so603949366b.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510734; x=1730115534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGKVik8k+N1+0aUh0sK9VsKSMpGrr/3asSc/Xn7VCXg=;
 b=bpWOQyvjkmRftmdVVAb4BM3TEPyR9nZs4N6muXLQvWGnRLuRfupTAwCstRQnIJ7CuV
 3KuBKFc6jw5mXEg6YGdiUzEUvI6LjL7CoNjcYZXlyyselw4p2nenp3GeLAnb7vJK3khA
 tgIawYowZZYLX8wTw0JatxKnej0UhKFkzoI6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510734; x=1730115534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGKVik8k+N1+0aUh0sK9VsKSMpGrr/3asSc/Xn7VCXg=;
 b=wjzIsxTB5Pr6xYbNsthXB+r1VnUxr3O9hkbSATpOLg5prxREr5osiaMajxGiKZueUt
 /3MflpmVIRoP7Fu2sZPj7PNGJTLTwj2SlkIZACjbFYRTEUIwaj8Y0Qxk8qJ5Vk+Vl9V9
 qU4TyQ1MKCzhs+y4q+v62f0yMKQN7VV1UaT+Rf6UkGexypG7TwyqY2RPBdktf0OUAAjv
 uEHPF2KpZBQ3/sqJvxbYpUWTdT+dvm2U8GnS5bEItww22yir1wBnNE7ApJosR/RyDRC8
 MsNj3fSKH9yUBOMX6jKHWrGO+Zjw9z1S0SUyAU5zvdnG0C26PAxaIty/ia5FhEHl8d6J
 oW1A==
X-Gm-Message-State: AOJu0YwQ673XLektU9f7n32rUgfZ9DUuDV9TzkBeIZCdRu+X7pfw1QBL
 r65XVYiVhJq723MbiKvX4eA2mAh6Tvp2fJ+3N81iDhPe1TnfEPCVRy6C7cbGRx02G4/FXEezHYi
 DddjJ
X-Google-Smtp-Source: AGHT+IGEz8FadIhVAs4dVcu/IaPi6J3N9l3P8cbsb9PkE2gzufSmdHiINIvsh9geYDJbk+TDoN95GA==
X-Received: by 2002:a17:907:9623:b0:a9a:230b:fb5e with SMTP id
 a640c23a62f3a-a9a69868cb2mr1204572166b.4.1729510734314; 
 Mon, 21 Oct 2024 04:38:54 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v2 05/25] socfpga_vining_fpga: Enable LED
Date: Mon, 21 Oct 2024 13:38:13 +0200
Message-ID: <20241021113839.318572-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

Drop the STATUS_LED options and enable LED and LED_BOOT instead, since
this is the new way to access the LED functionality.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a patch to enable LED and LED_BOOT for these boards

 configs/socfpga_vining_fpga_defconfig | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index 094e9186fca..94018752b40 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -77,17 +77,8 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=48
-CONFIG_LED_STATUS1=y
-CONFIG_LED_STATUS_BIT1=53
-CONFIG_LED_STATUS2=y
-CONFIG_LED_STATUS_BIT2=54
-CONFIG_LED_STATUS3=y
-CONFIG_LED_STATUS_BIT3=65
-CONFIG_LED_STATUS_CMD=y
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-- 
2.43.0

