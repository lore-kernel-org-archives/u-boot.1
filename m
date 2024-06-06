Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF06C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE14883CE;
	Thu,  6 Jun 2024 18:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="WysdrwsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFE388459; Thu,  6 Jun 2024 18:33:38 +0200 (CEST)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9643A883F5
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPSA id 1821B1C2B73;
 Thu,  6 Jun 2024 18:33:33 +0200 (CEST)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1717691613; bh=iOwaHJej/A7YWouo+54t/25nUL4G3h7pp0qfHZSSyJ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=WysdrwsUO8PwNa/gghAYsAUjZM0/2tRyR3I1O+0Y9yusAWqcLy2zxsCayQaNz5oZI
 nWsv3x6O+6v2fHRoy2j4lP5uakSXtBo7FMLjxFdVMTSTzs4IxQOP6JJ/Unf9eHbkfo
 MCv7lJkp+FiFnG2Xtpu/3CeGWBxRcAnPYZCVX+eU=
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: u-boot@lists.denx.de
Cc: kabel@kernel.org,
	marek.mojik@nic.cz
Subject: [PATCH 4/6] powerpc: mpc85xx: use CONFIG_VAL() for SYS_MONITOR_BASE
 in start.s
Date: Thu,  6 Jun 2024 18:33:24 +0200
Message-ID: <20240606163326.386950-5-marek.mojik@nic.cz>
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
X-Rspamd-Queue-Id: 1821B1C2B73
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

Use CONFIG_VAL() for SYS_MONITOR_BASE in start.S so that correct value
is used for SPL.

Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
---
 arch/powerpc/cpu/mpc85xx/start.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc85xx/start.S b/arch/powerpc/cpu/mpc85xx/start.S
index b737d5d12f..3e24a90233 100644
--- a/arch/powerpc/cpu/mpc85xx/start.S
+++ b/arch/powerpc/cpu/mpc85xx/start.S
@@ -116,7 +116,7 @@ bootsect:
 	.long (CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR_START + CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR_DATA) * 512
 
 	.org 0x58 /* Target address in the system's local memory address space */
-	.long CONFIG_SYS_MONITOR_BASE
+	.long CONFIG_VAL(SYS_MONITOR_BASE)
 
 	.org 0x60 /* Execution starting address */
 	.long _start
-- 
2.45.1

