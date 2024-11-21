Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646F3D75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD3E896B9;
	Thu, 21 Nov 2024 06:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166784;
	bh=TFzlkhfSJSMQwS+uWvOlMPkxGRVM6g6L5o5kgRfmbYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bk3kwpvvF2zq2QnVaD12oXgjaLwaJvfdc/+QP7uMQx87FUQYuJ+yuOHd9+C6Ikbnh
	 A2Sb2/adNQnrjTLpJsPFjqlCm0e27i/bG0oOe927MyRzDsaPH+8fv4qkSjhoS3gSWC
	 50dhyszQhgQz3IIEvAOJ5OVshu9w621PZvaFR0xZOiPhsuhD51ijqH/CxTs2J49Yv3
	 waZqxZCPv0TY3BIHBzVIHmAxeHKCPWrx+qG1SduxLqXRokokohVcTtQ4pKrVQ/KHRH
	 DB+1ktv3wRcPVDcL0fup9CeeC7OWYO86MoijWX20o8FbBo9zpyS9p5ai5KFCC1P51J
	 JmrdC2ywya0gg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D40028966E;
 Thu, 21 Nov 2024 06:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166781;
 bh=TFzlkhfSJSMQwS+uWvOlMPkxGRVM6g6L5o5kgRfmbYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=suuUVXeM75Bpq09znOk5hgvNa8r0MawOEAUBoaTk9Zaq00NBpT3eiTl8AicLV2Xx6
 e8poErBG2fWGJnGGyLXVKsajOU8gWblxdpCmPeg71hGuqMjseNiOcK7zRzjPslGGN/
 qAthfb5WYp/zyy+44e7fcUc6b/XcoP0gwaQo6UjD5AfeEi++/eP53CAxehZl1JsYPs
 44zJTLf4nWbXIncwzHJg1ForjW2YMiolCl7NrJ2Il/BVkaoJKJt0UpdG1vNzxh5yHY
 +WEowlOUfpHMia/0F0Uw/ftyJ0X0Cgen19pBZrdHrKxXLrTMBJ9U1liuvxdYfbh8jd
 V4ItQE/eAEpRw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 14/20] siemens: capricorn: small board updates
Date: Thu, 21 Nov 2024 06:25:55 +0100
Message-Id: <20241121052601.72880-15-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

(no changes since v2)

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

