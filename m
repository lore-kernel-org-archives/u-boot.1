Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD248C48BF6
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 23:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3557087D15;
	Sun, 25 Feb 2024 00:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8jkPpqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DBC87D16; Sun, 25 Feb 2024 00:52:11 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4657287255
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 00:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benwolsieffer@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6861538916cso13724146d6.3
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 15:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708818726; x=1709423526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WSwdiMaE96SdlRcXjQVY6v7W34HSM/C96FkUkxyx3jM=;
 b=m8jkPpqtoAAfH7nE+SnmSTNbnchkNzhy2DKzWB0trIwGNnoeX2AE7fLBsoJ+tzGV19
 UjgKELK14q+f/l+p35EwhsOxYVvaObyz1/LjKOwh60XabxtAEs/hmsNqezXoLXSCt3wI
 BUWwcpIjopGi6XVhPYpEeC+VeFtxw3SKKDu3EFoymmk5prN8QGZw4+UZI2ubwOFRRpjE
 KLZOVimTGj67T41WXYNeY4MKc5HQJcAtSrN4YFOckexNg+3ebSynpLC+v2atzEw8j3VI
 VGyLg+DzVTDVDgin2w/IqiZR4d9rmjixLAhIkgtNUu8B0sAyXqasBFb1sGRTrcCNORLq
 /E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708818726; x=1709423526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WSwdiMaE96SdlRcXjQVY6v7W34HSM/C96FkUkxyx3jM=;
 b=toO7L1mA3wiHM8M+HqOMtCzpt45HUk1g8+7rWUsaZnsAOnaShFDyc2X1mWSxdwKl3I
 vlGUW/jIc/hLC2ZS1qKU8rf+PjvPQCwmZRJ2JQx85+YIuYDwoXscadFbWzCcgqiuz37J
 h+o7akNfCKEsXlwNywMV9nM1WK+37PgEG1IgvIWToc88mPVe+HpBNL+xmu+PnlRIYrSe
 l/J3ueua2w8KAPSm99dqF8LSx8dXV51Kwdx8Z94SqHhxycqw3jLGPXHEq3222tDEhcbi
 XjbwcLxsfVHm2ztz8RqRri4sMlBHxj/ytIqbs1EVjT0vikihw5xaqT4czT7e2NFzDDfb
 NLkQ==
X-Gm-Message-State: AOJu0YzBZ5ZU9sQK3wM1iVB2NpHXQndFHdB5MWiZGhrVD2oEy7AsjsqD
 EiW/N0OP/CDR0yq3c91xUOqnwW86g5bTKbv4lJp6adJ/rNIavFGUJotMvywL
X-Google-Smtp-Source: AGHT+IFjxnUeilC3jz62DV4vM1Y65i1FjjoVcEb0UD6e73oHz1jko2epsnEa9wTtEzID5wYfPrgqAw==
X-Received: by 2002:a0c:f049:0:b0:68f:62c8:39d3 with SMTP id
 b9-20020a0cf049000000b0068f62c839d3mr4147577qvl.56.1708818726509; 
 Sat, 24 Feb 2024 15:52:06 -0800 (PST)
Received: from Dell-Inspiron-15.. ([2601:18c:8002:3d40:7920:e10c:26cf:ff86])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a0c9b0a000000b0068fbe6d38f6sm1208935qve.54.2024.02.24.15.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 15:52:05 -0800 (PST)
From: Ben Wolsieffer <benwolsieffer@gmail.com>
To: u-boot@lists.denx.de
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Ben Wolsieffer <benwolsieffer@gmail.com>
Subject: [PATCH] rockchip: rock64: store env in SPI flash
Date: Sat, 24 Feb 2024 18:50:11 -0500
Message-ID: <20240224235011.290117-1-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.43.2
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

Currently, U-Boot attempts to store the environment in MMC 0, which
doesn't work when an eMMC is used without an SD card. There is an SPI
flash chip on the board, so use that instead which should work in all
cases. Additionally, this brings the Rock64 into line with the
RockPro64.

Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---
 configs/rock64-rk3328_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 0297d09876..589e5184ca 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -8,6 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_SPEED=20000000
+CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock64"
 CONFIG_DM_RESET=y
@@ -54,7 +55,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
-CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
-- 
2.43.2

