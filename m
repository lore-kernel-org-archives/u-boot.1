Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6B0CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 22:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B621C8382E;
	Sat, 18 Oct 2025 00:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BdtH32yD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="drFsoVUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 975A88383F; Sat, 18 Oct 2025 00:05:00 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5FE83804
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 00:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cpJlY3LX1z9tVV;
 Sat, 18 Oct 2025 00:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760738697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tjI5HbLEP9dYoZtADU3cTyEvLJMNsiA0bPq4PvAvCQ0=;
 b=BdtH32yDKXsYM/L0rGwfWuuSUcyj71PoXrjIjXL7/VeauF3clFOo7HJRnzsg4YEQ1AzA2V
 kyAi8rgIrFnnTMXKYUWYzt5jAgV9WwdVifHudFZMFNijJeDpouEAnR3OjMpWQft2Zbtwzc
 gNJbT3hlFjPa16u9A/GDhQgs9ZYCgAkeVvB0eecJ0pTd+Gm2GKT09Hkz8JOKUKWqLU5B7Y
 7sxY/3f27f/iDmUZ/2ZNE7LQTrMumKVJq8iKcFdeIJ18rVnn02SqViXHRab3XMOTrr3B10
 BRUWWHlC07GRT9b9LHKTWWLcdGg6FYUHzbU0JKkpx4SSy2D96EXTPpXdDmINZA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760738695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tjI5HbLEP9dYoZtADU3cTyEvLJMNsiA0bPq4PvAvCQ0=;
 b=drFsoVUE2ZhlT4XUAarCHw8+2Mtp+8LD1BHrllZn2yuzoF0Ky52zOg/SsjHtzkRekB9dbz
 zCxfnIJapM7g08A3iJAi4te/eV9PElgzoafjIrl0vVfpET0SQYI+/FmhWwF+KeszupGT9W
 qH4vOm391mqFj595RuvViyXT6jew+vEEUrJXSEHDiwM2fmNZ2tagiMWDYCEj1KKp1NwWzi
 azu99Vr1mSDJOf8hn2Y9c8csSSJB49Sbh7Xj6T/+S7jqQKMA5+ME/LWMglc1qjKIxc1UKS
 MPUmV6kIPm4IbnDAOnoTsENFtVkRvWsXXU77pFhgjRuMZxW5qfLews4s0k/xtQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: renesas: Disable R8A779G0 V4H White Hawk RPC SPI DT
 node again
Date: Sat, 18 Oct 2025 00:04:07 +0200
Message-ID: <20251017220440.137788-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d7f83abcca83f6687ad
X-MBO-RS-META: u9uk3dkdtd3dyeoagj8b81rifpd57zjc
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

Commit 3faeb78378ea ("ARM: dts: renesas: Minimize R8A779G0 V4H RPC SPI DT node")
incorrectly re-enabled the RPC SPI DT node, which was disabled in commit
13bdb6a26910 ("ARM: dts: renesas: Disable RPC driver on R8A779G0 V4H White Hawk board")
Reinstate the disablement.

Fixes: 3faeb78378ea ("ARM: dts: renesas: Minimize R8A779G0 V4H RPC SPI DT node")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
index 85e32208b29..8e4307ff87d 100644
--- a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
@@ -23,6 +23,8 @@
 
 &rpc {
 	bootph-all;
+	status = "disabled";
+
 	flash@0 {
 		bootph-all;
 		spi-tx-bus-width = <1>;
-- 
2.51.0

