Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0242BCDB483
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ACA086F5B;
	Thu, 19 Oct 2023 16:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D393886FDE; Thu, 19 Oct 2023 16:50:51 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id C76FF86F56
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,237,1694703600"; d="scan'208";a="179877285"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 19 Oct 2023 23:50:46 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.46])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79E0F42714BF;
 Thu, 19 Oct 2023 23:50:44 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH] mmc: renesas-sdhi: Fix error handling in rzg2l_sdhi_setup
Date: Thu, 19 Oct 2023 15:50:38 +0100
Message-Id: <20231019145038.14701-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
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

We should ensure that reset_free() is called in the error path.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Fixes: 93c811b7331b ("mmc: renesas-sdhi: Initialize module on RZ/G2L")
---
 drivers/mmc/renesas-sdhi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 1ea6e1066f2b..865efdd32184 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -998,7 +998,7 @@ static int rzg2l_sdhi_setup(struct udevice *dev)
 	ret = reset_get_by_index(dev, 0, &rst);
 	if (ret < 0) {
 		dev_err(dev, "failed to get reset line\n");
-		goto err_reset;
+		goto err_get_reset;
 	}
 
 	ret = reset_deassert(&rst);
@@ -1016,6 +1016,8 @@ static int rzg2l_sdhi_setup(struct udevice *dev)
 err_tmio_probe:
 	reset_assert(&rst);
 err_reset:
+	reset_free(&rst);
+err_get_reset:
 	clk_disable(&aclk);
 err_aclk:
 	clk_disable(&imclk2);

base-commit: 9a0cf3993f71043ba08c315572c54622de42d447
-- 
2.39.2

