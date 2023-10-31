Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77B3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625EC87C66;
	Tue, 31 Oct 2023 08:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698738083;
	bh=aMZJhUXVGXnRgek9MX/fSpNLDfeju/VEHlpNYTqH/9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jaai/eARKU9EiEkOrcjFiZs5pjz90S/8uxvTCSVnv8w57cBTVMn1nH4tLYD2pUoFx
	 Dn75mQpT5viHyUo/PQmphnES+UWH7b9BHhJV3yAUcNlIOvOeSZtplP39iFtm/nz+E/
	 OxGq7HGVc91VO2qOe1QF7ozt5grfwMIPerSoL/z8A+w5MJFVs4tfQnZ0DFlk8cFHUJ
	 dNrXy2y2yjpT74Urb50F7+yCF6i+a2WEn9thvYfXNLytrhfG9ISddkWTHQFIW68W17
	 Bt+pEWZtsUHCP+OteCKywe3r/kP1sk6qFbkghtSkXWoqZzSLRNyks2oPIlxnrq0rWe
	 Q1jki96aOOEIw==
Received: from localhost (unknown
 [IPv6:2a01:cb18:989:a700:4b67:3ae7:15fa:40a0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 426CE87C6E;
 Tue, 31 Oct 2023 08:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698738082;
 bh=aMZJhUXVGXnRgek9MX/fSpNLDfeju/VEHlpNYTqH/9I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kdFfC3g7SjHUHOQAbyIDuAfJCGl1he57q4xiZ4/tK9au8fBbOEdejsmUK6OMFUTVW
 y6ookJTsAEff4fRPhw+VRiL6uOwdbdNIs16CdHkdYQy8J2AcIXn+nizcdjaKOBmbdM
 x1JHj8s9c8Rzmm3IRQcZZGDNSkxZgyTQh36eU3cfJoFk2jk9IFffqnUfzDTJuCm0dH
 1AN7muJO0svA+Syk+vNlM9t0imULfiDwAhXGk+u06rDGLJLOhXwWPt6a9zV9v/yxgm
 0yE7Xv+x0KhguDf032Y9sSoVMbYb5z3cjmCl+nYGrqEsviibZjyKxmD4U4koWZvpW4
 EQd4oTZwE1tFw==
From: Philip Richard Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: hs@denx.de, sjg@chromium.org, trini@konsulko.com,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH v3 2/3] i2c: Implement i2c_get_chip_by_phandle()
Date: Tue, 31 Oct 2023 08:38:46 +0100
Message-ID: <20231031073844.15683-6-pro@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031073844.15683-2-pro@denx.de>
References: <20231031073844.15683-2-pro@denx.de>
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

This new function enhances the i2c_get_chip*() toolbox by implementing a
variant that does not require a chip_addr. Instead, the desired device
is pointed to by a phandle.

Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v3: none
    Changes in v2: new

 drivers/i2c/i2c-uclass.c | 75 ++++++++++++++++++++++++++++++++++++++++
 include/i2c.h            | 12 +++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
index 8867a560bd..5405067861 100644
--- a/drivers/i2c/i2c-uclass.c
+++ b/drivers/i2c/i2c-uclass.c
@@ -388,6 +388,81 @@ int i2c_get_chip_for_busnum(int busnum, int chip_addr, uint offset_len,
 	return 0;
 }
 
+/* Find and probe I2C bus based on a chip attached to it */
+static int i2c_get_parent_bus(ofnode chip, struct udevice **devp)
+{
+	ofnode node;
+	struct udevice *dev;
+	int ret;
+
+	node = ofnode_get_parent(chip);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C, node, &dev);
+	if (ret) {
+		*devp = NULL;
+		return ret;
+	}
+
+	*devp = dev;
+	return 0;
+}
+
+int i2c_get_chip_by_phandle(const struct udevice *parent, const char *prop_name,
+			    struct udevice **devp)
+{
+	ofnode node;
+	uint phandle;
+	struct udevice *bus, *chip;
+	char *dev_name;
+	int ret;
+
+	debug("%s: Searching I2C chip for phandle \"%s\"\n",
+	      __func__, prop_name);
+
+	dev_name = strdup(prop_name);
+	if (!dev_name) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	ret = dev_read_u32(parent, "i2cbcdev", &phandle);
+	if (ret)
+		goto err_exit;
+
+	node = ofnode_get_by_phandle(phandle);
+	if (!ofnode_valid(node)) {
+		ret = -ENODEV;
+		goto err_exit;
+	}
+
+	ret = i2c_get_parent_bus(node, &bus);
+	if (ret)
+		goto err_exit;
+
+	ret = device_bind_driver_to_node(bus, "i2c_generic_chip_drv",
+					 dev_name, node, &chip);
+	if (ret)
+		goto err_exit;
+
+	ret = device_probe(chip);
+	if (ret) {
+		device_unbind(chip);
+		goto err_exit;
+	}
+
+	debug("%s succeeded\n", __func__);
+	*devp = chip;
+	return 0;
+
+err_exit:
+	free(dev_name);
+	debug("%s failed, ret = %d\n", __func__, ret);
+	*devp = NULL;
+	return ret;
+}
+
 int dm_i2c_probe(struct udevice *bus, uint chip_addr, uint chip_flags,
 		 struct udevice **devp)
 {
diff --git a/include/i2c.h b/include/i2c.h
index ef3820eaba..4e59009cd9 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -537,6 +537,18 @@ int i2c_get_chip(struct udevice *bus, uint chip_addr, uint offset_len,
 int i2c_get_chip_for_busnum(int busnum, int chip_addr, uint offset_len,
 			    struct udevice **devp);
 
+/**
+ * i2c_get_chip_by_phandle() - get a device to use to access a chip
+ *			       based on a phandle property pointing to it
+ *
+ * @parent: Parent device containing the phandle pointer
+ * @name:   Name of phandle property in the parent device node
+ * @devp:   Returns pointer to new device or NULL if not found
+ * Return:  0 on success, -ve on failure
+ */
+int i2c_get_chip_by_phandle(const struct udevice *parent, const char *prop_name,
+			    struct udevice **devp);
+
 /**
  * i2c_chip_of_to_plat() - Decode standard I2C platform data
  *
-- 
2.42.0

