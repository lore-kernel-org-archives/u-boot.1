Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B01EC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 10:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3854887164;
	Mon, 13 Nov 2023 11:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="st3ZkHUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3B508714E; Mon, 13 Nov 2023 11:19:31 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064E3870ED
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 11:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADAJPIo070713;
 Mon, 13 Nov 2023 04:19:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699870765;
 bh=OjoQ13WsU96GKzEvCi87vwirQLJ0+aWk87yTfOakFi8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=st3ZkHUP94AkcxHuIZTt1p4Y/krTV86HmHLCLaKK+GVrZd4FYkupn5UtVjZbv9pD+
 u3Mvw+PnhuosVO5olZ2eNmm9Ds8470AydA5PmYhwMZZh9WSo7HqjsbPcC4bN5bx64f
 CBn/358Ldwq2O1di3BqyrqjIHSDwki6o0YSZYuBs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADAJPhq075602
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 04:19:25 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 04:19:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 04:19:25 -0600
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADAJ06C051156;
 Mon, 13 Nov 2023 04:19:22 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 13 Nov 2023 15:49:05 +0530
Subject: [PATCH v5 6/8] binman: j7200: Add firewall configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231113-binman-firewalling-v5-6-b3ba6f839606@ti.com>
References: <20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com>
In-Reply-To: <20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699870741; l=5559;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=eaFamJ8A4sqggLVspnDdcs8xg4EB7GcJA5aU/13JaiA=;
 b=njBZ/kvrQeRgRc6u+mI885lSjNjeytmVrsb+OP64xIHrcpv8rqDM6Nl2K020Y07dydT81cEV3
 qoqqy4ATuu1B/NDaXDaPHBHN3pbhWbJl0NxeciW+AV9rY4Jqar1UF5C
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
 arch/arm/dts/k3-j7200-binman.dtsi | 143 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 14f7dea65ee3..246f15c2dd5d 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -214,6 +214,74 @@
 					ti-secure {
 						content = <&atf>;
 						keyfile = "custMpk.pem";
+						auth-in-place = <0xa02>;
+
+						firewall-257-0 {
+							/* cpu_0_cpu_0_msmc Background Firewall */
+							id = <257>;
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
+						firewall-257-1 {
+							/* cpu_0_cpu_0_msmc Foreground Firewall */
+							id = <257>;
+							region = <1>;
+							control = <(FWCTRL_EN | FWCTRL_LOCK |
+										FWCTRL_CACHE)>;
+							permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+											FWPERM_SECURE_PRIV_RWCD |
+											FWPERM_SECURE_USER_RWCD)>;
+							start_address = <0x0 0x70000000>;
+							end_address = <0x0 0x7001ffff>;
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
+							id = <4760>;
+							region = <1>;
+							control = <(FWCTRL_EN | FWCTRL_LOCK |
+										FWCTRL_CACHE)>;
+							permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+											FWPERM_SECURE_PRIV_RWCD |
+											FWPERM_SECURE_USER_RWCD)>;
+							start_address = <0x0 0x70000000>;
+							end_address = <0x0 0x7001ffff>;
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
+							id = <4761>;
+							region = <1>;
+							control = <(FWCTRL_EN | FWCTRL_LOCK |
+										FWCTRL_CACHE)>;
+							permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+											FWPERM_SECURE_PRIV_RWCD |
+											FWPERM_SECURE_USER_RWCD)>;
+							start_address = <0x0 0x70000000>;
+							end_address = <0x0 0x7001ffff>;
+						};
+
 					};
 					atf: atf-bl31 {
 					};
@@ -230,6 +298,81 @@
 					ti-secure {
 						content = <&tee>;
 						keyfile = "custMpk.pem";
+						auth-in-place = <0xa02>;
+
+						/* cpu_0_cpu_0_msmc region 0 and 1 configured
+						 * during ATF Firewalling
+						 */
+
+						firewall-257-2 {
+							/* cpu_0_cpu_0_msmc Foreground Firewall */
+							id = <257>;
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
+						firewall-4762-0 {
+							/* nb_slv2__mem0 Background Firewall - 0 */
+							id = <4762>;
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
+						firewall-4762-1 {
+							/* nb_slv2__mem0 Foreground Firewall */
+							id = <4762>;
+							region = <1>;
+							control = <(FWCTRL_EN | FWCTRL_LOCK |
+										FWCTRL_CACHE)>;
+							permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+											FWPERM_SECURE_PRIV_RWCD |
+											FWPERM_SECURE_USER_RWCD)>;
+							start_address = <0x0 0x9e800000>;
+							end_address = <0x0 0x9fffffff>;
+						};
+
+						firewall-4763-0 {
+							/* nb_slv3__mem0 Background Firewall - 0 */
+							id = <4763>;
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
+						firewall-4763-1 {
+							/* nb_slv3__mem0 Foreground Firewall */
+							id = <4763>;
+							region = <1>;
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
 					};

-- 
2.41.0

