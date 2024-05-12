Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FBFC25B4F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 04:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1EE187ECD;
	Sun, 12 May 2024 06:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qlnlnY1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9715887EF4; Sun, 12 May 2024 06:26:12 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99F387DD3
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 06:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2612540823; 
 Sun, 12 May 2024 04:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715487966;
 bh=bBL6K/fXWU2EiIQnYxU71zUihBEVDqqOHw/PxNPVj+s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qlnlnY1rlp2fQ0vCXCFbuku/A7273mUzDnHxJWFGX4YLE/w9VBZinA2yS2lCG91tB
 8ChOiTRYTKs6RWdht3CAZpi9WPVFrDLKRggPDniudoOdrwbtKJ7BeyjFTvpajHAo++
 5xO5JRIDQVT4koE/jv0xoDJoXhMlecyaJDGHpHsX50GaGOFgCHUvcnl8RRKIX18UvV
 l/crVy+XCfFNbiJDJzGFWJrI7CovaSCwI8362ZYSqWpfL2xjF4VVi/niex+OFatayJ
 +4QZPPqocwhZkHOvmkc2zJsLD9YVeSIlw+sy3Wli9pYtrmZF1DhdOyGNmvcDr7/Nr1
 5krQ5kVr/wkJA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 4/5] configs: visionfive2: enable SPL_YMODEM_SUPPORT
Date: Sun, 12 May 2024 06:25:25 +0200
Message-ID: <20240512042528.7766-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240512042528.7766-1-heinrich.schuchardt@canonical.com>
References: <20240512042528.7766-1-heinrich.schuchardt@canonical.com>
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

We can use U-Boot for recovering JH7110 based boards via UART
if CONFIG_SPL_YMODEM_SUPPORT=y.

* Send u-boot-spl.normal.out via XMODEM.
* Send u-boot.itb via YMODEM.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: E. Shattow <lucent@gmail.com>
---
v5:
	no change
v4:
	no change
v3:
	no change
v2:
	no change
---
 configs/starfive_visionfive2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 3bbd1dbd67c..174ac24dc74 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -62,6 +62,7 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
+CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_SYS_PROMPT="StarFive # "
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_SIZE=512
-- 
2.43.0

