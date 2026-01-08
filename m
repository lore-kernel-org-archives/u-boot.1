Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08151D1D486
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4409083B49;
	Thu,  8 Jan 2026 20:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bxFJ2MDl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AKmo9His";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1718415E; Thu,  8 Jan 2026 20:09:38 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9EF0838A5
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dnDww3LnJz9srM;
 Thu,  8 Jan 2026 20:09:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767899376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3/3n+wu1bOSSdpy+E24JJ7ADRMxP/jO9WBoLDy6UIY4=;
 b=bxFJ2MDlJkVtfTo0zjDArzLL+6PR+N/r/NSJBCuaeSwc0WKBA8s1P4aApbWcbBHTuEOyJh
 TNj2rr0DP/GJswahqLtOlk3DbGbGK/IoZdMSgHxPsxDCuaFnOU+4qBsRagiwSzYw0Da+gF
 3XVlFvuGvjPnaSF9EqUXvr3Y9X1/fLwx/LcLGwghbHKRXRSSGHbuRt3tFWN07nOs4tG6FB
 e65JgxCMG4TVzQe6Tr3VqhtdHrj3WFQyUmKT/lC6B8SEyKlRo6FMMoG+yUPd8z7PcpOcUi
 BOpXMaP5lzIFckzzsCW0lyuydzuFsLzJ73NdtKtGbU1y32ltBB02HzH5pQkjxA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=AKmo9His;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767899374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3/3n+wu1bOSSdpy+E24JJ7ADRMxP/jO9WBoLDy6UIY4=;
 b=AKmo9HismghRRcfphOhBS7wcuqBlayhqDk/jrL5hibgjIIj4ZYxDQwAd1Cy0GY66F5XHvI
 HLzkHfVYixj28zeVs9/oeYvRqNdZMAlThvRJQzYnH5bceKN9jUs1hdjvTYVMplq6LVYk68
 +FtV1kvN2+0Kiqi2bxO/ryHMFnatWmFlDzTU9C9V6gzZs93wPA7IF05BdTW9IZF7/ygT57
 f9C24xryKUiclQ2ETcv7DFIto3NpCLEkIz7x5e5+Yd2ipODCIEF0IwNUZhvz9rCCstiEz7
 5L/Lw/OrV/eJA66edAkDMfRrUGi6onuTjlrfCnktouM4KovtkT0QOMSQ2C3xWQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: r8a779g3: Reinstate basic PCIe clock
 description for Sparrow Hawk
Date: Thu,  8 Jan 2026 20:09:21 +0100
Message-ID: <20260108190932.36964-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ehp8mmkbwu9o5sjr91x59w4s5zwefpst
X-MBO-RS-ID: 9d197149bd0646f44ff
X-Rspamd-Queue-Id: 4dnDww3LnJz9srM
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

The 9FGV0441 PCIe clock generator can operate in autonomous mode, which
is the default mode. U-Boot currently does not have a driver for this
PCIe clock generator, but Linux 6.17 DT does describe the clock generator
in Sparrow Hawk board DT and this DT is included in U-Boot since commit
eea470fd7f6a ("Subtree merge tag 'v6.17-dts' of dts repo [1] into dts/upstream").

Reinstate basic PCIe clock description which matches the behavior of
Linux DT before Linux 6.17.y release in in U-Boot DT extras to allow
PCIe to be used on Sparrow Hawk board in U-Boot until the 9FGV0441
driver gets implemented or ported from Linux.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
index dff0355150d..968cf6684c5 100644
--- a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
@@ -49,6 +49,24 @@
 	status = "okay";
 };
 
+&pcie0_clkref {
+	clock-frequency = <100000000>;
+	status = "okay";
+};
+
+&pciec0 {
+	clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
+};
+
+&pcie1_clkref {
+	clock-frequency = <100000000>;
+	status = "okay";
+};
+
+&pciec1 {
+	clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
+};
+
 &rpc {
 	flash@0 {
 		/*
-- 
2.51.0

