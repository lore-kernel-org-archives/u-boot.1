Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5961FC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6282E8654E;
	Thu, 24 Aug 2023 05:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EvW0daQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A6486435; Thu, 24 Aug 2023 05:11:27 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1695186567
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BAmu085395;
 Wed, 23 Aug 2023 22:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692846670;
 bh=3/rytJGBghKR7PJJc49jtdMWzvfKHA+veMZ7wSErFcU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EvW0daQ4L62t/vqlHU23HD+x++2R9SPBA+opMJq22qjRUS7VvtAcXu443/sSn3YDB
 xmuk9okfbgU0jSkeGeH/LaWtBb6ufsw/O7q9DNLcTSi1Em6LcTt6MsqMc6cRs+sB3+
 GtK6uaIZk6YtHVJT/oGwep/rL/tUSECy+jlk8EZ8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O3BAlK012262
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 22:11:10 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 22:11:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 22:11:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BAR5013365;
 Wed, 23 Aug 2023 22:11:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH V5 14/17] arm: dts: k3-am625-sk-binman: Add labels for
 unsigned binary
Date: Wed, 23 Aug 2023 22:10:58 -0500
Message-ID: <20230824031101.3460411-15-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230824031101.3460411-1-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add labels for unsigned binary to permit over-ride.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Cc: Simon Glass <sjg@chromium.org>
Changes since v4:
* Picked up Mattijs' Review

V4: https://lore.kernel.org/r/20230822184135.2328409-6-nm@ti.com
V3: https://lore.kernel.org/all/20230815164440.2713726-2-nm@ti.com/
V2: https://lore.kernel.org/u-boot/20230727234446.3651836-2-nm@ti.com/
V1: https://lore.kernel.org/all/20230725185253.2123433-3-nm@ti.com/
 arch/arm/dts/k3-am625-sk-binman.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index a35d6418c25f..41277bf4bfdb 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -389,7 +389,7 @@
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					blob {
+					spl_am625_sk_dtb_unsigned: blob {
 						filename = SPL_AM625_SK_DTB;
 					};
 				};
@@ -438,7 +438,7 @@
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					blob {
+					am625_sk_dtb_unsigned: blob {
 						filename = AM625_SK_DTB;
 					};
 					hash {
-- 
2.40.0

