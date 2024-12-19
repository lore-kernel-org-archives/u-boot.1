Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E91CE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87428021D;
	Thu, 19 Dec 2024 22:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="hqxu6HsX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D872280328; Thu, 19 Dec 2024 22:42:14 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5D98021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 9459410000B;
 Fri, 20 Dec 2024 00:42:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9459410000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1734644529;
 bh=hq4NE4mG0rhI5W4fy8EGqpLwGeHX0RN0rDLbK8efcGE=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
 b=hqxu6HsX1NT2Hi9WaWbEyt8GygGQHVJvrsF7Y0JxpjOQR1brAOKc9m5H0liSszIYq
 ZXKiBmS/NbkBA4P/j4qD4Q1qeTkotRHBrHd2LHjgHQ8mG6oANi5hosmMxxlshOTPiv
 T9XKnjwQRbXl+2aptPXv9lTQkUI8MnFtsGVWAhHDy+TUWVTwL+GZp1nfa1f4hO4013
 2yuSJFfcB6Y3/Nma+jG2Dp7nDqM7mMFnXaCmLtElvwWGtZQ2D6KA2Lw6rJ9PGS9J0h
 f01x6NZhoLkgvOehvFg8smLYWi+dSAj7QymmI21M6dqKx4EpL/wNu4jqWwMClcFVLI
 dCTC+BYDy5/Tg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 20 Dec 2024 00:42:09 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Fri, 20 Dec 2024 00:42:09 +0300
Subject: [PATCH 2/3] fdt_support: board_fdt_chosen_bootargs() should return
 const char*
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241220-board_fdt_chosen_bootargs_improvements-v1-2-f6a7181787c5@salutedevices.com>
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
In-Reply-To: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Tim Harvey
 <tharvey@gateworks.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Sam Protsenko
 <semen.protsenko@linaro.org>, Devarsh Thakkar <devarsht@ti.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734644528; l=1826;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=fb2Ll0t3/zlQjicTpvVnf0aTh5+ONZikcTxP4TI9VgY=;
 b=tiQskMo3qhJBTd7awi+mb0q7W1plsRBCfRqki7pGgOAR6+9v1lwhiNHSaucaWGEhwnCduww6V
 sz4lvIjtWyaBsohA09SBVd1G+AEPnektjRQxfbnPMUtm1BfuL090tVB
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.162.51]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189961 [Dec 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/19 19:16:00 #26891781
X-KSMG-AntiVirus-Status: Clean, skipped
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

It should be structured this way to demonstrate to the caller that
freeing the return value is unnecessary and that the caller cannot
modify it.
The function fdt_setprop() includes a parameter with a const char*
prototype, so it is better to use the const qualifier.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/fdt_support.c    | 4 ++--
 include/fdt_support.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 2392027d40ba292a4cd714c7f23497e9879ac454..2c39b2dd14b7c447bc4c7c8fad64e22cb00e88e0 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -321,7 +321,7 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
  * board_fdt_chosen_bootargs - boards may override this function to use
  *                             alternative kernel command line arguments
  */
-__weak char *board_fdt_chosen_bootargs(void)
+__weak const char *board_fdt_chosen_bootargs(void)
 {
 	return env_get("bootargs");
 }
@@ -331,7 +331,7 @@ int fdt_chosen(void *fdt)
 	struct abuf buf = {};
 	int   nodeoffset;
 	int   err;
-	char  *str;		/* used to set string properties */
+	const char *str;		/* used to set string properties */
 
 	err = fdt_check_header(fdt);
 	if (err < 0) {
diff --git a/include/fdt_support.h b/include/fdt_support.h
index ed4f5ba26c19b2d0afcc43c46bdee3c211c0441a..f481881ce640797e0f6204d599f008d0e5dc2bf7 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -236,7 +236,7 @@ int board_rng_seed(struct abuf *buf);
  *
  * Return: pointer to kernel command line arguments in memory
  */
-char *board_fdt_chosen_bootargs(void);
+const char *board_fdt_chosen_bootargs(void);
 
 /*
  * The keystone2 SOC requires all 32 bit aliased addresses to be converted

-- 
2.43.0

