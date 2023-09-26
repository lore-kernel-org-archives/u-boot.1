Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E898EE7D271
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 10:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BAF186C2D;
	Tue, 26 Sep 2023 12:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4242E86C2D; Tue, 26 Sep 2023 12:09:16 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157FF86C37
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 12:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-Spam: true
X-QQ-mid: bizesmtp81t1695718598tgca81o9
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:56:36 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 12/15] cmd: blk_common: Stop using hard-coded block size for
 Sandbox operations
Date: Tue, 26 Sep 2023 16:43:42 +0800
Message-Id: <20230926084346.2237483-13-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz6a-0
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

commit 3d2fc7971454 ("cmd: blk: Allow generic read/write operations to work in sandbox")
used the hard-coded block size (512) for accessing the sandbox host
device. Now that we have added support for non-512 block size for both
Sandbox host device and blkmap driver, let's stop using the hard-coded
block size.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 cmd/blk_common.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/cmd/blk_common.c b/cmd/blk_common.c
index ad9b16dc09..02ac92837b 100644
--- a/cmd/blk_common.c
+++ b/cmd/blk_common.c
@@ -67,15 +67,19 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 			phys_addr_t paddr = hextoul(argv[2], NULL);
 			lbaint_t blk = hextoul(argv[3], NULL);
 			ulong cnt = hextoul(argv[4], NULL);
+			struct blk_desc *desc;
 			void *vaddr;
 			ulong n;
+			int ret;
 
 			printf("\n%s read: device %d block # "LBAFU", count %lu ... ",
 			       if_name, *cur_devnump, blk, cnt);
 
-			vaddr = map_sysmem(paddr, 512 * cnt);
-			n = blk_read_devnum(uclass_id, *cur_devnump, blk, cnt,
-					    vaddr);
+			ret = blk_get_desc(uclass_id, *cur_devnump, &desc);
+			if (ret)
+				return CMD_RET_FAILURE;
+			vaddr = map_sysmem(paddr, desc->blksz * cnt);
+			n = blk_dread(desc, blk, cnt, vaddr);
 			unmap_sysmem(vaddr);
 
 			printf("%ld blocks read: %s\n", n,
@@ -85,15 +89,19 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 			phys_addr_t paddr = hextoul(argv[2], NULL);
 			lbaint_t blk = hextoul(argv[3], NULL);
 			ulong cnt = hextoul(argv[4], NULL);
+			struct blk_desc *desc;
 			void *vaddr;
 			ulong n;
+			int ret;
 
 			printf("\n%s write: device %d block # "LBAFU", count %lu ... ",
 			       if_name, *cur_devnump, blk, cnt);
 
-			vaddr = map_sysmem(paddr, 512 * cnt);
-			n = blk_write_devnum(uclass_id, *cur_devnump, blk, cnt,
-					     vaddr);
+			ret = blk_get_desc(uclass_id, *cur_devnump, &desc);
+			if (ret)
+				return CMD_RET_FAILURE;
+			vaddr = map_sysmem(paddr, desc->blksz * cnt);
+			n = blk_dwrite(desc, blk, cnt, vaddr);
 			unmap_sysmem(vaddr);
 
 			printf("%ld blocks written: %s\n", n,
-- 
2.25.1

