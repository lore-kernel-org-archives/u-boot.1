Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C75DCD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B520384944;
	Fri, 12 Jun 2026 14:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e1lw6HTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C4183FEC; Fri, 12 Jun 2026 09:55:15 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC6AB8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 09:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piyushthepal@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c0c2c7e0c5so4471565ad.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781250911; x=1781855711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/+FvjQjgSa3gZ/Hjg+q7qHpqloMKqAn67NuYYjqhas=;
 b=e1lw6HTueJWbU/7Y8MRUcKAz4d7+d4CXzqu1QJfSfLEg58W/F7A+yItZKOtb2BAa2C
 WrGIMleNnGzFM43SqUxLCJcdB24vjQb2ykn+9D0pUIpsJlFt5MTyTx4LVeNwxdKkLBHK
 Vssq66t8TPTLB8W0NCvenfEt2bFiBcI9ly/ROurRWSBUDADhXSPIv1ggPsPhgRSqj65E
 OjbKjbNfjMZg3pTFk0pzynMrHcUMenn3xGj0sEn+1/9JEl2x4QCw3ovZnKw1d1P+ItKD
 Jn+1xVvRAXoev3r/QHrLAWoNcqOYyX0Nu16y/MqIktIGX+K1sGgazEqx5Zc+1kUrk2Wb
 9dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781250911; x=1781855711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D/+FvjQjgSa3gZ/Hjg+q7qHpqloMKqAn67NuYYjqhas=;
 b=RhQfgeKTdBl/GCuqFrG3Kn98heE1jzLdvCpUd4fjn7O0fewKRwqRz1p3FrGmprgzQr
 gALbeRY7VhqwhA+tU+CrDWxgIAXbAnejf4gYgr4BrL0mN9+Ic/M+1d/hNNVFZOKqiVwp
 Z+OLCKg0X8OR/s1XQxgrHe5E0r0IvI/NLvXi3troQ6rfFoDDMIoydyKDXyR363bsTVZH
 cRuXmcsL/O8EJ/zBd4cymsCewtpUD+Havd3pLmaHTig6UUU16hhbYl8WMe3fN/B9EpJt
 1yKM7JV0ljX7GVE2KVUKp95JAHjHTouy1MRLqBRlDOeTRfK6AVQDwrb7Nn5atfeVxVMF
 dgWA==
X-Gm-Message-State: AOJu0Yw4589nREsv3D/nlspYRq3SZf7xh8A4ErXBxur/9OAEGDMr4UoM
 1fXiTGUmnJBKJ1QoTqMfLAuamK/J/CEtHmkvBNJIes4G+LnqF05ribDOrvLsu3j6
X-Gm-Gg: Acq92OE3rkHzkeRYkTvw+dxSqJlViKc+JraR0SrSRIWzPqR24AwG+dwM5e/VUV4opls
 +EMM0a2LD5dWHj+UydwJfUUlupEJlyhV29rOSy8r24U+TFKD/XDZXs0qKl+iVDp+/rqoANWmSIL
 ZvnBAtOepd4TqKT9NJHOhhWTG83UjE3NWIYiHFb3GBMpcADQIuJOLFDGBcgTjg6s0IjgVTi43B5
 +na05NdOEKv2UDU/3C9PlW9glxSYrKt5gcyThAcq7eG6QpVcGHpOt2HakXraFvMj3jD/n0hWij8
 x/RgF9EklZseesJnJ2Jk+UXVy/zLKFL13q37MzZTpRXrDtbUY7nZnzowyFSTQmJGgXCRKoUTf2B
 ImVLIb3NYhJhVbtzDDHC49bg2bogM46RjozF9TpZTBt9Pc6Bs2LdJBHzxwPmyyJNqtqkweuPGYc
 aAU36FvzQ8xEEZF9QuFXp4lgOXPOyFQ8qA1Tw57W9JCFibpLUSCGWLRJ8=
X-Received: by 2002:a17:903:284:b0:2b7:975c:dacc with SMTP id
 d9443c01a7336-2c4104117fbmr21994715ad.1.1781250911420; 
 Fri, 12 Jun 2026 00:55:11 -0700 (PDT)
Received: from localhost.localdomain ([116.72.140.90])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432d8a039sm11197655ad.62.2026.06.12.00.55.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jun 2026 00:55:11 -0700 (PDT)
From: Piyush Paliwal <piyushthepal@gmail.com>
To: u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 trini@konsulko.com, eric.kilmer@trailofbits.com,
 Piyush Paliwal <piyushthepal@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] fs/squashfs: bound fragment offset/size in
 sqfs_read_nest()
Date: Fri, 12 Jun 2026 13:24:24 +0530
Message-ID: <20260612075424.83462-3-piyushthepal@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260612075424.83462-1-piyushthepal@gmail.com>
References: <20260612075424.83462-1-piyushthepal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

When reading a fragment-backed file, sqfs_read_nest() copies the file
data out of the fragment block with:

  memcpy(buf + *actread, &fragment_block[finfo.offset],
         finfo.size - *actread);

finfo.offset (the fragment's byte offset) and finfo.size come straight
from the on-disk inode and are never validated against the fragment
block length. Unlike the data-block loop above it, this path does not
clamp the source span, so a crafted inode makes the memcpy read past the
fragment buffer -> out-of-bounds heap read. The leaked bytes are copied
into the user-visible load buffer (information disclosure) or fault.
This affects both the compressed (dest_len bytes) and the uncompressed
(table_size bytes) fragment cases.

Validate finfo.offset and the copy length against the available fragment
data before each memcpy and reject malformed inodes.

Found by fuzzing the sandbox (CONFIG_ASAN) sqfsload with mutated images:
before, SEGV in sqfs_read_nest() at the fragment memcpy; after, malformed
images are rejected and valid fragmented files still load correctly.

Fixes: 0008d8086649 ("fs/squashfs: fix reading of fragmented files")
Cc: stable@vger.kernel.org
Signed-off-by: Piyush Paliwal <piyushthepal@gmail.com>
---
 fs/squashfs/sqfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 3548b5e07e2..6e7723669d4 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -1630,6 +1630,19 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 			goto out;
 		}
 
+		/*
+		 * finfo.offset and finfo.size come from the on-disk inode and
+		 * must not let the copy read past the decompressed fragment
+		 * block (dest_len bytes).
+		 */
+		if (finfo.size < (size_t)*actread ||
+		    finfo.offset > dest_len ||
+		    finfo.size - *actread > dest_len - finfo.offset) {
+			free(fragment_block);
+			ret = -EINVAL;
+			goto out;
+		}
+
 		memcpy(buf + *actread, &fragment_block[finfo.offset], finfo.size - *actread);
 		*actread = finfo.size;
 
@@ -1638,6 +1651,17 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 	} else if (finfo.frag && !finfo.comp) {
 		fragment_block = (void *)fragment + table_offset;
 
+		/*
+		 * Same check for the uncompressed fragment: the readable data
+		 * is table_size bytes starting at table_offset within fragment.
+		 */
+		if (finfo.size < (size_t)*actread ||
+		    finfo.offset > table_size ||
+		    finfo.size - *actread > table_size - finfo.offset) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		memcpy(buf + *actread, &fragment_block[finfo.offset], finfo.size - *actread);
 		*actread = finfo.size;
 	}
-- 
2.41.0

