Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A4FF30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D9884462;
	Mon, 16 Mar 2026 00:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bqEqfmN+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Z/fCQEw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6BA84461; Mon, 16 Mar 2026 00:52:27 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563628446D
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fYw4m1HPsz9tc2;
 Mon, 16 Mar 2026 00:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eYz2cJdpG1Yne/Id/Kcib+a014SZIAx3UleE2MYmafs=;
 b=bqEqfmN+WprrlNrMlRngsGAk0WBvNX96L1+h5PwWuw2okTbsrGNyXrPrQ2gs/H0f3iDkxq
 DN3e7UT3Uk8q8BicrTA4zRQNOOJCon7hDz5w/n866iR4qO0IXyV7q249ZmPoGKeQR+oZG/
 kp+EdxzlUgJEl2xGkWExMIjZ8L2Yg+J93MDsV648rFS3kVjCrWH5Yyuor1P/o0SoWfBPHB
 5zonnxmKUNYTdtPb67EjPgO7X6dZGWPzEaq4ZHOJSgRkjxRcsFMC/sYs5Y1TM/2Y3484/4
 fXk1jNja8dGRvMFVcTt6vu0dBtKMkhN7EBhCZDyOqph5izhztImNW20sDhpoAg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="Z/fCQEw3";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eYz2cJdpG1Yne/Id/Kcib+a014SZIAx3UleE2MYmafs=;
 b=Z/fCQEw3oFIcE+75RYDKOrTkIdvQV+VdfKurAbCDDwRU6mWmVS2DMnj2TkS/mZg+wJq87U
 NLxADc1bQjtPLM5iQOBf1kZBvcY4YuY7Gh9CYZfpRtDg7JPm+B1IHfHRzkndfPQGJ9jXRl
 aDQte55n9YVwPd1ooDp2t2687k+4b0FfsP2tmtbGZzKNq6XBIDXE5XiCdAUZ0sJZGYqnFY
 E1pLT/jV4ckjcKptcOAa3K5Y4Wg9Jp/1kz8e5pHtygaQn6DcJuq6HjFWh/HkAKsvaBmEx8
 kllP94cS1/AVREvO/6pobtkbyZszgdh4vgP2A890tacuCcpLpYoLtw18uS/j0g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: Disable SCIF1 in Renesas R-Car X5H
 R8A78000 SoC DT
Date: Mon, 16 Mar 2026 00:51:59 +0100
Message-ID: <20260315235220.304562-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: so1465ggx1x84zkw37s1gi7okzhbmx7q
X-MBO-RS-ID: 1998849fa5f514cdbeb
X-Rspamd-Queue-Id: 4fYw4m1HPsz9tc2
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

Disable incorrectly enabled SCIF1 in Renesas R-Car X5H R8A78000 SoC DT.
The SCIF1 should be enabled on board DT level in case it is needed, but
should be disabled in SoC DT by default. This had no adverse effect on
the currently upstream platforms, because those managed to probe only
the HSCIF0 device and SCIF1 was ignored.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a78000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/r8a78000.dtsi b/arch/arm/dts/r8a78000.dtsi
index 0d0c24503e2..89c2881fa94 100644
--- a/arch/arm/dts/r8a78000.dtsi
+++ b/arch/arm/dts/r8a78000.dtsi
@@ -763,7 +763,7 @@
 			interrupts = <GIC_SPI 4075 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			status = "okay";
+			status = "disabled";
 		};
 
 		scif3: serial@c0708000 {
-- 
2.51.0

