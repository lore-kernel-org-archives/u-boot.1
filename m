Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D83EC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 12:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DEA88A74;
	Wed,  1 May 2024 14:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="H1AsOqnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAB4588AC0; Wed,  1 May 2024 10:54:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E879C88840
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 10:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1714553673; x=1715158473; i=fiona.klute@gmx.de;
 bh=De7ssdPcvFLmS8qz4oJHRi4zcgWyOb1ompWmrp0+geY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=H1AsOqnbQAPDxx+yOA0/qugIik7VrokqnucbKkh6t4LJCVDKpEce/lQxl3ozrCKm
 j0s+hp9tDsBmUGhhQqXnS022vzVRz02/0exFTb9M8kEfvOaTlGshabLcPiOT94DkQ
 G5oNlYHH39FSg7vYts/vTUhYYzHyYiix+2fsBGFShfV8HOfS1coTD6YBWL2mLRbay
 bz0JpWUisek/wCwnwJYOO1RToylw1y5cEKH15rQLct89XDZpiCpmN4h1HUYUUAIin
 lKpaDJXMbCmRADwX66fXxqmkUw/r9jMZioGgyAjWoljTFEMrl9manyiSDm8Ib8+f1
 2tronq1EDahsyj0Zeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.124.38]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bfq-1sihwV2fcs-016Kah; Wed, 01
 May 2024 10:54:33 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Fiona Klute <fiona.klute@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Bin Meng <bmeng.cn@gmail.com>, Rogier Stam <rogier@unrailed.org>
Subject: [PATCH] Init virtio before loading ENV from EXT4 or FAT
Date: Wed,  1 May 2024 10:54:09 +0200
Message-ID: <20240501085409.3457803-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PEyDt/JIGahKTf/E02NRmC6ufOMaxxZL5wSAzmxVSZ/usqF045b
 cCcljAKc+ToqShnE6E7EHrwz5vyJM51EU3lz16PlxTdRtwi8n2yMrpBBevlpgdAWwpUfCPW
 Zw32x3icue7YFkgGVcm2zva+O0MojPV/CrB00SV/YLBwnw//HoGjNS8rc+USVWBBJflCWNF
 +RS2UlF92Cm3oN3b7D9SQ==
UI-OutboundReport: notjunk:1;M01:P0:ZzEfcZ5CzO0=;Pv0r9GS+W1eVIl0dw4gyIXx+ShW
 i9Swg7E6X4tmwTjN+4vHXyYIHhiN56N1iTFJY6S3o5heiaOjuvHLsjTerPNrYFEDaYLDR8Xhe
 FAOD2Tq7eM6WRlazFNha+a7yj65j7mPO06piQzgEZwzDsrHRgA03N5VQ5bJXchkPpQfXat/4O
 gsE+f8MV3lwoarca08d8jy68YOo9BU+ZNMExsXrY2W/S+8ZjhpQVYE9lAOvkGJE2gF0ki6NrV
 VS32R14qahpKIry4kb/nRNffSphJyzOg2p8L8kKBpM/GBAusuthjR4Sr7FkIfovELPM1t7L/Z
 BZEQ8sfpQ9dqY6klpnpbtjOJeBO1ZEoCLsmxV2Mgah6TXjG4QTNDvV2HZRHvR6yiLVDTFmNYZ
 iTziEbnzvUvklhWCphrp1lJ9c8zn6s/t1fcMBHA0TZWZVZJdvAmlh7bE1C5eGsCT2khBh5N+z
 za2jKVDv3vkHcOeR5iGdceq8sq5qjR4t6FKlvCtU5xun7Ceb2BFyqBZCeuC3tfODOn1L1dUG8
 VHOCksZw0jnLj9WUywoaf5VwZkNOVLNwuJX7Mfd0F5/y4xyaQkm2eyiPGmTIRwd6OMWd0rcpc
 52rWYUkSHPvXXUrgTHsSr37cPNuKwcoc5XhaUSQ8zXYMsDYDa2cXvIA/suWu18zVq4cFWPE5W
 W9/wtjnuEYZ87tLgHJxG/Y91vYwUSIo1118kO6D8+aWxmpzpUYWDX/BPln+xCH+YBvbSwfnmm
 nNVovSrZODC2B1scLKPQ20ZwDoOuX3hJHs/QXUSSzlKMC4M59nkqnGkrvMC2pORoKfegKNVKY
 yBsEqFTrpfLK5YZndcXPjg1fufjPCCmWcUJLHonwPaD9k=
X-Mailman-Approved-At: Wed, 01 May 2024 14:59:11 +0200
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

Specifying a file in an EXT4 or FAT partition on a virtio device as
environment location failed because virtio hadn't been initialized by
the time the environment was loaded. This patch mirrors commit
54ee5ae84191 ("Add SCSI scan for ENV in EXT4 or FAT") in issue and
fix, just for a different kind of block device.

The additional include in include/virtio.h is needed so all functions
called there are defined, the alternative would have been to include
dm/device.h separately in the env/ sources.

Checkpatch suggests using "if (IS_ENABLED(CONFIG...))" instead of
"#if defined(CONFIG_...)", I'm sticking to the style of the existing
code here.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
CC: Joe Hershberger <joe.hershberger@ni.com>
CC: Bin Meng <bmeng.cn@gmail.com>
CC: Rogier Stam <rogier@unrailed.org>
=2D--
 env/ext4.c       | 5 +++++
 env/fat.c        | 5 +++++
 include/virtio.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/env/ext4.c b/env/ext4.c
index da26705b8d..f21939186f 100644
=2D-- a/env/ext4.c
+++ b/env/ext4.c
@@ -32,6 +32,7 @@
 #include <ext4fs.h>
 #include <mmc.h>
 #include <scsi.h>
+#include <virtio.h>
 #include <asm/global_data.h>

 DECLARE_GLOBAL_DATA_PTR;
@@ -151,6 +152,10 @@ static int env_ext4_load(void)
 	if (!strcmp(ifname, "scsi"))
 		scsi_scan(true);
 #endif
+#if defined(CONFIG_VIRTIO)
+	if (!strcmp(ifname, "virtio"))
+		virtio_init();
+#endif

 	part =3D blk_get_device_part_str(ifname, dev_and_part,
 				       &dev_desc, &info, 1);
diff --git a/env/fat.c b/env/fat.c
index 3172130d75..d87a47b100 100644
=2D-- a/env/fat.c
+++ b/env/fat.c
@@ -18,6 +18,7 @@
 #include <fat.h>
 #include <mmc.h>
 #include <scsi.h>
+#include <virtio.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <linux/stddef.h>
@@ -134,6 +135,10 @@ static int env_fat_load(void)
 	if (!strcmp(CONFIG_ENV_FAT_INTERFACE, "scsi"))
 		scsi_scan(true);
 #endif
+#if defined(CONFIG_VIRTIO)
+	if (!strcmp(ifname, "virtio"))
+		virtio_init();
+#endif
 #endif
 	part =3D blk_get_device_part_str(ifname, dev_and_part,
 				       &dev_desc, &info, 1);
diff --git a/include/virtio.h b/include/virtio.h
index 062a24630c..8113a59d79 100644
=2D-- a/include/virtio.h
+++ b/include/virtio.h
@@ -21,6 +21,7 @@
 #define __VIRTIO_H__

 #include <virtio_types.h>
+#include <dm/device.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #define VIRTIO_ID_NET		1 /* virtio net */
=2D-
2.43.0

