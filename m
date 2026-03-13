Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F973105F797
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AA5842CD;
	Fri, 13 Mar 2026 11:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xYr/EyIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F1E842CC; Fri, 13 Mar 2026 11:42:48 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A721C8427F
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5C7FB1A2DF4
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 10:42:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 33F5A60027;
 Fri, 13 Mar 2026 10:42:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7279A10369E9C; Fri, 13 Mar 2026 11:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773398565; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=pscrM9oLa5M24A3QvrGqE0RD0yYGFQkI3l8o5W7RhEk=;
 b=xYr/EyIuPzX+d3qDiay0n+JPe8n9iMMxknEcGuugduvAw1XdocnmslKLHlCoaNU08KsxoM
 jXJgCBaaK7Kghv91qK2FzarOTe1985po2ooXsf+fxWZtv5bxRHXQ6jNN7O+YThcKp0zf5j
 vVTuk5jR405ooVqZ4OXsVTI8bS6vUPQ2KHvmyyN/w2CrCanlgFi0M5CmvmEnRbUhM71DGC
 e2fzCkzuQO16QBKDAuUtLAI7+4Tl5Bo26sR90VM59dTrYJN3EjzxHdkkQrTLRx12U7OOn+
 XgJGOWpOwU7Op3zbxrB2ikcaXLBY4J3jYL1vH8tSgtaf71srouQgMwXQKKkwVA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 3/7] fs/squashfs: squashfs.h: include file should be self
 dependent
Date: Fri, 13 Mar 2026 11:42:25 +0100
Message-ID: <20260313104229.1555236-4-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313104229.1555236-1-richard.genoud@bootlin.com>
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
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

Otherwise, we get a lot of errors when including this file.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 include/squashfs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/squashfs.h b/include/squashfs.h
index 7489eefa1f2f..83ed8a494428 100644
--- a/include/squashfs.h
+++ b/include/squashfs.h
@@ -10,7 +10,10 @@
 #ifndef _SQFS_H_
 #define _SQFS_H_
 
-struct disk_partition;
+#include <fs.h>
+#include <blk.h>
+#include <part.h>
+#include <linux/types.h>
 
 int sqfs_opendir(const char *filename, struct fs_dir_stream **dirsp);
 int sqfs_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
