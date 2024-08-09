Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5CBC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DF888C04;
	Fri,  9 Aug 2024 11:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46BB88BD9; Fri,  9 Aug 2024 11:55:06 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A0688BD9
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 2CFF16195FD7;
 Fri,  9 Aug 2024 11:55:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id OhiKQgnmC4TX; Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id A46C061966C1;
 Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id A1FFsfzv_2xc; Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 404C664D5E3D;
 Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, Jixiong.Hu@mediatek.com, marek.vasut+renesas@mailbox.org,
 patrick.delaunay@foss.st.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH v2 3/3] ext4: Fix zalloc()
Date: Fri,  9 Aug 2024 11:54:30 +0200
Message-Id: <20240809095430.3656-3-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240809095430.3656-1-richard@nod.at>
References: <20240809095430.3656-1-richard@nod.at>
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

Currently, zalloc() calls uncondtionally memset(),
if the allocation failes, memset() will write to a null pointer.

Fix by using kzalloc().

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ext4/ext4_common.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
index 84500e990a..346752092b 100644
--- a/fs/ext4/ext4_common.h
+++ b/fs/ext4/ext4_common.h
@@ -24,6 +24,7 @@
 #include <ext4fs.h>
 #include <malloc.h>
 #include <asm/cache.h>
+#include <linux/compat.h>
 #include <linux/errno.h>
 #if defined(CONFIG_EXT4_WRITE)
 #include "ext4_journal.h"
@@ -43,9 +44,7 @@
=20
 static inline void *zalloc(size_t size)
 {
-	void *p =3D memalign(ARCH_DMA_MINALIGN, size);
-	memset(p, 0, size);
-	return p;
+	return kzalloc(size, 0);
 }
=20
 int ext4fs_read_inode(struct ext2_data *data, int ino,
--=20
2.35.3

