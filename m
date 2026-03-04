Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB34AEDEC1E
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 07:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E47E883D8A;
	Wed,  4 Mar 2026 08:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0692683F61; Wed,  4 Mar 2026 08:51:13 +0100 (CET)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 9BB31838BB
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 08:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 04 Mar 2026 16:51:06 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
 by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id C49D72069FEA;
 Wed,  4 Mar 2026 16:51:06 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Wed, 4 Mar 2026 16:51:06 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
 by kinkan3.css.socionext.com (Postfix) with ESMTP id 5627F1776;
 Wed,  4 Mar 2026 16:51:06 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] image-fit: Fix mismatched parameter type in comment
Date: Wed,  4 Mar 2026 16:51:00 +0900
Message-Id: <20260304075100.3637609-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The functions use 'ulong', however, the comments said 'uint32_t'.
Update the comments to match the prototype.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 boot/image-fit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index e7c7212195f..067ad236081 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -881,7 +881,7 @@ static int fit_image_get_address(const void *fit, int noffset, char *name,
  * fit_image_get_load() - get load addr property for given component image node
  * @fit: pointer to the FIT format image header
  * @noffset: component image node offset
- * @load: pointer to the uint32_t, will hold load address
+ * @load: pointer to the ulong, will hold load address
  *
  * fit_image_get_load() finds load address property in a given component
  * image node. If the property is found, its value is returned to the caller.
@@ -899,7 +899,7 @@ int fit_image_get_load(const void *fit, int noffset, ulong *load)
  * fit_image_get_entry() - get entry point address property
  * @fit: pointer to the FIT format image header
  * @noffset: component image node offset
- * @entry: pointer to the uint32_t, will hold entry point address
+ * @entry: pointer to the ulong, will hold entry point address
  *
  * This gets the entry point address property for a given component image
  * node.
-- 
2.34.1

