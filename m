Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748F6FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0900284353;
	Sat, 25 Apr 2026 18:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="anNe8jSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 229DD84307; Sat, 25 Apr 2026 18:21:33 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A666183FB0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C75C1113EC9; Fri, 24 Apr 2026 05:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777001673; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=XvAF1MvuDmuaq8/lCMu2laOm9UdT/sKurjF2POSfH2w=;
 b=anNe8jSiMZ4qm+BTsm2/rDY6aWJGjnW8HIQ7iuLdx/GxSf4D5MCoi8TdC0kUxePvTlkcF1
 DnzNMLMOx+vsdriDo3aS27XqfH7aKcYVSuQZQksr2aKbqtKNLii5QXaO+adb+r3RUJOCne
 UHhk0C0/nY0yMdVVcNjeNy2EPT97QV/eEoJFLa949ddorI1CJyGR5xi8TSFl3a239LUnRh
 Nmz/e6k2786qkVgpSIm4s9XZd/QNdhLg1sXcyjvKJrGoghztsP9EgsMG/ffAiS+bWAwEXN
 ge7icISm/YRQvLqFjvQGy/TLj0eHWCvpQ5pVfCxeNvj9UWtRm7pCI5pKc31m/w==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: ums: Switch HW partition before block access
Date: Fri, 24 Apr 2026 05:33:38 +0200
Message-ID: <20260424033401.90360-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

An UMS session with eMMC device specifier "ums C mmc dev.part1,dev.part2"
exposes the same eMMC HW partition 'part2' twice instead of exposing both
HW partitions 'part1' and 'part2'. Fix this by switching the eMMC HW
partition before block device read/write access.

An eMMC is represented by a single struct blk_desc, with the currently
selected HW partition being stored in this struct blk_desc. Each call to
part_get_info_by_dev_and_name_or_num() with partition string dev[.partN]
does trigger HW partition switch by calling blk_get_device_part_str() ->
blk_get_device_part_str() -> get_dev_hwpart() -> get_dev_hwpart() ->
blk_dselect_hwpart(). The ums_init() iterates over the device specifier
string and calls part_get_info_by_dev_and_name_or_num() in a loop for
each dev[.partN] entry used as the partition string. If the device
specifier string contains more than one dev[.partN] partition strings
for the same dev device, then it is the HW partition described in the
last dev[.partN] partition string entry that is accessed for all dev
device partition strings in the device specifier string, because that
last dev[.partN] partition string entry was the last one that triggered
blk_dselect_hwpart() call for that device.

To access the expected HW partition for every dev[.partN] partition string
entry, it is necessary to call blk_dselect_hwpart() before each block read
or write. Store HW partition described for each dev[.partN] partition string
in struct ums and use the stored value to make it so.

The blk_dselect_hwpart() does test whether the currently selected HW
partition is already configured in hardware and does not reconfigure
the hardware if that is the case, therefore for the majority of block
reads and writes, blk_dselect_hwpart() is a no-op with negligible
performance impact.

Example reproducer is listed below. The last sector of both eMMC HW BOOT
partitions is populated with distinct test pattern and UMS is launched:

"
=> mmc dev 1 1 ; mmc read $loadaddr 0x1fff 1 ; md $loadaddr 4
switch to partitions #1, OK
mmc1(part 1) is current device
MMC read: dev # 1, block # 8191, count 1 ... 1 blocks read: OK
84000000: 1234abcd 1234abcd 1234abcd 1234abcd  ..4...4...4...4.

=> mmc dev 1 2 ; mmc read $loadaddr 0x1fff 1 ; md $loadaddr 4
switch to partitions #2, OK
mmc1(part 2) is current device
MMC read: dev # 1, block # 8191, count 1 ... 1 blocks read: OK
84000000: 567890ef 567890ef 567890ef 567890ef  ..xV..xV..xV..xV

=> ums 0 mmc 1.1,1.2
UMS: LUN 0, dev mmc 1, hwpart 1, sector 0x0, count 0x2000
UMS: LUN 1, dev mmc 1, hwpart 2, sector 0x0, count 0x2000
"

Read of the two block devices on host without this fix produces
identical data present in HW BOOT partition 2:

"
$ dd if=/dev/sdX of=mmc-a.bin ; dd if=/dev/sdY of=mmc-b.bin
$ hexdump -C mmc-a.bin | tail -n 3 | head -n 1 ; \
  hexdump -C mmc-b.bin | tail -n 3 | head -n 1
003ffe00  ef 90 78 56 ef 90 78 56  ef 90 78 56 ef 90 78 56  |..xV..xV..xV..xV|
003ffe00  ef 90 78 56 ef 90 78 56  ef 90 78 56 ef 90 78 56  |..xV..xV..xV..xV|
"

Read of the two block devices on host with this fix produces the
expected distinct data from either HW BOOT partition 1 or 2:

"
$ dd if=/dev/sdX of=mmc-a.bin ; dd if=/dev/sdY of=mmc-b.bin
$ hexdump -C mmc-a.bin | tail -n 3 | head -n 1 ; \
  hexdump -C mmc-b.bin | tail -n 3 | head -n 1
003ffe00  cd ab 34 12 cd ab 34 12  cd ab 34 12 cd ab 34 12  |..4...4...4...4.|
003ffe00  ef 90 78 56 ef 90 78 56  ef 90 78 56 ef 90 78 56  |..xV..xV..xV..xV|
"

Reported-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 cmd/usb_mass_storage.c     | 11 +++++++++++
 include/usb_mass_storage.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
index 47e8b70cd10..e8b87045bdc 100644
--- a/cmd/usb_mass_storage.c
+++ b/cmd/usb_mass_storage.c
@@ -24,6 +24,11 @@ static int ums_read_sector(struct ums *ums_dev,
 {
 	struct blk_desc *block_dev = &ums_dev->block_dev;
 	lbaint_t blkstart = start + ums_dev->start_sector;
+	int ret;
+
+	ret = blk_dselect_hwpart(block_dev, ums_dev->hwpart);
+	if (ret && ret != -ENOSYS)
+		return ret;
 
 	return blk_dread(block_dev, blkstart, blkcnt, buf);
 }
@@ -33,6 +38,11 @@ static int ums_write_sector(struct ums *ums_dev,
 {
 	struct blk_desc *block_dev = &ums_dev->block_dev;
 	lbaint_t blkstart = start + ums_dev->start_sector;
+	int ret;
+
+	ret = blk_dselect_hwpart(block_dev, ums_dev->hwpart);
+	if (ret && ret != -ENOSYS)
+		return ret;
 
 	return blk_dwrite(block_dev, blkstart, blkcnt, buf);
 }
@@ -110,6 +120,7 @@ static int ums_init(const char *devtype, const char *devnums_part_str)
 		snprintf(name, UMS_NAME_LEN, "UMS disk %d", ums_count);
 		ums[ums_count].name = name;
 		ums[ums_count].block_dev = *block_dev;
+		ums[ums_count].hwpart = block_dev->hwpart;
 
 		printf("UMS: LUN %d, dev %s %d, hwpart %d, sector %#x, count %#x\n",
 		       ums_count, devtype, ums[ums_count].block_dev.devnum,
diff --git a/include/usb_mass_storage.h b/include/usb_mass_storage.h
index 6d83d93cad7..9be704ea8b7 100644
--- a/include/usb_mass_storage.h
+++ b/include/usb_mass_storage.h
@@ -22,6 +22,7 @@ struct ums {
 	unsigned int num_sectors;
 	const char *name;
 	struct blk_desc block_dev;
+	int hwpart;
 };
 
 int fsg_init(struct ums *ums_devs, int count, struct udevice *udc);
-- 
2.53.0

