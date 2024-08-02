Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E02BC3DA49
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 09:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0FB988BBC;
	Fri,  2 Aug 2024 11:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722590758;
	bh=OzN+S6jGYsZq9ye7fST1STcw/DIXZYk1h1HJ2DqxT7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sWQT39OWEeb+0v7SCEsrfAvGSwuZMedqNYlWDz9rdZkJyxtn74wFjxez2rxhrmorH
	 fUfu+q3XqDOZySGfK/DOKnjRm3WmAAmtsK83EwHo7KV1uiXrfXIQjbJJKc4biQ/xU8
	 bBEzObVIlW8qcjxcMhQ6H9Wr9uyE6q/0R7C/wSz2v8UlOKm7Fg+OIUXIWSC5d+3YKu
	 DJb1erQaO6X9s21q9hY2qsQSplvLy+95399cZ5ftcWyqLQqjCHRXjmnA4/4xyz36w6
	 kp7oqp+z994dw6J+BbF6ddrXYyw//0S/fn7poDczA/K6r4xZcLskm8NwdaoK69m4ak
	 9jMSBp6JXX9rg==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:7f4c:42be:fdf8:3b8a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E17E288BBB;
 Fri,  2 Aug 2024 11:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722590758;
 bh=OzN+S6jGYsZq9ye7fST1STcw/DIXZYk1h1HJ2DqxT7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xA5oJPaH+cMIOpSoDuUOkqG2SgM3aJjYUawY8eL0/lY0C9FRNWh8gSDACSDN7Vt6q
 I3hunk5RcmtB0fMwAcfT2rJt8GApMqAZntETP6NCSHd98Ui+KbntgdgBHqWfnXVBlz
 KawM3lVBjBLBSqhuVMooz8tUJHG6XrXiIQWFj7QhgeVMI+zxK0wibSKeRvVBYuOlGD
 rMKLLSj+zwt6gf0rHQM8eymhaVu8HqtR+mC5v3wTekOSvj2yoUwXSfbVt8dYNhhe0r
 OJO3qG3C6xNppHmFBmPLc6fDQtimDbsbW2x9QuQzb72VtUDfhE0PpGJtl3vHidtyr9
 bWBAv335JnrWw==
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
 trini@konsulko.com, xypron.glpk@gmx.de, marex@denx.de,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v4 4/5] net: dwc_eth_qos: Implement bind() for PCI devices
Date: Fri,  2 Aug 2024 11:25:38 +0200
Message-Id: <20240802092539.162892-5-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802092539.162892-1-pro@denx.de>
References: <20240802092539.162892-1-pro@denx.de>
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

Notes:
    Changes in V4: None
    Changes in V3: None

 drivers/net/dwc_eth_qos.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 203c86c6cf..f6cec32021 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1383,6 +1383,21 @@ static int eqos_remove_resources_tegra186(struct udevice *dev)
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
@@ -1613,6 +1628,7 @@ U_BOOT_DRIVER(eth_eqos) = {
 	.name = "eth_eqos",
 	.id = UCLASS_ETH,
 	.of_match = of_match_ptr(eqos_ids),
+	.bind	= eqos_bind,
 	.probe = eqos_probe,
 	.remove = eqos_remove,
 	.ops = &eqos_ops,
-- 
2.39.2

