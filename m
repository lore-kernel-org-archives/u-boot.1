Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A40CC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA6B88422;
	Tue, 18 Jun 2024 17:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aW8O2oKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BBE88422; Tue, 18 Jun 2024 17:35:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D0B8840E
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 82991618BC;
 Tue, 18 Jun 2024 15:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACBAC4AF1C;
 Tue, 18 Jun 2024 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724898;
 bh=FQNCbXfLDMVM6k4shY+rW+zJ3n3uupp5ct3DLUSUdUY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aW8O2oKm2FHaNM0Bn4TyJP2YaZIBKV+jzru1TnFARQ0iyMCbouXpSk+udRzSjqceb
 jDisu3KYx2S8GWBRh6MsPzpu5bDS24vCPzvsh7dyuxxqjQ0IR1hJbU7HuDc/vTjGEP
 AsmlNKy/1MMFss6eWEoLGStvmXxPWsMWpW0jWF6uNTkmlRyIgqsJHL5zgz1VbVllkt
 w2zsZxGGW7b5bvflIwViyXtLLaXq96LPAX1p2ff3e8N3yuqZYJCDy+LGkbxUH0DUyP
 yXh2OVTx7yeq1miOD87dfYdgtOdOjT/lSybiXuJJ9pQzvos6S4oKvU48cYIaH08g4n
 zlq+P7iE+d4WQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 11/16] arm: mvebu: turris_omnia: Read DDR speed
 from EEPROM
Date: Tue, 18 Jun 2024 17:34:34 +0200
Message-ID: <20240618153439.9518-12-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
References: <20240618153439.9518-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Some Turris Omnia boards experience memory issues, and by
experimentation we found that some of these issues can be solved by
slowing DDR speed.

Add a new field in the extended EEPROM information structure, ddr_speed.
Support several values in this field (for now 1066F, 1333H, and the
default, 1600K) and use it to overwrite the DDR topology parameters
used by the DDR training algorithm.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/eeprom.c       | 41 +++++++++-
 board/CZ.NIC/turris_omnia/turris_omnia.c | 99 +++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/board/CZ.NIC/turris_omnia/eeprom.c b/board/CZ.NIC/turris_omnia/eeprom.c
index ea13e95b37..32572481ce 100644
--- a/board/CZ.NIC/turris_omnia/eeprom.c
+++ b/board/CZ.NIC/turris_omnia/eeprom.c
@@ -55,12 +55,49 @@ static int eeprom_field_update_region(struct eeprom_field *field, char *value)
 	return 0;
 }
 
+static void eeprom_field_print_ddr_speed(const struct eeprom_field *field)
+{
+	printf(PRINT_FIELD_SEGMENT, field->name);
+
+	if (field->buf[0] == '\0' || field->buf[0] == 0xff)
+		puts("(empty, defaults to 1600K)\n");
+	else
+		printf("%.5s\n", field->buf);
+}
+
+bool omnia_valid_ddr_speed(const char *name);
+void omnia_print_ddr_speeds(void);
+
+static int eeprom_field_update_ddr_speed(struct eeprom_field *field,
+					 char *value)
+{
+	if (value[0] == '\0') {
+		/* setting default value */
+		memset(field->buf, 0xff, field->size);
+
+		return 0;
+	}
+
+	if (!omnia_valid_ddr_speed(value)) {
+		printf("%s: invalid setting, supported values are:\n  ",
+		       field->name);
+		omnia_print_ddr_speeds();
+
+		return -1;
+	}
+
+	strncpy(field->buf, value, field->size);
+
+	return 0;
+}
+
 static struct eeprom_field omnia_layout[] = {
 	_DEF_FIELD("Magic constant", 4, bin),
 	_DEF_FIELD("RAM size in GB", 4, ramsz),
 	_DEF_FIELD("Wi-Fi Region", 4, region),
 	_DEF_FIELD("CRC32 checksum", 4, bin),
-	_DEF_FIELD("Extended reserved fields", 44, reserved),
+	_DEF_FIELD("DDR speed", 5, ddr_speed),
+	_DEF_FIELD("Extended reserved fields", 39, reserved),
 	_DEF_FIELD("Extended CRC32 checksum", 4, bin),
 };
 
@@ -96,7 +133,7 @@ static int omnia_update_field(struct eeprom_layout *layout, char *field_name,
 	}
 
 	if (field < ext_crc_field) {
-		u32 crc = crc32(0, layout->data, 44);
+		u32 crc = crc32(0, layout->data, 60);
 		put_unaligned_le32(crc, ext_crc_field->buf);
 	}
 
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index c2f91b762f..544784e860 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -431,7 +431,8 @@ struct omnia_eeprom {
 	u32 crc;
 
 	/* second part (only considered if crc2 is not all-ones) */
-	u8 reserved[44];
+	char ddr_speed[5];
+	u8 reserved[39];
 	u32 crc2;
 };
 
@@ -520,6 +521,26 @@ static int omnia_get_ram_size_gb(void)
 	return ram_size;
 }
 
+static const char *omnia_get_ddr_speed(void)
+{
+	struct omnia_eeprom oep;
+	static char speed[sizeof(oep.ddr_speed) + 1];
+
+	if (!omnia_read_eeprom(&oep))
+		return NULL;
+
+	if (!is_omnia_eeprom_second_part_valid(&oep))
+		return NULL;
+
+	if (!oep.ddr_speed[0] || oep.ddr_speed[0] == 0xff)
+		return NULL;
+
+	memcpy(&speed, &oep.ddr_speed, sizeof(oep.ddr_speed));
+	speed[sizeof(speed) - 1] = '\0';
+
+	return speed;
+}
+
 static const char * const omnia_get_mcu_type(void)
 {
 	static char result[] = "xxxxxxx (with peripheral resets)";
@@ -634,12 +655,84 @@ static struct mv_ddr_topology_map board_topology_map_2g = {
 	{0}				/* timing parameters */
 };
 
+static const struct omnia_ddr_speed {
+	char name[5];
+	u8 speed_bin;
+	u8 freq;
+} omnia_ddr_speeds[] = {
+	{ "1066F", SPEED_BIN_DDR_1066F, MV_DDR_FREQ_533 },
+	{ "1333H", SPEED_BIN_DDR_1333H, MV_DDR_FREQ_667 },
+	{ "1600K", SPEED_BIN_DDR_1600K, MV_DDR_FREQ_800 },
+};
+
+static const struct omnia_ddr_speed *find_ddr_speed_setting(const char *name)
+{
+	for (int i = 0; i < ARRAY_SIZE(omnia_ddr_speeds); ++i)
+		if (!strncmp(name, omnia_ddr_speeds[i].name, 5))
+			return &omnia_ddr_speeds[i];
+
+	return NULL;
+}
+
+bool omnia_valid_ddr_speed(const char *name)
+{
+	return find_ddr_speed_setting(name) != NULL;
+}
+
+void omnia_print_ddr_speeds(void)
+{
+	for (int i = 0; i < ARRAY_SIZE(omnia_ddr_speeds); ++i)
+		printf("%.5s%s", omnia_ddr_speeds[i].name,
+		       i == ARRAY_SIZE(omnia_ddr_speeds) - 1 ? "\n" : ", ");
+}
+
+static void fixup_speed_in_ddr_topology(struct mv_ddr_topology_map *topology)
+{
+	typeof(topology->interface_params[0]) *params;
+	const struct omnia_ddr_speed *setting;
+	const char *speed;
+	static bool done;
+
+	if (done)
+		return;
+
+	done = true;
+
+	speed = omnia_get_ddr_speed();
+	if (!speed)
+		return;
+
+	setting = find_ddr_speed_setting(speed);
+	if (!setting) {
+		printf("Unsupported value %s for DDR3 speed in EEPROM!\n",
+		       speed);
+		return;
+	}
+
+	params = &topology->interface_params[0];
+
+	/* don't inform if we are not changing the speed from the default one */
+	if (params->speed_bin_index == setting->speed_bin)
+		return;
+
+	printf("Fixing up DDR3 speed (EEPROM defines %s)\n", speed);
+
+	params->speed_bin_index = setting->speed_bin;
+	params->memory_freq = setting->freq;
+}
+
 struct mv_ddr_topology_map *mv_ddr_topology_map_get(void)
 {
+	struct mv_ddr_topology_map *topology;
+
 	if (omnia_get_ram_size_gb() == 2)
-		return &board_topology_map_2g;
+		topology = &board_topology_map_2g;
 	else
-		return &board_topology_map_1g;
+		topology = &board_topology_map_1g;
+
+	fixup_speed_in_ddr_topology(topology);
+
+	return topology;
 }
 
 static int set_regdomain(void)
-- 
2.44.2

