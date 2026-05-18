Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC1ECD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 05:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5A0846AA;
	Mon, 18 May 2026 07:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Q/Vcf/YJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA758466F; Mon, 18 May 2026 07:57:57 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2148467A
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de
 [46.114.109.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3DA0641794; 
 Mon, 18 May 2026 05:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779083874;
 bh=stgAR1NEBbGyaaiZGEXq86e5OVsrFCqAzFqL+sq8lb4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Q/Vcf/YJ9AV51SULH5PnLu3nSIijB0mcn836R22iDdjpT8Hw9dnYkJpf/6yAIHzK2
 5KGzt48dfMCGY1IgM0hBzVO/Z7/ZiuzMu6Gih5PBIRreGpxoejC8Aq5CL1881pxUVr
 OrNb0awef/ZkBa71AkPb4wTK6dm4tGHo7kWJT0y7JMRxoAYs9jRTvgN8Up0k5dT/6d
 KGYChjwTBIkzjCwQIQR6ci+7soojFvTkBR1rgih4TjhclC/JAMEoYE8Ssuf6zM/6BI
 /53aKK9VryODmMdTg6Ki1xfQtTDi/4UG8ivvKM0G/+gy5QtRB+4HHT4FG97eeOaPpy
 momZW8B0SMOtqOZ6lyIeb9TDhHwDZR2EJcS2Ibw8zm6gY8PlBXjgdNY+x5B+3TPLj/
 cQ0q5LRvkA7zMtdhnFeY2pyuY4k18pW1xiyMkpmYJ2xwHxyAP5R9J5ejLh8fY/C1fy
 X5IaeRu6b2olINsHSWOUBcLJNjVHENLtQE6i+fTz8GG2OnGXJn62MaeLPMScwefEom
 PMcDvmq2c8FWiW9xLsSU0AUvDwLouXF5TYDN7HXPVZFkXjvB7F3W+kjilHq8atCRZc
 utrqdXocNzREq6ndztMb2y0bFx0ieDS7oVKNZDY72bTc9HikLMICUEIXaqT1Hqcodn
 xLTKcHIdyHxHkxeTinCQkEyc=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/9] fs: ext4: set inode timestamps on write
Date: Mon, 18 May 2026 07:57:24 +0200
Message-ID: <20260518055728.178507-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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

Replace the hardcoded zero timestamp in ext4fs_write() with the actual
current time obtained from the RTC when CONFIG_DM_RTC is enabled.

Per the ext2/3/4 specification (ext2 design document, section 4.2):
  i_mtime  last data modification time
  i_ctime  last inode change time (the 'c' stands for 'change', not
           'create'; this is not a creation timestamp)
  i_atime  last access time

All three fields are set to the same value since writing data modifies
both the file content (mtime) and the inode metadata (ctime), and any
write also constitutes an access (atime).  If no RTC is available, the
timestamp falls back to 2000-01-01 00:00:00 UTC, matching the FAT
write driver behaviour.

The ext4 i_crtime field (true file creation time, added in ext4) is
stored in the extra inode area beyond the base 128-byte inode and is
not modelled by struct ext2_inode, so it cannot be set here.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4_write.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 1abedcede72..c8a1ca63605 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -21,14 +21,47 @@
  */
 
 #include <blk.h>
+#include <dm/uclass.h>
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <part.h>
+#include <rtc.h>
 #include <linux/stat.h>
 #include <div64.h>
 #include "ext4_common.h"
 
+/**
+ * define EXT4_TIMESTAMP_Y2K - 2000-01-01 00:00:00 UTC as a POSIX timestamp
+ *
+ * Used as a fallback timestamp when no RTC is available.
+ */
+#define EXT4_TIMESTAMP_Y2K	946684800
+
+/**
+ * ext4_current_timestamp() - get current time as a POSIX timestamp
+ *
+ * Returns the current time as seconds since the Unix epoch.
+ * Falls back to 2000-01-01 00:00:00 UTC if the RTC is unavailable,
+ * matching the behaviour of the FAT write driver.
+ */
+static time_t ext4_current_timestamp(void)
+{
+	if (CONFIG_IS_ENABLED(DM_RTC)) {
+		struct udevice *dev;
+		struct rtc_time tm;
+
+		uclass_first_device(UCLASS_RTC, &dev);
+		if (!dev)
+			goto fallback;
+		if (dm_rtc_get(dev, &tm))
+			goto fallback;
+		return rtc_mktime(&tm);
+	}
+fallback:
+	return EXT4_TIMESTAMP_Y2K;
+}
+
 static inline void ext4fs_sb_free_inodes_inc(struct ext2_sblock *sb)
 {
 	sb->free_inodes = cpu_to_le32(le32_to_cpu(sb->free_inodes) + 1);
@@ -854,7 +887,7 @@ int ext4fs_write(const char *fname, const char *buffer,
 	unsigned char *inode_buffer = NULL;
 	int parent_inodeno;
 	int inodeno;
-	time_t timestamp = 0;
+	time_t timestamp = ext4_current_timestamp();
 
 	uint64_t bytes_reqd_for_file;
 	unsigned int blks_reqd_for_file;
@@ -979,7 +1012,11 @@ int ext4fs_write(const char *fname, const char *buffer,
 	}
 	if (existing_file_inode)
 		free(existing_file_inode);
-	/* ToDo: Update correct time */
+	/*
+	 * Note: ext4 i_crtime (true creation time) lives in the extended
+	 * inode area beyond the base 128-byte inode and is not modelled
+	 * by struct ext2_inode, so it cannot be set here.
+	 */
 	file_inode->mtime = cpu_to_le32(timestamp);
 	file_inode->atime = cpu_to_le32(timestamp);
 	file_inode->ctime = cpu_to_le32(timestamp);
-- 
2.53.0

