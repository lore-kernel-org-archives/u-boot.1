Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F59EC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 08:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897C087C08;
	Tue, 23 Jan 2024 09:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7CA87C8A; Tue, 23 Jan 2024 09:08:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C664C87BFD
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 54EED1F766;
 Tue, 23 Jan 2024 08:08:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9BD9139B1;
 Tue, 23 Jan 2024 08:08:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6HK/JgR0r2XOagAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 23 Jan 2024 08:08:36 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T . Ivanov" <iivanov@suse.de>
Subject: [PATCH v5 1/7] rpi5: add initial memory map for bcm2712
Date: Tue, 23 Jan 2024 10:07:53 +0200
Message-ID: <20240123080819.13625-2-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123080819.13625-1-iivanov@suse.de>
References: <20240123080819.13625-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 54EED1F766
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
will properly reserve framebuffer region.

When no HDMI cable is plugged in the size of the region will
be 0x3fc00000UL.

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
2.43.0

