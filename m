Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8C4C3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E557088B6B;
	Thu, 18 Jul 2024 19:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dx0jtTEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2085C88B62; Thu, 18 Jul 2024 19:36:48 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FFA388B0C
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368313809a4so64817f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324201; x=1721929001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHUZOcN6LGzTYsEcFz1bu++nyyRzG75KyCmrYVVCOvM=;
 b=Dx0jtTEz4A/zeOublV73zZiQT2SIvoyGX3456gFzyq85kJJZncjwBPqNZqlE74/T7l
 3/45jRRvA5ScbexFeLjtzSWR9r521tIZ1GEnMCE/adtW+TwBSPTEmauQ9zyY0Va588AA
 oJeC0byTFe1+xHS6lsYz/K3F3v8Xi3xqR4k/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324201; x=1721929001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHUZOcN6LGzTYsEcFz1bu++nyyRzG75KyCmrYVVCOvM=;
 b=I6vB/wyER/GiVDp/TuO8gX0XgVnbgRVcc4mpGhP5xdfbsuc7/gochbDGalNvzHcu2w
 lOljPSIVMpWyfuL25tR8u9JkXxwVX+Qx013LrW/fpwZZXyjNsdmYo5dUWKvfcIzfN9fT
 sroZ8xsTKO68cJDrfkNAN7AfokigcQQ14lNa2cQfa8qaa84uRvphs1e2XYy4gJsbPo9P
 ZSj6oxMmuo8fxfrRTRuy0zkQzNl0A62K0tBgzsTgFUlFtuRNE8x7QarqwWtMfhzUqhoM
 b2fbOEFvptgd0mR63WyaHWp1Sw94RjW4uyF7X3GhD/Jbr5/zekaCGvlu07+f45tVqNOV
 1yQQ==
X-Gm-Message-State: AOJu0YzFG71gX4EGCdRaPw9FNp1kG4qBmJqWX0b3zQQdd1pUSDZGDND8
 X5/X/y4LX5UAJG1z7XUmDK98aMG0NTr27g3I2U8ITwzaBdRs2/+VS/5sccKJybLGua0WVfI0S54
 =
X-Google-Smtp-Source: AGHT+IGrOHP4l4A5hlRAp85I7U5odX4ilWmaj+ku8vkNE6GElhccll74YBbVrtaih5y1Irkbjl9S7A==
X-Received: by 2002:a5d:6ac1:0:b0:366:ea4a:17ec with SMTP id
 ffacd0b85a97d-36873dc19aemr31287f8f.2.1721324201585; 
 Thu, 18 Jul 2024 10:36:41 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Albert ARIBAUD <albert.aribaud@3adev.fr>,
 Peter Robinson <pbrobinson@gmail.com>, Sinan Akman <sinan@writeme.com>,
 egnite GmbH <info@egnite.de>
Subject: [PATCH 08/20] MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
Date: Thu, 18 Jul 2024 18:35:59 +0100
Message-Id: <20240718173611.4014274-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

These use pre-driver model code and it is several years since the
migration deadline. Disable the 'date' command so that this old code can
be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/MPC837XERDB_defconfig | 1 -
 configs/ethernut5_defconfig   | 1 -
 configs/work_92105_defconfig  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/MPC837XERDB_defconfig b/configs/MPC837XERDB_defconfig
index 9eac43a0fcb..dd30e8d30da 100644
--- a/configs/MPC837XERDB_defconfig
+++ b/configs/MPC837XERDB_defconfig
@@ -139,7 +139,6 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/ethernut5_defconfig b/configs/ethernut5_defconfig
index cc2f567c8a8..004f1866162 100644
--- a/configs/ethernut5_defconfig
+++ b/configs/ethernut5_defconfig
@@ -46,7 +46,6 @@ CONFIG_CMD_SNTP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_BSP=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_JFFS2=y
diff --git a/configs/work_92105_defconfig b/configs/work_92105_defconfig
index 1de61886b38..f05a2f15c13 100644
--- a/configs/work_92105_defconfig
+++ b/configs/work_92105_defconfig
@@ -48,7 +48,6 @@ CONFIG_CMD_NAND=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 CONFIG_DOS_PARTITION=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-- 
2.34.1

