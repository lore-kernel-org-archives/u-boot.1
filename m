Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6944CEB2C4
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 07:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92B083EE8;
	Sat, 15 Nov 2025 08:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VGwzsvoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFEA83C54; Sat, 15 Nov 2025 08:33:44 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8B883C54
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 08:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64198771a9bso5089990a12.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 23:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763192021; x=1763796821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a+cyisrRJyLRbHGi2y+53o+IqEygZvhFX9FDkrgl/ew=;
 b=VGwzsvoX3ZicZ4J9//x/a7Ii2nG1GSxlpnocJP56Ue/qG7w4VNFge0kAZHQG14iZFr
 +f2nzJAZkE5ztdvTR9HVDiPhhTiLTN+0g4T1tg3/JPM2VWZZ+gKK6wz3WKYc4DLNTK7g
 gfQKpBCTvUYUt1ziurT/jJDlGpg4eJs2/vACBSHJfW9EtzZXBWJ1UleGjUFL6u11zdld
 OrGKqpQBi+19Ie4pnYy2raJw2O4AMU7D/9TJ2xizw5HzuSa4IaxQDyqXtSzOM6Haep3C
 FvV9D+N+D23HCGxGeQ3tZWTrRuFl/BeRQ/Y48pk2B38esWPsUl3ASQjNdr6/spWy6CYJ
 4qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763192021; x=1763796821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+cyisrRJyLRbHGi2y+53o+IqEygZvhFX9FDkrgl/ew=;
 b=XRL7dsxU4PNwku468SUiK4O0zuPGbR4YH81VeX3cW2unpZo8zn02Fn+4KGZvh/44DP
 OUabsAUnIQafvLQQFv11ieV5fTvlJ+H4Bw2nkeB1FhwvLbh7fqmSinI97bVHf5mCLHjP
 KJ8DYbC3ebbOXmynRoLG/9jZ7rG3zpVsIke05Pda+i8EvX4b2i825m7WoNFhOa2nkI+i
 k2WrNMVXzmMsphDycWxwsn5XYLb9JTVgsvlCvCIVtI2gCj1w7qrO7LUW8X7R8wNSrczP
 By+P6V830wt7R2pvKwzeWQsaDWGEMUvVAVID2x8VKmFvX5V1vG9Cc8suBu/vtc7P8NOS
 eQDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlCshk/dl8FriD6Ry334CGfmIezpOmTzw3GamZNY0YQefRBplAV/aJM/436kr7HAScQ7/KmnY=@lists.denx.de
X-Gm-Message-State: AOJu0YyyRIwpnO+5U9Akv1z3W50azBNBClDgYwt6jm8fSwd5COPUn9d/
 NBW9l3R/icp/OfkmBUTOZDK7yf7+C0zIJxbnNRnjkqnOCrSP9FpHOrMlmyfxf/n4fGA=
X-Gm-Gg: ASbGncuM6PvhJYiKhxVvW7RNpd7nqDasbCROuk1ff5X5eIBS+mtcbgTSW/T9d6r3Rse
 PphBAp/5fJ2xnPqqyK3t8VILcFFAzTwNvMcctiwvkisIedsyiWyCTT1YhunIBqf7s4N223GbhJY
 MSmx5eluyVW5JH5lWArhYOYbfZDulFydmhkJikcIBRM4RBQtD/MZ5oEKm3OZ1Mr2shCSw2US+rR
 x13elRfl0z8W8PaSjpzEXIgjcgIivcDjog8IrX49ZZ6Rul0xQOF5u5pMIlF2jrAlVnbdbJbgqpA
 72f0jQJuziIKmlBpRzKD/RcAdg41xJjIpM9u9nLkiHasi4F3Zg8XsJQvFAIVBZzL2e0Fau/vqFl
 DNuKClqD8EhNMkfKufgnvBszqceeeV6T6BYSkybqSUZTE8A43NvRgjY0eheLrvCnHZgYghPAhuG
 sS4Oa8xYbicKoslOhEsCCj33pm5ZBzuBZbkDhgOL9Imia1DHdEeGszruHk
X-Google-Smtp-Source: AGHT+IHpAwCfkYy+mQIEnkiwPxM1/LqwDvFMXFuzT75rXYgUS5AO/UmD7IHIAm0pTzMyNY9432KsuA==
X-Received: by 2002:a17:907:3c8e:b0:b73:8758:b44b with SMTP id
 a640c23a62f3a-b738758c6d0mr12069966b.48.1763192020841; 
 Fri, 14 Nov 2025 23:33:40 -0800 (PST)
Received: from hera ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73785d0e04sm167725666b.47.2025.11.14.23.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 23:33:40 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] rpi4: Fix compilation with larger configs
Date: Sat, 15 Nov 2025 09:33:29 +0200
Message-ID: <20251115073329.35720-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Tom reports that adding more Kconfig options fails with
board/raspberrypi/rpi/lowlevel_init.o: in function `save_boot_params':
board/raspberrypi/rpi/lowlevel_init.S:20:(.text+0x0):
relocation truncated to fit: R_AARCH64_ADR_PREL_LO21
against symbol `fw_dtb_pointer' defined in .data section
in board/raspberrypi/rpi/rpi.o
make: *** [Makefile:2029: u-boot] Error 1

Since fw_dtb_pointer lives in .data it might end up above the
+-1MB that adr can reach.
So switch over to adrp+add which has a +-4gb reach.

Reported-by: Tom Rini <trini@konsulko.com>
Closes: https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/issues/2
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 board/raspberrypi/rpi/lowlevel_init.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/lowlevel_init.S b/board/raspberrypi/rpi/lowlevel_init.S
index 8c39b3e12e80..30c0b0c27a81 100644
--- a/board/raspberrypi/rpi/lowlevel_init.S
+++ b/board/raspberrypi/rpi/lowlevel_init.S
@@ -16,7 +16,8 @@ save_boot_params:
 
 	/* The firmware provided ATAG/FDT address can be found in r2/x0 */
 #ifdef CONFIG_ARM64
-	adr	x8, fw_dtb_pointer
+	adrp	x8, fw_dtb_pointer
+	add     x8, x8, #:lo12:fw_dtb_pointer
 	str	x0, [x8]
 #else
 	ldr	r8, =fw_dtb_pointer
-- 
2.51.0

