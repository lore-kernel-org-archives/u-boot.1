Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCACCE7A96
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 12:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1604386B4E;
	Mon, 25 Sep 2023 14:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=spox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E3286BE6; Mon, 25 Sep 2023 12:38:08 +0200 (CEST)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2593780569
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=spox.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wojciech.nizinski@grinn-global.com
Received: from localhost (95.143.241.142.ultranet.net.pl [95.143.241.142])
 by server220076.nazwa.pl (Postfix) with ESMTP id 3A90F1BD8E0;
 Mon, 25 Sep 2023 12:38:05 +0200 (CEST)
From: Wojciech Nizinski <niziak@spox.org>
To: u-boot@lists.denx.de
Cc: Wojciech Nizinski <niziak@spox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH] fastboot: fix CRC32 chunk size checking
Date: Mon, 25 Sep 2023 12:37:15 +0200
Message-Id: <20230925103714.4153612-1-niziak@spox.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 Sep 2023 14:16:34 +0200
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

genimage create android-sparse file with CRC32 chunk at end. When
U-Boot's fastboot receives this chunk it returns error message:
`Fail Bogus chunk size for chunk type Dont Care`

According to reference implementation of Android's sparse file format:

<https://android.googlesource.com/platform/system/core/+/refs/heads/main/
libsparse/output_file.cpp#513>

the chunk_header.total_sz is CHUNK_HEADER_LEN + 4 (CRC32 size).

Signed-off-by: Wojciech Nizinski <niziak@spox.org>
---

 lib/image-sparse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index 8f8a67e158..323aad981c 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -289,8 +289,8 @@ int write_sparse_image(struct sparse_storage *info,
 
 		case CHUNK_TYPE_CRC32:
 			if (chunk_header->total_sz !=
-			    sparse_header->chunk_hdr_sz) {
-				info->mssg("Bogus chunk size for chunk type Dont Care",
+			    sparse_header->chunk_hdr_sz + sizeof(uint32_t)) {
+				info->mssg("Bogus chunk size for chunk type CRC32",
 					   response);
 				return -1;
 			}
-- 
2.39.2

