Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDA1D5E12D
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E4189235;
	Fri,  8 Nov 2024 06:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043329;
	bh=kx91WIzjZenScg55sVzP/qbT2rRQ6Scp4HzKWOslLIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0LrkicnYP8pvMNIIMlFhPIHMIouvMj2SL6tomVX6/DiTEX5ePEa35MEPpTmGzTY1Y
	 fb+8nTfXtaKtgfkBQ5NCAtyF9gtfnF21Gow4C4JuesnUDo6weMW0CeUPNVlf4IkV0t
	 shOKmHl0brdrSJEstadJfa1HeEZQYycKb/qCDm2VD0Yp/YIDbSaCcCFg4bQtZdSwlB
	 UB1S58g2Pfr0ZZiucGILgRYnbILFekfWbb9EXPjxvKeA+USrhVMzRwHEIpAwVdYevk
	 RnPKkzDlvUqNjOg1TjJR+CEOFLUcZF3WkqmY8qqAIixmIW0THeMfWL/vrI1Kqt7VZN
	 EePtmxD5g6h0A==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 43A47891BC;
 Fri,  8 Nov 2024 06:22:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043325;
 bh=kx91WIzjZenScg55sVzP/qbT2rRQ6Scp4HzKWOslLIs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zprSS9uRcSXnTsf3LNeFdzHhG/xAQA+RUA3H2Z/KjScySJGqgUC3YJFBkcUh4tRPW
 /sKJ6ficJfVPZK+qzIvPCpv8jD8V9YEaboMuGaIJUZXbp2e1PJCqaNLbHR2IlUlaWm
 JwQ+5qkrDR67RBifDyzc+h2sZvrwyZi4Ks0AP1r7FGjo9R/mCzMb4BrC4fsQn/LOw/
 jslltmm7V0TnZ3XTV+U4fsKzcCpJ+zCIMnAvIDSsdYgs1yYEv/6fCPDx1hBfP/R5xD
 oM/fRnz5+0a8FQU1lRF7LHE2pGoQwvXiIKh/WuAOXxpybrgyhrR8eXxNWwpqkSo2el
 lsJpi7bgSXz2w==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 16/22] siemens: capricorn: board.c fixes
Date: Fri,  8 Nov 2024 06:21:37 +0100
Message-Id: <20241108052143.26874-17-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

show build_info and only init uart2.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 board/siemens/capricorn/board.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index ad474d9baa0..99681d68c3f 100644
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
 
@@ -275,7 +274,7 @@ int checkboard(void)
 	 * Running build_info() doesn't work with current SCFW blob.
 	 * Uncomment below call when new blob is available.
 	 */
-	/*build_info();*/
+	build_info();
 
 	print_bootinfo();
 	return 0;
-- 
2.20.1

