Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372E0CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 13:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3263E83D7A;
	Fri,  7 Nov 2025 14:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="lWqNTSjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D255E83D8A; Fri,  7 Nov 2025 14:03:07 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C41B83D0C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 14:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2zkZ1TDRzmFK;
 Fri,  7 Nov 2025 14:03:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762520582;
 bh=8/djiPHb/LNJf+9hdcipjtsGC+0ETAksC+0KzZczhTU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lWqNTSjQC5bKniOCmEtIs5x3ecLvR6EX+QUrggiBkLsbaBHXxCzjjtWMH+55up7Sr
 ZUzzj1IPb8cM2X5PoyZZLd22Umli41WKZ0ltV4SwVo2S0EHdhMr+3zC4fiBYQLmRc2
 FIxRcx22uOXfeQUAhBzFCNwGxRJQn7cS+MPh8ifs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2zkY4jpxzRg2; Fri,  7 Nov 2025 14:03:01 +0100 (CET)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/6] arm: dts: k3-am642-evm: Remove duplicate node
Date: Fri,  7 Nov 2025 14:01:00 +0100
Message-ID: <20251107130216.3084134-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107130216.3084134-1-dev@pschenker.ch>
References: <20251107130216.3084134-1-dev@pschenker.ch>
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

(no changes since v1)

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
2.51.2

