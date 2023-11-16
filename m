Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A134C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77246874C5;
	Thu, 16 Nov 2023 17:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MsKGG6T6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F63874DA; Thu, 16 Nov 2023 17:44:23 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE06B874A8
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc330e8f58so8525885ad.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700153040; x=1700757840; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nj28H7ZiG7dYCdUVs2gcu/7Y2e3Bgt1CBt9kV7IZD7I=;
 b=MsKGG6T6xtteFAUDpByQpFJ+v6gutOynPpWd24DwcAcpHcYJBW9WHOrwKPK4teVSSW
 dSjM0oJfTvZXUIn3v6YGvbaSZALRbQ6HH17rpmxtVVEKuPrCs7xZR2s5KmJjOLWBAiRq
 KUItldZ5j6UllDbp6DZMLCu3L6EBxbQvHats1ly+K16LTibkTyKMknH8dw274zVp7U7Y
 659UHxgPymBIcSJfG0E0xXiKmvjscs0cTI2XqF+fJHAoOPad7x7BHoPJ+Or6JtNM4oXi
 yYlMzrWtAhz317UAkPDTntKWZv7BMp94pphET6hJI+Ye9vQYITvzvhZV2Ag8N4u28Kqf
 Q6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153040; x=1700757840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nj28H7ZiG7dYCdUVs2gcu/7Y2e3Bgt1CBt9kV7IZD7I=;
 b=cANB97DpLlROdHIbdqT75u133rPlvIbKIckg6Z+h570H37rJLAwN+QOGrRdBL5PVna
 yxwFLAnC/Kztwp7Ob35owY/x6uQas7iJGuzKzVxcqlcU7jsEuz4mdjO+7ZWCGZQ/8QVx
 0IXO5+YjIzTloyd9kD/vIJvU49OxmLVhQZwzZ+yVTroNKz6qvSilRk/FRDtCp7elrUuA
 HB7ZRTJ+HHhZr1Xh6y9kD9ViQFRwMXkvIjS6Ewc+lQicFMBLVLUnCwj4x9ChpiukA5Ya
 UGSY9ZSVAYM4/BRj9MP6W4FXNUgWFJ2HnF4y7Wf6oXXtstYjYPSkEuykI4tD2+4qaOri
 cICA==
X-Gm-Message-State: AOJu0YzxUPuZg21GjvK+Drb6DZg/dyXKNtiSumshMvv5k9mt3JG7718Q
 xYg64HCEDtXey/ZO5OizwD2JLw==
X-Google-Smtp-Source: AGHT+IF/UVKGBWEfujLazEJ7YY3YUDfxqq8zaxJhaYqQnca0gQFVIwT6L0HjTHM7IUtooHVrO6Y22A==
X-Received: by 2002:a17:902:eccf:b0:1ce:5b21:5c34 with SMTP id
 a15-20020a170902eccf00b001ce5b215c34mr119643plh.5.1700153040012; 
 Thu, 16 Nov 2023 08:44:00 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:57e3:f37f:e352:7f6c:bf18:83f0])
 by smtp.googlemail.com with ESMTPSA id
 l2-20020a170902f68200b001c5eb37e92csm9439839plg.305.2023.11.16.08.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:43:59 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/3] Xilinx SPI driver enhancements
Date: Thu, 16 Nov 2023 22:13:33 +0530
Message-Id: <20231116164336.140171-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

This series makes the Xilinx XPS SPI driver compatible with the MMC_SPI
driver and also includes an enhacement from the corresponding Linux driver.

Changes in v2:
- Improve comment and add reviewed-by tag in patch 3

Mayuresh Chitale (3):
  drivers: xilinx_spi: Use udevice in start_tranfer
  drivers: xilinx_spi: Add xfer callback
  drivers: xilinx_spi: Probe fifo_depth at runtime

 drivers/spi/xilinx_spi.c | 68 ++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

-- 
2.34.1

