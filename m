Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C3C4828D
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 01:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40AF87C42;
	Fri,  2 Feb 2024 02:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a0U75MMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0346D87C00; Fri,  2 Feb 2024 02:49:03 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1AEA87CC2
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 02:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so392083a12.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 17:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706838537; x=1707443337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QyD+Mg4TL5FNYAD22wtQ1wrSfQZQuOaAyZGowNXEtN0=;
 b=a0U75MMIkjvkRSFDX0f21ozWB71QhFb7UlsqNFHHz0gV17aER43jeBnf6wnd1ggudx
 5DNBF3fE4WblmCqHTXN7qUchGmwBdSw3FlYH6uqMWn5dT59BvPPE4zVElLSoUEcRIIse
 +mCI7vRz/ZOux+OJcTtHOgWiq8TmI/vOrA2taFlw9aMDMCCQTjEUnF0vRvKQujMzkK6k
 p/dp8UqsQSd5Cc3Ejc8i7RtRKTfx4OUHll/jBEVv5rj07R7kqHFxmLPsJUz12Kiz56t2
 vzMFcl6RwOlLXheSVCcC11rjFHCSBR2hJiJqXO4dVbHGmkyvftYSSWDmSoako4WOOAtm
 grxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706838537; x=1707443337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QyD+Mg4TL5FNYAD22wtQ1wrSfQZQuOaAyZGowNXEtN0=;
 b=bGJc9esAn7ckMKiqBp0twZJ/ttkTz6W3Z9Fj2HahapwnOeiUo5EFuB0QF7Z2k0TQPv
 qeeVJJrbfmfzg0j+sdj7J51RD7WokovAuUmlU0CkUswKoRORWfYyfuSvc7aUAovm+bo+
 q3GvbVfaUKd8tywt8bKg45d0+F0IsS2uHI8//+UN/hxStTSNu1C/iYJ+CtVsEl4Oecxz
 +CCclVG8ANni7sagQo3wdpdL98FtA/wrCayqti+N8Hrcl0BKzuMZRapLdl4RkU6VBgqv
 ozR6f86vv5/YM1WCKlLPlRukmcWpQdcf3Haqx505OhmvamJKn20+q6YzWX8V8Xcwww/C
 9Ecw==
X-Forwarded-Encrypted: i=0;
 AJvYcCWmR46o1jZG7RbsL8WDQ8iqZ/+3joOxVHzoUIcvgGSFAwm8oNYEz/1i/GNfJEXIlWxZMozyoicDIzHIlA34cmJ0PdkqkQ==
X-Gm-Message-State: AOJu0YwSRud1rgY0tpubymvhbXryx7aW771fjmfuHPH/Fiw7krcsG65f
 3x8o1ldfZDGdK6MthvtHneDvs99TasxExMdfOFr8bXyChv8V5khIGduJnBqp
X-Google-Smtp-Source: AGHT+IFhpp5tvJQIpa7ww7xBpma8tSNg9KgQJkSTKZ9KWgVRJ4zCpaw++3wMbMEULZbLDiqXgjHMxA==
X-Received: by 2002:a05:6a20:7486:b0:19e:3462:b7be with SMTP id
 p6-20020a056a20748600b0019e3462b7bemr4611234pzd.4.1706838537119; 
 Thu, 01 Feb 2024 17:48:57 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVZCEul+8VuAOgz6ZgD/g1Wg+pEW6rRXgN+2vUnu7sMaRlkIGK98hZnedHkORlqRaxPxUqRVsVoU8PQy6qFyJQodGT1An4e5S0VNKYVEFs+F+B+lSSoZA==
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8e7a:352d:b9a0:297a])
 by smtp.gmail.com with ESMTPSA id
 du13-20020a056a002b4d00b006d9b345092dsm406048pfb.156.2024.02.01.17.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 17:48:56 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] mx6sabresd: Fix U-Boot corruption after saving the
 environment
Date: Thu,  1 Feb 2024 22:48:48 -0300
Message-Id: <20240202014849.4022787-1-festevam@gmail.com>
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

U-Boot binary has grown in such a way that it goes beyond the reserved
area for the environment variables.
    
Running "saveenv" and rebooting the board causes U-Boot to hang because
of this overlap.
    
Fix this problem by increasing the CONFIG_ENV_OFFSET.
    
Also, to prevent this same problem to happen in the future, use
CONFIG_BOARD_SIZE_LIMIT, which can detect the overlap in build-time.
    
CONFIG_BOARD_SIZE_LIMIT is calculated as follows:

CONFIG_BOARD_SIZE_LIMIT = CONFIG_ENV_OFFSET - u-boot-img.dtb offset
CONFIG_BOARD_SIZE_LIMIT = 0xd000 - 69 * 1024
CONFIG_BOARD_SIZE_LIMIT = 781312

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/mx6sabresd_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index a90efe4a7786..f19df607e7ae 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -9,7 +9,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0xC0000
+CONFIG_ENV_OFFSET=0xd0000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6SABRESD=y
 CONFIG_DM_GPIO=y
@@ -24,6 +24,8 @@ CONFIG_PCI=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_PRINT=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=781312
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
-- 
2.34.1

