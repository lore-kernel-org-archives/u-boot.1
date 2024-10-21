Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BA8D15DA5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74C2E88EDA;
	Mon, 21 Oct 2024 17:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BBSum0zj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E4C88E91; Mon, 21 Oct 2024 17:13:36 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BD158878A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 80A5EFF804;
 Mon, 21 Oct 2024 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1729523614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byT4dG4eHtqmnXOMp+wHxVfraqmCnxj+QM/ceJKZ3mo=;
 b=BBSum0zjYmjZf1LZJCxQKcUbI+xMribKV02YMxYygApgUnfqrDOsDOoS+R7dh/kIfQrIHG
 0pt/AIXQoA1d2bdF3okYnhU0OT7s+pz5VLpWomZQ76Rupw+mX7FW84QemzP9N//DYh1Q0A
 7LrrcalENBM/voEO7VWphb3C+vhCIKj4rFbqnlYV6EK+iqI+Vc8ERiJBjH02hpfelwNfYH
 +w8BJuoDfm8CgrF+79sRB4SyyApUDFTnqortvTo9g6zJdPmE99edGdedEiwzGe3eQUvDwZ
 V8tHoXAFjdd+0WjaGvOMpB7ccooC6t1bZvaIFXjVAt3w+IWvltrM13RtAE/Q7A==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Tom Rini <trini@konsulko.com>,
	Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 1/6] memory: ti-aemif: Correct macro to ensure avoiding
 precedence issues
Date: Mon, 21 Oct 2024 17:13:25 +0200
Message-ID: <20241021151330.1860929-2-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
References: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
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

Fix following CHECK pointed out by checkpatch:

   CHECK: Macro argument 'cs' may be better as '(cs)' to avoid precedence issues
   #62: FILE: drivers/memory/ti-aemif.c:15:
   +#define AEMIF_CONFIG(cs)               (0x10 + (cs * 4))

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/ti-aemif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 29131f536a..127a262894 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -12,7 +12,7 @@
 #define AEMIF_WAITCYCLE_CONFIG		(KS2_AEMIF_CNTRL_BASE + 0x4)
 #define AEMIF_NAND_CONTROL		(KS2_AEMIF_CNTRL_BASE + 0x60)
 #define AEMIF_ONENAND_CONTROL		(KS2_AEMIF_CNTRL_BASE + 0x5c)
-#define AEMIF_CONFIG(cs)		(KS2_AEMIF_CNTRL_BASE + 0x10 + (cs * 4))
+#define AEMIF_CONFIG(cs)		(KS2_AEMIF_CNTRL_BASE + 0x10 + ((cs) * 4))
 
 #define AEMIF_CFG_SELECT_STROBE(v)	((v) ? 1 << 31 : 0)
 #define AEMIF_CFG_EXTEND_WAIT(v)	((v) ? 1 << 30 : 0)
-- 
2.47.0

