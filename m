Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61203CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD1683DEB;
	Fri,  7 Nov 2025 17:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fXj8xiGS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mJGhwMfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F197683DEA; Fri,  7 Nov 2025 17:17:22 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA7883DD7
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 17:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d342m3dNQz9tdB;
 Fri,  7 Nov 2025 17:17:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762532240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsUNQSpomt1UhmKzkW99RSGMbtUXOpZ/RJtkYuqSr84=;
 b=fXj8xiGS0PBXBK70I6aAofAL7vBPO+zJP9aR92EH7hjMOdZs/kxBg2KHHq5YVogOaE2jJM
 XD3ffatrzITHKCogMECAJSP9g6sTr8HZ/j4Zr7QqtGnd06uizuHQbbsuVPSQ0J6Kcwt5Yb
 84PAul3eAUishltUTHKus1+N/Jw1XBs3DOj8NpSvtNiaweZ7a+KtE2xQWiR827ym++a0P6
 bLCrq2KZqR//c3Pod1wlncUsOvorkWMF5aSnRBe/owRNMA7f3dSwzifyNtlWgM2Mx1lGdR
 nt9BJ+iflxlkAFfcv46qsrSCRNWqzpHanADlZZhtLwKecCHatT3BrvuiToFo1Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762532238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsUNQSpomt1UhmKzkW99RSGMbtUXOpZ/RJtkYuqSr84=;
 b=mJGhwMfiUdDb4bL7HBp9f23xjzEm9zaTPVejk3+/IFW464l8U+RthsmQPl9lcZ/im6Uf7t
 QyO/rCptZIncjwPMFVnH0odi5LtYkhR/U2jpNl5M9V+TDAPtzAvO910v/1Ekx/yvVog76x
 SvuIydgn52FslzdWryfzdWG6YgVf6lj2MzOqI1OdZq0YXZpqPrKPjvfoC7rTD6svi6Swtp
 HXQ8vsZA7Zd8K7LsqwIiQa6blJnyohv570ygdgbIOcTYC/HUc+RkaDFIrq69dBXBv4W2xV
 Kvn4EITJHNUNXcZsLN43TLDXUux4NBHt/mqXAluivHv7SBZ8Is5IBeJfkddVIg==
To: u-boot@lists.denx.de
Cc: Huy Bui <huy.bui.wm@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Thanh Quan <thanh.quan.xn@renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] pinctrl: renesas: r8a779g0: Remove CC5_OSCOUT
Date: Fri,  7 Nov 2025 17:16:54 +0100
Message-ID: <20251107161708.37236-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251107161708.37236-1-marek.vasut+renesas@mailbox.org>
References: <20251107161708.37236-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 53b6c21fe3e690b1a2f
X-MBO-RS-META: dbhdty4zr4qp9ktfczwjbkp6qrxapgjn
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

From: Huy Bui <huy.bui.wm@renesas.com>

Rev.1.30 of the R-Car V4H Series Hardware User’s Manual removed the
"CC5_OSCOUT" signal from the pin control register tables.  As this is
further unused in the pin control driver, it can be removed safely.

Signed-off-by: Huy Bui <huy.bui.wm@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Linux counterpart: https://lore.kernel.org/all/77f9efe5388f2801ace945b7793d4823618eeec8.1762274384.git.geert+renesas@glider.be/
---
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Thanh Quan <thanh.quan.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index 53d364b3517..f188c27f63c 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -499,7 +499,7 @@
 /* IP0SR7 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
 #define IP0SR7_3_0	FM(AVB0_AVTP_PPS)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR7_7_4	FM(AVB0_AVTP_CAPTURE)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR7_11_8	FM(AVB0_AVTP_MATCH)	F_(0, 0)		FM(CC5_OSCOUT)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR7_11_8	FM(AVB0_AVTP_MATCH)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR7_15_12	FM(AVB0_TD3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR7_19_16	FM(AVB0_LINK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR7_23_20	FM(AVB0_PHY_INT)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -1119,7 +1119,6 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP0SR7_7_4,	AVB0_AVTP_CAPTURE),
 
 	PINMUX_IPSR_GPSR(IP0SR7_11_8,	AVB0_AVTP_MATCH),
-	PINMUX_IPSR_GPSR(IP0SR7_11_8,	CC5_OSCOUT),
 
 	PINMUX_IPSR_GPSR(IP0SR7_15_12,	AVB0_TD3),
 
-- 
2.51.0

