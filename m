Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CEFD5D690
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F76F88E39;
	Thu,  7 Nov 2024 22:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="VHhx91aE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rl2j+7E0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5753989293; Thu,  7 Nov 2024 16:01:21 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F51892D9
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 16:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1730991677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMJECLMM4wLwTiZodooCl2eFTpJMFcrRPc42lf0yjM4=;
 b=VHhx91aE73TdirBS+YkTVBwt7bQMusY8B0xoghkMbdRz7MoGQWyKEu7Wn+n837fPks/5nD
 dXMQI4R+YhoRB865RpDl3CA9pU+o3HgzrsWAu4WgUMahAkrKPT7HHHTwmpxyFdbEPs8Iq3
 4SRJ91JhCT08UaTdxTKU7W9eNb1sjJ4dpX740ePJ1s0VLcQflWJqLObua+p01CJmDsR5Oz
 fAuIwXhQ0fqeh0AQuPUV4zTtszTgLa1MnxwNoVlixFuaoHQfybow2UcSzmbh/AVUiHwttz
 Cumx7nFRGoYtz2KL0JSpekaBGz4celsuUjDPJFVScJlUAQsVVOmGGu4ROPBy8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1730991677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMJECLMM4wLwTiZodooCl2eFTpJMFcrRPc42lf0yjM4=;
 b=Rl2j+7E0JF26lc5GnfYkr8HKGrioyc3o1Wi27r+yw3uK/3AexFWbhsAnOr+4hE7+VPpjfI
 z61RmGwcE4lPEmDQ==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Nam Cao <namcao@linutronix.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/2] fs: Use ARCH_DMA_MINALIGN as default alignment for
 fs_read_alloc()
Date: Thu,  7 Nov 2024 16:01:06 +0100
Message-Id: <e05bde602304f32dd813a8383a2249fabc464940.1730988601.git.namcao@linutronix.de>
In-Reply-To: <cover.1730988601.git.namcao@linutronix.de>
References: <cover.1730988601.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 07 Nov 2024 22:53:17 +0100
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

The comment above fs_read_alloc() explains:

    @align: Alignment to use for memory allocation (0 for default)

However, in the actual implementation, there is no alignment when @align is
zero.

This current default is probably fine for most cases. But for some block
devices which transfer data via DMA, ARCH_DMA_MINALIGN is needed.

Change the default alignment to ARCH_DMA_MINALIGN.

Fixes: de7b5a8a1ac0 ("fs: Create functions to load and allocate a file")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Tested-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
---
v2:
  - mention the default value in function comment [Simon]

 fs/fs.c      | 4 ++++
 include/fs.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fs.c b/fs/fs.c
index acf465bdd80..bfa51c89d40 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -23,6 +23,7 @@
 #include <semihostingfs.h>
 #include <ubifs_uboot.h>
 #include <btrfs.h>
+#include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <div64.h>
@@ -1001,6 +1002,9 @@ int fs_read_alloc(const char *fname, ulong size, uint=
 align, void **bufp)
 	char *buf;
 	int ret;
=20
+	if (!align)
+		align =3D ARCH_DMA_MINALIGN;
+
 	buf =3D memalign(align, size + 1);
 	if (!buf)
 		return log_msg_ret("buf", -ENOMEM);
diff --git a/include/fs.h b/include/fs.h
index ef540e7c23d..2f879968d0c 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -309,7 +309,7 @@ int do_fs_types(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char * const argv[]);
  *
  * @fname: Filename to read
  * @size: Size of file to read (must be correct!)
- * @align: Alignment to use for memory allocation (0 for default)
+ * @align: Alignment to use for memory allocation (0 for default: ARCH_DMA=
_MINALIGN)
  * @bufp: On success, returns the allocated buffer with the nul-terminated=
 file
  *	in it
  * Return: 0 if OK, -ENOMEM if out of memory, -EIO if read failed
--=20
2.39.5

