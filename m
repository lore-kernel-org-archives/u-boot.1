Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D79C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 10:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39B388BAD;
	Fri,  2 Aug 2024 12:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33EF88BA4; Fri,  2 Aug 2024 12:09:02 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41AAE88B9D
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 12:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 1A2D564C3B23;
 Fri,  2 Aug 2024 12:08:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id mcFtR_KjIEEA; Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id CB73D64C3B26;
 Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id f8TfEaktGcbf; Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 610D264C3B23;
 Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, marek.vasut+renesas@mailbox.org,
 eugeneuriev@gmail.com, trini@konsulko.com, bmeng.cn@gmail.com,
 sjg@chromium.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/4] dlmalloc: Make sure allocation size is within malloc area
Date: Fri,  2 Aug 2024 12:08:46 +0200
Message-Id: <20240802100846.16619-4-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240802100846.16619-1-richard@nod.at>
References: <20240802100846.16619-1-richard@nod.at>
MIME-Version: 1.0
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

Since U-Boot does not support memory overcommit we can
enforce that the allocation size is within the malloc area.
This is a simple and efficient hardening measure to mitigate
further integer overflows in dlmalloc.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 common/dlmalloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index c8d1da1cb1..d264fc031a 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -1274,7 +1274,8 @@ Void_t* mALLOc_impl(bytes) size_t bytes;
     return NULL;
   }
=20
-  if ((long)bytes < 0) return NULL;
+  if (bytes > CONFIG_SYS_MALLOC_LEN || (long)bytes < 0)
+     return NULL;
=20
   nb =3D request2size(bytes);  /* padded request size; */
=20
@@ -1687,7 +1688,8 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem;=
 size_t bytes;
   }
 #endif
=20
-  if ((long)bytes < 0) return NULL;
+  if (bytes > CONFIG_SYS_MALLOC_LEN || (long)bytes < 0)
+     return NULL;
=20
   /* realloc of null is supposed to be same as malloc */
   if (oldmem =3D=3D NULL) return mALLOc_impl(bytes);
@@ -1907,7 +1909,8 @@ Void_t* mEMALIGn_impl(alignment, bytes) size_t alig=
nment; size_t bytes;
   mchunkptr remainder;        /* spare room at end to split off */
   long      remainder_size;   /* its size */
=20
-  if ((long)bytes < 0) return NULL;
+  if (bytes > CONFIG_SYS_MALLOC_LEN || (long)bytes < 0)
+     return NULL;
=20
 #if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
--=20
2.35.3

