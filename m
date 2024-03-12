Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54224C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 23:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E4287FEF;
	Wed, 13 Mar 2024 00:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="O4Tb5zj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C025587F16; Wed, 13 Mar 2024 00:37:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 610A987F78
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 00:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03ce=KT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710286660; bh=wlobukw0Wl3kZ7VAkBUqAUxAhdTH82Gcusb9oYtrWpI=;
 b=O4Tb5zj9MjhYKipFX/vIBLczxR9dLGKyypDMmxnN8Vke6BH07BJwcpKjSGRdSQTldBrYUpl48
 kaUiCpO8W1WutIOBdFYeyk6QmwrbfZz4o6HL77basnm7dn2CYy35fafR0JL0ShlENTQnTKJ1FU4
 iy652qSm0Upa3bXFN7vcJnJhSiicmT2AAosabsQHhvB0mTSme5o9mOe3TLbszxQiHtLPIpDHR0S
 o/6HShbBcoclNhgJ0F7x5sEz9Hx4VV6gNCYKi0OMbIgP1VuC7oFCB7W5lWqNjCDlG4msPK8wztZ
 15ATI/jhVY0EDy/DvSlP/lyTWol5BCcd5UCTlkuPC7KA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 12/12] rockchip: board: Move gpt_capsule_update_setup() call
Date: Tue, 12 Mar 2024 23:36:22 +0000
Message-ID: <20240312233636.1428749-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240312233636.1428749-1-jonas@kwiboo.se>
References: <20240312233636.1428749-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f0e742e6c04c5b305936c4
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

Move the call to gpt_capsule_update_setup() from the weak function
rk_board_late_init() into the main board_late_init() function.

Also change to use IS_ENABLED() instead for defined().

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- New patch, split from "board: rockchip: Add a common ROCK Pi 4 target"
---
 arch/arm/mach-rockchip/board.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 4f666aee706f..dea5805c4665 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -34,7 +34,7 @@
 #include <asm/arch-rockchip/periph.h>
 #include <power/regulator.h>
 
-#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
 
 #define DFU_ALT_BUF_LEN			SZ_1K
 
@@ -185,10 +185,6 @@ static void gpt_capsule_update_setup(void)
 
 __weak int rk_board_late_init(void)
 {
-#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
-	gpt_capsule_update_setup();
-#endif
-
 	return 0;
 }
 
@@ -196,6 +192,10 @@ int board_late_init(void)
 {
 	setup_boot_mode();
 
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
+	gpt_capsule_update_setup();
+#endif
+
 	return rk_board_late_init();
 }
 
-- 
2.43.2

