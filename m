Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996F8C5DF6D
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 22:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38A8780E97;
	Sat, 15 Aug 2026 22:48:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id em8KX3Dgm09N; Sat, 15 Aug 2026 22:48:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D2D780E92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786834128;
	bh=nGfSG+1FAlbfztU2PdT1Nx8LBDVwWWqVMtuWqRUql/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z4aO+jikQ7WIe7DnghowaOWCL76gZxn3eroFJG0HFkYD1FCUKNLwIaQ5efvvzFl3B
	 dUeBmzvzbGmGcjLccXHXTdQ6EWifFSMq2TsvcC7SmqF9hDnG0Azj1CoUI8fYv/89a4
	 eXJj2rlp0MAWRDUM3kzo4MYC8Vu2LxNDueVTggFm6lAuaR4nAHTDTOafHQGZbyDM3o
	 NMfdK4AfaXZTlFlY5UnxJAACjJtOMK7vc3vEJSjHrB9PpepNcmJWULupT/Yp4cd4QU
	 8ksuOKD44WAucoXirPXQrfwrIVc6lj7fHPN/+ugLMXznwt1g2azPd9EuVw+LhL+aA7
	 /1EyNXb3LLCwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D2D780E92;
	Sat, 15 Aug 2026 22:48:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 54CF82BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 469A660644
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:03:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FEp7BNxQbbzh for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 22:03:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3174060633
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3174060633
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lprkQENn
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3174060633
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:03:25 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso11154925e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786831403; x=1787436203;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nGfSG+1FAlbfztU2PdT1Nx8LBDVwWWqVMtuWqRUql/k=;
 b=lprkQENnBhuQNkjcxPmcMMd9n9gs6B/lGNzjNgJilocOYhTc0NDT15U94D2+Dr5ATh
 iF589RhGmCC6rvrMvThpdUfOBP6qrdtKd73b+U7k+PXt8ChT3bGaeMODes/X4NALNYMm
 OLMDLgi9+3ZMZcGKQrH+d+haUDWsZSZUdCaGbmUrapFSKBaRZZRCGbAg0WHNYEo1ouEU
 6u4r0aUYwj5QQcI60FtbYVJ7Pvh8Fv7Z+FjMR+CuSCfwllUAk+Fc4boG/5dMaLCuLNIJ
 WA5Ixl/+CiWh3N/AJD9nTC7k43bpuD7//AY6vU7qKxSLV/aqijHLv8qf+1ju8qjX13qM
 sYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786831403; x=1787436203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nGfSG+1FAlbfztU2PdT1Nx8LBDVwWWqVMtuWqRUql/k=;
 b=OhvFXpo5BUjs7xtNQLhaSMVfUoaDD4l8guXyrWvf/WX3iRliLXTkfgm0mMy6eJoCRT
 kAeSUhX93HjW20Vl4d644VAmVfKRaYTKSguMO3VSB5/EpXUFpIfuzTIafTeNZftGXP/e
 sabNI45IgMjCGh7dd1wkmaJv7olz+xuOpPDo6gesMVg+7hloHApim4jSWM80td5Q+gUE
 zrXrWvFxEHKff9M9B3CFz1DRpYtdwkGfHS5RjBhZabQAX7dV+rM8kXtBooLU0w/fV29m
 WBC23sXCoriCrHG4hPw/FB1MVnd/XO3OUlfBzmnockoxHnIVQdu5e46ZFv7pM2H+mQTD
 4/Ag==
X-Gm-Message-State: AOJu0YxfLUxKjhpsk7Ea3ncIg9skcMFM7f2f7L+LZQNkp0BFvPhF3LFc
 sumCUodjF4a22mara7UCKDNJakYywwry0nnSr4E8X7LuMVoXr6s/0pGDJK8DCCLaV5E=
X-Gm-Gg: AR+sD10sN7ccA3em7QJktuppYKIU6OOgkF25d3yAeCD4TqKne8ZwJjkccr+2JVGvr2Y
 VRxOrI20rrM9DoWbM5EJh1vHDnvYQRATMGSHkw/LwSEd7zKoYfmkUA/ewMvyvjjzzMrOeM90271
 DhTYc7urA2CIBhcwGatT1Bn+T3mTv/H7BqKBTHzzJw9ba0JJBsByrphFo+BxFwOcRPbURgljc7h
 w76neL5tJAyweN85qY4uOndUSe34gSal40UFNqh6UWgMrmpGp7e7qIjABsheBtsfq8k1qCAYCoY
 tHodk6BYlIQhoU50jIsws2qjPbfP65O/c9rsbgHuriMaNySyR5ySXq7Wc8lrDKW3/dG+KNrD32q
 yc4pdk+U4uHVQpDCbSe+bRN2Nv3X5rVd///QSyApQR3m0JGoI0VQco7JzCMjBhQlDxEcfqwonnh
 JyfyKuDPql5ICiCvw9CUU7eLONBBsjcQ8TeatZLQZYq0VNWbskTh+CC/gueIcGLUSZcnOx9xedU
 fqO/Ko/eDKrMIvu3LFthkbcY3+ITvBGzDbqhSun3MxITNFlcU3DJc4gSx22edDjGeyylv2AvQBL
 3MXJufXsJMZBR/zKXouI7joMDPfwwBonZZI=
X-Received: by 2002:a05:600c:3114:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-49987971986mr209946905e9.10.1786831403070; 
 Sat, 15 Aug 2026 15:03:23 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d33asm179055255e9.10.2026.08.15.15.03.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 15 Aug 2026 15:03:22 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 trini@konsulko.com, Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v1 2/2] fs/squashfs: bound the offset returned by
 sqfs_dir_offset()
Date: Sat, 15 Aug 2026 23:01:15 +0100
Message-ID: <20260815220115.11335-3-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260815220115.11335-1-pranavkasthuri@gmail.com>
References: <20260815220115.11335-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 15 Aug 2026 22:48:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Commit 57e0bb7bf00d ("fs/squashfs: add sqfs_dir_offset() error checks")
made sqfs_search_dir() reject negative returns from sqfs_dir_offset(),
but the positive range is still unbounded. Both parts of the returned
offset come from the image: 'offset' is a 16-bit inode field used
verbatim, and the matched metadata block index may be the last one in
m_list, in which case the returned block (j + 1) is one past the end
of the directory table.

The callers use the result to index dirs->dir_table[], which
sqfs_read_directory_table() allocates as m_count metadata blocks, and
then memcpy() a directory header out of it. A crafted image can
therefore read up to 64 KiB past the end of that allocation.

Reject an inode offset that cannot address a decompressed metadata
block, and verify that the resulting directory header lies entirely
within the directory table.

The existing 'offset < 0' test is dropped: 'offset' is assigned from
get_unaligned_le16() and so is never negative, meaning the test never
fired. The new upper bound covers what it was meant to catch.

Fixes: c51006130370 ("fs/squashfs: new filesystem")
Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
---
 fs/squashfs/sqfs_dir.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/squashfs/sqfs_dir.c b/fs/squashfs/sqfs_dir.c
index ed83c90682f..3908d1380b3 100644
--- a/fs/squashfs/sqfs_dir.c
+++ b/fs/squashfs/sqfs_dir.c
@@ -32,6 +32,7 @@ int sqfs_dir_offset(void *dir_i, u32 *m_list, int m_count)
 	struct squashfs_base_inode *base = dir_i;
 	struct squashfs_ldir_inode *ldir;
 	struct squashfs_dir_inode *dir;
+	u64 table_size, res;
 	u32 start_block;
 	int j, offset;
 
@@ -51,20 +52,49 @@ int sqfs_dir_offset(void *dir_i, u32 *m_list, int m_count)
 		return -EINVAL;
 	}
 
-	if (offset < 0)
+	/*
+	 * 'offset' is an offset into a decompressed metadata block, so it can
+	 * never address past the end of one.
+	 */
+	if (offset >= SQFS_METADATA_BLOCK_SIZE)
 		return -EINVAL;
 
+	if (m_count < 1)
+		return -EINVAL;
+
+	/* The caller's directory table holds m_count decompressed blocks. */
+	table_size = (u64)m_count * SQFS_METADATA_BLOCK_SIZE;
+
 	for (j = 0; j < m_count; j++) {
 		if (m_list[j] == start_block)
-			return (++j * SQFS_METADATA_BLOCK_SIZE) + offset;
+			break;
 	}
 
-	if (start_block == 0)
-		return offset;
+	if (j < m_count) {
+		/*
+		 * m_list[j] is the position of the metadata block following
+		 * block j, so a match means the directory starts in block
+		 * j + 1.
+		 */
+		res = (u64)(j + 1) * SQFS_METADATA_BLOCK_SIZE + offset;
+	} else if (start_block == 0) {
+		res = offset;
+	} else {
+		printf("Error: invalid inode reference to directory table.\n");
+		return -EINVAL;
+	}
 
-	printf("Error: invalid inode reference to directory table.\n");
+	/*
+	 * Callers use the return value to index the directory table and read a
+	 * directory header from it, so the whole header must lie inside the
+	 * table.
+	 */
+	if (res + SQFS_DIR_HEADER_SIZE > table_size) {
+		printf("Error: inode points past the end of the directory table.\n");
+		return -EINVAL;
+	}
 
-	return -EINVAL;
+	return res;
 }
 
 bool sqfs_is_empty_dir(void *dir_i)
-- 
2.50.1 (Apple Git-155)

