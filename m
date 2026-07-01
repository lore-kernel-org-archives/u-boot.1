Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EC8C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFB084BC1;
	Wed,  1 Jul 2026 13:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="b/Sq8WsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF3084BC3; Wed,  1 Jul 2026 13:18:33 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D8884BAA
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904707; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dY3snv2YJX+5J/78aKWdHVlH2psM+ZQP+pCxNNJCoVL7LwAEyM7B5neQqLUFwj3j77d5xfi8o78Sl0blYwOMWWMFTHrta7u59nSUuxdSzCz7r4Ppn/uqqFHwZ6IVBvfhaGyehGHtEkX0utkWI5HF+/l5xw/Y8KD/urMfcoxTGbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904707;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wdlyKDMesHylSLRPH6u+UaBNsFJKaXgqbxWo92OVrao=; 
 b=E0EpAzSs+JlYQhvdprPBO/JSS+hWoJKhhSJ1r3w8oZzdwngggMpEgKz3dmkhoFw6D4VAlkB48F3GmtK/iTLB83cy5S4w61tvh1lBeHEApthGU5LhMer9ADgfx8cMpMlo6uefqAMzpB0p9sJwheFu6SxGhJe+ZPyC2vfo/wl3f7Y=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904707; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wdlyKDMesHylSLRPH6u+UaBNsFJKaXgqbxWo92OVrao=;
 b=b/Sq8WsWJ+CrinsI7iBhxstNJxAd7eqE3lLhbP5j0LNvZoygoPtErelGHDLT+atH
 McV452pRF6cYf6sMYjQ7XrBJcl2dsXupFXpd1W7HJStcVgxC7p4/t/5+aA3KhMuP38H
 6hvCC389AI7FPWoyUV9dWIR2fNx9TNnEc6S7LFpA=
Received: by mx.zohomail.com with SMTPS id 1782904705386863.474644445674;
 Wed, 1 Jul 2026 04:18:25 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 02/16] linux/io.h: Use map_physmem to implement ioremap
Date: Wed,  1 Jul 2026 11:17:54 +0000
Message-ID: <20260701111808.870705-3-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
References: <20260701111808.870705-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

ioremap API is here to be compatible with Linux drivers,
to maintain compatibility we need to ensure we are using
the same way to determine virtual address for IO devices
from physical address.

map_physmem is U-Boot's standard way for doing the trick,
we should follow that. For architectures VA == PA it has
no impact, for MIPS it has it's own ioremap implementation
in asm/io.h anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

(No changes since v1)

 include/linux/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 79847886be95..ada6525a1c6a 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -59,11 +59,12 @@ static inline void iowrite64(u64 value, volatile void __iomem *addr)
 static inline void __iomem *ioremap(resource_size_t offset,
 				    resource_size_t size)
 {
-	return (void __iomem *)(unsigned long)offset;
+	return (void __iomem *)map_physmem(offset, size, MAP_NOCACHE);
 }
 
 static inline void iounmap(void __iomem *addr)
 {
+	return unmap_physmem(addr, MAP_NOCACHE);
 }
 #endif
 
-- 
2.54.0

