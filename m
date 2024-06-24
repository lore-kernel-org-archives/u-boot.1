Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E20C2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEBAC88464;
	Mon, 24 Jun 2024 10:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719218124;
	bh=ar2QF8MTc+S41k3/9ueKTay82HTTrcYyOGQlg9RPf14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HbxFCw206O0fwUjujoVMvbW7CJyweHMEN7Tv4v3pBAQyydA2ezE/HXLSZDkZ6cq/p
	 cEJK2nKT8ubw1e8mXc92X2rlwTGDXUvBP5H5w8FtGornp0rKgSGAVN6Kpm0UlpL4+0
	 z6IVfIws9y0nnlu3WGlEWX4NAsyD6IKYJ3+CAjCL+R/gxIDmK69ULT9iu2PMua2oJE
	 KDShPU4rnaXJDv++bIpS9Br6bMaswtVVVVu7goLnlSBICklX65yThGGEA9wOBlkIf3
	 Ydo/F3LejI9/nkAThcjxS8CcVE708UshQdRC+u0Ecrubx1QaP0gjC2GmGvxHpuy3K1
	 pBQrSXtd2TutQ==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DE640883B1;
 Mon, 24 Jun 2024 10:35:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719218122;
 bh=ar2QF8MTc+S41k3/9ueKTay82HTTrcYyOGQlg9RPf14=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hLv10VF1JNIr1AaG7wHydkx4v9qEVpvyO+4EjRIS9awJJrtO9ghTb0LFUhRLF8azB
 KDK6RU+MKu2jfHxdGm6s2gX4g3/cQgtGn2F6XWwHo9Sw94wDNbqDosGvZWvtuSg3S9
 6r6x38fPxYMYn5eQ4Q8rq5yLRcubEL8Gi8KfHb3tbrq0SVmP95RAqxfjK1m4+9zrO8
 Bjhh9Ho+NrqRqEnC5TV0w+Qe1Q/Ec8h182KKjzwM1Pea3zvnkvEWEVpEIJcD815iaf
 aHTgp95NrJbjbkTdHF1QVh+Bms9f8yzNbRwABU8SVdA0MbcVEpq40Y24ISilnyZySs
 R9cEz6QclOqjw==
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
Subject: [RESEND PATCH v2 4/5] net: dwc_eth_qos: Implement bind() for PCI
 devices
Date: Mon, 24 Jun 2024 10:34:49 +0200
Message-Id: <20240624083450.90297-5-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624083450.90297-1-pro@denx.de>
References: <20240624083450.90297-1-pro@denx.de>
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

