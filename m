Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76C4C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 08:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC18C88C2A;
	Fri,  3 May 2024 10:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714726231;
	bh=P/HIOGhQQal+hi4C6BK+atFxmknNFmFGPdI4ouQzGPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jVmYprFCV6vOqZBAvUh2wxkkLoe3sgoOVoH1Gd8dEseBOKjS6ZK1EKh5thFJEox5X
	 W/D0266oCOxhTRDtTgmPNV8iUIo4WGFcTuJGL6601xOm8wFM6j2+tU/gMVSOWUHXGS
	 +S0Yd5erYNliyWbQvchkhu8Z53kcwusJrIZl6+4bIisdE/jv86Pr9c/F5NzeeWjPeY
	 J72g1FdMxUvYPqkh6OEk4OAcxZTrVaF7lX+nlUCziRLlZtCRZlRiGVFW4PC2IXVovm
	 aR8vxJEbpivRKGGzoruHRgETXKH95PI++oMDtx+XU1Yv7D8RgCQhh65ReEiFuIECoJ
	 aJ6CKWPc5GSlQ==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7157087FCC;
 Fri,  3 May 2024 10:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714726231;
 bh=P/HIOGhQQal+hi4C6BK+atFxmknNFmFGPdI4ouQzGPs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XugeLIzPT7OhYRB7jvTMPZzcw3BQDWfaOA6SVHBPkcZ7SluxhMq2xmWTLT95gO3Cj
 BywiucrlX7V3H62y3N0yHZPMvpcdldIg17dXdhAnBhg2PbEKEP9n9gtWv8xE38+8U4
 5kyM9l6cn2pipqcpUwa5q1yvq9PQCRsDIWV7U1OemWuIegjsgnNb8S9xfbp/PiB4ph
 60zX+s4pgHGwPeFOLdZ2wB6d8Ar+AOmY4994EBsXbOZdzdyhtYQwXnfgNn6g5NDSCe
 gu3pat+JmrNbgoz5baQe6k0vyMYJZfoYtTFlYQDjgVPqEWZP8UZE0xkJ5J4XTPEO4y
 LGkhvbgEsX0kQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com, sebastian.reichel@collabora.com,
 sebastien.szymanski@armadeus.com, sjg@chromium.org, sumit.garg@linaro.org,
 trini@konsulko.com, xypron.glpk@gmx.de, yanhong.wang@starfivetech.com,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH 4/5] net: dwc_eth_qos: Implement bind() for PCI devices
Date: Fri,  3 May 2024 10:49:49 +0200
Message-Id: <20240503084950.70680-5-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503084950.70680-1-pro@denx.de>
References: <20240503084950.70680-1-pro@denx.de>
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

PCI devices do not necessarily use a device tree. Implement a bind()
function to assign unique device names in that case.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 drivers/net/dwc_eth_qos.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 36412d1c83..fdd64f074a 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1376,6 +1376,21 @@ static int eqos_remove_resources_tegra186(struct udevice *dev)
 	return 0;
 }
 
+static int eqos_bind(struct udevice *dev)
+{
+	static int dev_num;
+	const size_t name_sz = 16;
+	char name[name_sz];
+
+	/* Device name defaults to DT node name. */
+	if (ofnode_valid(dev_ofnode(dev)))
+		return 0;
+
+	/* Assign unique names in case there is no DT node. */
+	snprintf(name, name_sz, "eth_eqos#%d", dev_num++);
+	return device_set_name(dev, name);
+}
+
 /*
  * Get driver data based on the device tree. Boards not using a device tree can
  * overwrite this function.
@@ -1597,6 +1612,7 @@ U_BOOT_DRIVER(eth_eqos) = {
 	.name = "eth_eqos",
 	.id = UCLASS_ETH,
 	.of_match = of_match_ptr(eqos_ids),
+	.bind	= eqos_bind,
 	.probe = eqos_probe,
 	.remove = eqos_remove,
 	.ops = &eqos_ops,
-- 
2.39.2

