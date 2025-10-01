Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349A8CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED3F2835B9;
	Wed,  1 Oct 2025 22:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TbIIfneQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31809835B3; Wed,  1 Oct 2025 22:30:39 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 171878352B
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-30ccec59b4bso274738fac.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350636; x=1759955436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FeSxMEP7mxhib9KxWd4T+b546VVKOXTT++yQ1rU8Ewc=;
 b=TbIIfneQ4NBvnv1zqzAcxAk/GehDbJ3MjOex5uJGba9D/399YrzGBx0SZMEAqO+Rz6
 WQRN2P+R36/7qyo8YPhSsl/jF0N2SC4s+2L6mMkYqX7h9M+q/IYECHb3nYHklYzMvz5K
 qHWWt53JP+yUq0sUxVo4cGx023lvaZffVlUQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350636; x=1759955436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FeSxMEP7mxhib9KxWd4T+b546VVKOXTT++yQ1rU8Ewc=;
 b=kUDGJ6aDuR+Bzx4PG8n6e4/g6mtmeQg3X3wxihp1aau1Z1fI9bAValk4kJ59Qln4Qk
 6r8LtYJCJc53SKOPG/qPUyKE9TgnQ0aqDmgX0FziuCoNa1qVm5lqwU3W6vQ8Y80UEhAW
 4feiZZhRaQkhG4qf414F8VfQ3ZkLNfDUaj6c0FeGd1pGZmC4lZYXcW8JFO2HcxzxnJG+
 rQVkRzi0OnSCY2fN0dh0m/2ChZVCcL2grq/kcR0l+qOOGLss6u9qX5Zak032CoDGOahf
 l0AS0lhX/O4AWW8keECNz4ziidyEY+ttEgYpuItYdfB+cTRS+OBS77c+HF8ifPYDdiGF
 mcXA==
X-Gm-Message-State: AOJu0Yxv+q4CouHfTS/+BKtyZSf9Les1oencfT0IFAR1N4dWfGeC/03H
 +bAR9yJFna684cOJPK2rrD4zMLr6qpkn2NQCE/1Zvuquj94g01Mf/HV9JuzQDD4gTU/4ghuAeGA
 r7gPBZuM=
X-Gm-Gg: ASbGnctinihWs5JyL0kt69y6T7JtbvAQpeaYvk8IMbtqlL5cUI8uEjgpFjzzO/zF06k
 T7MpHhgtpVqskIpdjnRn38srEdiYXyB/DJGjwz3AuWukeu0TBX7H9awp2z6RHGkl6g9qis+igG6
 EJ4bN9khfMa78A3RiIEAzk8+7i5Qxskv9v5/Z6ObZeEdFvpPYT7qbRPjJsL+xGk+tr6B8qANmYB
 CfVSPhZRCYrsjV/Lbf19bXVfgy2qCZCk4OalDO38gq1blosN4EQSU8GGbvzzHB2cwp6eegZqPDS
 ECcdTzJg8NEDMwHAsDBh9mdlqcI6NBCITF3tTqr4CeMEJcJ85YYjH+TLWw2Vkk+gg8b3k+0aRJ1
 GqJ3/gkjayg1MwRjNQsxvZd4MMqywf9EXuU9DfatG/cuINdcJjKn5WSRB+DeOBJP5qtC897U+QX
 NWhxTfdmg=
X-Google-Smtp-Source: AGHT+IFL259htPUX++m2mgSOYp5tz3UeXOVOYq5Q72kEid5uBwtxXPtjeHSxAWTUhYwV89bc7mnaUg==
X-Received: by 2002:a05:6871:808:b0:332:fc:dadc with SMTP id
 586e51a60fabf-39bb0a0b4a8mr3445088fac.27.1759350635685; 
 Wed, 01 Oct 2025 13:30:35 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab930c8e7esm214035fac.24.2025.10.01.13.30.34
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Expand the BOOT_DEVICE enum
Date: Wed,  1 Oct 2025 14:30:34 -0600
Message-ID: <20251001203034.2828228-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

There are many more BOOT_DEVICE values that need to be set in order for
allyesconfig to build, so add missing ones here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/spl.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
index d824b2123a25..df773a5e74ae 100644
--- a/arch/sandbox/include/asm/spl.h
+++ b/arch/sandbox/include/asm/spl.h
@@ -9,16 +9,29 @@
 struct spl_image_info;
 
 enum {
+	BOOT_DEVICE_RAM,
 	BOOT_DEVICE_MMC1,
 	BOOT_DEVICE_MMC2,
 	BOOT_DEVICE_MMC2_2,
+	BOOT_DEVICE_NAND,
+	BOOT_DEVICE_ONENAND,
+	BOOT_DEVICE_NOR,
+	BOOT_DEVICE_UART,
+	BOOT_DEVICE_SPI,
+	BOOT_DEVICE_USB,
+	BOOT_DEVICE_USBETH,
+	BOOT_DEVICE_SATA,
+	BOOT_DEVICE_NVME,
+	BOOT_DEVICE_I2C,
 	BOOT_DEVICE_BOARD,
+	BOOT_DEVICE_DFU,
+	BOOT_DEVICE_XIP,
+	BOOT_DEVICE_BOOTROM,
+	BOOT_DEVICE_SMH,
 	BOOT_DEVICE_VBE,
 	BOOT_DEVICE_CPGMAC,
-	BOOT_DEVICE_NOR,
-	BOOT_DEVICE_SPI,
-	BOOT_DEVICE_NAND,
 	BOOT_DEVICE_UPL,
+	BOOT_DEVICE_NONE
 };
 
 /**
-- 
2.43.0

