Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D54E7D24B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077AB86D80;
	Tue, 26 Sep 2023 09:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FDMx1BPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44DA086D84; Tue, 26 Sep 2023 09:59:11 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3916486D7F
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38Q7x7Nn027182;
 Tue, 26 Sep 2023 02:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695715147;
 bh=dfMXR/zHyKWv6Npv2wdZvLhIfklH+B4mg51VyVg4N/M=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=FDMx1BPj7tPj4dUxudsSxYnzgI+Bz7jH8NSwbQVIuyUXUjYAUfJyPzI+KNVAaSkDk
 28BWQixLuizkJQDgPAaIdGX4vLhwEqD3zZv9AunXnQABR2cyt6TnsiGOY0CgMWH6sI
 d0ezWaWirQxHCzptPHvLyHuc5f8pY1Pj4diOiU74=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38Q7x7AN114932
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 02:59:07 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 02:59:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 02:59:06 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38Q7wauO019632;
 Tue, 26 Sep 2023 02:59:03 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 26 Sep 2023 13:28:34 +0530
Subject: [RFC PATCH v2 6/8] binman: am62x: Add firewalling configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230926-binman-firewalling-v2-6-b1a084ec634d@ti.com>
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
In-Reply-To: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695715116; l=2420;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=mZw5yN0aXAuARGimJt2+tM8Xk6UM4BZsDrEm1KDHOu4=;
 b=DKAE5CIwctmqq7fIcilzok4sEc+4zsefqr/PFofDeoYSede02ZYxOU8xBjmjEDu6tcmdGaaCB
 y88ETFF5zzYBTXrIF9ABc2rjGj0j3089JIOtZOOO3yA4V3ELAE89Ndy
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

The following commits adds the configuration of firewalls required to
protect ATF and OP-TEE memory region from non-secure reads and
writes using master and slave firewalls present in our K3 SOCs.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 41277bf4bfdb..bb5341aaae8e 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -175,6 +175,36 @@
 					ti-secure {
 						content = <&atf>;
 						keyfile = "custMpk.pem";
+						auth_in_place = <0xa02>;
+
+						firewall-1-0 {
+							/* sdram Background Firewall - 0 */
+							id = <1>;
+							region = <0>;
+							control = <(FWCTRL_EN | FWCTRL_LOCK |
+										FWCTRL_BG | FWCTRL_CACHE)>;
+							permissions = <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
+											FWPERM_SECURE_PRIV_RWCD |
+											FWPERM_SECURE_USER_RWCD |
+											FWPERM_NON_SECURE_PRIV_RWCD |
+											FWPERM_NON_SECURE_USER_RWCD)>;
+							start_address = <0x0 0x0>;
+							end_address = <0xff 0xffffffff>;
+						};
+
+						firewall-1-1 {
+							/* sdram Foreground Firewall */
+							id = <1>;
+							region = <1>;
+							control = <(FWCTRL_EN | FWCTRL_LOCK |
+										FWCTRL_CACHE)>;
+							permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+											FWPERM_SECURE_PRIV_RWCD |
+											FWPERM_SECURE_USER_RWCD)>;
+							start_address = <0x0 0x9e780000>;
+							end_address = <0x0 0x9e7fffff>;
+						};
+
 					};
 					atf: atf-bl31 {
 					};
@@ -191,8 +221,27 @@
 					ti-secure {
 						content = <&tee>;
 						keyfile = "custMpk.pem";
+						auth_in_place = <0xa02>;
+
+						/* sdram region 0 and 1 configured during
+						   ATF Firewalling */
+
+						firewall-1-2 {
+							/* sdram Foreground Firewall */
+							id = <1>;
+							region = <2>;
+							control = <(FWCTRL_EN | FWCTRL_LOCK |
+										FWCTRL_CACHE)>;
+							permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+											FWPERM_SECURE_PRIV_RWCD |
+											FWPERM_SECURE_USER_RWCD)>;
+							start_address = <0x0 0x9e800000>;
+							end_address = <0x0 0x9fffffff>;
+						};
+
 					};
 					tee: tee-os {
+
 					};
 				};
 

-- 
2.41.0

