Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4160C36001
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 01:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8ACD8082A;
	Sat, 22 Mar 2025 02:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742607901;
	bh=4XhCGRoxHOezEvb26Ot165gcQtetIlM79uWPEDJauMs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IJbWcWxBAR1zdXVbT1AM80uyJnxnoL+RyZ3Yz8WlO98KKLLniteEGoAJ0lLnDH3kJ
	 NBcv65DRXfN/h5UQcMJ0eTvZTTKwZOByi7h1qTtM2ivxqATHXeqTLhajjjY3NrG99P
	 kEgVUmpH0p7dhjjHui+kj7wLLE291bZKJQIO3gNgw+szyRnvFRzheBn1rN3++VHOXt
	 RuzdDQ2igicgVduQcddjW4HnvZDNn4c8bplsBUKzhTwX1g9AWfQM6uwDzrXsMOM68K
	 SpWUg9ucZFAEemY2KPeeoGIK3OVGsoDWf+9fuoDo8AUqpW8NNo5DCfyrpjeL3yWaYQ
	 mRqsKjtDzkKkw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE52D808A2; Sat, 22 Mar 2025 02:45:00 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85B67806FC
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 02:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BrdYIjnc"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8E657101E8F43; Sat, 22 Mar 2025 02:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742607896; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=4XhCGRoxHOezEvb26Ot165gcQtetIlM79uWPEDJauMs=;
 b=BrdYIjncbf8nbUW3sKb14Npx5ZuGIO1xQ/zfoPkz6xJfbZHIFfnkANj7N2cZ9zuUOd9gS5
 8ofAp5HypbzBF5Mm+6NyTtS0IWlW5T4E0p9rPpWy+5mvzanLGoxTeIuzVlNpORdBULKj+K
 /rFBl+21460ysy1+WA1jfIzRynxTEagznHLmSUgFJPw/8mGeTL9E6dqzQ5x19YWH7wNnhg
 VB5/Rv2PnDYp1zYFOobp2Nk9KMD0E2z7+VG27d25/d8lpZyzXqT91uy/12MZJ6iZulmN7k
 A5/FQpxVyJjTtdPRYuq50zTM30pmI06uBIY+VgoY6N65/xEv6zgopW7+MTgxgw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] power: regulator: scmi: Move regulator subnode hack to
 scmi_regulator
Date: Sat, 22 Mar 2025 02:44:40 +0100
Message-ID: <20250322014444.174796-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The current code attempts to bind scmi_voltage_domain to regulator subnode
of the SCMI protocol node, so scmi_voltage_domain can then bind regulators
directly to subnodes of its node. This kind of behavior should not be in
core code, move it into scmi_voltage_domain driver code. Let the driver
descend into regulator node and bind regulators to its subnodes.

Fixes: 1f213ee4dbf2 ("firmware: scmi: voltage regulator")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 8 +-------
 drivers/power/regulator/scmi_regulator.c  | 6 ++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b032..e6e43ae936a 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -427,14 +427,8 @@ static int scmi_bind_protocols(struct udevice *dev)
 			break;
 		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id)) {
-				node = ofnode_find_subnode(node, "regulators");
-				if (!ofnode_valid(node)) {
-					dev_err(dev, "no regulators node\n");
-					return -ENXIO;
-				}
+			    scmi_protocol_is_supported(dev, protocol_id))
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
-			}
 			break;
 		default:
 			break;
diff --git a/drivers/power/regulator/scmi_regulator.c b/drivers/power/regulator/scmi_regulator.c
index 99f6506f162..2550b27246f 100644
--- a/drivers/power/regulator/scmi_regulator.c
+++ b/drivers/power/regulator/scmi_regulator.c
@@ -178,6 +178,12 @@ static int scmi_regulator_bind(struct udevice *dev)
 	ofnode node;
 	int ret;
 
+	node = ofnode_find_subnode(node, "regulators");
+	if (!ofnode_valid(node)) {
+		dev_err(dev, "no regulators node\n");
+		return -ENXIO;
+	}
+
 	drv = DM_DRIVER_GET(scmi_regulator);
 
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
-- 
2.47.2

