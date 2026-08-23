Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A778C5DF9B
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A56EB80D6E;
	Sun, 23 Aug 2026 19:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAzJuIDofinG; Sun, 23 Aug 2026 19:48:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787514521;
	bh=L6asGVw1+PnHQu73KRGI8b81kH8oFvnkth5g8A8LHpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zR0rYsg7A+Mse2c45PWuwl/8Z1eZ68FdZ7bIMZlsa9eVqjWDMiJg4Tg/7jvoD+cWG
	 6y3ClBembp1o7mtl/z8PC53NWb2utoKspRqtkE2+V4mOltKONIY4cJDFCqnibrhPLk
	 n0/dtxc21SMfs+eD0foPn5GWZYadT235HIjsZtN4K83TlYvbyUjCKVN1em8Q4RaboO
	 b4fvyNt2ceLRq92cjmMlMeTrX6Q7zTnQK9H1cobbhJNuYjE8aGRn0IiDmnUDxQ3Z6a
	 jswT7JtJUx0KP3M0XAwTG0kTuKd60xk3IsExKlq8SwYyLsiz3xdg6RU8WUUZZ42uJ6
	 AF+5/mSVdgdBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2494980B20;
	Sun, 23 Aug 2026 19:48:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F16D279
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15F1A4055B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ozqskuO9FbaW for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:48:37 +0000 (UTC)
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 23 Aug 2026 19:48:34 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=felu6HIA
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.228;
 helo=mta-65-228.siemens.flowmailer.net;
 envelope-from=fm-294854-202608231947282d1235d9220002078d-wsgjnd@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 763B240533
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:34 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 202608231947282d1235d9220002078d
 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 21:47:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=L6asGVw1+PnHQu73KRGI8b81kH8oFvnkth5g8A8LHpQ=;
 b=felu6HIAHDam+q//x659naCUpVYvJfXlqQ3t2qPC3Yo5kRAuPyntbqcfgADC8E7BPv5Xou
 uYEDbGIU0VZdZKMSjEB08lZKh9PUH3UEuU4nXh9VzCg4sPVwgxp3VEVvhqNrHZqc4CObPrXB
 iFHfIMdIBJlEb3QYRcKgLciRlT48q5eFf0gxpxkwSuRz3kAhz+R+XW4s6Ba4s7B3qV6jy748
 t6ZsbrinN3De8VjJPR5FPDwnx+WqS8a37+eoTxaNgBL0aZfIVPPg3zDZkUXN5pzAnIxLSulH
 c2gjTaa9OAimzjfTV7ocO1ylmssttnpo9n3VHVcQas1cG5frBhfEvJCw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 4/5] mmc: Call back to optee after a successful mmc_init
Date: Sun, 23 Aug 2026 21:47:25 +0200
Message-ID: <ddef88ae1677f4c9b793252483f23eae900b89d1.1787514446.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787514446.git.jan.kiszka@siemens.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
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

