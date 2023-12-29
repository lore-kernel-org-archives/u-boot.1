Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55A6C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91BE87B31;
	Fri, 29 Dec 2023 11:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aW453GqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15B94876B2; Fri, 29 Dec 2023 11:47:07 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443FD87B09
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkxpt059476;
 Fri, 29 Dec 2023 04:46:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846819;
 bh=A0XpjR5E5SltrmDrUVjbLW3tWPuhFVtUVdHMus3bzbM=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=aW453GqECE9ZosdYm0819DpnCghG3/6aiTGbJ9cgnsBrAovTF0za6ScROXoSDWkFr
 +F16iEBBI18bGk1gF6sd7LjllaMO7eLxNMBggf0kP/2fBLM1mXJDUpuih8UVHTV5fd
 KBr2RniA5tbUg7QwAzTGUdrAO0Zq1+FyntLVIwGg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAkxZw016338
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:46:59 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:46:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:46:59 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7l072641;
 Fri, 29 Dec 2023 04:46:56 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 29 Dec 2023 16:16:31 +0530
Subject: [PATCH v7 7/9] arm: dts: k3-j7200-binman: Add firewall configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231229-binman-firewalling-v7-7-47ed4af303fe@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=2964;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=jlD86iYszvuUkfiUfEzwtFvxwCDq5wK2iVqfRTT3xlo=;
 b=Y96gV5TOzO8iMa0JjgRM4jWg0LLMJBbC1RICqjzp7MC4pdqsy3IWmcjH3ntfitBGyJcWkqsoe
 +jQLLA3E7+TCDUT8nDbVJaQem1JMOT6zPbJaiynCcCLxWAk7f34tyOI
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
 arch/arm/dts/k3-j7200-binman.dtsi | 90 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 38cccabaa71d..06db86598761 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -195,6 +195,96 @@
 
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
+						/*	firewall-4760-0 {
+						 *		nb_slv0__mem0 Background Firewall
+						 *		Already configured by the secure entity
+						 *	};
+						 */
+
+						firewall-4760-1 {
+							/* nb_slv0__mem0 Foreground Firewall */
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <4760>;
+							region = <1>;
+						};
+
+						/*	firewall-4761-0 {
+						 *		nb_slv1__mem0 Background Firewall
+						 *		Already configured by the secure entity
+						 *	};
+						 */
+
+						firewall-4761-1 {
+							/* nb_slv1__mem0 Foreground Firewall */
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <4761>;
+							region = <1>;
+						};
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						/* cpu_0_cpu_0_msmc region 0 and 1 configured
+						 * during ATF Firewalling
+						 */
+
+						firewall-257-2 {
+							/* cpu_0_cpu_0_msmc Foreground Firewall */
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <257>;
+							region = <2>;
+						};
+
+						firewall-4762-0 {
+							/* nb_slv2__mem0 Background Firewall - 0 */
+							insert-template = <&firewall_bg_3>;
+							id = <4762>;
+							region = <0>;
+						};
+
+						firewall-4762-1 {
+							/* nb_slv2__mem0 Foreground Firewall */
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <4762>;
+							region = <1>;
+						};
+
+						firewall-4763-0 {
+							/* nb_slv3__mem0 Background Firewall - 0 */
+							insert-template = <&firewall_bg_3>;
+							id = <4763>;
+							region = <0>;
+						};
+
+						firewall-4763-1 {
+							/* nb_slv3__mem0 Foreground Firewall */
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <4763>;
+							region = <1>;
+						};
+					};
+				};
 				dm {
 					ti-secure {
 						content = <&dm>;

-- 
2.43.0

