Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D63CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 14:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C0DF87588;
	Wed,  8 Nov 2023 15:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5997787259; Wed,  8 Nov 2023 15:21:00 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6324386FB2
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08C001C000B;
 Wed,  8 Nov 2023 14:20:56 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 4/6] rockchip: ringneck-px30: only declare functions in U-Boot
 proper
Date: Wed,  8 Nov 2023 15:20:33 +0100
Message-ID: <20231108-env_default_theobroma-v1-4-cb493bfdeffd@theobroma-systems.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Those functions are useless in anything but U-Boot proper for now, so
let's compile them out explicitly.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 board/theobroma-systems/ringneck_px30/ringneck-px30.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
index bb1bb4acf5c..dd711cd05de 100644
--- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
+++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
@@ -25,6 +25,7 @@
 #include <power/regulator.h>
 #include <u-boot/sha256.h>
 
+#ifndef CONFIG_SPL_BUILD
 /*
  * Swap mmc0 and mmc1 in boot_targets if booted from SD-Card.
  *
@@ -169,3 +170,4 @@ int misc_init_r(void)
 
 	return 0;
 }
+#endif

-- 
2.41.0

