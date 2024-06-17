Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D3AC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 19:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE8E883FB;
	Mon, 17 Jun 2024 21:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E5F088403; Mon, 17 Jun 2024 21:14:25 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C05088398
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 21:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sJHo4-00CFal-9M;
 Mon, 17 Jun 2024 19:14:20 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Michal Simek <michal.simek@amd.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v6 2/4] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
Date: Mon, 17 Jun 2024 12:14:14 -0700
Message-Id: <20240617191416.1351790-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617191416.1351790-1-tharvey@gateworks.com>
References: <20240617191416.1351790-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
randomize the virtual address at which the kernel image is loaded, it
expects entropy to be provided by the bootloader by populating
/chosen/kaslr-seed with a 64-bit value from source of entropy at boot.

If we have DM_RNG enabled populate this value automatically when
fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
is enabled as its implementation uses a different source of entropy
that is not yet implemented as DM_RNG. We also skip this if
MEASURED_BOOT is enabled as in that case any modifications to the
dt will cause measured boot to fail (although there are many other
places the dt is altered).

Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
randomization and completely ignores the kaslr-seed for its own
randomness needs (i.e the randomization of the physical placement of
the kernel). It gets weeded out from the DTB that gets handed over via
efi_install_fdt() as it would also mess up the measured boot DTB TPM
measurements as well.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Chris Morgan <macromorgan@hotmail.com>
---
v6:
 - collected tags
v5:
 - fixed typo in commit message s/it's/its/
 - split patch into 3 parts
v4:
 - add missing /n to notice in kaslrseed cmd
 - combine ints in declaration
 - remove unused vars from board/xilinx/common/board.c ft_board_setup
v3:
 - skip if CONFIG_MEASURED_BOOT
 - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
 - pass in rng index and bool to specify overwrite
 - remove duplicate error strings printed outside of fdt_kaslrseed
 - added note to commit log about how EFI STUB weeds out kalsr-seed
v2:
 - fix typo in commit msg
 - use stack for seed to avoid unecessary malloc/free
 - move to a library function and deduplicate code by using it
   elsewhere
---
 boot/fdt_support.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index b1b2679dea0c..4559adcd5e2e 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -345,6 +345,15 @@ int fdt_chosen(void *fdt)
 	if (nodeoffset < 0)
 		return nodeoffset;
 
+	/* if DM_RNG enabled automatically inject kaslr-seed node unless:
+	 * CONFIG_MEASURED_BOOT enabled: as dt modifications break measured boot
+	 * CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT enabled: as that implementation does not use dm yet
+	 */
+	if (IS_ENABLED(CONFIG_DM_RNG) &&
+	    !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
+	    !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
+		fdt_kaslrseed(fdt, false);
+
 	if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
 		err = fdt_setprop(fdt, nodeoffset, "rng-seed",
 				  abuf_data(&buf), abuf_size(&buf));
-- 
2.25.1

