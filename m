Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B361FC54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 15:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E617B82B0F;
	Thu, 29 May 2025 17:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA16B82DF2; Thu, 29 May 2025 17:02:53 +0200 (CEST)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3ED80F0E
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 8CB4A298575;
 Thu, 29 May 2025 17:02:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id gFJttN9IX_OL; Thu, 29 May 2025 17:02:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 2653E298580;
 Thu, 29 May 2025 17:02:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id MDnPjmQ6a8hB; Thu, 29 May 2025 17:02:51 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id C558D298575;
 Thu, 29 May 2025 17:02:50 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ddrokosov@salutedevices.com, sjg@chromium.org,
 tharvey@gateworks.com, ilias.apalodimas@linaro.org,
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at,
 Richard Weinberger <richard@nod.at>
Subject: [RFC, PATCH] fdt: Make sure there is no stale initrd left
Date: Thu, 29 May 2025 17:02:13 +0200
Message-ID: <20250529150213.27149-1-richard@nod.at>
X-Mailer: git-send-email 2.43.0
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

Although if we we don't setup an initrd, there could be a stale
initrd setting from the previous boot firmware in the live
device tree. So, make sure there is no setting left if we
don't want an initrd.

This can happen when booting on a Raspberry Pi. The boot firmware
can happily load an initrd before us and configuring the addresses
in the live device tree we get handed over.

Especially the setting `auto_initramfs` in config.txt is dangerous.
When enabled (default), the firmware tries to be smart and looks for
initramfs files.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
Hi!

This foot gun hit me hard and invalidated an A/B
update concept...

Thanks,
//richard
---
 boot/fdt_support.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 92f2f534ee0..b7331bb76b3 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -224,15 +224,24 @@ int fdt_initrd(void *fdt, ulong initrd_start, ulong=
 initrd_end)
 	int is_u64;
 	uint64_t addr, size;
=20
-	/* just return if the size of initrd is zero */
-	if (initrd_start =3D=3D initrd_end)
-		return 0;
-
 	/* find or create "/chosen" node. */
 	nodeoffset =3D fdt_find_or_add_subnode(fdt, 0, "chosen");
 	if (nodeoffset < 0)
 		return nodeoffset;
=20
+	/*
+	 * Although we didn't setup an initrd, there could be a stale
+	 * initrd setting from the previous boot firmware in the live
+	 * device tree. So, make sure there is no setting left if we
+	 * don't want an initrd.
+	 */
+	if (initrd_start =3D=3D initrd_end) {
+		fdt_delprop(fdt, nodeoffset, "linux,initrd-start");
+		fdt_delprop(fdt, nodeoffset, "linux,initrd-end");
+
+		return 0;
+	}
+
 	total =3D fdt_num_mem_rsv(fdt);
=20
 	/*
--=20
2.43.0

