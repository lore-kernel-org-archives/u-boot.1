Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A4FC4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 15:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D31087C6D;
	Sun, 11 Feb 2024 16:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6tt9K74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7162087C75; Sun, 11 Feb 2024 16:45:50 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8448587C69
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 16:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d09d90fa11so32162241fa.3
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707666348; x=1708271148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=90n5dFUw9S6m8bY1tX/q7h9mo79YgmkyT3Kx1Gb1/iI=;
 b=W6tt9K74GAETLVAUaQYjaRRSMhUcjR+00LCYZtalwXVl4loHHYts0YUeYlEcGxBfpl
 4++oKE6/A3ojI9g7sHdkdVr+fldbD/odvgeRNTjL4cuK0j0M+JSWgKkFd8BWAgUk1fX3
 Anr4t4L22jfJqhxVOz3Je8cSVipm79HyYbcxowgsChatheP1S6EFDRXrZoc+t/v2qpsz
 tVBg+SAWQwSt3u3RTIwFdkDG7n2MluS+E2U9OydB7e+XRoVfdY4iJkZNoDQHsb6KywfS
 7mYN53G9RcB5bpAInMek66721nFPTCJiL4W48f6dx3OjGhHsr0wubTJYp1sKtRxaHVgu
 ANLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707666348; x=1708271148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=90n5dFUw9S6m8bY1tX/q7h9mo79YgmkyT3Kx1Gb1/iI=;
 b=ie5HiciQgG4/h4KyEUhi881OcrbzFYD3D3xOEqbSKJ0oULK6zbcJ+dvHJFFFrryzIM
 tKVczz1Ht/OozNxXPaQhr4TVyGcrf58eTV33j9ogOt1xhzSGgyQ32qxD7jJ/X9W+MFNt
 sPjvIYWJBhdQbaeP0TMGfMiKANzJoJ4Btt0quV1qjQYs847RqOWjzphTdbYlFvmd70SF
 J3ARbE4en/fn7M+URde5/5LIXGJHLUz8e7MX3BEvjU6fJeG///vN6YnGxzVGXVUgWMVJ
 iOEAuzWNE3PFY8PJNDIpKVcbJ3zJ/dU5KDTb8DNGuzmq5w+kkEHrNGromGv7rR5miwJl
 1GIQ==
X-Gm-Message-State: AOJu0YwIW9yZgpVZrBaCHMD5H8tiBMQnWb8X1qZE+bCr21tM0pGGIXp9
 td7Jka6YTdAkxC5bLGT776SZ44m/qVZLWz2s5YE19ew5dS6jbqDYG3UkZtG1kWo=
X-Google-Smtp-Source: AGHT+IGGtaPn4oCJ6rSZcYj0+EOtS467DTmhN0/yflRqD+K0bl2LpIFXok+hCebrHWi44gI5JFV5Ow==
X-Received: by 2002:a2e:9bd3:0:b0:2d0:c273:669a with SMTP id
 w19-20020a2e9bd3000000b002d0c273669amr2683346ljj.46.1707666347474; 
 Sun, 11 Feb 2024 07:45:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCURrNWPjzUSqsnL54K/lTVDPpdXCxGyCBIwWJYzMiPvtbCxW+sToApyv/stJFPgSta9wnx81Aa3G2dhK4MkX9p5AX5Yk+jOuzNiIdGUZDZo+zoW7QUuFCQeWnh2byOJPpcrNTzKGkii/pY7PCHCNKa7iK+SlFlZAxY91neDaxh0nsURFkb+9bvb2tWGAybT47Ok4B+B18vI9ERZ9hMDAN/nA8qrbBfDTA==
Received: from localhost.localdomain ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a2e7d0d000000b002d08153c3cesm1003672ljc.42.2024.02.11.07.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 07:45:46 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] sunxi: defconfig: Add pstore support for pinephone
Date: Sun, 11 Feb 2024 18:45:14 +0300
Message-ID: <20240211154514.925977-1-andrej.skvortzov@gmail.com>
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

In general any DRAM address, that isn't overwritten during a boot is
suitable for pstore.

Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
later in the boot process. Ramdisk start address is 0x4FF00000,
initramfs for kernel with some hacking features and debug info enabled
can take more than 100Mb and final address will be around 0x58000000.
Address 0x61000000 will most likely not overlap with that.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 configs/pinephone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index 9d39204a43..7b80cc3131 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -10,6 +10,8 @@ CONFIG_DRAM_ZQ=3881949
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_CMD_PSTORE=y
+CONFIG_CMD_PSTORE_MEM_ADDR=0x61000000
 CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
 CONFIG_LED_STATUS=y
 CONFIG_LED_STATUS_GPIO=y
-- 
2.43.0

