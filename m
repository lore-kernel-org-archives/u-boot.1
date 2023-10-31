Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F7AC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCA987CD7;
	Tue, 31 Oct 2023 14:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BsHfDYpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF1EC87C82; Tue, 31 Oct 2023 14:28:23 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC5D87B5D
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSJn5094068;
 Tue, 31 Oct 2023 08:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698758899;
 bh=wM5Z6kH0RfGiNh5W9PqgaZYG/Kyd70CC84uVN0Hp+Wg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BsHfDYpdsgzEcs143L7CECGYpSS6AG3lC2burW89kj8BY9EWpNv20ueKXRVdmX+8G
 w36+FGtpmX/309RnFpIU6qc1ACWG9U0TadGFLwbythBeGH/dsLMosE4sA8u/qJazKA
 u18cvpi350zVyonzlwuOiRQOSH82Krp0J12RWiuA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDSJ6q007487
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:28:19 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:28:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:28:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSIrW003550;
 Tue, 31 Oct 2023 08:28:19 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 6/6] doc: ti: Add AM62SIP SK Board information
Date: Tue, 31 Oct 2023 18:58:09 +0530
Message-ID: <20231031132809.1524341-7-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031132809.1524341-1-n-yadav@ti.com>
References: <20231031132809.1524341-1-n-yadav@ti.com>
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

Add link for AM62SIP SK in platform information. AM62SIP SK
has config fragment for R5 SPL to build U-boot, Adding
information to update UBOOT_CFG_CORTEXR with am62sip fragment
over am62x defconfig.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 doc/board/ti/am62x_sk.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index 9d7ce1fd54..c147759d0d 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -42,6 +42,7 @@ Platform information:
 
 * https://www.ti.com/tool/SK-AM62B
 * https://www.ti.com/tool/SK-AM62-LP
+* https://www.ti.com/tool/SK-AM62-SIP
 
 Boot Flow:
 ----------
@@ -94,6 +95,12 @@ For SK-AM62x-LP, set the UBOOT_CFG_CORTEXR variable as shown below:
  $ export UBOOT_CFG_CORTEXR=am62x_evm_r5_defconfig am62x_lpsk_r5.config
  $ export UBOOT_CFG_CORTEXA=am62x_evm_a53_defconfig am62x_lpsk_a53.config
 
+For SK-AM62-SIP, set the UBOOT_CFG_CORTEXR variable for R5 SPL as shown below:
+
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR=am62x_evm_r5_defconfig am62xsip_sk_r5.config
+
 .. am62x_evm_rst_include_start_build_steps
 
 1. Trusted Firmware-A:
-- 
2.25.1

