Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E46C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6402388103;
	Thu,  9 May 2024 16:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l92rnND0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 009C188080; Thu,  9 May 2024 16:20:49 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE39388096
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449EKkS5124651;
 Thu, 9 May 2024 09:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715264446;
 bh=g+1ymPdExZv5CEptvkSLjDQ8COuZe+xVSSpxyOGgjac=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=l92rnND0pk/xaA+vGEsWS9B0PLu6Ks0ZDhkcRAKN4GgsmK8xGQS9ocQyp6BRzUDN8
 FL0wBu83CmSXEbkZ01YHFwHBD+n9s5E7xn9syTBgZVYqsgoYgbuzVvQSqxGLexmgQV
 bb2J17SpubQah/siEGHm9mnMOsmD8OT4Qjg8Pm7U=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449EKkhE126190
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 09:20:46 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 09:20:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 09:20:46 -0500
Received: from localhost ([10.250.32.135])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449EKjlU075502;
 Thu, 9 May 2024 09:20:45 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <devarsht@ti.com>, <afd@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [PATCH 4/4] board: ti: am62ax: Add support for remote proc load
Date: Thu, 9 May 2024 09:20:37 -0500
Message-ID: <20240509142037.32064-5-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240509142037.32064-1-hnagalla@ti.com>
References: <20240509142037.32064-1-hnagalla@ti.com>
MIME-Version: 1.0
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

Add AM62a remote proc firmware names to environment variables for
loading of C7x DSP and R5F processors.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 board/ti/am62ax/am62ax.env | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
index 334374abb7..97122fb57b 100644
--- a/board/ti/am62ax/am62ax.env
+++ b/board/ti/am62ax/am62ax.env
@@ -1,5 +1,8 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
 
 name_kern=Image
 console=ttyS2,115200n8
@@ -27,3 +30,4 @@ get_kern_mmc=load mmc ${bootpart} ${loadaddr}
 get_fit_mmc=load mmc ${bootpart} ${addr_fit}
 	${bootdir}/${name_fit}
 partitions=name=rootfs,start=0,size=-,uuid=${uuid_gpt_rootfs}
+rproc_fw_binaries= 0 /lib/firmware/am62a-mcu-r5f0_0-fw 1 /lib/firmware/am62a-c71_0-fw
-- 
2.34.1

