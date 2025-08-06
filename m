Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0DCC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 00:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF33883938;
	Wed,  6 Aug 2025 02:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wjkHcWzu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SFeoOQ73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D86383933; Wed,  6 Aug 2025 02:57:05 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1528E83933
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 02:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxX1Y5sggz9skQ;
 Wed,  6 Aug 2025 02:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754441809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LnxYKoTq8yhTtClB//gPn5auL6SBRNgaeenQc6a2k8s=;
 b=wjkHcWzu2ZWAT0/6VwwJ7J0N+xYwFRQnK6Z/kt4ITCbGsujJOS0HgCm4f1JcZtmKsnAymg
 i1N0k0K2yI/jI8FQM268sRqswcVC4e8mDVEJWdjgR9caxVqggKr0Y4v76TID5sAzWhaJ4t
 yivS2vWSnlE1ffztGjaOuNJn7aaY5XxBbmwvgx7U/s/MdPGrxXTR1fZn1I/cKcUXiSQ2sd
 OEuogTKeOMkK97/5dAHVjnR0MGqLXhF7peI0bzQeZc5kl2qfdRNvnJKafaoWfYQ9uYyxJp
 I8V2PQE+VHQLeDju/Qv2b0Pbe9O/pFzV/8gEGOBxwhyg7Lm0yp+0CGrXr1nmLQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SFeoOQ73;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754441808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LnxYKoTq8yhTtClB//gPn5auL6SBRNgaeenQc6a2k8s=;
 b=SFeoOQ73vMZ8lXKjbPCzgFkdiveu7cQOXMyTUdq7voB8OumUq5PO+hgSfh5JZYhyx0QoQz
 JvAMfMxSuV/DNL7CV8Y5uq50URaNRGeVQH8pnOgooZ4EtIykWetamZxwX9h1Vj/Nh1HNjH
 cnDcvMrt6u/wlw14fyhihISDtaG44crPXXfJ0m68h79FM7IIxAWDXw0Xwa2FIlm7jrOGrw
 7nihhEQ5Bb2b6F9tTC65sZtlOhPQ/WOFNXFyEOJL+LZo+hVV/ODcsTYSZiQDhmkkn46um/
 6g+b8ZLD8CnS00Twi0Mk+iNpX/9kP+P0BzcI3LsPK0Wr3kM/ne/KUmNj2sDzOA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: r8a779g3: Disable MicroSD UHS modes on
 Retronix R-Car V4H Sparrow Hawk EVTA1
Date: Wed,  6 Aug 2025 02:56:15 +0200
Message-ID: <20250806005630.284041-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fec54dd2f70851bc48a
X-MBO-RS-META: ui3n84kd9a3t4qydn1iqdt5ugmd68w7m
X-Rspamd-Queue-Id: 4bxX1Y5sggz9skQ
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

The Retronix R-Car V4H Sparrow Hawk old revision EVTA1 does not have MicroSD
voltage switch populated on the board, therefore the board supports only 3V3
and non-UHS MicroSD cards. While the EVTB1 board is populated with Winbond
W77Q51NW SPI NOR, the EVTA1 board is populated with Spansion S25FS512S SPI
NOR, those those SPI NOR IDs to discern the two board revisions and apply
the MicroSD related DT changes.

The MicroSD related DT changes modify the regulator node, which is now a
regulator-fixed and supplies only 3V3, and remove sd-uhs-sdr50 and
sd-uhs-sdr104 properties from the MicroSD slot controller node.

The MicroSD related DT changes cannot be applied as DTO, because the base
DT contains nodes which have to be removed in case of EVTA1, but have to
be present in case of EVTB1 and newer revisions of the board. Because the
EVTA1 is an old revision of the board that is not generally available, it
is better to special case it and keep the base DT compatible with EVTB1
and newer revisions of the board which are actually available.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/sparrowhawk/sparrowhawk.c | 114 ++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/board/renesas/sparrowhawk/sparrowhawk.c b/board/renesas/sparrowhawk/sparrowhawk.c
index 8e72b5424d1..871dad8172a 100644
--- a/board/renesas/sparrowhawk/sparrowhawk.c
+++ b/board/renesas/sparrowhawk/sparrowhawk.c
@@ -6,8 +6,12 @@
 #include <asm/io.h>
 #include <compiler.h>
 #include <dbsc5.h>
+#include <spi.h>
+#include <spi_flash.h>
 #include <spl.h>
 
+#include "../../../drivers/mtd/spi/sf_internal.h"
+
 #if defined(CONFIG_XPL_BUILD)
 
 static const struct renesas_dbsc5_board_config
@@ -118,6 +122,116 @@ dbsc5_get_board_data(struct udevice *dev, const u32 modemr0)
 		return &renesas_v4h_sparrowhawk_8g_6400_dbsc5_board_config;
 }
 
+static bool renesas_v4h_sparrowhawk_is_evta1 = false;
+
+unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
+{
+	const u8 sf_ids_evta1[6] = { 0x01, 0x02, 0x20, 0x4d, 0x00, 0x81 };
+
+	renesas_v4h_sparrowhawk_is_evta1 = !memcmp(sf_ids_evta1, flash->info->id,
+						   sizeof(sf_ids_evta1));
+
+	return CONFIG_SYS_SPI_U_BOOT_OFFS;
+}
+
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	void *blob = spl_image_fdt_addr(spl_image);
+	int err, offs;
+	u32 size;
+
+	if (!renesas_v4h_sparrowhawk_is_evta1)
+		return;
+
+	printf("EVTA1 board detected\n");
+
+	/*
+	 * MicroSD voltage switch is not populated on Sparrow Hawk EVTA1,
+	 * rewrite MicroSD slot regulator to only support 3V3 and disable
+	 * UHS modes in MicroSD slot node.
+	 */
+	if (!blob)
+		return;
+
+	err = fdt_check_header(blob);
+	if (err < 0) {
+		printf("Invalid FDT header: %s\n", fdt_strerror(err));
+		return;
+	}
+
+	size = fdt_totalsize(blob);
+	err = fdt_open_into(blob, blob, size + 64);
+	if (err < 0) {
+		printf("Failed to expand DT\n");
+		return;
+	}
+
+	offs = fdt_path_offset(blob, "/regulator-vcc-sdhi");
+	if (offs < 0) {
+		printf("Failed to locate MicroSD regulator node: %d\n", offs);
+		return;
+	}
+
+	err = fdt_setprop_string(blob, offs, "compatible", "regulator-fixed");
+	if (err < 0) {
+		printf("Failed to set fixed MicroSD regulator: %d\n", err);
+		return;
+	}
+
+	err = fdt_setprop_u32(blob, offs, "regulator-min-microvolt", 3300000);
+	if (err < 0) {
+		printf("Failed to set MicroSD regulator minimum voltage: %d\n", err);
+		return;
+	}
+
+	err = fdt_nop_property(blob, offs, "gpios");
+	if (err < 0) {
+		printf("Failed to remove MicroSD regulator gpios: %d\n", err);
+		return;
+	}
+
+	err = fdt_nop_property(blob, offs, "gpios-states");
+	if (err < 0) {
+		printf("Failed to remove MicroSD regulator gpio states: %d\n", err);
+		return;
+	}
+
+	err = fdt_nop_property(blob, offs, "states");
+	if (err < 0) {
+		printf("Failed to remove MicroSD regulator states: %d\n", err);
+		return;
+	}
+
+	offs = fdt_path_offset(blob, "/soc/mmc@ee140000");
+	if (offs < 0) {
+		printf("Failed to locate MicroSD device node: %d\n", offs);
+		return;
+	}
+
+	err = fdt_nop_property(blob, offs, "sd-uhs-sdr50");
+	if (err < 0) {
+		printf("Failed to disable SDR50 mode in MicroSD node: %d\n", err);
+		return;
+	}
+
+	err = fdt_nop_property(blob, offs, "sd-uhs-sdr104");
+	if (err < 0) {
+		printf("Failed to disable SDR104 mode in MicroSD node: %d\n", err);
+		return;
+	}
+
+	err = fdt_setprop_string(blob, offs, "pinctrl-names", "default");
+	if (err < 0) {
+		printf("Failed to set fixed MicroSD pin names: %d\n", err);
+		return;
+	}
+
+	err = fdt_nop_property(blob, offs, "pinctrl-1");
+	if (err < 0) {
+		printf("Failed to disable UHS pins in MicroSD node: %d\n", err);
+		return;
+	}
+}
 #endif
 
 #define RST_MODEMR0			0xe6160000
-- 
2.47.2

