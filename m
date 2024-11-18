Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25578D68BD0
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECBD89443;
	Mon, 18 Nov 2024 07:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911259;
	bh=wR00ldh7OvwFdSVWAj4YdBBw+jVfg4i3M6k1i0FGVPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jr2N0Sw/TTjQLjC0UJUbLWf2vgKn3jM1rmklhorUmhnvvXzK856YlZwzxHqVbOdhd
	 YADcM5cALuB0bMhB+0PRDubnFWlkNzEfU+ofZBs1G3lNevugzZBgJj2IOUnxs4Ijrm
	 eTb8QEcq6AI3oufIun9sJNIkQq+YfcQnoTEEyE2zi5B4ymflKGckBP9pOOU6369LJO
	 K9OQYfs2g3PMCip080o4MsoxdYQlM8mwvuXc/8FqMZ13MaYlUk9PzXGD1o9jmlFDJy
	 610chAVxiKRiCqrPnKcvwuU/tHecjdkVq//r/LSEtulZTJpWRuDgmt8vvGmfEF8jHi
	 yDBF5GvYItU1Q==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DED25891A9;
 Mon, 18 Nov 2024 07:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911256;
 bh=wR00ldh7OvwFdSVWAj4YdBBw+jVfg4i3M6k1i0FGVPY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ykECNbrmvJWYmMCFDjsKu6+QvuZTKjLpRMUH7MAYM32ZN6GeNmQBjGnhd444ikjK1
 M0p9nVwD7v4DB8QxvdL1dBN/40bFcn2lmnGR0SXWoe3arq8gm81Ogf4wmEZi+6k4Bq
 1EJDYD0jlpg6YXhx0oKGuKilA9JvqJukzgen/rxDrD3i+Kg6YByk+fgmAtyN0iCRqQ
 aXqJPjEIFxOplAi+rE0PhbOisouT3vG20TxpXt+YB9Q43k3XwRYXZQjmv+RF5y4WWP
 EL2e9IAkRDObvEFZTlfMXRj9oe6rp4CcU22vjDhYzsX/BYcHkXwB275z0srA1eRMck
 bB3lIIzg8EKvQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/20] siemens: capricorn: small board updates
Date: Mon, 18 Nov 2024 07:27:08 +0100
Message-Id: <20241118062715.32989-15-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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

with newest SCFW build_info() works now, so call it
from checkboard() now.

As we only use uart2 as console, do not init uart0.

Signed-off-by: Heiko Schocher <hs@denx.de>

---

Changes in v2:
- add comments from Fabio
  rename subject line and rework commit message,
  alse remove unneeded comment in checkboard()

 board/siemens/capricorn/board.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index ad474d9baa0..bf04f12c75b 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -63,8 +63,7 @@ int board_early_init_f(void)
 	sc_pm_clock_rate_t rate = SC_80MHZ;
 	int ret;
 
-	ret = sc_pm_setup_uart(SC_R_UART_0, rate);
-	ret |= sc_pm_setup_uart(SC_R_UART_2, rate);
+	ret = sc_pm_setup_uart(SC_R_UART_2, rate);
 	if (ret)
 		return ret;
 
@@ -271,11 +270,7 @@ int checkboard(void)
 {
 	puts("Board: Capricorn\n");
 
-	/*
-	 * Running build_info() doesn't work with current SCFW blob.
-	 * Uncomment below call when new blob is available.
-	 */
-	/*build_info();*/
+	build_info();
 
 	print_bootinfo();
 	return 0;
-- 
2.20.1

