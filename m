Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638CEC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92DDD8753C;
	Mon, 18 Dec 2023 22:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="frMNX+46";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IseK5QVE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1pz5pvm/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fIckdee4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A7F87525; Mon, 18 Dec 2023 22:03:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B37B87530
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6EE4F2228D;
 Mon, 18 Dec 2023 21:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KH3AWH4E2OZnkKkgKspHqUQ687KHDd+TcmlhsjT4WMY=;
 b=frMNX+46FgFSdyN24UT7Y4WdFDJKcOxcjH0HyyTrZsMcayuXoLtERkmRllSmLu8aRAoWOI
 dzM9aX7eK9EHwuozUVijinsJ6wKpvqwxEx0Kdnj3wKPjAS3KTXGwfYiuZeO5wmbGRytEXd
 p252vWhSG5L4UgaWil84yA4iM0KqiPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KH3AWH4E2OZnkKkgKspHqUQ687KHDd+TcmlhsjT4WMY=;
 b=IseK5QVEh+KCaimaGVOvt6lv9A9n/uQ/xO6kky5hugt4tubeSnhwGXuCjHTIEZhYi9auSr
 Q6h6Mb/o4bd7u1CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KH3AWH4E2OZnkKkgKspHqUQ687KHDd+TcmlhsjT4WMY=;
 b=1pz5pvm/SI3fxjKAlUcM+pRnK+NKLVbl/0Kj+UUQ/R29Irq4CDjfgTyaU0/DIXgn3x7Ttl
 2U7+per0J38TYiYHjQSDlrdPq4CwSFX2IEFS6sA5jx41ySG3RgO51Hh5GXKFh/WDUjcsn6
 ZPLcQCP31JjxHhULkzjaYLVYE2rQuXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KH3AWH4E2OZnkKkgKspHqUQ687KHDd+TcmlhsjT4WMY=;
 b=fIckdee4Yc6Iut7CdcyZnDHxDW58F+dY46W7JLg6y7iXnfDkSc0DETyb97S3ngS7GdF3OQ
 HPy/QFdHWA8p8cBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D359F13C92;
 Mon, 18 Dec 2023 21:03:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4CUUMbSzgGUtZAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Mon, 18 Dec 2023 21:03:48 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T . Ivanov" <iivanov@suse.de>
Subject: [PATCH v3 1/7] rpi5: add initial memory map for bcm2712
Date: Mon, 18 Dec 2023 23:03:35 +0200
Message-ID: <20231218210341.30073-2-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218210341.30073-1-iivanov@suse.de>
References: <20231218210341.30073-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,bedrocksystems.com:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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

From: Dmitry Malkin <dmitry@bedrocksystems.com>

includes:
* 1GB of RAM (from 4GB or 8GB total)
* VPU memory interface
* AXI ranges (main peripherals)

Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 arch/arm/mach-bcm283x/init.c | 38 +++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 7265faf6ce..af23b9711a 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -19,7 +19,7 @@
 #ifdef CONFIG_ARM64
 #include <asm/armv8/mmu.h>
 
-#define MEM_MAP_MAX_ENTRIES (4)
+#define MEM_MAP_MAX_ENTRIES (5)
 
 static struct mm_region bcm283x_mem_map[MEM_MAP_MAX_ENTRIES] = {
 	{
@@ -68,6 +68,41 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
 	}
 };
 
+static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
+	{
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x3f800000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0x3f800000UL,
+		.phys = 0x3f800000UL,
+		.size = 0x00800000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* Beginning of AXI bus where uSD controller lives */
+		.virt = 0x1000000000UL,
+		.phys = 0x1000000000UL,
+		.size = 0x0002000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0x107c000000UL,
+		.phys = 0x107c000000UL,
+		.size = 0x0004000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
 struct mm_region *mem_map = bcm283x_mem_map;
 
 /*
@@ -78,6 +113,7 @@ static const struct udevice_id board_ids[] = {
 	{ .compatible = "brcm,bcm2837", .data = (ulong)&bcm283x_mem_map},
 	{ .compatible = "brcm,bcm2838", .data = (ulong)&bcm2711_mem_map},
 	{ .compatible = "brcm,bcm2711", .data = (ulong)&bcm2711_mem_map},
+	{ .compatible = "brcm,bcm2712", .data = (ulong)&bcm2712_mem_map},
 	{ },
 };
 
-- 
2.35.3

