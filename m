Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD034C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 01:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A7187640;
	Sat, 23 Dec 2023 02:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="q7EJcier";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715B4874AC; Sat, 23 Dec 2023 02:04:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C097874AC
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 02:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703293431; x=1703898231; i=xypron.glpk@gmx.de;
 bh=sLSlAziIHs8/2dmnyyM5SSxCR7JSUbqf+Q36TRTz3rg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
 References;
 b=q7EJcierLYjTOtCSqAt9+NDMVZULUsJ0nuRhfk9Fv5z89G+f2mV3+sQ56hl189IG
 OYPEvGo1Jc56S7N0KMo4bfuycaPKRScZ5jFweXyh+cOzS7Jt52ciSe+S9jmkmnAYp
 RV+9FThryCDgoK1LNyEkMpubKieuhVV3R/3s/mLolxrnnjsmSl3nSgolnYD799gCg
 rJCqtaaRKON3PZLx2I5pi5Dzw23Oc+qSQqgeZRrDRmK4cN9pbLcQhE6wvX7nOZ7SS
 QQg2o6/qoVQSEwypckK37aWOW9r7dEZbRob2qKd1uAY8Y3i5naVeL9nTt6aclEXd/
 HrjrK/6Zc1KcHEdQfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1rML8d16rs-007j4x; Sat, 23
 Dec 2023 02:03:51 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] smbios: copy QEMU tables
Date: Sat, 23 Dec 2023 02:03:34 +0100
Message-ID: <20231223010334.248291-3-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223010334.248291-1-xypron.glpk@gmx.de>
References: <20231223010334.248291-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bJ7mTccEOWtFjmNvRauke1ZT5H+aE5al+GZpeR9Zbm6fKVXpzay
 cVE2F24rah0gdaEnhP3JtQvfCBmBgrytTY3hCwpnC5hqjTpVY60VWq2XxWULCwLQfIx2V48
 F64QGtcj6tOT27W/KlOXjATNGQ+46UBnn+ENT2tDNNs5VCdyMwUWlyNcs3dZyEJF01XSoN0
 ID5zF+J64OWhrJxry8cog==
UI-OutboundReport: notjunk:1;M01:P0:c8o3iiwCGvw=;xKiciQbWU3q/NjuYqSifhTgyAns
 dYTG6fBijksAriWlQinqG/w5AMmrvVm4cPftVkCsrytM7V5FfNzlTitka9nQR4kOoB0sjzHRu
 ghrvd9lsHiehuFbM3TzPXt1E1mACZzke5Ajr0DwAaSDqIqAMih8r6iHKLOr9LEtIT6hYZij0r
 F5wwbkWlUJqK7+cKhrkzQto1KBS3ukVFzdGp7HiAdXTVnG0VmHaY5wgi8ur25vydVrtJoygOW
 wqCR5c2j2FzJhXfmr8yHNPKbkf1fj/8L4W0wnVp9F+ODYv0w+cl1nXIGEuptYobF+rqEervOc
 5s66vnU6D6iTWedZtJQpq3xkDC05APHhDaYr4OwEGE6UTynK9wvqWw+syKC6v+Tg+gkLV2M49
 hxoZUoO6D3q9LeYRI34ucpwIkgA3X4qP8NmTJ9wuB6RjEdq5eiAmOQ89OQaMaQMGPEykr4wjT
 KTi0LHJ9qJ+s7tHpnFwk0wFEU1gkpTmAWyH+qQrUgWRJ35MU1sCmW1ofJFbVBo9/TticgMlQi
 G8DN/8xEmwX2XUbqeYxSukIJO2t97589vbtLz9Q1QxmE5QKvTTrUfelAw9LGP8BRGHHV9aljL
 TqYquhpFHHhwTs85sh6dRrEEeetHuDq248yRio7GFv4zmdoKXpqM2jGdjFQU0SH3TOfBCJxkM
 hxcWaHHlex3Ct+AImx6ew7IdmB2IpjllObDvt7PCN7VLhsVXgxL7GEV7rFlVxNgyT2L+Vldqt
 pZAzHyIN4eBA1kzlwre1v3lqGGshbQLEg6DtOH8fiwszGHax7Bu6vkMt/C8Koa5/fO5b/2oAI
 3/Cmu3JGk8aUlp4kr1jrc32PrrC644JnQ2ZlJM+ffue9DO9JU0e0ReBZD2OzwEG2h4rMFlQj6
 vPAj67nrOzo1zLvuLcg6+b6NKgwZZzhcaznfW6I4PICxyrDiz7LBOfkZ/YB9m7STwsUcgNgIh
 p7zbTqQ2GOfp948phycMO9bajBU=
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

QEMU provides SMBIOS tables with detailed information. We should not try t=
o
replicate them in U-Boot.

If we want to inform about U-Boot, we can add a Firmware Inventory
Information (type 45) table in future.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
=2D--
v2:
	fix parsing of SMBIOS anchor
	enable copying on x86 and 32bit ARM/RISC-V
=2D--
 arch/x86/lib/tables.c       |   2 +-
 drivers/misc/Kconfig        |   7 ++
 drivers/misc/Makefile       |   1 +
 drivers/misc/qfw_smbios.c   | 197 ++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_smbios.c |   4 +-
 5 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/qfw_smbios.c

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 5b5070f7ca..914d9de0cb 100644
=2D-- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -61,7 +61,7 @@ static struct table_info table_list[] =3D {
 #ifdef CONFIG_GENERATE_ACPI_TABLE
 	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, 0x10000, 0x1000},
 #endif
-#ifdef CONFIG_GENERATE_SMBIOS_TABLE
+#if defined(CONFIG_GENERATE_SMBIOS_TABLE) && !defined(CONFIG_QFW_SMBIOS)
 	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, 0x1000, 0x100},
 #endif
 };
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e8e4400516..d2536c54e0 100644
=2D-- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -561,6 +561,13 @@ config QFW_MMIO
 	  Hidden option to enable MMIO QEMU fw_cfg interface. This will be
 	  selected by the appropriate QEMU board.

+config QFW_SMBIOS
+	bool
+	default y
+	depends on QFW && SMBIOS && !SANDBOX
+	help
+	  Hidden option to read SMBIOS tables from QEMU.
+
 config I2C_EEPROM
 	bool "Enable driver for generic I2C-attached EEPROMs"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index cda701d38e..64bea92f51 100644
=2D-- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,6 +66,7 @@ obj-y +=3D qfw.o
 obj-$(CONFIG_QFW_ACPI) +=3D qfw_acpi.o
 obj-$(CONFIG_QFW_PIO) +=3D qfw_pio.o
 obj-$(CONFIG_QFW_MMIO) +=3D qfw_mmio.o
+obj-$(CONFIG_QFW_SMBIOS) +=3D qfw_smbios.o
 obj-$(CONFIG_SANDBOX) +=3D qfw_sandbox.o
 endif
 obj-$(CONFIG_ROCKCHIP_EFUSE) +=3D rockchip-efuse.o
diff --git a/drivers/misc/qfw_smbios.c b/drivers/misc/qfw_smbios.c
new file mode 100644
index 0000000000..9019345783
=2D-- /dev/null
+++ b/drivers/misc/qfw_smbios.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2023 Heinrich Schuchardt <heinrich.schuchardt@canonical.=
com>
+ */
+
+#define LOG_CATEGORY UCLASS_QFW
+
+#include <efi_loader.h>
+#include <errno.h>
+#include <log.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <qfw.h>
+#include <smbios.h>
+#include <tables_csum.h>
+#include <linux/sizes.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * qfw_load_smbios_table() - load a QEMU firmware file
+ *
+ * @dev:	QEMU firmware device
+ * @size:	parameter to return the size of the loaded table
+ * @name:	name of the table to load
+ * Return:	address of the loaded table, NULL on error
+ */
+static void *qfw_load_smbios_table(struct udevice *dev, uint32_t *size,
+				   char *name)
+{
+	struct fw_file *file;
+	struct bios_linker_entry *table;
+
+	file =3D qfw_find_file(dev, name);
+	if (!file) {
+		log_debug("Can't find %s\n", name);
+		return NULL;
+	}
+
+	*size =3D be32_to_cpu(file->cfg.size);
+
+	table =3D malloc(*size);
+	if (!table) {
+		log_err("Out of memory\n");
+		return NULL;
+	}
+
+	qfw_read_entry(dev, be16_to_cpu(file->cfg.select), *size, table);
+
+	return table;
+}
+
+/**
+ * qfw_parse_smbios_anchor() - parse QEMU's SMBIOS anchor
+ *
+ * @dev:	QEMU firmware device
+ * @entry:	SMBIOS 3 structure to be filled from QEMU's anchor
+ * Return:	0 for success, -ve on error
+ */
+static int qfw_parse_smbios_anchor(struct udevice *dev,
+				   struct smbios3_entry *entry)
+{
+	void *table;
+	uint32_t size;
+	struct smbios_entry *entry2;
+	struct smbios3_entry *entry3;
+	const char smbios_sig[] =3D "_SM_";
+	const char smbios3_sig[] =3D "_SM3_";
+	int ret =3D 0;
+
+	table =3D qfw_load_smbios_table(dev, &size, "etc/smbios/smbios-anchor");
+	if (!table)
+		return -ENOMEM;
+	if (!memcmp(table, smbios3_sig, sizeof(smbios3_sig) - 1)) {
+		entry3 =3D table;
+		if (entry3->length !=3D sizeof(struct smbios3_entry)) {
+			ret =3D -ENOENT;
+			goto out;
+		}
+		memcpy(entry, entry3, sizeof(struct smbios3_entry));
+	} else if (!memcmp(table, smbios_sig, sizeof(smbios_sig) - 1)) {
+		entry2 =3D table;
+		if (entry2->length !=3D sizeof(struct smbios_entry)) {
+			ret =3D -ENOENT;
+			goto out;
+		}
+		memset(entry, 0, sizeof(struct smbios3_entry));
+		memcpy(entry, smbios3_sig, sizeof(smbios3_sig));
+		entry->length =3D sizeof(struct smbios3_entry);
+		entry->major_ver =3D entry2->major_ver;
+		entry->minor_ver =3D entry2->minor_ver;
+		entry->max_struct_size =3D entry2->max_struct_size;
+	} else {
+		ret =3D -ENOENT;
+		goto out;
+	}
+	ret =3D 0;
+out:
+	free(table);
+
+	return ret;
+}
+
+/**
+ * qfw_write_smbios_tables() - copy SMBIOS tables from QEMU
+ *
+ * @addr:	target buffer
+ * @size:	size of target buffer
+ * Return:	0 for success, -ve on error
+ */
+static int qfw_write_smbios_tables(u8 *addr, uint32_t size)
+{
+	int ret;
+	struct udevice *dev;
+	struct smbios3_entry *entry =3D (void *)addr;
+	void *table;
+	uint32_t table_size;
+
+	ret =3D qfw_get_dev(&dev);
+	if (ret) {
+		log_err("No QEMU firmware device\n");
+		return ret;
+	}
+
+	ret =3D qfw_read_firmware_list(dev);
+	if (ret) {
+		log_err("Can't read firmware file list\n");
+		return ret;
+	}
+
+	ret =3D qfw_parse_smbios_anchor(dev, entry);
+	if (ret) {
+		log_debug("Can't parse anchor\n");
+		return ret;
+	}
+
+	addr +=3D entry->length;
+	entry->struct_table_address =3D (uintptr_t)addr;
+	entry->checksum =3D 0;
+	entry->checksum =3D table_compute_checksum(entry,
+						 sizeof(struct smbios3_entry));
+
+	table =3D qfw_load_smbios_table(dev, &table_size,
+				      "etc/smbios/smbios-tables");
+	if (table_size + sizeof(struct smbios3_entry) > size) {
+		free(table);
+		return -ENOMEM;
+	}
+	memcpy(addr, table, table_size);
+	free(table);
+
+	return 0;
+}
+
+/**
+ * qfw_evt_write_smbios_tables() - event handler for copying QEMU SMBIOS =
tables
+ *
+ * Return:	0 on success, -ve on error (only out of memory)
+ */
+static int qfw_evt_write_smbios_tables(void)
+{
+	phys_addr_t addr;
+	void *ptr;
+	int ret;
+	/*
+	 * TODO:
+	 * This size is currently hard coded in lib/efi_loader/efi_smbios.c.
+	 * We need a field in global data for the size.
+	 */
+	uint32_t size =3D SZ_4K;
+
+	/* Reserve 64K for SMBIOS tables, aligned to a 4K boundary */
+	ptr =3D memalign(SZ_4K, size);
+	if (!ptr) {
+		log_err("Out of memory\n");
+		return -ENOMEM;
+	}
+	addr =3D map_to_sysmem(ptr);
+
+	/* Generate SMBIOS tables */
+	ret =3D qfw_write_smbios_tables(ptr, size);
+	if (ret) {
+		if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
+			log_info("Falling back to U-Boot generated SMBIOS tables\n");
+			write_smbios_table(addr);
+		}
+	} else {
+		log_debug("SMBIOS tables copied from QEMU\n");
+	}
+
+	gd_set_smbios_start(addr);
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qfw_evt_write_smbios_tables);
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index bbb8421ce1..c4837da969 100644
=2D-- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -51,7 +51,9 @@ static int install_smbios_table(void)
 	u64 addr;
 	efi_status_t ret;

-	if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) || IS_ENABLED(CONFIG_X86))
+	if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) ||
+	    IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_QFW_SMBIOS))
 		return 0;

 	addr =3D SZ_4G;
=2D-
2.43.0

