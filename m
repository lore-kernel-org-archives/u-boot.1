Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA44E64A88
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 12:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29B7988E6F;
	Tue,  3 Dec 2024 13:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JvB1KmMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB15088BFB; Tue,  3 Dec 2024 13:34:09 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6784588E77
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 13:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-215810fff52so25068435ad.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 04:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733229246; x=1733834046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I0wC/N7n8QmZc5TkwxABvTSGh8wJ9/L3Z/VaTCntbbw=;
 b=JvB1KmMW+xs8HhVWRztL6wv1SlgA/zEaU0P4//orAI5SCi2/Awb6ShbrRb/dvu06Kx
 VQGIOpSYGWall2dTjksRsF0Z1ZKvy5FDHsN9QueWmF8bwcplJ4u22PxhvM8VAQEsXIgJ
 AhHsntrh4GKZaTjMugiGKJtvHgll5uaaLjtRhj0lxHv7aG67fEzrKna4IdVL8p5N9vgM
 4KILKSV15L/4HkgyAKbNEQHvSyJk4TYFR6Wf/uNba9SknApEQEzASRk2lFpIDLVbDwhS
 d/2PYYh8wqFLocRcSSlcKs6hj6Ea+u7g7hB2BAg4okpJ3jw3O8MDIuOObfrkBSYtSz4M
 pIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733229246; x=1733834046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I0wC/N7n8QmZc5TkwxABvTSGh8wJ9/L3Z/VaTCntbbw=;
 b=RREDiVmlsKXWO4gySU7Z4LyoDNCkdfPfuK1prcAmENhoaEPIZRJudolfKu4PiVPNCc
 ixIyiN4aL+rMqwOTJnLh9oKQWzrvtlRqHRZSRE08Fo4qyapp/l34NJWMi6da03SBb2wo
 nAfVz6ee7aSEmetq+Y3RxOxOSZuuTe8L8ugqiG7M+EDmpJ9U+mdwDfPOmtI6P+yNvdzC
 HN5qwx+3+mz56wSKqkqcA/YdimQuh2VxnWcDUjAJqpFUJx0JraFytXmJIEgasezt+/6G
 SAJb2RHsXntkuuJA0lHWKSwyIMad10RxUXrRYZPrPaR1LOWAnXzr0AhmuHMhR17smcFi
 YWXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcCrKwHppLuZz1YcKPYcF87dRFZy/bGVus42f6TIOeFL+gA6kgc06DoM+G0kvTVPYOjVweiRo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4ATpK2A1I29yGSqmLm8xruDXYBcRmwXXpsexoQhwtCrmFog1s
 I0MJAYurqjSz8iZdxJ6AV1DlpPFKP9BLAJyDAuwF07yjwqs7CcQp
X-Gm-Gg: ASbGncuJiZzWIDqqyWQJPVvK6OlujL6J3gbrOANNDGfR2A9rLlNgjgAtJiYrrEhqN1q
 khWuCf6kQfKuY6xyQVpkz/COiFervD7t4pBOIwBJYn9bP6TBmMZNRbwYd9sHaZGJjqlwCPXv9p4
 JUYQd+LR5aWPnLVTFmH7J05xCgeU2ttSeVQYRWH+NfIMGfA6qzhi7shXeoXLtO6BuwAcNcKSmOT
 zNt0OAZgPGZHcSR8oM0FYmEGb7eNCwilr/B6fa0jwSaYMtrU3V62RiMcbkuSkOb84L7LiwX
X-Google-Smtp-Source: AGHT+IFbRTFIYVUiC9lfP0fqpBdZEIh4aLdhHQ5Tq/htkTVgkmRtGJQPB5q4py4814V9NPYkwyzIcg==
X-Received: by 2002:a17:902:fc46:b0:215:899f:bb57 with SMTP id
 d9443c01a7336-215bd26a6c0mr32413665ad.53.1733229245732; 
 Tue, 03 Dec 2024 04:34:05 -0800 (PST)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21561f7a0f9sm55651235ad.123.2024.12.03.04.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 04:34:05 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v2] verdin-am62: fix FASTBOOT_BUF_ADDR and FASTBOOT_BUF_SIZE
Date: Tue,  3 Dec 2024 09:33:02 -0300
Message-Id: <20241203123302.298188-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
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

From: Hiago De Franco <hiago.franco@toradex.com>

The current value of CONFIG_FASTBOOT_BUF_ADDR is incorrect for hardware
with 512MB and 1GB of RAM. The RAM address ranges for these devices are:

- 512MB:
  - Start: 0x80000000
  - End:   0xA0000000
- 1GB:
  - Start: 0x80000000
  - End:   0xC0000000

The current buffer address makes fastboot downloads work only on
hardware with 2GB of RAM.

To fix this issue:
1. Lower CONFIG_FASTBOOT_BUF_ADDR to 0x88200000. This makes the buffer
   to be equal ot CONFIG_SYS_LOAD_ADDR, which is a safe address to
   download files using fastboot.

2. Reduce the size of the download buffer to 128MB, avoiding overlaps
   with RAMDISK_ADDR_R. This is a good enough value for individual
   downloads.

These changes make fastboot downloads work with 512MB and 1GB devices.

Fixes: defe30a78b76 ("verdin-am62: add DFU, USB and UUU fastboot support")
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 configs/verdin-am62_a53_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 49fb9790e295..fc9ffa0f392b 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -122,8 +122,8 @@ CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
-CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
+CONFIG_FASTBOOT_BUF_ADDR=0x88200000
+CONFIG_FASTBOOT_BUF_SIZE=0x8000000
 CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_GPIO_HOG=y
-- 
2.39.5

