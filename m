Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60BDC54788
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 14:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE528808C;
	Thu, 22 Feb 2024 15:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="N7LcHMg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B91C28809C; Thu, 22 Feb 2024 15:52:56 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED1288087
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 15:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.perrot@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB4AD20003;
 Thu, 22 Feb 2024 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1708613574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jAt8Mf946L/bg6WNqFU1z+YcUR+wMUk/itxtXignECg=;
 b=N7LcHMg3Zo6iFjValZVBiMz/KK0aakxsB0E1P1UO43NZtF087nDtpebn/hauUlI/gcr99G
 2kR47mf66iGD4AKhwyOswipH4QLLoY4EECSaIbBaFukHGqciiIQXFNBaj4haiUoLSF6VXT
 JQajD+pvroXm970yMpAY+5nEAjyjOzOZqf+ygFCy1v4fb9O+rki3Ulj5EtL57ybwtPbKrM
 joHWxaRVE76bq7exdUnl/d5r2XF8l+1RBRsbx9YSsKR2p3oPRKXcA47ZTPII3ScZxWnRHf
 t1uBF+GESs6DZ/khP7c/STFZ7yznvQVTSB1pSvTzCiiUy42d0QG709JxQWQaug==
From: thomas.perrot@bootlin.com
To: u-boot@lists.denx.de
Cc: Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [PATCH] riscv: sifive: fu740: reduce DDR speed from 1866MT/s to
 1600MT/s
Date: Thu, 22 Feb 2024 15:52:03 +0100
Message-ID: <20240222145203.2659671-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.perrot@bootlin.com
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

From: Thomas Perrot <thomas.perrot@bootlin.com>

It appears that there is some timing marginality either in the
board layout or the SoC that results in occasional data corruption
on some boards.
We observed this issue on some of the new HiFive Unmatched RevB
boards during volume production as well as some of the original
HiFive Unmatched boards from 2021 in our possession. This means
that there are other boards out there that might have the issue
too.

We have done some limited testing with DDR4 at 1600MT/s and
faulty boards (failing at 1866MT/s) passed.
We plan further testing after we procure a temperature chamber.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 arch/riscv/dts/fu740-c000-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/dts/fu740-c000-u-boot.dtsi b/arch/riscv/dts/fu740-c000-u-boot.dtsi
index 706224b384d2..956237c3218e 100644
--- a/arch/riscv/dts/fu740-c000-u-boot.dtsi
+++ b/arch/riscv/dts/fu740-c000-u-boot.dtsi
@@ -77,7 +77,7 @@
 			       0x0 0x100b2000 0x0 0x2000
 			       0x0 0x100b8000 0x0 0x1000>;
 			clocks = <&prci FU740_PRCI_CLK_DDRPLL>;
-			clock-frequency = <933333324>;
+			clock-frequency = <800000004>;
 			bootph-pre-ram;
 		};
 	};
-- 
2.43.2

