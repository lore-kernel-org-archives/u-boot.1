Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E87C3ABC9
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE13C82A4D;
	Tue, 13 May 2025 11:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ekSzP9Qz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78E78295C; Tue, 13 May 2025 11:05:36 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D5182991
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AE4D2260C2;
 Tue, 13 May 2025 11:05:34 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pqc23W98VXf5; Tue, 13 May 2025 11:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747127134; bh=cqYYgytrOfmLxXMxa9fcUzlSq8LidnsU4f/U20x5zXw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ekSzP9QzAK0GOJoTAbxPoVou1smD+AWILo2OR/TQ2vxAQaIEvyeguhnn3PNbFnoHq
 l92y6B1s55BmGPmL2ytVBLYzHXAxua8qLyEzqeJ3n0B+PzhRMXvue1GJ33eNC6aPt5
 iJznU6YEmOPpoAptV6oW19C6f4TtkbSnOY6/r0vyHAAOSVKn9JwQvSYCduX6zBg+2c
 riqUlZifJQSg0wOfD/g2Dx564AJES1iHhjcoHJKynxUQlZJiw3ebJQmQvJn04SqRBh
 EDobdICr5irshsNEUzcBp9gNHWtaXZjvcxkcvscNmweg66XMohuJFYSFCSedJA29jH
 T+uBWyBCHtQoQ==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 02/10] configs: th1520_lpi4a: Add UART clock frequency
Date: Tue, 13 May 2025 09:04:55 +0000
Message-ID: <20250513090503.46670-3-ziyao@disroot.org>
In-Reply-To: <20250513090503.46670-1-ziyao@disroot.org>
References: <20250513090503.46670-1-ziyao@disroot.org>
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

The BROM of TH1520 always initializes UART0's parent clock and
configures the baudrate to 115200. Describe the clock frequency to make
UART function correctly in SPL without introducing CCF.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 include/configs/th1520_lpi4a.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/th1520_lpi4a.h b/include/configs/th1520_lpi4a.h
index 87496a52c4c..7a9b70a3678 100644
--- a/include/configs/th1520_lpi4a.h
+++ b/include/configs/th1520_lpi4a.h
@@ -9,6 +9,7 @@
 
 #include <linux/sizes.h>
 
+#define CFG_SYS_NS16550_CLK		100000000
 #define CFG_SYS_SDRAM_BASE		0x00000000
 
 #define UART_BASE	0xffe7014000
-- 
2.49.0

