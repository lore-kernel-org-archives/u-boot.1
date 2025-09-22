Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A9ACAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 11:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372B8833E8;
	Mon, 22 Sep 2025 13:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gElDqo4l";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E3ZCmNHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF2E833F5; Mon, 22 Sep 2025 13:49:55 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6956F832F9
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 13:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cVhHP1tphz9v8W;
 Mon, 22 Sep 2025 13:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758541793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqudjCgyCZCm5Zi3022f9xyUQ3F7mqMksyS+ZYDU+WM=;
 b=gElDqo4ldcnpktRWod/8oBx00KyQfZ5Z71tuStBeF33OvZ65oeGQOjJoGj2gV2kPYDl5Ml
 wo6vli7CdUdBPKmWHhOR/xEeEqL9CC35zw7TQtRpaZIsMAN0dsmuxczHnzD2W/r8J/E8cj
 A6mqKgYR33xVpaDo2u4BhbN4MAzUboMYarKBeWBF+/LTiOZC3Qsyhi8uNXX9bJ1pRjNo3a
 0QeZJf+h6tXs9+UrlFDCxIA6VIDffx4psoRAODdRs5b2GRaa5Y9DEIpaW4KITAIxhW7XFS
 syQQ8as1e4DNnp/OJOzWVqIFEdCS6HNSBmPIHTfzlfQtr8W5xMrW/SLtItm4nQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=E3ZCmNHD;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758541791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqudjCgyCZCm5Zi3022f9xyUQ3F7mqMksyS+ZYDU+WM=;
 b=E3ZCmNHDr7AFoxEdVYBOn0o7JJYs5fQQpfYRm5erjujDgigBlAXt5+xu0om93Dqu24Hh00
 X56NUt0fFQTt7xcbkBJiCYrXJVifmk84WGCXV+Xx5qTdlxlX0ZNmqMWQGjVegoWFWZGeTS
 tU5hzEcoq2vUNXG4SGvzIQ/v0/Pvdaxi/dYpckQOnX55MyegB8Q83Wh6dAnASX47qIxXjo
 LYD2z5YS7viVQ7slv85cZfOvZARSNHF66rJY1bdfZxetmHKBSW9gpnN/9tzOhkSKn9oNre
 aBWfXV5bIGxGdgUyjqFv0WFJK70j1Cle+g5f53iOcUxb9230clfmnMFlVAedPA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 2/2] fw_loader: Prefix the FW loader variables with the script
 prefix
Date: Mon, 22 Sep 2025 13:48:28 +0200
Message-ID: <20250922114926.51984-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250922114926.51984-1-marek.vasut+renesas@mailbox.org>
References: <20250922114926.51984-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gfqahzjc3ayx4saags4qksjchqqp8735
X-MBO-RS-ID: 44e51f447740327d22c
X-Rspamd-Queue-Id: 4cVhHP1tphz9v8W
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

Add the script name as a prefix to fw_addr and fw_size variables
to make sure they are always unique and won't easily conflict with
user variables.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de
---
 lib/fw_loader.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/fw_loader.c b/lib/fw_loader.c
index 207f5fadd1e..f776e09523a 100644
--- a/lib/fw_loader.c
+++ b/lib/fw_loader.c
@@ -13,6 +13,8 @@ int request_firmware_into_buf_via_script(void *buf, size_t max_size,
 					 const char *script_name,
 					 size_t *retsize)
 {
+	char env_addr[CONFIG_SYS_CBSIZE] = { 0 };
+	char env_size[CONFIG_SYS_CBSIZE] = { 0 };
 	char *args[2] = { "run", (char *)script_name };
 	int ret, repeatable;
 	ulong addr, size;
@@ -28,13 +30,17 @@ int request_firmware_into_buf_via_script(void *buf, size_t max_size,
 		return -EINVAL;
 	}
 
+	/* Prefix the FW loader variables with the script prefix */
+	snprintf(env_addr, sizeof(env_addr), "%s_addr", script_name);
+	snprintf(env_size, sizeof(env_size), "%s_size", script_name);
+
 	/* Find out where the firmware got loaded and how long it is */
-	addr = env_get_hex("fw_addr", 0);
-	size = env_get_hex("fw_size", 0);
+	addr = env_get_hex(env_addr, 0);
+	size = env_get_hex(env_size, 0);
 
 	/* Clear the variables set by the firmware loading script */
-	env_set("fw_addr", NULL);
-	env_set("fw_size", NULL);
+	env_set(env_addr, NULL);
+	env_set(env_size, NULL);
 
 	if (!addr || !size) {
 		log_err("Firmware address (0x%lx) or size (0x%lx) are invalid.\n",
-- 
2.51.0

