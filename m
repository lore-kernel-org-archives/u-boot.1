Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA00EC3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 19:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040CE887A1;
	Tue,  2 Jul 2024 21:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1F3883A9; Tue,  2 Jul 2024 21:42:32 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5CA8874C
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 21:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id AFB8964943E1;
 Tue,  2 Jul 2024 21:42:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id rCaMPH_pdGHg; Tue,  2 Jul 2024 21:42:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 5EB9C605835D;
 Tue,  2 Jul 2024 21:42:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id VU9TAGv2oO8j; Tue,  2 Jul 2024 21:42:30 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 1521E605835E;
 Tue,  2 Jul 2024 21:42:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: Jixiong.Hu@mediatek.com, sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, xypron.glpk@gmx.de,
 trini@konsulko.com, upstream+uboot@sigma-star.at,
 Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] ext4: Fix zalloc()
Date: Tue,  2 Jul 2024 21:42:23 +0200
Message-Id: <20240702194223.31998-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240702194223.31998-1-richard@nod.at>
References: <20240702194223.31998-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

The zalloc() function suffers from two problems.
1. If memalign() fails it will return NULL and memset() will use a NULL p=
ointer.
2. memalign() itself seems to crash when more than 2^32 bytes are request=
ed.

So, check the return value of memalign() and allocate only of size is les=
s than
CONFIG_SYS_MALLOC_LEN.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
FWIW, I didn't investigate further why memalign() fails for large sizes.
Maybe this is an issue on it's own.

Thanks,
//richard
---
 fs/ext4/ext4_common.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
index 84500e990a..0d1f72ae01 100644
--- a/fs/ext4/ext4_common.h
+++ b/fs/ext4/ext4_common.h
@@ -43,8 +43,14 @@
=20
 static inline void *zalloc(size_t size)
 {
-	void *p =3D memalign(ARCH_DMA_MINALIGN, size);
-	memset(p, 0, size);
+	void *p =3D NULL;
+
+	if (size < CONFIG_SYS_MALLOC_LEN)
+		p =3D memalign(ARCH_DMA_MINALIGN, size);
+
+	if (p)
+		memset(p, 0, size);
+
 	return p;
 }
=20
--=20
2.35.3

