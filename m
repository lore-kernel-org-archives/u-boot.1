Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B409CC46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98EE87B43;
	Fri, 29 Dec 2023 11:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ex86ZE6/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34A287B31; Fri, 29 Dec 2023 11:47:01 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6728287B1B
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkuZt085087;
 Fri, 29 Dec 2023 04:46:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846816;
 bh=mpOOm/yP+ObWxhcex3AjnIdI2Je1Kdz+ybCqMjLt9oQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=ex86ZE6/WVsL8TH++I37WF5MpOEI7jD8N1ezBaC/ObrUKW0SZU3P6c3m4rKhEG4YF
 n0NoTc1EPsQhOcHfWrqmk2x2P11gDDuTtNFPNfIkCSbkty1cq6NwheYUN4l9Wb17Yw
 aUfERED+7B1krYFyKcUQIu8Naq2bEmvJQ376s3AA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAktrk065869
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:46:56 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:46:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:46:55 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7k072641;
 Fri, 29 Dec 2023 04:46:52 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 29 Dec 2023 16:16:30 +0530
Subject: [PATCH v7 6/9] arm: dts: k3-j721s2-binman: Add firewall configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231229-binman-firewalling-v7-6-47ed4af303fe@ti.com>
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
In-Reply-To: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=3785;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=kaV36In9QmSi4+B42CU8VWJapEYkjSv15k9CourW1Xk=;
 b=fqFRUaYc5AZhPXInwSHG8TU9PjQtPLZGXDZcdnmiD8SoArPbgYUSFdTeZAGLQ+NRaLS1f9Li6
 IaOE4ZdOa76Ca24Sjt7CuQJiBB8OIEqNZrcP1VSsJaYNMrm2H8yNJon
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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
 arch/arm/dts/k3-j721s2-binman.dtsi | 123 +++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index f17dd8e04cfa..7efb135bdff9 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -159,6 +159,129 @@
 
 		fit {
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-257-0 {
+							/* cpu_0_cpu_0_msmc Background Firewall */
+							insert-template = <&firewall_bg_1>;
+							id = <257>;
+							region = <0>;
+						};
+
+						firewall-257-1 {
+							/* cpu_0_cpu_0_msmc Foreground Firewall */
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <257>;
+							region = <1>;
+						};
+
+						firewall-284-0 {
+							/* dru_0_msmc Background Firewall */
+							insert-template = <&firewall_bg_3>;
+							id = <284>;
+							region = <0>;
+						};
+
+						firewall-284-1 {
+							/* dru_0_msmc Foreground Firewall */
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <284>;
+							region = <1>;
+						};
+
+						/*	firewall-5140-0 {
+						 *		nb_slv0__mem0 Background Firewall
+						 *		Already configured by the secure entity
+						 *	};
+						 */
+
+						firewall-5140-1 {
+							/* nb_slv0__mem0 Foreground Firewall */
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <5140>;
+							region = <1>;
+						};
+
+						/*	firewall-5140-0 {
+						 *		nb_slv1__mem0 Background Firewall
+						 *		Already configured by the secure entity
+						 *	};
+						 */
+
+						firewall-5141-1 {
+							/* nb_slv1__mem0 Foreground Firewall */
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <5141>;
+							region = <1>;
+						};
+
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-257-2 {
+							/* cpu_0_cpu_0_msmc Foreground Firewall */
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <257>;
+							region = <2>;
+						};
+
+						firewall-284-2 {
+							/* dru_0_msmc Foreground Firewall */
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <284>;
+							region = <2>;
+						};
+
+						firewall-5142-0 {
+							/* nb_slv2__mem0 Background Firewall - 0 */
+							insert-template = <&firewall_bg_3>;
+							id = <5142>;
+							region = <0>;
+						};
+
+						firewall-5142-1 {
+							/* nb_slv2__mem0 Foreground Firewall */
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <5142>;
+							region = <1>;
+						};
+
+						firewall-5143-0 {
+							/* nb_slv3__mem0 Background Firewall - 0 */
+							insert-template = <&firewall_bg_3>;
+							id = <5143>;
+							region = <0>;
+						};
+
+						firewall-5143-1 {
+							/* nb_slv3__mem0 Foreground Firewall */
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <5143>;
+							region = <1>;
+						};
+
+						firewall-5144-0 {
+							/* nb_slv4__mem0 Background Firewall - 0 */
+							insert-template = <&firewall_bg_3>;
+							id = <5144>;
+							region = <0>;
+						};
+
+						firewall-5144-1 {
+							/* nb_slv4__mem0 Foreground Firewall */
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <5144>;
+							region = <1>;
+						};
+
+					};
+				};
 				dm {
 					ti-secure {
 						content = <&dm>;

-- 
2.43.0

