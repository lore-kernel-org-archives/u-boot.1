Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D162BC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 08:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477D4806FE;
	Thu, 16 Jan 2025 09:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="H9btcOpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF1980713; Thu, 16 Jan 2025 09:19:07 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 658A98033D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 09:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3111215904=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G7ousG032376;
 Thu, 16 Jan 2025 09:18:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 S3go9EjNv14sgE44bj2lpQM0b0e2qSokFbbEIm9jAPc=; b=H9btcOpyGYcgNXL2
 8aal9ixxcuZZdNhACZIoZwnOmQNxFnxf7VgzYqphOjwLyMrtzcE4T8eF2M2wV43o
 XwxycvWp3/VQ88NDMtdj+80eLj4dIxMllx1L1nrGLUPLmKWqdOxZGuT8rP+OeO8c
 mytSMLrlZQ48UvGwohREwkOrnD1rOd2sIVg5VSCoRdRfaG34hUkAIfJspFz7weHu
 kCP7fG36fyXLdlFT0fttiZ2Qcix6wUQBMZBg/Xt4g7wqOixWCu52at95lfeviGbO
 idtDEv7qwJYYoe694XLIWz4hnIHcm4EIVLLWpL+c8sfl5bJAjZjS21V8+gq8vLGD
 q4PX6Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 446m8s9u1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 09:18:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A799F40045;
 Thu, 16 Jan 2025 09:18:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C6C328C111;
 Thu, 16 Jan 2025 09:17:42 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 16 Jan
 2025 09:17:42 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/9] ARM: dts: sti: Add fixed clock for ehci and ohci nodes
 in stih410-b2260.dtsi
Date: Thu, 16 Jan 2025 09:17:30 +0100
Message-ID: <20250116081738.2511223-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116081738.2511223-1-patrice.chotard@foss.st.com>
References: <20250116081738.2511223-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_03,2025-01-16_01,2024-11-22_01
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

On STi platforms, all clocks are enabled by BOOTROM, so CONFIG_CLK is
not set as no clock driver for STI exists.

As ehci-generic and ohci-generic drivers are used on platforms where
CONFIG_CLK is set, clk_get_bulk() returns-ENOSYS in case of
stih410-b2260.
To avoid this error, add fixed clocks for ehci and ohci nodes for
stih410-b2260 to fix the following errors:

Bus usb@9a03c00: ohci_generic usb@9a03c00: Failed to get clocks (ret=-19)
Port not available.
Bus usb@9a03e00: ehci_generic usb@9a03e00: Failed to get clocks (ret=-19)
Port not available.
Bus usb@9a83c00: ohci_generic usb@9a83c00: Failed to get clocks (ret=-19)
Port not available.
Bus usb@9a83e00: ehci_generic usb@9a83e00: Failed to get clocks (ret=-19)
Port not available.
scanning bus dwc3@9900000 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marex@denx.de>
---

(no changes since v1)

 arch/arm/dts/stih410-b2260-u-boot.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/stih410-b2260-u-boot.dtsi b/arch/arm/dts/stih410-b2260-u-boot.dtsi
index 3b080ac7a1b..e9d7ec92281 100644
--- a/arch/arm/dts/stih410-b2260-u-boot.dtsi
+++ b/arch/arm/dts/stih410-b2260-u-boot.dtsi
@@ -14,20 +14,30 @@
 			};
 		};
 
+		clk_usb: clk-usb {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+		};
+
 		ohci0: usb@9a03c00 {
 			compatible = "generic-ohci";
+			clocks = <&clk_usb>;
 		};
 
 		ehci0: usb@9a03e00 {
 			compatible = "generic-ehci";
+			clocks = <&clk_usb>;
 		};
 
 		ohci1: usb@9a83c00 {
 			compatible = "generic-ohci";
+			clocks = <&clk_usb>;
 		};
 
 		ehci1: usb@9a83e00 {
 			compatible = "generic-ehci";
+			clocks = <&clk_usb>;
 		};
 	};
 };
-- 
2.25.1

