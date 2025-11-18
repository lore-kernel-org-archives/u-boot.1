Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE76CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F1D83DE9;
	Wed, 19 Nov 2025 00:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L4a3t/e0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4760783DA7; Wed, 19 Nov 2025 00:21:29 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2031483DBF
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45033024e59so2767068b6e.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763508085; x=1764112885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QW7HCCplwdQyFCohZ8ki36NDBK0sY5vO6zhDGRsa38=;
 b=L4a3t/e0ThktJt8YFwPVDH2PzRaEX5XfIRU4vQ3EBJLGQ7tZT+6RG215wJeaeEcuLd
 HF7DfbwoX1wnfIdKe+lhN5Lz7pypYCIJd34iVSsbs5Vq3wFnh8wxz67B/a+P7BMiIZPf
 EW2CE70+15K47vyfY4ln+zjBhKY/g5FOrnadqgdZKzukPH3axKabRHmEWDmMkOjwj8YU
 KWOI0zawDMgzZvLOalDB92CllO/tHessqQrhEhnJRc9XademciugakxzTUjtmFJvkHws
 lxsYervCmUMwnRZhLXI5meBGFrU573ml22lOZW/vmovLlO43uTanbkShODBC5rTckf+3
 fFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508085; x=1764112885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8QW7HCCplwdQyFCohZ8ki36NDBK0sY5vO6zhDGRsa38=;
 b=WAdFXnjajpOfVZGPuee1KqPsMzxjEglKpCPUWCgW28T+B2ZKPCUxU6HEJbqEB0f1Kv
 iddvx10+BvyeiiCMCEssD5ifD/neDybNsrkBN3FrkJnKRrX3Wc6ujQ+iODUY8mSSssqF
 WGtzViNgAwKZrzENj22XvXGaPHxQstoOWdwAJCemdavlBjF9E+WQjWJVLxCID7RywOMF
 TI0efX9ca9dnY3uOie6J2GtQrtX8dmEWPbHJboJ08+t8qP3EZLGwQK+yH7ZIsw4I7mN1
 Kp23jzx1qGPVaqzJ0WdzoX8YxRZBx4BmLzPqdK7lUgxbMFxdolp0xXhJ+OGo5ZUZHYHx
 N+LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUqLygu4x0aj0J1KS2bozCqUHpqepuRsMAy/hVvrkfbmED73LsRDEbgFFeDpd7HxxCJjFIlIg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/PaqlxM4EU++4RqAc9+NF5WQvXApXzDQPCm5ZEpIBASi2MHEE
 78M/2ciQNfu0Hfazek155wwsGLxSs2Bn1G1mkjOZ51D/ZMUDLI+NBSaR7G3qkf6dFak=
X-Gm-Gg: ASbGncsreWHCvUws3oYNSzdH8R0tapHCx45ckypiLnfTsSoJEz1gBdGO9KXMSZLPCQV
 CbKfjGmGw+OofQhIrT3CCJfMkr7Guuf0RguclTUXqxChx2Q3wOJbQVvz9eIccDzoXhq+JhKfmWM
 YA3AkH7XVOnLb3eqtKCVYdcLfdR1DxEnm6q6qHNjyrlDBPwOrVLiEL0AlNz588y2u9TAsBBZa/S
 cO5JHCqTueroTAJ53lypd3xzy2+Lovi7qkIMv8FDMKDhIeJGFTAhaz43e1+nIiUvj6gxurWbqMw
 57jz8Pcmt0V09PSjSlD+j2db8RTw4PeVGb5abpGb7+DCKyO1anbDZLZ23avdB6tE7KzMOe8j4cG
 RGnXT8BiwBp9oORhIXeRiLYFOphCwrHP1QYzEsj6XCbZju8Ql/cgLcOsOrS+NkIVTXLDHpD1eHG
 cV9HDc/EB+fbkefLhd7Cr8
X-Google-Smtp-Source: AGHT+IF3mdf+qnO7vfvR52fPTe2OWM9oNplrNzwhaT146F2rnoGN+m0XyKsPfZ7t2DELXsgbe7DVUQ==
X-Received: by 2002:a05:6808:218a:b0:450:5aa0:3681 with SMTP id
 5614622812f47-4509744f567mr7842013b6e.4.1763508085391; 
 Tue, 18 Nov 2025 15:21:25 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 5614622812f47-4508a682846sm5668678b6e.14.2025.11.18.15.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:21:24 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 5/6] board: samsung: e850-96: Load firmwares over USB on
 USB boot
Date: Tue, 18 Nov 2025 17:21:18 -0600
Message-ID: <20251118232119.17928-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118232119.17928-1-semen.protsenko@linaro.org>
References: <20251118232119.17928-1-semen.protsenko@linaro.org>
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

During USB boot it's expected that the bootloader (U-Boot) should
download LDFW and TZSW firmware binaries over USB, using corresponding
SMC call. Once it's done, the Boot ROM code can release the USB block,
so that it can be used in U-Boot (e.g. for flashing images to eMMC using
DFU or fastboot). Otherwise USB wouldn't be accessible in U-Boot, and
any attempt to access USB PHY or DWC3 registers will lead to abort.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 board/samsung/e850-96/e850-96.c | 36 +++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 3cf98a01b703..3aa4992a36d5 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -11,6 +11,7 @@
 #include <net.h>
 #include <usb.h>
 #include <asm/io.h>
+#include "bootdev.h"
 #include "fw.h"
 #include "pmic.h"
 
@@ -31,6 +32,10 @@
 #define EMMC_DEV_NUM			0
 #define EMMC_ESP_PART			1
 
+/* Firmware size */
+#define LDFW_MAX_SIZE			SZ_4M
+#define SP_MAX_SIZE			SZ_1M
+
 struct efi_fw_image fw_images[] = {
 	{
 		.image_type_id = E850_96_FWBL1_IMAGE_GUID,
@@ -127,11 +132,34 @@ static void setup_ethaddr(void)
 		eth_env_set_enetaddr("ethaddr", mac_addr);
 }
 
+static void load_firmware_usb(void)
+{
+	int err;
+
+	printf("Loading LDFW firmware (over USB)...\n");
+	err = load_image_usb(USB_DN_IMAGE_LDFW, LDFW_NWD_ADDR, LDFW_MAX_SIZE);
+	if (err) {
+		printf("ERROR: LDFW loading failed (%d)\n", err);
+		return;
+	}
+
+	err = init_ldfw(LDFW_NWD_ADDR);
+	if (err) {
+		printf("ERROR: LDFW init failed (%d)\n", err);
+		/* Do not return, still need to download SP */
+	}
+
+	printf("Loading SP firmware (over USB)...\n");
+	err = load_image_usb(USB_DN_IMAGE_SP, LDFW_NWD_ADDR, SP_MAX_SIZE);
+	if (err)
+		printf("ERROR: SP loading failed (%d)\n", err);
+}
+
 /*
  * Call this in board_late_init() to avoid probing block devices before
  * efi_init_early().
  */
-void load_firmware(void)
+static void load_firmware_blk(void)
 {
 	const char *ifname;
 	ulong dev, part;
@@ -175,7 +203,11 @@ int board_late_init(void)
 {
 	setup_serial();
 	setup_ethaddr();
-	load_firmware();
+
+	if (bootdev_is_usb())
+		load_firmware_usb();
+	else
+		load_firmware_blk();
 
 	return 0;
 }
-- 
2.47.3

