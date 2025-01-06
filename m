Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64D8E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 21:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B5F8036B;
	Mon,  6 Jan 2025 22:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jrMjcpCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E76D801DB; Mon,  6 Jan 2025 22:39:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC325801DB
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 22:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=48da=T7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1736199594;
 bh=6BH8caVWXhZ9mTySDSjeY7WEIvRBGIt7QOzgakJvJl8=;
 b=jrMjcpCcB1Lqz6zODFsx1NmESAONB7G7YvFz3MHfgVQ6RHhyI+FaJIRNwISCa0RitTpnoyQyx
 0L7wtSAjG3iSpTn0lSpJ6lyMoNVqCF9xNHxbjqHEMsQBfC68pc2ZfGLVKkauB8CPeyOb884EFPh
 OHgUWLxMXvscjFfA4kLa7bTPMtu4fZAIkBcqZRNFJTfj0iLp/d8uSWdMUM4aq+aSW9gUnf+4FIt
 gzvHPgI+nboPI6AKBX3lPdFg6ANq6xo7+H4bTmsQxI+zcGEU/ibkVnx4tkjeFO+4El6tjlMOi1s
 RvZM3hCwD2r8iM/cTyWkIFbQ0+TVD7vd3TEpdoNJrNow==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from bionic.. ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Mon,
 06 Jan 2025 21:39:45 +0000
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] pinctrl: rockchip: rk3328: Fix pinmux for GPIO2-B and GPIO3-B
 pins
Date: Mon,  6 Jan 2025 21:39:42 +0000
Message-ID: <20250106213944.3796172-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 677c4da53a8d812ac5ca648f
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

The pinmux bits for GPIO2-B0 to GPIO2-B6 actually have 2 bits width,
correct the bank flag for GPIO2-B. The pinmux bits for GPIO2-B7 is
recalculated so it remain unchanged. Add missing GPIO3-B1 to GPIO3-B7
pinmux data to rk3328_mux_recalced_data as mux register offset for these
pins does not follow rockchip convention.

This matches changes in following Linux commits:
- e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins")
- 5ef6914e0bf5 ("pinctrl: rockchip: fix pinmux bits for RK3328 GPIO3-B pins")
- 128f71fe014f ("pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins")

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/pinctrl/rockchip/pinctrl-rk3328.c | 59 ++++++++++++++++++++---
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3328.c b/drivers/pinctrl/rockchip/pinctrl-rk3328.c
index 47c2e923a1bb..dd0dc2eff270 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3328.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3328.c
@@ -14,23 +14,68 @@
 
 static struct rockchip_mux_recalced_data rk3328_mux_recalced_data[] = {
 	{
-		.num = 2,
-		.pin = 12,
-		.reg = 0x24,
-		.bit = 8,
-		.mask = 0x3
-	}, {
+		/* gpio2_b7_sel */
 		.num = 2,
 		.pin = 15,
 		.reg = 0x28,
 		.bit = 0,
 		.mask = 0x7
 	}, {
+		/* gpio2_c7_sel */
 		.num = 2,
 		.pin = 23,
 		.reg = 0x30,
 		.bit = 14,
 		.mask = 0x3
+	}, {
+		/* gpio3_b1_sel */
+		.num = 3,
+		.pin = 9,
+		.reg = 0x44,
+		.bit = 2,
+		.mask = 0x3
+	}, {
+		/* gpio3_b2_sel */
+		.num = 3,
+		.pin = 10,
+		.reg = 0x44,
+		.bit = 4,
+		.mask = 0x3
+	}, {
+		/* gpio3_b3_sel */
+		.num = 3,
+		.pin = 11,
+		.reg = 0x44,
+		.bit = 6,
+		.mask = 0x3
+	}, {
+		/* gpio3_b4_sel */
+		.num = 3,
+		.pin = 12,
+		.reg = 0x44,
+		.bit = 8,
+		.mask = 0x3
+	}, {
+		/* gpio3_b5_sel */
+		.num = 3,
+		.pin = 13,
+		.reg = 0x44,
+		.bit = 10,
+		.mask = 0x3
+	}, {
+		/* gpio3_b6_sel */
+		.num = 3,
+		.pin = 14,
+		.reg = 0x44,
+		.bit = 12,
+		.mask = 0x3
+	}, {
+		/* gpio3_b7_sel */
+		.num = 3,
+		.pin = 15,
+		.reg = 0x44,
+		.bit = 14,
+		.mask = 0x3
 	},
 };
 
@@ -275,7 +320,7 @@ static struct rockchip_pin_bank rk3328_pin_banks[] = {
 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0,
-			     IOMUX_WIDTH_3BIT,
+			     IOMUX_8WIDTH_2BIT,
 			     IOMUX_WIDTH_3BIT,
 			     0),
 	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3",
-- 
2.47.1

