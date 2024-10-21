Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42E4D0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF12288F4F;
	Mon, 21 Oct 2024 13:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RTy9U2qN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B268488CFB; Mon, 21 Oct 2024 13:38:56 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA7C3888D5
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539f8490856so4555103e87.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510734; x=1730115534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otqF2oEh8JLFj60TrtdrZO87CDnNFz0mj2V81/2ma7o=;
 b=RTy9U2qN5qsyqdloJbCgvUlzW39du3djzduLDorjA0CEHYvhLJW1C/NQoVqB6qv59x
 F0PABRBQDKuGLRHN+60FVeM5kE+RjKlf/7sCgSiqlXhYTtX8nCZXaTtSBhQLR4c06RMD
 +qO2udw+6PnbnNjyf4QUZDzyMv5niQrlP5qkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510734; x=1730115534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otqF2oEh8JLFj60TrtdrZO87CDnNFz0mj2V81/2ma7o=;
 b=wKBu8Zh6ZwMZraWbmnwgtoPt5KVaruMOYrX7qDlkH6oPRKn2YTmyqKOEx/JOyFlXG1
 5D2DtPRQ152lt9s/Lw++/WpFOfAwO46PSHjSATM75I8ACLmD1wI4bzow/iFy/Es6ZQMp
 kNpY4S+2jMgvt9YBugiyagNAeA8H3jh2mDzED1MoD39kywUibp4nK43ZI4mYeh+nRQFF
 kHfRbndlMqSqMlcGcy7X6WMJD/oi1xdjW7+rdB5DB6aOJI8T3LhatIxDu2HKATTf/JIG
 25Y0vMEzHPHmECNrE5AAnJCcl5D5c9h/yrGcCsfluH7HwhqqXYw9I9V/CDf4KGqcug6E
 DsyA==
X-Gm-Message-State: AOJu0Yy/2aU2BqGOaNWi+FNni7yzQ1zIfLQ80dJyEWBdAtUjTSXxxbEH
 H7SaTWyUNiOC575wccRcvCFZR5rAkwm5L99gxEGm3qM39ri7SxD1smyKkwe4mggr4y/A2j6b+UB
 hYWYf
X-Google-Smtp-Source: AGHT+IGsVCUQBS2j1GMcoKyGGKPDQr0hwNdKcbjWgEh3AmvWKSQYJH+Xh/6RsSyWhA3tga98InRk3Q==
X-Received: by 2002:a05:6512:1108:b0:539:964c:16b4 with SMTP id
 2adb3069b0e04-53a154fb01bmr5842491e87.58.1729510733438; 
 Mon, 21 Oct 2024 04:38:53 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 04/25] mx23_olinuxino: pinephone: Enable LED
Date: Mon, 21 Oct 2024 13:38:12 +0200
Message-ID: <20241021113839.318572-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

Drop the STATUS_LED options and enable LED and LED_BOOT instead, since
this is the new way to access the LED functionality.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a patch to enable LED and LED_BOOT for these boards

 configs/mx23_olinuxino_defconfig | 10 ++--------
 configs/pinephone_defconfig      |  7 ++-----
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/configs/mx23_olinuxino_defconfig b/configs/mx23_olinuxino_defconfig
index 3016f750e64..c1319077891 100644
--- a/configs/mx23_olinuxino_defconfig
+++ b/configs/mx23_olinuxino_defconfig
@@ -39,14 +39,8 @@ CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
 CONFIG_MXS_GPIO=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=778
-CONFIG_LED_STATUS_STATE=2
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
 CONFIG_MMC_MXS=y
 CONFIG_CONS_INDEX=0
 CONFIG_DM_SERIAL=y
diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index 9d39204a439..272fce1c1a4 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -11,8 +11,5 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=114
-CONFIG_LED_STATUS_STATE=2
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
-- 
2.43.0

