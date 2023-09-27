Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BBFCE7B1C
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 19:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC3E6867D2;
	Thu, 28 Sep 2023 21:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ChbUGtIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B2E86548; Thu, 28 Sep 2023 21:02:28 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C75867D2
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 21:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dba8=FN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1695927741;
 bh=/VjW0BoYi5bYXU4RDNgePXUAlPjcBhaJzkvcyE7jKgM=;
 b=ChbUGtIVlRtGljaOPEgeD0anIg5x5D42Ule/mSQCRVhVO2xm+b91LG9HjuttncoQaFoY6YNy+
 GlASMKmka8e25UgYOdsToq5FZW1WkXONQyGM7vKD95Ix0h9Zju/wg3EOAquMIsGgQxueMx9Vp15
 lzK/+Voa+kaD4nT7uE3O5Bku35aabADcsLIOi0TmqW/cKoqbCuLyOYHMWbH+rKS//ZKa7rFkJ6Y
 AjIw9nIhd3w/zC47x0Mrksbg8LQhGMu0irQpfvx2avd89+qQMM8Jfx5xzBtl22gcew6x+zQxpFg
 X5p46qJlhUSzbrpl05uXWSsLNyV6j1kAdB+daqJr6ltQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>, Ferass El Hafidi
 <vitali64pmemail@protonmail.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] spl: Jump to image at end of board_init_r
Date: Wed, 27 Sep 2023 21:44:13 +0000
Message-ID: <20230927214415.2224768-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6515cdbc63d269bceef458a0
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

spl_board_prepare_for_boot() is not called before jumping/invoking atf,
optee, opensbi or linux images.

Jump to image at the end of board_init_r() to fix this.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This patch have dependencies on the following patches:

spl: add __noreturn attribute to spl_invoke_opensbi function
https://patchwork.ozlabs.org/patch/1827057/

spl: add __noreturn attribute to spl_invoke_atf function
https://patchwork.ozlabs.org/patch/1831366/

spl: Drop the switch() statement for OS selection
from the "spl: Preparation for Universal Payload" series
https://patchwork.ozlabs.org/patch/1839731/
---
 common/spl/spl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index f7608f14e365..79c39820262a 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -647,6 +647,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		BOOT_DEVICE_NONE,
 		BOOT_DEVICE_NONE,
 	};
+	typedef void __noreturn (*jump_to_image_t)(struct spl_image_info *);
+	jump_to_image_t jump_to_image = &jump_to_image_no_args;
 	struct spl_image_info spl_image;
 	int ret, os;
 
@@ -735,20 +737,20 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	} else if (CONFIG_IS_ENABLED(ATF) && os == IH_OS_ARM_TRUSTED_FIRMWARE) {
 		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
 		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
-		spl_invoke_atf(&spl_image);
+		jump_to_image = &spl_invoke_atf;
 	} else if (CONFIG_IS_ENABLED(OPTEE_IMAGE) && os == IH_OS_TEE) {
 		debug("Jumping to U-Boot via OP-TEE\n");
 		spl_board_prepare_for_optee(spl_image_fdt_addr(&spl_image));
-		jump_to_image_optee(&spl_image);
+		jump_to_image = &jump_to_image_optee;
 	} else if (CONFIG_IS_ENABLED(OPENSBI) && os == IH_OS_OPENSBI) {
 		debug("Jumping to U-Boot via RISC-V OpenSBI\n");
-		spl_invoke_opensbi(&spl_image);
+		jump_to_image = &spl_invoke_opensbi;
 	} else if (CONFIG_IS_ENABLED(OS_BOOT) && os == IH_OS_LINUX) {
 		debug("Jumping to Linux\n");
 		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
 			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
 		spl_board_prepare_for_linux();
-		jump_to_image_linux(&spl_image);
+		jump_to_image = &jump_to_image_linux;
 	} else {
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
 	}
@@ -788,7 +790,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 
 	spl_board_prepare_for_boot();
-	jump_to_image_no_args(&spl_image);
+	jump_to_image(&spl_image);
 }
 
 /*
-- 
2.42.0


