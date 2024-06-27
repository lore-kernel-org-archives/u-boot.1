Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE49C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D47885B0;
	Thu, 27 Jun 2024 10:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F82A885AE; Thu, 27 Jun 2024 10:30:10 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD628884A7
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4W8sFX4QzMz9tlS;
 Thu, 27 Jun 2024 10:30:08 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9AOXXObbs7lc; Thu, 27 Jun 2024 10:30:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4W8s9007fYz9vGJ;
 Thu, 27 Jun 2024 10:26:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 006578B776;
 Thu, 27 Jun 2024 10:26:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ePL2JkI3XrTz; Thu, 27 Jun 2024 10:26:11 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.179])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B26558B763;
 Thu, 27 Jun 2024 10:26:11 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH] watchdog: mpc8xxx: Fix timer value
Date: Thu, 27 Jun 2024 10:26:08 +0200
Message-ID: <31a49f86032687601e617da89f831a162303f283.1719476762.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
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

Timer value is a 16 bits calculated from the wanted timeout and the
system clock. On powerpc/8xx, a timeout of 2s gives a value which
is over U16_MAX so U16_MAX shall be used. But the calculation is
casted to u16 so at the end the result is 63770 instead of 128906.

So the timer gets loaded with 63770 instead of 65535. It is not
a big difference in that case, but lets make the code correct and
cast to u32 instead of u16.

Fixes: 26e8ebcd7cb7 ("watchdog: mpc8xxx: Make it generic")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/watchdog/mpc8xxx_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index f28636ca90..67e687a364 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -44,7 +44,7 @@ static int mpc8xxx_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
 	struct mpc8xxx_wdt_priv *priv = dev_get_priv(dev);
 	const char *mode = env_get("watchdog_mode");
 	ulong prescaler = dev_get_driver_data(dev);
-	u16 swtc = min_t(u16, timeout * get_board_sys_clk() / 1000 / prescaler, U16_MAX);
+	u16 swtc = min_t(u32, timeout * get_board_sys_clk() / 1000 / prescaler, U16_MAX);
 	u32 val;
 
 	mpc8xxx_wdt_reset(dev);
-- 
2.44.0

