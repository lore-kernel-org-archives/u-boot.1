Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C42E7E62E
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 12:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D6DD86AEA;
	Tue, 26 Sep 2023 14:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="igM/ncGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED35E86AF7; Tue, 26 Sep 2023 14:43:16 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B418D869BC
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 14:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1695732194; x=1727268194;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pCgvSglAb+9L3x1/pMBysx1135Q1RCbNZ0kFSfjS0LI=;
 b=igM/ncGo5xMxKgQLozfiBMN4OIfFacNvWlCSAOaNVYnDixB3U/6T3lkt
 QBrkWpkWnsVh18/YS5hgLl7vfdEWpkLIeUrAGiT6sFKuM2tvuBNyso/yh
 WhzXpv24xLzgJLM27Wn67W5blDEoYaJEtThSCi318mUom7zm7BdxNq6sU
 zu0A9Wbm4yibA9/yNrl8IkSMX70MQ2XGVyd2KpPgP47yKqRgF/szs96lT
 Cs7IXBxEnfHOEP46fQ+Kq5V1ejtw1wVsrpj6rybKFN4SEmsDEH6jEu9kT
 zDiIGAILIcWBaROlXGyFJIAO1xH4OSQ10m0cxd+D7F8aEREIiwc1X9Ubs A==;
X-IronPort-AV: E=Sophos;i="6.03,177,1694728800"; d="scan'208";a="33152880"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 26 Sep 2023 14:43:14 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 2E541280075;
 Tue, 26 Sep 2023 14:43:14 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>
Cc: Andreas Dannenberg <dannenberg@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] mailbox: k3-sec-proxy: fix error handling for missing scfg in
 FDT
Date: Tue, 26 Sep 2023 14:42:54 +0200
Message-Id: <20230926124254.127465-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The wrong field was checked.

Fixes: f9aa41023bd9 ("mailbox: Introduce K3 Secure Proxy Driver")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mailbox/k3-sec-proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/k3-sec-proxy.c b/drivers/mailbox/k3-sec-proxy.c
index 815808498f2..27072610462 100644
--- a/drivers/mailbox/k3-sec-proxy.c
+++ b/drivers/mailbox/k3-sec-proxy.c
@@ -326,7 +326,7 @@ static int k3_sec_proxy_of_to_priv(struct udevice *dev,
 	}
 
 	spm->scfg = devfdt_get_addr_name(dev, "scfg");
-	if (spm->rt == FDT_ADDR_T_NONE) {
+	if (spm->scfg == FDT_ADDR_T_NONE) {
 		dev_err(dev, "No reg property for Secure Cfg base\n");
 		return -EINVAL;
 	}
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

