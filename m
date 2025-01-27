Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E9FC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB0378128B;
	Mon, 27 Jan 2025 14:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=studiofuga.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=studiofuga.com header.i=@studiofuga.com header.b="PgXkPhAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3544A80FF7; Mon, 27 Jan 2025 10:39:37 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05F0E801DE
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 10:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=studiofuga.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fuga@studiofuga.com
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YhNft4RJ6zHM2;
 Mon, 27 Jan 2025 10:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studiofuga.com;
 s=20220517; t=1737970774;
 bh=gBIkDbFBDx9DiQdplpyfEe+/gDLC7cI5C8GCZB58um4=;
 h=Date:From:Subject:Reply-To:References:To:In-Reply-To:From;
 b=PgXkPhAbyhDzl9ft6H/JlS2l7pTNda65HFe4heu2Ulg8WtUhzq3irKICmRlhU10sk
 Te6oLdNJQU80heZHuK/a/r8r1YqbOU7yB5p9aCAX4Fa1JewcLpvpTPHJNbuy/leGfd
 mNs1opz8esrDPTF1ejN3K4n3Aqh7PsgaQsAD2GPs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4YhNfs6QjnzkD6; Mon, 27 Jan 2025 10:39:33 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------NShKYbs8scpO4by2Y20GTiuz"
Message-ID: <add4f6ac-3dd5-4707-a40c-a41191e62912@studiofuga.com>
Date: Mon, 27 Jan 2025 10:39:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Federico Fuga <fuga@studiofuga.com>
Subject: [PATCH] Fix fastboot handling of partitions when no slots are,
 supported
Content-Language: en-US
References: <a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com>
To: u-boot@lists.denx.de, Federico Fuga <fuga@studiofuga.com>
Autocrypt: addr=fuga@studiofuga.com; keydata=
 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
 3Z10R+iQ3XwjCMCTFTN+4NBJ1U0=
In-Reply-To: <a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com>
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Mon, 27 Jan 2025 14:02:41 +0100
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
Reply-To: Federico Fuga <fuga@studiofuga.com>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This is a multi-part message in MIME format.
--------------NShKYbs8scpO4by2Y20GTiuz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


The fastboot module has a bug that prevents some command to work
properly on devices that haven't an Android-like partition scheme, that
is, just one spl and one kernel partition, instead of the redundant
scheme with _a and _b slots.

This is the schema of our NAND storage (board is based on an AllWinner
A33 sunxi chip):

=> mtdparts

device nand0 <1c03000.nand>, # parts = 4
   #: name         size            net size        offset mask_flags
   0: spl          0x00020000      0x00020000      0x00000000      0
   1: uboot        0x00100000      0x00100000      0x00020000      0
   2: kernel       0x00400000      0x00400000      0x00120000      0
   3: ubi          0x07ae0000      0x079e0000 (!)  0x00520000      0

active partition: nand0,0 - (spl) 0x00020000 @ 0x00000000

This happens when we try to erase the spl partition using fastboot:

$ fastboot erase spl
Erasing 'spl_a'               FAILED (remote: 'invalid NAND device')
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
   drivers/fastboot/fb_nand.c   | 2 +-
   2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 93cbd598e0..f5d8b03301 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -121,8 +121,11 @@ static int getvar_get_part_info(const char 
*part_name, char *response,
               *size = disk_part.size * disk_part.blksz;
       } else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
           r = fastboot_nand_get_part_info(part_name, &part_info, response);
-        if (r >= 0 && size)
+        if (r == 0 && size) {
               *size = part_info->size;
+        } else {
+            r = -EINVAL;
+        }
       } else {
           fastboot_fail("this storage is not supported in bootloader", 
response);
           r = -ENODEV;
diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index 5a55144479..3ee0f40ea8 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -141,7 +141,7 @@ static lbaint_t fb_nand_sparse_reserve(struct 
sparse_storage *info,
    *
    * @part_name: Named device to lookup
    * @part_info: Pointer to returned part_info pointer
- * @response: Pointer to fastboot response buffer
+ * @response: 0 on success, 1 otherwise
    */
   int fastboot_nand_get_part_info(const char *part_name,
                   struct part_info **part_info, char *response)
-- 
2.48.1


--------------NShKYbs8scpO4by2Y20GTiuz
Content-Type: application/pgp-keys; name="OpenPGP_0xEBBD37A93653C032.asc"
Content-Disposition: attachment; filename="OpenPGP_0xEBBD37A93653C032.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: 7bit

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
3Z10R+iQ3XwjCMCTFTN+4NBJ1U0=
=gKDV
-----END PGP PUBLIC KEY BLOCK-----


--------------NShKYbs8scpO4by2Y20GTiuz--
