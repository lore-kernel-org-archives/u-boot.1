Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27199C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 16:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E8C882A5;
	Fri,  3 May 2024 18:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gSDXaGWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D7E882AE; Fri,  3 May 2024 18:44:39 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD798829C
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 18:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 443GiZek018125;
 Fri, 3 May 2024 11:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714754675;
 bh=+Pvp2pZ8X+JK5bi3B8DMzQgCEUdxKL42LpqB4XXCL18=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=gSDXaGWKwrTvtUh8rMHWRwDucgNwMNCN0hOGF9MGwAYazhFKjyZXkJhF0SL7SmaGH
 WKM+m5BwdVpqT2YGAAVfMKvR0FPDJhZTfFCVFeN9fOZL8okFv+jW1u9SMPl/zMdvnV
 oYRPmLPaTaOtTyB8rpP2H4RDUuduBHgBhdd+Ae6M=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 443GiZoB027279
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 May 2024 11:44:35 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 11:44:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 11:44:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 443GiYBG032245;
 Fri, 3 May 2024 11:44:34 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 3 May 2024 11:44:29 -0500
Subject: [PATCH v3 2/2] configs: add defconfigs for the am625-lp-sk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240429-am62q-wip-v3-2-17dcfdb1075a@ti.com>
References: <20240429-am62q-wip-v3-0-17dcfdb1075a@ti.com>
In-Reply-To: <20240429-am62q-wip-v3-0-17dcfdb1075a@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nitin Yadav <n-yadav@ti.com>, Bryan Brattlof
 <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=bb@ti.com;
 h=from:subject:message-id; bh=4DKLwW+Cap1YPDLkWFLweE7StcTso8sqekpOv8wTf1o=;
 b=owNCWmg5MUFZJlNZ0H6pagAAZf////ffWvN7G6vtj09v/1+XKY/+d7/y7vZ7zUhb9//+7V2wA
 Rsxo4gxAANNDQPUDIAeoaBoAAAaaA0AAAD1D1GgAGmgaZND1D1GjE9TTZNGieogDTIyGmmjJkaA
 Bk0GJhHpADTIHqAaAAGEwCAyZANGjRpoeoaZNA0GRkZDRD0j9SaaepoNNAxDQ0GnqDIZMQDQDQB
 oaADAmhpoxAYQMmhkHqAAAaaA0GTQACIOuDgXKQbDWpCIEkhs4OTeevUX1D20sFGxPKMP8wWRWB
 7asfKUggveFTP1TipChlHSX99bG7MgLhsqutMc6Cy6CkgsCeQWoNXFoPbfJcNCjh2zNlGYI4qp5
 fu4QgFe7RHP/TjPUoAIApOnVbUIIBNjOXEEeZt2b1WkO+TH9JeOS2QHnsL3eBLHVVy99QdRH0YU
 CaTYIa4Dj3mEo5pVMcOsdjjAM2rVB6A8h2nwmRxQgxhasgRwaLKaiNELVKMjjXRLpighGCVKtc5
 uslsnWzMZEIjxZlaY914ANlHpimJF3uudpJrGhl6ezZc8AgfRh/poURwOGIiNnFIfw63eSdcUoz
 1MwCjbYEyT3EmjX0oI1XEAZRyLyiF0QhHtnuTyOYHIIRmrI3X8BezOWAoHgb3wJhMXyp8lRllnl
 HMA3/xdyRThQkNB+qWo
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

The am62x-lp-sk is a package and reference board spin of the am62x-sk to
showcase the low-power features of the am62x SoC family. Because it so
closely resembles the am62x-sk board, use the preprocessor to inherit
its configuration making the needed changes for this board where
necessary.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 configs/am62x_lp_sk_a53_defconfig | 3 +++
 configs/am62x_lp_sk_r5_defconfig  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/configs/am62x_lp_sk_a53_defconfig b/configs/am62x_lp_sk_a53_defconfig
new file mode 100644
index 0000000000000..904b2142b2f53
--- /dev/null
+++ b/configs/am62x_lp_sk_a53_defconfig
@@ -0,0 +1,3 @@
+#include <configs/am62x_evm_a53_defconfig>
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62-lp-sk"
+CONFIG_OF_UPSTREAM=y
diff --git a/configs/am62x_lp_sk_r5_defconfig b/configs/am62x_lp_sk_r5_defconfig
new file mode 100644
index 0000000000000..93b3922e6fec5
--- /dev/null
+++ b/configs/am62x_lp_sk_r5_defconfig
@@ -0,0 +1,2 @@
+#include <configs/am62x_evm_r5_defconfig>
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-lp-sk"

-- 
2.43.2

