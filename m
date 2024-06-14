Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3CAC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 08:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCED78804F;
	Fri, 14 Jun 2024 10:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jfkDUWW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A338867C; Fri, 14 Jun 2024 10:42:26 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904BD87EBD
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 10:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E8gMAu012434;
 Fri, 14 Jun 2024 03:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718354542;
 bh=jgxtXSr8fTW+rQgWV1oiTip00kRNtz0PnuvskPS47Gk=;
 h=From:To:CC:Subject:Date;
 b=jfkDUWW175wRjkxpozkZRVMithadKern1GSxKLvKaV8Cnc2EYre6jFuFcvm7jC4ad
 Ih2EZcFoM8T8rlc1HH+/CNyX6ftQKz2FbVSLSfDcoznRBWH9Bp3ajSn834ZUpiCCKS
 3O0RtenvF5H9/AGtMEAGK8a4ApkN6vLruv6hkpDc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E8gMdM032162
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 03:42:22 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 03:42:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 03:42:21 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E8gHVD015445;
 Fri, 14 Jun 2024 03:42:18 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH] arm: dts: k3-am625-beagleplay: Add symlinks for tiboot3 and
 tispl
Date: Fri, 14 Jun 2024 14:10:52 +0530
Message-ID: <20240614084052.4029849-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Add symlinks for both tiboot3.bin and tispl.bin because a user has to
anyway rename these files to get the platform to boot up.
This just makes it more intuitive and convenient.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 1 +
 arch/arm/dts/k3-am625-r5-beagleplay.dts      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index fb2032068d1c..bd48af8d186a 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -71,6 +71,7 @@
 
 	ti-spl_unsigned {
 		filename = "tispl.bin_unsigned";
+		symlink = "tispl.bin";
 		pad-byte = <0xff>;
 
 		fit {
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index 9db58f093c8c..da6746e009d5 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -79,6 +79,7 @@
 &binman {
 	tiboot3-am62x-gp-evm.bin {
 		filename = "tiboot3-am62x-gp-evm.bin";
+		symlink = "tiboot3.bin";
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;

base-commit: 1ebd659cf020843fd8e8ef90d85a66941cbab6ec
-- 
2.34.1

