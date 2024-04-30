Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53C9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 16:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 186F288519;
	Tue, 30 Apr 2024 18:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D5688518; Tue, 30 Apr 2024 18:40:50 +0200 (CEST)
Received: from tianjin2.rivoreo.one (unknown [60.25.139.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82447888E6
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 18:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=whr@rivoreo.one
Received: from [10.1.105.1] (localhost [127.0.0.1])
 by tianjin2.rivoreo.one (Postfix) with ESMTP id C072772168;
 Wed,  1 May 2024 00:40:38 +0800 (CST)
Received: from 10.1.107.31 (SquirrelMail authenticated user whr)
 by _ with HTTP; Wed, 1 May 2024 00:40:38 +0800
Message-ID: <f1c277becf620ba6fd949758704076ce.squirrel@_>
Date: Wed, 1 May 2024 00:40:38 +0800
Subject: [PATCH] zfs: fix function 'zlib_decompress' pointlessly calling itself
From: "WHR" <whr@rivoreo.one>
To: u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>,
 mwleeds@mailtundra.com
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20240501004038_73634"
X-Priority: 3 (Normal)
Importance: Normal
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

------=_20240501004038_73634
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

In order to prevent crashing due to infinite recursion and actually
decompress the requested data, call the zlib function 'uncompress'
instead.

Signed-off-by: WHR <msl0000023508@gmail.com>

---
v2:
Resubmit with diff content in plain text.


------=_20240501004038_73634
Content-Type: text/plain;
 name="0001-zfs-fix-function-zlib_decompress-pointlessly-calling"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-zfs-fix-function-zlib_decompress-pointlessly-calling"

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index bfc11fa667..4896cc18ef 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -17,6 +17,7 @@
 #include <linux/time.h>
 #include <linux/ctype.h>
 #include <asm/byteorder.h>
+#include <u-boot/zlib.h>
 #include "zfs_common.h"
 #include "div64.h"
 
@@ -183,7 +184,8 @@ static int
 zlib_decompress(void *s, void *d,
 				uint32_t slen, uint32_t dlen)
 {
-	if (zlib_decompress(s, d, slen, dlen) < 0)
+	uLongf z_dest_len = dlen;
+	if (uncompress(d, &z_dest_len, s, slen) != Z_OK)
 		return ZFS_ERR_BAD_FS;
 	return ZFS_ERR_NONE;
 }
------=_20240501004038_73634--


