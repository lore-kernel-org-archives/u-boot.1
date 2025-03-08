Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76090C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 20:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D57A5814A4;
	Sat,  8 Mar 2025 21:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741464980;
	bh=/Cp1NePN/4ydmbDM8GbUHc+LhlvNsWTyN1N2cQHh/Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m1z6eXUTcfRktKTUh6sIfkpj3Z7iW4YoP9/J1LPcmQ8kEE4vBLIthGZecl4CnN5Mv
	 GaE3FpBaR0kl+WNU+AYWnhFPhEl1FPzFb6n0cZi3J1TITBMnOUqCE69jqlYvTYl0E8
	 WRADuQoIvw00cxmPQ397/B2VEREaQNFR1En0bqdoijkJK8erfqOqrK4uLeGnmcTYJW
	 2e/a5QDuaWFhOmFeTf1XDlKAjv3V3DFiwbcLk36YDT6ADFhLKGw8RI4F5uVGI5n/yR
	 Utx3B0LUV4f4Z/PxrIJw+KDPhlvVvQTGKgHNLUO6YsQ1foEH60RcRsYah77JRH98Fz
	 QQld5kqLscjpQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CD68144F; Sat,  8 Mar 2025 21:16:19 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1609980F4C
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 21:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BXCEou/P"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7F595101E8809; Sat,  8 Mar 2025 21:16:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741464976; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=/Cp1NePN/4ydmbDM8GbUHc+LhlvNsWTyN1N2cQHh/Kg=;
 b=BXCEou/PwkJcCQvVG7kO3Y8NFJIaLYra0Dh8benmTUXhyZrBhM6zXH0EjherA3HrsFxXTe
 04qt+V39IzkMShCmJqMTtzDh/zrWnIulXLGofz28VG9vbVPwMhRDuQC20kdxWcVKGeCOXW
 HaviP2yppntAHgj5xTww1/NV1WkqHJFy2uiuS4WLAkrzTd4pP6fDO1Z3rPyAFmIqrOFUyz
 L+fUUO8uZWI47jc6B+Y88blGK6yACMZXMJ1K21ez7y9xjjfthTR56Gbp2pvnYWVG74B0/T
 xk9kfAY8I7BSKwzxeApaquPmmqgh0VSx0hnS5VizOYhM3UtExEXBwm5x7PCE8Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/12] fs: Add generic fs_devread() implementation
Date: Sat,  8 Mar 2025 21:12:09 +0100
Message-ID: <20250308201533.1315951-6-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308201533.1315951-1-marex@denx.de>
References: <20250308201533.1315951-1-marex@denx.de>
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

Add generic implementation of write into a block device to be used
by filesystem implementations. This is a pair function for already
existing fs_devread().

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 fs/fs_internal.c      | 102 ++++++++++++++++++++++++++++++++++++++++++
 include/fs_internal.h |   2 +
 2 files changed, 104 insertions(+)

diff --git a/fs/fs_internal.c b/fs/fs_internal.c
index 51c1719361b..ab4847ac257 100644
--- a/fs/fs_internal.c
+++ b/fs/fs_internal.c
@@ -92,3 +92,105 @@ int fs_devread(struct blk_desc *blk, struct disk_partition *partition,
 	}
 	return 1;
 }
+
+int fs_devwrite(struct blk_desc *blk, struct disk_partition *partition,
+	        lbaint_t sector, int byte_offset, int byte_len, const char *buf)
+{
+	unsigned block_len;
+	int log2blksz;
+	ALLOC_CACHE_ALIGN_BUFFER(char, sec_buf, (blk ? blk->blksz : 0));
+	if (blk == NULL) {
+		log_err("** Invalid Block Device Descriptor (NULL)\n");
+		return 0;
+	}
+	log2blksz = blk->log2blksz;
+
+	/* Check partition boundaries */
+	if ((sector + ((byte_offset + byte_len - 1) >> log2blksz))
+	    >= partition->size) {
+		log_debug("read outside partition " LBAFU "\n", sector);
+		return 0;
+	}
+
+	/* Get the read to the beginning of a partition */
+	sector += byte_offset >> log2blksz;
+	byte_offset &= blk->blksz - 1;
+
+	log_debug(" <" LBAFU ", %d, %d>\n", sector, byte_offset, byte_len);
+
+	if (byte_offset != 0) {
+		int readlen;
+		/* read first part which isn't aligned with start of sector */
+		if (blk_dread(blk, partition->start + sector, 1,
+			      (void *)sec_buf) != 1) {
+			log_err(" ** %s read error **\n", __func__);
+			return 0;
+		}
+
+		readlen = min((int)blk->blksz - byte_offset,
+			      byte_len);
+		memcpy(sec_buf + byte_offset, buf, readlen);
+
+		if (blk_dwrite(blk, partition->start + sector, 1,
+			      (void *)sec_buf) != 1) {
+			log_err(" ** %s write error **\n", __func__);
+			return 0;
+		}
+		buf += readlen;
+		byte_len -= readlen;
+		sector++;
+	}
+
+	if (byte_len == 0)
+		return 1;
+
+	/* write sector aligned part */
+	block_len = byte_len & ~(blk->blksz - 1);
+
+	if (block_len == 0) {
+		if (blk_dread(blk, partition->start + sector, 1,
+			  (void *)sec_buf) != 1) {
+			log_err(" ** %s read error **\n", __func__);
+			return 0;
+		}
+
+		memcpy(sec_buf, buf, byte_len);
+
+		if (blk_dwrite(blk, partition->start + sector, 1,
+			      (void *)sec_buf) != 1) {
+			log_err(" ** %s write error **\n", __func__);
+			return 0;
+		}
+
+		return 1;
+	}
+
+	if (blk_dwrite(blk, partition->start + sector,
+		       block_len >> log2blksz, (void *)buf) !=
+			block_len >> log2blksz) {
+		log_err(" ** %s write error - block\n", __func__);
+		return 0;
+	}
+	block_len = byte_len & ~(blk->blksz - 1);
+	buf += block_len;
+	byte_len -= block_len;
+	sector += block_len / blk->blksz;
+
+	if (byte_len != 0) {
+		/* read rest of data which are not in whole sector */
+		if (blk_dread(blk, partition->start + sector, 1,
+			      (void *)sec_buf) != 1) {
+			log_err("* %s read error - last part **\n", __func__);
+			return 0;
+		}
+
+		memcpy(sec_buf, buf, byte_len);
+
+		if (blk_dwrite(blk, partition->start + sector, 1,
+			      (void *)sec_buf) != 1) {
+			log_err(" ** %s write error - last part **\n", __func__);
+			return 0;
+		}
+	}
+	return 1;
+}
diff --git a/include/fs_internal.h b/include/fs_internal.h
index 07f6bc5ea40..351582db61a 100644
--- a/include/fs_internal.h
+++ b/include/fs_internal.h
@@ -12,5 +12,7 @@
 
 int fs_devread(struct blk_desc *, struct disk_partition *, lbaint_t, int, int,
 	       char *);
+int fs_devwrite(struct blk_desc *, struct disk_partition *, lbaint_t, int, int,
+	        const char *);
 
 #endif /* __U_BOOT_FS_INTERNAL_H__ */
-- 
2.47.2

