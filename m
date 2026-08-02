Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B937DC55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 21:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1252D606C7;
	Sun,  2 Aug 2026 21:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rl4IT_2804j6; Sun,  2 Aug 2026 21:35:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 211E0606AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785706544;
	bh=BoyZ4dPgit799mEJkoJ+tFlLNJFzv+yEH/4hheyUobo=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Z/N59YIUs7vCCp3vHidZw95jrapz0HrIWzLi8gox6vOyynnl8So3BHaOBCcyZnjy5
	 stmGU+cgivnhJH0hgWHunM6qHZsW6dK2EjRSb9VUtv1cruLKALobq3Y9NisbINTHil
	 MVx2jo8T3rRRgkGqNA83c8XwvZf0OgvTAiSBgdvntDlNiCQzOc5zc8rIGTJxFFhIys
	 Bsyh6FZuiXdNcVbNqOYKldaJS2nvQL3oMuKvIWye927lGO8mGdA1NuXdTwixvEtyDN
	 CSzT8UG7OW6QNz+kl3gmEnWjPAEPv7sV3qAh8f5BUAYMOvEIGfdnVCGZ+RcQ/uIyrv
	 e7yI9ItERkpsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 211E0606AA;
	Sun,  2 Aug 2026 21:35:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DE06313
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 100E2405E5
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CDnSYKevze1B for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 21:35:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F35FF404F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F35FF404F5
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F35FF404F5
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:35:41 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hCtQL6W75zMlHS;
 Sun, 02 Aug 2026 23:35:38 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] board_f: Add verbose DRAM layout print option
Date: Sun,  2 Aug 2026 23:33:37 +0200
Message-ID: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cs3jws7ts4ok36bc43spt91i7aewrha7
X-MBO-RS-ID: 0d081e659dd7ee428b7
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785706538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BoyZ4dPgit799mEJkoJ+tFlLNJFzv+yEH/4hheyUobo=;
 b=R4laDC29PHXfQTGPC53MT/zFitTGSPAEYmTuN29S64oZjsm2KKpSyzRXCuKRM262xROR/+
 gAhs/PyigEj4Tis22DJwoMxFA+7zKeuofQhTpLOlpC/j42uG5AtRv77sPrO+c8OyoryWxj
 kKs4+JaOGzslC4nTjqRvWbuNY+Km3p9xkstQezG23W/AqHKBJqXLFTdVEhsNHgyVe5EptS
 51r1dz1qSZzCFUghurlGrfr8ObH6v72CzxYSu1sCr31af/oxwrFwvsxwMWYPZiu7yXfmCa
 BiTk5X6jsF1nu2FwuE5F/cCNhaOrbtlzo8X0p1oVji8A1gE1b3SbpYeMb/P09A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785706537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BoyZ4dPgit799mEJkoJ+tFlLNJFzv+yEH/4hheyUobo=;
 b=t1Vbvz5tJEeR0azQ2JufPwq3Q2bsjpMKAz4U2g59dRHMzqnz49SQ5SJa3lzoyEfv4EY2px
 LcjLkSUW3+qFxWknaqm/G62RpDbgqcpOB5uOCy/brKzbrdwLdAIlm9T7y7np55R8PZECNl
 rmsFdI4sdetHiECMlqPBr13azh57qeio+tn/kS8lxFh2JKpCLqlRJKAnIqM8qDrtGoZkGd
 EAbxZSZGw1E7j1XrjGZNKJQxtaxxK/UHPZi/oNHI1YnIDOQeV0ydVOEvJG54Sllwnjl5yN
 K4LJQdDfBpMbB3Z0KP8HgN761F/gTDW1EaSglXkgoowQPbnPMWE1Ce7PjGjsgg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=R4laDC29; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=t1Vbvz5t
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Make verbose DRAM layout print on boot configurable via newly introduced
CONFIG_DISPLAY_DRAM_CONFIG_VERBOSE Kconfig option. This reuses existing
DRAM layout debug print, but with additional rework to place the output
at the end of DRAM size listing, print both bank start and end addresses,
and skip empty banks. In case DEBUG is defined, the DRAM layout print is
triggered unconditionally.

The original debug print looked as follows, which puts the layout print
between DRAM: size announcement (1) and duplicate DRAM: size print (2),
does not skip empty banks (3), and does not print DRAM bank end (4).

"
Model: Renesas Ironhide board based on r8a78000
DRAM:  <----------------------------------------------------------- (1)
RAM Configuration:
Bank #0: 1080000000 2 GiB
Bank #1: 1200000000 4 GiB <---------------------------------------- (4)
...
Bank #8: 40000000 2 GiB
Bank #9: 0 0 Bytes <----------------------------------------------- (3)
...
Bank #15: 0 0 Bytes

DRAM:  2 GiB (total 32 GiB) <-------------------------------------- (2)
Core:  68 devices, 26 uclasses, devicetree: separate
"

The new debug print and optionally verbose print looks as follows, the
duplicate DRAM: prefix is removed (1), the layout is printed after the
DRAM size print (3), the DRAM end address is printed (3) and there are
no more empty banks printed (4):

"
Model: Renesas Ironhide board based on r8a78000
DRAM:  2 GiB (total 32 GiB) <-------------------------------------- (1)
RAM Configuration: <----------------------------------------------- (2)
Bank #0: 0x1080000000 - 0x10ffffffff, 2 GiB <---------------------- (4)
Bank #1: 0x1200000000 - 0x12ffffffff, 4 GiB
Bank #2: 0x1400000000 - 0x14ffffffff, 4 GiB
Bank #3: 0x1600000000 - 0x16ffffffff, 4 GiB
Bank #4: 0x1800000000 - 0x18ffffffff, 4 GiB
Bank #5: 0x1a00000000 - 0x1affffffff, 4 GiB
Bank #6: 0x1c00000000 - 0x1cffffffff, 4 GiB
Bank #7: 0x1e00000000 - 0x1effffffff, 4 GiB
Bank #8: 0x40000000 - 0xbfffffff, 2 GiB <-------------------------- (3)
Core:  68 devices, 26 uclasses, devicetree: separate
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 common/Kconfig   |  6 ++++++
 common/board_f.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 345be4b8ca1..869493c979d 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -615,6 +615,12 @@ config DISPLAY_BOARDINFO_LATE
 	  the relocation phase. The board function checkboard() is called to do
 	  this.
 
+config DISPLAY_DRAM_CONFIG_VERBOSE
+	bool "Display additional information about DRAM layout"
+	help
+	  Display additional information about the board DRAM layout, including
+	  each bank start address, end address and size.
+
 menu "Start-up hooks"
 
 config CYCLIC
diff --git a/common/board_f.c b/common/board_f.c
index 9efcd9499a9..f886774e82b 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -217,21 +217,34 @@ static int sizes_near(unsigned long long size1, unsigned long long size2)
 	return size1_scale == size2_scale && size1_val == size2_val;
 }
 
+static void show_dram_config_verbose(void)
+{
+	int i;
+
+#ifndef DEBUG
+	if (!CONFIG_IS_ENABLED(DISPLAY_DRAM_CONFIG_VERBOSE))
+		return;
+#endif
+
+	printf("RAM Configuration:\n");
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		if (!gd->dram[i].size)
+			break;
+
+		printf("Bank #%d: 0x%llx - 0x%llx, ", i,
+		       (unsigned long long)(gd->dram[i].start),
+		       (unsigned long long)(gd->dram[i].start + gd->dram[i].size - 1));
+		print_size(gd->dram[i].size, "\n");
+	}
+}
+
 static int show_dram_config(void)
 {
 	unsigned long long size;
 	int i;
 
-	debug("\nRAM Configuration:\n");
-	for (i = size = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+	for (i = size = 0; i < CONFIG_NR_DRAM_BANKS; i++)
 		size += gd->dram[i].size;
-		debug("Bank #%d: %llx ", i,
-		      (unsigned long long)(gd->dram[i].start));
-#ifdef DEBUG
-		print_size(gd->dram[i].size, "\n");
-#endif
-	}
-	debug("\nDRAM:  ");
 
 	print_size(gd->ram_size, "");
 	if (!sizes_near(gd->ram_size, size)) {
@@ -241,6 +254,8 @@ static int show_dram_config(void)
 	board_add_ram_info(0);
 	putc('\n');
 
+	show_dram_config_verbose();
+
 	return 0;
 }
 
-- 
2.53.0

