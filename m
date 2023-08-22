Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5054CEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5092864B2;
	Tue, 22 Aug 2023 18:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="igr+PJmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CE3864E0; Tue, 22 Aug 2023 18:41:20 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEC068646D
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfBdM048837;
 Tue, 22 Aug 2023 11:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722471;
 bh=BuwD3E0yKMyaUrfwBGm9a9Y0Dm8x7CPGZ2Uve3C2xjg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=igr+PJmbHj73lTiYflNjUqqCHf9vYXMbCS5/eez+vjFwMJgQrAGgzxfczGSNr0kYL
 qbEOtdZ0vs6CkFcIN+8X1re7vCVKZqH8U+GnELah8e8fjaxjbcH7YbL0UJ8X1jiku6
 CSdcO/cXJytMul1cGAQ1WYAdOiKgtqeQhD0ANvP8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfBnI071237
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:11 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfBXT022036;
 Tue, 22 Aug 2023 11:41:11 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 07/13] doc: board: ti: j721e: provide image alt text
Date: Tue, 22 Aug 2023 11:41:01 -0500
Message-ID: <20230822164107.2272231-8-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230822164107.2272231-1-nm@ti.com>
References: <20230822164107.2272231-1-nm@ti.com>
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

Provide alternative text for image.

Fixes: 3b83dff183b5 ("doc: board: ti: j721e: Convert the image format to svg")
Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
new
 doc/board/ti/j721e_evm.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index d2a214fb33f4..a4c464707c6a 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -40,6 +40,7 @@ Boot flow is similar to that of AM65x SoC and extending it with remoteproc
 support. Below is the pictorial representation of boot flow:
 
 .. image:: img/boot_diagram_j721e.svg
+  :alt: Boot flow diagram
 
 - Here DMSC acts as master and provides all the critical services. R5/A72
   requests DMSC to get these services done as shown in the above diagram.
@@ -136,14 +137,17 @@ Image formats:
 - tiboot3.bin
 
 .. image:: img/no_multi_cert_tiboot3.bin.svg
+  :alt: tiboot3.bin image format
 
 - tispl.bin
 
 .. image:: img/dm_tispl.bin.svg
+  :alt: tispl.bin image format
 
 - sysfw.itb
 
 .. image:: img/sysfw.itb.svg
+  :alt: sysfw.itb image format
 
 R5 Memory Map:
 --------------
@@ -213,6 +217,7 @@ addresses.
 Flash layout for OSPI:
 
 .. image:: img/ospi_sysfw.svg
+  :alt: OSPI flash partition layout
 
 Firmwares:
 ----------
-- 
2.40.0

