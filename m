Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FEDCD6E6B
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 09:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC69884962;
	Wed,  3 Jun 2026 11:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oowDwIYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E8B84962; Wed,  3 Jun 2026 11:55:41 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B628984943
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 11:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 777CD1A37B7;
 Wed,  3 Jun 2026 09:55:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4B7105FFA8;
 Wed,  3 Jun 2026 09:55:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A526710888413; 
 Wed,  3 Jun 2026 11:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780480535; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=MlTnhzcho49rY5O/4Z5BigrqPbeLgzqtAueY0ICihlo=;
 b=oowDwIYj5NPjF9Gx+V6L2tL9HGTfNJ/kOlVXeKqEagUg7F4ZmCau01KBlALbW5AqAzspcE
 DTP5xZNQFSf+uUD6qCPEdthCzyAO9OeYFiNDCK8B7kTPYPvhQjEQrxGLFyAoptt4Q3xVUG
 3JQ2tMjXAKIa6VspcY97fl9nRfEOWrdaMboMURnGg5jEbUBVJNmaQhlAXf+o5VjPuwZMGE
 8aq3M+yrKNF+P6NlPuVkKz2aog4qENHawCjmOkaiYf16HFyamAyV/uhlhQj+9IfoJTLcX3
 5ZZQYz4vaXQ4HYbvLsxo62KGLnJ84T9OPm6uPLmeciRKjOMGmW0tYYMDk24YiQ==
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
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v2 15/16] arm: dts: k3-j7200: Remove background firewall on DDR
Date: Wed,  3 Jun 2026 11:54:48 +0200
Message-ID: <20260603095449.2089514-16-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603095449.2089514-1-richard.genoud@bootlin.com>
References: <20260603095449.2089514-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
-- 
2.47.3

