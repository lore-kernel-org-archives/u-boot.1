Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F258CD4F28
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 06:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3496283DDD;
	Thu, 13 Nov 2025 07:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qyGyUNX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B182283D77; Thu, 13 Nov 2025 07:47:30 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C7A83D9C
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 07:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9D39A40A14; 
 Thu, 13 Nov 2025 06:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763016447;
 bh=X9nMaY0wmMAfDbzabyYEOZH35VMKSzdL8okrZ0TEGt8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qyGyUNX2+ygywmvmM68m4kNmj9YYP0jVucnD2S5QFaffRjnKM83VoCN77d+TyLkni
 qLkA+w1fRCF23tZ8eGMBnun5jsMZWhhJJQ/2C74K56pgRznP+TgEF4g1NP9Auw4Ss0
 +mikPhjvuikDYwe7ucMx5KDqbeGy11ecNrzDXQoZGDAoNNqqzGi8stJDoJeAEa0FgD
 uW7Y5mhoqET0R9SDOkn4fm7e1qghs5fbAjrrTYKBm6xgRWoep2NhfAJhkFG/f7a/Vh
 hRPE5pKOA7l1CuGTqXIug6iDRxmSC1d+5GROj2HfhQy+XEyx+HbMqLit8dcTQdcOAv
 kP1N6+lmwWNSG+IqMbzYBjaMju8eyQ4TPTTsAoqQzvrnynZPm6ePPs21Dfgxiz6K7X
 Twi+CwIDXA39dyTKTeKXkpTGT5q1kpa15EL0/f46DAiypmc0P+0qgaq26u1Xw0wu6x
 KTHrGoArX2KhdRlR1XHINTo04FgvkcZXRJaHr6P+jjaJrspj3uDXsv/sKxxaaUh/oG
 WV9SpUHN0GRhdKy+WXwc2cArg+W4dQr7b5B/ic7GYMiLqqE+CChnO943g+MMjOUIv2
 wkQ134aLo/yuM2khcylmj/2aL/rrGX7WSvn8z2wBkOGEP2PmcqjXv2dk+mCNBuKP0n
 6ow2ST1JDCzowMl3OM4nnL1c=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Claude <noreply@anthropic.com>
Subject: [PATCH 3/6] fat: Update struct fat_itr to kernel-doc style
Date: Thu, 13 Nov 2025 07:46:53 +0100
Message-ID: <20251113064656.245394-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
References: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
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

From: Simon Glass <simon.glass@canonical.com>

Convert the struct fat_itr documentation from the older style with
separate @field comments to the standard kernel-doc style where field
descriptions are listed in the header comment block.

Co-developed-by: Claude <noreply@anthropic.com>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---
 fs/fat/fat_internal.h | 60 +++++++++++--------------------------------
 1 file changed, 15 insertions(+), 45 deletions(-)

diff --git a/fs/fat/fat_internal.h b/fs/fat/fat_internal.h
index 10881a15569..bc52d534b46 100644
--- a/fs/fat/fat_internal.h
+++ b/fs/fat/fat_internal.h
@@ -32,6 +32,21 @@ extern struct disk_partition cur_part_info;
 
 /**
  * struct fat_itr - directory iterator, to simplify filesystem traversal
+ * @fsdata: filesystem parameters
+ * @start_clust: first cluster
+ * @clust: current cluster
+ * @next_clust: next cluster if remaining == 0
+ * @last_cluster: set if last cluster of directory reached
+ * @is_root: is iterator at root directory
+ * @remaining: remaining directory entries in current cluster
+ * @dent: current directory entry
+ * @dent_rem: remaining entries after long name start
+ * @dent_clust: cluster of long name start
+ * @dent_start: first directory entry for long name
+ * @l_name: long name of current directory entry
+ * @s_name: short 8.3 name of current directory entry
+ * @name: l_name if there is one, else s_name
+ * @block: buffer for current cluster
  *
  * Implements an iterator pattern to traverse directory tables,
  * transparently handling directory tables split across multiple
@@ -51,65 +66,20 @@ extern struct disk_partition cur_part_info;
  * For a more complete example, see fat_itr_resolve().
  */
 struct fat_itr {
-	/**
-	 * @fsdata:		filesystem parameters
-	 */
 	fsdata *fsdata;
-	/**
-	 * @start_clust:	first cluster
-	 */
 	unsigned int start_clust;
-	/**
-	 * @clust:		current cluster
-	 */
 	unsigned int clust;
-	/**
-	 * @next_clust:		next cluster if remaining == 0
-	 */
 	unsigned int next_clust;
-	/**
-	 * @last_cluster:	set if last cluster of directory reached
-	 */
 	int last_cluster;
-	/**
-	 * @is_root:		is iterator at root directory
-	 */
 	int is_root;
-	/**
-	 * @remaining:		remaining directory entries in current cluster
-	 */
 	int remaining;
-	/**
-	 * @dent:		current directory entry
-	 */
 	dir_entry *dent;
-	/**
-	 * @dent_rem:		remaining entries after long name start
-	 */
 	int dent_rem;
-	/**
-	 * @dent_clust:		cluster of long name start
-	 */
 	unsigned int dent_clust;
-	/**
-	 * @dent_start:		first directory entry for long name
-	 */
 	dir_entry *dent_start;
-	/**
-	 * @l_name:		long name of current directory entry
-	 */
 	char l_name[VFAT_MAXLEN_BYTES];
-	/**
-	 * @s_name:		short 8.3 name of current directory entry
-	 */
 	char s_name[14];
-	/**
-	 * @name:		l_name if there is one, else s_name
-	 */
 	char *name;
-	/**
-	 * @block:		buffer for current cluster
-	 */
 	u8 block[MAX_CLUSTSIZE] __aligned(ARCH_DMA_MINALIGN);
 };
 
-- 
2.51.0

