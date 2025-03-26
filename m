Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E85C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 09:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B2B80756;
	Wed, 26 Mar 2025 10:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rums.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rums.se header.i=@rums.se header.b="FYt0ps/8";
	dkim=permerror (0-bit key) header.d=rums.se header.i=@rums.se header.b="aA03J4F1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6A4810E8; Wed, 26 Mar 2025 10:23:14 +0100 (CET)
Received: from mailrelay1-2.pub.mailoutpod3-cph3.one.com
 (mailrelay1-2.pub.mailoutpod3-cph3.one.com [IPv6:2a02:2350:5:426::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE3E8070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=rums.se
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=onilsson@rums.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742980992;
 x=1743585792; d=rums.se; s=rsa2;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
 cc:to:from:from;
 bh=evXZDscElgBlzN3aKM51xLJQUC9ctuS6id+cBD9oyQE=;
 b=FYt0ps/8lWIUGHaGZG16kpp5Rxk/NW6zV7zL0AjVjuZnjGvZZ4ie0YW3KUTSJwoSwxjPvPvinOqh6
 QC2U5S8AGzxuJpK5XZx8+5sUj9fQjW7iL5Gk97NfTKVbXf2Wj3LGLnhe8preqmAmoqMiQ/grVhTG1p
 bQQacs/QWP5gq2DfpMGhPCh9LoFscdDOsL4gv4xk22V1VVj7RPi9N8TYxkpZYOoRixKXQjUDleSOE3
 mcNOLP74yDMll1Egujm1GkD4FOfoC4ZwVHa+qTNQOgdt0aN1eaRcOvD6/rTfEnK2bQh6WCQXGMqvOL
 NjbKhMOAlCTk8CcXMWaAmP/bPLQQvTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742980992;
 x=1743585792; d=rums.se; s=ed2;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
 cc:to:from:from;
 bh=evXZDscElgBlzN3aKM51xLJQUC9ctuS6id+cBD9oyQE=;
 b=aA03J4F1xl9k8DXAqJOUmUvxpZnUQeLHyvwig/ngejM+v9zi5s5Jxt0g9SUp6k6gnN45VKdID0aY9
 tK2vQaWDw==
X-HalOne-ID: ef1b844e-0a23-11f0-b8ab-152d8afab6bc
Received: from ryzen.lan (c-85-226-134-249.bbcust.telenor.se [85.226.134.249])
 by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id ef1b844e-0a23-11f0-b8ab-152d8afab6bc;
 Wed, 26 Mar 2025 09:23:11 +0000 (UTC)
From: Oskar Nilsson <onilsson@rums.se>
To: u-boot@lists.denx.de
Cc: Oskar Nilsson <onilsson@rums.se>, Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@denx.de>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2] ubi: fix bug creating partitions for non-existent volumes
Date: Wed, 26 Mar 2025 10:22:44 +0100
Message-ID: <20250326092257.443785-1-onilsson@rums.se>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The part_get_info_ubi() function was incorrectly returning 0 (success)
when a UBI volume was not found for a given partition index. This caused
the part_create_block_devices() function in blk-uclass.c to continue
creating devices for non-existent partitions up to MAX_SEARCH_PARTITIONS

Fix the issue by returning -1 when a volume is not found, signaling to
the part_create_block_devices() function that no more valid volumes
exist.

Before patch, 128 blk_partition are created:
Class   Index  Probed  Driver        Name
-------------------------------------------------
root        0  [ + ]  root_driver    root_driver
thermal     0  [   ]  imx_thermal    |-- imx_thermal
simple_bus  0  [ + ]  simple_bus     |-- soc
mtd         0  [ + ]  mxs-nand-dt    |   |-- nand-controller@1806000
blk         0  [   ]  ubi_blk        |   |   `-- nand-controller@1806000.blk
partition   0  [   ]  blk_partition  |   |       |-- nand-controller@1806000.blk:1
...
partition 127  [   ]  blk_partition  |   |       `-- nand-controller@1806000.blk:128


After patch, the expected blk_partition are created:
Class   Index  Probed  Driver        Name
-------------------------------------------------
root        0  [ + ]  root_driver    root_driver
thermal     0  [   ]  imx_thermal    |-- imx_thermal
simple_bus  0  [ + ]  simple_bus     |-- soc
mtd         0  [ + ]  mxs-nand-dt    |   |-- nand-controller@1806000
blk         0  [   ]  ubi_blk        |   |   `-- nand-controller@1806000.blk
partition   0  [   ]  blk_partition  |   |       |-- nand-controller@1806000.blk:1
partition   1  [   ]  blk_partition  |   |       |-- nand-controller@1806000.blk:2
partition   2  [   ]  blk_partition  |   |       |-- nand-controller@1806000.blk:3
partition   3  [   ]  blk_partition  |   |       `-- nand-controller@1806000.blk:4
simple_bus  1  [ + ]  simple_bus     |   |-- bus@2000000

Signed-off-by: Oskar Nilsson <onilsson@rums.se>
Cc: Kyungmin Park <kmpark@infradead.org>
Cc: Heiko Schocher <hs@denx.de>
Cc: Alexey Romanov <avromanov@salutedevices.com>

Changed in v2:
 - Change return from -1 to -ENOENT

---
 drivers/mtd/ubi/part.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/part.c b/drivers/mtd/ubi/part.c
index 13d1f165c30..a049bb295ce 100644
--- a/drivers/mtd/ubi/part.c
+++ b/drivers/mtd/ubi/part.c
@@ -47,7 +47,7 @@ static int __maybe_unused part_get_info_ubi(
 	 */
 	vol = ubi_get_volume_by_index(part_idx - 1);
 	if (!vol)
-		return 0;
+		return -ENOENT;
 
 	snprintf(info->name, PART_NAME_LEN, vol->name);
 
-- 
2.43.0

