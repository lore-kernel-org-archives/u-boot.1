Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B34C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 160A78845E;
	Thu,  6 Jun 2024 18:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="fokaLqz2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 332CE883F5; Thu,  6 Jun 2024 18:33:38 +0200 (CEST)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B5BB88216
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPSA id 95B8D1C2B71;
 Thu,  6 Jun 2024 18:33:32 +0200 (CEST)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1717691612; bh=kv2fe1BnI969CD2T9rWUY7or/DGE9g7eXWA4TS/75kY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=fokaLqz2nr+O1zveifi21QPpXeQ4hl5rartLe+dd2bRArWiDjbQ3KsVGMEuVT4+vv
 Vt1PT09Dv+3163D4+l2hv9Vs+bfOkp5Hwb6eX1iGSUH8eHpWBUzYIvZThErTRGlR/J
 uL/CC0lcb3WHTAGcVPBKwCO2zwb8R+P6dFdL5Nds=
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: u-boot@lists.denx.de
Cc: kabel@kernel.org,
	marek.mojik@nic.cz
Subject: [PATCH 2/6] board: freescale: p1_p2_rdb_pc: Add weak function
 p1_p2_rdb_pc_fix_fdt_model() for fixing DT model string
Date: Thu,  6 Jun 2024 18:33:22 +0200
Message-ID: <20240606163326.386950-3-marek.mojik@nic.cz>
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
X-Rspamd-Queue-Id: 95B8D1C2B71
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

This allows boards to fixup / overwrite DT model string when booting OS.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
---
 board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
index 399ff72072..336d274cdb 100644
--- a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
+++ b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
@@ -364,6 +364,8 @@ int board_early_init_r(void)
 	return 0;
 }
 
+__weak void p1_p2_rdb_pc_fix_fdt_model(void *blob) {}
+
 #if defined(CONFIG_OF_BOARD_SETUP) || defined(CONFIG_OF_BOARD_FIXUP)
 static void fix_max6370_watchdog(void *blob)
 {
@@ -407,6 +409,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 			sizeof("okay"), 0);
 #endif
 
+	p1_p2_rdb_pc_fix_fdt_model(blob);
 	fix_max6370_watchdog(blob);
 
 #if defined(CONFIG_HAS_FSL_DR_USB)
@@ -464,6 +467,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #ifdef CONFIG_OF_BOARD_FIXUP
 int board_fix_fdt(void *blob)
 {
+	p1_p2_rdb_pc_fix_fdt_model(blob);
 	fix_max6370_watchdog(blob);
 	return 0;
 }
-- 
2.45.1

