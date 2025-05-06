Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC54C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 10:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9C482169;
	Tue,  6 May 2025 12:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ahpf27mX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DB48272A; Tue,  6 May 2025 12:42:27 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D388288D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 12:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546AgKZl482325
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 05:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746528140;
 bh=3YMJe7oLU7BZT9JXNzqnsuLJQrIzLuGgBibZAkvJ6+w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ahpf27mXqxzPOOCFSLTj3LUC0qqDEt1ed+i7ZzXot6HXCxANAaDsVmJfQBfcnEWkv
 Hxr2G/SsCUyGmoXJqquAsQKL8wxpjTPfTeAUoYtvQQ++X7Yh9a/EWtnfjP/QPMx1qK
 vIHukFmsGh2JboKqmJFGcq6qlTxyHj4XqSpCk8SE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546AgKqu018585
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 05:42:20 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 05:42:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 05:42:19 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546Ag2uV103095;
 Tue, 6 May 2025 05:42:14 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <afd@ti.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 2/7] spl: Use FIT data address as fallback when 'load'
 property is absent
Date: Tue, 6 May 2025 16:11:57 +0530
Message-ID: <20250506104202.16741-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506104202.16741-1-b-padhi@ti.com>
References: <20250506104202.16741-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

In cases where the 'load' property is not defined in a FIT image node,
fallback to using the data address returned by `fit_image_get_data()`.
This enables FIT images to omit the 'load' property during FIT creation.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v2: Changelog:
1. New patch. Add support to load images without 'load' property.

 common/spl/spl_fit.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 86506d6905c..bf26f96c77b 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -742,6 +742,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 {
 	struct spl_image_info image_info;
 	struct spl_fit_info ctx;
+	const void *fit_image_loadaddr;
+	size_t fit_image_size;
 	int node = -1;
 	int ret;
 	int index = 0;
@@ -832,7 +834,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		if (firmware_node == node)
 			continue;
 
-		image_info.load_addr = 0;
+		/*
+		 * If the 'load' property is not present in the image node,
+		 * use the FIT image's data address as the fallback load
+		 * address. This allows flexibility in omitting the load address
+		 * during FIT creation time.
+		 */
+		ret = fit_image_get_data(ctx.fit, node,
+					 &fit_image_loadaddr, &fit_image_size);
+		if (ret < 0)
+			panic("Error accessing node = %d in FIT (%d)\n", node,
+			      ret);
+
+		image_info.load_addr = (ulong)fit_image_loadaddr;
 		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
 		if (ret < 0 && ret != -EPERM) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
-- 
2.34.1

