Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D3FCA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 14:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D877F83559;
	Wed,  3 Sep 2025 16:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bxVA8esZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y24jVPqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CEBB835B3; Wed,  3 Sep 2025 16:21:20 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57AF9834AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 16:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cH4Xr6p5Sz9tFH;
 Wed,  3 Sep 2025 16:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756909277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CdFx9Boeq8G6EMuG3Jr5ihlw81o+ixvCmHhEaF2e800=;
 b=bxVA8esZ11JQrOATJcCwT2lSiRb67xRTYzPVyiARfOMLy66w6So5ha4G5G/bFUWMHng/iQ
 NvwfDpOhGHbEJ16hTli5rMCmp3Ewi67J3aPZWE5JrOfzKueZfL4a+nJN5qjUXQDPs4ttpl
 K3HggrQpfCXH3FFgQFtiZloZS5ZoCOiWK5ciQQeMwu0wRsojL6elZzfHfY8XTwjwf8JXia
 zLp8Co9R+rEQVxuqL+jynebZmgpngrsMt5CX+CJwUUU5Xi3OLGFFnIf/H5ydl6S5WcMjmp
 llY48K+Xgaq+db/SqpjSjOhhmgNslLwmhQAYPffwR6kO/fvPZoYNtoULuz9icg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Y24jVPqO;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756909275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CdFx9Boeq8G6EMuG3Jr5ihlw81o+ixvCmHhEaF2e800=;
 b=Y24jVPqOuTNrdxshF8bjFwB+biuupHoJalYUpIlBQMTIFqzjjL0Zkzvwv5w04SJkNJc1vL
 CFzGH4GUWKe5AEvnnkeP8lAhlWh5KnGmHBAwQFVcV86E0j0RvWisLVCwaTrnk9dT1ck4Fn
 IPuvIPRvIHdCluUd4hWQjsNGHM1OvFO5v9NTYVt+fu07EU1BuZbZfvXj0gHhT5Y+Z85uRi
 Mx3nruZzNMTOtjBIfOVxQefXLwvNmaMlDbDx+ls0QUJJYnRCkmAREA7bzxiqgCEJ+PV7zw
 8fb3OV3UQ9N/Zio/Yny7AbwZgmrknM3k/gsFGfzVQszaCILF0q1y27zFN0eLFA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] env: Remove usb_ignorelist and env_fdt_path from ifdef
 CONFIG_ENV_VARS_UBOOT_CONFIG
Date: Wed,  3 Sep 2025 16:20:52 +0200
Message-ID: <20250903142101.90350-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0f5ca401b5ca205e5bd
X-MBO-RS-META: 4eq8oxjn6nzwfzt7q885imtrsp9gay11
X-Rspamd-Queue-Id: 4cH4Xr6p5Sz9tFH
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

The CONFIG_ENV_VARS_UBOOT_CONFIG should protect only U-Boot
configuration variables in environment, those are arch, cpu,
board, board_name, vendor, soc. It should certainly not hide
usb_ignorelist or env_fdt_path from the environment. Fix it.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Drop the tab->space hunk
---
 include/env_default.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env_default.h b/include/env_default.h
index ae2cfbcbc45..7f8dc1c35a7 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -97,6 +97,7 @@ const char default_environment[] = {
 #ifdef CONFIG_SYS_SOC
 	"soc="		CONFIG_SYS_SOC			"\0"
 #endif
+#endif
 #ifdef CONFIG_USB_HOST
 	"usb_ignorelist="
 #ifdef CONFIG_USB_KEYBOARD
@@ -111,7 +112,6 @@ const char default_environment[] = {
 #ifdef CONFIG_ENV_IMPORT_FDT
 	"env_fdt_path="	CONFIG_ENV_FDT_PATH		"\0"
 #endif
-#endif
 #if defined(CONFIG_BOOTCOUNT_BOOTLIMIT) && (CONFIG_BOOTCOUNT_BOOTLIMIT > 0)
 	"bootlimit="	__stringify(CONFIG_BOOTCOUNT_BOOTLIMIT)"\0"
 #endif
-- 
2.50.1

