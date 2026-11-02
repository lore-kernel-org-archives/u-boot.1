Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E3606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oKJy1aD2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06D41406A5;
	Mon,  2 Nov 2026 13:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ZJFl0lLW_5j; Mon,  2 Nov 2026 13:10:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9566E406C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793625038;
	b=Z/GpTg2GNJstpj5ruHXjmvUd3u/+87g0vaHqWAzi1SOly4SHKGf1gU8EQjtLXMFCciW0
	 lN05kTaL7J52uQaF0AvbMBCocdQSwXK1eSaVRVk3cjeCve2W6TYFm3ogN61ORjrES1egz
	 BCouB5bS4F5UhXNOv73xGTrj5U+rEKF9P+DXyVAaVypeCA5UtlJYHLG3XBuaIPNYUU7Rd
	 OxJH1IJ5X+P8dAoCknM+CowYfh9hwZM2pPtqRsX/moGyrPgsBI/qhqJhLwT3bL886G0A6
	 bLq8z8XJcqvl57nRZSh29msET9G3zkD3B0SrZb4sVDaN8cp+iKk+6eySq82MFa0GhfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793625038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q6NG5Q3EKrG+OXNwPQt1zo+B4dnZtz0m2HraeHJMJRg=;
	b=JNjGRLWrDTlOm/A0iF0mNKciF1QXfwan2Z4S/kFKj3AkiFTqyoS1kHMMqgvXOL/EBSxG
	 YdZPFbN5nK/3rdjofH5DUXrMOaHW2HUs5jpXbttDC1LpQG9S4BEWtklGXK8tdps8NtxPm
	 JXtnE2KoOonK2DDgYIXMFh3baTiaiwZMBJlqwZ4pFK6SH6BB53NfL8tS+leLqNrqIcjUa
	 lCCaCcuEP2Z/gXmXm70o7TRCkqPqyOmOHs6MA8npXPM0KTKgK+y8jtak9xbOnt6NO9lht
	 Fm3zNIn7b8Bd34kKDnkNMRZFqPcx6RPXLVWPsnv0CPP7Pw8nJsAQAF5H2iFyuUxNWQQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793625038;
	bh=Q6NG5Q3EKrG+OXNwPQt1zo+B4dnZtz0m2HraeHJMJRg=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oKJy1aD2ozSZvzvVzdJw93++eeCAPUzwkwDV2bJKmqDELGbKnOFYriCXNwNQwi6SI
	 yHPhtqKjwAcdAWh0HKmpCUlPno9IGu63iBmVFbozCS0nQVVyO31bsL3twrS+XpKjKm
	 2czbZcHaqociSNRkHBYYe6g9uuZ4G//lJ21Uf1u7vSKe1c9U4Pz+It3EJAImujAHWz
	 i22eeRkae+27kOIS0GPr2q3hWNf6vcI6MHPQAP1xrgRgG639G4YOplZUZgmwH+nEbB
	 NBcNIRAD1jCV3gG60l/o/nzXdS81LlOuHWhymVQxOpNHdjUvCM2bcgzy/kC5quEpVb
	 G2zsCRsJDtCFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9566E406C7;
	Mon,  2 Nov 2026 13:10:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58F09411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F2FD80F4D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:01:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ALaLWJtO5oof for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:01:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B235680F47
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793610085;
 b=Kp5RRnl1twTqxbfPsc5ziGTlBLeX5DMJpmGF4fGi1KJuwNoLcpvIE7KHFGeswjfooCGf
 LJKKV367erZsQl3QPqmBUgMEL0Ebp7e+Z2zTM8b4PrZDe9FG3P2lcj0kBCFmb8RGN+t0/
 qEMaPcEJCLa7aye06oFCTYs0EDOCjv0+USmf4mLRbEy3l/G43uw9VBX7O3EN1K5k6czhN
 b5Rnxt+4TH0xuIJNO3aunhOt5drMHvKsXBSVffzeqgumKFA7m8MvnkCUq7br0f3P0Q20N
 OItm8koyQxl+hPXEOaDaQblUVN+9E4/5MT5bIvohXhMVrjUH2Yr6KuONPGIfTEkMP2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793610085;
 h=Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=Q6NG5Q3EKrG+OXNwPQt1zo+B4dnZtz0m2HraeHJMJRg=;
 b=ArShwk1Qu624Kvlw6Lb3xlFt+Igvoklq1x6SZ1uEj49VcDA3toKKO2u8PNYgfxBGmlgb
 MjwwmIddYy2CSPhYagPbTWlkYKM9RIkJg5Tm2WewkbZvK3ULR76w7+aRfWc4hDBqdaY3t
 VVcmX5uPGFD2jKL5GnTPUGq1fhsQL0YTRqXPgJjq7ZqIU6YWLo4+fsXVWR+ItDVco+O1L
 pAygB7+PyXRTOjXvcZlRnPcHfFTs3ixt2NdRQBY4PhkK/jvQbMJXS/2uskYBwSID/2ZRI
 IHHNJcqyFIuSMAxXJbVsPRDcRtCD5xKoMM/UAV09haYkVdIMu0rSeBlOeN1fMawMqRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B235680F47
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:01:23 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Nov
 2026 17:01:21 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Nov 2026 17:01:21 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 2 Nov 2026 17:01:21 +0800
Subject: [PATCH] clk: ast2700: bind the generic syscon to the SCU node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261102-clk_syscon-v1-1-197c255ccb95@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAGBR6GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3eSc7PjiyuLk/DxdyyTjZEMzkyQzc8NkJaCGgqLUtMwKsGHRsbW
 1AHtRAHFcAAAA
X-Change-ID: 20261102-clk_syscon-9b3c164b671c
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.u-boot-project.org>, Ryan Chen <ryan_chen@aspeedtech.com>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Lukasz Majewski <lukma@nabladev.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793610081; l=2173;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=kEst36ulcGNo8BuQTHX2hdHReU/m7Czdvj0Ml4x0nws=;
 b=XSholZjtScLTKKeg/jYTiRPLesSQA4Ox8rspWHc/XTZNr4o65bs30onBj7e0aGp2V5jyAkPNq
 Db+nTktlxXWAQ8drQPHw4bZQr8J4LLRtyrSS51/iHBQhNRFRE47diXC
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Mon, 02 Nov 2026 13:10:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The clock driver binds to the SCU node, which is also a "syscon",
"simple-mfd" node, so the generic syscon driver never binds to it.
The SCU then has no syscon device and its child nodes, for example the
pin controllers, are never bound: every pinctrl-0 is silently ignored.

Bind the generic syscon driver to the SCU node from the clock driver
and select SYSCON for the AST2700.

Fixes: 0758fddb3729 ("clk: ast2700: add clock driver support")
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Tested on the AST2700 EVB: the pin controllers and their MDIO/RGMII
states are bound and applied.
---
 arch/arm/mach-aspeed/Kconfig     |  1 +
 drivers/clk/aspeed/clk_ast2700.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index f4b038ebd9e..0413d817259 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -39,6 +39,7 @@ config ASPEED_AST2600
 config ASPEED_AST2700
 	bool "Support Aspeed AST2700 SoC"
 	select ARM64
+	select SYSCON
 	select SYS_ARCH_TIMER
 	help
 	  Support for the Aspeed AST2700, an arm64 (Cortex-A35) Baseboard
diff --git a/drivers/clk/aspeed/clk_ast2700.c b/drivers/clk/aspeed/clk_ast2700.c
index ca76abef48f..78ea30b0bd7 100644
--- a/drivers/clk/aspeed/clk_ast2700.c
+++ b/drivers/clk/aspeed/clk_ast2700.c
@@ -918,6 +918,18 @@ static int ast2700_clk_bind(struct udevice *dev)
 			debug("Warning: failed to bind reset controller: ret = %d\n", ret);
 	}
 
+	/* Bind the generic syscon driver to the same ofnode so that the
+	 * SCU child nodes, such as the pinctrl and its pin configuration
+	 * states, are bound before any consumer device probes and selects
+	 * its default pinctrl state.
+	 */
+	if (CONFIG_IS_ENABLED(SYSCON)) {
+		ret = device_bind_driver_to_node(dev, "syscon", "syscon",
+						 dev_ofnode(dev), NULL);
+		if (ret)
+			debug("Warning: failed to bind syscon: ret = %d\n", ret);
+	}
+
 	return 0;
 }
 

---
base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
change-id: 20261102-clk_syscon-9b3c164b671c

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

