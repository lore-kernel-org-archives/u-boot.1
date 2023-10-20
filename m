Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27558CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 10:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BFF187479;
	Fri, 20 Oct 2023 12:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="aT99BPqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5508087476; Fri, 20 Oct 2023 12:21:23 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E0780F06
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 12:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9bf0ac97fdeso97964466b.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 03:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1697797281; x=1698402081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VJ/mQOEAMI18a06QHYq0i7pMNnph7rmZfPRHcbrS3Jc=;
 b=aT99BPqW0x5IIu/1IGnylnutOnYTNWUg0zwU14IpZHbUdHG61lKvtoZR3qW2oZSBMX
 wtiwnmbrhAVQa2T4qHl92bx9CoFYizuwkzTdp5mmERsgCDNy0GWJGy4RLu0p8u3CpfE0
 jLocTLhIDfroQj1Gsr3nOSBCqvmTIQMOUKWerPIKhCrxgRLXk8OiSygG41oLac6/P2wY
 RiS5tboacmxPaGnawbxAcT8M0ji/tklr0VOyAa+PFyTcgmtDVh4qv/Lu9GTLCS+MDZ7c
 TG0f5Uf8zg5RhkVr20wKbt9uaJ4VSsjVVTGXIRkVFcGPi2ZEm6ZGhhf1Fbp4et5SzRBb
 fS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697797281; x=1698402081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJ/mQOEAMI18a06QHYq0i7pMNnph7rmZfPRHcbrS3Jc=;
 b=FIMssQV4h471TpME/kEP3xfjGJVxG0zeqnMxiQ+OKIuITKNIef7GgG7hCPrgC9V4tb
 KRWyNlIZD4QlaU6evxBUHvGUBLkvaGkserS6IEo50lgNkvYKgNv5KSNYiUNPIHZ9C/1m
 zfYo04clc9HrPqEgtW9omblbQFFnZKRhoEIyLn+/9xfG6yd2YVpmwhlyUUkF9M8mBW5o
 G0HmK3g+TYeQsyvI88CzD3Kj7Efndk3PUWMoZHXvh5D9pvT0jrpaebltRknG7xse+IN4
 JN5mqNdikqVbboCSV5kSFC0d7xIzyQ2hc1YGJpkhCClvadqpUk+rVQUFpBXn3bHMhTus
 662Q==
X-Gm-Message-State: AOJu0YxZ5duhh7LMraHgchSyvKgcf1LSwfY65JJbQ7iTM3vNRhU7Aswa
 zhP7UxM8h2EnE9mkcgQpYUf4WA==
X-Google-Smtp-Source: AGHT+IFzdsOma789YoYIqNlEWSHsVOo4MY3nL3Bm2raRGojctRYEa1C8zFwzyzMV64T9ySEvTNEBew==
X-Received: by 2002:a17:907:9724:b0:9bd:f3b0:c087 with SMTP id
 jg36-20020a170907972400b009bdf3b0c087mr1012118ejc.2.1697797280569; 
 Fri, 20 Oct 2023 03:21:20 -0700 (PDT)
Received: from fedora.. (dh207-96-32.xnet.hr. [88.207.96.32])
 by smtp.googlemail.com with ESMTPSA id
 e27-20020a170906749b00b009a198078c53sm1204693ejl.214.2023.10.20.03.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 03:21:19 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sr@denx.de,
	u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
Date: Fri, 20 Oct 2023 12:20:53 +0200
Message-ID: <20231020102117.1583572-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
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

Currently, Esspresobin FDT is being fixed up directly in ft_board_setup()
which makes it hard to add support for any other board to be fixed up.

So, lets just move the FDT fixup code to a separate function and call it
if compatible matches, there should be no functional change.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index 04124d8014..1471caa9a6 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -363,18 +363,14 @@ EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 #endif
 
 #ifdef CONFIG_OF_BOARD_SETUP
-int ft_board_setup(void *blob, struct bd_info *bd)
+static int espressobin_fdt_setup(void *blob)
 {
-#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
 	int ret;
 	int spi_off;
 	int parts_off;
 	int part_off;
 
 	/* Fill SPI MTD partitions for Linux kernel on Espressobin */
-	if (!of_machine_is_compatible("globalscale,espressobin"))
-		return 0;
-
 	spi_off = fdt_node_offset_by_compatible(blob, -1, "jedec,spi-nor");
 	if (spi_off < 0)
 		return 0;
@@ -459,6 +455,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 		return 0;
 	}
 
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
+	if (of_machine_is_compatible("globalscale,espressobin"))
+		return espressobin_fdt_setup(blob);
 #endif
 	return 0;
 }
-- 
2.41.0

