Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC08C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D52A8884F6;
	Fri, 14 Jun 2024 14:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eHjmiKY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A0ED88641; Fri, 14 Jun 2024 14:05:12 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36F388113
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EC55fV060250;
 Fri, 14 Jun 2024 07:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718366705;
 bh=uzx337Cl9mzf8JGpTHsskBVkc3ZRGCycL/Jc+JWxnZY=;
 h=From:To:CC:Subject:Date;
 b=eHjmiKY/bhxqSBD3Q5e72PQBzTDyoUcsneg755OmKzcZvdP1ePL5UcowxQE+NAxNS
 HI0k9jIpu867FK71QxkBaCvEJv8Ufj/xarLDluhxGNwIx87GnB+Mk/8MzclDxrSYgK
 aA5j+22M+t5v3TAipbvdYU4LO9yOUsIRRDU/SW98=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EC54I8017304
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 07:05:05 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 07:05:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 07:05:04 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EC507A111731;
 Fri, 14 Jun 2024 07:05:01 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH v3] arm: dts: k3-am625-beagleplay: Add symlinks for tiboot3
 and tispl
Date: Fri, 14 Jun 2024 17:34:17 +0530
Message-ID: <20240614120416.4126896-1-d-gole@ti.com>
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

This is just a RESEND of v1, because the changes in v2 were not
required. Link to previous revision:
https://lore.kernel.org/u-boot/20240614115340.4091211-1-d-gole@ti.com/


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

