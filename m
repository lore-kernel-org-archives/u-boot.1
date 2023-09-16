Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C57CD37BB
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 13:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E43F867EF;
	Sat, 16 Sep 2023 15:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lahfa.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13338662F; Sat, 16 Sep 2023 15:18:26 +0200 (CEST)
Received: from nef.ens.fr (nef2.ens.fr [129.199.96.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFBA48654B
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 15:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lahfa.xyz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan.lahfa@ens.fr
X-ENS-nef-client: 129.199.1.22 ( name = clipper-gw.ens.fr )
Received: from clipper.ens.fr (clipper-gw.ens.fr [129.199.1.22])
 by nef.ens.fr (8.14.4/1.01.28121999) with ESMTP id 38GDINoE001206
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 15:18:23 +0200
Received: from  localhost using smtps by clipper.ens.fr (8.14.4/jb-1.1)
 id 38GDINru121649 for <u-boot@lists.denx.de>;
 Sat, 16 Sep 2023 15:18:23 +0200 (authenticated user rlahfa)
X-ENS-Received: (bny92-8_migr-88-174-101-154.fbx.proxad.net [88.174.101.154]
 (may be forged))
X-Envelope-To: <u-boot@lists.denx.de>
From: Ryan Lahfa <ryan-uboot@lahfa.xyz>
To: u-boot@lists.denx.de
Subject: zboot: [PATCH] boot/pxe-utils: populate initrd_filesize for extlinux
 boot
Date: Sat, 16 Sep 2023 15:14:56 +0200
Message-ID: <20230916131812.4035430-1-ryan-uboot@lahfa.xyz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (nef.ens.fr [129.199.96.32]); Sat, 16 Sep 2023 15:18:23 +0200 (CEST)
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

The reason for this is that initrd_filesize is constantly equal to zero
or more specifically, potentially uninitialized memory.

I believe this was introduced in
085cbdafca9c3d7bc2f27523a343f61db82f2ccb ("pxe: simplify label_boot()"),
diff here:

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index b08aee9896..defbe465e4 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -532,11 +532,10 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		}
 
 		initrd_addr_str = env_get("ramdisk_addr_r");
-		strcpy(initrd_filesize, simple_xtoa(size));
-
-		strncpy(initrd_str, initrd_addr_str, 18);
-		strcat(initrd_str, ":");
-		strncat(initrd_str, initrd_filesize, 9);
+		size = snprintf(initrd_str, sizeof(initrd_str), "%s:%lx",
+				initrd_addr_str, size);
+		if (size >= sizeof(initrd_str))
+			return 1;
 	}
 
 	if (get_relfile_envaddr(ctx, label->kernel, "kernel_addr_r",

The initrd_filesize completely disappears.

We re-copy the size information inside initrd_filesize, maybe, too
naively, something may have to be done to reduce the overflow potential
if it exist at all.

pxe_utils.c |    2 ++
 1 file changed, 2 insertions(+)

