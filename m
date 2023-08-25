Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C8FC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8931386B28;
	Fri, 25 Aug 2023 20:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c5v0AHmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7B0F86ACE; Fri, 25 Aug 2023 20:03:25 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962A086AE1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI37C0111948;
 Fri, 25 Aug 2023 13:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986587;
 bh=ZQlyQn6RpwiNwQn0C2wpuftw8WvssV/EGVl6AsTmQ/g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=c5v0AHmxs6nHdIm5B+x07byf0w0g8m3N9pow2W3xVdtNE6wUIC6lvi0oI44txjjw/
 c446tq4kmlaFpVnb27EODfSbLNYxDmuwOtkDqeunc8clAIL7SeP3kPigsOFId2vepd
 uAs/2Mr+9s5gZj2FrotpMeU+MrSj1nl8DJVCuqMU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI37Ij123997
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:07 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI360s038419;
 Fri, 25 Aug 2023 13:03:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 13/20] arm: mach-k3: am625_init: Convert
 rtc_erratumi2327_init to static
Date: Fri, 25 Aug 2023 13:02:58 -0500
Message-ID: <20230825180305.69515-14-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230825180305.69515-1-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The erratum is called locally, make it static, drop the #ifdeffery since
it will only be called in R5 build and mark it potentially unused to
stop compiler screaming at us.

While at this, drop the redundant return for a void function.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
No change other than picking up reviews, tested tags along the way.
V5: https://lore.kernel.org/r/20230824031101.3460411-12-nm@ti.com
 arch/arm/mach-k3/am625_init.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 165bca6885ef..499cb57267b9 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -80,8 +80,6 @@ static __maybe_unused void enable_mcu_esm_reset(void)
 	writel(stat, CTRLMMR_MCU_RST_CTRL);
 }
 
-#if defined(CONFIG_CPU_V7R)
-
 /*
  * RTC Erratum i2327 Workaround for Silicon Revision 1
  *
@@ -94,7 +92,7 @@ static __maybe_unused void enable_mcu_esm_reset(void)
  *
  * https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
  */
-void rtc_erratumi2327_init(void)
+static __maybe_unused void rtc_erratumi2327_init(void)
 {
 	u32 counter;
 
@@ -112,9 +110,7 @@ void rtc_erratumi2327_init(void)
 	 */
 	writel(K3RTC_KICK0_UNLOCK_VALUE, REG_K3RTC_KICK0);
 	writel(K3RTC_KICK1_UNLOCK_VALUE, REG_K3RTC_KICK1);
-	return;
 }
-#endif
 
 void board_init_f(ulong dummy)
 {
-- 
2.40.0

