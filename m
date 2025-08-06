Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2ABC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D74183A71;
	Wed,  6 Aug 2025 16:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JsFjeBuP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yXQImoZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF76183A79; Wed,  6 Aug 2025 16:47:51 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD11383A36
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxtSM1zHsz9sqF;
 Wed,  6 Aug 2025 16:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754491667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xrxcCyzrMottNlkmkADJ9WrojOJQkW0ST6N8F2rtXFs=;
 b=JsFjeBuPrpLGSyI3mwmadEVS9yidabqkbtPzWiLQQ20g2WV/a/W7zTl8bWMm9C+xoaNt0J
 kHucbVhSfcEgwtXXU8YXQ0ZSh/DumPmXxXcDfiLIAVOW4ylVsBe+TDZqWcULb01+mDJTRC
 w+2O2eUcXAeDOM/khhLSrZGI1TvehX6A5WMNvZ2RWh9rq8vlae9w0TuM8zsuDRyvFursCF
 KfkLwmsssYD3JcgSZrHPhrULNPdw4XN7/RsjvEhSwYvlK3gnR0dJZ3uw+3ENPHUzI3TqNe
 ZjTLfggqETvHzw01PML7r5vxwXRVvPrbyM7dJlfZPcEKWefwDIjE3+ZYhnZPXw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754491665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xrxcCyzrMottNlkmkADJ9WrojOJQkW0ST6N8F2rtXFs=;
 b=yXQImoZLR6oahXXjicr8OraSBQZIBjmYdr65m+MffbCnANyUwmDvVMI//hK1Lmv6Y7M3Lq
 wEcYsLcpsrHzEglA8HL0bw+tLXcBYY20WBo153S/PFaxdiTukfWN3gpX0cKOkG+Iw4En8c
 NFPtD91gNVDqt5uD2i89JTkCu6fpiZJ9wy/b7UnQfejymDBlwVnHLhsxD/QEssHr1ifwzp
 VZ5ra0QhJfU0P81rd3fiX1eKj+gG5da1N+guBM+vTbxIZlM4I7F4SyMZkamKga0Tbmrc9w
 PjzLVl4L3cDkdQjcwPp88HIXVEV6bJwbzvArwGRkfJerzvwXdMU2Ljl8rHDoLg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] arm64: dts: renesas: r8a779g3: Describe generic SPI
 NOR support on Retronix R-Car V4H Sparrow Hawk board
Date: Wed,  6 Aug 2025 16:47:13 +0200
Message-ID: <20250806144727.7006-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9ee125cdffe1d17d319
X-MBO-RS-META: f8j4wnnaexo1ejosxhtbai43na3bdt9f
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

Retronix R-Car V4H Sparrow Hawk EVTA1 is populated with Spansion S25FS512S,
EVTB1 is populated with Winbond W77Q51NW. Describe the SPI NOR using generic
"jedec,spi-nor" compatible, because both flashes can be auto-detected based
on their built-in IDs.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Update commit message, s@spi-flash@jedec,spi-nor@
---
 dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
index 6955eafd8d6..58a146466e5 100644
--- a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
+++ b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
@@ -729,7 +729,11 @@
 	status = "okay";
 
 	flash@0 {
-		compatible = "spansion,s25fs512s", "jedec,spi-nor";
+		/*
+		 * EVTA1 is populated with Spansion S25fS512S
+		 * EVTB1 is populated with Winbond W77Q51NW
+		 */
+		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <40000000>;
 		spi-rx-bus-width = <4>;
-- 
2.47.2

