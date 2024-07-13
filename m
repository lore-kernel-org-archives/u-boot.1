Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA1DC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BBC887FD;
	Sat, 13 Jul 2024 15:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gLVeJL9L";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="V2KweZkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99DA886AF; Sat, 13 Jul 2024 15:21:10 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39E988676
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WLpxw4sP6z9sps;
 Sat, 13 Jul 2024 15:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UChM9RUqMrmkEU0iApayUHx1tXMpk+5uSGRcOySAhl8=;
 b=gLVeJL9LSH+dWbvbC+OPAaIW6l44mCY6Z9XKT6METTeQLHB0X2ykS5Wh0EIUqXgxD2Vk3s
 K32M/DQqCPVKNhs9AvJwfB4PaPmRa8TAckusB8jGIxJIRs4FmG3QcbxahwBmhxXIc+6GMk
 cTFLhHv0DNDnviQLgywZAclL1SjzlHpdVHgcQjhscH5QCRmE4g/HSgrV4oVQerfWvP/s3s
 0IAj55QlwL360QepN5yJ6u6Kj30ZvbhCT0MkdC56XUPkVw44PfcmX4/beAXI1y0f2n2xd0
 VpZ2g2Fw+1bYFoMmeOJL0JygbxOVPIf/CexzZRBwOR26smbr4aZMUaYSXkOO0Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UChM9RUqMrmkEU0iApayUHx1tXMpk+5uSGRcOySAhl8=;
 b=V2KweZkImJQxH5yXYbsN2sJzIrFozpba5kBxaG1p6tVIKMZyrdN6yNDKBeRYJzd3PF5L0v
 vZ9gNYBb64aVqJmPns7NKmUzCTl5RgZkW7wQtftHOl5mTUc1SmyNHObH9HHNrn6zjPgqU+
 4HkZwAxIJx/E3aHuPt09qoN3gTdiNyk5VDNLTDSqWK+0QDWBPAyEPAq5WJIv/+WPrUQN9I
 oZKPwDfkpjbRTEzqd5o/vSk9R8Tg5viZeX1Gp6xEVhQ/u1ZV8wzyJpN1KEjPh3XnRjV4PI
 p4vssRQyRQ73CtYFMSM24PwfHKpljOIsqMh2FTkIxPRO1IPwOwjmgMxDV6Foig==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/45] arc: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:18:53 +0200
Message-ID: <20240713132021.57650-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 842e8fc9b3e879488e9
X-MBO-RS-META: pwhp7qow9zjd73n1zprqhy39tiaydmkg
X-Rspamd-Queue-Id: 4WLpxw4sP6z9sps
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arc/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index c818b8bdaec..39f361293fd 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -77,7 +77,6 @@ static inline void sync(void)
 #define __arch_putl(v, a)	({ __comp_b(); *(volatile u32 *)(a) = (v); __comp_b(); })
 #define __arch_putq(v, a)	({ __comp_b(); *(volatile u64 *)(a) = (v); __comp_b(); })
 
-
 /*
  * We add memory barriers for __raw_readX / __raw_writeX accessors same way as
  * it is done for readX and writeX accessors as lots of U-Boot driver uses
@@ -93,7 +92,6 @@ static inline void sync(void)
 #define __raw_readl(c)		({ u32 __v = __arch_getl(c); __iormb(); __v; })
 #define __raw_readq(c)		({ u64 __v = __arch_getq(c); __iormb(); __v; })
 
-
 static inline void __raw_writesb(unsigned long addr, const void *data,
 				 int bytelen)
 {
-- 
2.43.0

