Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06882C46CCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A2F4878FA;
	Thu, 21 Dec 2023 18:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hAipZYl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AECD8878F7; Thu, 21 Dec 2023 18:44:23 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB48878C9
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiE75118519;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=u/pmGVDTOcM2QIWsjMHDlHcod3aWMlx8rNkaQ2Z89sg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hAipZYl2vGsA+ehJaobJJsLpuKrBZUuYlwh/gltTZwy2B6iDW1/HbqEsMdX8QoTOT
 GmQLPI9jzWnpBXQEoRr99twCIkW/7Ge3HjmG6s14Qs8cCLZqiTwVt19WZ6GJuMVK1N
 QhxYQRewIF4f6sQPpUtHNk0hMxGcbAfa2PvLUsD0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiEpv113461
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiECN069245;
 Thu, 21 Dec 2023 11:44:14 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 08/26] arm: dts: k3-am654: remove duplicate wkup_uart0
Date: Thu, 21 Dec 2023 11:43:54 -0600
Message-ID: <20231221174412.210807-9-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=bb@ti.com;
 h=from:subject; bh=9wOorRMH/9W63Owamlb6YnMwc/uoTfrw7hpMqZMkYvA=;
 b=owNCWmg5MUFZJlNZfnO1/QAAZ////v//H7X633mvP66v3taW+v9/3339WlKd7/v/q9tX+9+wA
 RssEPRNANDQAAaGgAAaBpoAAGhkADTQBoAaAGQGgaNAAeoHqaaepozU0ZMh+iiBkaGhkBoDQBkG
 QyA000AZAxAAxAaAG0jEBiAAGR6I00MQAxA9NQaAAyR5QPUaZBkABoABoNAaGmjEAAAANDQA0AD
 INMIYjQAAMjAR6jJkyAwQXsHUBknI04Wo0WYeQdWUiAbCQhDb8LHjQBxmnTijeAWRwt6zOc60VM
 nFJQRfNJlp5YkhM9C6F50qwY6DVGjpt4MUH2PGx0sLIyxZFdEeszUoDZTJMlJLadxgHdikhu/wr
 QHOZTB+TYJEuL+9eEu1AV/6eBG/HNkogZxry/18PACxszdFeaWsYpuBcOmgh7jx70nWMcmRNTbq
 zDpAO8j/8omslMSvhQCYkXndcP2gV/36CUJIHy+hPfKYozawndhqRi6pcl7hOBL2ZaECMuPsHyx
 kZQfOqyqwY6bRFBwqzjvftUGcxECldQD+ogsqKkQJI9ZPsZhae9tps4kMJRFA0SsYwtNfCYqwCu
 Z24xe0YL0wicsmYMCqfp5gqiFs14Fw5DrTHqoBI4yTxH9rDmAwFgEoq603k4FNAUJxQEd5Blfg/
 4u5IpwoSD852v6A
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

With the Linux and U-Boot board files unified, we now have a duplicate
wkup_uart0 node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index d55ddb83837f3..3e94cfccd4321 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -18,7 +18,6 @@
 		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
 		serial1 = &mcu_uart0;
 		serial2 = &main_uart0;
 		spi0 = &ospi0;
@@ -117,8 +116,6 @@
 };
 
 &wkup_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_uart0_pins_default>;
 	status = "okay";
 };
 
@@ -144,15 +141,6 @@
 };
 
 &wkup_pmx0 {
-	wkup_uart0_pins_default: wkup_uart0_pins_default {
-		pinctrl-single,pins = <
-			AM65X_WKUP_IOPAD(0x00a0, PIN_INPUT, 0)	/* (AB1) WKUP_UART0_RXD */
-			AM65X_WKUP_IOPAD(0x00a4, PIN_OUTPUT, 0)	/* (AB5) WKUP_UART0_TXD */
-			AM65X_WKUP_IOPAD(0x00c8, PIN_INPUT, 1)	/* (AC2) WKUP_GPIO0_6.WKUP_UART0_CTSn */
-			AM65X_WKUP_IOPAD(0x00cc, PIN_OUTPUT, 1)	/* (AC1) WKUP_GPIO0_7.WKUP_UART0_RTSn */
-		>;
-	};
-
 	wkup_vtt_pins_default: wkup_vtt_pins_default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0040, PIN_OUTPUT_PULLUP, 7)	/* WKUP_GPIO0_28 */
-- 
2.43.0

