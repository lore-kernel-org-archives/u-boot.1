Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A582C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DBDE88116;
	Tue,  9 Apr 2024 17:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="N/l5HTR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329DE881CD; Tue,  9 Apr 2024 17:04:50 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6890287E86
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=482956ac1a=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 439BXJJk004570; Tue, 9 Apr 2024 17:04:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=Bhgs6uPbIuSQndb94PoXoCxZxHPW2dfR8mkuLh4tpAU=; b=N/
 l5HTR128y2E3hMhNdTiUU2gVLq8Kn0tsqffnubbeBmKPpe7sSmnjMKyq7DMfMRTN
 UDjWRKTcM1jR7pV5udrxvxAaZbFniu662PuLxiQKuc9A3O+0/XDz1IYqDS7IT+w6
 47yS4pFIoGgkk6XNDbRcXDbgKfY8k3A9NR68xW7/cEjW2FKtpelyTPP3LGKwNuR4
 OuAwOmyOGRH7nT2C226BR4SrifbCCwM9CUmIb2ZeYe9ybO6hNrY9aWrl9QxlhT9U
 fnZT1R9NkU5BdV63fUh6Q2cELDROOE/5ruoB1gbX7sDeXi5GiE0w4/e1gjfXYF/e
 76A98iZVx7AeLQJrcSQg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xautfv640-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:04:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1CFC840045;
 Tue,  9 Apr 2024 17:04:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E0872207C2;
 Tue,  9 Apr 2024 17:04:31 +0200 (CEST)
Received: from localhost (10.48.86.98) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Apr
 2024 17:04:31 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 13/25] ARM: dts: stm32: Add led-blue for
 stm32mp157a-dk1-scmi-u-boot
Date: Tue, 9 Apr 2024 17:02:03 +0200
Message-ID: <20240409150215.2497778-14-patrice.chotard@foss.st.com>
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

As indicated in kernel led dt-bindings, label is a deprecated
property, so remove it and use blue led node's name instead
for u-boot,boot-led property.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
index e61814fd66e..a5158fec7ef 100644
--- a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
@@ -13,7 +13,7 @@
 	};
 
 	config {
-		u-boot,boot-led = "heartbeat";
+		u-boot,boot-led = "led-blue";
 		u-boot,error-led = "led-red";
 		u-boot,mmc-env-partition = "u-boot-env";
 		st,adc_usb_pd = <&adc1 18>, <&adc1 19>;
@@ -36,6 +36,10 @@
 	};
 
 	led {
+		led-blue {
+			/delete-property/label;
+		};
+
 		led-red {
 			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
 		};
-- 
2.25.1

