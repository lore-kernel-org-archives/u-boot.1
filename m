Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93442E6ADE3
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC3D89432;
	Sat, 23 Nov 2024 17:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380806;
	bh=SQ2HNFmU5CeNjCvguMAiwL608DQT6l7Ng/l18yH8wzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ks69PWbo0v8/C1euQcscRnXO/fadjLNoM+2RuRokXpJvuhmHJ08DcAXEyROgxo3fE
	 IbYs034oHjr3HHmeCpXUCOZag5uNkKGpeXTvVnvpHxCZM7SNqFPBLV9ofi/q4DVEak
	 rnS4JpCq5vPfFsmlL35KbMBnHdHNrCLL6s42E/PqK9IubSh+WyAgNwvoi/s0gPXqQY
	 ZXjL23C04bMfQjru8zCordSPDNEp9NRnK6T6YOKN2725FBN7zN4cqqREVRNH+c8UU8
	 x8KPDwdRvClT1Hq5jkBUEEtHK8mQ49CMJBehONRzZthUyaNMGOCoivqnozf7neULTn
	 44385JglAzAZQ==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 844CC88EAF;
 Sat, 23 Nov 2024 17:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380804;
 bh=SQ2HNFmU5CeNjCvguMAiwL608DQT6l7Ng/l18yH8wzE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N/0n+DeCrZe+lp6zs5FxPTA+4LBJDWmAcnSULHcfe1Ohd0+6nV7sWJBsYzZoo20uQ
 nKBJF6YPyvka0rRr8LJYBkKp1ntdQYykMn9rNXS6LfrwSc0Gt0wOJ3vWwc3WPB6HuF
 WEEtLgMa6+Q+aXf5TuTIpHVKYfO6jcM7+MBFTHcsqtVslcpBYrt2jqDApQQqM3qD2Z
 YRQiPtvbBz0n+2jKXLrafSQhoPX/8RJGTITPypUQJCZkfpX00BdyTi/7fiwwlVcJel
 2/f50hlWynGLB3duZjN9vctp8OEeV2ADktRWBc1ZQfMs4GRPQDPoCmOIABgJhB6Xle
 r2bkKpAkH8tzw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 14/20] siemens: capricorn: small board updates
Date: Sat, 23 Nov 2024 17:52:58 +0100
Message-Id: <20241123165304.100538-15-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---

Changes in v4:
- add Reviewed-by from Alexander

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

