Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3752C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDC6883BA;
	Tue, 18 Jun 2024 17:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lEbzs87A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7630888438; Tue, 18 Jun 2024 17:34:59 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF3E5883BB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0EC82CE1A0B;
 Tue, 18 Jun 2024 15:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68792C3277B;
 Tue, 18 Jun 2024 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724894;
 bh=EVb0XnfS/mt0ArpWnHZbPThh/VveSgImfLFfQbKJklE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lEbzs87ATgbgymoGQlFbTRebYPw8Sl5cvt6M0eDVaVDvFfsSalX0KPQtli5W14cRw
 4b3UeO9NK8DCsbDmEslMQkZokfG49CwiuJDI7OfKz0bMvFQHQFOUME5UeUCji3g1fR
 6f1Pl6Ndo55qm2SpX6zlB+Ej6aJS3wuxxGsldL58pUa3nDPFctun+uizU+JpC/mGgh
 JDg6X9l75bvLyLrEJZs/08RQQE4obKoeK4RDAXeZ9QdGxLqYvM8oVEprxOG3gTBBed
 ybyt7+0wrqDTl317eJp3DDBJVvJRBF0R0nmmFUpg5GKIsa+BCihln8/yav67OjM3ft
 SegLXVaHIRuhQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 08/16] arm: mvebu: turris_omnia: Implement
 EEPROM layout for the 'eeprom' command
Date: Tue, 18 Jun 2024 17:34:31 +0200
Message-ID: <20240618153439.9518-9-kabel@kernel.org>
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

Implement Turris Omnia EEPROM layout for the 'eeprom' command.

When the 'eeprom' command (with layout support) is enabled, we can now
use the 'eeprom print' and 'eeprom update' commands, for example:

  => eeprom print
  Magic constant                34a04103
  RAM size in GB                2
  Wi-Fi Region
  CRC32 checksum                cecbc2a1

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/Makefile |   1 +
 board/CZ.NIC/turris_omnia/eeprom.c | 109 +++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 board/CZ.NIC/turris_omnia/eeprom.c

diff --git a/board/CZ.NIC/turris_omnia/Makefile b/board/CZ.NIC/turris_omnia/Makefile
index 341378b4e5..216e11958a 100644
--- a/board/CZ.NIC/turris_omnia/Makefile
+++ b/board/CZ.NIC/turris_omnia/Makefile
@@ -3,3 +3,4 @@
 # Copyright (C) 2017 Marek Behún <kabel@kernel.org>
 
 obj-y	:= turris_omnia.o ../turris_atsha_otp.o ../turris_common.o
+obj-$(CONFIG_CMD_EEPROM_LAYOUT)	+= eeprom.o
diff --git a/board/CZ.NIC/turris_omnia/eeprom.c b/board/CZ.NIC/turris_omnia/eeprom.c
new file mode 100644
index 0000000000..a4f1dab469
--- /dev/null
+++ b/board/CZ.NIC/turris_omnia/eeprom.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Marek Behún <kabel@kernel.org>
+ */
+
+#include <asm/unaligned.h>
+#include <ctype.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <eeprom_field.h>
+#include <eeprom_layout.h>
+#include <u-boot/crc.h>
+
+#define _DEF_FIELD(_n, _s, _t) \
+	{ _n, _s, NULL, eeprom_field_print_ ## _t, eeprom_field_update_ ## _t }
+
+static void eeprom_field_print_ramsz(const struct eeprom_field *field)
+{
+	printf(PRINT_FIELD_SEGMENT, field->name);
+	printf("%u\n", get_unaligned_le32(field->buf));
+}
+
+static int eeprom_field_update_ramsz(struct eeprom_field *field, char *value)
+{
+	u32 sz;
+
+	if (value[0] == '1' || value[0] == '2' || value[0] == '4')
+		sz = value[0] - '0';
+	else
+		return -1;
+
+	if (value[1] != '\0')
+		return -1;
+
+	put_unaligned_le32(sz, field->buf);
+
+	return 0;
+}
+
+static void eeprom_field_print_region(const struct eeprom_field *field)
+{
+	eeprom_field_print_ascii(field);
+}
+
+static int eeprom_field_update_region(struct eeprom_field *field, char *value)
+{
+	if (strlen(value) != 2) {
+		printf("%s: has to be 2 characters\n", field->name);
+		return -1;
+	}
+
+	memcpy(field->buf, value, 2);
+	memset(&field->buf[2], '\0', 2);
+
+	return 0;
+}
+
+static struct eeprom_field omnia_layout[] = {
+	_DEF_FIELD("Magic constant", 4, bin),
+	_DEF_FIELD("RAM size in GB", 4, ramsz),
+	_DEF_FIELD("Wi-Fi Region", 4, region),
+	_DEF_FIELD("CRC32 checksum", 4, bin),
+};
+
+static struct eeprom_field *crc_field = &omnia_layout[3];
+
+static int omnia_update_field(struct eeprom_layout *layout, char *field_name,
+			      char *new_data)
+{
+	struct eeprom_field *field;
+	int err;
+
+	if (!new_data)
+		return 0;
+
+	if (!field_name)
+		return -1;
+
+	field = eeprom_layout_find_field(layout, field_name, true);
+	if (!field)
+		return -1;
+
+	err = field->update(field, new_data);
+	if (err) {
+		printf("Invalid data for field %s\n", field_name);
+		return err;
+	}
+
+	if (field < crc_field) {
+		u32 crc = crc32(0, layout->data, 12);
+		put_unaligned_le32(crc, crc_field->buf);
+	}
+
+	return 0;
+}
+
+void eeprom_layout_assign(struct eeprom_layout *layout, int)
+{
+	layout->fields = omnia_layout;
+	layout->num_of_fields = ARRAY_SIZE(omnia_layout);
+	layout->update = omnia_update_field;
+	layout->data_size = 16;
+}
+
+int eeprom_layout_detect(unsigned char *)
+{
+	/* Turris Omnia has only one version of EEPROM layout */
+	return 0;
+}
-- 
2.44.2

