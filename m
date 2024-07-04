Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B52CC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 12:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8887188650;
	Thu,  4 Jul 2024 14:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W+J9i0Fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA289885D7; Thu,  4 Jul 2024 14:03:54 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7699E88650
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c995aeb1ebso65445a91.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720094631; x=1720699431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3H2ciaOSTgPQavrCSd9nkyNcwVkGWaMRlu3oCZM4NTk=;
 b=W+J9i0Fyg5LncZgyK9gYjEPrDCZKJ/l17X3azSyL+WOpIU1VBX+YjfmDt6GQ1xoCkO
 gz/wegTfH+/HCLEQz7Tanj/f4bfjd6976IM3NgC8gVN9hjaOGUy9mS5vS5WEDCaLMFZ1
 01saVVOKCVM/3B+05c/j3mhU0PjhXQm3x/B7oLAbHb4aSfVFlW3D9RlYRUn1POt1THmf
 SxNR6KtU7KTGeWbsA52jLgxC5z5pv4FZdgvYiH8UyMxf2xtpgebFrFcrbavLbduONcLA
 ycnSpYbBTFd36R6e9N5qo6wIiWF+cM+B8A82H9MP7UH9IIsrOniNxeI1uJQ5w8PKJl/s
 Rsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720094631; x=1720699431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3H2ciaOSTgPQavrCSd9nkyNcwVkGWaMRlu3oCZM4NTk=;
 b=ToUPItxJpID5K15iEUiq0mGmYVPLy3kq5mGDKu3VSMZvJpQmsHj3y1U4LvEJ1oISWx
 L+ktsVvZJf5tp8MMhwE61ecPnNzBObtMytrzbF8B9WwntqaOCgdacIIAbEqvjVHsvBuz
 ZDOM5xCporGIgMDBA3cIIcJ9VO/6MHtVKdQdTwytVqEdtpGZOl4hrUkLUKiUC62ehNQM
 OinrkiQHzx+p1CNUV9dE4sA8ZCCuI+F0BLInANvYGWJ5LAiGARB0MRjxwLf1dKDbnqFk
 1w5pnSO61FCqiEQrDJ7dRn/vSZdkMRqvB7WLvmZaAIiRvfkuuNV1yYe4z2KiX3RMSRzR
 R2XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo2duIMP/I6f/LU+y+O1xF5U+H1FQkUpgh+YU3KQtNRUoE1DGIroWo3WG9dW78y0c0USFgjtIgAIsNWEICpEzSQclzCg==
X-Gm-Message-State: AOJu0YwwzaWClkSZMWoIK7LxIYlo+6PTNRr7M9FDAJ3wuawY4Mwf8qbD
 ZTvZGB5VHbciv9q9oHuCSgSs1x+6CcgFUXq85ZTlVdrSEHr8QbtbHInhPQ==
X-Google-Smtp-Source: AGHT+IGItSuENzUuuFSvSLlhTDODru4PmM5S0kFiYvsGCak5F4MT6YDMvtla9QeMXPGKCYENlYsv1Q==
X-Received: by 2002:a17:90a:148:b0:2c9:8dc2:7768 with SMTP id
 98e67ed59e1d1-2c99c841adcmr1333980a91.4.1720094630687; 
 Thu, 04 Jul 2024 05:03:50 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4fd9:3a00:dbd0:b26d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a9ce680sm1319929a91.40.2024.07.04.05.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 05:03:49 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: ian.ray@gehealthcare.com
Cc: sbabic@denx.de, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] msc_sm2s_imx8mp: Adjust the initrd_addr location
Date: Thu,  4 Jul 2024 09:03:37 -0300
Message-Id: <20240704120337.673211-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Booting an initramfs with the current initrd_addr address may lead to
initramfs corruption and boot failure.

Fix the initramfs problem by applying the following layout
suggested by Tom Rini:

loadaddr=0x40480000 --> Gets moved to 0x40600000 in run-time:

   Uncompressing Kernel Image
Moving Image from 0x40480000 to 0x40600000, end=41e80000

fdt_addr_r= moved loadaddr + 128 MiB = 0x48600000

initrd_addr=fdt_addr_r + 512 KiB = 0x48680000

Signed-off-by: Fabio Estevam <festevam@denx.de>
Tested-by: Stefano Babic <sbabic@denx.de>
---
Changes since v2:
- Apply Tom's suggested layout.
- Added Stefano's Tested-by.

 include/configs/msc_sm2s_imx8mp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/msc_sm2s_imx8mp.h b/include/configs/msc_sm2s_imx8mp.h
index 3c7d96cb3c0..d0c5da7b98d 100644
--- a/include/configs/msc_sm2s_imx8mp.h
+++ b/include/configs/msc_sm2s_imx8mp.h
@@ -36,10 +36,10 @@
 	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"image=Image\0" \
 	"console=ttymxc1,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
+	"fdt_addr_r=0x48600000\0"			\
 	"boot_fdt=try\0" \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"initrd_addr=0x43800000\0"		\
+	"initrd_addr=0x48680000\0"		\
 	"bootm_size=0x10000000\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-- 
2.34.1

