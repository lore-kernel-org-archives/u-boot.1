Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E3C47DDF
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C836287C2D;
	Fri, 26 Jan 2024 13:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="NA1HOC/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A64887C20; Fri, 26 Jan 2024 13:53:13 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F0C787C1F
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 13:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 117CC240028
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 13:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1706273591; bh=XbL4pHMMuZTVf2o6bwJ/Q1T76XAhfgov8Fim7b/KMF4=;
 h=From:To:Cc:Subject:Date:Message-Id:From;
 b=NA1HOC/KgWLgySbL0UEeiT6LPNBp511SsmlAsEb56U7pphqE5wt2kZ7a6pzcAM+Ss
 aVEoROHtSssm5pZL+Dp2846nWp2eejUyd1mEXqAWwgYNZoNhOz437kBQPw8wWizcPF
 MzUiyWUdDJzAVLn/yicaAe+CelNRkvmNerReimZbjAOWaIGORVyTo6itGK5V61QgzO
 SJvjaYPVktvMmyrqMBf3R5KJIdJ1ltV+34lkQeAET9gE2kJy4K2OKneSkn6XzuBtMb
 t2M1YmvDuQBut+RB2aWT0VR1ZHTRB1KolZ5lFJIWA/RYURB734auKr0/iiJVRXUbK2
 l4AaEQhy3vDMw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4TLyKf2VQRz6tw9;
 Fri, 26 Jan 2024 13:53:10 +0100 (CET)
From: Stefan Bosch <stefan_b@posteo.net>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH v3 1/2] common: board_f: change calculation of gd->mon_len to
 fix s5p4418 reloc
Date: Fri, 26 Jan 2024 12:50:55 +0000
Message-Id: <20240126125056.16439-2-stefan_b@posteo.net>
In-Reply-To: <20240126125056.16439-1-stefan_b@posteo.net>
References: <20240126125056.16439-1-stefan_b@posteo.net>
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

ARCH_NEXELL: Change calculation of monitor length (gd->mon_len) to fix
relocation at boards with s5p4418-SoC (ARCH_NEXELL). At s5p4418, _start
is after the header (NSIH). Therefore the monitor length has to be
calculated using __image_copy_start instead of _start in order the
whole monitor code is relocated.

Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
---

Changes in v3:
- MICROBLAZE has not built anymore. Therefore do change calculation of
  gd->mon_len for ARCH_NEXELL only. This makes sure that MICROBLAZE and
  other ARM-boards are not affected.

Changes in v2:
- Cosmetic: Fix spelling mistake in commit message

 common/board_f.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index d4d7d01f8f..73297fc1b2 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -282,7 +282,9 @@ static int init_func_i2c(void)
 
 static int setup_mon_len(void)
 {
-#if defined(__ARM__) || defined(__MICROBLAZE__)
+#if defined(CONFIG_ARCH_NEXELL)
+	gd->mon_len = (ulong)__bss_end - (ulong)__image_copy_start;
+#elif defined(__ARM__) || defined(__MICROBLAZE__)
 	gd->mon_len = (ulong)__bss_end - (ulong)_start;
 #elif defined(CONFIG_SANDBOX) && !defined(__riscv)
 	gd->mon_len = (ulong)_end - (ulong)_init;
-- 
2.17.1

