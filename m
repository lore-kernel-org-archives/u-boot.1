Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E4CCDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 09:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 557648746C;
	Fri, 20 Oct 2023 11:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697792675;
	bh=Y5islzxAL95lIzBbkjhUnRYY5aF7T+yJ8rPULSWCboo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SIP8i2OLDTTE20CY/JdHWUfLSKUfWZTClKpNAI7MOn86/EuinxMTUQuxpEyp2ZA67
	 fB6qI6SrId9F2t5+QGokdG7Prx9itXIkPrtbNgeAAw5lezTNINK7bZEcnlAsQvJM+k
	 yp9mFTkGp+lEpUAVxWTNeYQ5Qa4h4iEQSRcVASnBmEOycunPunWlrbApHxYdF79NR1
	 8y9E5bLz4g2jvV/2mCTWAWcXizwXH7lqnCpVVJnZKvQUuPHLsGKNCrdt6NFq0gecPj
	 NoA5uYIVwXvbqrQdJQufBCngTHYwUQlZ9QQbchFsvV7zR43z2JtAdYXg83zUV8/9yi
	 GUV+x7c36XLTw==
Received: from localhost (lfbn-poi-1-1121-43.w83-200.abo.wanadoo.fr
 [83.200.224.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E3C888746C;
 Fri, 20 Oct 2023 11:04:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697792673;
 bh=Y5islzxAL95lIzBbkjhUnRYY5aF7T+yJ8rPULSWCboo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=v/AMR40CKEejWSKbLfMYD+nk1EmuOaWUf4+sUcdVQY7AqucfnXFYCqI1StI2rlvd1
 aOv7432vQoksI0Vx6Qgx+GoPKnrBA+QdPzFyi+wzUvyiMJJL6qWDTez3DJ8XeY46lT
 yF6rPKiii/S/svYrV3zM4LbrF5dlQu9LnrFKiPZd5p8ffuojqXwFw4sBFVCrrWd8iq
 n0PEK80HMtFqMcMNxl1qWoKZ966GPNS6ZrKjz5lugr0a/shVgys3XqhfPrlWEh5f5z
 DYA73OgYLXgQlAfYBmqIiX3M1mf6zKuTp8msdFm2fzPY+r79BbyiXm26xyYXSZc6Xf
 Fu8RICFcI8MPQ==
From: Philip Richard Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: hs@denx.de, sjg@chromium.org, trini@konsulko.com,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH v2 2/3] i2c: Implement i2c_get_chip_by_phandle()
Date: Fri, 20 Oct 2023 11:02:26 +0200
Message-ID: <20231020090227.16634-3-pro@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020090227.16634-1-pro@denx.de>
References: <20231020090227.16634-1-pro@denx.de>
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

