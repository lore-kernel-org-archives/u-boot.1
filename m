Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E512EC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF4D87767;
	Mon, 27 Nov 2023 19:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="ShdmTRT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F137875A1; Mon, 27 Nov 2023 19:28:08 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DCFD877B3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 25E29240028
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:28:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1701109684; bh=EcmlHEv41AD/bb9c1J2qsRrPpAugwVc6M1rjyTkprKM=;
 h=From:To:Cc:Subject:Date:Message-Id:From;
 b=ShdmTRT4CVTpN3eZeKEgNNSpIY+D0VqzU7p8YFOB4OOgnpvRU6ncPV0wqnsO9Gw58
 F7hc3OV7iq5Nxk5Laei9t2ftzJuDd/o2fhyNf6KUK3D0J28XInoMATFNDrO7ARrT3S
 06XjtR+gaBs+hgzGeGrzdOPQzy5uJ64jsSAOXwcwA0uStbw1/u3yi2JOuU8TreretK
 D4EZghw5EKkY5DxGjPFDjBCMHUlr7pJrUqdv0/gqiFvQYVrXIFQeO9K6YoSNzthkmH
 WXTHYN+cdI70GmiYXxXEQpz8V9A142Ouqp5KRzwev5I0hzS+m/JKYk56WjOe/4S7+d
 sG2sGgjZF63Zw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4SfDbl48Vwz6twC;
 Mon, 27 Nov 2023 19:28:03 +0100 (CET)
From: Stefan Bosch <stefan_b@posteo.net>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH v2 1/2] common: board_f: change calculation of gd->mon_len to
 fix s5p4418 reloc
Date: Mon, 27 Nov 2023 18:26:08 +0000
Message-Id: <20231127182609.4663-2-stefan_b@posteo.net>
In-Reply-To: <20231127182609.4663-1-stefan_b@posteo.net>
References: <20231127182609.4663-1-stefan_b@posteo.net>
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
calculated using __image_copy_start instead of _start in order the whole
monitor code is relocated.

Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
---

Changes in v2:
- Cosmetic: Fix spelling mistake in commit message

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

