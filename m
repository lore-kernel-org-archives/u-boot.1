Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDEFE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F478021C;
	Thu, 12 Dec 2024 14:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SxjKXREc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k119++VI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55AE280209; Thu, 12 Dec 2024 14:40:58 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48164801D7
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y8DBb6jWLz9t0M;
 Thu, 12 Dec 2024 14:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKuLBnx+NmZBvhvG6cXBgCux4ahTAIVBWAi2eTvY7kw=;
 b=SxjKXREclWhnryA6agwDkprB4GAGHuzYDo7LGio8fZibLIq27pkuO344WgPvmoJo4iGUCM
 xLET5p5YSPaKoUQOfDGP+uIp9pMTq11ypozE8Qzipxzemsb0OHDmgyz2AaFJOwWoJjFNl0
 SWldmjZjOMNPo5gzDS0gkh7NvVl+76783ivvqU44aolLgwWuuWLeE5rwXJGLEDxfF/haRe
 skPEGF/h0tZ9lKC7EWUx0Au8kEOacrOuZx0/clC5TO2EjFUqB9ZeABCyeuWb75UcLQlUI8
 JtgFuJw0EBnIDvd7XtNOvIRNz62Ge2W/KP1UeW5TUfvAJGTaY4c6LXm7uvyQaQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKuLBnx+NmZBvhvG6cXBgCux4ahTAIVBWAi2eTvY7kw=;
 b=k119++VIF/hCYYSpPOFu1iqpchMn5leoXxV5HMJtdJU4MmBIiZV5sAcu1fVmTaDXlAfnde
 Rct1Bzz/hpjUX83Ln2ZaEOM6POx0sU+exg39u28k3lGd0e+cOzbX6i00WpXtr48r5uYb/b
 CfEvXfgMyvMS967X+/7WeX0fFJzxgPNLwaxqSWhv3zO89vb9dczKYX88MPrigagXoAtInE
 FXJV58Im3+7+SlnPjTmNagECiebjJJCua5zycFbFdM0Hf16t4nr7iswRLlsQ3yq1p4rtLY
 E/hdnLF5PZQ308OWMB77oytL3TSw0Par0L+lzPlb+KjkU9wVjmqjcBlnQGQ8Tw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm64: renesas: Make bottom 128 MiB of DRAM available in
 EL3
Date: Thu, 12 Dec 2024 14:38:28 +0100
Message-ID: <20241212134025.84612-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241212134025.84612-1-marek.vasut+renesas@mailbox.org>
References: <20241212134025.84612-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b87n6pr75t7duoah7ztycsc9tfs6ibb4
X-MBO-RS-ID: 68f8f278a4b92e617e5
X-Rspamd-Queue-Id: 4Y8DBb6jWLz9t0M
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

In case U-Boot runs in EL3, which is the highest privilege level on ARM64,
there can be no firmware running that would restrict access to the bottom
128 MiB of DRAM. In fact, it is likely that U-Boot would have to load that
firmware into those bottom 128 MiB of DRAM and start that firmware.

Make those bottom 128 MiB of DRAM available in case U-Boot runs in EL3 to
allow loading the firmware to that area.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/rcar-common/common.c | 36 +++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/board/renesas/rcar-common/common.c b/board/renesas/rcar-common/common.c
index 4e35e0151c9..95a64ab9cec 100644
--- a/board/renesas/rcar-common/common.c
+++ b/board/renesas/rcar-common/common.c
@@ -15,6 +15,7 @@
 #include <asm/io.h>
 #include <dm/uclass-internal.h>
 #include <asm/arch/renesas.h>
+#include <asm/system.h>
 #include <linux/libfdt.h>
 
 #ifdef CONFIG_RCAR_64
@@ -23,13 +24,46 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	int ret = fdtdec_setup_mem_size_base();
+
+	if (IS_ENABLED(CONFIG_RCAR_GEN4) && current_el() == 3 &&
+	    gd->ram_base == 0x48000000) {
+		/*
+		 * If this U-Boot runs in EL3, make the bottom 128 MiB
+		 * available for loading of follow up firmware blobs.
+		 */
+		gd->ram_base -= 0x8000000;
+		gd->ram_size += 0x8000000;
+	}
+
+	return ret;
 }
 
 int dram_init_banksize(void)
 {
+	int bank;
+
 	fdtdec_setup_memory_banksize();
 
+	if (!IS_ENABLED(CONFIG_RCAR_GEN4))
+		return 0;
+
+	if (current_el() != 3)
+		return 0;
+
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		if (gd->bd->bi_dram[bank].start != 0x48000000)
+			continue;
+
+		/*
+		 * If this U-Boot runs in EL3, make the bottom 128 MiB
+		 * available for loading of follow up firmware blobs.
+		 */
+		gd->bd->bi_dram[bank].start -= 0x8000000;
+		gd->bd->bi_dram[bank].size += 0x8000000;
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.45.2

