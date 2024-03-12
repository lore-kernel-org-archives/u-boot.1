Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E08EC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B46F787F34;
	Tue, 12 Mar 2024 10:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a97Wldi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD44F87F34; Tue, 12 Mar 2024 10:44:49 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7382787F2D
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42C9ijLf108310;
 Tue, 12 Mar 2024 04:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710236685;
 bh=+cwsULfOeCVH84daddKDEpLxLJ4FydOT1/cJ0VPndFA=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=a97Wldi606J4aIgsVCMaFtVDBO5iMQ7mnFS3AtPWSa1qpoEe6rQU5o+MwG7WHy2Je
 +pNAqF0jjasmmwbIVqoBPKzrgKKh6esxCJVfe7DX4hUkD6BG+AMnxe2VdmrpSwUVZf
 79AMbxhRanIlDBmIwAUg+Z/A9rMzprvFvzp1VfNM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42C9ijkJ012516
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 04:44:45 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 04:44:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 04:44:45 -0500
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.69.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42C9ibb3063791;
 Tue, 12 Mar 2024 04:44:43 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Udit Kumar <u-kumar1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 2/2] remoteproc: k3-dsp: Extend support for C71x DSPs on
 J721S2 SoCs
Date: Tue, 12 Mar 2024 15:14:36 +0530
Message-ID: <20240312094436.2959542-3-a-nandan@ti.com>
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

The K3 J721S2 SoCs have two C71x DSP subsystems in MAIN voltage domain,
and there are no C66x DSP subsystems on these SoCs. The C71x DSP subsystem
is a slighly updated version of the C71x DSP subsystem on J721e. The
C71x DSPs are 64 bit machine with fixed and floating point DSP
operations.

Extend support to the C71x DSPs with J721S2 compatible strings.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_rproc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index 1c6515f9ab7..611d8434aeb 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -338,7 +338,8 @@ static int k3_dsp_of_get_memories(struct udevice *dev)
 
 	for (i = 0; i < dsp->num_mems; i++) {
 		/* C71 cores only have a L1P Cache, there are no L1P SRAMs */
-		if (device_is_compatible(dev, "ti,j721e-c71-dsp") &&
+		if (((device_is_compatible(dev, "ti,j721e-c71-dsp")) ||
+		     (device_is_compatible(dev, "ti,j721s2-c71-dsp"))) &&
 		    !strcmp(mem_names[i], "l1pram")) {
 			dsp->mem[i].bus_addr = FDT_ADDR_T_NONE;
 			dsp->mem[i].dev_addr = FDT_ADDR_T_NONE;
@@ -457,6 +458,7 @@ static const struct k3_dsp_boot_data c71_data = {
 static const struct udevice_id k3_dsp_ids[] = {
 	{ .compatible = "ti,j721e-c66-dsp", .data = (ulong)&c66_data, },
 	{ .compatible = "ti,j721e-c71-dsp", .data = (ulong)&c71_data, },
+	{ .compatible = "ti,j721s2-c71-dsp", .data = (ulong)&c71_data, },
 	{}
 };
 
-- 
2.34.1

