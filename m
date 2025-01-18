Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EA5C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 14:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 413398070C;
	Sat, 18 Jan 2025 15:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=herb-clan.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E56980755; Sat, 18 Jan 2025 12:55:38 +0100 (CET)
Received: from leuchtturm3.herb-clan.de (leuchtturm3.herb-clan.de
 [159.69.115.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FF780657
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=herb-clan.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fabian@herb-clan.de
Received: from mail.herb-clan.de (unknown [192.168.51.232])
 by leuchtturm3.herb-clan.de (Postfix) with ESMTPS id 266971F71C
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 11:55:36 +0000 (UTC)
Received: from smtpclient.apple (unknown [172.16.5.226])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.herb-clan.de (Postfix) with ESMTPSA id 71FD81EB8
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:55:35 +0100 (CET)
From: Fabian Herb <fabian@herb-clan.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Accessing SPI NOR Flash as Block Device
Message-Id: <0FBFE017-1018-48C1-A490-4A4197F78DDB@herb-clan.de>
Date: Sat, 18 Jan 2025 12:55:25 +0100
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-Mailman-Approved-At: Sat, 18 Jan 2025 15:22:32 +0100
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

Hi everyone!

I=E2=80=99m trying to access a SquashFS image in serial SPI flash. A =
block device layer was added to MTD devices last August, but it was only =
activated for NAND flash (commit d12689a). So, without really knowing =
what I was doing, I patched NOR flash code in the same way [1], and sure =
enough, the block device is showing up in "lsblk=E2=80=9C and "dm =
tree=E2=80=9C:

=3D> dm tree=20
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 root          0  [ + ]   root_driver           root_driver
 simple_bus    0  [ + ]   simple_bus            |-- soc
 spi           0  [ + ]   sun4i_spi             |   |-- spi@1c05000
 spi_flash     0  [ + ]   jedec_spi_nor         |   |   `-- w25q128@0
 blk           0  [   ]   mtd_blk               |   |       `-- =
w25q128@0.blk <mailto:w25q128@0.blk>

But "sqfsls=E2=80=9C still doesn=E2=80=99t work on the block device. The =
problem seems to be that blk_get_devnum_by_uclass_idname() (in =
drivers/block/blk-uclass.c) expects the parent device of the block =
device to be UCLASS_MTD, but it is UCLASS_SPI_FLASH instead. This =
matches with the output of "dm tree=E2=80=9C.

I don=E2=80=99t know how to go from here. Is this an easy fix? Or a =
greater architectural endeavour?

Thanks and regards,
Fabian

=E2=80=94

[1]

diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index 7100b64bf22..582c7a0eae3 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -18,6 +18,10 @@
=20
 #include "sf_internal.h"
=20
+struct spi_nor_plat {
+	struct mtd_info *mtd;
+};
+
 static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info =3D {
@@ -208,14 +212,25 @@ static int spi_flash_std_get_sw_write_prot(struct =
udevice *dev)
 	return spi_flash_cmd_get_sw_write_prot(flash);
 }
=20
+static int spi_flash_std_bind(struct udevice *dev)
+{
+	struct spi_nor_plat *plat =3D dev_get_plat(dev);
+
+	return mtd_bind(dev, &plat->mtd);
+}
+
 int spi_flash_std_probe(struct udevice *dev)
 {
 	struct spi_slave *slave =3D dev_get_parent_priv(dev);
 	struct spi_flash *flash;
+	struct mtd_info *mtd =3D dev_get_uclass_priv(dev);
+	struct spi_nor_plat *plat =3D dev_get_plat(dev);
=20
 	flash =3D dev_get_uclass_priv(dev);
 	flash->dev =3D dev;
 	flash->spi =3D slave;
+	plat->mtd =3D mtd;
+
 	return spi_flash_probe_slave(flash);
 }
=20
@@ -260,6 +275,8 @@ U_BOOT_DRIVER(jedec_spi_nor) =3D {
 	.priv_auto	=3D sizeof(struct spi_nor),
 	.ops		=3D &spi_flash_std_ops,
 	.flags		=3D DM_FLAG_OS_PREPARE,
+	.bind =3D spi_flash_std_bind,
+	.plat_auto =3D sizeof(struct spi_nor_plat),
 };
=20
 DM_DRIVER_ALIAS(jedec_spi_nor, spansion_m25p16)

