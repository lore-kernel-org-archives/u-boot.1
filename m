Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538DDE7B606
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E05658755B;
	Wed,  4 Oct 2023 14:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dqC58xUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EF4F87557; Wed,  4 Oct 2023 14:32:34 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0441587540
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394CWTiE032593;
 Wed, 4 Oct 2023 07:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696422749;
 bh=t9B63s7sxzH6H32foWRqoidUyNKT+36qIeRoCnuNJEk=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=dqC58xUN11tUezfQceFU7MKpukI5yVW5oBKnCyKLoxiSv006HnJa6q56i3cgT78bl
 AJp8VMQYmexHy2ktHOhbUZpOprWwTiosa6HTF2ZrApTN9MsKRf0yX7aP2vUdXxPDAs
 B/uB1R1Y5LcsRYv+IW6REn/epLR3fZ2SDb0hAmuY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394CWTHZ082550
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 07:32:29 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 07:32:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 07:32:29 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394CWBJp010622;
 Wed, 4 Oct 2023 07:32:26 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 4 Oct 2023 18:01:33 +0530
Subject: [PATCH v3 4/6] binman: j721e: Add firewall configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231004-binman-firewalling-v3-4-e4a102324e1f@ti.com>
References: <20231004-binman-firewalling-v3-0-e4a102324e1f@ti.com>
In-Reply-To: <20231004-binman-firewalling-v3-0-e4a102324e1f@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696422731; l=7023;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=Dact7wRFeRPw4wPFEQsIMvAkAYmyczcXjU/E0mw2Lmc=;
 b=cPyy5vTTv8K7pGWPI7MXeEMZ14oigdgWETzfY5IsPJ19y+ABG+DVP3I4cprN09m1Yjikhgi2o
 UA4Ygy59IuAAH9onN9S7ddUItCZflN2sdZ0urs2JTbXPFUng6rlTCkh
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
 arch/arm/dts/k3-j721e-binman.dtsi | 187 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 4f566c21a9af..a2ad86822112 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -330,6 +330,102 @@
 					ti-secure {
 						content = <&atf>;
 						keyfile = "custMpk.pem";
+						auth_in_place = <0xa02>;
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
+						firewall-284-0 {
+							/* dru_0_msmc Background Firewall */
+							id = <284>;
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
+						firewall-284-1 {
+							/* dru_0_msmc Foreground Firewall */
+							id = <284>;
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
@@ -346,6 +442,97 @@
 					ti-secure {
 						content = <&tee>;
 						keyfile = "custMpk.pem";
+						auth_in_place = <0xa02>;
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
+						/* dru_0_msmc region 0 and 1 configured
+						 * during ATF Firewalling
+						 */
+
+						firewall-284-2 {
+							/* dru_0_msmc Foreground Firewall */
+							id = <284>;
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
+							/* nb_slv2__mem0 Background Firewall */
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
+							/* nb_slv3__mem0 Background Firewall */
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
 					};
 					tee: tee-os {
 					};

-- 
2.41.0

