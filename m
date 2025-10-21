Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9A5CCD1AB
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 23:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0078334F;
	Wed, 22 Oct 2025 01:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4654E80077; Wed, 22 Oct 2025 01:11:41 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AE9083303
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 01:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C8314B220109;
 Wed, 22 Oct 2025 01:11:37 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2 1/3] board: starfive: visionfive2: Add Milk-V Mars CM and
 Mars CM Lite selection by product_id
Date: Tue, 21 Oct 2025 16:09:58 -0700
Message-ID: <20251021231021.196336-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251021231021.196336-1-e@freeshell.de>
References: <20251021231021.196336-1-e@freeshell.de>
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

Add identifier for Milk-V Mars CM to dts selection callback in SPL, and
to fdtfile environment variable default value selection in payload.

Signed-off-by: E Shattow <e@freeshell.de>
---
 board/starfive/visionfive2/spl.c                  | 8 ++++++++
 board/starfive/visionfive2/starfive_visionfive2.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 420a8cf8d91..5047292a0fa 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -123,6 +123,14 @@ int board_fit_config_name_match(const char *name)
 	} else if (!strcmp(name, "starfive/jh7110-milkv-mars") &&
 		    !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
 		return 0;
+	} else if (!strcmp(name, "starfive/jh7110-milkv-marscm-emmc") &&
+		    !strncmp(get_product_id_from_eeprom(), "MARC", 4) &&
+		    get_mmc_size_from_eeprom()) {
+		return 0;
+	} else if (!strcmp(name, "starfive/jh7110-milkv-marscm-lite") &&
+		    !strncmp(get_product_id_from_eeprom(), "MARC", 4) &&
+		    !get_mmc_size_from_eeprom()) {
+		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-pine64-star64") &&
 		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		return 0;
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 6271974b9c7..6c39fd4af35 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -57,6 +57,12 @@ static void set_fdtfile(void)
 		fdtfile = "starfive/jh7110-deepcomputing-fml13v01.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
 		fdtfile = "starfive/jh7110-milkv-mars.dtb";
+	} else if (!strncmp(get_product_id_from_eeprom(), "MARC", 4)) {
+		if (get_mmc_size_from_eeprom()) {
+			fdtfile = "starfive/jh7110-milkv-marscm-emmc.dtb";
+		} else {
+			fdtfile = "starfive/jh7110-milkv-marscm-lite.dtb";
+		}
 	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		fdtfile = "starfive/jh7110-pine64-star64.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7)) {
-- 
2.50.0

