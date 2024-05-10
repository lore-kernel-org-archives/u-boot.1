Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A641BC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 05:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7A48884C;
	Fri, 10 May 2024 07:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pKgHdk+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991C088719; Fri, 10 May 2024 07:52:46 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F5388176
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 07:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9302B40819; 
 Fri, 10 May 2024 05:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715320361;
 bh=AboStmdkWG28z01kFWLqmL5kZ3GjzxeVNnSwOp1zM7o=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=pKgHdk+4rTs1nxdZYoXwU6FSWDvYCaruFI3GoPYKHWk8oU5n1BO+tiMxqvnrh4onf
 ZvV6mh/P1PYfwdy9R00t8HElWiftdO/cDloBurIbU8yfAufBIXp6jasLUp0Veh8zxE
 GBUCZNHQlJ7GDyPUb/jtlpijy7WGrycoQV3jYuGN7eKlDcpZfXvpAFrAp3cRL+4VoE
 3AMJpCSxYrZrfs64cxAPOuLpqBl/Hv8GcUzQE4S1xcI1t/XpdEdQusm2T1TBfhO1W3
 5vdL0GfCAlBxy8fUiJhBcuoUxKjcCdD5FJyuhlFhh4s8dXfoSjElcvG1ziaFczp6V3
 ti1qoYt/muAIA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 2/5] board: add support for Milk-V Mars CM
Date: Fri, 10 May 2024 07:52:18 +0200
Message-ID: <20240510055223.11617-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
References: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
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

We already support the VisionFive 2 and the Milk-V Mars board by
patching the VisionFive 2 device tree. With this patch the same
is done for the Milk-V Mars CM.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Tested-by: E. Shattow <lucent@gmail.com>
Reviewed-by: E. Shattow <lucent@gmail.com>
---
v4:
	no change
v3:
	no change
v2:
	rename spl_fdt_fixup_marc() to spl_fdt_fixup_mars_cm()
	rename device-trees for Mars CM and Mars CM Lite
	change model and compatible properties
---
 board/starfive/visionfive2/spl.c              | 28 ++++++++++++++++++-
 .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index ca61b5be227..b555189556a 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -129,6 +129,30 @@ void spl_fdt_fixup_mars(void *fdt)
 	}
 }
 
+void spl_fdt_fixup_mars_cm(void *fdt)
+{
+	const char *compat;
+	const char *model;
+
+	spl_fdt_fixup_mars(fdt);
+
+	if (!get_mmc_size_from_eeprom()) {
+		int offset;
+
+		model = "Milk-V Mars CM Lite";
+		compat = "milkv,mars-cm-lite\0starfive,jh7110";
+
+		offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
+		/* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE) */
+		fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
+	} else {
+		model = "Milk-V Mars CM";
+		compat = "milkv,mars-cm\0starfive,jh7110";
+	}
+	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
+	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
+}
+
 void spl_fdt_fixup_version_a(void *fdt)
 {
 	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
@@ -236,7 +260,9 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 		pr_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARS", 4)) {
+	if (!strncmp(product_id, "MARC", 4)) {
+		spl_fdt_fixup_mars_cm(spl_image->fdt_addr);
+	} else if (!strncmp(product_id, "MARS", 4)) {
 		spl_fdt_fixup_mars(spl_image->fdt_addr);
 	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index a86bca533b2..6be53489626 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
 #define FDTFILE_MILK_V_MARS \
 	"starfive/jh7110-milkv-mars.dtb"
+#define FDTFILE_MILK_V_MARS_CM \
+	"starfive/jh7110-milkv-mars-cm.dtb"
+#define FDTFILE_MILK_V_MARS_CM_LITE \
+	"starfive/jh7110-milkv-mars-cm-lite.dtb"
 #define FDTFILE_VISIONFIVE2_1_2A \
 	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
 #define FDTFILE_VISIONFIVE2_1_3B \
@@ -61,7 +65,12 @@ static void set_fdtfile(void)
 		log_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARS", 4)) {
+	if (!strncmp(product_id, "MARC", 4)) {
+		if (get_mmc_size_from_eeprom())
+			fdtfile = FDTFILE_MILK_V_MARS_CM;
+		else
+			fdtfile = FDTFILE_MILK_V_MARS_CM_LITE;
+	} else if (!strncmp(product_id, "MARS", 4)) {
 		fdtfile = FDTFILE_MILK_V_MARS;
 	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
-- 
2.43.0

