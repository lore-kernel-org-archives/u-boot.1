Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9F3E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 21:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D35F8035E;
	Fri,  3 Jan 2025 22:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="eU847euI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9972A802EF; Fri,  3 Jan 2025 22:59:26 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB5E6803DC
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 22:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4402=T4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1735941562; bh=JI4ShrZEE4vFmcBlMaEVH9fPEVMaxVpC44LdFF9lT3E=;
 b=eU847euIitAudbAJbVbckUrDeummRtw3kCY/7Dup+fwG0OGUXwYE9KL66HGrB0YdFfSLfzTPZ
 3P2Kv7TaSap+IQ+WtlSun5NjnKq+2h6jIptNen9LRVkdgCFW+O84oAv8Bpp8S/wAUJe661qOqDe
 cO2ZYgSyKr5v83+vDqBYqPc33yXu4jLaqijN1jGmddc/1nWuxrl7jFUas3m+6h7XAorUC01hvqB
 8Gk+MwUD9ebNPWxo7OSYCd8hJ/92Xr+2+glcJ2HDdhUYnChf45ghDF3NCuoDNbjo1kt2gYjhcu2
 ob1s3rXiRwQWMnmKY7G/qydMK8MoDeH21btR+lZCqqKg==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from bionic.. ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Fri,
 03 Jan 2025 21:59:06 +0000
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] tools: amlimage: Add support for GXBB eMMC header
Date: Fri,  3 Jan 2025 21:58:59 +0000
Message-ID: <20250103215904.2590769-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103215904.2590769-1-jonas@kwiboo.se>
References: <20250103215904.2590769-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67785db4053722097e3f1012
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

GXBB BL1 only tries to read boot image from sector 0 on eMMC and sector
1 on SD-card. GXL and newer read boot image from sector 1 on both eMMC
and SD-card.

Vendor BL2 have solved the issue with different offsets by considering
where BL2 was loaded from to adjust the offset where BL3 is read from.

This provide a different solution to create a boot image that can be
booted from both eMMC and SD-card and where the offset for reading next
stage loader can be shared for both boot options.

Inject code, that relocate the payload located at 0x1200 offset in TZRAM
to the expected offset of 0x1000, into the padding area at offset 0x200
when a normal GXBB boot image is created. A special GXBB eMMC header can
then be created that have the payload offset point to this relocate
code, BL1 will jump to this relocate code when booted from eMMC instead
of the normal payload start. One effect of this is that the payload size
limit must be reduced by 512 bytes on GXBB.

Example of how to use it:
  # Create a normal boot image
  tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin bl2.bin

  # Create a boot image with a special eMMC header
  tools/mkimage -T amlimage -n emmc -d bl2.bin bl2-emmc.bin

  # Write normal boot image to sector 1 of eMMC/SD-card
  dd if=bl2.bin of=/path/to/dev bs=512 seek=1

  # Write eMMC header, 112 bytes, to start of eMMC
  dd if=bl2-emmc.bin of=/path/to/dev bs=1 count=112

Or with binman using something like:
  binman {
	multiple-images;

	u-boot-gxbb-sd {
		filename = "u-boot-gxbb-sd.bin";
		pad-byte = <0xff>;

		mkimage {
			filename = "bl2.bin";
			args = "-n", "gxbb", "-T", "amlimage";

			u-boot-spl {
			};
		};
	};

	u-boot-gxbb-emmc {
		filename = "u-boot-gxbb-emmc.bin";
		pad-byte = <0xff>;

		mkimage {
			filename = "bl2-emmc.bin";
			args = "-n", "emmc", "-T", "amlimage";

			blob-ext {
				filename = "bl2.bin";
			}
		};
	};
  };

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 tools/amlimage-gxbb-relocate.c | 79 ++++++++++++++++++++++++++++++++++
 tools/amlimage.c               | 37 ++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 tools/amlimage-gxbb-relocate.c

diff --git a/tools/amlimage-gxbb-relocate.c b/tools/amlimage-gxbb-relocate.c
new file mode 100644
index 000000000000..3503805c460e
--- /dev/null
+++ b/tools/amlimage-gxbb-relocate.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+/*
+ * The following commands can be used to reproduce the gxbb_relocate
+ * byte array in amlimage.c
+ *
+ * Start U-Boot CI docker container from U-Boot source code root folder:
+ *  docker run --rm -v $(pwd):/build -u uboot -it docker.io/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
+ *
+ * Run the following commands inside the docker container:
+ *  export PATH=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin:$PATH
+ *  cd /build/tools
+ *
+ * Generate assembly code for the c code in this file:
+ *  aarch64-linux-gcc -nostdlib -ffreestanding -Os -S -o amlimage-gxbb-relocate.S amlimage-gxbb-relocate.c
+ *
+ * Manually remove 'mov x16, x2' and replace 'x16' with 'x2' on the last line.
+ *
+ * Compile assembly code and extract the AArch64 binary code:
+ *  aarch64-linux-as -o amlimage-gxbb-relocate.o amlimage-gxbb-relocate.S
+ *  aarch64-linux-objcopy -O binary -j .text amlimage-gxbb-relocate.o amlimage-gxbb-relocate.bin
+ *
+ * Print binary code as a byte array that can be copied into amlimage.c
+ *  hexdump -ve '1/1 "0x%.2x, "' amlimage-gxbb-relocate.bin | fold -w 72 && echo
+ *
+ * Remember to update assembly code below when byte array is updated.
+ */
+
+#include <stdint.h>
+
+#define TZRAM_BASE		0xd9000000
+#define PAYLOAD_OFFSET		0x200
+#define BL2_OFFSET		0x1000
+#define BL2_BASE		(void *)(TZRAM_BASE + BL2_OFFSET)
+#define BL2_SIZE		0xb000
+
+void _start(uint64_t x0, uint64_t x1)
+{
+	void (*bl2)(uint64_t, uint64_t) = BL2_BASE;
+	uint64_t i, *dst = BL2_BASE, *src = BL2_BASE + PAYLOAD_OFFSET;
+
+	/* memmove payload from 0x1200 to 0x1000 offset in TZRAM */
+	for (i = 0; i < BL2_SIZE / sizeof(*src); i++)
+		*(dst + i) = *(src + i);
+
+	/* goto entry point with x0 and x1 reg intact */
+	bl2(x0, x1);
+}
+
+/*
+	.arch armv8-a
+	.file	"amlimage-gxbb-relocate.c"
+	.text
+	.align	2
+	.global	_start
+	.type	_start, %function
+_start:
+.LFB0:
+	.cfi_startproc
+	mov	x2, 4608
+	movk	x2, 0xd900, lsl 16
+	add	x3, x2, 45056
+.L2:
+	sub	x4, x2, #32768
+	add	x2, x2, 8
+	ldr	x5, [x2, -8]
+	str	x5, [x4, 32256]
+	cmp	x2, x3
+	bne	.L2
+	mov	x2, 4096
+	movk	x2, 0xd900, lsl 16
+	br	x2
+	.cfi_endproc
+.LFE0:
+	.size	_start, .-_start
+	.ident	"GCC: (GNU) 13.2.0"
+	.section	.note.GNU-stack,"",@progbits
+*/
diff --git a/tools/amlimage.c b/tools/amlimage.c
index 9af795602e69..43be1636ed11 100644
--- a/tools/amlimage.c
+++ b/tools/amlimage.c
@@ -51,6 +51,7 @@ struct amlimage_variant {
 		  .payload_size = size, } }
 
 static const struct amlimage_variant variants[] = {
+	VARIANT("emmc", 1, 0, 0xb000 + PAYLOAD_OFFSET),
 	VARIANT("gxbb", 1, 0, 0xb000),
 	VARIANT("gxl",  1, 1, 0xb000),
 	VARIANT("gxm",  1, 1, 0xb000),
@@ -176,6 +177,17 @@ static void amlimage_set_header(void *buf, struct stat *sbuf, int ifd,
 	hdr->data_offset = hdr->digest_offset + SHA256_SUM_LEN;
 	hdr->data_size = hdr->total_size - hdr->data_offset;
 
+	/* Adjust offset and size in GXBB eMMC header */
+	if (!strcmp("emmc", params->imagename)) {
+		hdr->total_size -= PAYLOAD_OFFSET;
+		/* Use offset to relocate code relative to eMMC header */
+		hdr->payload_offset = 0x400 - HEADER_OFFSET;
+		hdr->payload_size = hdr->total_size - hdr->payload_offset;
+		/* Use 0x200 offset to exclude MBR from the data range */
+		hdr->data_offset = 0x200 - HEADER_OFFSET;
+		hdr->data_size = hdr->total_size - hdr->data_offset;
+	}
+
 	sha256_starts(&ctx);
 	/* Header and data is used as input for sha256 digest */
 	sha256_update(&ctx, (void *)hdr, hdr->header_size);
@@ -203,6 +215,22 @@ static int amlimage_check_image_type(uint8_t type)
 	return EXIT_FAILURE;
 }
 
+/*
+ * AArch64 binary code to relocate payload when booting from eMMC on GXBB.
+ *
+ * Payload is relocated from offset 0x1200 to 0x1000 in TZRAM, similar to:
+ * memmove(0xd9001000, 0xd9001200, 0xb000)
+ * goto 0xd9001000
+ *
+ * See amlimage-gxbb-relocate.c on how to reproduce the following byte array.
+ */
+static const uint8_t gxbb_relocate[] = {
+	0x02, 0x40, 0x82, 0xd2, 0x02, 0x20, 0xbb, 0xf2, 0x43, 0x2c, 0x40, 0x91,
+	0x44, 0x20, 0x40, 0xd1, 0x42, 0x20, 0x00, 0x91, 0x45, 0x80, 0x5f, 0xf8,
+	0x85, 0x00, 0x3f, 0xf9, 0x5f, 0x00, 0x03, 0xeb, 0x61, 0xff, 0xff, 0x54,
+	0x02, 0x00, 0x82, 0xd2, 0x02, 0x20, 0xbb, 0xf2, 0x40, 0x00, 0x1f, 0xd6,
+};
+
 static int amlimage_vrec_header(struct image_tool_params *params,
 				struct image_type_params *tparams)
 {
@@ -213,6 +241,10 @@ static int amlimage_vrec_header(struct image_tool_params *params,
 	/* Use payload offset as header size, datafile will be appended */
 	tparams->header_size = PAYLOAD_OFFSET;
 
+	/* Only prepend 512 bytes for GXBB eMMC header */
+	if (!strcmp("emmc", variant->name))
+		tparams->header_size = 0x200;
+
 	tparams->hdr = calloc(1, tparams->header_size);
 	if (!tparams->hdr) {
 		fprintf(stderr, "%s: Can't alloc header: %s\n",
@@ -223,6 +255,11 @@ static int amlimage_vrec_header(struct image_tool_params *params,
 	/* Start with a copy of the variant header */
 	memcpy(tparams->hdr + HEADER_OFFSET, hdr, hdr->header_size);
 
+	/* Insert relocate code to move payload from 0x1200 to 0x1000 on GXBB */
+	if (!strcmp("gxbb", variant->name))
+		memcpy(tparams->hdr + 0x200,
+		       gxbb_relocate, sizeof(gxbb_relocate));
+
 	/* Pad up to payload size of the variant header */
 	return hdr->payload_size - params->file_size;
 }
-- 
2.47.1

