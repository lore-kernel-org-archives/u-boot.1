Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE1CCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 07:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7888B83E63;
	Tue, 11 Nov 2025 08:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="bQ/0i6Q8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474CB83B4A; Tue, 11 Nov 2025 08:18:40 +0100 (CET)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A9383B1E
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 08:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d5HvL0prGzxKS;
 Tue, 11 Nov 2025 08:18:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762845517;
 bh=nqy2KvA9wLyMwguHgHvlsgnUefK0jqxrXFYf2E9ZQLc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bQ/0i6Q80Y4ukRAl5G2hPRl/TzLu0G2V0DmwC8yHjGluHzQxpQW4IABspXTMp7FL1
 +SizuF4cEXXeJlvRwwKjCoFBMFIXKz6Dpt9BiLjngxIKOn+aGhQqkimhj29ye17IU5
 MVvWEiGJJ/zLguE+BnGMT3Jkma00x7R2szyvXr3E=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d5HvK4VQHzxTZ; Tue, 11 Nov 2025 08:18:37 +0100 (CET)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Anshul Dalal <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/6] arm: dts: k3-am642-evm: Remove duplicate node
Date: Tue, 11 Nov 2025 08:16:25 +0100
Message-ID: <20251111071756.1257488-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111071756.1257488-1-dev@pschenker.ch>
References: <20251111071756.1257488-1-dev@pschenker.ch>
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
Reviewed-by: Anshul Dalal <anshuld@ti.com>

---

Changes in v3:
- Add Anshul's Reviewed-by, thanks!

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

