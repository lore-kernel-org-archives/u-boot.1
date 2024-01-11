Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292C4C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 07:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 865D4878C8;
	Thu, 11 Jan 2024 08:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FWF13zh2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA76887A3B; Thu, 11 Jan 2024 08:32:04 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF5E087847
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.home.xypron
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E7BF64300A; 
 Thu, 11 Jan 2024 07:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704958322;
 bh=u2AZKfkq17s1VoNkWHM3xC0UHvI2UbA8f0p81gwlywg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FWF13zh2M/2nyIoKBtvo0Qg3lksTIj8u+ELkQSGVWJT5gOfhFpXR1qEAefRRqfGLb
 4Gs0bHSkIEe+MDvAdg0XFkML4F8GtvMIhHf9gmZ9w0ziYkrxR/E1s24FHsKQyYIdss
 5qfFk2FRVjo1kkgmzzQjfm+Hi8DkaMqJDH42bpsCSo2+Gi05Kiz10NJuXUWp2Lo73Y
 OwZj80LRhysU1wAb9Hb9KzWtTxXc0Ev7PRW75TV0NOUJvAncM+6hgFMJxNNGTX/yWB
 4yLhqw126rR16ePWotlvsjTDQDFU5lVzdfGbADEvCAAOrjaIpFc5Wai+f4taYvQUJT
 yCC1dHJQJ843w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Stefan Roese <sr@denx.de>, Jagan Teki <jagan@openedev.com>,
 Boris Brezillon <bbrezillon@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: mtd: avoid unintentional integer overflow
Date: Thu, 11 Jan 2024 08:31:55 +0100
Message-ID: <20240111073155.19545-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

mtd dump beyond 4 GiB will show incorrect results.

Multiplying two u32 will yield a u32. Add a missing cast.

Fixes: 5db66b3aee6f ("cmd: mtd: add 'mtd' command")
Addresses-Coverity-ID: 477205 ("Unintentional integer overflow")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/mtd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index e63c011e79..9083a6840a 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -77,7 +77,7 @@ static void mtd_dump_device_buf(struct mtd_info *mtd, u64 start_off,
 
 	if (has_pages) {
 		for (page = 0; page < npages; page++) {
-			u64 data_off = page * mtd->writesize;
+			u64 data_off = (u64)page * mtd->writesize;
 
 			printf("\nDump %d data bytes from 0x%08llx:\n",
 			       mtd->writesize, start_off + data_off);
@@ -85,7 +85,7 @@ static void mtd_dump_device_buf(struct mtd_info *mtd, u64 start_off,
 				     mtd->writesize, start_off + data_off);
 
 			if (woob) {
-				u64 oob_off = page * mtd->oobsize;
+				u64 oob_off = (u64)page * mtd->oobsize;
 
 				printf("Dump %d OOB bytes from page at 0x%08llx:\n",
 				       mtd->oobsize, start_off + data_off);
-- 
2.43.0

