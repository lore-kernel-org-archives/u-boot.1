Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0085C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 15:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C1D488452;
	Wed, 26 Jun 2024 17:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WzCDXWlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC5C8844F; Wed, 26 Jun 2024 17:15:40 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D11CB88315
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 17:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f9cd92b146so53532055ad.3
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719414936; x=1720019736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BNGM0TQ+C5MiJk3yc8dX5Z8ezvzmDyER8OhJD4UkE9c=;
 b=WzCDXWloWSQPNJojVDE+egVJ0CwXndd/T/nb0wkaj8Fr3O7O9Y+Jkjgn1n/pKm7xM0
 0GB6g93SBKBTJEKmhbRdFkKc5NW5Ru9ZHm626+wA6PtsSFVjPXGm2dYjhuQG527dq5IR
 t7b/mU8qA2y823DTn/2Q+l+RorpzwW1IP2o7Ldck7yp2cd5w/vAt0sGnhB22pgLigHjy
 kueoLeYTu6sKDlFZ4B9M4LcsvX02EYIZjY50PP9SDd1oc0q4hFMVHjzCtXIM/M7j8M/f
 +W47TS+VQ8vCB0Pp83U5bz/MzJt35ZrtMSjuAwPsJ15xf6JE5FYLvuDOk4Tsu3LSDgPh
 Y9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719414936; x=1720019736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BNGM0TQ+C5MiJk3yc8dX5Z8ezvzmDyER8OhJD4UkE9c=;
 b=KCAFXlBinIWK/czP9KJTw5rQ0zGCjGBuLkj4dMtAbzda9AwN+pTZRGo2SdVMXyxNUU
 tceetohNnAswX16z+bMXK7dNlE1q6BmnjxDe+miGlGJ9ZWNzzKKRoTRavNXiVnPcZYY2
 NmpBKSBqLNZG6kY+pFsfX0i08Ipe1LXRIBh1ch7eWwUu+YmfCkmY4ojNiFO92IMqAfGF
 uC+JGQka0tfrxeuRFFXO79xl1AL/aMUzNEacjxPcg9wXXAw4UxDb1ElzH2R4/FpKdjXL
 CyxomR0WeTPH3co/2K57KEBFg6D+wcvLzjzwSnSLwrimTiqXFk7fIu4uMPq6ykVp5yc1
 SC7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKJemCaLjo35/WvAXa+dQEo5WbZ8gdGV0Xxh9GhEgZ2zjBizyp9bnSSSYaSRAs2yyezNFPw3eVp32JpDTq3H3ALV8ilQ==
X-Gm-Message-State: AOJu0YwoPd0QybhSypJNrAjXBUjOWvgQuo1zy37ra2YtOp3u2r0rdFFH
 d7sgVA2zgJz6M9TmhK2fMSpcje7pB9P06/WNuu+HBAG+gjlXTqir
X-Google-Smtp-Source: AGHT+IHX79lxPzQifqqSSRFgpRSRysp6z3xFrSeThJAACfgneBm8Vv31LcGdmyjDaumGHepFv1LAGQ==
X-Received: by 2002:a17:902:f60d:b0:1fa:4fcb:c198 with SMTP id
 d9443c01a7336-1fa4fcbc1bfmr90681915ad.44.1719414936022; 
 Wed, 26 Jun 2024 08:15:36 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fa060eeee9sm85536795ad.280.2024.06.26.08.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 08:15:35 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 --Minkyu Kang <mk7.kang@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/2] dm: exynos: Correct CONFIG_SYS_BOARD setting for
 Odroid XU3 boards
Date: Wed, 26 Jun 2024 20:45:21 +0530
Message-ID: <20240626151522.83561-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
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

Fix the issue where CONFIG_SYS_BOARD was incorrectly set on
Odroid XU3 boards, causing boot failure. This was resolved by
correcting the SYS_BOARD entry in Kconfig to load the correct
device tree source (dts) for the Odroid Exynos5422 Platforms.

Fixes: f76750d11133 ("Convert CONFIG_CONS_INDEX et al to Kconfig")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
U-Boot 2024.07-rc5-00042-g80a111f426 (Jun 26 2024 - 15:03:09 +0530) for ODROID-XU3/XU4/HC1/HC2

CPU:   Exynos5422 @ 800 MHz
DRAM:  2 GiB
Core:  74 devices, 12 uclasses, devicetree: separate
MMC:   mmc@12200000: 0, mmc@12220000: 2
Loading Environment from MMC... Reading from MMC(2)... *** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Model: Odroid XU3/XU4/HC1/HC2 based on Exynos5422
Type:  xu4
Boot device: MMC(2)
Net:   No ethernet found.
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc2 is current device
Scanning mmc 2:1...
Found U-Boot script /boot/boot.scr
2046 bytes read in 22 ms (90.8 KiB/s)
8104280 bytes read in 519 ms (14.9 MiB/s)
Failed to load '/boot/dtbs/exynos5422-smdk5420xu4.dtb'
SCRIPT FAILED: continuing...
No EFI system partition
No EFI system partition
Failed to persist EFI variables
No EFI system partition
Failed to persist EFI variables
No EFI system partition
Failed to persist EFI variables
Loading Boot0000 'mmc 2' failed
EFI boot manager: Cannot load any image
MMC Device 1 not found
no mmc device at slot 1
---
 board/samsung/smdk5420/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/samsung/smdk5420/Kconfig b/board/samsung/smdk5420/Kconfig
index a9d62fffa5..37d6bbbed1 100644
--- a/board/samsung/smdk5420/Kconfig
+++ b/board/samsung/smdk5420/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_ODROID_XU3
 
 config SYS_BOARD
-	default "smdk5420"
+	default "odroid"
 
 config SYS_VENDOR
 	default "samsung"

base-commit: c53b344475734d0d29f522b7b1d80c5b8204442d
-- 
2.44.0

