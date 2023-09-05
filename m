Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0C6C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 08:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51CAB8643D;
	Tue,  5 Sep 2023 10:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HvTyclyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B251B86987; Tue,  5 Sep 2023 10:21:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D760486940
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 10:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3858Ln8Z029416;
 Tue, 5 Sep 2023 03:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693902109;
 bh=1IOIPN2oLkuSznuXIEkkfRSbPvVwz4ZqO5Wvb2DNLFQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=HvTyclytz3wBUr4wSZ+YkvYrHRt1NNHKE7ahpAR926XB1NP2L+NtOxknQgbSa6ciW
 jzVmpfh3Wzpk6uSSgcmDILXbcFV8V/znEM9+M8dpHO41lnKotej4pegBK+KNd5nfP7
 H9T0Wirh8kfa2ByBP50U479dV7KmC5GrvHJqhyyg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3858LnBR011404
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 03:21:49 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 03:21:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 03:21:49 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3858LdLi016284;
 Tue, 5 Sep 2023 03:21:46 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 5 Sep 2023 13:51:35 +0530
Subject: [RFC PATCH 2/2] binman: j721e: Add firewall configurations for atf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230905-binman-firewalling-v1-2-3894520bff8a@ti.com>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
In-Reply-To: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693902099; l=5263;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=mrlvXbwL1WihBx8K2El/4nz5HmPwToDHCKl4zo0GoyU=;
 b=YXrV3r0CkSXMi0Edi2q16xna/4d+5kAP0a0gv5jp1h9jLs272na6E+QyXWN/VCiI9enyBob0v
 K32XMtOKhUkALvPSDbxpsvBehO9nqRmLq/4xfcnspJuQu/xELhmgHIo
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
 arch/arm/dts/k3-j721e-binman.dtsi | 161 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 4f566c21a9af..0569a592597e 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -330,6 +330,73 @@
 					ti-secure {
 						content = <&atf>;
 						keyfile = "custMpk.pem";
+						auth_in_place = <0xa02>;
+
+						// cpu_0_cpu_0_msmc Background Firewall - 0
+						firewall-0 {
+							id = <257>;
+							region = <0>;
+							control = <0x31a>;
+							permissions = <0xc3ffff>;
+							start_address = <0x0 0x0>;
+							end_address = <0xff 0xffffffff>;
+						};
+
+						// cpu_0_cpu_0_msmc Foreground Firewall
+						firewall-1 {
+							id = <257>;
+							region = <1>;
+							control = <0x1a>;
+							permissions = <0x0100ff>;
+							start_address = <0x0 0x70000000>;
+							end_address = <0x0 0x7001ffff>;
+						};
+
+						// dru_0_msmc Background Firewall - 0
+						firewall-4 {
+							id = <284>;
+							region = <0>;
+							control = <0x31a>;
+							permissions = <0xc3ffff>;
+							start_address = <0x0 0x0>;
+							end_address = <0xff 0xffffffff>;
+						};
+
+						// dru_0_msmc Foreground Firewall
+						firewall-5 {
+							id = <284>;
+							region = <1>;
+							control = <0x1a>;
+							permissions = <0x0100ff>;
+							start_address = <0x0 0x70000000>;
+							end_address = <0x0 0x7001ffff>;
+						};
+
+						// Slave Background Firewall - 0
+						// Already configured by secure entity
+
+						// Slave Foreground Firewall
+						firewall-7 {
+							id = <4760>;
+							region = <1>;
+							control = <0x1a>;
+							permissions = <0x0100ff>;
+							start_address = <0x0 0x70000000>;
+							end_address = <0x0 0x7001ffff>;
+						};
+
+						// Slave Background Firewall - 0
+						// Already configured by secure entity
+
+						// Slave Foreground Firewall
+						firewall-9 {
+							id = <4761>;
+							region = <1>;
+							control = <0x1a>;
+							permissions = <0x0100ff>;
+							start_address = <0x0 0x70000000>;
+							end_address = <0x0 0x7001ffff>;
+						};
 					};
 					atf: atf-bl31 {
 					};
@@ -346,6 +413,100 @@
 					ti-secure {
 						content = <&tee>;
 						keyfile = "custMpk.pem";
+						auth_in_place = <0xa02>;
+
+						// cpu_0_cpu_0_msmc Background Firewall - 0
+						// configured during ATF Firewalling
+
+						// cpu_0_cpu_0_msmc Foreground Firewall - 1
+						// configured during ATF Firewalling
+
+						// cpu_0_cpu_0_msmc Foreground Firewall - 2
+						firewall-1 {
+							id = <257>;
+							region = <2>;
+							control = <0x1a>;
+							permissions = <0x0100ff>;
+							start_address = <0x0 0x9e800000>;
+							end_address = <0x0 0x9fffffff>;
+						};
+
+						// dru_0_msmc Background Firewall - 0
+						// configured during ATF Firewalling
+
+						// dru_0_msmc Foreground Firewall - 1
+						// configured during ATF Firewalling
+
+						// dru_0_msmc Foreground Firewall - 2
+						firewall-5 {
+							id = <284>;
+							region = <2>;
+							control = <0x1a>;
+							permissions = <0x0100ff>;
+							start_address = <0x0 0x9e800000>;
+							end_address = <0x0 0x9fffffff>;
+						};
+
+						// Slave Background Firewall - 0
+						firewall-6 {
+							id = <4762>;
+							region = <0>;
+							control = <0x31a>;
+							permissions = <0xc3ffff>;
+							start_address = <0x0 0x80000000>;
+							end_address = <0x0 0xffffffff>;
+						};
+
+						// Slave Background Firewall - 1
+						firewall-7 {
+							id = <4762>;
+							region = <1>;
+							control = <0x31a>;
+							permissions = <0xc3ffff>;
+							start_address = <0x8 0x0>;
+							end_address = <0xf 0xffffffff>;
+						};
+
+						// Slave Foreground Firewall
+						firewall-8 {
+							id = <4762>;
+							region = <2>;
+							control = <0x1a>;
+							permissions = <0x0100ff>;
+							start_address = <0x0 0x9e800000>;
+							end_address = <0x0 0x9fffffff>;
+						};
+
+						// Slave Background Firewall - 0
+						firewall-9 {
+							id = <4763>;
+							region = <0>;
+							control = <0x31a>;
+							permissions = <0xc3ffff>;
+							start_address = <0x0 0x80000000>;
+							end_address = <0x0 0xffffffff>;
+						};
+
+						// Slave Background Firewall - 1
+						firewall-10 {
+							id = <4763>;
+							region = <1>;
+							control = <0x31a>;
+							permissions = <0xc3ffff>;
+							start_address = <0x8 0x0>;
+							end_address = <0xf 0xffffffff>;
+						};
+
+						// Slave Foreground Firewall
+						firewall-11 {
+							id = <4763>;
+							region = <2>;
+							control = <0x1a>;
+							permissions = <0x0100ff>;
+							start_address = <0x0 0x9e800000>;
+							end_address = <0x0 0x9fffffff>;
+						};
+
 					};
 					tee: tee-os {
 					};

-- 
2.41.0

