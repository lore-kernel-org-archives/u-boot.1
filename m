Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3223C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 11:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A45C81F66;
	Mon, 23 Jun 2025 13:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BNLO58z6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3AC68210D; Mon, 23 Jun 2025 13:51:48 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E800380548
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 13:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 56A5B4431B;
 Mon, 23 Jun 2025 11:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CE4C4CEF0;
 Mon, 23 Jun 2025 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750679504;
 bh=jG/qAKqr4E2mMrEZ4vOAK9BM7I9CX+knqVhgKkiPEkM=;
 h=From:To:Cc:Subject:Date:From;
 b=BNLO58z66AAKvZ1p2kLAn89E9kKNpZFMrpP5tNN0WwvZ/eKDq5FbyiJoMm7wyhkS/
 1ACYjR8E+YreBBiZIJGcY9VmSJX4iSYHvD2Ija7SMVodoTzg1V5z/u/5ZrtY54cjxq
 joF668rlrF1WGx1hTwQcGkrh0DAxbcqjWYSvGIa25lbMO/o57g4uKiyt7+8/uf+vnY
 bxXpJ9BpvxCiits5we7GTMCPZc5mWTtqdCghIFKKci0cJnDrC1b4/R3enwEHH0Aen6
 9t5f1snsSDW0VeM4E9RPrgj2M95V/3LYa1Dsc2m6P3Ib/XxUNmfqqq/L9eOt353z2x
 fjLlfLzjpnpyQ==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Ivan Griffin <ivan.griffin@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Jamie.Gibbons@microchip.com
Subject: [PATCH v2] board: mpfs_icicle: implement
 board_fdt_blob_setup()/board_fit_config_name_match()
Date: Mon, 23 Jun 2025 12:51:36 +0100
Message-ID: <20250623115137.4017059-1-conor@kernel.org>
X-Mailer: git-send-email 2.45.2
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

From: Conor Dooley <conor.dooley@microchip.com>

The firmware on the Icicle is capable of providing a devicetree in a1 to
U-Boot, but until now the devicetree has been packaged in a "payload" [1]
alongside U-Boot (or other bootloaders/RTOSes) and appended to the image.
The address of this appended devicetree is placed in a1 by the firmware.
This meant that the mechanism used by OF_SEPARATE to locate the
devicetree at the end of the image would pick up the one provided by the
firmware when u-boot-nodtb.bin was in the payload and U-Boot's devicetree
when u-boot.bin was.

The firmware is now going to be capable of providing a minimal devicetree
(quite cut down due to severe space constraints), but this devicetree is
linked into the firmware that runs out of the L2 rather than at the end
of the U-Boot image.

Implement board_fdt_blob_setup() so that this devicetree can be
optionally used, and the devicetree provided in the "payload" can be
used without relying on "happening" to implement the same strategy as
OF_SEPARATE expects in combination with u-boot-nodtb.bin.
Unlike other RISC-V boards, the firmware provided devicetree is only
used when OF_BOARD is set, so that the almost certainly more complete
devicetree in U-Boot will be used unless explicitly requested otherwise.

Implement board_fit_config_name_match(), so that, using the firmware
provided cut-down/minimal dtb, U-Boot can select one of several
devicetrees when MULTI_DTB_FIT is enabled.

Enabling both MULTI_DTB_FIT and OF_BOARD will lead to a conflict
between the two options, with the latter taking priority due to
board_fdt_blob_setup() being executed before board_fit_config_name_match(),
which causes gd->fdt_blob to be overwritten with a pointer to the
minimal devicetree rather than the location of the fit image containing
the multiple dtbs. Let MULTI_DTB_FIT take priority in this case, by
explicitly blocking the override when MULTI_DTB_FIT is enabled.

Link: https://github.com/polarfire-soc/hart-software-services/blob/master/tools/hss-payload-generator/README.md [1]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

v2:
- implement MULTI_DTB_FIT too

v1 was a year ago here:
https://lore.kernel.org/u-boot/20240625090806.1787287-2-conor.dooley@microchip.com/

There was some discussion on that thread, but ultimately I didn't find
what was mentioned to be worth implementing. Heinrich suggested to me, I
guess on IRC or something since it's not in that thread, implementing
MULTI_DTB_FIT, which I have done. A lot of the reason for the patch when
I wrote it was speculative, but we have some actual users for OF_BOARD
now - hence the v2 after about a year's gap.

CC: Ivan Griffin <ivan.griffin@microchip.com>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Tom Rini <trini@konsulko.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Simon Glass <sjg@chromium.org>
CC: Jamie.Gibbons@microchip.com
CC: u-boot@lists.denx.de
---
 board/microchip/mpfs_icicle/mpfs_icicle.c | 63 +++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
index 4d7d843dfa3..6b6984eae3f 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -9,6 +9,7 @@
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <asm/sections.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -50,6 +51,68 @@ static void read_device_serial_number(u8 *response, u8 response_size)
 		response_buf[idx] = readb(MPFS_SYS_SERVICE_MAILBOX + idx);
 }
 
+#if defined(CONFIG_MULTI_DTB_FIT)
+int board_fit_config_name_match(const char *name)
+{
+	const void *fdt;
+	int list_len;
+
+	/*
+	 * If there's not a HSS provided dtb, there's no point re-selecting
+	 * since we'd just end up re-selecting the same dtb again.
+	 */
+	if (!gd->arch.firmware_fdt_addr)
+		return -EINVAL;
+
+	fdt = (void *)gd->arch.firmware_fdt_addr;
+
+	list_len = fdt_stringlist_count(fdt, 0, "compatible");
+	if (list_len < 1)
+		return -EINVAL;
+
+	for (int i = 0; i < list_len; i++) {
+		int len, match;
+		const char *compat;
+		char *devendored;
+
+		compat = fdt_stringlist_get(fdt, 0, "compatible", i, &len);
+		if (!compat)
+			return -EINVAL;
+
+		strtok((char *)compat, ",");
+
+		devendored = strtok(NULL, ",");
+		if (!devendored)
+			return -EINVAL;
+
+		match = strcmp(devendored, name);
+		if (!match)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+#endif
+
+int board_fdt_blob_setup(void **fdtp)
+{
+	fdtp = (void *)_end;
+
+	/*
+	 * The devicetree provided by the previous stage is very minimal due to
+	 * severe space constraints. The firmware performs no fixups etc.
+	 * U-Boot, if providing a devicetree, almost certainly has a better
+	 * more complete one than the firmware so that provided by the firmware
+	 * is ignored for OF_SEPARATE.
+	 */
+	if (IS_ENABLED(CONFIG_OF_BOARD) && !IS_ENABLED(CONFIG_MULTI_DTB_FIT)) {
+		if (gd->arch.firmware_fdt_addr)
+			fdtp = (void *)(uintptr_t)gd->arch.firmware_fdt_addr;
+	}
+
+	return 0;
+}
+
 int board_init(void)
 {
 	/* For now nothing to do here. */
-- 
2.45.2

