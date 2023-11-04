Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E4BC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3068744F;
	Sat,  4 Nov 2023 08:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aFv2Itgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BD586EC9; Sat,  4 Nov 2023 08:22:53 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BD487123
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LsKO061069;
 Sat, 4 Nov 2023 02:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699082514;
 bh=HLO2zP9DyDz+puPa+gP24RYNxMHC6qEDwpdWj3TtdjU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aFv2ItgsecPvZAgiR98TzNjMKZS+9EDMg5Agd1nHbvCGR4uHFWkH/FiSBiqb/20bC
 c2aE7dYhs9Mhp1KAQdTyFbXr5le9JQWBHkOtyf4KrqQUZ7YvKVFFWzXwtwvGFFC9pG
 RypCT7krW6GKwyY5wiZzD08MP5SIwoLlqqGJav0E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A47LsAN001185
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 02:21:54 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 02:21:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 02:21:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LsdB103859;
 Sat, 4 Nov 2023 02:21:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 12/12] doc: board: ti: j721e_evm: Use board relative path
 for include directives
Date: Sat, 4 Nov 2023 02:21:50 -0500
Message-ID: <20231104072150.3339-13-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104072150.3339-1-nm@ti.com>
References: <20231104072150.3339-1-nm@ti.com>
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

When using include directives within a section that is included by non
TI board rst file, k3.rst and other include paths need to be relative to
doc/board/ base.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 doc/board/ti/j721e_evm.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index 344a38d37486..b012171b45ee 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -48,7 +48,7 @@ support. Below is the pictorial representation of boot flow:
 Sources:
 --------
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
@@ -56,17 +56,17 @@ Build procedure:
 ----------------
 0. Setup the environment variables:
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_desc
     :end-before: .. k3_rst_include_end_common_env_vars_desc
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_board_env_vars_desc
     :end-before: .. k3_rst_include_end_board_env_vars_desc
 
 Set the variables corresponding to this platform:
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
 .. prompt:: bash $
@@ -84,14 +84,14 @@ Set the variables corresponding to this platform:
 
 1. Trusted Firmware-A:
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_build_steps_tfa
     :end-before: .. k3_rst_include_end_build_steps_tfa
 
 
 2. OP-TEE:
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_build_steps_optee
     :end-before: .. k3_rst_include_end_build_steps_optee
 
@@ -99,13 +99,13 @@ Set the variables corresponding to this platform:
 
 * 3.1 R5:
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_build_steps_spl_r5
     :end-before: .. k3_rst_include_end_build_steps_spl_r5
 
 * 3.2 A72:
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_build_steps_uboot
     :end-before: .. k3_rst_include_end_build_steps_uboot
 .. j721e_evm_rst_include_end_build_steps
@@ -248,7 +248,7 @@ detailed setup information.
   environment's distribution needs to be updated, it might be necessary to
   build OpenOCD from the source.
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
     :end-before: .. k3_rst_include_end_openocd_connect_XDS110
 
-- 
2.37.2

