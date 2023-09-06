Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B618EB8FAF
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 12:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF87D86680;
	Wed,  6 Sep 2023 14:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="X2nFX8Gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8220286963; Wed,  6 Sep 2023 14:00:20 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3973A865A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 14:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8F56A3F6E8; 
 Wed,  6 Sep 2023 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694001615;
 bh=s2NQ4lKxssNOTsLUEdjxt3ZVUM5/wA/VYAYo+8vVDgY=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=X2nFX8GvSqNQddOmVHB6B2eEoiwcYdWzyLiZ1JdZFkXgA2xI2i9IP+ITCAVjlKOaf
 7OOuWRzNHwz+v+8D1yeF61O2T0Il9NEKMu/WjlMdLN17fvOnkOMwrginCERvdoAcGB
 4Rsa+Se4ajCNqHanzQQNKZSuZtCJZQIxeI/SWt22CxzzXQZn83ADi8D4ZG0rPO+s9T
 84kQcVW79WhUX9B6Tq5OcIOrMlU55SSbZ8biz7491pMSIpqukyOkg5kByDfrO60Py2
 SgeBnJ0X4U/LjnLkasixGJKWI7dvpd6ZOPI4HIXfbLPZKiYRHIqBGC2E6iMJ1U9TxF
 AO8A7tpk5xWRA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: Simon Glass <sjg@chromium.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] tools: mkimage: Add StarFive SPL image support
Date: Wed,  6 Sep 2023 14:00:07 +0200
Message-Id: <20230906120008.86717-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
References: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
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

The StarFive JH7110 base boards require a header to be prefixed to the SPL
binary image. This has previously done with a vendor tool 'spl_tool'
published under a GPL-2-or-later license. Integrate this capability into
mkimage.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>
---
v2:
	no change except for Tested-by credit
---
 boot/image.c    |   1 +
 include/image.h |   1 +
 tools/Makefile  |   1 +
 tools/sfspl.c   | 174 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+)
 create mode 100644 tools/sfspl.c

diff --git a/boot/image.c b/boot/image.c
index 5c4f9b807d..3a99d2e897 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -182,6 +182,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_SUNXI_TOC0, "sunxi_toc0",  "Allwinner TOC0 Boot Image" },
 	{	IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat Device Tree ", },
 	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
+	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index 01a6787d21..5f85bf84a2 100644
--- a/include/image.h
+++ b/include/image.h
@@ -231,6 +231,7 @@ enum image_type_t {
 	IH_TYPE_SUNXI_TOC0,		/* Allwinner TOC0 Boot Image */
 	IH_TYPE_FDT_LEGACY,		/* Binary Flat Device Tree Blob	in a Legacy Image */
 	IH_TYPE_RENESAS_SPKG,		/* Renesas SPKG image */
+	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
diff --git a/tools/Makefile b/tools/Makefile
index 3d0c4b0dd6..1aa1e36137 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -123,6 +123,7 @@ dumpimage-mkimage-objs := aisimage.o \
 			pblimage.o \
 			pbl_crc32.o \
 			renesas_spkgimage.o \
+			sfspl.o \
 			vybridimage.o \
 			stm32image.o \
 			$(ROCKCHIP_OBS) \
diff --git a/tools/sfspl.c b/tools/sfspl.c
new file mode 100644
index 0000000000..ec18a0a77e
--- /dev/null
+++ b/tools/sfspl.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ *
+ * The StarFive JH7110 requires to prepend a header to u-boot-spl.bin describing
+ * the payload length and CRC32.
+ *
+ * This module implements support in mkimage and dumpimage for this file format.
+ *
+ * StarFive's spl_tool available under GPL-2.0-and-later at
+ * https://github.com/starfive-tech/Tools implements writing the same file
+ * format and served as a reference.
+ */
+
+#include <compiler.h>
+#include <fcntl.h>
+#include <u-boot/crc.h>
+#include <unistd.h>
+#include "imagetool.h"
+
+#define DEFAULT_VERSION 0x01010101
+#define DEFAULT_BACKUP 0x200000U
+#define DEFAULT_OFFSET 0x240
+
+/**
+ * struct spl_hdr - header for SPL on JH7110
+ *
+ * All fields are low-endian.
+ */
+struct spl_hdr {
+	/** @offset:	offset to SPL header (0x240) */
+	unsigned int offset;
+	/** @bkp_offs:	address of backup SPL, defaults to DEFAULT_BACKUP */
+	unsigned int bkp_offs;
+	/** @zero1:	set to zero */
+	unsigned int zero1[159];
+	/** @version:	header version, defaults to DEFAULT_VERSION */
+	unsigned int version;
+	/** @file_size:	file size */
+	unsigned int file_size;
+	/** @hdr_size:	size of the file header (0x400) */
+	unsigned int hdr_size;
+	/** @crc32:	CRC32 */
+	unsigned int crc32;
+	/** @zero2:	set to zero */
+	unsigned int zero2[91];
+};
+
+static int sfspl_check_params(struct image_tool_params *params)
+{
+	/* Only the RISC-V architecture is supported */
+	if (params->Aflag && params->arch != IH_ARCH_RISCV)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static int sfspl_verify_header(unsigned char *buf, int size,
+			       struct image_tool_params *params)
+{
+	struct spl_hdr *hdr = (void *)buf;
+	unsigned int hdr_size = le32_to_cpu(hdr->hdr_size);
+	unsigned int file_size = le32_to_cpu(hdr->file_size);
+	unsigned int crc = le32_to_cpu(hdr->crc32);
+	unsigned int crc_check;
+
+	if (size < 0 ||
+	    (size_t)size < sizeof(struct spl_hdr) ||
+	    (size_t)size < hdr_size + file_size) {
+		printf("Truncated file\n");
+		return EXIT_FAILURE;
+	}
+	if (hdr->version != DEFAULT_VERSION) {
+		printf("Unknown file format version\n");
+		return EXIT_FAILURE;
+	}
+	crc_check = crc32(0, &buf[hdr_size], size - hdr_size);
+	if (crc_check != crc) {
+		printf("Incorrect CRC32\n");
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
+
+static void sfspl_print_header(const void *buf,
+			       struct image_tool_params *params)
+{
+	struct spl_hdr *hdr = (void *)buf;
+	unsigned int hdr_size = le32_to_cpu(hdr->hdr_size);
+	unsigned int file_size = le32_to_cpu(hdr->file_size);
+
+	printf("Header size: %u\n", hdr_size);
+	printf("Payload size: %u\n", file_size);
+}
+
+static int sfspl_image_extract_subimage(void *ptr,
+					struct image_tool_params *params)
+{
+	struct spl_hdr *hdr = (void *)ptr;
+	unsigned char *buf = ptr;
+	int fd;
+	unsigned int hdr_size = le32_to_cpu(hdr->hdr_size);
+	unsigned int file_size = le32_to_cpu(hdr->file_size);
+
+	if (params->pflag) {
+		printf("Invalid image index %d\n", params->pflag);
+		return EXIT_FAILURE;
+	}
+
+	fd = open(params->outfile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd == -1) {
+		perror("Can write file");
+		return EXIT_FAILURE;
+	}
+	if (write(fd, &buf[hdr_size], file_size) != file_size) {
+		perror("Cannot write file");
+		return EXIT_FAILURE;
+	}
+	close(fd);
+
+	return EXIT_SUCCESS;
+}
+
+static int sfspl_check_image_type(uint8_t type)
+{
+	if (type == IH_TYPE_STARFIVE_SPL)
+		return EXIT_SUCCESS;
+
+	return EXIT_FAILURE;
+}
+
+static void sfspl_set_header(void *buf, struct stat *sbuf, int infd,
+			     struct image_tool_params *params)
+{
+	struct spl_hdr *hdr = buf;
+	unsigned int file_size;
+	unsigned int crc;
+
+	file_size = params->file_size - sizeof(struct spl_hdr);
+	crc = crc32(0, &((unsigned char *)buf)[sizeof(struct spl_hdr)],
+		    file_size);
+
+	hdr->offset = cpu_to_le32(DEFAULT_OFFSET);
+	hdr->bkp_offs = cpu_to_le32(DEFAULT_BACKUP);
+	hdr->version = cpu_to_le32(DEFAULT_VERSION);
+	hdr->file_size = cpu_to_le32(file_size);
+	hdr->hdr_size = cpu_to_le32(sizeof(struct spl_hdr));
+	hdr->crc32 = cpu_to_le32(crc);
+}
+
+static int sfspl_vrec_header(struct image_tool_params *params,
+			     struct image_type_params *tparams)
+{
+	tparams->hdr = calloc(sizeof(struct spl_hdr), 1);
+
+	/* No padding */
+	return 0;
+}
+
+U_BOOT_IMAGE_TYPE(
+	sfspl, /* id */
+	"StarFive SPL Image", /* name */
+	sizeof(struct spl_hdr), /* header_size */
+	NULL, /* header */
+	sfspl_check_params, /* check_params */
+	sfspl_verify_header, /* verify header */
+	sfspl_print_header, /* print header */
+	sfspl_set_header, /* set header */
+	sfspl_image_extract_subimage, /* extract_subimage */
+	sfspl_check_image_type, /* check_image_type */
+	NULL, /* fflag_handle */
+	sfspl_vrec_header /* vrec_header */
+);
-- 
2.40.1

