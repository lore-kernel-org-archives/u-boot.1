Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3148E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 20:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0404A801CE;
	Tue, 17 Dec 2024 21:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TodZsECg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52D6801CE; Tue, 17 Dec 2024 21:48:53 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F056F8022E
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 21:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHKmfpC057022
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 14:48:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734468521;
 bh=pfGuIOXelj928wZblMAdqu8uYaC1YOD34vOA5CP4m+0=;
 h=From:To:CC:Subject:Date;
 b=TodZsECgbOGovQOIRj/Xbj/VPmrIkUJvpyjr6KT7ph+6YTHvnVKWFmT91jP85LBwi
 tNrLwGDRr0RRohNmYmGRVl4JfBsoNTl3axzKmZo81ee8DtDc4j6KECEopo6bffgqL+
 9qOHyIoFTdaBfqVI2Su1mfatabBN4sImxwW5HiQs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHKmfJi069580
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Dec 2024 14:48:41 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 14:48:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 14:48:41 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHKmf9E096999;
 Tue, 17 Dec 2024 14:48:41 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Caleb Connolly
 <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH] dfu: Prevent set_dfu_alt_info() from overwriting a previous
 value
Date: Tue, 17 Dec 2024 14:48:35 -0600
Message-ID: <20241217204835.3312765-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
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

If CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment
variable is dynamically set when initializing the DFU entities, which is
done as part of normal flow of a DFU operation.

The USB DFU boot support will set it's own specific value for dfu_alt_info
before performing the DFU operation. This means that if
CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment variable
that the USB DFU boot path had set is overwritten, causing USB DFU boot to
fail.

Likewise, if the user sets their own value for dfu_alt_info, say at the
U-Boot prompt, it get's overwritten if CONFIG_SET_DFU_ALT_INFO is enabled.

This patch will first check that dfu_alt_info isn't already set before
calling set_dfu_alt_info(), when CONFIG_SET_DFU_ALT_INFO is enabled.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 drivers/dfu/dfu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
index 756569217bb..ab8abae1d89 100644
--- a/drivers/dfu/dfu.c
+++ b/drivers/dfu/dfu.c
@@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface, char *devstr)
 	dfu_reinit_needed = false;
 	dfu_alt_info_changed = false;
 
+	str_env = env_get("dfu_alt_info");
 #ifdef CONFIG_SET_DFU_ALT_INFO
-	set_dfu_alt_info(interface, devstr);
+	if (!str_env) {
+		set_dfu_alt_info(interface, devstr);
+		str_env = env_get("dfu_alt_info");
+	}
 #endif
-	str_env = env_get("dfu_alt_info");
 	if (!str_env) {
 		pr_err("\"dfu_alt_info\" env variable not defined!\n");
 		return -EINVAL;
-- 
2.34.1

