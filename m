Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED4BCCFA18
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 01:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704D383AB4;
	Wed, 12 Nov 2025 02:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Jl8HfHzP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QdY0mBH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA5883BD2; Wed, 12 Nov 2025 02:17:29 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 304A283A94
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 02:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d5lr563mCz9v6M;
 Wed, 12 Nov 2025 02:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762910245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AOUfQx0InHOkxv4SmSMX2t1V5yyovXbjxeTYOsQfh8E=;
 b=Jl8HfHzPEhE3MzrK8ND8tnSGkPgf0DUWg4ncPSCK6Aq0OarRzUIEg823WLxayi2EeWVwu9
 9a1ms/NxTbGNVu5/bE3877MT7pIvN47mm2EnGLtmXCSEzDHzHT3PS/yo2ki+QrPqz9b77i
 yKjfPeBiL3CydvBUCbPlc6jKl92Onzw39HDYmy+zHVdLHPfZJ2JbgEywPYHwV63RvrA0fa
 b5S3uxmRDXhMabq35OZB+w0LvEoJmSvsxI4DMX/G5j6uNS6JQ+d0Ud9GkCUqz3Vq1h/oXu
 gza0isXk8eIab8nuumFtPjpaJkTyQ7ICXSGGfWjTGuwtRZexdUjERzcECNyRlA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762910244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AOUfQx0InHOkxv4SmSMX2t1V5yyovXbjxeTYOsQfh8E=;
 b=QdY0mBH9TCt91ZbQZIMQhePZ1DTSqlINo1ZXLggDDs55/zkE4wxvV8RvDzgx9Bj8jaMG9s
 vf3vx36n/ks5rpmGoKKFQlxl61XrxE5MtLnoqh2cIzIbjLqb4eT0mLiHGkT55xDjA2tP/C
 Lg3qLiY7729FqxOlqRiMxQdIDb7ttFxRaQPq2QSIWkZtnTxnZnmSSrtE0DUb954cpIRQBL
 IUWxNCXxp3kW0vM1GSKWfIWqwkwUWUhH/KxLF8x8W0dUYKPJo0l3ieoqgF6rW0PMqDe75M
 ueQO8Ql9JB/hu5HU60322yJ6WHT6ob1JfzUygIuCA+crLd1KKAckjc9zdUf+aA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with libfdt
Date: Wed, 12 Nov 2025 02:16:20 +0100
Message-ID: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 613317fadd51fab9a76
X-MBO-RS-META: pq5bpp387tgy48pbmof5d7m49xiwbxwt
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

Newer versions of libfdt strictly check whether the FDT blob
passed to them is at 8-byte aligned offset, if it is not, then
the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
android_image_print_dtb_contents() passed FDT directly mapped
from abootimg to libfdt, and this FDT is not always aligned to
8-byte offset. Specifically, the FDTs are somewhat packed in
the abootimg, therefore if the first FDT blob is e.g. 0xfd bytes
long, then the next FDT blob ends up at 0xfd offset, which is
not 8-byte aligned.

Fix this by first extracting the header into 8-byte aligned buffer,
checking only the header for validity, and then by copying the
entire FDT into newly allocated 8-byte aligned buffer. While this
is not efficient, it is the correct way to handle DTs, which must
be at 8-byte aligned offsets. Mitigate the inefficiency for the
common case by checking whether the DT might be 8-byte aligned and
if it is, map it directly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Kling <webgeek1234@gmail.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>
Cc: George Chan <gchan9527@gmail.com>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nicolas Belin <nbelin@baylibre.com>
Cc: Sam Day <me@samcday.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 boot/image-android.c | 46 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index e46dee0d9b3..5ff2bf664e5 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -721,17 +721,19 @@ bool android_image_get_dtb_by_index(ulong hdr_addr, ulong vendor_boot_img,
 	dtb_addr = dtb_img_addr;
 	while (dtb_addr < dtb_img_addr + dtb_img_size) {
 		const struct fdt_header *fdt;
+		struct fdt_header fdth __aligned(8);
 		u32 dtb_size;
 
 		fdt = map_sysmem(dtb_addr, sizeof(*fdt));
-		if (fdt_check_header(fdt) != 0) {
-			unmap_sysmem(fdt);
+		memcpy(&fdth, fdt, sizeof(*fdt));
+		unmap_sysmem(fdt);
+
+		if (fdt_check_header(&fdth) != 0) {
 			printf("Error: Invalid FDT header for index %u\n", i);
 			return false;
 		}
 
-		dtb_size = fdt_totalsize(fdt);
-		unmap_sysmem(fdt);
+		dtb_size = fdt_totalsize(&fdth);
 
 		if (i == index) {
 			if (size)
@@ -885,23 +887,45 @@ bool android_image_print_dtb_contents(ulong hdr_addr)
 	dtb_addr = dtb_img_addr;
 	while (dtb_addr < dtb_img_addr + dtb_img_size) {
 		const struct fdt_header *fdt;
+		struct fdt_header *fulldt;
+		struct fdt_header fdth __aligned(8);
 		u32 dtb_size;
 
 		fdt = map_sysmem(dtb_addr, sizeof(*fdt));
-		if (fdt_check_header(fdt) != 0) {
-			unmap_sysmem(fdt);
+		memcpy(&fdth, fdt, sizeof(*fdt));
+		unmap_sysmem(fdt);
+
+		if (fdt_check_header(&fdth) != 0) {
 			printf("Error: Invalid FDT header for index %u\n", i);
 			return false;
 		}
 
-		res = android_image_print_dtb_info(fdt, i);
-		if (!res) {
+		dtb_size = fdt_totalsize(&fdth);
+
+		/* The device tree must be at an 8-byte aligned address */
+		if ((uintptr_t)fdt & 7) {
+			fulldt = memalign(8, dtb_size);
+			if (!fulldt)
+				return false;
+
+			fdt = map_sysmem(dtb_addr, dtb_size);
+			memcpy(fulldt, fdt, dtb_size);
 			unmap_sysmem(fdt);
-			return false;
+		} else {
+			fulldt = map_sysmem(dtb_addr, dtb_size);
 		}
 
-		dtb_size = fdt_totalsize(fdt);
-		unmap_sysmem(fdt);
+		res = android_image_print_dtb_info(fulldt, i);
+
+		/* The device tree must be at an 8-byte aligned address */
+		if ((uintptr_t)fdt & 7)
+			free(fulldt);
+		else
+			unmap_sysmem(fulldt);
+
+		if (!res)
+			return false;
+
 		dtb_addr += dtb_size;
 		++i;
 	}
-- 
2.51.0

