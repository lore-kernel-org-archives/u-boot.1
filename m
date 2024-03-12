Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A2C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5243D87F1C;
	Tue, 12 Mar 2024 10:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WKeHx+jZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D0387F2F; Tue, 12 Mar 2024 10:44:47 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B64587D9D
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42C9igfA108304;
 Tue, 12 Mar 2024 04:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710236682;
 bh=BmqmPbom6pAj8YLAqsGeK5kZrLHvuT/Qbx7i7037LbA=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=WKeHx+jZcDML8TKansCF6J+u7M+zwmMwNMDh1CXVUdrq/gjGs9CMF1E1XxCNCs7XS
 RFGQnPdWcxmxV0H6RQN1R5oDRC1OFWksvrLEqKdXIUAO+YnmHbSClCeTS9RO6W8/B0
 +Efh12txsb4vg3sN+wx9VsN5WvMlR42GHaM1SFcs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42C9igAF003696
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 04:44:42 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 04:44:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 04:44:42 -0500
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.69.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42C9ibb2063791;
 Tue, 12 Mar 2024 04:44:40 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Udit Kumar <u-kumar1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 1/2] remoteproc: k3-r5: Extend support for R5F clusters on
 J721S2 SoCs
Date: Tue, 12 Mar 2024 15:14:35 +0530
Message-ID: <20240312094436.2959542-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312094436.2959542-1-a-nandan@ti.com>
References: <20240312094436.2959542-1-a-nandan@ti.com>
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

From: Hari Nagalla <hnagalla@ti.com>

The K3 J721S2 SoCs have three dual-core R5F subsystems, one in MCU
voltage domain and the other two in MAIN voltage domain. These R5F
clusters are similar to the R5F clusters in J7200 SoCs.

Compatible Info is updated to support J721S2 SoCs.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/remoteproc/ti_k3_r5f_rproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 6f3e12d915e..631e548dcce 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -855,7 +855,7 @@ static const struct k3_r5f_ip_data k3_data = {
 	.tcm_ecc_autoinit = false,
 };
 
-static const struct k3_r5f_ip_data j7200_data = {
+static const struct k3_r5f_ip_data j7200_j721s2_data = {
 	.tcm_is_double = true,
 	.tcm_ecc_autoinit = true,
 };
@@ -863,7 +863,8 @@ static const struct k3_r5f_ip_data j7200_data = {
 static const struct udevice_id k3_r5f_rproc_ids[] = {
 	{ .compatible = "ti,am654-r5f", .data = (ulong)&k3_data, },
 	{ .compatible = "ti,j721e-r5f", .data = (ulong)&k3_data, },
-	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_data, },
+	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_j721s2_data, },
+	{ .compatible = "ti,j721s2-r5f", .data = (ulong)&j7200_j721s2_data, },
 	{}
 };
 
@@ -901,6 +902,7 @@ static const struct udevice_id k3_r5fss_ids[] = {
 	{ .compatible = "ti,am654-r5fss"},
 	{ .compatible = "ti,j721e-r5fss"},
 	{ .compatible = "ti,j7200-r5fss"},
+	{ .compatible = "ti,j721s2-r5fss"},
 	{}
 };
 
-- 
2.34.1

