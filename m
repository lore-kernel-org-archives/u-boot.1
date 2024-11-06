Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59BED59F6C
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 20:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546718900E;
	Wed,  6 Nov 2024 21:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="JbU1PNlD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x3hICAYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A98188C4D; Wed,  6 Nov 2024 17:34:43 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746A28903B
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 17:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1730910881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okzu7HLcfto8R+nkCczTWVtKwnRG8Myq7BMa6idzagg=;
 b=JbU1PNlD2gO3IIba84N0GEehnLvUehLkklfcE+tyMBJAsJ5NM8uDnkhBGKDJRSl6qvzEQi
 wc9SwTrWyTVUqt/OQXXoTOgfhm6RPk7qWYn+dcGTFTvw3Aq+tpfO9Of4KAJP/XaUoT6wZg
 ez9FReZ4wrpSR0BCGsikyS83jSlzWt++/39q8ZvnzQaqCSGDS8NtjiBj5VpGksC8A89NOI
 4Ns+DHNbllv6C/jTJEnr/MllDxuhWRpKoDGLeaMKclRApiBQvWzEGLj0AQh+hITveV/jWh
 4ftxay1LiKN/dJB/qYEWT85keoWNNoqqSJI395ZwGbKTyjbUNBCEVNQdMmeGrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1730910881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okzu7HLcfto8R+nkCczTWVtKwnRG8Myq7BMa6idzagg=;
 b=x3hICAYI6VBAU0yy0PXm9Ei6DfGhdGA5L6tJxf/ItV6QPi43fVE9AaJhxiWKAW2PLtiEfn
 QuIJcyViwKDyDjDg==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Nam Cao <namcao@linutronix.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: [PATCH 1/2] fs: Use ARCH_DMA_MINALIGN as default alignment for
 fs_read_alloc()
Date: Wed,  6 Nov 2024 17:34:31 +0100
Message-Id: <eab1fcfd3165975fba61424441615782d9738fb7.1730909884.git.namcao@linutronix.de>
In-Reply-To: <cover.1730909884.git.namcao@linutronix.de>
References: <cover.1730909884.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 06 Nov 2024 21:19:57 +0100
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
 fs/fs.c | 4 ++++
 1 file changed, 4 insertions(+)

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
--=20
2.39.5

