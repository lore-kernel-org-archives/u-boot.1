Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7811ECCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 09:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ACE382E34;
	Thu, 23 Oct 2025 11:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="jRuoltXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62E8835FD; Thu, 23 Oct 2025 11:47:34 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7277983303
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 11:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4csh5w1FY5zDHY;
 Thu, 23 Oct 2025 11:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1761212852;
 bh=CzQ6XOHlDaG0BNKqHRCpzT/mUNvQqEdeUeO0nYtGYiw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jRuoltXZhcasTsjD+1kA02mCw/Vudc3Ut9xX+Op76LIkSqn+GtzShvoCoNYjOZMLC
 JFvApD+IrUfASWPFZQ+3PtpyihMn4wbamd2DhKC/oc2vA31TSknVZo+cL2cEj5dHjR
 7H+kAYUGgN6N3wLBOWJBoNcD8zpiPJk9hPJYD58g=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4csh5v579RzFPZ; Thu, 23 Oct 2025 11:47:31 +0200 (CEST)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/6] arm: dts: k3-am642-evm: Remove duplicate node
Date: Thu, 23 Oct 2025 11:46:19 +0200
Message-ID: <20251023094631.16742-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023094631.16742-1-dev@pschenker.ch>
References: <20251023094631.16742-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Philippe Schenker <philippe.schenker@impulsing.ch>

The device tree contained a duplicate DT node 'main_mmc1_pins_default',
which was already defined a few lines below. This patch removes the
redundant entry.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
---

 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index 705b3baa81cf..6469f43fca81 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -19,10 +19,6 @@
 	dr_mode="peripheral";
 };
 
-&main_mmc1_pins_default {
-	bootph-all;
-};
-
 &sdhci0 {
 	bootph-all;
 };
-- 
2.51.1

