Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47481CD8C8B
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4ACC86C4D;
	Tue, 10 Oct 2023 16:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b4vnMocc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A78C86BA1; Tue, 10 Oct 2023 16:14:49 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95CB86C93
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c4456d595cso5646135ad.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696947263; x=1697552063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lg817uBSf/h+czd1apIC+lnrjlUIrkjCYcLOYOG9Eas=;
 b=b4vnMoccxO4K/fSX9QN9ZB+fToGNekAvLoItbC7TVEMmYDEas46l5xmGtBYn1+F+2x
 Ka4Bx788ZzH0JpTRFiUG0RNCvN90GGDQ6qtKnSm2HipKMoKqRn/lRbIP0b/TL4dD2i2V
 HbGTGSrYgcMP7G3+Fz5RH2kMMqg6St527pELNzWE7ePP4f8FdnG2iBQmjyWoRZqJVvoy
 d2r9r7ehfYdlPdTyHuY7872n3KAQlESxTbBhx8r6QD4Z28+XUotPo05OQnaKUUOL0dfI
 /Pxj4kV4RNTgMRJcGqHF4EEjUVebT2H+vio+b3ewTePhW8WeyMqOPhKhj/YuTmTkyPQx
 Kq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696947263; x=1697552063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lg817uBSf/h+czd1apIC+lnrjlUIrkjCYcLOYOG9Eas=;
 b=EG7EOYnFT1U0DxEt5wQSuvM7CUwQVjz0MUp7DPIs1PJXOTTe39S9W3KKMT+qGURhqY
 3Fzg9zT8ucy3q3XP2HCMGudSh58qCNtAbSvzkBl6TlfnW7O9Svel4hm+F9hCOAKk0BIC
 ecCbsX+iqS4B3nP+53oEB5Ew//lQ6MeEmlRHkdqxa1noXU2IV6yYGFWoNx6nM8Y9++wc
 fSBwWOmKYfzURdGftipEYEOEKEwwx/E92suMR33Enc45sMkkKaqKWteb/80AVB0WNZW2
 HbbpZRmXbvs9yz316N33HU7hvHsq/sZ0TI2w8i6cONgw/mDRAC2JfZkZPaB7vx8DVp+V
 jRZA==
X-Gm-Message-State: AOJu0Yxn80+ycdA9iKqdk0gLaTkmBiSMSlnIaI+GUYj4xTA7tO4LXM4w
 80doUSWvrv4sVtSEJX/jIyY=
X-Google-Smtp-Source: AGHT+IG8k9vZOU0es5M/VfeJk6XVtALy0ZTFom4TuFmPth2tfQO0fy0Q/EuHcoZXmg2K9xM/mW3RqQ==
X-Received: by 2002:a17:902:d2c1:b0:1c1:fbec:bc32 with SMTP id
 n1-20020a170902d2c100b001c1fbecbc32mr20585795plc.6.1696947262688; 
 Tue, 10 Oct 2023 07:14:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4e59:4c23:49e8:22bb])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a170902988700b001c627413e87sm513385plp.290.2023.10.10.07.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 07:14:22 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, Eduard Strehlau <eduard@lionizers.com>,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] smegw01: Remove misuse of CONFIG_ENV_IS_NOWHERE
Date: Tue, 10 Oct 2023 11:14:12 -0300
Message-Id: <20231010141412.3681919-1-festevam@gmail.com>
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

From: Eduard Strehlau <eduard@lionizers.com>

When using a list of writeable variables, the initial values come
from the built-in default environment since commit 5ab81058364b ("env:
Complete generic support for writable list").

Remove unnecessary misuse of CONFIG_ENV_IS_NOWHERE as default environment.

Based on the fix done by commit b16fd7f75f6d ("imx6q: acc: Remove misuse
of env is nowhere driver").

Signed-off-by: Eduard Strehlau <eduard@lionizers.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/storopack/smegw01/smegw01.c | 15 ---------------
 configs/smegw01_defconfig         |  1 -
 2 files changed, 16 deletions(-)

diff --git a/board/storopack/smegw01/smegw01.c b/board/storopack/smegw01/smegw01.c
index 7b2c50a61e..345191b31c 100644
--- a/board/storopack/smegw01/smegw01.c
+++ b/board/storopack/smegw01/smegw01.c
@@ -111,18 +111,3 @@ uint mmc_get_env_part(struct mmc *mmc)
 	return part;
 }
 
-enum env_location env_get_location(enum env_operation op, int prio)
-{
-	if (op == ENVOP_SAVE || op == ENVOP_ERASE)
-		return ENVL_MMC;
-
-	switch (prio) {
-	case 0:
-		return ENVL_NOWHERE;
-
-	case 1:
-		return ENVL_MMC;
-	}
-
-	return ENVL_UNKNOWN;
-}
diff --git a/configs/smegw01_defconfig b/configs/smegw01_defconfig
index 5cfd3d2715..13665ecfd3 100644
--- a/configs/smegw01_defconfig
+++ b/configs/smegw01_defconfig
@@ -48,7 +48,6 @@ CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
-- 
2.41.0

