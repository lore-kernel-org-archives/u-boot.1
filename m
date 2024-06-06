Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E44C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0508843A;
	Thu,  6 Jun 2024 18:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="Qa2rldbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B0F8842C; Thu,  6 Jun 2024 18:33:38 +0200 (CEST)
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5655881A1
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPSA id ED2F81C2B6F;
 Thu,  6 Jun 2024 18:33:31 +0200 (CEST)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1717691612; bh=jb8yTDYohv2xvVfRAf/gQCzX6zGB3ke3cCPio8ZqA9I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=Qa2rldbsp9NhbgkNfwkkNNAKDGGXj5sCNYslsVtMUSe19cSLRqXxPvaz+Che0h58C
 3Ws03XQR900m+YB8om9CWBAG4WUX2Y7t+hjDOglYHtq2bBKdnm78uFrKwaq40usfql
 p0LVki+u3uVByZISDGFdmlLzwtz0GnHc6V9pjyiM=
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: u-boot@lists.denx.de
Cc: kabel@kernel.org,
	marek.mojik@nic.cz
Subject: [PATCH 1/6] board_f: Add support for CONFIG_OF_BOARD_FIXUP for XIP
 images
Date: Thu,  6 Jun 2024 18:33:21 +0200
Message-ID: <20240606163326.386950-2-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606163326.386950-1-marek.mojik@nic.cz>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.10 / 20.00]; REPLY(-4.00)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:592e:6672:3345:e2e0];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: ED2F81C2B6F
X-Spamd-Bar: ----
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
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

From: Pali Rohár <pali@kernel.org>

When U-Boot is running from flash memory (execute in place) then
gd->fdt_blob before relocation points to read-only flash memory.

So U-Boot calls board_fix_fdt() with read-only gd->fdt_blob pointer which
cause immediate CPU crash when callback is trying to modify gd->fdt_blob.

Fix this issue by introducing a new config option OF_INITIAL_DTB_READONLY
which moves fix_fdt callback after the reloc_fdt callback. This makes
CONFIG_OF_BOARD_FIXUP working also if U-Boot before relocation is not
running from read/write (S)RAM memory.

This is required for mpc85xx boards when booting from flash NOR.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
---
 common/board_f.c | 8 +++++++-
 dts/Kconfig      | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 212ffb3090..22c180b218 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -949,7 +949,7 @@ static const init_fnc_t init_sequence_f[] = {
 	 *  - board info struct
 	 */
 	setup_dest_addr,
-#ifdef CONFIG_OF_BOARD_FIXUP
+#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_READONLY)
 	fix_fdt,
 #endif
 #ifdef CFG_PRAM
@@ -965,6 +965,10 @@ static const init_fnc_t init_sequence_f[] = {
 	reserve_board,
 	reserve_global_data,
 	reserve_fdt,
+#if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READONLY)
+	reloc_fdt,
+	fix_fdt,
+#endif
 	reserve_bootstage,
 	reserve_bloblist,
 	reserve_arch,
@@ -975,7 +979,9 @@ static const init_fnc_t init_sequence_f[] = {
 	setup_bdinfo,
 	display_new_sp,
 	INIT_FUNC_WATCHDOG_RESET
+#if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_READONLY)
 	reloc_fdt,
+#endif
 	reloc_bootstage,
 	reloc_bloblist,
 	setup_reloc,
diff --git a/dts/Kconfig b/dts/Kconfig
index 6883a000a0..569d4be338 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -145,6 +145,12 @@ config OF_EMBED
 
 endchoice
 
+config OF_INITIAL_DTB_READONLY
+	bool "Initial DTB for DT control is read-only"
+	help
+	  If initial DTB for DT control is read-only (e.g. points to
+	  memory-mapped flash memory), then set this option.
+
 config OF_BOARD
 	bool "Provided by the board (e.g a previous loader) at runtime"
 	default y if SANDBOX || OF_HAS_PRIOR_STAGE
-- 
2.45.1

