Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9591E810DA
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026D086DC3;
	Wed, 27 Sep 2023 14:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695818692;
	bh=bU3GTze++gST0wdvHMclEVODFjEn76nk82xtA++toEA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=puo0gDHtaMAZKnnZJU2OKosY8W8hT/M+e85KT7TvKI0XpIeM0uHeH9YmlvPd73VRO
	 FEVC8/gMFkJsNxuJZYm7kmrpVSdmn6SzuyRgsfViy/kNLRYudJDKJOvLI3GR7orQnW
	 2b9V8Ku0m8ohUWT4Rp35EU846YDtbyjvyiRzoerrfpphVJb4iKGbumq3xap9glQE+L
	 /SldLpYdl/qkQm7OUnQyow2fKE9b66N29R78wJc56SeHPDmhJqayXGqKwkX+7PgbVa
	 AuVUeUGXDKaK2lQ05ps7XHaC0tjbJhnB5rP0HgAwC13zLtIgFL5zxthHXv7wMiD5O3
	 GVzPThmAQeyAw==
Received: from maia.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hws@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2E42C86D59;
 Wed, 27 Sep 2023 14:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695818690;
 bh=bU3GTze++gST0wdvHMclEVODFjEn76nk82xtA++toEA=;
 h=From:To:Cc:Subject:Date:From;
 b=gNSlkDtWL8+tZBC+j0X/ggB2we8l3i0WUItAapyNqwn6A1Oaoy9FSXqy3IcXVAzfj
 QIRy5Y4Qkp4oK29cYJl54ispK/1AQkC3boSPBSEWa79pd51NWwbeb8Si6aWZA0vXzj
 NM+4FeJPfl42S4VjOG8RaTrq9guxzN9J9/wHGDIYrYiprvFk1Gwb21HbfvbJg/2uKS
 QCeVLG+lhQ/h6M07gdiWMRGrmvBX4g95SVKGRRvnCrJdKXAQuRLqa598bU6P2pHRZo
 PBOVJfUsbh7+QezqxljF2XF+N61JBMIY4dVQJuqzH3WST0z+GK735rsJYImwCdS4Wy
 4tXwcqByEzC4A==
From: Harald Seiler <hws@denx.de>
To: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Harald Seiler <hws@denx.de>
Subject: [PATCH 1/2] ram: stm32mp1: Only print RAM config with
 CONFIG_SPL_DISPLAY_PRINT
Date: Wed, 27 Sep 2023 14:44:40 +0200
Message-ID: <20230927124440.247726-1-hws@denx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

Ensure that the RAM configuration line is only printed when
CONFIG_SPL_DISPLAY_PRINT is set.

Signed-off-by: Harald Seiler <hws@denx.de>
---
 drivers/ram/stm32mp1/stm32mp1_ram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ram/stm32mp1/stm32mp1_ram.c b/drivers/ram/stm32mp1/stm32mp1_ram.c
index a6c19af9722..2808d07c3ae 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ram.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ram.c
@@ -126,7 +126,8 @@ static int stm32mp1_ddr_setup(struct udevice *dev)
 		dev_dbg(dev, "no st,mem-name\n");
 		return -EINVAL;
 	}
-	printf("RAM: %s\n", config.info.name);
+	if (CONFIG_IS_ENABLED(DISPLAY_PRINT))
+		printf("RAM: %s\n", config.info.name);
 
 	for (idx = 0; idx < ARRAY_SIZE(param); idx++) {
 		ret = ofnode_read_u32_array(node, param[idx].name,
-- 
2.41.0

