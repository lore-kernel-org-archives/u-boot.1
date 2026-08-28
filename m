Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AC3C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E935B80FA6;
	Fri, 28 Aug 2026 13:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id in6Ig83FwvQN; Fri, 28 Aug 2026 13:58:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925538;
	bh=XRYwRzv5N1yrxAZ/OqcKaCMrg9LmGTCjDEXSvHGKsd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xnmjqbj+1QS7arXYM42cAGqGQmpw3VnveqWssCWu2Kt2fJ1eWjrhuIxeKu19Tah0x
	 8oXn6h8FYMfCDfvHSpxyjMYl6aeot8qr6Oh98RYfsTnLPrtoeXK6rfm5f+rnA/z0gf
	 ajp3DSE6RKBuvuoF4gEePGZxW7t8PUj5fLV1Mh+6B/fTm74C2559KzCK4DdwfqJ7AZ
	 rucL7AEmOuHu8egtWddCx0f6l2O84O6feKjlucx+Fn4XO7qjHdqYhJagWpwemlkexe
	 6TmG7WCnBOXXhX40JOnyzYHfrDekpP2WhO12Mb8zZcFktwJ0DAmgu43KeiKM4Aje/m
	 hXvFxOSd4csow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C824D80F8C;
	Fri, 28 Aug 2026 13:58:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 71680386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 629F640872
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PUbfEBtaBc41 for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=zWPhx5YF
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B92C74085F
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BD7804E41401;
 Fri, 28 Aug 2026 13:58:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 92BFF60537;
 Fri, 28 Aug 2026 13:58:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 923C111C7832B; 
 Fri, 28 Aug 2026 15:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925532; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=XRYwRzv5N1yrxAZ/OqcKaCMrg9LmGTCjDEXSvHGKsd4=;
 b=zWPhx5YFpVQfdHZm6seKtmxbj4CM7/YsP0LF3eEz/NA3ImMf2kkbVjm6I1dDvJkFapU+Lb
 q9TmccfIn6WhYYIS/itVl/M4iQWkckRwB4fJVlVOfGnlVVvjDuBRq++EcMh4QN/jdZcfEI
 D7kRxMRzxqc118+SFeUhUxtI38vAYdl41xxyfS4YX8tjjd3UQ93YuLVCXYOaim5vY8+Hjy
 quVSqtXv/s36KtfApbfklweVoK05wGHPMy9d9RnCmnWst8DI8vvtQk3mfjZ2KCb11089Xo
 Efxfua8IbSSvPKCYeOELp7Ps5CZkOThOhXhOMcTLEAaAtHiLZ1rLQldXrNxNDw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 20/21] arm: dts: k3-j7200: Remove background firewall on DDR
Date: Fri, 28 Aug 2026 15:57:29 +0200
Message-ID: <20260828135730.1565643-21-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Prasanth Babu Mantena <p-mantena@ti.com>

With updated TIFS version tag v11.02.06, the background firewall
for DDR firewalls are applied by the TIFS. This removes the
dependency of applying firewalls through binman.

Remove background firewall on the whole DDR, as this
background firewall is applied by the TIFS init for j7200
and j784s4. Modify for j7200 only, as there are no firewalls applied
for j784s4 from SPL.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/dts/k3-j7200-binman.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index b4e0ce8bfcf2..c2b86339d593 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -294,13 +294,6 @@
 							region = <2>;
 						};
 
-						firewall-4762-0 {
-							/* nb_slv2__mem0 Background Firewall - 0 */
-							insert-template = <&firewall_bg_3>;
-							id = <4762>;
-							region = <0>;
-						};
-
 						firewall-4762-1 {
 							/* nb_slv2__mem0 Foreground Firewall */
 							insert-template = <&firewall_armv8_optee_fg>;
@@ -308,13 +301,6 @@
 							region = <1>;
 						};
 
-						firewall-4763-0 {
-							/* nb_slv3__mem0 Background Firewall - 0 */
-							insert-template = <&firewall_bg_3>;
-							id = <4763>;
-							region = <0>;
-						};
-
 						firewall-4763-1 {
 							/* nb_slv3__mem0 Foreground Firewall */
 							insert-template = <&firewall_armv8_optee_fg>;
