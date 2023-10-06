Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C381E92FFF
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 10:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521B686EAF;
	Fri,  6 Oct 2023 12:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pd5OmoBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63E2386D19; Fri,  6 Oct 2023 12:07:50 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 783DE86E2D
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 12:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 396A7kCg051603;
 Fri, 6 Oct 2023 05:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696586866;
 bh=N/bUVtLYXwQbYVtXQXJs0wlsGltucITdBs8MwKgcb88=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pd5OmoBikVVdJ4kSxO0YfEanzzwcWtufPtXfY6Msg6bFJVgBD2qA5pUhxUikeZiCC
 WX+FblRIJA2uTr8ztOBgOCZ71B44L19m8FZx4cryeUhOuu6OVKZhySKjb4p58NPCcf
 VNu1sEjkNsTmNTlbpAGAGfmN5xivYdbgOqWfeiqY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 396A7kT4103658
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Oct 2023 05:07:46 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 05:07:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 05:07:45 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 396A7c70105951;
 Fri, 6 Oct 2023 05:07:43 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <a-nandan@ti.com>
Subject: [PATCH v3 2/2] DONOTMERGE: arm: dts: k3-j7200-binman: Enable split
 mode for MCU R5
Date: Fri, 6 Oct 2023 15:37:37 +0530
Message-ID: <20231006100737.343745-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006100737.343745-1-n-francis@ti.com>
References: <20231006100737.343745-1-n-francis@ti.com>
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

Set boot core-opts to enable split mode for MCU R5 cluster by default.
This patch serves to demonstrate how this can be done.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
No change since v2

 arch/arm/dts/k3-j7200-binman.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 14f7dea65e..025a0bd071 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -55,6 +55,7 @@
 				<&combined_dm_cfg>, <&sysfw_inner_cert>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -100,6 +101,7 @@
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -146,6 +148,7 @@
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			content-sbl = <&u_boot_spl_unsigned>;
 			load = <0x41c00000>;
 			content-sysfw = <&ti_fs_gp>;
-- 
2.34.1

