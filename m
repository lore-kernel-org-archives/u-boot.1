Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB1CC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 11:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6733D81BEE;
	Tue, 28 Jan 2025 12:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X063vjsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6152381D42; Tue, 28 Jan 2025 12:18:48 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE9B81B4B
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 12:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+fuga.studiofuga.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8A16C5C5A8C;
 Tue, 28 Jan 2025 11:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D1CCC4CED3;
 Tue, 28 Jan 2025 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738063124;
 bh=Uqt2kxSNqDv6BD+W0UtzqzAvW3XrEFA0I1NGLTZ3n5U=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=X063vjsi6IvEP4V5ZooLAzPmpWvxoViijsTd2m/yo1Uj2F+l7CKuCEEomc5kF6akA
 fHMQBI5wTAcz7BuCkNx2oWhbtLVu6Jmc/ewq2Qtn6jafMNfNooubSqolRNJL17T7IG
 H+O/M560Ccrm4Oftjenqt6KWBFJ0ELS13rRo5DdtiBgNrPy9JoV3YN20WBG5t+GA9f
 O1xXMquhTIBaUnM+5NDk3adfM+4kXpgZC0+yOAyCPGL4E8QD3CoOtX2vQQvzjhzE5B
 YY9PTdNIqgrV0hNgWZuBVHQMSEdjqE7w/qLxTbP8o+9m42yf+/HeEC/XpCVEc+CYo4
 +vNo5TmM4mrZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 52322C0218D;
 Tue, 28 Jan 2025 11:18:44 +0000 (UTC)
From: Federico Fuga via B4 Relay <devnull+fuga.studiofuga.com@kernel.org>
Date: Tue, 28 Jan 2025 12:18:37 +0100
Subject: [PATCH] Fix fastboot handling of partitions when no slots are
 supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-fastboot_slot_fix-v1-1-1a4688936662@studiofuga.com>
X-B4-Tracking: v=1; b=H4sIAAy9mGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyML3bTE4pKk/PyS+OIcIJGWWaFrZmlkamhqbpZimZSkBNRXUJQKFAa
 bGR1bWwsAkAvxoGMAAAA=
X-Change-ID: 20250128-fastboot_slot_fix-69251576d9bb
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Federico Fuga <fuga@studiofuga.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3127;
 i=fuga@studiofuga.com; h=from:subject:message-id;
 bh=TKOjlYcOT6aH74HSyiAsmNFDbwha6KERQuHNXYuuMWg=;
 b=owGbwMvMwCWWHKr8a5mpjg3jabUkhvQZe4WOzZW80y9XezsuOSdl1urHn2zYErJedK8zNdvdM
 8/IZlFiRykLgxgXg6yYIsucl8/OZH3LPvtRd70WzBxWJpAhDFycAjCRN5cZ/gemTPScIO3qNf2n
 45nDu4wvJhaeWTh3eljedM5TvYYb52xl+MNRfJbZW8IkedsZieUyTprOhWWnHpYa65nUNm7ov2O
 8ixkA
X-Developer-Key: i=fuga@studiofuga.com; a=openpgp;
 fpr=9CE9E6CC6AF66BCDF12DAF2A635523FAA6352C3C
X-Endpoint-Received: by B4 Relay for fuga@studiofuga.com/default with
 auth_id=333
X-Original-From: Federico Fuga <fuga@studiofuga.com>
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
Reply-To: fuga@studiofuga.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Federico Fuga <fuga@studiofuga.com>

The fastboot module has a bug that prevents some command to work
properly on devices that haven't an Android-like partition scheme, that
is, just one spl and one kernel partition, instead of the redundant
scheme with _a and _b slots.

This is the schema of our NAND storage (board is based on an AllWinner
A33 sunxi chip):

=> mtdparts

device nand0 <1c03000.nand>, # parts = 4
 #: name         size            net size        offset          mask_flags
 0: spl          0x00020000      0x00020000      0x00000000      0
 1: uboot        0x00100000      0x00100000      0x00020000      0
 2: kernel_a     0x00400000      0x00400000      0x00120000      0
 3: ubi          0x07ae0000      0x079e0000 (!)  0x00520000      0

active partition: nand0,0 - (spl) 0x00020000 @ 0x00000000

This happens when we try to erase the spl partition using fastboot:

$ fastboot erase spl
Erasing 'spl_a'               FAILED (remote: 'invalid NAND device')
fastboot: error: Command failed

The error occurs because getvars fails to handle the error returned by
nand layer when a partition cannot be found.

Indeed, getvar_get_part_info returns what is returned by
fastboot_nand_get_part_info (0 on success, 1 on failure) but it should
return -ENODEV or -EINVAL instead. Since the cause of failure is not
returned by the nand function, I decided to return -EINVAL to make it
simple.

Signed-off-by: Federico Fuga <fuga@studiofuga.com>
---
 drivers/fastboot/fb_getvar.c | 5 ++++-
 drivers/fastboot/fb_nand.c   | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 9c2ce65a4e5bce0da6b18aa1b2818f7db556c528..816ed8a6213b5c1f0948a813c6f6a865a4b47ba8 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -121,8 +121,11 @@ static int getvar_get_part_info(const char *part_name, char *response,
 			*size = disk_part.size * disk_part.blksz;
 	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
 		r = fastboot_nand_get_part_info(part_name, &part_info, response);
-		if (r >= 0 && size)
+		if (r == 0 && size) {
 			*size = part_info->size;
+		} else {
+			r = -EINVAL;
+		}
 	} else {
 		fastboot_fail("this storage is not supported in bootloader", response);
 		r = -ENODEV;
diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index afc64fd5280717ae4041ed70268ccc01cfbb0496..9e2f7c01895785a4409eb67ea48abd02a6a6da26 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -151,7 +151,7 @@ static lbaint_t fb_nand_sparse_reserve(struct sparse_storage *info,
  *
  * @part_name: Named device to lookup
  * @part_info: Pointer to returned part_info pointer
- * @response: Pointer to fastboot response buffer
+ * @response: 0 on success, 1 otherwise
  */
 int fastboot_nand_get_part_info(const char *part_name,
 				struct part_info **part_info, char *response)

---
base-commit: a517796cfa5d8f4ca2f0c11c78c24a08a102c047
change-id: 20250128-fastboot_slot_fix-69251576d9bb

Best regards,
-- 
Federico Fuga <fuga@studiofuga.com>


