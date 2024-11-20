Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC272D44171
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BAF088D1C;
	Wed, 20 Nov 2024 10:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF49E89678; Wed, 20 Nov 2024 10:48:57 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id C3702895BD
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: lII46ZM7TMaaCf40Zn+msA==
X-CSE-MsgGUID: KPZWqTtlTwS4/j2a4WR76g==
X-IronPort-AV: E=Sophos;i="6.12,169,1728918000"; d="scan'208";a="225420114"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2024 18:48:52 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.28])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 630EE41A5E7B;
 Wed, 20 Nov 2024 18:48:40 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/3] pinctrl: rzg2l: Drop unnecessary scope
Date: Wed, 20 Nov 2024 09:48:30 +0000
Message-Id: <20241120094830.71-3-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241120094830.71-1-paul.barker.ct@bp.renesas.com>
References: <20241120094830.71-1-paul.barker.ct@bp.renesas.com>
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

In rzg2l_pinconf_set(), there are no new variables defined in the case
statement for PIN_CONFIG_INPUT_ENABLE so no additional scope is needed.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Changes v1->v2:
  - Split out of series adding RZ/G2L Ethernet support [1]
  - Added Marek's Reviewed-by tag

[1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/

 drivers/pinctrl/renesas/rzg2l-pfc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
index af371bd0ff1e..3c751e9473a5 100644
--- a/drivers/pinctrl/renesas/rzg2l-pfc.c
+++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
@@ -381,7 +381,7 @@ static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	}
 
 	switch (param) {
-	case PIN_CONFIG_INPUT_ENABLE: {
+	case PIN_CONFIG_INPUT_ENABLE:
 		if (!(cfg & PIN_CFG_IEN)) {
 			dev_err(dev, "pin does not support IEN\n");
 			return -EINVAL;
@@ -391,7 +391,6 @@ static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			port_offset, pin, argument);
 		rzg2l_rmw_pin_config(data, IEN(port_offset), pin, IEN_MASK, !!argument);
 		break;
-	}
 
 	case PIN_CONFIG_POWER_SOURCE: {
 		bool support_2500 = false;
-- 
2.43.0

