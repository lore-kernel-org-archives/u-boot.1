Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CADC36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 17:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9080C810E8;
	Tue, 25 Mar 2025 18:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rums.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rums.se header.i=@rums.se header.b="U0B6xFpg";
	dkim=permerror (0-bit key) header.d=rums.se header.i=@rums.se header.b="ZgBb5/hE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4029F8192A; Tue, 25 Mar 2025 18:47:13 +0100 (CET)
Received: from mailrelay5-2.pub.mailoutpod2-cph3.one.com
 (mailrelay5-2.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:40a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F0F81026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 18:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=rums.se
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=onilsson@rums.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742924830;
 x=1743529630; d=rums.se; s=rsa2;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
 cc:to:from:from;
 bh=T0DeIW/ncBzGQ1xhzGO7f5BKo0qWsa2aaKCpcNN7sPM=;
 b=U0B6xFpgYhq0ZrufYsHIUnJJK5abOKbT1M0FPbZpIWMQACjwedlT2NT3qsOOpxliKj5tRU0sSgfIk
 BM4QIaPjzcqd/7J5hZupmGOgjQhB5dgoFAszWjds1+2KvdiXaO/KlSdC98BLFDlWQjWgcBCcwMTMC2
 99LgW/nMAMmPIGrukR5I61AhwOH1CUwlMBa+pbPv6Nl0VYBDjPfRqLUiInrs44iq1H1k33jBBercbj
 OHVAhyCwwXqA+e/pZw0VTozob8EQaV0KQTFqoN4WlyYJbPzcsHijvtbIft5ET3sAM5F2jgW+HQVOUu
 PhYMg3F2taB2CURI96lqjoebb+tAKLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742924830;
 x=1743529630; d=rums.se; s=ed2;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
 cc:to:from:from;
 bh=T0DeIW/ncBzGQ1xhzGO7f5BKo0qWsa2aaKCpcNN7sPM=;
 b=ZgBb5/hEuMSCWu7flHH//qb237IIKvFsA9Hi/ySGdnZxNvXyJhHFoPFTMrCS67p1q8yMYntb7tnso
 PuYWepFBA==
X-HalOne-ID: 2c8c8d8a-09a1-11f0-bc24-471e5e6299d9
Received: from ryzen.lan (c-85-226-134-249.bbcust.telenor.se [85.226.134.249])
 by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 2c8c8d8a-09a1-11f0-bc24-471e5e6299d9;
 Tue, 25 Mar 2025 17:47:10 +0000 (UTC)
From: Oskar Nilsson <onilsson@rums.se>
To: u-boot@lists.denx.de
Cc: Oskar Nilsson <onilsson@rums.se>, Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@denx.de>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH] ubi: fix bug creating partitions for non-existent volumes
Date: Tue, 25 Mar 2025 18:47:06 +0100
Message-ID: <20250325174708.426459-1-onilsson@rums.se>
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
+		return -1;
 
 	snprintf(info->name, PART_NAME_LEN, vol->name);
 
-- 
2.43.0

