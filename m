Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5D2C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 10:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165AA8718E;
	Mon, 27 Nov 2023 11:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bxoENEeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BCB28753C; Mon, 27 Nov 2023 11:29:27 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C1F8718E
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ARATMFe017382;
 Mon, 27 Nov 2023 04:29:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701080962;
 bh=pmGDBi72rT+2auhasubW/eRFNYjlrHYJ48sMucyyzEA=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=bxoENEebZtfsH92vkJ8QDtZa5xH4SaLAT+h6LdC8QYnIDvWAGXZYodR6ji2PvI1XU
 w0U9dsczuHUgI65k8kZxPhEaxzRboE7W5m8rPFRft94cOU3ORN4q1ILYeq2UA2vcgB
 4QvsOq0nr8niX16WJ7Rnyew7TeOFWv1DuMt91GW4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ARATMR6043929
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Nov 2023 04:29:22 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 04:29:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 04:29:22 -0600
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ARATDlc089434;
 Mon, 27 Nov 2023 04:29:20 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 27 Nov 2023 15:59:13 +0530
Subject: [PATCH v2 2/3] remoteproc: k3-dsp: Extend support for C71x DSPs on
 J721S2 SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231127-b4-upstream-j721e-rproc-support-v2-2-22ee7c8ef53c@ti.com>
References: <20231127-b4-upstream-j721e-rproc-support-v2-0-22ee7c8ef53c@ti.com>
In-Reply-To: <20231127-b4-upstream-j721e-rproc-support-v2-0-22ee7c8ef53c@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Hari Nagalla <hnagalla@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701080953; l=1640;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=0BM5etci/NDiFbjmzAiuwnqYEZoJZ1XNHHmOi+0IEY8=;
 b=eQ1u95kdvbH3oNKVbMGThqyaPkfZhO80dvQf72jl81/KBwgXp5eVj1UBMl+91y5WTLEVh8doL
 wN6f0ZSOMsiB+SCLVUTJJOY/3AoHuuT8lgF9tb5jTC6hcEpD5cpLNOh
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

The K3 J721S2 SoCs have two C71x DSP subsystems in MAIN voltage domain,
and there are no C66x DSP subsystems on these SoCs. The C71x DSP subsystem
is a slighly updated version of the C71x DSP subsystem on J721e. The
C71x DSPs are 64 bit machine with fixed and floating point DSP
operations.

Extend support to the C71x DSPs with J721S2 compatible strings.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_rproc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index 576de4bb26e4..749ea2bd6187 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -327,7 +327,8 @@ static int k3_dsp_of_get_memories(struct udevice *dev)
 
 	for (i = 0; i < dsp->num_mems; i++) {
 		/* C71 cores only have a L1P Cache, there are no L1P SRAMs */
-		if (device_is_compatible(dev, "ti,j721e-c71-dsp") &&
+		if (((device_is_compatible(dev, "ti,j721e-c71-dsp")) ||
+		    (device_is_compatible(dev, "ti,j721s2-c71-dsp"))) &&
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
2.41.0

