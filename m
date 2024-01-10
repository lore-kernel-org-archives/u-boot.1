Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899CFC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 20:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758EE8771B;
	Wed, 10 Jan 2024 21:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=aurel32.net header.i=@aurel32.net header.b="wznFYjUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC3087867; Wed, 10 Jan 2024 21:18:07 +0100 (CET)
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5CE9876F6
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 21:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aurelien@aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
 Content-Description:In-Reply-To:References:X-Debbugs-Cc;
 bh=ip667LqygBAhpEX405JmcHqcXJBH2kxzbksIVM3Fw+M=; b=wznFYjUTiXzvC/+lhjiDMgp59E
 54+U9zJjqJLR2LlpsQm8+LnseAQUlFOeI1dxwaxm8Ss3J+6TDsNcHa6rTMw4o2G7LdlZlh7Fk+cSA
 rrazTkj8+ffd6wb4okbaKyVDGHbqmJwlkKyA7AeNQR2GxjrOFbqPH6B4btlTHmDZ2ui6cKkwYgGcQ
 EVL95Xkut2n1XUMuByeava8uNaJoAonrqitey6wwf4sCw9yuLKnApGXiABLC31CYx0yH7ZFYBGBS7
 rM7ZMKpmTdxt8dN6F9eX54665PpA8jQU83grvRQbXoARgaph/c7cTz+KUoTC2hYpkmTcI3vMjz65d
 6HFLybsw==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <aurelien@aurel32.net>) id 1rNf1W-00DG74-2z;
 Wed, 10 Jan 2024 21:18:02 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: u-boot@lists.denx.de
Cc: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] board: starfive: handle compatible property in dynamic DT
 configuration
Date: Wed, 10 Jan 2024 21:17:44 +0100
Message-ID: <20240110201757.983435-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Jan 2024 21:51:41 +0100
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

The difference between the StarFive VisionFive 2 1.2A and 1.3B boards is
handled dynamically by looking at the PCB version in the EEPROM in order
to have a single u-boot version for both versions of the board. While
the "model" property is correctly handled, the "compatible" one is
always the the one of version 1.3b.

This patch add support for dynamically configuring that property.

Fixes: 9b7060bd15e7 ("riscv: dts: jh7110: Combine the board device tree files of 1.2A and 1.3B")

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 board/starfive/visionfive2/spl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 336f0cdfc9..911add429d 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -61,11 +61,13 @@ static const struct starfive_vf2_pro starfive_verb[] = {
 
 void spl_fdt_fixup_version_a(void *fdt)
 {
+	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
 	u32 phandle;
 	u8 i;
 	int offset;
 	int ret;
 
+	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
 	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
 			   "StarFive VisionFive 2 v1.2A");
 
@@ -106,11 +108,13 @@ void spl_fdt_fixup_version_a(void *fdt)
 
 void spl_fdt_fixup_version_b(void *fdt)
 {
+	static const char compat[] = "starfive,visionfive-2-v1.3b\0starfive,jh7110";
 	u32 phandle;
 	u8 i;
 	int offset;
 	int ret;
 
+	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
 	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
 			   "StarFive VisionFive 2 v1.3B");
 
-- 
2.42.0

