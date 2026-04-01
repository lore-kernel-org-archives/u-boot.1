Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C279210F6FCB
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3359784010;
	Wed,  1 Apr 2026 17:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HzzeBx+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FA2D840AB; Wed,  1 Apr 2026 16:18:59 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8936980517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so64026845e9.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775053137; x=1775657937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2pDCCUt+Q7P/UzxVZX7i213nF80aViZS2FAaIetF4ZU=;
 b=HzzeBx+rmQ76o7lIgR6Oir3FDJqAN8Tu70PaG24kRrNLcPQ1oQEyFxILmpXo2BfFYT
 ME+jYNTKvCFdxEGIG3gMRextu227We5YarZeiUTCnxJPbqPwjIIQuEHdIAAA5dh7qxun
 ePdj2jsRMCaNsgcKtE3x6pLp8XBgLcL2wKymRko1wlS7msAwWAetNztrq8Hh+xY4JC1x
 K7e5snm2GyCMTejpHUj6J5Aaz8hZtYBI8McGLNI191/I/j0G+lLKlfS/1qfPkt3wZccN
 fh3LfAzi2ixX6OT6aHO6JjP+OBLXJbLRSW6t4/obLbP/176YpF1XLnPWxSq2PwrdemCQ
 MumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775053137; x=1775657937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pDCCUt+Q7P/UzxVZX7i213nF80aViZS2FAaIetF4ZU=;
 b=hFLc1/6Em9RUNi3+IkR4cMgQd57zCKCUm64ZemsneSZ1WzD4c6sU/lG7utBxJyhXRg
 00fU5sbP8rCYqJYnRGKL1T3PHwQYVp4DWZv2NAW09dnXQDQPQxz/6CSlh7eLsc7OJiZb
 Fv0Z16Hc4yEpwBHsVu9XmmLPP4QVM3nfW24xm8TMxupORY5CROme5kf29RKqVqQCJJwW
 6S6W8+Kf1an7dRBTOqie9RV3Z2mMcGGOeEq+vK0j5ZIoYTYPpbEuaXrpotfLxq3OMPtb
 h2WzzIQejxDnw4ikWtnKFRyvXPHoGHJNdIpaGedBzVNUHj1JrdzpEQRVLCVY2agngHa4
 bNvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlDrTKMJVcXgHKJEUM+yf1sScA1zD2FhAXB8brVXQIEkekj2Wjp9yh31Rmj7HJ4hpy8RB8dpc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxv72qSmbgFFbW7d/GagHEX0ovffE/91BLC+ozx9Ea5liyvAY5e
 M5M32yYBNRFoVH9yNBk2J5xnzy8gT7x/FwErFbzISwUJIH+lKQRgQcIU
X-Gm-Gg: ATEYQzw3kSAKIyQhb5A9+pxh5lZWT1Oq1VTHzcl9r+rXYdlqgJ9vbO2elFcxKKZQFSI
 vbDKmDXo6fI9g0DuH6vx1kviSSZ7TPVLxMp+ihV6mEI3WEyMBCEYrOrxGTm+6YQA+/nTHYkCXL4
 ZG9QhlmJEbjq9Jb9PCZtdu29qrypYBK11ftdZfpLM7hISyhZhCaFHB148DnCcCEmMpX8gz7xLzP
 EDF6vtzGABCp+PSi2EWsWgutDQfPGa5oB8iioAWK7oZGPcvbRlyJGzjRk1Bj6r9y1XWIgOLJoT4
 wlCrseHcNkcR0JWGD153aqmOqMPI/Ik4Ju3PV/uvvmUMXzDn0YC2k/syRaa3OX9/mAwoeLlAetc
 +3pXelIpJ5tuzuDgzPNxcDzg7qmn3Dc3JhMMKibf1mqduq/P2J8V5l/KQg0oxW05aLrtWcddP30
 SFxf4CX/jaZWAxD+7ADinZh+lHKYIzD4JCp2gzSnA=
X-Received: by 2002:a05:600d:10:b0:485:3f17:425 with SMTP id
 5b1f17b1804b1-488835920e0mr49376375e9.21.1775053136661; 
 Wed, 01 Apr 2026 07:18:56 -0700 (PDT)
Received: from vitor-nb (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c884ae5sm44883735e9.16.2026.04.01.07.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:18:55 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] configs: aquila-am69: Set ENV_MMC_EMMC_HW_PARTITION and
 ENV_RELOC_GD_ENV_ADDR
Date: Wed,  1 Apr 2026 15:18:42 +0100
Message-ID: <20260401141844.539308-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 17:01:32 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Set CONFIG_ENV_MMC_EMMC_HW_PARTITION=1 to store the environment in the
eMMC first hardware boot partition instead of defaulting to 0 (user
data area), where the rootfs and data partitions normally reside,
risking corruption. This keeps the full boot stack self-contained in
the eMMC hardware boot partition.

Enable CONFIG_ENV_RELOC_GD_ENV_ADDR so that gd->env_addr is adjusted by
the relocation offset during U-Boot relocation. Without it, gd->env_addr
keeps pointing to the pre-relocation address of the default
environment, leading to incorrect environment access before env_load()
completes.

Fixes: 3f0528882c0d ("board: toradex: add aquila am69 support")
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 configs/aquila-am69_a72_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/aquila-am69_a72_defconfig b/configs/aquila-am69_a72_defconfig
index 0f85b228b063..6a0ccd15e6db 100644
--- a/configs/aquila-am69_a72_defconfig
+++ b/configs/aquila-am69_a72_defconfig
@@ -80,6 +80,8 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
-- 
2.53.0

