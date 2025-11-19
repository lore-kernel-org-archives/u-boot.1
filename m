Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FA8CF58C9
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 19:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2325E83F60;
	Wed, 19 Nov 2025 20:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E5RCyKvN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FuiOcOmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F95683F2D; Wed, 19 Nov 2025 20:33:21 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5726683D3C
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 20:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dBWqM0SyTz9tl6;
 Wed, 19 Nov 2025 20:33:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763580799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g/aaQ7C/BEH6BnUI38dI5ZBBYIBOREwzdaewysQZhbk=;
 b=E5RCyKvNud1orrVFgLIZkxwJlG+8Z9RAgGAWjRt5naF22ZD/rurJ7jonC/afXVxvxScvnd
 poBQgAt2jeOB05lCCO05qO3rLnc+ydbrvWJkp93Q23yBQmXoZWINMmd5YeB2JLbuteNhtt
 hAudAsKivgOCs5/4tTGr2pMmW6yb+O436aaWh3aF48DMCFoxUfo+lfSmVKsEf3Q9Hq9eCa
 QJzIkkcx9G8sGiSRJEBoVKam1XjSUG13VdKH96pUTiaClVVSPZMNRdijJwWrH7rLIs7ZQH
 nWT7vixkiQZQEOeirBfg8nsOPtda2DN01/prwxLejzatyHD+Py2JvQpx+51eOQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763580797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g/aaQ7C/BEH6BnUI38dI5ZBBYIBOREwzdaewysQZhbk=;
 b=FuiOcOmbFxKiwjyuUHsE7QLv/0k6+6AnjXLm+YFQzgUgNZI5Y9g2Srnnpei11egIK9QOhh
 XEJYXerTkzY7ZjQzYu0DkYyA9maEHdvdK6YIImyXw46qIzUKCHzIpfLl6mm2U2GahW1c2b
 657Vw44dJ8DF0uKs90P+dtf4Rjm9i5Un7myi1dIqREduckExAj9J3sOqchqGp/KmfUepCK
 397rcsvUPLMH1AevHsnwkCOF9k5CBQk0Ol1reYnrBx9RbgjaNu2uku0iBA20qhlryzT8Wf
 6w3HxxJG1eNI3r2gmU/hDnjHl+yWE2O5vVjM4aSU88Ho2TDtEJ0i7MAj8uPPHQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] boot: android: Always use 8-byte aligned DT with libfdt
Date: Wed, 19 Nov 2025 20:32:51 +0100
Message-ID: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: aajj99zs94h3j15jzx1nrdoybgwe8yre
X-MBO-RS-ID: 1d57cc05e3f350b1488
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
V2: - Turn the two conditionals into single conditional
    - Use IS_ALIGNED()
V3: - Flip the IS_ALIGNED() conditional to check the right thing
---
 boot/image-android.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index e46dee0d9b3..ea47869a64c 100644
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
@@ -885,23 +887,41 @@ bool android_image_print_dtb_contents(ulong hdr_addr)
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
+		if (!IS_ALIGNED((uintptr_t)fdt, 8)) {
+			fulldt = memalign(8, dtb_size);
+			if (!fulldt)
+				return false;
+
+			fdt = map_sysmem(dtb_addr, dtb_size);
+			memcpy(fulldt, fdt, dtb_size);
 			unmap_sysmem(fdt);
-			return false;
+			res = android_image_print_dtb_info(fulldt, i);
+			free(fulldt);
+		} else {
+			fulldt = map_sysmem(dtb_addr, dtb_size);
+			res = android_image_print_dtb_info(fulldt, i);
+			unmap_sysmem(fulldt);
 		}
 
-		dtb_size = fdt_totalsize(fdt);
-		unmap_sysmem(fdt);
+		if (!res)
+			return false;
+
 		dtb_addr += dtb_size;
 		++i;
 	}
-- 
2.51.0

