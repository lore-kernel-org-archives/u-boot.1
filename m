Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE492C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A4187A88;
	Wed, 10 Jan 2024 13:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="WhHjAWOY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p8oa/FRs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WhHjAWOY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p8oa/FRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280E486EF1; Wed, 10 Jan 2024 13:29:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA4E878D7
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 13:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2C2B21DDF;
 Wed, 10 Jan 2024 12:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704889763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fZNNsdOHOssOsQ3DD4x6601/qyAAXeT5aF/iQxY4ik=;
 b=WhHjAWOY8Wm5fabRxuldEZartP81vl91Pjc9OZKBazs5LMET3quy0WbDehf9380R4pOj1Q
 FEy5PHhLyO+gF9T3ZQ53Z512SucvTmnInuQ/jAXA6Xk3C+9jY5QiK9PJhKTQuZ1jPGWQ1A
 XWeHZ/OeSgIZBpvl1cJMkaVbCoQLTbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704889763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fZNNsdOHOssOsQ3DD4x6601/qyAAXeT5aF/iQxY4ik=;
 b=p8oa/FRsv7uY3mWqZc7MgfRzt4sZUekRoBq8V7PHK2EBbONzyJvIEA21MYSKK2LeBPCqei
 XEtZqeb13Fhe/SDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704889763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fZNNsdOHOssOsQ3DD4x6601/qyAAXeT5aF/iQxY4ik=;
 b=WhHjAWOY8Wm5fabRxuldEZartP81vl91Pjc9OZKBazs5LMET3quy0WbDehf9380R4pOj1Q
 FEy5PHhLyO+gF9T3ZQ53Z512SucvTmnInuQ/jAXA6Xk3C+9jY5QiK9PJhKTQuZ1jPGWQ1A
 XWeHZ/OeSgIZBpvl1cJMkaVbCoQLTbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704889763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fZNNsdOHOssOsQ3DD4x6601/qyAAXeT5aF/iQxY4ik=;
 b=p8oa/FRsv7uY3mWqZc7MgfRzt4sZUekRoBq8V7PHK2EBbONzyJvIEA21MYSKK2LeBPCqei
 XEtZqeb13Fhe/SDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E66C13CB3;
 Wed, 10 Jan 2024 12:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OMWUGKKNnmUZPgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Wed, 10 Jan 2024 12:29:22 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T . Ivanov" <iivanov@suse.de>
Subject: [PATCH v4 1/6] rpi5: add initial memory map for bcm2712
Date: Wed, 10 Jan 2024 14:29:03 +0200
Message-ID: <20240110122908.31612-2-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110122908.31612-1-iivanov@suse.de>
References: <20240110122908.31612-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.22 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.68)[93.01%]
Authentication-Results: smtp-out1.suse.de;
	none
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

This includes:
* 1GB of RAM (from 4GB or 8GB total)
* AXI ranges (main peripherals)

When HDMI cable is plugged in at boot time firmware will
insert "simple-framebuffer" device into devicetree and will
shrink first memory region to 0x3f800000UL. Board setup then
will properly reserve frameboofer region.

When no HDMI cable is plugged in size of the region will be
0x3fc00000UL.

Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 arch/arm/mach-bcm283x/init.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 7265faf6ce..f1a0c8588d 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -68,6 +68,36 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
 	}
 };
 
+static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
+	{
+		/* First 1GB of DRAM */
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Beginning of AXI bus where uSD controller lives */
+		.virt = 0x1000000000UL,
+		.phys = 0x1000000000UL,
+		.size = 0x0002000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* SoC bus */
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
@@ -78,6 +108,7 @@ static const struct udevice_id board_ids[] = {
 	{ .compatible = "brcm,bcm2837", .data = (ulong)&bcm283x_mem_map},
 	{ .compatible = "brcm,bcm2838", .data = (ulong)&bcm2711_mem_map},
 	{ .compatible = "brcm,bcm2711", .data = (ulong)&bcm2711_mem_map},
+	{ .compatible = "brcm,bcm2712", .data = (ulong)&bcm2712_mem_map},
 	{ },
 };
 
-- 
2.35.3

