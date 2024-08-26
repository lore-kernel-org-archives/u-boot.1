Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFECC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9485588AFB;
	Mon, 26 Aug 2024 20:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TzaBsL7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959F388AB2; Mon, 26 Aug 2024 20:20:32 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7485888966
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20230059241so37201265ad.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724696429; x=1725301229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u7YZijsVUiJwzv9u+l+P0Owc2uKRlrVo1gpzVBQQ+EU=;
 b=TzaBsL7CsnOJhcQ8Z8nO+Er3DHC8e5/1TlBV+YRzufFWebVQONkmJLj4nsmFwG1XbB
 PUA0/VChYu/dMHxsNKdQ7K1q04N5qj4YZm0zJfZr0vJmx613uxL8n1a1ebyfI2lYnpcR
 3y7EuU4Ga/H/2vugfNKsSyHPIEH4XR47b0m8wsO/sDXhWtYq+MaoFzaia3PoDXsBzK42
 +RKkh7b1OlgYbvfRFrLVMmXv9Tusz9zdCXg9Mjqp0zLXeYKzXacZU8KOKSl80rAnK54H
 AuFe/qutRq6jB+ug/GnR7K8ODV8umt0gnwXzRo4YJQWKtKAEVbjZkMvtBq0qB4YKVJLv
 S0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724696429; x=1725301229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u7YZijsVUiJwzv9u+l+P0Owc2uKRlrVo1gpzVBQQ+EU=;
 b=QvslwfaodNvdw3tv/Gef+mPV8Xedapt5wtFpPyf4qKoYSF/8aFzKIlRyXi2CwzcSRV
 s6nKsbJYHr2KsRxVXSCXEN4PTXOooaSSJPmj0alybO3F4hox7IdfOsV1RGEbwId7qJuP
 KrnBzyp7fZPS8jxsGMVuRrD8kzXlFiZL+4j6K4D0D+EAR2X06pAivTHS3PC0IonoxHer
 LykU9OAiwlWv3fK2N4FVjnxrzswyvYXpEUd5UjChUudnrDCHljm0D+YmRX5VyorkmBlx
 qPg8zUpFnm0GBmjSv1UquvjFGfTVQaJbhykMG6c4iEHTkL22GOMZNsz16opgpqP5CaJn
 LatQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY9rYkeSLCr0PPgRelo2k57jbTfyHgwoMpzw4ELL/gORhn/Avooj01YMVw00UJB8WkUEd7npw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywf8YYmQtutVCsTEHrvUNgi/jWOUzI8j/iygxmUBdmzvr5Vb0OH
 tI5QNlUJz6C0wZ8Z5a/LymTmmKl0vNyo99/8NinHcX+QTVvhoMXT
X-Google-Smtp-Source: AGHT+IE0eABWgCEw6iZYRnEIV+3vt/C/RAJDD5JAk/9R1ebFXObkeOqJatF0+hrlMsepQOyfQfhkKA==
X-Received: by 2002:a17:903:32c5:b0:202:35cb:b0cc with SMTP id
 d9443c01a7336-2039e44c8a5mr96455895ad.1.1724696428681; 
 Mon, 26 Aug 2024 11:20:28 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385fcf5efsm70548145ad.305.2024.08.26.11.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 11:20:28 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Keerthy <j-keerthy@ti.com>, Amjad Ouled-Ameur <aouledameur@baylibre.com>,
 u-boot@lists.denx.de, Hiago De Franco <hiago.franco@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH] fs: Fix SPL build if SPL_FS_LOADER is enabled and FS_LOADER
 is disabled
Date: Mon, 26 Aug 2024 15:19:33 -0300
Message-Id: <20240826181933.252020-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
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

When SPL_FS_LOADER is set to y and FS_LOADER is not enabled, the SPL build
fails with the following errors:

  AR      spl/boot/built-in.o
  LD      spl/u-boot-spl
arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
`fw_get_filesystem_firmware':
/u-boot/drivers/misc/fs_loader.c:162: undefined reference to
`fs_set_blk_dev'
arm-none-linux-gnueabihf-ld.bfd: /home/frh/tdx/src/u-boot/drivers/misc/
fs_loader.c:185: undefined reference to `fs_read'
arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
`select_fs_dev':
/u-boot/drivers/misc/fs_loader.c:89: undefined reference to
`fs_set_blk_dev_with_part'
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
make: *** [Makefile:2055: spl/u-boot-spl] Error 2

Fix it by replacing the FS_LOADER with SPL_FS_LOADER in the Makefile, so
the fs.c with the necessary function definitions are compiled.

Fixes: b071a07743d4 ("drivers: misc: Makefile: Enable fs_loader compilation at SPL Level")
Suggested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 fs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Makefile b/fs/Makefile
index 7b05c79e0ccf..a3ee0a361d3d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -5,7 +5,7 @@
 # Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
 
 ifdef CONFIG_SPL_BUILD
-obj-$(CONFIG_FS_LOADER) += fs.o
+obj-$(CONFIG_SPL_FS_LOADER) += fs.o
 obj-$(CONFIG_SPL_FS_FAT) += fat/
 obj-$(CONFIG_SPL_FS_EXT4) += ext4/
 obj-$(CONFIG_SPL_FS_CBFS) += cbfs/
-- 
2.39.2

