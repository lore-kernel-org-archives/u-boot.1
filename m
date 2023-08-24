Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF34C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CD0869AC;
	Thu, 24 Aug 2023 21:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oQBCV3np";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 535E486923; Thu, 24 Aug 2023 21:26:54 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4EC86418
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c479ede21so105870f8f.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905211; x=1693510011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGTKi5hyg288FhatKgnvBzU0s7qfbulM2J8mlAxkUNE=;
 b=oQBCV3np8EDSH/BGqEPMksyJxgAKhadw78AyuHBEwimuph7j1p3ulLnWuoHGbcuqA6
 UpG2UV5DdKua63bO8yAlbX+eMnIlDH8+6XsQ5iCDvjwLissQh1DQCJo7RlJ64X7jXeO1
 L9DgIe009ayNrWMkZbztXNe+G3R+WYRIXFawuyyEW7dyN6VZ39+8s8ce9adyYzoWXnfV
 ZPyt0TAbJ4+mf8b2AP1fEVg2hxxYvhfNGb9czdBjsgrZsAaWBd4r8/e9J+GSaypfw6i/
 HNeI0wNP5ajRmfdPIOFygOyNs2PcN09AOMxfKRqF33qFILArwxuGN9yo0+XYK4tbVBjt
 TXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905211; x=1693510011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGTKi5hyg288FhatKgnvBzU0s7qfbulM2J8mlAxkUNE=;
 b=b/mBZXYCObL2ASrsLFmQNXWL0Hp4k4oDARFO5Y1XWqep3NOEtjMHU4UyndTeEex1hL
 vDoOfai+8B7MVDkSO045mzrHx3+fJ2tPT+2EwZEuslGTHerEwgFvBDC98Xg8M0GlHRtQ
 LZnPLt4JjRz92g9CwvbJU2pTqT2yP6Dtyl8QN14UPhj0oxAh72EfKVaoeQuYdU9cMeZX
 /vEPg+m3As294sPgbhTTlrhYuyXaRQcP8Su7ppur4YpxFSrUMuBZnedJCfBJz4su9VTF
 ExTGbxXLRYdmzKGzzcqYVbxJm+JJdCgAjzOVC5DAslPpNDG+gpf85LkrsY4nhdHF7bf3
 KFQw==
X-Gm-Message-State: AOJu0Yyj8/rttxBAH372qbnHF02IvpP+YN3AT0u046SsPfvTAsVFsxtC
 kv69E3VrmXxb/nxk5sONt2c=
X-Google-Smtp-Source: AGHT+IE2SpML0hgS/pgX5NGjnFcXLscJ6u67NisqhKRjxJ7a40WyxMh/t+nQpvD9JmqeJy0lBh5klQ==
X-Received: by 2002:a5d:4041:0:b0:317:3f70:9dc4 with SMTP id
 w1-20020a5d4041000000b003173f709dc4mr12898328wrp.31.1692905210886; 
 Thu, 24 Aug 2023 12:26:50 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 03/16] configs: transformer_t30: support booting from USB
Date: Thu, 24 Aug 2023 22:25:50 +0300
Message-Id: <20230824192603.240104-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

Change boot logic to primary try to boot from USB in dock, then
from microSD and lastly from eMMC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/tf600t.config             | 2 +-
 configs/transformer_t30_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/tf600t.config b/configs/tf600t.config
index 89d8db4eb1..18ab4fbd87 100644
--- a/configs/tf600t.config
+++ b/configs/tf600t.config
@@ -1,4 +1,4 @@
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf600t"
 CONFIG_TRANSFORMER_SPI_BOOT=y
-CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4d00
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 6fe6f2548d..840431ff38 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -22,7 +22,7 @@ CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.39.2

