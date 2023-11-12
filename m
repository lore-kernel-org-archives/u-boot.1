Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D982C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 14:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DEF87158;
	Sun, 12 Nov 2023 15:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="VTr7utCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9F487142; Sun, 12 Nov 2023 15:40:23 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4DA58718A
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 15:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 6811F240027
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 15:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1699800020; bh=+rj49qCdPgXZ40Qv8lVNHpLZK/R3Fp59gUa8ci0DoqU=;
 h=From:To:Cc:Subject:Date:Message-Id:From;
 b=VTr7utCtjbv2lV57sN4pbSmOIac3m2PrC3ctmEYfl+PTD8mTSPQa7TPvN4CUx447A
 Nd7OhCm7bnVLk+o/wpKDaDRQwA54CfSFMX0cBQDttXo5mn4nBdOdjTyQvlPtPkw8bR
 oP+xaEQkYECCOj+GN0nM5WTqUeUnaNzM9+vnRv69p/m9Pj3XXuRalsatl4soP1kv5g
 2CnTe4P0YNY5AbRTvf42gEf6dbf1KZ3wiJpLqWJfJi0olVk/0MYdEEThQLmv+aOnnw
 2q3TqQ725T28ZWnTsST0IvBbjjyS4+bSMN0ulZQTOzS0MM7786fWtKDhk18wvIfvFk
 N9miJ6cFR66+g==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4SSwFv6X5qz9rxB;
 Sun, 12 Nov 2023 15:40:19 +0100 (CET)
From: Stefan Bosch <stefan_b@posteo.net>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH v1 1/2] common: board_f: change calculation of gd->mon_len to
 fix s5p4418 reloc
Date: Sun, 12 Nov 2023 14:38:10 +0000
Message-Id: <20231112143811.3606-2-stefan_b@posteo.net>
In-Reply-To: <20231112143811.3606-1-stefan_b@posteo.net>
References: <20231112143811.3606-1-stefan_b@posteo.net>
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

ARM and MICROBLAZE: Change calculation of monitor length (gd->mon_len)
to fix relocation at boards with s5p4418-SoC. At s5p4418, _start is
after the header (NSIH) therefore the monitor length has to be
calculated using __image_copy_start instead of _start in order the hole
monitor code is relocated.

Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
---

 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index d4d7d01f8f..d2e4d9eae2 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -283,7 +283,7 @@ static int init_func_i2c(void)
 static int setup_mon_len(void)
 {
 #if defined(__ARM__) || defined(__MICROBLAZE__)
-	gd->mon_len = (ulong)__bss_end - (ulong)_start;
+	gd->mon_len = (ulong)__bss_end - (ulong)__image_copy_start;
 #elif defined(CONFIG_SANDBOX) && !defined(__riscv)
 	gd->mon_len = (ulong)_end - (ulong)_init;
 #elif defined(CONFIG_SANDBOX)
-- 
2.17.1

