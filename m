Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D60CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD1D8881A5;
	Tue,  9 Apr 2024 17:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7yBUvVfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19688881BC; Tue,  9 Apr 2024 17:03:58 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5663881B0
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=482956ac1a=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 439BUQa2009700; Tue, 9 Apr 2024 17:03:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=2Q4S/FPaf5o3pa+RhITBTRKxHE2I4+RxDQSBEjt9N98=; b=7y
 BUvVfHhgUm33c+pUw5ig2dfazxnUqZKZimje7vclkEE7TOhFpe23mnIFTW0hDOh+
 gxoXFuGUX3j0+losqzl9MsSQtVOsT2OAqRMxA5cLjcqOwUPhB4ZTpQa+ommbAnoX
 n8X+7FNMi4S08Csrxk7Wjl8BIn2oLv8mJWVIvR5PjRO3+bXMYiunK7Ijs76g066g
 1a2jNgKO3RhJqTISf6DDXoGOdbovM4Ie5+AG7w4fn5Hji3waJt1zlJnN/G6+FRfw
 kbKeo7vLZsAmcZgwgxSHBXsKC/z+lFxnlvyA6hab/uV0sWw32GRuLudJHNrv0nM7
 98NFEQqJ9P3zc9acDx8Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xaw9cuqwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:03:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9DA7040044;
 Tue,  9 Apr 2024 17:03:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0CD5D2207B1;
 Tue,  9 Apr 2024 17:03:27 +0200 (CEST)
Received: from localhost (10.48.86.98) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Apr
 2024 17:03:26 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 08/25] ARM: dts: stm32: Don't probe led-red/led-blue at
 boot for stm32mp135f-dk-u-boot
Date: Tue, 9 Apr 2024 17:01:58 +0200
Message-ID: <20240409150215.2497778-9-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.98]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
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

led-red and button dedicated to fastboot share the same gpio GPIOA13.
led-blue and button dedicated to stm32prog share the same gpio GPIOA14.
Led driver is probed early so the corresponding gpio is taken and
configured in output which forbid fastboot and stm32prog button usage.

To avoid this, remove the "default-state" property from led-red and
led-blue led's node.

This will avoid to trigger the led driver probe() to configure the led
default state during startup.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/dts/stm32mp135f-dk-u-boot.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
index e64ded13462..8f42735609a 100644
--- a/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
@@ -30,10 +30,13 @@
 	};
 
 	leds {
+		led-blue {
+			/delete-property/default-state;
+		};
+
 		led-red {
 			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
-			default-state = "off";
 		};
 	};
 };
-- 
2.25.1

