Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796D7C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 05:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6814388E51;
	Mon, 16 Sep 2024 07:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y7wSSVGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A862788E59; Mon, 16 Sep 2024 07:40:53 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407BD88DDE
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 07:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vaishnav.a@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48G5eit0054777;
 Mon, 16 Sep 2024 00:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726465244;
 bh=ow1T6JQhqX49Dn5Z+u3g7ruMKzhdPBRNs+jPkCEni2U=;
 h=From:To:CC:Subject:Date;
 b=y7wSSVGh5OpIjNX+XOZMEx8pUlx+gosOX+bjGVZzy6466oJ66lrIB7F+cIJ3OTBEL
 TZMytakCtco0M64bVVG7ADrF0sZQObaar+eAaas1fGPs3c9a8sCS7B6mQ2XjQPEXaC
 ahh22q0RPAdZ5kEpJ2FOsu83aW5aLTcbAGlVPTz8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48G5ehsc026095
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Sep 2024 00:40:44 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Sep 2024 00:40:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Sep 2024 00:40:43 -0500
Received: from uda0490681.. ([10.24.69.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48G5ecN0071000;
 Mon, 16 Sep 2024 00:40:39 -0500
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <sughosh.ganu@linaro.org>,
 <ilias.apalodimas@linaro.org>, <seanga2@gmail.com>,
 <akashi.tkhro@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vaishnav.a@ti.com>
Subject: [PATCH] fs: Fix reserved memory alloaction in fs_read()
Date: Mon, 16 Sep 2024 11:10:38 +0530
Message-ID: <20240916054038.2125910-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The reserved memory region in fs_read() is not being
freed after read, free that. The issue was uncovered by
commit ed17a33fed29 ("lmb: make LMB memory map persistent and global")
as now the region used to load from fs cannot be reused by other
loaders like tftp, wget which use lmb_get_free_size() instead
of lmb_alloc_addr(), other loaders which uses lmb_reserve() is
appropriately freeing the buffer after usage (Eg. Serial loader).
Also while at it move #if CONFIG_IS_ENABLED(LMB) to if (IS_ENABLED()).

Fixes aa3c609e2be5 ("fs: prevent overwriting reserved memory")

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

We started seeing boot failures since we have platforms that perform
mmc load for firmwares and subsequent tftp load for kernel to same
loadaddr, the reservation need not be permanent and is only to make
sure that the read is not overwriting reserved regions, there is no
permanent reservation/protection needed for each load.

In failing case (J7200 EVM):

_snip_
run boot_rprocs
75416 bytes read in 11 ms (6.5 MiB/s)
Load Remote Processor 2 with data@addr=0x82000000 75416 bytes: Success!
75416 bytes read in 12 ms (6 MiB/s)
Load Remote Processor 3 with data@addr=0x82000000 75416 bytes: Success!
_snip_
lmb_dump_all:
 memory.count = 0x1
 memory[0]    [0x80000000-0xffffffff], 0x80000000 bytes flags: none
 reserved.count = 0x3
 reserved[0]    [0x82000000-0x82012697], 0x00012698 bytes flags: none (this is from previous mmc load, size == 12698h = 75416)
 reserved[1]    [0x9e800000-0xa47fffff], 0x06000000 bytes flags: no-map
 reserved[2]    [0xfce8fef0-0xffffffff], 0x03170110 bytes flags: no-overwrite 

With fix:
lmb_dump_all:
 memory.count = 0x1
 memory[0]    [0x80000000-0xffffffff], 0x80000000 bytes flags: none
 reserved.count = 0x2
 reserved[1]    [0x9e800000-0xa47fffff], 0x06000000 bytes flags: no-map
 reserved[2]    [0xfce8fef0-0xffffffff], 0x03170110 bytes flags: no-overwrite 

 fs/fs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 4bc28d1dff..e00c2056a5 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -552,7 +552,7 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 	lmb_dump_all();
 
 	if (lmb_alloc_addr(addr, read_len) == addr)
-		return 0;
+		return read_len;
 
 	log_err("** Reading file would overwrite reserved memory **\n");
 	return -ENOSPC;
@@ -564,15 +564,13 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 {
 	struct fstype_info *info = fs_get_info(fs_type);
 	void *buf;
-	int ret;
+	int ret, alloc_size;
 
-#if CONFIG_IS_ENABLED(LMB)
-	if (do_lmb_check) {
-		ret = fs_read_lmb_check(filename, addr, offset, len, info);
-		if (ret)
-			return ret;
+	if (IS_ENABLED(CONFIG_LMB) && do_lmb_check) {
+		alloc_size = fs_read_lmb_check(filename, addr, offset, len, info);
+		if (alloc_size < 0)
+			return alloc_size;
 	}
-#endif
 
 	/*
 	 * We don't actually know how many bytes are being read, since len==0
@@ -587,6 +585,9 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 		log_debug("** %s shorter than offset + len **\n", filename);
 	fs_close();
 
+	if (IS_ENABLED(CONFIG_LMB) && do_lmb_check)
+		lmb_free(addr, alloc_size);
+
 	return ret;
 }
 
-- 
2.34.1

