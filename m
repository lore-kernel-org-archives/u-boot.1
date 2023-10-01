Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF76E748E9
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 16:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE969870B6;
	Sun,  1 Oct 2023 18:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IBY+isKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3560F86D1E; Sun,  1 Oct 2023 18:57:01 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29FB3870B2
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 18:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 391GuoBx016948;
 Sun, 1 Oct 2023 11:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696179410;
 bh=LkmedknQjDqkkoDks1tvJVEX8RLTzX371OIQDDcN2bk=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=IBY+isKqG3WcrnAapMdtNkgE/xCeJI9WhcUUOgOqBqATxOb2VWlftyAIJ0XwTdWzm
 sSox7InknBhLjlfVQ0ikNtZH6u5z89U40Y3shpzrKTBx4cEvx/kLjYki+n/Brk8fp4
 mJh5en9huqgOm4++ixquDeHgISyzvo5MqCCJwAhw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 391GuoeY025784
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 1 Oct 2023 11:56:50 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Oct 2023 11:56:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Oct 2023 11:56:50 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 391GtkAV002403;
 Sun, 1 Oct 2023 11:56:43 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v4 08/16] remoteproc: k3-dsp: Extend support for C71x DSPs on
 J784S4 SoCs
Date: Sun, 1 Oct 2023 22:25:37 +0530
Message-ID: <20231001165545.494212-9-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001165545.494212-1-a-nandan@ti.com>
References: <20231001165545.494212-1-a-nandan@ti.com>
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

The K3 J784S4 SoC has four C71x DSP subsystems in MAIN voltage domain.
The C71x DSPs are 64 bit machine with fixed and floating point DSP
operations. The C71x DSP subsystem is a slightly updated version of the
C71x DSP subsystem on J721E. And, same IP data can be used for J7200,
J721S2 and J784S4.

Extend support to the C71x DSPs for J784S4 with J721S2 compatible
string.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_rproc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index 1a2e9dd1f5..d856e31db8 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -327,7 +327,8 @@ static int k3_dsp_of_get_memories(struct udevice *dev)
 
 	for (i = 0; i < dsp->num_mems; i++) {
 		/* C71 cores only have a L1P Cache, there are no L1P SRAMs */
-		if (device_is_compatible(dev, "ti,j721e-c71-dsp") &&
+		if (((device_is_compatible(dev, "ti,j721e-c71-dsp")) ||
+		     (device_is_compatible(dev, "ti,j721s2-c71-dsp"))) &&
 		    !strcmp(mem_names[i], "l1pram")) {
 			dsp->mem[i].bus_addr = FDT_ADDR_T_NONE;
 			dsp->mem[i].dev_addr = FDT_ADDR_T_NONE;
@@ -446,6 +447,7 @@ static const struct k3_dsp_boot_data c71_data = {
 static const struct udevice_id k3_dsp_ids[] = {
 	{ .compatible = "ti,j721e-c66-dsp", .data = (ulong)&c66_data, },
 	{ .compatible = "ti,j721e-c71-dsp", .data = (ulong)&c71_data, },
+	{ .compatible = "ti,j721s2-c71-dsp", .data = (ulong)&c71_data, },
 	{}
 };
 
-- 
2.34.1

