Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9453BC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E31F834DC;
	Wed,  9 Apr 2025 09:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jEHyzvtX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E53831D5; Wed,  9 Apr 2025 09:18:53 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F79D83121
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-207.46.114.pool.telefonica.de
 [46.114.104.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DAE7341484; 
 Wed,  9 Apr 2025 07:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744183128;
 bh=eq0Qie9hPCjLLGQB2OYho62UY6RWDJNbejmUDw3D1o8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=jEHyzvtXxrqt6Dc0bQknkxK7Ye71ZUhm/lBoQYFT7NWGlYmZI+omBGbrkqpvuBGrR
 YHbztyfxaI3Eu7IeGDFw9YB57Fx75iJL/1BI5NdZECTw9INI0LN587nguWjbgSfMgM
 5MYe/rsUDZqFUA9qw/rxHGGKmjrVZ37H208najBDo9OpDCf+GH3QFSxXdNB5eaLEsl
 0Dv2oKVkoQA4nSQPOR3jGa/Y3wXmTdiAXYnT4tUaIHb4BJeZUP0IELsWNFJ7swDjtd
 STens8/HCyxtcQIJ0cTQg+E/PeBJv+O8GL/O1U3Yc6Af93Sa5wanoV7fS+rg5PPUsG
 UCyyt76PdNIfQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 3/8] board: starfive: DeepComputing FML13V01 fdt selection
Date: Wed,  9 Apr 2025 09:18:30 +0200
Message-ID: <20250409071836.26629-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
References: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
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
v3:
	rebased upon Mars CM removal patch
v2:
	no change
---
 board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index b8cd509bc89..5fe888d4072 100644
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
 #define FDTFILE_VISIONFIVE2_1_2A \
@@ -63,7 +65,9 @@ static void set_fdtfile(void)
 		log_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARS", 4)) {
+	if (!strncmp(product_id, "FML13V01", 8)) {
+		fdtfile = FDTFILE_FML13V01;
+	} else if (!strncmp(product_id, "MARS", 4)) {
 		fdtfile = FDTFILE_MILK_V_MARS;
 	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
-- 
2.48.1

