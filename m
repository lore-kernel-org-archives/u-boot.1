Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7663EC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 09:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 731D888470;
	Thu,  6 Jun 2024 11:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717665744;
	bh=ar2QF8MTc+S41k3/9ueKTay82HTTrcYyOGQlg9RPf14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gMf7wbPUswMba91MwkjGG/Za63cKatSEv+l9ig1ble2JN2HJGU5cDQMvTOvclqefM
	 sT+OBbp9JS5I91cITUjmG84uDKFuZNTXlRUDU6bOdaWY/th+3bUmDrqoyCXWXKdXS7
	 m1jCIkYi4Z2D3cGfTmlUHL42h7ipq8AzlKYGE1vjB4tg3JlyJenKWzKXsmm+5NEHnd
	 ZoHRjuixlQTV0y0a5rvQ6dFMe19gcEvLCtET60U5KcE9JulOrlubISQrWQFy6vVC2K
	 xqsRf4KSYCGr4cQmrWz9qXLDUkIZ0ue8AtHmi5gak5u3IZijuCAb0hLN6daxI0y3V7
	 vQdJryzzG9E4A==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 986188841F;
 Thu,  6 Jun 2024 11:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717665741;
 bh=ar2QF8MTc+S41k3/9ueKTay82HTTrcYyOGQlg9RPf14=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P7E8Gbh5hY38tK4r4pOkzYBFwftfFeys9xafz0PGwugzrcXkCs5cQ22AQAt7xsNSH
 kf7YQNQH7xnCu8zzmGcUUULSdZsKV4v2B71DhXKyo2vNRISvNv0k+RKNmvwPasTZSO
 bC/eImy1yXzDqpwdyTQFYUOnxeocnjE/vf9LocidjhiAq7oXkSURDTOLV34zvCLOcq
 H65nBET6eMzFDM8WtMFVEnLDMaHOCEaaNyPtVf2+vx8KI+jOEvoCtysGYFjjZaThYY
 VaBpJ8vsGwvkrbhIyUX9K1PPo1F9n8V3F430kfhL9gMYvFpxNMhxtT3/ippdt89XiK
 m7Kfm2uvobANg==
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
 trini@konsulko.com, xypron.glpk@gmx.de, Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v2 4/5] net: dwc_eth_qos: Implement bind() for PCI devices
Date: Thu,  6 Jun 2024 11:22:06 +0200
Message-Id: <20240606092207.87816-5-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606092207.87816-1-pro@denx.de>
References: <20240606092207.87816-1-pro@denx.de>
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
index 34e29301cc..2eeaccc800 100644
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

