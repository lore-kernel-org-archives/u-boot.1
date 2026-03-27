Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA8A10F2843
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 15:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE09481E18;
	Fri, 27 Mar 2026 16:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="kvJvGol9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7A083C14; Fri, 27 Mar 2026 16:16:19 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6C880077
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
 :Cc:To:From:subject:date:message-id:reply-to;
 bh=YA6fA6B1AE1RhjOfXz03D2Sq3xllHbc+ZpUPbKzQ4QE=; b=kvJvGol9Nl5f6KbWKU18OFAesy
 jps3kBbpUTUo2AnJmqLCzFPURfK+xMqdsgjJU7kDuMlKsm+YAls5cQwglVTsdH+LH0yx+rgcw1RRz
 Ruq/ZyzLC99ckCQdRGzRZdcY5YMydtEs2CttOvGLwSe+Z2eAB48krqC87AChtGJ0+Wck=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]
 helo=pettiford.lan) by mail.hugovil.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <hugo@hugovil.com>) id 1w68v1-000000003IH-0Bl3;
 Fri, 27 Mar 2026 11:16:15 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tom Rini <trini@konsulko.com>
Cc: hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 u-boot@lists.denx.de
Subject: [PATCH] config_distro_bootcmd: do not scan boot partitions if
 distro_bootpart is defined
Date: Fri, 27 Mar 2026 11:16:07 -0400
Message-ID: <20260327151612.2000964-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

For some projects, designing the active bootable partition is done by
setting distro_bootpart in the environment instead of changing the bootable
flag on the active partition.

This patch makes it possible to support both models by scanning boot
partitions only if distro_bootpart is not defined in the environment.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 include/config_distro_bootcmd.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 7b6ac6eed9d..8d6f80a0ce5 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -543,8 +543,12 @@
 		"\0"                                                      \
 	\
 	"scan_dev_for_boot_part="                                         \
-		SCAN_DEV_FOR_BOOT_PARTS                                   \
-		"env exists devplist || setenv devplist 1; "              \
+		"if env exists distro_bootpart; then "                    \
+			"setenv devplist ${distro_bootpart}; "            \
+		"else "                                                   \
+			SCAN_DEV_FOR_BOOT_PARTS                           \
+			"env exists devplist || setenv devplist 1; "      \
+		"fi; "                                                    \
 		"for distro_bootpart in ${devplist}; do "                 \
 			"if fstype ${devtype} "                           \
 					"${devnum}:${distro_bootpart} "   \

base-commit: c24a72c35abe9cbbeb72e2effc6b6c73cd828a32
-- 
2.47.3

