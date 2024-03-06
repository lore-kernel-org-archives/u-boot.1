Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C491BC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 12:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4238B87F73;
	Wed,  6 Mar 2024 13:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tGubV0YZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E75587FC2; Wed,  6 Mar 2024 07:38:06 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E6E87D14
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4266c2DV007308
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:38:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709707082;
 bh=yhTVY4YH4wvW3wWek2OIEEnIbsfQrvThgyqszwq6VJY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tGubV0YZgXnhpJf6jauU376CFKIT9MzxstkxjlA/6yB8U3VjMrkNZnWI65yuu1GVG
 w7UA2UD2JuGXo9UL7vkUQyAFtuF9kUJF+lcNLMrboqll0KQY7pPBSSRsXXq78U9tsB
 SlBzRM9kT1jOxcHnvq0m9EG/UiyULeAYJ0AjfvS0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4266c2wh008560
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:38:02 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 00:38:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 00:38:02 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.68.244])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4266bsdn012351;
 Wed, 6 Mar 2024 00:38:00 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <vaishnav.a@ti.com>, <a-nandan@ti.com>, Aniket Limaye
 <a-limaye@ti.com>
Subject: [PATCH 3/4] arm: dts: k3-j7200-r5-common: fix the mcu_timer0 clock
 frequency
Date: Wed, 6 Mar 2024 12:07:48 +0530
Message-ID: <20240306063749.1411176-4-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306063749.1411176-1-a-limaye@ti.com>
References: <20240306063749.1411176-1-a-limaye@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 06 Mar 2024 13:09:02 +0100
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

Correcting the clock-frequency property of the mcu_timer0 node

Fixes: df73e791ce09 ("arm: dts: j7200: dts sync with Linux 6.6-rc1")
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index 195637a836..c4ca09b1e0 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -52,7 +52,7 @@
 };
 
 &mcu_timer0 {
-	clock-frequency = <25000000>;
+	clock-frequency = <250000000>;
 	bootph-pre-ram;
 };
 
-- 
2.34.1

