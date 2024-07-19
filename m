Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6812DC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 23:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4529588418;
	Sat, 20 Jul 2024 01:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pEZaL8BX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FBE08845A; Sat, 20 Jul 2024 01:12:09 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E09A883BA
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 01:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-093-080.um16.pools.vodafone-ip.de
 [62.143.93.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4AD803F385; 
 Fri, 19 Jul 2024 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721430723;
 bh=s0/o5bObUJ2ynRsgsx/IAcB3eohKOmd8yjDzS1WYzss=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pEZaL8BXMq4MNfgt2I8Hzppom93gd+KukoP2SzQz8KEBajjWVNlgOZJfKVFrGZIzP
 n3J59wyNPOj1ZAhKP3y757rUYjGdAcN1Mz858r1Rz1Cz1sTOEdemI4oVpveXbcMblA
 Erv+mpQx9TzFFGK7YTKV8KqnW84LKzh9/4vPKLYUJeeUj1pwNdZiumQ5qEyhr615MX
 SFwrVvQ1E0+9Q89RjVR8xpGUBA2us2cehkOyGnlI7lxMjwavkTaHB6y8gNK2FtRTlU
 6z3yCL87528DpG/bpsi1XGIjKT83I66wzP4j8+Zr3hPOgOgYD+9F7/zD3hemlz+xQT
 6Z2XZ6nmK98fg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, E Shattow <lucent@gmail.com>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Aurelien Jarno <aurelien@aurel32.net>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] board: fix compatible property Milk-V Mars CM
Date: Sat, 20 Jul 2024 01:11:58 +0200
Message-ID: <20240719231158.50416-1-heinrich.schuchardt@canonical.com>
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

For the Milk-V Mars CM (lite) we have only been copying sizeof(void *)
bytes to the compatible property instead of the whole string list.

Fixes: de3229599d4f ("board: add support for Milk-V Mars CM")
Reported-by: E Shattow <lucent@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/spl.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index b794b73b6bd..f55c6b5d34c 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -170,23 +170,32 @@ void spl_fdt_fixup_mars_cm(void *fdt)
 {
 	const char *compat;
 	const char *model;
+	int compat_size;
 
 	spl_fdt_fixup_mars(fdt);
 
 	if (!get_mmc_size_from_eeprom()) {
 		int offset;
+		static const char
+		compat_cm_lite[] = "milkv,mars-cm-lite\0starfive,jh7110";
 
 		model = "Milk-V Mars CM Lite";
-		compat = "milkv,mars-cm-lite\0starfive,jh7110";
+		compat = compat_cm_lite;
+		compat_size = sizeof(compat_cm_lite);
 
 		offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
 		/* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE) */
 		fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
 	} else {
+		static const char
+		compat_cm[] = "milkv,mars-cm\0starfive,jh7110";
+
 		model = "Milk-V Mars CM";
-		compat = "milkv,mars-cm\0starfive,jh7110";
+		compat = compat_cm;
+		compat_size = sizeof(compat_cm);
 	}
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
+	fdt_setprop(fdt, fdt_path_offset(fdt, "/"),
+		    "compatible", compat, compat_size);
 	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
 }
 
-- 
2.45.2

