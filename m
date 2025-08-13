Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0FBCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 13:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84C4835CB;
	Wed, 13 Aug 2025 15:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JUng9uDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A57E8338D; Wed, 13 Aug 2025 12:30:03 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E621F831D3
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DATr0T1679974;
 Wed, 13 Aug 2025 05:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755080993;
 bh=5mZAB3pOTz1XILuvbH8EJC3fKsoLqOfaU84HENGmZd0=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=JUng9uDaedGKcLI1+XP+R+eSAG+R9UwfY4k+Dk9Ufvg+4DuO0TOfGZ7o5e1Ldxh0j
 qe0G+XW7oCIYq0z1yH85UOHb5WIZmhjBjMuN+B9vzKSs5RTGS2MnuByVjUKftG/wYA
 nWtggObl872FFYqETNfw1YT4ko91OghMzWr5fPf8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DATroc4185807
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 13 Aug 2025 05:29:53 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 05:29:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 05:29:52 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DATpfR2165849;
 Wed, 13 Aug 2025 05:29:52 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Wed, 13 Aug 2025 15:59:36 +0530
Subject: [PATCH 2/2] clk: scmi: add compatibility for clock version 3.0 and
 onwards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250813-b4-scmi-v1-v1-2-bef20fc32d4b@ti.com>
References: <20250813-b4-scmi-v1-v1-0-bef20fc32d4b@ti.com>
In-Reply-To: <20250813-b4-scmi-v1-v1-0-bef20fc32d4b@ti.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
CC: <u-boot@lists.denx.de>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755080987; l=3008;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=0lf6SHyRTCTIdHintJDbItCC3Y+mKcEtdwO0X2FTNZE=;
 b=S9l9g+5Xt+mQDmdZI5aR0WYEPGK2yjQfOtVnY0rPAEF/MY1ITOiiB0IqU8CCa/VJNHy5Q6jHT
 qsqxoAZtP2WCLhZ8iL6eyeNu3Q/St8japPUmZhU2zaL36NEUNppcYmk
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 13 Aug 2025 15:10:42 +0200
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

Clock version 3.0 specified in ARM SCMI Platform design document
v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET.

The SCMI server with clock version 3.0 rejects the message if
they don't have this field.

Add support so that both SCMI server with clock version 2.0 and 3.0
can be handled.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 drivers/clk/clk_scmi.c   | 49 ++++++++++++++++++++++++++++++++++++++-----------
 include/scmi_protocols.h |  6 ++++++
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 83ea7bb4286..b547f2494c6 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -135,17 +135,44 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 		.clock_id = clk_get_id(clk),
 		.attributes = enable,
 	};
-	struct scmi_clk_state_out out;
-	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
-					  SCMI_CLOCK_CONFIG_SET,
-					  in, out);
+
+	struct scmi_clock_priv *priv = dev_get_priv(clk->dev);
+
 	int ret;
 
-	ret = devm_scmi_process_msg(clk->dev, &msg);
-	if (ret)
-		return ret;
+	if (priv->version >= CLOCK_PROTOCOL_VERSION_3_0) {
+		struct scmi_clk_state_in_v2 in = {
+			.clock_id = clk->id,
+			.attributes = enable,
+		};
+		struct scmi_clk_state_out out;
+		struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+						  SCMI_CLOCK_CONFIG_SET,
+						  in, out);
 
-	return scmi_to_linux_errno(out.status);
+		ret = devm_scmi_process_msg(clk->dev, &msg);
+		if (ret)
+			return ret;
+
+		return scmi_to_linux_errno(out.status);
+	} else {
+		struct scmi_clk_state_in_v2 in = {
+			.clock_id = clk->id,
+			.attributes = enable,
+		};
+		struct scmi_clk_state_out out;
+		struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+						  SCMI_CLOCK_CONFIG_SET,
+						  in, out);
+
+		ret = devm_scmi_process_msg(clk->dev, &msg);
+		if (ret)
+			return ret;
+
+		return scmi_to_linux_errno(out.status);
+	}
+
+	return 0;
 }
 
 static int scmi_clk_enable(struct clk *clk)
@@ -275,12 +302,12 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	if (!CONFIG_IS_ENABLED(CLK_CCF))
-		return 0;
-
 	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
 					    &priv->version);
 
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return 0;
+
 	/* register CCF children: CLK UCLASS, no probed again */
 	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
 		return 0;
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 762a1032c37..a4d1a4c80c8 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -807,6 +807,12 @@ struct scmi_clk_state_in {
 	u32 attributes;
 };
 
+struct scmi_clk_state_in_v2 {
+	u32 clock_id;
+	u32 attributes;
+	u32 extended_config_val;
+};
+
 /**
  * struct scmi_clk_state_out - Response payload for CLOCK_CONFIG_SET command
  * @status:	SCMI command status

-- 
2.34.1

