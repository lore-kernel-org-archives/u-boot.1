Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F395ACD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 10:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DF9839D5;
	Sun, 16 Nov 2025 11:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ORZnxHZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7FE2839D7; Sun, 16 Nov 2025 11:39:42 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88ABD8399B
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 11:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C93E63FB67; 
 Sun, 16 Nov 2025 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763289579;
 bh=IW6mF7W65CX7fiZKePhNrK+/T98YCJNZchwcaXa0Xb0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ORZnxHZdeehrawo6Rz75YOjjkIPJ8JUS9vB67OT0rFhvtzqtJw4HrBBToIYyXn5Zu
 qG+f7Nxd2JEUY9hqV+Q5v7gm/Dc/B3ZTA1m18yaqrgSXOASPIqbbFVSoaQPHBedBvR
 e35jOKivNVx3KhCgU7vLmmAlBePlGIenzjdmbE/T9U2y5coWjKPkY4Vs55ZF1+hSiE
 SvG/+k1rC5LT6O/hGzqTDPsdAq0Cg8D4+PMQ0dNgh4XL/KQnmAd7T+HxYBPP4XQOdW
 aBqvGOuCXR2VSbF9VCEslPbgVy09lSITELuhsT0Ou7jkGlMyd1t+4v0Wk9oKJzpsT1
 HiBt0V3Ec0PJNkqk265EtLytNlzNflFTjGgJkeZkoqeH7PT50QJAlIRdDecM2GFBBk
 dEw8/dNA7uotS8iAXlNZgzuqqg0y198xKm19m80dfrUhv/DBRoi7C+jGboJADCaI0W
 XEMrfhLYGtMsxBaK9gQuo3fSbIGOg4OX2eiiUTV1hsCnQMbvciO5WgSQZEZdMUd8gy
 h2QvTgeKxdFJ6x2Q0W3+RHUITn2bT9DVtww8ve70qesvZFiCN7irQb/EsU90krSgf6
 esq8m66TPLP0qpN1YgZ0qfH0P/aQAHN/UOrJsCEW++hDViTXPWO54al1UW0DmmXLrS
 lFIrOS9pqYjYR62QFpoNhps0=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: smbios: correct output for table type 4
Date: Sun, 16 Nov 2025 11:39:34 +0100
Message-ID: <20251116103934.63668-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

In the QFW case the SMBIOS specification version is controlled by QEMU.
Field 'Thread Enable' is not available before SMBIOS v3.6.

We should not print the core, core enabled, and thread counts twice.
Use the appropriate based on the SMBIOS version.
Use decimal output which is easier to read for humans.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/smbios.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 671c14e05b5..f9a352c107d 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -262,6 +262,8 @@ static const struct str_lookup_table md_tech_strings[] = {
 	{ SMBIOS_MD_TECH_OPTANE,	"Intel Optane persistent memory" },
 };
 
+static u16 smbios_version;
+
 /**
  * smbios_get_string() - get SMBIOS string from table
  *
@@ -504,18 +506,23 @@ static void smbios_print_type4(struct smbios_type4 *table)
 	smbios_print_str("Serial Number", table, table->serial_number);
 	smbios_print_str("Asset Tag", table, table->asset_tag);
 	smbios_print_str("Part Number", table, table->part_number);
-	printf("\tCore Count: 0x%02x\n", table->core_count);
-	printf("\tCore Enabled: 0x%02x\n", table->core_enabled);
-	printf("\tThread Count: 0x%02x\n", table->thread_count);
+	if (smbios_version < 0x0300) {
+		printf("\tCore Count: %d\n", table->core_count);
+		printf("\tCore Enabled: %d\n", table->core_enabled);
+		printf("\tThread Count: %d\n", table->thread_count);
+	} else {
+		printf("\tCore Count: %d\n", table->core_count2);
+		printf("\tCore Enabled: %d\n", table->core_enabled2);
+		printf("\tThread Count: %d\n", table->thread_count2);
+	}
 	printf("\tProcessor Characteristics: 0x%04x\n",
 	       table->processor_characteristics);
 	smbios_print_lookup_str(processor_family_strings,
 				table->processor_family2,
 				ARRAY_SIZE(processor_family_strings),
 				"Processor Family 2");
-	printf("\tCore Count 2: 0x%04x\n", table->core_count2);
-	printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
-	printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
+	if (smbios_version < 0x0306)
+		return;
 	printf("\tThread Enabled: 0x%04x\n", table->thread_enabled);
 }
 
@@ -719,6 +726,8 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 		struct smbios3_entry *entry3 = entry;
 
 		table = (void *)(uintptr_t)entry3->struct_table_address;
+		smbios_version = ((u16)entry3->major_ver << 16) +
+				 (u16)entry3->minor_ver;
 		snprintf(version, sizeof(version), "%d.%d.%d",
 			 entry3->major_ver, entry3->minor_ver, entry3->doc_rev);
 		table = (void *)(uintptr_t)entry3->struct_table_address;
-- 
2.51.0

