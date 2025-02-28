Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC899C021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 04:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A56F810FE;
	Sat,  1 Mar 2025 05:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6F2xb+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C2E80AE1; Fri, 28 Feb 2025 20:22:49 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35CFD800B6
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bschnei@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22339936bbfso39414375ad.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740770566; x=1741375366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QL5zLH3ZlBt/fgIemYW+gIR04k1GJLgi8OfM4Bsdy9s=;
 b=V6F2xb+t3yT0KukDufHO301Wsb+fDa5wyIziHhzOqmN+hdcj61GI672HJzf2o9oe9d
 luj++bJXraqMoyZqa2NqHua3NOHLGkRmLqrPVS/TjuS/04RTp8bgxVvE1vEAsiBha1gL
 hGCWE5XINWsMb745lJnwkTeifgUwE+3ikjp81GbXBN4dJaa0gJG2r1oTON1rZ1aPnnFl
 9Ths+DtkFE4e4GN1vmXBwkHcgdy7ZtG5c8j0BtF5V5YzjgG9JCJg6fCypCJe6KVNDS5M
 FyivQX8/2eRbzfuhYM/NRnVUmSbafXiqm2KUXaHWIBLYx+w+Px0QnQzcBHsJ8ZzGwxVg
 5hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740770566; x=1741375366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QL5zLH3ZlBt/fgIemYW+gIR04k1GJLgi8OfM4Bsdy9s=;
 b=S0XlsmLbybneG7yTohEZjNaNlbRgdjpeRidUuN7hIJyUmjXtnRwm5Vi5PcQ9IlFaWJ
 PI7STP4fjz68D/aC8MZ8CDh/bp6Q/CssiWeCOlG542eg0S3aaHx/izDx4OM91nzPh7XY
 FQFL8pcGumxFzG++i4+BQ1OtrrGy+tRD59q4Ees91COc2wrKXHPfwZYkAriupb3nOiMF
 EkOa/KP/ig5deW0J14/oikM4I50DxfwSQthm9crPwsP5hU76kVTL45WHyVjwNujEfkd9
 /5maPp/9lqG3/9e7nM/AiGwcxVeKZdsOL3SaPo2IhAz6y0wEOq99Y7sSZxm8WRUVf/jM
 P0tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUe55WYcIPC9aSDJ7gcfhWiLtTYMsIPvM4c6xhSKibBlb9v6/QrIDhSatOQxqS9PZ+UvsUL5E=@lists.denx.de
X-Gm-Message-State: AOJu0Yxq/6331R4SjXH35wgNXeyP/iFP0zjMK08MWWQ3agQO4Jiw2XSM
 C+SZyXBi9zlghLmXQLBY/M1DwvhM9F571CfWiXcCKg4EBRE7CTYO
X-Gm-Gg: ASbGncuoaiKKwbVY68caj3FbVB91lxyfyFwZ1Pb9XkTTet2r6gQ+pk5pJM4T88wct4R
 O2O64krfApNDQRGmxrzXTVBIuxBtL0TZXhf6dYOZ9L20flv3DDMLWXwC3ZWtXebTX0qKcDiFHV2
 +mi51jNtV7VXnMD2W3r2T80FeryfYoy4/tW4IOQF0vQt4S1Ocer4DWz2ovT+wQH275AU/AaXppI
 ssFIYgohI8LuIhG2JJJdPYMsAVaawdyKZzxLt6pPsIeD+NuvsyHnOMS+/K0Ik4ylR7EJS4FGQeW
 qJHNFLdxA0JGzDCMMpT2LZ95Vg==
X-Google-Smtp-Source: AGHT+IEY7DsVKOscHjG3wBQJfUw6KMRdsp2+h8jtApXi+rPVJMasMSYNGHLSCunYmRTAana12nHQsw==
X-Received: by 2002:a05:6a20:a11d:b0:1e1:cbbf:be0 with SMTP id
 adf61e73a8af0-1f2f4d2eec1mr8384278637.22.1740770564078; 
 Fri, 28 Feb 2025 11:22:44 -0800 (PST)
Received: from desky.home.arpa ([2605:59c8:492:c301:a006:5b2b:de58:f59e])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7ddf2444sm3837408a12.3.2025.02.28.11.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 11:22:43 -0800 (PST)
From: Benjamin Schneider <bschnei@gmail.com>
X-Google-Original-From: Benjamin Schneider <ben@bens.haus>
To: Stefan Roese <sr@denx.de>
Cc: Benjamin Schneider <ben@bens.haus>, Benjamin Schneider <bschnei@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH] configs: mvebu_espressobin_ultra-88f3720_defconfig: disable
 SATA
Date: Fri, 28 Feb 2025 11:22:10 -0800
Message-ID: <20250228192240.129406-1-ben@bens.haus>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 01 Mar 2025 05:32:55 +0100
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

This device uses the SCSI subsystem to interface with SATA devices.
Trying to use the sata command results in an unhandled exception.
This has the side effect of also causing bootflow scan to raise
an unhandled exception when it attempts to probe the SATA
subsystem. Disabling the sata command fixes this issue and does
not remove support for any boot devices.

Signed-off-by: Benjamin Schneider <ben@bens.haus>
---

 configs/mvebu_espressobin_ultra-88f3720_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
index 6f1a66f5f1..1cbeee8fcb 100644
--- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
+++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
@@ -34,7 +34,6 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
-- 
2.48.1

