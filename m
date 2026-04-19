Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E10BEA7193
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 10:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B339D83B99;
	Sun, 19 Apr 2026 12:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="b91+pqps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC6D83E81; Sun, 19 Apr 2026 12:01:35 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6377D839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 12:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82f33d28c1dso1078266b3a.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776592890; x=1777197690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7ikCeYkdipiUt5MA+i6o4kjBZWru91wHL/UErGFPYmQ=;
 b=b91+pqpssGxY5I7xzp/3/hbGQzJNFipT0YjZfYJNuHGoJ2atGOfUbt8qUlTw/TQZWr
 tpbgoVKX8qtg08wvZYWjIYGHQjIdOx20rf8yKRLLYgSSAv2EW+qFk5BLKqEMEKxoLKmi
 WNl031Y/TBjeboi0ar7U1zdRAvPoKC+PylgQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776592890; x=1777197690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ikCeYkdipiUt5MA+i6o4kjBZWru91wHL/UErGFPYmQ=;
 b=bVNb9OcP/8hPGsY6wtdvo2R/hCszk3LEAnirkYUtEYhB339xEFfZ9pC4bg9FdQq/7o
 wLNUKqyyb994mnyDsZoUbL4BJhk/Vr6+nzJ4QWxwnkkZMkWD1MLQHHSUVpgBLHkQaZDG
 k1JAOf/FfAvjc/SwC6Y1GltmXHKk+ZT3FM8QSmvkoRp7wNfl/d29vaz9epIw2sSnb49j
 R/tX4HMUi/TjytyRy7wBpAzZisD909N1ga5CFtGwLEu5TZFxMlYRHmhifWQ/S/tyFmOE
 IIzxfAPCU3T0aH8V2J4gG+yJrpKJUCfcM7JF0+Wbob3+2MmR98JrZjETJzCPMXjiDhLX
 U/sQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ83kiyYhpwMriCHCSEgNK5+Ok/Z2M7gaFd5QHU5vdBl0oE5HHRi6SfhT7NgaZtXBeJMFnX3v7s=@lists.denx.de
X-Gm-Message-State: AOJu0YwXXxE6W7XQnvMUNWxb8bjcEcs6FIsVMftTi2eeDV6NYWPlMEl+
 JjVJ49fc6vzZKQjtS1+5rvmEYrfmyRBV/HfZ/kSt1HeO8VwuXfYPEVrK194TKf7NzUc=
X-Gm-Gg: AeBDievFSLV9SPdFlGlnlGQHyUkAFwq+Fz2wrmJt/8Apa+2oDOPP+3dP8klNGx5Zux3
 I0PFfPhMJTc0QeDuB8kYKZNj3II3c1o1eHnDBE6pwnqVDL5924mpN+ixD0BMPd+v9ANE/40t50j
 AMPKhecxncl3wLcGn8s0NfUvhg0gnYCLlVgj0YfS/qyD1+G/RL2mCO5EOzUpsVMC+rSx7s2OFN0
 PbxZg4xJTIPw1Ph1ttWV/cJ14dG2owcjXBEDfVLSEtJsnGmbk04GFeuFS5FFrQAjEW9uNcKGzs7
 Zb0C2fv85gquzQhlEuT8BiC9o6dDIATqYTEsPXwhelAbDEXeZkTdVvJ8HAnCyOGhInOa0wgyElO
 EP0RSUMUwVvq9UkqYUtGbrbhVzrfSu5b5eJYlq0KK7VqmgTRTOOPQv9Aeel5Q/4xjImKa9tGJ/O
 a8B2CopWKeu1lMlzoHpZpXhSBd24/6zweZCSQlNbONmh0p+YM7BdXA+1dwlUJpFvJGKDpfncyMw
 /mY8T0TQ69ac3V6JHnm4e++
X-Received: by 2002:a05:6a00:4b4f:b0:82c:6bcc:f3fa with SMTP id
 d2e1a72fcca58-82f8c94401fmr9232486b3a.35.1776592890489; 
 Sun, 19 Apr 2026 03:01:30 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981829sm8627313b3a.12.2026.04.19.03.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 03:01:30 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: jnhuang95@gmail.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, u-boot@lists.denx.de,
 Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] fs/erofs: Fix build for m68k
Date: Sun, 19 Apr 2026 19:01:23 +0900
Message-ID: <20260419100123.2427364-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
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

Currently the use of roundup() causes GCC to emit a reference
to __udivdi3() on m68k and we don't have that:

/usr/bin/m68k-linux-gnu-ld.bfd: fs/erofs/data.o: in function `erofs_map_blocks':
u-boot/fs/erofs/data.c:81:(.text.erofs_map_blocks+0x126): undefined reference to `__udivdi3'
/usr/bin/m68k-linux-gnu-ld.bfd: u-boot/fs/erofs/data.c:81:(.text.erofs_map_blocks+0x458): undefined reference to `__udivdi3'

We could add it but since unit is 4 or 8 we can actually just
switch the code to use round_up() instead and not output
__udivdi3() in the first place.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index b58ec6fcc666..95873846f62d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -78,7 +78,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
 
 	chunknr = map->m_la >> vi->u.chunkbits;
-	pos = roundup(iloc(vi->nid) + vi->inode_isize +
+	pos = round_up(iloc(vi->nid) + vi->inode_isize +
 		      vi->xattr_isize, unit) + unit * chunknr;
 
 	err = erofs_blk_read(buf, erofs_blknr(pos), 1);
-- 
2.53.0

