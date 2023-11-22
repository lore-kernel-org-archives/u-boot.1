Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5AFC61D92
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 02:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D689787563;
	Wed, 22 Nov 2023 03:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AFU8jTek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EBD9875AF; Wed, 22 Nov 2023 03:36:13 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2A83875B5
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 03:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 690743F27A; 
 Wed, 22 Nov 2023 02:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700620568;
 bh=blQDhT6f4wnwXuSTEpv2kfpfoV+iaVJT4vDZ4L4rRYQ=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=AFU8jTek5cxXbRHiJk3maF3NqAO8I79mNZT8PWlAiej2FZ7GENmU+hvD2YViRHM5v
 dMcplX0tO4dvWdJeP9pM3YYk9551eoaESWag1z7yinUvX3wxrD9wgs6WNH6XXLDCMq
 QGPvWWf1VMxR+M4MCGV1ktnVQBy9pd04SBhAi1/E2k0LwUobEKbr7cmmwdN3Soe0O7
 VOd4n8w2n87YcNMch5uvfDTjd7rDMyg1W/jyafTNA2m8HQlbEElGSmyfL/P/BvS14h
 u2bg9pFO1diFM0Y6+cgqdauQTL2FRDdwt5823lDN4B3saOJA0c91JheOJW9H6WlWJV
 SdGzpf9XhkxWQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: enable VIDEO_ANSI on EFI app
Date: Wed, 22 Nov 2023 03:36:02 +0100
Message-Id: <20231122023602.7060-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

The cls command ignores $stdout if CONFIG_VIDEO_ANSI=n. This leads to
unexpected output.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/efi-x86_app32_defconfig | 1 +
 configs/efi-x86_app64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index dfc315774a..fd963a8ce4 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -38,6 +38,7 @@ CONFIG_BOOTFILE="bzImage"
 CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_VIDEO_ANSI=y
 # CONFIG_REGEX is not set
 # CONFIG_GZIP is not set
 CONFIG_EFI=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index e0cfe3ee24..14435290d6 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -40,6 +40,7 @@ CONFIG_BOOTFILE="bzImage"
 CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_VIDEO_ANSI=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 # CONFIG_REGEX is not set
 CONFIG_CMD_DHRYSTONE=y
-- 
2.40.1

