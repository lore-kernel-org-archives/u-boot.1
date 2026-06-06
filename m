Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2702FCD8C85
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 08:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2BD849BC;
	Sat,  6 Jun 2026 10:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y7wFDZOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C883849CE; Sat,  6 Jun 2026 10:48:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC40284958
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 10:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3246E445E2;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14080C2BCF4;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780735671;
 bh=ZIQTqUgMNPKzd4TSKRep3/i8h1uB3QJWr/9vHdLaEmY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Y7wFDZOvIwMzz6bGsnpaitZvDW+sZFV5HENA0Nmez4+TkC+KuTVbevR53jWnoLaCO
 p8Vt9+pZpLL8ai2prfuCqoWBsYBDTopRtL3IcQoZRQr+QupjiISx2hBUNDpaP1AWxw
 AEaEW5sbOkX/Afk3PE4sqxnekXZSlpeIvmKP8D7+dt7hKa5gzQPF7tP4ieYixlTyBQ
 1PAawPJUZYNk+gDzFpP52JihLnRBEXpusrih94cQhvpaonN3blnPvLCehBgZkxQDj5
 gl65KxpdoQg/TFohF0IWz61JCMrR8ZT/q/ORf8j7+D2orxdddAIfElkhEIfdNJLKey
 gLyNknC6KNURg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD02CD8C8E;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 18:47:36 +1000
Subject: [PATCH 05/11] sysreset: qcom-pshold: PM8916 PON reset type support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-pm8916-pon-v1-5-170c9cbe5099@samcday.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780735669; l=1606;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=lMO6yWOp/proHsUHO0eKk6GQnq/J24pQ78nHP3WriT8=;
 b=pCuRpkfL2dEQ4kuRHwatlVXeoKfJbeI5zV48QE5bh2H6VF/r0//T9Lhs1ftNiDofw+Zq1AIJD
 WtZxteJJWTEDNLX3LXLxKPT6r5+2ng2a+BXASQBHbSSmLmh0LK3Aa3R
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

Before de-asserting PS_HOLD, PM8916 PMIC can be informed of what kind of
reset should take place.

This might seem a little hacky/weird, but it's a byproduct of how the DT
nodes are structured, and the way u-boot handles sysreset.

The qcom,pshold node does not belong to the PMIC hierarchy. If U-Boot's
sysreset infra was a little more flexible, we might be able to model the
qcom,pm8916-pon driver as UCLASS_SYSRESET in order to catch the sysreset
type and set the appropriate bits in the PMIC, before chaining to the
pshold driver to de-assert PS_HOLD (which actually triggers the reset
type that was written in the previous step).

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/sysreset/sysreset_qcom-pshold.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
index 45290478536..20ddb4ae4ec 100644
--- a/drivers/sysreset/sysreset_qcom-pshold.c
+++ b/drivers/sysreset/sysreset_qcom-pshold.c
@@ -13,6 +13,8 @@
 #include <sysreset.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <dm/device_compat.h>
+#include "pm8916_pon.h"
 
 struct qcom_pshold_priv {
 	phys_addr_t base;
@@ -22,6 +24,13 @@ static int qcom_pshold_request(struct udevice *dev, enum sysreset_t type)
 {
 	struct qcom_pshold_priv *priv = dev_get_priv(dev);
 
+	if (CONFIG_IS_ENABLED(PM8916_PON)) {
+		int ret = pm8916_pon_set_reboot_type(type);
+
+		if (ret)
+			dev_err(dev, "Failed to set reboot type: %d\n", ret);
+	}
+
 	writel(0, priv->base);
 	mdelay(10000);
 

-- 
2.54.0


