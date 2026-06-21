Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF9ACDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 02:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D0884844;
	Sun, 21 Jun 2026 04:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xd6nF+HV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eKY/UDBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF2484873; Sun, 21 Jun 2026 04:38:53 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F11D83FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 04:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gjbB26tcvz9swL;
 Sun, 21 Jun 2026 04:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ENLxKm7wpLbxy1KWcVZzfMaS1rnthlq1LEe4DtwHBB8=;
 b=xd6nF+HVIIXgCFmz1Ux9/6VqFogZWPHDQnK+USW+XO11X7GAgX+yeErtVwxSINdn9h1Vmw
 Sd4ZODS2ubbL3BTs7IgG9bT8AA0l1wArcfr5BQlPmKvbrX9SaEibC21JTKWENpiazsGNZ1
 /ef37YPcD++X2eLN8CrRdh0Fg2ooeV57AAb+I7hfKIbNJONlZjI4+6YBLTN6BKUYk4AZcE
 r0KELbNiUtW/MROmF4ZBJzVOx0sysM6Y1cjpoEWeFsMKygXXOFOauJWscvIo4i0LV/BY5T
 EwKO9ALVsUcrNR/UPzA7oQ5Jgdf6BrE+nwONVUcpmWqwHNcn8wVLHCnR8r7tNQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="eKY/UDBD";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ENLxKm7wpLbxy1KWcVZzfMaS1rnthlq1LEe4DtwHBB8=;
 b=eKY/UDBDsGrI2gh7BzoEhrddNfA3nnUa0yXzYF0Q4d7KH0t/5CBf5DqhcANddQm1wfv+9p
 oJSqbUrwMCNbAFRWAy7i/FxvwHY2Grtlu3uip74vvkyFui7h/d7O/sCvShOHD083BSwij0
 cbYmOVcqtiOnq83n5tEo6vQWFVbPOnsigKGjga97J88z5U0wKDtR86+HOGY38AKgcbocWg
 N6dh9xLZKC9kfj4O72z/mqHwLcLYxM/qr5qoYUVlEvfnfDZ6I8NDyB3rLHh+6pVv4lNlwK
 8+M2rGWUKO5PQUa0sF+JwAFd6NE73lbxYN4D7bFr88E/w0pD9faR9Y6J4Y+oFw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: dts: renesas: Remove unused OPP nodes from R-Car
 H3/M3-W/M3-W+/M3-N
Date: Sun, 21 Jun 2026 04:38:22 +0200
Message-ID: <20260621023845.404276-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 84d3gj87p5as5y8x114bxmdkfeoy8zkp
X-MBO-RS-ID: 6d714a09789a966a4f9
X-Rspamd-Queue-Id: 4gjbB26tcvz9swL
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

Remove OPP DT nodes from R-Car H3, M3-W, M3-W+ and M3-N DTs,
those nodes are not used by U-Boot and only increase the control
DT size and complexity. This saves about 1 kiB on the resulting
U-Boot binary without any impact on functionality.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a77951-u-boot.dtsi | 34 +++++++++++++++++++++++++++++++
 arch/arm/dts/r8a77960-u-boot.dtsi | 26 +++++++++++++++++++++++
 arch/arm/dts/r8a77965-u-boot.dtsi |  9 ++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/arm/dts/r8a77951-u-boot.dtsi b/arch/arm/dts/r8a77951-u-boot.dtsi
index e8a7fa27a76..0c00cc8bef9 100644
--- a/arch/arm/dts/r8a77951-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-u-boot.dtsi
@@ -11,6 +11,8 @@
 /delete-node/ &can0;
 /delete-node/ &can1;
 /delete-node/ &canfd;
+/delete-node/ &cluster0_opp;
+/delete-node/ &cluster1_opp;
 /delete-node/ &csi20;
 /delete-node/ &csi40;
 /delete-node/ &csi41;
@@ -62,6 +64,38 @@
 	/delete-node/ vga;
 };
 
+&a53_0 {
+	/delete-property/ operating-points-v2;
+};
+
+&a53_1 {
+	/delete-property/ operating-points-v2;
+};
+
+&a53_2 {
+	/delete-property/ operating-points-v2;
+};
+
+&a53_3 {
+	/delete-property/ operating-points-v2;
+};
+
+&a57_0 {
+	/delete-property/ operating-points-v2;
+};
+
+&a57_1 {
+	/delete-property/ operating-points-v2;
+};
+
+&a57_2 {
+	/delete-property/ operating-points-v2;
+};
+
+&a57_3 {
+	/delete-property/ operating-points-v2;
+};
+
 &i2c4 {
 	/delete-node/ video-receiver@70;
 };
diff --git a/arch/arm/dts/r8a77960-u-boot.dtsi b/arch/arm/dts/r8a77960-u-boot.dtsi
index b437792a172..2a8c5a96390 100644
--- a/arch/arm/dts/r8a77960-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-u-boot.dtsi
@@ -11,6 +11,8 @@
 /delete-node/ &can0;
 /delete-node/ &can1;
 /delete-node/ &canfd;
+/delete-node/ &cluster0_opp;
+/delete-node/ &cluster1_opp;
 /delete-node/ &csi20;
 /delete-node/ &csi40;
 /delete-node/ &drif00;
@@ -70,3 +72,27 @@
 		/delete-node/ imr-lx4@fe890000;
 	};
 };
+
+&a53_0 {
+	/delete-property/ operating-points-v2;
+};
+
+&a53_1 {
+	/delete-property/ operating-points-v2;
+};
+
+&a53_2 {
+	/delete-property/ operating-points-v2;
+};
+
+&a53_3 {
+	/delete-property/ operating-points-v2;
+};
+
+&a57_0 {
+	/delete-property/ operating-points-v2;
+};
+
+&a57_1 {
+	/delete-property/ operating-points-v2;
+};
diff --git a/arch/arm/dts/r8a77965-u-boot.dtsi b/arch/arm/dts/r8a77965-u-boot.dtsi
index 57382e34912..6eb7bbeed26 100644
--- a/arch/arm/dts/r8a77965-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-u-boot.dtsi
@@ -11,6 +11,7 @@
 /delete-node/ &can0;
 /delete-node/ &can1;
 /delete-node/ &canfd;
+/delete-node/ &cluster0_opp;
 /delete-node/ &csi20;
 /delete-node/ &csi40;
 /delete-node/ &du;
@@ -60,3 +61,11 @@
 		/delete-node/ imr-lx4@fe890000;
 	};
 };
+
+&a57_0 {
+	/delete-property/ operating-points-v2;
+};
+
+&a57_1 {
+	/delete-property/ operating-points-v2;
+};
-- 
2.53.0

