Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50123CCFA03
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 21:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE5683B0B;
	Fri, 31 Oct 2025 22:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PSTKyg3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9765D83B0D; Fri, 31 Oct 2025 22:07:05 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010D083AF6
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 22:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 04AC23FAF6; 
 Fri, 31 Oct 2025 21:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761944822;
 bh=ooTYgQbmlbwQp0WR/uI9H9hYZMUHMwaLSXJYJnJLnIY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=PSTKyg3LyVEBIQGyUklxXMvGVpBu7s/WhCXgEDzA5gXeBNaYmPmlenYyaGkm8F9G/
 zsr3ZROaGCvxYy5ZU0snKm9xYujj4hT0zaLZNRuebeQr6j5h/uOYmWQ6s5yjbgMU0S
 gydbItdfZrhl5f1GnbetaadmVE4yFSZZOoR+oRZwQWcuikeUkcnNHuoa+4ZzkBlvKF
 VhKVU+3LdMD3kOMeBZ8Bk6qgK6HAQsxDvkHNiLkWOldJHRHrpl9oetqSks30xVCJ2u
 SCmlqPow8MfppJdlctMmDOLsyR4MbN0y1a1M9HLCpqmiX5odTGKo2M15CiJJcGjcJU
 Hzcqj36uBrWz6GA/TWBzg66/BhT8YP6GsG8N3A/jZd/NJReElViL46ChZZwR1kdZEC
 kMExEeMylWFHVeTHV06z2xp3KJ9MaTF9Idmw5StbPw5vW7UzYJLs81qDKoeC/GgA6I
 BnkzM2R52kvqDrwnyVcQugMjpb9FzNXb0Cg+QNuTw8FiRhLoe5/HCCfA0Zsw4NrhMF
 xH2sQju0O3NM9NtYCwxC/7KoDsuwHUDkQXIrCC3Bu4+1svqmhy5ukL/yvfxxper3U6
 XqlYFnRfTjPMMGc0TnmSCqYcETeM2FdKmjkHRcXjuynBt/nJ88g/7ymcLgzF3RSNNO
 DLKE+CVHMvzq6bRTIrCy1aEU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sound: all sound devices must depend on CONFIG_SOUND
Date: Fri, 31 Oct 2025 22:07:00 +0100
Message-ID: <20251031210700.643712-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Clean up the sound Kconfig options to let all sound devices depend on
CONFIG_SOUND.

Before this patch it was possible to select CONFIG_SOUND_MAX98357A even
with CONFIG_SOUND=n.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/sound/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/sound/Kconfig b/drivers/sound/Kconfig
index 81de9b30f39..afcc08c27bc 100644
--- a/drivers/sound/Kconfig
+++ b/drivers/sound/Kconfig
@@ -12,9 +12,10 @@ config SOUND
 	  audio codecs are called from the sound-i2s code. This could be
 	  converted to driver model.
 
+if SOUND
+
 config I2S
 	bool "Enable I2S support"
-	depends on SOUND
 	help
 	  I2S is a serial bus often used to transmit audio data from the
 	  SoC to the audio codec. This option enables sound support using
@@ -42,7 +43,6 @@ config I2S_SAMSUNG
 
 config SOUND_DA7219
 	bool "Dialog Semiconductor audio codec"
-	depends on SOUND
 	help
 	  The DA7219 is an ultra-low-power audio codec with Advanced Accessory
 	  Detection (AAD). This driver only supports generation of ACPI tables.
@@ -51,7 +51,7 @@ config SOUND_DA7219
 
 config SOUND_I8254
 	bool "Intel i8254 timer / beeper"
-	depends on SOUND && X86
+	depends on X86
 	help
 	  This enables support for a beeper that uses the i8254 timer chip.
 	  This can emit beeps at a fixed frequency. It is possible to control
@@ -63,7 +63,6 @@ config SOUND_I8254
 
 config SOUND_INTEL_HDA
 	bool "Intel HDA audio codec"
-	depends on SOUND
 	help
 	  Most Intel chips have an HDA (High-definition audio) codec which can
 	  be used by U-Boot to play simple beeps. This is also sometimes called
@@ -72,7 +71,6 @@ config SOUND_INTEL_HDA
 
 config SOUND_IVYBRIDGE
 	bool "Intel Ivybridge sound support"
-	depends on SOUND
 	select SOUND_INTEL_HDA
 	help
 	  Enable sound output on supported Intel Ivybridge-based boards. This
@@ -148,4 +146,6 @@ config SOUND_WM8994
 	  audio data and I2C for codec control. At present it only works
 	  with the Samsung I2S driver.
 
+endif
+
 endmenu
-- 
2.51.0

