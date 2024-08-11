Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E528C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DDD588979;
	Sun, 11 Aug 2024 16:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YADtTl7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1796E8894F; Sun, 11 Aug 2024 16:51:22 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C541088907
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-81fd520fe0dso139952439f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387877; x=1723992677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTItN6IY3GnhSfQxDEJfOubzaE2rCm6TNz/vH2ktr44=;
 b=YADtTl7UYYzfzTNvp0RbT+MBKC6ducNkR+qkkDdrsN7+bEY8Kkc8Vuf/tgL6sqrddq
 9Bk3vRY3MSBEB8g92KPbMKHR8b5d29araDvCTYIJ2ZbkSOnqDzcRLV7nR3v5quPjMsUd
 NZRBeA7viGYiPYYlzTBWic5ojn3cxjohUXngE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387877; x=1723992677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTItN6IY3GnhSfQxDEJfOubzaE2rCm6TNz/vH2ktr44=;
 b=D6qMLtmuxZajSuXxq8qmBVt1W85bS55mTesOADdzhLB5LzuM8i8IqlDqWX/g1IqtG9
 +IMwc8oIlZAKaVovFQRD5wx6TXN3QvzYWgIAfx0roLZrfjMfQy0vZLP0Sfk2nvG92HGG
 XKhFO00DHByDUZG3QrCPf6zxxxvXhohjRzdMn4+g9+veCGHNN+6BCYN+US5q9YG3As4A
 GHvKPUVSpWefyGtrHk1sKF9QTGcbTGMfGk9yl2Mc5ro1kez+PIgdOxx8QH2t2/3lbZsk
 nijU6rm6+P9HoKaTLculpQ1GwnS5D8D5ypKgY1OLJ9hvb9iGaCj8yZJudBa/cHGvKgEp
 gi2w==
X-Gm-Message-State: AOJu0YzkiFvu/QlnaLqkHQXOMNm3NLrp00Cwec51RTD6eKLxxqZzdRus
 svst9QLGu8dxTOsHI1AvKCbdSmW1MX1i8oJs83VObv27f/equOm4dL1XumTWbFSG6RZmlwZiCVU
 =
X-Google-Smtp-Source: AGHT+IEqpiIsuvasTOky0zfhNrYYqUgi/6fBDJw3Rl4B1ROyD6mfb+NldbJu6sva5pfE70C7UHmhvA==
X-Received: by 2002:a05:6602:640f:b0:81f:e0a1:34cb with SMTP id
 ca18e2360f4ac-8225ee7fecamr1101839639f.10.1723387877356; 
 Sun, 11 Aug 2024 07:51:17 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 05/18] armv8: ls2085a: Drop CMD_DATE
Date: Sun, 11 Aug 2024 08:50:34 -0600
Message-Id: <20240811145047.4189460-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

These boards use pre-driver model code and it is several years since the
migration deadline. Disable the 'date' command so that this old code can
be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/ls2080aqds_nand_defconfig | 1 -
 configs/ls2080aqds_qspi_defconfig | 1 -
 configs/ls2080ardb_nand_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index 06e41546d67..0066414f0f5 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -61,7 +61,6 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls2080aqds_qspi_defconfig b/configs/ls2080aqds_qspi_defconfig
index 0b54bc999e7..44a1459749f 100644
--- a/configs/ls2080aqds_qspi_defconfig
+++ b/configs/ls2080aqds_qspi_defconfig
@@ -43,7 +43,6 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_defconfig
index f1009e1738b..cbc8d6a5cf4 100644
--- a/configs/ls2080ardb_nand_defconfig
+++ b/configs/ls2080ardb_nand_defconfig
@@ -68,7 +68,6 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-- 
2.34.1

