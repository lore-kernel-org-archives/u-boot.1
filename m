Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE42CA1009
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 11:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF53834E5;
	Wed,  3 Sep 2025 13:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yehFdTss";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DCr3v4o0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A1783564; Wed,  3 Sep 2025 13:22:45 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6455833C6
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 13:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cH0Zp4qL9z9tj8;
 Wed,  3 Sep 2025 13:22:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756898562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v2H7GtTM4a7xeh7vekYuhxGVlkcFS2XCJp9rCuP+u+w=;
 b=yehFdTssyFTN2NsRcSI5dCd67rAYEIrAIvgXCdVXOjbC14zs+FNdBlwrtwEzHFUD9h+piN
 mlhBRO+m48ZbxYL8CC9R71EBWxVhzyaOCHQeaLE1Eu8tb8/rpEF1jCuufPENqCBLUt+FBw
 N4O8RIv81qVEsBIheDJ+CMATq6Y3U1OdrmuTaJQ8Jw4f91gLkf2M+gNN9pE3thMA9HAa3v
 mKWpJ2KciOjsB+Rwnj/VUUeXHHkOygUCpILg+YOJBLtP+Ji3RzrXWRxVLArY50/fK4CmPp
 YH/P5v65CTEKjAYbW/32ffq6PuzN/irguWc/MqSr1z00BQ5RggGMpubjNcydtw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756898560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v2H7GtTM4a7xeh7vekYuhxGVlkcFS2XCJp9rCuP+u+w=;
 b=DCr3v4o04zf6lgXw138KBxMq70aGQGKFmVu8a6TcWPgrLmVR8XTbz+Hyj59r/tbusK8rhO
 KjFXiF+hkceewBxjklTquPEemoxFZFTfL9b/QNJ/6x/Av20gN4As+BbKY8TqIwnM4nD34I
 UdLVjBG915in7fteAeXPuvdOmuMeQtyTS6rdWcYbwaDCFDYklo3dpz3hANQWvsW8VbSJZM
 Pd7GIfg2s6QLJuwEF/k6va7dxe+JKcz3JVPEtyQyXlDt5z1/hqco4CavQL9I/c298BiTaJ
 Bx4nz6WJr8mDAvgrzxpp4so93iCD0VB6LcQrohErxUduBXTbxjjpfxDUhTWLcw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] env: Remove usb_ignorelist and env_fdt_path from ifdef
 CONFIG_ENV_VARS_UBOOT_CONFIG
Date: Wed,  3 Sep 2025 13:22:06 +0200
Message-ID: <20250903112228.48224-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e8187cdc7a10b391270
X-MBO-RS-META: id3tw6iuk5h1tdajym9xnfuiymz49u84
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
 include/env_default.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/env_default.h b/include/env_default.h
index 9caf22cdd1d..7f8dc1c35a7 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -79,10 +79,10 @@ const char default_environment[] = {
 #ifdef CONFIG_USE_BOOTFILE
 	"bootfile="	CONFIG_BOOTFILE			"\0"
 #endif
-#ifdef	CONFIG_SYS_LOAD_ADDR
+#ifdef CONFIG_SYS_LOAD_ADDR
 	"loadaddr="	__stringify(CONFIG_SYS_LOAD_ADDR)"\0"
 #endif
-#ifdef	CONFIG_ENV_VARS_UBOOT_CONFIG
+#ifdef CONFIG_ENV_VARS_UBOOT_CONFIG
 	"arch="		CONFIG_SYS_ARCH			"\0"
 #ifdef CONFIG_SYS_CPU
 	"cpu="		CONFIG_SYS_CPU			"\0"
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

