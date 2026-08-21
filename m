Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ABEC5DF92
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 09:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 177A6608BA;
	Fri, 21 Aug 2026 09:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdvDkhAit8Wz; Fri, 21 Aug 2026 09:30:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787304618;
	bh=L6asGVw1+PnHQu73KRGI8b81kH8oFvnkth5g8A8LHpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hZO8BrwEKVFKbmdNoJKBTWd/WCR2FVgnoDLJB5Er+6m+QbmSyHDoGINJy6Uz9qng0
	 vxzZFiKnMOrZ9qazHYeJRicoy+yWRO88n1cj81R0C4XyYD68KgpJgyQQRChUzcYaN0
	 eeBQ+tNOQgvac+GOP7ng/rj7H3De0+Mw723gdObTwxzNbV7SaL3UsopL66YhMJRXfZ
	 oSWvAQmcAp6r7Cr/NwWAPkz5KrBwpmcjdfTMUNTKidjfhDPPPv08i0Z93yrk1TTGrU
	 SaruPev3Xfyqdvmg9Wzhkh/WULWpBupbYaMCDSVAND6BdjjKlPfBStgiyTZ0bfOVqB
	 73OgEX4MOlU8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D686960A5A;
	Fri, 21 Aug 2026 09:30:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 036D8263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDC9140912
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6MxwZyYg7qR for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 09:30:12 +0000 (UTC)
X-Greylist: delayed 60 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 09:30:11 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=QwPvlSPl
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-294854-20260821092903bcb2b30b71000207c3-htzsfd@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F31F40930
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:11 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260821092903bcb2b30b71000207c3
 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 11:29:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=L6asGVw1+PnHQu73KRGI8b81kH8oFvnkth5g8A8LHpQ=;
 b=QwPvlSPl7BtfxlvedBRmvlWhSlpZJgs5ZzSoJEkfAqXuV7K0kC+BME7/e4DQOGQUDVlU6h
 Ntt7gumT6oV0zCV8VSS6PIE98UJrK7ocsnam3xlThCW4tP+yR8+xsF8Ds+ZarmrA3fl/yDnK
 HnFBprWSP20hPfupo6YjCQDko4zfEVI9j2D8cxs/87rzKWXcFfVxk93D6FGYqABKhaSS8E/b
 ry/YK1yAAQb8wkvVNTIkjdXCyQd1BhKbQXv9MpGD5SHquQnsUru/qIH+dkHQp1qHYot39nDc
 n/NysEEjx/GgeLckVn7aAW6ClWLH65xUtVLUI3vg1gE5FFPnlAZIlwbA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/4] mmc: Call back to optee after a successful mmc_init
Date: Fri, 21 Aug 2026 11:29:00 +0200
Message-ID: <a95292a0b1dc11096c34916c020173f1671c492b.1787304541.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787304541.git.jan.kiszka@siemens.com>
References: <cover.1787304541.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This is needed to that OP-TEE can re-enumerate services which need RPMB
access that may have become available now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Peng Fan <peng.fan@nxp.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 670e92ee12b..2463e50cd3c 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -27,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <div64.h>
+#include <tee/optee.h>
 #include "mmc_private.h"
 
 #define DEFAULT_CMD6_TIMEOUT_MS  500
@@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
 				mmc->cfg->name);
 	}
 
+	if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
+		optee_rpmb_available();
+
 	return err;
 }
 
-- 
2.47.3

