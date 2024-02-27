Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A2AC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 20:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5A68803A;
	Tue, 27 Feb 2024 21:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220FE8800A; Tue, 27 Feb 2024 21:41:05 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id F1A0D8800F
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 21:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,188,1705330800"; d="scan'208";a="199492148"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2024 05:40:58 +0900
Received: from renesas-deb12.mshome.net (unknown [10.226.92.31])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id CA73A400C4EC;
 Wed, 28 Feb 2024 05:40:56 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v3 7/8] pmic: raa215300: Bind sysreset driver
Date: Tue, 27 Feb 2024 20:40:34 +0000
Message-Id: <20240227204035.3761-8-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227204035.3761-1-paul.barker.ct@bp.renesas.com>
References: <20240227204035.3761-1-paul.barker.ct@bp.renesas.com>
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

If SYSRESET support is enabled for the RAA215300 PMIC, we need to bind
the raa215300_sysreset driver as a child device of the PMIC.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/power/pmic/raa215300.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/pmic/raa215300.c b/drivers/power/pmic/raa215300.c
index b93a0d3a084a..a581a1f6dc15 100644
--- a/drivers/power/pmic/raa215300.c
+++ b/drivers/power/pmic/raa215300.c
@@ -29,6 +29,15 @@ static const struct udevice_id raa215300_ids[] = {
 
 static int raa215300_bind(struct udevice *dev)
 {
+	if (IS_ENABLED(CONFIG_SYSRESET_RAA215300)) {
+		struct driver *drv = lists_driver_lookup_name("raa215300_sysreset");
+		if (!drv)
+			return -ENOENT;
+
+		return device_bind(dev, drv, dev->name, NULL, dev_ofnode(dev),
+				   NULL);
+	}
+
 	return 0;
 }
 
-- 
2.44.0

