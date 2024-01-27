Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EF7C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 13:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEDB87DC2;
	Sat, 27 Jan 2024 14:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=aurel32.net header.i=@aurel32.net header.b="DfkMadaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0307487DC4; Sat, 27 Jan 2024 14:49:14 +0100 (CET)
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EE787DC1
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 14:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aurelien@aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
 Content-Description:In-Reply-To:References:X-Debbugs-Cc;
 bh=BNZQyvbikVHT3MhXGrhJOY7uuZo7bm29YmoTRDfLL6Q=; b=DfkMadaBvIAFZclYnxVla6uOz1
 nmfrgq4VoDZKDOYGT+A+dvsbeFcFQ+ceuHb3od2qsgeshHdyI20nHjzI6pesdGS+s8NtPuKPzkKmU
 tPyUcraJkGeD1LNuzYDscjUo6TB/MADXbGrLXJ7QzHzb/6aOVidJUEyihXIyKj2qjJASpOWYJw2mv
 O3OO4MwicdCZljoxpdZdb88PcjoqZj0xjAaO7Yl7kMSGFOKyHivfNoEywCnjPSH0CvLxRidY9uuLr
 w3wLh7lEfdqC2kT4AftHMcLXbdRojw7GwzIsvsC2UJX44TPxmQemDKlVPnFliA3XuWDdLpERH2N4I
 j5T9/ZHg==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <aurelien@aurel32.net>) id 1rTj3D-002nS2-1n;
 Sat, 27 Jan 2024 14:48:51 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Shengyu Qu <wiagn233@outlook.com>, Chanho Park <chanho61.park@samsung.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de (open list)
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	E Shattow <lucent@gmail.com>
Subject: [PATCH] configs: visionfive2: Disable ENV_IS_NOWHERE
Date: Sat, 27 Jan 2024 14:48:45 +0100
Message-ID: <20240127134850.582763-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.42.0
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

The VisionFive 2 board supports saving the u-boot environment settings
are saved to on-board SPI flash. However the defconfig enables both
ENV_IS_NOWHERE and ENV_IS_IN_SPI_FLASH, preventing the "saveenv" command
to work. Fix that by disabling ENV_IS_NOWHERE.

Fixes: 7d79bed00c9e ("configs: starfive: Enable environment in SPI flash support")

Reported-by: E Shattow <lucent@gmail.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 configs/starfive_visionfive2_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 1b7d57bac7..c68f3c2def 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -77,7 +77,6 @@ CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-- 
2.42.0

