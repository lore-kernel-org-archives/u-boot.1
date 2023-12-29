Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BA2C46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EF7387B25;
	Fri, 29 Dec 2023 11:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GrkcvEn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B52A87B18; Fri, 29 Dec 2023 11:46:59 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2E687B09
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkqTD085080;
 Fri, 29 Dec 2023 04:46:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846812;
 bh=tgOLUatsdRvETSnuCcbKTPRJ1ntFOjxO4Ab82IISql8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=GrkcvEn/w+BYFuAxCYXatCCfxGgIb7JjGaTKnNaFK/fJeUnKhwVL66XcZTIFH9+Ek
 PBltEgq1/xYhj7mKaSoerrTsSlIRozw73gpQxMPiHZiJxnxjjJ8g5JXc7+tQUBPb3e
 jRbIzwO8eHgTWit87MCnlAlr5TBfeO6iqnxs28xI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAkqTV065841
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:46:52 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:46:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:46:52 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7j072641;
 Fri, 29 Dec 2023 04:46:48 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 29 Dec 2023 16:16:29 +0530
Subject: [PATCH v7 5/9] arm: dts: k3-j721e-binman: Add firewall configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231229-binman-firewalling-v7-5-47ed4af303fe@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=3598;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=ozpASFRBp2LiNR7WgDbe1jZtw6ONZB1cAew9BJ3JrvQ=;
 b=e6HnL1bHFFg4XTZA7xO+d3HM9K2gaUSDGEK41OMJpJakZr4WCjSAqD9KROrmrd59HmDwC3Slo
 3fLRpesuBwADbMF3qvu3VA0O9A0OVV0woLwigkytcGjvKJ5vdem6RFb
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
 arch/arm/dts/k3-j721e-binman.dtsi | 116 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index dbc385a852de..1bd9f96a58e9 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -146,6 +146,122 @@
 
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
+
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
+						/* dru_0_msmc region 0 and 1 configured
+						 * during ATF Firewalling
+						 */
+
+						firewall-284-2 {
+							/* dru_0_msmc Foreground Firewall */
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <284>;
+							region = <2>;
+						};
+
+						firewall-4762-0 {
+							/* nb_slv2__mem0 Background Firewall */
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
+							/* nb_slv3__mem0 Background Firewall */
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

