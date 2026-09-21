Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AD4C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 14:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8757D6064C;
	Mon, 21 Sep 2026 14:56:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e7gDe_DeU_v7; Mon, 21 Sep 2026 14:56:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1C32E6060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790002563;
	b=WnGb39e82Y4FsTOpXSrxanht3zslaYKt++jnJL9LqGmFdq5SoNYvsv2sUez2rFg9qVPj
	 jQWvQFPdRofV6C9m/3jXr2c0mWmk5fZs2ccdth1QFWYUj2Cve8K+m6i3YAtNLWnAu5OVQ
	 MtMDeApoWtgXPUxDIz5kbW91TEMpn99kNqK/RlvIvMYkmOaP0NbYZNQwaiFdbxh4MZ4To
	 2bwKW9C4aS0zr/EujUA3p63IZfT+X7M9mIjIMRYiDK/m2nEdzvRAnh+2yzXNY/m4G6pBC
	 k7W0+v5q/zPeh8KUQ4Uh9Yj8McRPG3Ou+E7f58TZn6r1Grn12ugn4Kw9HvBH+uvQkIw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790002563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tDOcJTw0wE5bUFpYUYZvr0pbf8bHYuTKzuV14p2UmvE=;
	b=KgBkvoa84JbbLAo3kvrNAyHiO1pySVfk+shKlgwzzl9YChEWnmh0rJrrRGV6jLAIlmTm
	 J+7VHXR+GUQUkY4N487r1tcRPikYkiMpw7qTqKevWRno1SIj/IgWmgCLYLOo/hS0am6H/
	 Y1KjLyDX6zamf17cDxIqNq62yUXbMV87ENng2F5AvV87NDGZIpWxxTPW3CIAHFD0qQLvu
	 ql2VQCF+9zeKzv6IOvyrYrVslpTQB7wMkFULAm3nR6h3aY3EcOvi7aXrEBNozF4kN04VQ
	 GXOjL3WuYm1/Xm/uPwdGWEeuWby3OzYpLXRXJzSkqWhqnYulgo9jg4ueXCeH7tpTtIA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790002563;
	bh=tDOcJTw0wE5bUFpYUYZvr0pbf8bHYuTKzuV14p2UmvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EaAP9eD82drYIww4iPHcRgHkzKc980IKp8xQJcunDthO4zpaeu5h70CV7KLYbqXjc
	 JlMaQNKgKdlcE8JRUAsvFMJOx6THuQTQlnc8qdB+RXGqn1sAEixBfnZZoYX51MqGlT
	 4/UfMzRKJ+v6K8ba+udg8s3iQicN2ZC8tXE+cPq+krEVHpoCZaHgj4J6+P0CAbzMwP
	 Eo9xOiKR+0P2aNKFvGbaMb20temyu2jbfmO3z4qwBDbeDlqdnGXQt+zhXMkcWftBJR
	 9kWnUboGfj5nqPHhHtHpMdeaWeHqYNf3iC0bjO8tGt3OzlNkA9dgkVxl58FglWzJ5c
	 8Ki+xape2FnHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C32E6060D;
	Mon, 21 Sep 2026 14:56:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 790CF24D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5364940738
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:56:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KyGbhErBkgxE for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 14:55:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7966F40723
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790002559;
 b=s0vIhY2cZafbOV2QGefvHcEmGGipKbmivE0rBI/PxGAFZxhQymljUkJx6N6vi+WyFMKQ
 m8P7TK4v+7dcycP2JMiMM4CEBjeIVvQl9LxZ87btLHgJzZHs7kURYvqU1Ci6QsfKng9v1
 yrorLoljYyc7NTZ0bWjpIFZbccrMa4fVsgk+yX0Lz1CG2+kxixBf3/mJxG+tOAZz/is4A
 tdEtZXAKTHEDStt5ok7WV3txSoxz+qQpzxr63BCOdGWXuYemqHU+LozVeshNawQ4fAsqU
 3aOd3as7qKa5zJNG7p3Iw95x9Xx9VnbDnYV/vNbp+6pXRZxP4pf8r+nwLqpOX+D3enQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790002559;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=tDOcJTw0wE5bUFpYUYZvr0pbf8bHYuTKzuV14p2UmvE=;
 b=HmF8ju5v7ToeBWYiGDp1EPFBrla5rq/PTToBx1ZkJ/O2v9gvAWpFqT+YYEVmRQpvDnHt
 1nVggkvbNzkDP/VN983C8fX5t9pVlNDW+3o6fDdlCde0KLxFD4f9s6v5XMyDkSj4Js/9N
 SxEATZhK5ZL35xSJC4PyoRKXAwZ1LlyGWceTYTVJw/cvXvHDPEHPNj2ZN+lKMlkQ7iXsx
 GUhTW8QGyNHfEUPPvTW02HRJCprQJGbxE2MsPBZTbT209rGJwTpo+Ar52RmVKER84EX78
 A7qbSbGbMN8OpvSX6cQs59H5tI4nUsOvaf3Vyvf+8riE/kR/Nanfau9iIramJDlmPbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=fNL+NmXB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=fNL+NmXB
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7966F40723
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790002520; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eQ4imsanKNrkCnOSRzRbQ0saAg1cvMji02bFG9lkmStOkbhrxM+vulCXoZonwmmprS/iMlPKNr4TJnY7qbu4DTbtRMXQ8km84RNGcrwDzgoWBPDWc2W0zHud/x3JUKshp/6yHKAjtopdMrDACQzQ0+gHxoBJDOrYyblRVSpr19c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790002520;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tDOcJTw0wE5bUFpYUYZvr0pbf8bHYuTKzuV14p2UmvE=; 
 b=Hg5ltvcxLJfH8EpRpZtJ53KKoSijmHG7bDSntTWvwRZCbVFiv7gCtNMClyF7JYiPl8BHSS/75dK+Pq7yIQKYdXhnz5INzghEb1/j5r1bh+bdi11bdKEwe0YLewNGicsrLb6Oo2pYQ9Ld7HMApwrqUaMWJwqCKBykAMbHCUc3bL8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790002520; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=tDOcJTw0wE5bUFpYUYZvr0pbf8bHYuTKzuV14p2UmvE=;
 b=fNL+NmXBTPxHRuyg6klN4DaDbSZQUv/lhAAmQgWGDJ3hvs3hDPaJw7rGPIEOEglz
 RlvgL4P4aCFMd7e6pvQYHk3Y4kAjf9CMz3e4zWb0IGsTIU84Qw9s8LQ/DkMuqeVEQDV
 TmTjoIH2fPk5xUyvN0OURRb7LNE1lpfDNU0mJBMA=
Received: by smtp.zohomail.com with SMTPS id 17900025195251022.2035189473893; 
 Mon, 21 Sep 2026 07:55:19 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Sep 2026 22:54:38 +0800
Subject: [PATCH v3 1/2] tools: mkimage: add SpacemiT K3 boot image support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-spacemit-aihd-v3-1-f660fc85d2a5@pigmoral.tech>
References: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
In-Reply-To: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8815;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=2wU8zIBSmA88+7jdkTq+993n6YluMw9fzEXKV9X0ANQ=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2ujp3zdo8w1HqnkVYptuUwscX2OsSjqz8dav5yPfyE
 I6AE/P+d5SyMIhxMciKKbJw+Yv/s9bh+XZEoPU+zBxWJpAhDFycAjCRozWMDPMFz/VFS2cqXdxV
 +qTUhjctzF7jZM3L4NiKUoZZK+M+mjMynPtzlDEuxO8Fu7rdu3x1u1Jjjj/KU1sZ357aabJzB/d
 rPgA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The SpacemiT BootROM loads the FSBL from a boot image consisting of a
fixed 4 KiB header with two metadata headers and authentication
information, followed by a 32-byte-aligned SPL payload and a trailing
authentication area. K1 and K3 share the same layout, but use different
integrity and authentication schemes. K1 requires RSA-signed images,
while K3 uses CRC32 to verify images in non-secure boot mode.

Add mkimage type "smtimage" for the K3 CRC32 path. Populate both
metadata headers, fill their CRC32 values and the payload CRC32, and
reserve the authentication areas required by the layout.

The K1 and K3 image headers cannot be easily differentiated, and
dumpimage has no way to select the variant, so dumpimage support is
not implemented.

mkimage selects the SoC variant with "-n <soc>". For now only
"-n k3" with non-secure boot (CRC32) is supported. A variant table
is added to hold the SoC-specific parameters, making it easier to
add K1 support and RSA authentication later.

Tested-by: E Shattow <e@freeshell.de>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 boot/image.c     |   1 +
 include/image.h  |   1 +
 tools/Makefile   |   1 +
 tools/smtimage.c | 208 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492f..289e80f23a7f 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -179,6 +179,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_TFA_BL31, "tfa-bl31",  "TFA BL31 Image", },
 	{	IH_TYPE_STM32IMAGE_V2, "stm32imagev2", "STMicroelectronics STM32 Image V2.0" },
 	{	IH_TYPE_AMLIMAGE,   "amlimage",   "Amlogic Boot Image" },
+	{	IH_TYPE_SMTIMAGE,   "smtimage",   "SpacemiT Boot Image" },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index 1de0a84007af..edbbcf45ba62 100644
--- a/include/image.h
+++ b/include/image.h
@@ -235,6 +235,7 @@ enum image_type_t {
 	IH_TYPE_TFA_BL31,		/* TFA BL31 image */
 	IH_TYPE_STM32IMAGE_V2,		/* STMicroelectronics STM32 Image V2.0 */
 	IH_TYPE_AMLIMAGE,		/* Amlogic Boot Image */
+	IH_TYPE_SMTIMAGE,		/* SpacemiT Boot Image */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
diff --git a/tools/Makefile b/tools/Makefile
index 535a5d51c89e..fc0aa52455aa 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -138,6 +138,7 @@ dumpimage-mkimage-objs := aisimage.o \
 			pbl_crc32.o \
 			renesas_spkgimage.o \
 			sfspl.o \
+			smtimage.o \
 			vybridimage.o \
 			stm32image.o \
 			$(ROCKCHIP_OBS) \
diff --git a/tools/smtimage.c b/tools/smtimage.c
new file mode 100644
index 000000000000..462279e80a3f
--- /dev/null
+++ b/tools/smtimage.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ *
+ * The SpacemiT boot image consists of a fixed image header followed by an
+ * aligned SPL payload and a trailing authentication area. The image header
+ * contains two metadata headers and areas reserved for authentication data.
+ *
+ * The image layout is:
+ *
+ *   0x000             root key
+ *   0x100             header0
+ *   0x120             key metadata
+ *   0x300             OEM keys
+ *   0xb00             signature0
+ *   0xfe0             header1
+ *   0x1000            SPL payload, with its end aligned to 32 bytes
+ *   payload end       signature1 (0x100 bytes)
+ */
+
+#include <image.h>
+#include "imagetool.h"
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <u-boot/crc.h>
+
+#define SMT_MAGIC		"AIHD"
+#define SMT_AUTH_SIZE		0x100
+
+#define SMT_FLAG_CRC32		(1U << 0)
+
+/**
+ * struct smtimage_header - metadata header within a SpacemiT boot image header
+ *
+ * @magic:	Magic (must be SMT_MAGIC)
+ * @version:	Image version used when anti-rollback is enabled by eFuse
+ * @secure:	Version slot used when anti-rollback is enabled by eFuse
+ * @reserved:	Reserved
+ * @image_size:	Header0 stores the image header size
+ *		Header1 stores the aligned payload size
+ * @load_addr:	Unused
+ * @header_crc:	Header0 and Header1 store the CRC32 of the preceding 24 bytes on K3
+ * @image_crc:	Header1 stores the CRC32 of the aligned payload on K3
+ */
+struct smtimage_header {
+	uint8_t magic[4];
+	uint8_t version;
+	uint8_t secure;
+	uint16_t reserved;
+	uint64_t image_size;
+	uint64_t load_addr;
+	uint32_t header_crc;
+	uint32_t image_crc;
+} __packed;
+
+/**
+ * struct smtimage_image_header - fixed header area of a SpacemiT boot image
+ *
+ * @root_key:	Root public key
+ * @header0:	Image layout and load information
+ * @key_data:	Key metadata
+ * @oem_keys:	OEM public-key area
+ * @signature0:	Signature of the image configuration
+ * @reserved:	Reserved
+ * @header1:	SPL payload information
+ */
+struct smtimage_image_header {
+	uint8_t root_key[0x100];
+	struct smtimage_header header0;
+	uint8_t key_data[0x1e0];
+	uint8_t oem_keys[0x800];
+	uint8_t signature0[SMT_AUTH_SIZE];
+	uint8_t reserved[0x3e0];
+	struct smtimage_header header1;
+} __packed;
+
+/**
+ * struct smtimage_variant - SoC-specific image properties
+ *
+ * @name:	SoC name passed to mkimage with -n
+ * @flags:	SoC-specific image flags
+ */
+struct smtimage_variant {
+	const char *name;
+	unsigned int flags;
+};
+
+static const struct smtimage_variant smtimage_variants[] = {
+	{
+		.name = "k3",
+		.flags = SMT_FLAG_CRC32,
+	},
+};
+
+static const struct smtimage_variant *smtimage_get_variant(const char *name)
+{
+	int i;
+
+	if (!name)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(smtimage_variants); i++)
+		if (!strcmp(name, smtimage_variants[i].name))
+			return &smtimage_variants[i];
+
+	return NULL;
+}
+
+static void smtimage_init_header(struct smtimage_header *header, uint64_t image_size,
+				 const struct smtimage_variant *variant)
+{
+	uint32_t crc;
+
+	memcpy(header->magic, SMT_MAGIC, sizeof(header->magic));
+
+	header->image_size = cpu_to_le64(image_size);
+
+	if (variant->flags & SMT_FLAG_CRC32) {
+		crc = crc32(0, (uint8_t *)header,
+			    offsetof(struct smtimage_header, header_crc));
+		header->header_crc = cpu_to_le32(crc);
+	}
+}
+
+static int smtimage_check_params(struct image_tool_params *params)
+{
+	if (!smtimage_get_variant(params->imagename)) {
+		fprintf(stderr, "%s: SpacemiT SoC must be specified with -n\n",
+			params->cmdname);
+		return EXIT_FAILURE;
+	}
+
+	if (!params->dflag)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static void smtimage_print_header(const void *buf, struct image_tool_params *params)
+{
+	const struct smtimage_image_header *image_header = buf;
+	const struct smtimage_header *header1 = &image_header->header1;
+	uint64_t payload_size = le64_to_cpu(header1->image_size);
+
+	printf("Image Type:   SpacemiT Boot Image\n");
+	printf("SoC Variant:  %s\n", params->imagename);
+	printf("Total Size:   %llu bytes\n",
+	       (unsigned long long)(sizeof(*image_header) + payload_size + SMT_AUTH_SIZE));
+	printf("Payload Size: %llu bytes\n", (unsigned long long)payload_size);
+}
+
+static void smtimage_set_header(void *buf, struct stat *sbuf, int infd,
+				struct image_tool_params *params)
+{
+	const struct smtimage_variant *variant = smtimage_get_variant(params->imagename);
+	struct smtimage_image_header *image_header = buf;
+	struct smtimage_header *header0 = &image_header->header0;
+	struct smtimage_header *header1 = &image_header->header1;
+	size_t payload_size;
+	uint32_t crc;
+
+	payload_size = sbuf->st_size - sizeof(*image_header) - SMT_AUTH_SIZE;
+
+	smtimage_init_header(header0, sizeof(*image_header), variant);
+	smtimage_init_header(header1, payload_size, variant);
+
+	if (variant->flags & SMT_FLAG_CRC32) {
+		crc = crc32(0, (uint8_t *)(image_header + 1), payload_size);
+		header1->image_crc = cpu_to_le32(crc);
+	}
+}
+
+static int smtimage_check_image_type(uint8_t type)
+{
+	if (type == IH_TYPE_SMTIMAGE)
+		return EXIT_SUCCESS;
+
+	return EXIT_FAILURE;
+}
+
+static int smtimage_vrec_header(struct image_tool_params *params,
+				struct image_type_params *tparams)
+{
+	size_t payload_size = params->file_size - tparams->header_size;
+
+	tparams->hdr = calloc(tparams->header_size, 1);
+
+	return ALIGN(payload_size, 32) - payload_size + SMT_AUTH_SIZE;
+}
+
+U_BOOT_IMAGE_TYPE(
+	smtimage,
+	"SpacemiT Boot Image support",
+	sizeof(struct smtimage_image_header),
+	NULL,
+	smtimage_check_params,
+	NULL,
+	smtimage_print_header,
+	smtimage_set_header,
+	NULL,
+	smtimage_check_image_type,
+	NULL,
+	smtimage_vrec_header
+);

-- 
2.55.0

