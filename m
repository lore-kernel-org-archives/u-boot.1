Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F5FCD37BC
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 13:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F30E8689A;
	Sat, 16 Sep 2023 15:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lahfa.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7079986672; Sat, 16 Sep 2023 15:19:34 +0200 (CEST)
Received: from nef.ens.fr (nef2.ens.fr [129.199.96.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C82C86589
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 15:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lahfa.xyz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan.lahfa@ens.fr
X-ENS-nef-client: 129.199.1.22 ( name = clipper-gw.ens.fr )
Received: from clipper.ens.fr (clipper-gw.ens.fr [129.199.1.22])
 by nef.ens.fr (8.14.4/1.01.28121999) with ESMTP id 38GDJOo3001294
 ; Sat, 16 Sep 2023 15:19:25 +0200
Received: from  localhost using smtps by clipper.ens.fr (8.14.4/jb-1.1)
 id 38GDJOva123119 ; Sat, 16 Sep 2023 15:19:24 +0200 (authenticated user rlahfa)
X-ENS-Received: (bny92-8_migr-88-174-101-154.fbx.proxad.net [88.174.101.154]
 (may be forged))
From: Ryan Lahfa <ryan-uboot@lahfa.xyz>
To: u-boot@lists.denx.de
Cc: Ryan Lahfa <ryan-uboot@lahfa.xyz>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Zhaofeng Li <hello@zhaofeng.li>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ramon Fried <rfried.dev@gmail.com>, Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] boot/pxe-utils: populate initrd_filesize for extlinux boot
Date: Sat, 16 Sep 2023 15:14:58 +0200
Message-ID: <20230916131812.4035430-3-ryan-uboot@lahfa.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230916131812.4035430-1-ryan-uboot@lahfa.xyz>
References: <20230916131812.4035430-1-ryan-uboot@lahfa.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (nef.ens.fr [129.199.96.32]); Sat, 16 Sep 2023 15:19:25 +0200 (CEST)
X-Mailman-Approved-At: Sat, 16 Sep 2023 15:31:28 +0200
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

Currently, it seems like the `initrd_filesize` was uninitialized for a
while.

This is particularly problematic when attempting to `zboot` with a
initrd with a size coming from `label->initrd`, because it will provide
you with a 0-long initrd at boot time, making the kernel fail to
continue the boot.

This fixes the issue and I confirmed it enable me booting a U-Boot on
QEMU x86_64 q35 with NixOS kernel and initrds.

Signed-off-by: Ryan Lahfa <ryan-uboot@lahfa.xyz>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Zhaofeng Li <hello@zhaofeng.li>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Artem Lapkin <email2tema@gmail.com>
---
 boot/pxe_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index d13c47dd94..fa5e88ab95 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -556,6 +556,8 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		}
 
 		initrd_addr_str = env_get("ramdisk_addr_r");
+		/* Copy the actual initrd size inside the initrd_filesize */
+		snprintf(initrd_filesize, sizeof(initrd_filesize), "%lx", size);
 		size = snprintf(initrd_str, sizeof(initrd_str), "%s:%lx",
 				initrd_addr_str, size);
 		if (size >= sizeof(initrd_str))
-- 
2.42.0

