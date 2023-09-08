Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABD7EE8006
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2BB886B11;
	Fri,  8 Sep 2023 16:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OWFlElNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492A486A2A; Fri,  8 Sep 2023 13:06:59 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5CF86410
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388B6mLc118599;
 Fri, 8 Sep 2023 06:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694171208;
 bh=okUThkDPJvaH6+eYFNIniqDXcDIRMbg5I5LLjbM5tVs=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=OWFlElNAScRL1lGsWlZ9nhYD1ODnlhRgxhyFjmly+40+zxPID32Ox2g0T6C8jEbus
 Jq+lBB5ubAh1SIhOP4xhwFw+yYQqF31ElDQAeWLOqqrkm6cC+RNyQAVtRzfiai76bZ
 Zx5P2K0UyHuhdmog7BayG0onjPW7Fii+kAFCPlkk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388B6mE9094506
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:06:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:06:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:06:48 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388B5qEK018063;
 Fri, 8 Sep 2023 06:06:41 -0500
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
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jason
 Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v3 07/16] remoteproc: k3-dsp: Extend support for C71x DSPs on
 J784S4 SoCs
Date: Fri, 8 Sep 2023 16:35:42 +0530
Message-ID: <20230908110551.861575-8-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908110551.861575-1-a-nandan@ti.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 08 Sep 2023 16:01:41 +0200
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

The K3 J784S4 SoCs have four C71x DSP subsystems in MAIN voltage domain
The C71x DSPs are 64 bit machine with fixed and floating point DSP
operations. The C71x DSP subsystem is a slighly updated version of the
C71x DSP subsystem on J721e. And, same ip data can be used for J7200,
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

