Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FA1C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D818C80214;
	Thu, 23 Jan 2025 15:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="TOJ3O0Fu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A51780243; Thu, 23 Jan 2025 15:35:11 +0100 (CET)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B0680137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737642907; x=1737902107;
 bh=aZ6idz5T5ukylJcRIeuk1rnJ3wU9LG/QXt6RhXOApR8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=TOJ3O0FuXkQbKW84sFOFD81l8R+k+tVIzCKy28u7FOQB458jySbGKi5JF4Him5bjh
 1bo54m8UCwV6UrfuS7pk5imDR3+xs8i5fV423NYPaupq7jjZumPPlqvgbQn9cLllHG
 hCLaqEmYixV/r9Y6Sn2AdbANJ+ZWsCro6lXfpswMEBHBa6fLxRd4889z1NRNC7xEtS
 wsk74R1iK+tuUtceQck+McRNaFcLfQ9R6tQwp3VBGAJ8u2rYNF0UJpLvu8Sze6ghiT
 gZt9K7d2rMYNHlNPvq09cT4OS2dsF7KXECiVk0Qq3Xck3Q8c3LC/+/3sslTUqeEGDw
 P+lVXCHgF9Ufw==
Date: Thu, 23 Jan 2025 14:35:01 +0000
To: Tom Rini <trini@konsulko.com>, Safae Ouajih <souajih@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH] boot: android: handle boot images with missing DTB
Message-ID: <20250123-android-handle-no-dtb-v1-1-1cb7373247da@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 3573ca9c2977bb9b254268463194f463a9cdeb1e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

607b07554e2 removed the check on the return status of the
android_image_get_dtb_img_addr call from android_image_get_dtb_by_index,
which results in null pointer accesses shortly after when trying to
check the header of a nonexistent DTB.

Fixes: 607b07554e2 ("android: boot: move to andr_image_data structure")
Signed-off-by: Sam Day <me@samcday.com>
---
 boot/image-android.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 60a422dfb74a6c683b3cf9d2b19b3ad1dbd0d151..4fdf56dd1bd4ee26cd4d030532f=
75d8f48c0b8ee 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -696,7 +696,10 @@ bool android_image_get_dtb_by_index(ulong hdr_addr, ul=
ong vendor_boot_img,
 =09ulong dtb_addr;=09=09/* address of DTB blob with specified index  */
 =09u32 i;=09=09=09/* index iterator */
=20
-=09android_image_get_dtb_img_addr(hdr_addr, vendor_boot_img, &dtb_img_addr=
);
+=09if (!android_image_get_dtb_img_addr(hdr_addr, vendor_boot_img,
+=09=09=09=09=09    &dtb_img_addr))
+=09=09return false;
+
 =09/* Check if DTB area of boot image is in DTBO format */
 =09if (android_dt_check_header(dtb_img_addr)) {
 =09=09return android_dt_get_fdt_by_index(dtb_img_addr, index, addr,

---
base-commit: a3b71cc6f5cc74d4edc5808790a3d2999ea3f7fe
change-id: 20250123-android-handle-no-dtb-ac3e49f7bec6

Best regards,
--=20
Sam Day <me@samcday.com>


