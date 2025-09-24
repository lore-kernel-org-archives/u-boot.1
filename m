Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BA8CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 19:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B05835CB;
	Wed, 24 Sep 2025 21:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bibQsH9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1D5A835D8; Wed, 24 Sep 2025 21:22:06 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8495B835C9
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 21:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A1B93C011C6;
 Wed, 24 Sep 2025 19:21:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B563260634;
 Wed, 24 Sep 2025 19:22:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 90823102F187A; 
 Wed, 24 Sep 2025 21:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1758741722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=VNtM4/xtXUgDMKY1QQrFsHrxLUf+yA2pfNgddxGX2Us=;
 b=bibQsH9TSe657xyl5OQetMob1UzeS58cTDaBUaEveon4MHvjjVJl1nNlKo0T4N1m4BJ+6J
 sUJamBwewci4h3mgDsl6Q8ILU6KQ/bWUO3ZtIlLNGsFODgMfii+7D+TnLF/3Z4ahQzhPub
 duzQE0nFEwyCaBpBcKqC8dqh3d2+jUtja5Jtrh+uCsXJqB6ulOFP25tXnTwdSUsAvYnCQk
 CT+CI+PsKX3XJWpsOwKIPWjc9vqhcgLgIQD24vG5uxRzGB1AOTrFcODKii3hhTEd4RBcp0
 psJOJ9uybOROQWELCOGGBhn17EGf2hawIEwjFU0s+HbPdv7XILWqW+OrwWsV1g==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 24 Sep 2025 21:21:51 +0200
Subject: [PATCH] env: fix typo in multiple Kconfig descriptions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-fix_typo-v1-1-5e3441aae632@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAM5E1GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMT3bTMiviSyoJ8XUOTJDMzo9RU82SDFCWg8oKiVKAc2Kjo2NpaAMY
 9FkZaAAAA
X-Change-ID: 20250924-fix_typo-14b662ee7c0d
To: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 u-boot@lists.denx.de, Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
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

%s/environemt/environment

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 env/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/env/Kconfig b/env/Kconfig
index adea277470fa9e4b86c0f8699ab6a1e116e53450..678f362c455dd84724de801d09ba7129d23aa0fe 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -481,7 +481,7 @@ config ENV_IS_IN_UBI
 config ENV_REDUNDANT
 	bool "Enable redundant environment support"
 	help
-	  Normally, the environemt is stored in a single location.  By
+	  Normally, the environment is stored in a single location.  By
 	  selecting this option, you can then define where to hold a redundant
 	  copy of the environment data, so that there is a valid backup copy in
 	  case there is a power failure during a "saveenv" operation.
@@ -497,7 +497,7 @@ config ENV_FAT_INTERFACE
 	  Define this to a string that is the name of the block device.
 
 config ENV_FAT_DEVICE_AND_PART
-	string "Device and partition for where to store the environemt in FAT"
+	string "Device and partition for where to store the environment in FAT"
 	depends on ENV_IS_IN_FAT
 	default "0:1" if TI_COMMON_CMD_OPTIONS
 	default "0:auto" if ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
@@ -545,7 +545,7 @@ config ENV_EXT4_INTERFACE
 	  Define this to a string that is the name of the block device.
 
 config ENV_EXT4_DEVICE_AND_PART
-	string "Device and partition for where to store the environemt in EXT4"
+	string "Device and partition for where to store the environment in EXT4"
 	depends on ENV_IS_IN_EXT4
 	help
 	  Define this to a string to specify the partition of the device. It can

---
base-commit: f53fe908ac3dd44f7ad63dff319636541710b98c
change-id: 20250924-fix_typo-14b662ee7c0d

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>

