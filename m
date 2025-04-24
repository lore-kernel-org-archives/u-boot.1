Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EEAC369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C54B80F9C;
	Thu, 24 Apr 2025 14:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="e8Hkw5P9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2991817C4; Thu, 24 Apr 2025 14:13:51 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7A680194
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9735941A35
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 12:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745496808;
 bh=ISoormE2DBzLOxL2fMWKRl7vDHLT/Inbk+6hxzwx7DU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=e8Hkw5P91u30MXkm+kVVooxOAIBr+1TAWJ6WTDLEgfcAj9xoLAaWBlXHxjqxwHsJu
 K5weuIxstxEsCTK7wAP5kmnAM+WqQUQRkTa46WUsfyRqZzCQVr+UiLm7Bi6xt0szdF
 5d0oF58lDluhnCiNPN7+cMYhreYWC5V5YIlopt/UIrVtMq3rd27fi5Nnvi8bK+Tqoj
 fe4/foo3xI0rnf0HAnY7FBb99lqp8i9Un+qygVLPcKY/HErzMuOnv8R0+Xka+iNRRU
 pXCG5E/2sRgMw4vIP7WbtXIf4d67A/I2RrXJrKE5eN56z7aYa8tMk3V5VbSBiARxOQ
 VI7bN9DBOTHhA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a064c45f03so460304f8f.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496803; x=1746101603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISoormE2DBzLOxL2fMWKRl7vDHLT/Inbk+6hxzwx7DU=;
 b=KmgJ+6TPrwCRmOr0RfbztKEj+cNHKLKM6MI9ReGmnRUjaz9xJlRDWH4sirHObdHsl7
 cP5iMFBjoppM2zgVFNof8Kxg5PjwmdE2RTUGMiMVasmbZd11vsJVg3pAoRwssUvhUAgn
 9SN0ZS+2/FKAg3UBNhglBBNDiegTNB5IbHK8ZY9H+rtj+1UbrQBdFD1gpu5t7vfHidaW
 wr6kJqsR8nR8aCeENDCI9e8CW2qafj3CBalGQBY7HPV2ElOWpzivc+w37OP/J05ARqXZ
 RwxkGKA4eI7jTi9OTJs5cUbS8YElSeUyIRFBTG0RKlSba6YkOkNbtI3FtTrmaRABpQOw
 spNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHjpgGD3Qkw3m3gxBp1HsS9iT/qT7oMfFtQ6aIw0Rw3q7M0ceXIPjeXgKlHAsQW1P44EITvb4=@lists.denx.de
X-Gm-Message-State: AOJu0YxBRZyEhHPu+is9BWXVO2W/AnzDCRFix0waueKd2qZ3ydVjC0q4
 HgPGAOzVHpN4Ou/ZTbQvfypBLQVncrsrp+FAYFDQk4cael9iDEPzNgLvLZrx5i2Ze1Fe3y+O8Oh
 SyyFJvl31mOOEy7qRfedhR1yKTm/6qIdUiJqGETKE2M2ztsNrfx1H0oW636o9Lim/aFQ=
X-Gm-Gg: ASbGncvuR7sRyvUOqFYq+Z9X3IeG9MG8fJvXI+7ErodS/GRvsNErbveWccC6chqChtY
 S/ZU1VYB9QWGU7MostnWd6J4T+SOmLkQ658ns+U7QwqNxPOGrMtdWMF55gtIWbhjrCDp/yiq8H+
 SWVgeMcdczx/299Hzy7B9sxmgQ5B6k4VUj5qBz9sJ6hgv4drgeshU/SNxZ74057LbKXGeaJ7OTI
 r+Mx5/DiK3Il4qD4OUuRvO7nwVn2ELczyWZAEJGZR/tCddNpOWMbJmhRW8+EPUk8VoJ8mHgod8l
 yJwvYYycDYRStJrETBsmbclCvUV82QbYl9vFA+UqpcuCg2H4iUfP61yUnBBVcLowrbeB7dIBTxS
 sTh/3fT18o3x6Og==
X-Received: by 2002:a5d:47ce:0:b0:39b:32fc:c025 with SMTP id
 ffacd0b85a97d-3a06d641dadmr1995381f8f.2.1745496802954; 
 Thu, 24 Apr 2025 05:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDE3EcTVUYm04XyfMAaE7nUwHAp5nVsWRDJwyOekzZoeAwf3ZyyG/DSv3MxdytFQRq3wtUyw==
X-Received: by 2002:a5d:47ce:0:b0:39b:32fc:c025 with SMTP id
 ffacd0b85a97d-3a06d641dadmr1995359f8f.2.1745496802603; 
 Thu, 24 Apr 2025 05:13:22 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5326e1sm1900906f8f.70.2025.04.24.05.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 05:13:21 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Matthias Brugger <mbrugger@suse.com>, "E . Shattow" <lucent@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 1/8] configs: add jh7110-deepcomputing-fml13v01 to VF2
 defconfig
Date: Thu, 24 Apr 2025 14:13:08 +0200
Message-ID: <20250424121315.144549-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
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

The DeepComputing Framework motherboard is a JH7110 device support by the
upstream kernel. Add its device-tree to the list of device-trees to be
included into the starfive_visionfive_defconfig.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	no change
v3:
	no change
v2:
	rebased
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 6a5b247c4b5..e145ced8db8 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -80,7 +80,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_WGET=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
-CONFIG_OF_LIST="starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.48.1

