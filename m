Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F43EC0461
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 09:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D809583F53;
	Tue,  3 Mar 2026 10:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=lixiang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=lixiang-com.20200927.dkim.feishu.cn header.i=@lixiang-com.20200927.dkim.feishu.cn header.b="sUCERwIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A053F83F64; Tue,  3 Mar 2026 07:29:46 +0100 (CET)
Received: from lf-2-32.ptr.blmpb.com (lf-2-32.ptr.blmpb.com [101.36.218.32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 609A483F6D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 07:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=lixiang.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=suruitong@lixiang.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1772519373;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=qyyA5gyCwIp5TRngPmdIRD+gZzFbud37bW5yTu9n7Do=;
 b=sUCERwIqeUuCycU60TjcjlHtzHABDKGR2fTB5AVWsVablvYGn7APTQJTYT2/3EAxjjnJ19
 CXu7owgIAFHKSuBVA4PZlvwQc9YgyQMhXiY7Gq8eJnvM1gdVnROGdk9UYVYMhEfQPyu+Rr
 e10O2h0L6GHXLqLXKGVenI1ZyAG83YcOtIS/fIqLbTdAva8aSiDGClWeVymWlqsEpXKOLm
 jBdgnCaIdUeshlhYHO8kBZsYEPcnFwekNlIFZn3I9P3DDr1h3KnWJG49AqUaMdguKatI25
 4wrwvP+2XRrM8PNilsB/cSUDAqVYDDHjVXCOvNfYhNEsiO1xpUXPc6WYcbLM5g==
From: "Ruitong Su" <suruitong@lixiang.com>
Date: Tue,  3 Mar 2026 14:29:25 +0800
Mime-Version: 1.0
Cc: <mkorpershoek@kernel.org>, <trini@konsulko.com>, 
 "Ruitong Su" <suruitong@lixiang.com>
References: <20260303062926.3335004-1-suruitong@lixiang.com>
To: <u-boot@lists.denx.de>
Message-Id: <20260303062926.3335004-2-suruitong@lixiang.com>
In-Reply-To: <20260303062926.3335004-1-suruitong@lixiang.com>
Received: from SSOC4-SH.company.local ([220.248.55.70]) by smtp.feishu.cn with
 ESMTPS; Tue, 03 Mar 2026 14:29:30 +0800
Subject: [PATCH 1/2] fastboot: Add UFS flash backend
X-Mailer: git-send-email 2.50.1
X-Lms-Return-Path: <lba+269a67fcb+57717f+lists.denx.de+suruitong@lixiang.com>
X-Original-From: Ruitong Su <suruitong@lixiang.com>
X-Mailman-Approved-At: Tue, 03 Mar 2026 10:17:57 +0100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Add a fastboot backend for UFS (Universal Flash Storage) devices.
UFS devices are accessed through the SCSI subsystem, with each UFS
LUN exposed as a separate SCSI block device.

The key feature is multi-LUN partition addressing using the syntax
"<scsi_dev>#<partition_name>" (e.g. "0#system", "1#boot_a").
Unqualified names fall back to the default SCSI device configured
via CONFIG_FASTBOOT_FLASH_UFS_DEV.

The implementation reuses the existing fb_block helpers for raw
image, sparse image, and erase operations, adding only the
UFS-specific partition lookup and GPT handling logic on top.

Partition lookup uses a quiet iteration via part_get_info() instead
of the verbose part_get_info_by_name() / part_get_info_by_dev_and_
name_or_num(), which avoids noisy console output during fastboot
getvar probing (has-slot, partition-size queries).

Signed-off-by: Ruitong Su <suruitong@lixiang.com>
---
 MAINTAINERS               |   1 +
 drivers/fastboot/Kconfig  |  30 ++++++-
 drivers/fastboot/Makefile |   1 +
 drivers/fastboot/fb_ufs.c | 164 ++++++++++++++++++++++++++++++++++++++
 include/fb_ufs.h          |  49 ++++++++++++
 5 files changed, 243 insertions(+), 2 deletions(-)
 create mode 100644 drivers/fastboot/fb_ufs.c
 create mode 100644 include/fb_ufs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f8d4f6ee8b2..071102f47fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1197,6 +1197,7 @@ F:	cmd/fastboot.c
 F:	doc/android/fastboot*.rst
 F:	include/fastboot.h
 F:	include/fastboot-internal.h
+F:	include/fb_ufs.h
 F:	include/net/fastboot_tcp.h
 F:	include/net/fastboot_udp.h
 F:	drivers/fastboot/
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 576c3ef8a45..8569bec5d9b 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -92,7 +92,7 @@ config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
 	default y if ARCH_SUNXI && ( MMC || MTD_RAW_NAND )
 	default y if ARCH_ROCKCHIP && MMC
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || DM_SPI_FLASH || BLK
+	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || DM_SPI_FLASH || BLK |=
| (UFS && SCSI)
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -124,12 +124,38 @@ config FASTBOOT_FLASH_SPI
 	bool "FASTBOOT on SPI flash"
 	depends on DM_SPI_FLASH
=20
+config FASTBOOT_FLASH_UFS
+	bool "FASTBOOT on UFS"
+	depends on UFS && SCSI
+	help
+	  This enables support for the fastboot "flash" and "erase"
+	  commands on UFS (Universal Flash Storage) devices. UFS
+	  devices are accessed through the SCSI subsystem, with each
+	  UFS LUN exposed as a separate SCSI block device.
+
+	  Partitions are addressed using the syntax
+	  "<scsi_dev>#<partition_name>" (e.g. "0#system") to
+	  disambiguate across multiple UFS LUNs. Unqualified names
+	  fall back to the default SCSI device number.
+
 config FASTBOOT_FLASH_BLOCK
 	bool "FASTBOOT on block device"
 	depends on BLK
=20
 endchoice
=20
+config FASTBOOT_FLASH_UFS_DEV
+	int "Define FASTBOOT UFS default SCSI device number"
+	depends on FASTBOOT_FLASH_UFS
+	default 0
+	help
+	  The default SCSI device number for UFS fastboot operations.
+	  UFS LUNs are exposed as SCSI block devices by the UFS driver.
+	  Use "scsi scan" followed by "scsi info" to discover the
+	  mapping between SCSI device numbers and UFS LUNs. Typically
+	  device 0 corresponds to UFS LUN 0. When the partition name
+	  does not contain a "#" separator, this device is used.
+
 config FASTBOOT_FLASH_MMC_DEV
 	int "Define FASTBOOT MMC FLASH default device"
 	depends on FASTBOOT_FLASH_MMC
@@ -227,7 +253,7 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
=20
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
-	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
+	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_UFS) && EFI_PARTITION
 	default "gpt"
 	help
 	  The fastboot "flash" command supports writing the downloaded
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index a341af076d1..93a5227b737 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) +=3D fb_block.o
 # MMC reuses block implementation
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) +=3D fb_block.o fb_mmc.o
 obj-$(CONFIG_FASTBOOT_FLASH_NAND) +=3D fb_nand.o
+obj-$(CONFIG_FASTBOOT_FLASH_UFS) +=3D fb_block.o fb_ufs.o
 obj-$(CONFIG_FASTBOOT_FLASH_SPI) +=3D fb_spi_flash.o
diff --git a/drivers/fastboot/fb_ufs.c b/drivers/fastboot/fb_ufs.c
new file mode 100644
index 00000000000..1273c946491
--- /dev/null
+++ b/drivers/fastboot/fb_ufs.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Li Auto Inc.
+ *
+ * UFS (Universal Flash Storage) backend for fastboot.
+ *
+ * UFS devices in U-Boot are accessed through the SCSI subsystem, with
+ * each UFS LUN exposed as a separate SCSI block device.  This backend
+ * provides UFS-aware partition lookup with multi-LUN addressing, layered
+ * on top of the generic fb_block helpers for the actual I/O.
+ *
+ * Partition addressing uses the syntax "<scsi_dev>#<partition_name>"
+ * (e.g. "0#system") to disambiguate across multiple UFS LUNs.
+ * Unqualified names fall back to CONFIG_FASTBOOT_FLASH_UFS_DEV.
+ */
+
+#include <blk.h>
+#include <fastboot.h>
+#include <fastboot-internal.h>
+#include <fb_block.h>
+#include <fb_ufs.h>
+#include <image-sparse.h>
+#include <part.h>
+#include <vsprintf.h>
+#include <linux/printk.h>
+
+static struct blk_desc *fastboot_ufs_get_dev(char *response, int dev_num)
+{
+	struct blk_desc *dev_desc;
+
+	dev_desc =3D blk_get_dev("scsi", dev_num);
+	if (!dev_desc || dev_desc->type =3D=3D DEV_TYPE_UNKNOWN) {
+		pr_err("invalid UFS/SCSI device %d\n", dev_num);
+		fastboot_fail("invalid UFS device", response);
+		return NULL;
+	}
+
+	return dev_desc;
+}
+
+static int fb_ufs_find_part(struct blk_desc *dev_desc, const char *name,
+			    struct disk_partition *info)
+{
+	int i;
+	int ret;
+
+	for (i =3D 1; ; i++) {
+		ret =3D part_get_info(dev_desc, i, info);
+		if (ret)
+			return ret;
+		if (!strcmp(name, (char *)info->name))
+			return i;
+	}
+}
+
+int fastboot_ufs_get_part_info(const char *part_name,
+			       struct blk_desc **dev_desc,
+			       struct disk_partition *part_info,
+			       char *response)
+{
+	int dev_num =3D CONFIG_FASTBOOT_FLASH_UFS_DEV;
+	char name_buf[32];
+	const char *name =3D part_name;
+	int ret;
+
+	if (!part_name || !*part_name) {
+		fastboot_fail("partition not given", response);
+		return -ENOENT;
+	}
+
+	/* Parse "<dev>#<name>" syntax for multi-LUN addressing */
+	if (strchr(part_name, '#')) {
+		if (sscanf(part_name, "%d#%31s", &dev_num, name_buf) !=3D 2) {
+			fastboot_fail("invalid partition spec", response);
+			return -EINVAL;
+		}
+		name =3D name_buf;
+	}
+
+	*dev_desc =3D blk_get_dev("scsi", dev_num);
+	if (!*dev_desc || (*dev_desc)->type =3D=3D DEV_TYPE_UNKNOWN) {
+		fastboot_fail("no such device", response);
+		return -ENODEV;
+	}
+
+	ret =3D fb_ufs_find_part(*dev_desc, name, part_info);
+	if (ret < 0) {
+		fastboot_fail("no such partition", response);
+		return -ENOENT;
+	}
+
+	return ret;
+}
+
+void fastboot_ufs_flash_write(const char *cmd, void *download_buffer,
+			      u32 download_bytes, char *response)
+{
+	struct blk_desc *dev_desc;
+	struct disk_partition info =3D {0};
+
+#if CONFIG_IS_ENABLED(EFI_PARTITION)
+	{
+		int dev_num =3D CONFIG_FASTBOOT_FLASH_UFS_DEV;
+		char op_buf[16];
+		const char *op =3D cmd;
+
+		if (strchr(cmd, '#')) {
+			if (sscanf(cmd, "%d#%15s", &dev_num, op_buf) =3D=3D 2)
+				op =3D op_buf;
+		}
+
+		if (!strcmp(op, CONFIG_FASTBOOT_GPT_NAME)) {
+			dev_desc =3D fastboot_ufs_get_dev(response, dev_num);
+			if (!dev_desc)
+				return;
+
+			printf("%s: updating GPT on scsi %d\n",
+			       __func__, dev_num);
+			if (is_valid_gpt_buf(dev_desc, download_buffer)) {
+				printf("%s: invalid GPT - refusing to write\n",
+				       __func__);
+				fastboot_fail("invalid GPT partition",
+					      response);
+				return;
+			}
+			if (write_mbr_and_gpt_partitions(dev_desc,
+							 download_buffer)) {
+				printf("%s: writing GPT partitions failed\n",
+				       __func__);
+				fastboot_fail("writing GPT partitions failed",
+					      response);
+				return;
+			}
+			part_init(dev_desc);
+			printf("........ success\n");
+			fastboot_okay(NULL, response);
+			return;
+		}
+	}
+#endif
+
+	if (fastboot_ufs_get_part_info(cmd, &dev_desc, &info, response) < 0)
+		return;
+
+	if (is_sparse_image(download_buffer)) {
+		fastboot_block_write_sparse_image(dev_desc, &info, cmd,
+						  download_buffer, response);
+	} else {
+		fastboot_block_write_raw_image(dev_desc, &info, cmd,
+					       download_buffer,
+					       download_bytes, response);
+	}
+}
+
+void fastboot_ufs_erase(const char *cmd, char *response)
+{
+	struct blk_desc *dev_desc;
+	struct disk_partition info;
+
+	if (fastboot_ufs_get_part_info(cmd, &dev_desc, &info, response) < 0)
+		return;
+
+	fastboot_block_raw_erase(dev_desc, &info, cmd, 0, response);
+}
diff --git a/include/fb_ufs.h b/include/fb_ufs.h
new file mode 100644
index 00000000000..d64d5aca81a
--- /dev/null
+++ b/include/fb_ufs.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Li Auto Inc.
+ */
+
+#ifndef _FB_UFS_H_
+#define _FB_UFS_H_
+
+struct blk_desc;
+struct disk_partition;
+
+/**
+ * fastboot_ufs_get_part_info() - Look up partition on UFS device
+ *
+ * Supports two naming conventions:
+ *   "<scsi_dev>#<partition_name>"  -- explicit LUN targeting (e.g. "0#sys=
tem")
+ *   "<partition_name>"             -- searches on default UFS SCSI device
+ *
+ * @part_name: Partition specifier (see above)
+ * @dev_desc: Pointer to returned block device descriptor
+ * @part_info: Pointer to returned partition info
+ * @response: Pointer to fastboot response buffer
+ * Return: Partition number on success, negative on error
+ */
+int fastboot_ufs_get_part_info(const char *part_name,
+			       struct blk_desc **dev_desc,
+			       struct disk_partition *part_info,
+			       char *response);
+
+/**
+ * fastboot_ufs_flash_write() - Write downloaded image to UFS partition
+ *
+ * @cmd: Partition specifier ("0#system", "0#gpt", etc.)
+ * @download_buffer: Pointer to downloaded image data
+ * @download_bytes: Size of downloaded image
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_ufs_flash_write(const char *cmd, void *download_buffer,
+			      u32 download_bytes, char *response);
+
+/**
+ * fastboot_ufs_erase() - Erase a UFS partition
+ *
+ * @cmd: Partition specifier ("0#userdata", etc.)
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_ufs_erase(const char *cmd, char *response);
+
+#endif /* _FB_UFS_H_ */
--=20
2.50.1

=E5=A3=B0=E6=98=8E=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=
=85=81=E8=AE=B8=E6=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=
=BB=EF=BC=8C=E6=9C=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=
=E8=A6=81=E6=B1=82=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BD=BF=E7=94=A8=E3=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=
=AF=AF=E5=9C=B0=E5=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=
=94=E7=B3=BB=E9=82=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=
=E9=99=A4=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=
=8F=8A=E6=B3=95=E5=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=
=A0=E4=B8=BA=E8=AF=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=
=E6=88=96=E4=B8=A7=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=
=9A=84=E8=A7=82=E7=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=
=8E=E4=BD=9C=E8=80=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=
=E5=B9=B6=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=
=8F=B8=E3=80=82
Disclaimer: This email is intended to be read only by the designated recipi=
ent of the document and has high confidentiality requirements. Anyone else =
is prohibited from using, opening, copying or forwarding any of the content=
s inside. If this email was sent to you by mistake, please contact the send=
er of the email and delete this file immediately. Confidentiality and legal=
 privileges are not waived or lost by misdirected emails. Any views or opin=
ions expressed in the email are those of the author and do not necessarily =
represent those of the Company.

