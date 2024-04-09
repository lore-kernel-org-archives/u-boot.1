Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42CCC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DB2881CE;
	Tue,  9 Apr 2024 17:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="LObKfUla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88635881BF; Tue,  9 Apr 2024 17:04:11 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F548819F
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=482956ac1a=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 439EGxCr009424; Tue, 9 Apr 2024 17:04:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=Y65q18DHPHB0syRm2W3oyDGv0A5oW0YHK2QIctTkeN8=; b=LO
 bKfUlaeQxzW+Fc0SBaEgqDppXXSU2oLUQk248GZq3Dt0kkSFUg6U+xOoojUrOqEF
 4AF0ewzsY8iaKvFwlKdKBHLJ1dTCuO+5RJhs+QG7FAYH5qdr+nu2jPhKOh3l1jJ9
 7IE+c2lqMn7DesDxG+Gy3eofn5y1r0ae0AWB3/JJ5+NS+nkgmRYBXLbeV6/K+iW5
 BxQYKf+EASwHr+Zqj/tuheCJhnesSNU/yn5BXN63EefE3GRLY3v5XH9ofVakb34U
 lSyvGWzjHzuiqZ96fanVmNk3EUw/1eE5a3j1s9k3F9dol+Oodqfn1dFYieOf0LVP
 1bwdkCPqkt/x+iCTDh0A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xawqxutur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:04:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7EB4340045;
 Tue,  9 Apr 2024 17:03:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E29CF2207BC;
 Tue,  9 Apr 2024 17:03:27 +0200 (CEST)
Received: from localhost (10.48.86.98) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Apr
 2024 17:03:27 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 09/25] ARM: dts: stm32: Clean led-red node for
 stm32mp135f-dk-u-boot
Date: Tue, 9 Apr 2024 17:01:59 +0200
Message-ID: <20240409150215.2497778-10-patrice.chotard@foss.st.com>
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

Remove "color" property from led-red node which is not supported
by U-Boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/dts/stm32mp135f-dk-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
index 8f42735609a..f004e9840a2 100644
--- a/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp135f-dk-u-boot.dtsi
@@ -35,7 +35,6 @@
 		};
 
 		led-red {
-			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
 		};
 	};
-- 
2.25.1

