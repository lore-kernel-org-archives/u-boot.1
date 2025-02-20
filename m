Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB7DC021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDCF80F7A;
	Thu, 20 Feb 2025 22:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="MVqy9Ugj";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hhvkomvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED48180F42; Thu, 20 Feb 2025 15:58:24 +0100 (CET)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80958007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 15:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1740063502; x=1771599502;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=12vdHZvmdSO9sUWlhr4Hh1LSegJy2Pex5g2MmDSBMsA=;
 b=MVqy9UgjfybcMKFWjtuoA+EP3v0Li7l+8oTXroNyMshJnbojXJ/Y6M9m
 gQoh8ww7OdqmoiQ7fOvSpzMMSYWgK1+jVBuCOUHxNUQCzOo2ERD0p1ueH
 kr28jzpKnS25PWOLuaH6eSWgemLXWbHT5DgCfD9y+O5sP3fqD66lQAQBK
 Kvf+OtIuTq1M3pNdIP2nBtC3uGbPrswXwnd+IR5RowsPeiTdmcWrTHOyh
 ewSGwsF0L8kpzLKpMLS3/NJv9DlWwQeixnSd0ebUbbF0vqKnwmnWUeAlB
 Vfw3huFVpi6wPGxAHoxqcaUBem91N4RVStXedIMxRQbkNWP0K0Fza2MgN w==;
X-CSE-ConnectionGUID: G2eMrZfJQFerBMXn3amKdw==
X-CSE-MsgGUID: 2qYQIVWZTvOz3ms7lh33Bg==
X-IronPort-AV: E=Sophos;i="6.13,301,1732575600"; d="scan'208";a="41984322"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 20 Feb 2025 15:58:14 +0100
X-CheckPoint: {67B74306-33-EBA888C4-C1AC8B84}
X-MAIL-CPID: 02A7DACACE81B81D6AF3B999186A90DB_0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7AF5D1657D9; Thu, 20 Feb 2025 15:58:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1740063490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=12vdHZvmdSO9sUWlhr4Hh1LSegJy2Pex5g2MmDSBMsA=;
 b=hhvkomvh8Icgqrztp5j36NmjcqWooZYw7TKxHPLLPTNZJ3gjtRTZ7V3sRAW55VUSg/R9p7
 NM4UZU1fpBsx2r0XwQj6SrUiq3rr22hLYu/D3Apf6aS95Rf/1NPzw8B/nswgVaoi+zBF1B
 K6HYAv6hBsnZbGMfqgWfL3GVSZuqnW6RTAWaNCuwgWyiv81dBxgFL+R16TSgK6e/5vS4Ss
 T15WiwJe/SieTE2eEI0y4SKEM4GcU21oj+xHs09ZtFXX7rQl3njryOW0eS2PEZTTco2mrZ
 n70HmSn0HY+na3UzPfH4eOTtzZywyydZpcCNEyq5/l7yjpGZ4WzHZzF6BoTqWw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] mtd: mtdpart: Support MTD_SIZE_REMAINING with unallocated
 memory area
Date: Thu, 20 Feb 2025 15:58:07 +0100
Message-ID: <20250220145808.1911832-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:01:46 +0100
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

If there is an unallocated memory area before the last, filling parting
the size calculation for MTD_SIZE_REMAINING does not take this hole
into account.
Fix this by calculating the remaining size just based on total size
and partition offset.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mtd/mtdpart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 4886392a1cf..4bc0960bb3c 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -207,7 +207,7 @@ int mtd_parse_partitions(struct mtd_info *parent, const char **_mtdparts,
 {
 	struct mtd_partition partition = {}, *parts;
 	const char *mtdparts = *_mtdparts;
-	uint64_t cur_off = 0, cur_sz = 0;
+	uint64_t cur_off = 0;
 	int nparts = 0;
 	int ret, idx;
 	u64 sz;
@@ -236,8 +236,7 @@ int mtd_parse_partitions(struct mtd_info *parent, const char **_mtdparts,
 			return ret;
 
 		if (parts[idx].size == MTD_SIZE_REMAINING)
-			parts[idx].size = parent->size - cur_sz;
-		cur_sz += parts[idx].size;
+			parts[idx].size = parent->size - parts[idx].offset;
 
 		sz = parts[idx].size;
 		if (sz < parent->writesize || do_div(sz, parent->writesize)) {
-- 
2.43.0

