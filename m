Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D7ECFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 07:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C3183BF1;
	Mon, 24 Nov 2025 08:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="R3gH+IJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C630D83D01; Mon, 24 Nov 2025 08:57:33 +0100 (CET)
Received: from mx-relay48-hz3.antispameurope.com
 (mx-relay48-hz3.antispameurope.com [94.100.134.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765B483BF1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 08:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0416cdc3b4=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=+NBDW5zbwPoK5kgj3eLvtFk3lRxSfQsitKP+Q7oPn54=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763971048;
 b=NurHCv0X80YJHvpCQSzjgB0F4k13uGoPEd3nYIyBHF+UwEe44SC8nkLQGjYZoGmb23GZ+A84
 woF155AGAHFQMcA0klpR8c4Yf+B78BmNaZkrCDCvHIkVCJlWaQH0osYrfJmrRdULEyMTaoTVzBt
 0Pfx/+kvhZUltDikMBy7hb06l0y37B8OFDETDYZZFR8c0qc1qkxOic/neJmFeIhFYq6XPjRPg+B
 MYMhT7hPvD9o2rlZp8fvg4UB+YSfDVjqSCZqujK49g7/bgwSCbN2xEzZ2+JKCmP9L17xO0VwaTL
 Xk+L9/VpykJwJLsJL3s4RGJ4IHvwZPuXMy1vIwxqCLV7A==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763971048;
 b=Xxx2WzSp+u2UHirsCgyGVpU+0PlhC3nArYFWCR6IRv/7uUYFRtACwgYe13diNMVs4aPxFikn
 7iIOilNhfCj80F5EOHiGrpq9Qt5+C614pbWp+YFZixYmw9x+cXrsyeLkCuxIAwKvHo6psY93JGY
 u7k+ahCu43jEi1r5aLtcZZeF/oTnXQIwoKO0zMlp8Dxfbt4oZhXa4X9HLIcbf/ls207C7Fvbe+6
 PcxFzY0ugKZ7U07uzFdjJUURvJBUBvaMDeylqZTmxOA7PWk5sIeMPYpuecGBhf2oom8k+/yt+Gu
 nDwhDah/0k0x+nK57qXA/qrjNKBgPxL9bx3K+XFo3MPKw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay48-hz3.antispameurope.com; Mon, 24 Nov 2025 08:57:28 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 B6447CC0CC5; Mon, 24 Nov 2025 08:57:15 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: [PATCH v2 1/4] tqma6: Remove empty function tqma6_iomuxc_spi()
Date: Mon, 24 Nov 2025 08:55:23 +0100
Message-ID: <20251124075540.14930-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124075540.14930-1-Max.Merchel@ew.tq-group.com>
References: <20251124075540.14930-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay48-hz3.antispameurope.com with 4dFJ7w2m6gz1kPGJT
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: bbcb1b07d3824ac45adc56feb180c439
X-cloud-security: scantime:1.934
DKIM-Signature: a=rsa-sha256;
 bh=+NBDW5zbwPoK5kgj3eLvtFk3lRxSfQsitKP+Q7oPn54=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763971048; v=1;
 b=R3gH+IJliVTZvQIkIvvfeafsnkVRumCnqg3Q59tqhORDUKuVK82soWS0X2uIGpazI8nsnuhc
 H8kFlGUjZMeVF/HPYyp/DPjYGhHrCHpi4/2qHL1cFte5cc2jRuNNzUf/i7vzKo+WIXjs8yFSmvT
 tBaoxGG5fEsbcgbfRmZDHocfULXlc20uGNqQc1MD14A0xHbX5EaQQ3cebuzF4VNCgO24zGlzMbP
 ijrZ5yqcBN1kN818T7Ozz761dd+RjiZPJPq+aXgFDKjc0QMsEurDOA3TXan7qEiNYgMaonAJIhV
 JsSQUNDJc3p1Sbfs+fj0ULSroIxsOUVvRG6lXZijtFRfQ==
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

The function `tqma6_iomuxc_spi()` was removed in the commit
"tqma6: Remove non-DM board code".
The original function was overwritten with an empty function in the
WRU4 baseboard and should also have been removed.
Therefore, the function and its call are being removed.

Fixes: 93552cc442de ("tqma6: Remove non-DM board code")

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/tqma6.c      | 3 ---
 board/tq/tqma6/tqma6_wru4.c | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 40369f03e72..a7317b9e761 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -48,9 +48,6 @@ int board_init(void)
 	/* address of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
 
-#ifndef CONFIG_DM_SPI
-	tqma6_iomuxc_spi();
-#endif
 	tqma6_bb_board_init();
 
 	return 0;
diff --git a/board/tq/tqma6/tqma6_wru4.c b/board/tq/tqma6/tqma6_wru4.c
index 21c710188e0..aa53212e0e8 100644
--- a/board/tq/tqma6/tqma6_wru4.c
+++ b/board/tq/tqma6/tqma6_wru4.c
@@ -254,11 +254,6 @@ static void gpio_init(void)
 		gpio_direction_output(GPIO_UART3_PWRON, 0);
 }
 
-void tqma6_iomuxc_spi(void)
-{
-	/* No SPI on this baseboard */
-}
-
 int tqma6_bb_board_early_init_f(void)
 {
 	setup_iomuxc_uart4();
-- 
2.43.0

