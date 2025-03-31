Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B287C36013
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 07:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412F181F00;
	Mon, 31 Mar 2025 09:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t6mDvFOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38A881EBB; Mon, 31 Mar 2025 09:24:27 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7CF2817C4
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-051.46.114.pool.telefonica.de
 [46.114.110.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C448B3FFC9; 
 Mon, 31 Mar 2025 07:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743405862;
 bh=OXo5qVVyfYJSlY7Yftz+LjfJH1eZM+Vo0g0j3e9UmZ4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=t6mDvFOej3W1rrv00jP7geddajdQWyepvpeAYlrS9BfiDeb9u3dcE6rMBCD+F8J5c
 fqCOSxyQUAB5Y/slwUlSMk1vJpgctzhHTD00q8ZCCIwxCgUtpJoCqM03qqZ7C+sZYW
 cKDp1ioFLPGiriBOdwPO3GXRK6JPhtaFZdM1t1p+GqCUBlmdtL5geZH+aJk81v+kKA
 FKDYt2d6Dgn7AGMzjGA27HRLb0n7sNOrGMcika+AdJaf/gdi5ts5AsippwioPq8cEG
 lRe9TtuL3oWmmDX8HRa1eBySwTTa6H5TReqWo3H7qgrBK9cpbcPkARoF4LX1Hsq0ht
 2GSOZ1GYnP89g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, E Shattow <lucent@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/8] board: starfive: DeepComputing FML13V01 fdt selection
Date: Mon, 31 Mar 2025 09:24:05 +0200
Message-ID: <20250331072410.8662-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
References: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
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

We support all JH7110 boards with starfive_visionfive2_defconfig.
The relevant device-tree is selected at runtime based on EEPROM data.

Support setting $fdtfile to the file name of the DeepComputing Framework
motherboard (FML13V01) device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
v2:
	no change
---
 board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 3940d45b13f..55daf730c81 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -17,6 +17,8 @@
 DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
+#define FDTFILE_FML13V01 \
+	"starfive/jh7110-deepcomputing-fml13v01.dtb"
 #define FDTFILE_MILK_V_MARS \
 	"starfive/jh7110-milkv-mars.dtb"
 #define FDTFILE_MILK_V_MARS_CM \
@@ -67,7 +69,9 @@ static void set_fdtfile(void)
 		log_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARC", 4)) {
+	if (!strncmp(product_id, "FML13V01", 8)) {
+		fdtfile = FDTFILE_FML13V01;
+	} else if (!strncmp(product_id, "MARC", 4)) {
 		if (get_mmc_size_from_eeprom())
 			fdtfile = FDTFILE_MILK_V_MARS_CM;
 		else
-- 
2.48.1

