Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B765E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E4B08067D;
	Sat, 11 Jan 2025 01:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fIQc9LxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AED380762; Sat, 11 Jan 2025 01:01:41 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BB980050
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3ce34c6872aso16510295ab.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553697; x=1737158497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spqHqXdrlvhqc6cfitlakRXzVJ2zr1zOvxSrSQuaA0A=;
 b=fIQc9LxQ0U/C1KFTnosJoTn4V55ZwrAznIdzNS31oSBUWMz2jNCVsFDFvxp99w5WWx
 Zk51xPBdEZeXU7huVr/j0UJEphPC4kbyMyHTDwzS92irTPfvmsPAOY/6upBye9iLGwQs
 AdK4mkUMgnC4GMDoxiBt1aDaM4IfNOhkEt4C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553697; x=1737158497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spqHqXdrlvhqc6cfitlakRXzVJ2zr1zOvxSrSQuaA0A=;
 b=E1YTLEWakO5SD7nuyo+B52+p9L0UtNzhlE6gfn8c7RgtAm6mvNPCw67QH0azxuxIBq
 +5nnrd9i9nrPmuC6BF2KpCZ7CxYWL6qG/8Q6UafD5+7KHoPjvrjie+hmpUHoST5BMiQU
 83OnHBg4lj3Q22rHopFDtKlI7+M8IJwDUMX7EVsTkIJBDXK/DK9y4ndUi1ZCzmlMUZly
 LIuE/boPz9f9NF+QDF6iAC9JbhBBzGQ5MBOjwWlkQtXEWlyoSH6Xe61jgrry3K3wqdSU
 WKPS3FVsSujhY5J1Jqln2o1ytwPwQpSsxwWosVVDtyrrpX4Jf0FRWo7qnwqiWIYFRye/
 bxdQ==
X-Gm-Message-State: AOJu0Yz7Toi0a/L/jG8bVUJBfDTZ91AvMm+WLp1yfVTWXiFN19UR36nR
 tC/0L/WCi26HeDzctmW+2AOV7ymKOSSiN8eULqdN0RVuiWDI0EOr+s2zEKFjJo5MZVShzKhVSPo
 =
X-Gm-Gg: ASbGncv3bOPx4Xzhtl4JlBD/iYni7AHU/X+pi5yuY/Lr+HlhCiqQpfjBTCO5ZB6Aee2
 olhj9dB2NOCdCKumNb7gXdPFd8UmF2g/KtJABCuo5c9qOSLxJ5/FCJBhW/r8FnXoSpUjxGlSEOm
 UJoX2d+i/Cb55COWeQJ/BZ8GTexiM2xu8+t8P3lw4/odvUmTkXef4fJUNQqOT5x3GYWX7H+FhEd
 su/Wp5mPIzKqk2QfhOYKq25HXmsZAzXFtAogb6apSO7MFkGblIOnlwdf7i8XTB0O3NFzEMlMfbO
 NIDEM4FkT3wCDGIIKg==
X-Google-Smtp-Source: AGHT+IGQPV1FfhiNXey0GAmnpgr6SinB8/xScFw1uWC7pO1esxD0K1mCyNLHVvF4Rf2BYmxwkNDfTQ==
X-Received: by 2002:a05:6e02:20ee:b0:3a7:e103:3c46 with SMTP id
 e9e14a558f8ab-3ce3a8ba404mr94736505ab.16.1736553697500; 
 Fri, 10 Jan 2025 16:01:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 21/30] x86: Show an error if video fails
Date: Fri, 10 Jan 2025 17:00:20 -0700
Message-Id: <20250111000029.245022-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

If video is enabled we expect it to work. Avoid silent failure by adding
a panic if things go wrong.

Expand the SPL malloc-area for qemu-x86_64 to avoid a panic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/spl.c            | 9 +++++++--
 configs/qemu-x86_64_defconfig | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index f761fbc8bc3..aad748532d0 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -300,9 +300,14 @@ void spl_board_init(void)
 
 	if (CONFIG_IS_ENABLED(VIDEO)) {
 		struct udevice *dev;
+		int ret;
 
 		/* Set up PCI video in SPL if required */
-		uclass_first_device_err(UCLASS_PCI, &dev);
-		uclass_first_device_err(UCLASS_VIDEO, &dev);
+		ret = uclass_first_device_err(UCLASS_PCI, &dev);
+		if (ret)
+			panic("Failed to set up PCI");
+		ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
+		if (ret)
+			panic("Failed to set up video");
 	}
 }
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 39375c76227..2771a4b9e19 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x3000
 CONFIG_SPL_TEXT_BASE=0xfffd0000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
-- 
2.34.1

