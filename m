Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BDFC46CD2
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 00:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CF7871CE;
	Sat, 23 Dec 2023 01:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LJolok3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E51687579; Sat, 23 Dec 2023 01:44:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFEB87640
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 01:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703292287; x=1703897087; i=xypron.glpk@gmx.de;
 bh=qRhYStgJWrJohh1moIc9Gu986sqUmIChoooVSpFxHgM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
 References;
 b=LJolok3fu/tbTjkg5bmBYJvrr0cU9ETs3PuvkKG4Ond7gH4a5TCjDLYOVShvGBLn
 IM/BPJGNNCA0CgCkUyuAlhu/honaEJdAPovPfkX93sUcoV6WPn3KBe2rIgHeCpYK9
 SE35YSSI68zHeYsK57hsVkW1DfFklIipLWCeijHoUaDg2kQdVIa1UB/NsmLa6rnjR
 CQ1wTfckxlsNHxaZ5fadY8ChcXOvL0gK+aWIgVQwCAlWDvgGIZ0Z9CjsR2xCSjUcm
 Pqc2mSPlUU7AEeiYkCOZ6xbEvCjVPxaoT8S4tv6/Z9vXS1wR58vWS0xHapysVfmwE
 LiJh1Z8QqPprJ4qlwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD6W-1qleJB0XGk-00ePDk; Sat, 23
 Dec 2023 01:44:47 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 3/5] cmd: provide command to display SMBIOS information
Date: Sat, 23 Dec 2023 01:44:27 +0100
Message-ID: <20231223004429.247301-4-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223004429.247301-1-xypron.glpk@gmx.de>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l/VoTmZVWGc1jpd3HnZvPppRtVm0AjsA4koZxn1cjN29o/mwv8v
 bKXT6QAZkkLtagpMLwPNH5RB683jcrMW09MfL8MnuUbEhYwNfrsUDIVVLHTunEywHuBodii
 5Mfgg9RincEDKnLH35mmLyxTqQ9Quc/RYfUq7XZcT7esuiCdy4kKc4ZvvSYPXJI9/K6Nn37
 AegohVlTJgSkZJXD/WI3w==
UI-OutboundReport: notjunk:1;M01:P0:fitGTQUQ234=;Mu9A94nuCZgU+Z8Zu5wCIv5W0dh
 X3p69xhkxXUkJz+XsNgz2foFW1J5UYQBN+KqLJHefOh+IgpE+iVsW9P2wzxBm815NXrbUpyun
 ZHnVBLc2XXtqkYYVPqKzYGVbB/MtEEL+lkFdpCXzLczViSo7AL0mmBp/rflUYYbv1UhrrpJoC
 fVtR6OA0BmxiKclFrdaC3rkyKqVcASCvEH9sH4rP+AekGsaFWrisL3/0BrAWflkbPBaYcjWLH
 r37Po5ZOzOgoG0Mi65kp8+jKx/wtBUrZ5aB2hDUnNFi2hclYROVhEBwS5zQ3JUj89JFoUWDrm
 rzINbwL1i4dSYFOkCNQqt5nPLujJdEvjuCy4NxZcZ8iG+eafq9t8lhbwci5OvCfW9PGHrymsI
 PAq+QfJ7+JIfaaLaGQGtdSLIuNdw+NyEvel2xB+Wfk0ovLVJ87hso5nRD1jRlmWveWQRrCGzW
 q2y1JkC3eXGSkY/FEk5qnvxiq2wwrRTUMKklYlIObsDuXsga/XZ+tTbj8vGTt9ANpvWizkuZk
 ajUbwIgfksI4m69RKYC/atWnUBSbNc11VQXTh6Q620VXTdemPCtnbFQmLryaK/LDmC4tY8R/o
 fBy1YiJhu6MfMdyPrpeztCE4aRxE4BvdT1ofYbO2SHJR7GSJhc8exzTK4AoeBEkuEEXG9cicu
 Sc/ZBKWCTPFWemcHOnd7dWx6+4hW9Q2PWdBncnGdMfyzMkcagG7FGD+fHPcfPIWQKHoI0YrOW
 0A8p076Ksz2MkbLwfbhsm78EkOcAwrXo/qvUd9bmrd/+ZWKnT9kz3PODJc7xqb4bjrE1dQcl9
 NqY06/Dq9Xdt3zB0euHbvuLmB2y9VAQc1/gRs7epplsX6akt9+UEbKGZGMUrUxX6ANq5gmclC
 c5KOkkLnd4U89JzVr8CPjnNI8yb7thcLZblrH63DhZeyBxqgKlvKun4lk0rtVq+Bvj3cBOV5y
 +hpTXn3+95iGchi3mWm0EG9rZso=
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

U-Boot can either generated an SMBIOS table or copy it from a prior boot
stage, e.g. QEMU.

Provide a command to display the SMBIOS information.

Currently only type 1 and 2 are translated to human readable text.
Other types may be added later. Currently only a hexdump and the list of
strings is provided for these.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 cmd/Kconfig  |   7 ++
 cmd/Makefile |   1 +
 cmd/smbios.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 cmd/smbios.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5a7678f0ac..580aeec8ee 100644
=2D-- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -206,6 +206,13 @@ config CMD_SBI
 	help
 	  Display information about the SBI implementation.

+config CMD_SMBIOS
+	bool "smbios"
+	depends on SMBIOS
+	default y
+	help
+	  Display the SMBIOS information.
+
 endmenu

 menu "Boot commands"
diff --git a/cmd/Makefile b/cmd/Makefile
index 5ed0e4011d..8a5dfd8ca9 100644
=2D-- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -168,6 +168,7 @@ obj-$(CONFIG_CMD_SETEXPR) +=3D setexpr.o
 obj-$(CONFIG_CMD_SETEXPR_FMT) +=3D printf.o
 obj-$(CONFIG_CMD_SPI) +=3D spi.o
 obj-$(CONFIG_CMD_STRINGS) +=3D strings.o
+obj-$(CONFIG_CMD_SMBIOS) +=3D smbios.o
 obj-$(CONFIG_CMD_SMC) +=3D smccc.o
 obj-$(CONFIG_CMD_SYSBOOT) +=3D sysboot.o
 obj-$(CONFIG_CMD_STACKPROTECTOR_TEST) +=3D stackprot_test.o
diff --git a/cmd/smbios.c b/cmd/smbios.c
new file mode 100644
index 0000000000..63f908e92c
=2D-- /dev/null
+++ b/cmd/smbios.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The 'smbios' command displays information from the SMBIOS table.
+ *
+ * Copyright (c) 2023, Heinrich Schuchardt <xypron.glpk@gmx.de>
+ */
+
+#include <command.h>
+#include <hexdump.h>
+#include <mapmem.h>
+#include <smbios.h>
+#include <tables_csum.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * smbios_get_string() - get SMBIOS string from table
+ *
+ * @table:	SMBIOS table
+ * @index:	index of the string
+ * Return:	address of string, may point to empty string
+ */
+static const char *smbios_get_string(void *table, int index)
+{
+	const char *str =3D (char *)table +
+			  ((struct smbios_header *)table)->length;
+
+	if (!*str)
+		++str;
+	for (--index; *str && index; --index)
+		str +=3D strlen(str) + 1;
+
+	return str;
+}
+
+static struct smbios_header *next_table(struct smbios_header *table)
+{
+	const char *str;
+
+	if (table->type =3D=3D SMBIOS_END_OF_TABLE)
+		return NULL;
+
+	str =3D smbios_get_string(table, 0);
+	return (struct smbios_header *)(++str);
+}
+
+static void smbios_print_generic(struct smbios_header *table)
+{
+	char *str =3D (char *)table + table->length;
+
+	if (CONFIG_IS_ENABLED(HEXDUMP)) {
+		printf("Header and Data:\n");
+		print_hex_dump("\t", DUMP_PREFIX_OFFSET, 16, 1,
+			       table, table->length, false);
+	}
+	if (*str) {
+		printf("Strings:\n");
+		for (int index =3D 1; *str; ++index) {
+			printf("\tString %u: %s\n", index, str);
+			str +=3D strlen(str) + 1;
+		}
+	}
+}
+
+void smbios_print_str(const char *label, void *table, u8 index)
+{
+	printf("\t%s: %s\n", label, smbios_get_string(table, index));
+}
+
+static void smbios_print_type1(struct smbios_type1 *table)
+{
+	printf("System Information\n");
+	smbios_print_str("Manufacturer", table, table->manufacturer);
+	smbios_print_str("Product Name", table, table->product_name);
+	smbios_print_str("Version", table, table->version);
+	smbios_print_str("Serial Number", table, table->serial_number);
+	if (table->length >=3D 0x19) {
+		printf("\tUUID %pUl\n", table->uuid);
+		smbios_print_str("Wake Up Type", table, table->serial_number);
+	}
+	if (table->length >=3D 0x1b) {
+		smbios_print_str("Serial Number", table, table->serial_number);
+		smbios_print_str("SKU Number", table, table->sku_number);
+	}
+}
+
+static void smbios_print_type2(struct smbios_type2 *table)
+{
+	u16 *handle;
+
+	printf("Base Board Information\n");
+	smbios_print_str("Manufacturer", table, table->manufacturer);
+	smbios_print_str("Product Name", table, table->product_name);
+	smbios_print_str("Version", table, table->version);
+	smbios_print_str("Serial Number", table, table->serial_number);
+	smbios_print_str("Asset Tag", table, table->asset_tag_number);
+	printf("\tFeature Flags: 0x%2x\n", table->feature_flags);
+	smbios_print_str("Chassis Location", table, table->chassis_location);
+	printf("\tChassis Handle: 0x%2x\n", table->chassis_handle);
+	smbios_print_str("Board Type", table, table->board_type);
+	printf("\tContained Object Handles: ");
+	handle =3D (void *)table->eos;
+	for (int i =3D 0; i < table->number_contained_objects; ++i)
+		printf("0x%04x ", handle[i]);
+	printf("\n");
+}
+
+static void smbios_print_type127(struct smbios_type127 *table)
+{
+	printf("End Of Table\n");
+}
+
+static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	ulong addr;
+	void *entry;
+	u32 size;
+	char version[12];
+	struct smbios_header *table;
+	static const char smbios_sig[] =3D "_SM_";
+	static const char smbios3_sig[] =3D "_SM3_";
+	size_t count =3D 0;
+	u32 max_struct_size;
+
+	addr =3D gd_smbios_start();
+	if (!addr) {
+		log_warning("SMBIOS not available\n");
+		return CMD_RET_FAILURE;
+	}
+	entry =3D map_sysmem(addr, 0);
+	if (!memcmp(entry, smbios3_sig, sizeof(smbios3_sig) - 1)) {
+		struct smbios3_entry *entry3 =3D entry;
+
+		table =3D (void *)(uintptr_t)entry3->struct_table_address;
+		snprintf(version, sizeof(version), "%d.%d.%d",
+			 entry3->major_ver, entry3->minor_ver, entry3->doc_rev);
+		table =3D (void *)(uintptr_t)entry3->struct_table_address;
+		size =3D entry3->length;
+		max_struct_size =3D entry3->max_struct_size;
+	} else if (!memcmp(entry, smbios_sig, sizeof(smbios_sig) - 1)) {
+		struct smbios_entry *entry2 =3D entry;
+
+		snprintf(version, sizeof(version), "%d.%d",
+			 entry2->major_ver, entry2->minor_ver);
+		table =3D (void *)(uintptr_t)entry2->struct_table_address;
+		size =3D entry2->length;
+		max_struct_size =3D entry2->max_struct_size;
+	} else {
+		log_err("Unknown SMBIOS anchor format\n");
+		return CMD_RET_FAILURE;
+	}
+	if (table_compute_checksum(entry, size)) {
+		log_err("Invalid anchor checksum\n");
+		return CMD_RET_FAILURE;
+	}
+	printf("SMBIOS %s present.\n", version);
+
+	for (struct smbios_header *pos =3D table; pos; pos =3D next_table(pos))
+		++count;
+	printf("%zd structures occupying %d bytes\n", count, max_struct_size);
+	printf("Table at 0x%llx\n", (unsigned long long)map_to_sysmem(table));
+
+	for (struct smbios_header *pos =3D table; pos; pos =3D next_table(pos)) =
{
+		printf("\nHandle 0x%04x, DMI type %d, %d bytes at 0x%llx\n",
+		       pos->handle, pos->type, pos->length,
+		       (unsigned long long)map_to_sysmem(pos));
+		switch (pos->type) {
+		case 1:
+			smbios_print_type1((struct smbios_type1 *)pos);
+			break;
+		case 2:
+			smbios_print_type2((struct smbios_type2 *)pos);
+			break;
+		case 127:
+			smbios_print_type127((struct smbios_type127 *)pos);
+			break;
+		default:
+			smbios_print_generic(pos);
+			break;
+		}
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_LONGHELP(smbios, "- display SMBIOS information");
+
+U_BOOT_CMD(smbios, 1, 0, do_smbios, "display SMBIOS information",
+	   smbios_help_text);
=2D-
2.43.0

