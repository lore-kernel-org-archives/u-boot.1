Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AB7C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C2487D3B;
	Wed, 31 Jan 2024 12:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E4Cn1ycd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51DE187796; Wed, 31 Jan 2024 07:02:55 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1198587887
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V62pdD071551;
 Wed, 31 Jan 2024 00:02:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706680971;
 bh=69EdrZN8c/XQny67pyA+CxcHVkxKqqXId2ZpbfMHvmE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=E4Cn1ycdBSd7FaSlI/wWoJ1fp1Bw7Rnb8a4A0j83ydEfezF6x82BIU2ckZTH7xfAJ
 0LI0CSE1sAiqFZJ+ufo77XuaqIjdA9hb2MsUfkesL1pldaQVmdBSBg1mb7gniORUwc
 sRwxlJw6tG+f/6ZlSQqiWvpzb94Fu1Wwpbm0qlGI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V62p4E002320
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 00:02:51 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 00:02:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 00:02:50 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V62Utk062916;
 Wed, 31 Jan 2024 00:02:49 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 10/10] arm: dts: k3-am62a-ddr: Add ss_cfg reg entry
Date: Wed, 31 Jan 2024 11:32:13 +0530
Message-ID: <20240131060213.1128024-11-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131060213.1128024-1-s-k6@ti.com>
References: <20240131060213.1128024-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 31 Jan 2024 12:44:04 +0100
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

Add ss_cfg memory region which maps the DDRSS configuration region
for the memory controller node.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am62a-ddr.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/k3-am62a-ddr.dtsi b/arch/arm/dts/k3-am62a-ddr.dtsi
index 8629ea45b847..42e41f78505a 100644
--- a/arch/arm/dts/k3-am62a-ddr.dtsi
+++ b/arch/arm/dts/k3-am62a-ddr.dtsi
@@ -4,11 +4,12 @@
  */
 
 / {
-	memorycontroller: memory-controller@f308000 {
+	memorycontroller: memory-controller@f300000 {
 		compatible = "ti,am62a-ddrss";
 		reg = <0x00 0x0f308000 0x00 0x4000>,
-		      <0x00 0x43014000 0x00 0x100>;
-		reg-names = "cfg", "ctrl_mmr_lp4";
+		      <0x00 0x43014000 0x00 0x100>,
+		      <0x00 0x0f300000 0x00 0x200>;
+		reg-names = "cfg", "ctrl_mmr_lp4", "ss_cfg";
 		ti,ddr-freq1 = <DDRSS_PLL_FREQUENCY_1>;
 		ti,ddr-freq2 = <DDRSS_PLL_FREQUENCY_2>;
 		ti,ddr-fhs-cnt = <DDRSS_PLL_FHS_CNT>;
-- 
2.34.1

